Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWJPDE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWJPDE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 23:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWJPDE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 23:04:29 -0400
Received: from sigtuna.hangingditch.net ([88.198.191.26]:13011 "EHLO
	sigtuna.hangingditch.net") by vger.kernel.org with ESMTP
	id S1751330AbWJPDE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 23:04:28 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B1B60D4-4259-4720-A5A5-9691CA59E250@garethknight.com>
Cc: torvalds@osdl.org
Content-Transfer-Encoding: 7bit
From: Gareth Knight <gk@garethknight.com>
Date: Sun, 15 Oct 2006 20:04:15 -0700
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
X-SA-Exim-Connect-IP: 64.142.80.85
X-SA-Exim-Mail-From: gk@garethknight.com
Subject: [PATCH] generic signal code (small new feature - userspace signal mask), kernel 2.6.16
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on sigtuna.hangingditch.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked in MAINTAINERS for a suitable person for the generic signal  
code, but couldn't find anyone in particular.  Please Cc me on  
comments, which are most welcome, as I am not on LKML, although I do  
peruse the archives.

Gareth.


Userspace signal mask
==================

Inspiration and rationale:

This is a proposed addition to the linux kernel to reduce the  
overhead required to mask signals.  The intended usage is an  
application with critical sections that need to be guarded against  
deadlock by preventing signals from being delivered whilst inside one  
of the critical sections.  Currently such applications may be very  
heavy users of the sigprocmask syscall, this proposal provides an  
additional signal mask stored in userspace that can be updated with a  
simple store rather than a syscall.

The userspace sigprocmask is activated via a new subcommand of the  
sigprocmask or rt_sigprocmask syscall.  The first argument is  
currently an integer indicating which operation to perform.   
Currently the operations are SIG_BLOCK, SIG_UNBLOCK and SIG_SETMASK;  
the new operation I've called SIG_SETUSERMASKADDRESS.

Usage is:

sigprocmask( SIG_SETUSERMASKADDRESS, sigset_t *address, NULL);

The *address pointer points to wherever you've decided to keep the  
userspace sigmask in your thread. Any non-zero address enables the  
use of the userspace sigprocmask and conversely, setting the address  
to zero disables it.  On a kernel without support, this operation can  
be expected to return -EINVAL.

Behaviour:

Each thread has its own address, but there is no restriction on  
threads in a process pointing to the same address.

By default, a process does not have a userspace sigmask.  When a new  
thread is created or a process is forked, the new thread inherits any  
userspace sigmask address from its parent.

At any time the userspace sigmask is enabled, the effective sigmask  
is the union of the userspace sigmask and the traditional sigmask in  
the kernel for that thread.  The traditional kernel sigmask is set  
and controlled by the SIG_BLOCK etc operations as it was before.

As soon as the relevant bit is set in the userspace sigmask, that  
signal is blocked in the same way it would be as if you'd blocked it  
via a traditional sigprocmask call.  If a signal is both blocked and  
also pending for delivery, clearing the bit in the userspace sigmask  
does not guarantee immediate delivery as a SIG_UNBLOCK call would -  
instead delivery typically occurs at the next pre-emption point (any  
syscall for example).

If a bad address is passed to the kernel for the location of the  
userspace mask, it is discarded.

Patch:

This patch is against a vanilla 2.6.16 kernel from kernel.org.  The  
modifications are entirely architecture independent.  It has been  
tested on i386, x86_64, ia64 and ppc64 kernels:

--- pristine-linux-2.6.16/include/linux/sched.h	2006-03-19  
21:53:29.000000000 -0800
+++ linux-2.6.16-userspacesigmask/include/linux/sched.h	2006-10-09  
18:09:24.000000000 -0700
@@ -807,6 +807,7 @@
	struct sighand_struct *sighand;
	sigset_t blocked, real_blocked;
+  sigset_t __user *userspace_blocked; /* If non-zero, task has opted  
to maintain an additional blocked mask in userspace */
	sigset_t saved_sigmask;		/* To be restored with TIF_RESTORE_SIGMASK */
	struct sigpending pending;
--- pristine-linux-2.6.16/kernel/fork.c	2006-03-19 21:53:29.000000000  
-0800
+++ linux-2.6.16-userspacesigmask/kernel/fork.c	2006-10-05  
22:10:13.000000000 -0700
@@ -987,6 +987,7 @@
	spin_lock_init(&p->alloc_lock);
	spin_lock_init(&p->proc_lock);
+  p->userspace_blocked = current->userspace_blocked;
	clear_tsk_thread_flag(p, TIF_SIGPENDING);
	init_sigpending(&p->pending);
--- pristine-linux-2.6.16/kernel/signal.c	2006-03-19  
21:53:29.000000000 -0800
+++ linux-2.6.16-userspacesigmask/kernel/signal.c	2006-10-14  
21:08:38.000000000 -0700
@@ -24,6 +24,7 @@
#include <linux/ptrace.h>
#include <linux/posix-timers.h>
#include <linux/signal.h>
+#include <linux/mm.h>
#include <linux/audit.h>
#include <linux/capability.h>
#include <asm/param.h>
@@ -224,7 +225,30 @@
void recalc_sigpending(void)
{
-	recalc_sigpending_tsk(current);
+  sigset_t usermask, combinedblocked;
+
+  sigemptyset(&usermask);
+
+  if (current->userspace_blocked != 0)
+  {
+    /* Task is using the optional userspace signal mask, fetch it  
from the address given to us. */
+    /* If the address is bad, we don't mind and the mask remains  
empty */
+    if (copy_from_user(&usermask, current->userspace_blocked, sizeof 
(sigset_t)))
+    {
+      /* If we have a bad address, disable the userspace mask */
+      current->userspace_blocked = 0;
+    }
+  }
+
+  sigorsets(&combinedblocked,&usermask,&current->blocked);
+
+	if (current->signal->group_stop_count > 0 ||
+	    (freezing(current)) ||
+	    PENDING(&current->pending, &combinedblocked) ||
+	    PENDING(&current->signal->shared_pending, &combinedblocked))
+		set_thread_flag(TIF_SIGPENDING);
+	else
+		clear_thread_flag(TIF_SIGPENDING);
}
/* Given the mask, find the first available signal that should be  
serviced. */
@@ -914,6 +938,7 @@
	if (sigismember(&t->blocked, sig)) {
		sigdelset(&t->blocked, sig);
	}
+
	recalc_sigpending_tsk(t);
	ret = specific_send_sig_info(sig, info, t);
	spin_unlock_irqrestore(&t->sighand->siglock, flags);
@@ -1921,7 +1946,7 @@
{
	sigset_t *mask = &current->blocked;
	int signr = 0;
-
+
relock:
	spin_lock_irq(&current->sighand->siglock);
	for (;;) {
@@ -2136,6 +2161,15 @@
	if (set) {
		error = -EFAULT;
+
+    /* SIG_SETUSERMASK just needs to record the address of the extra  
mask in userspace and return */
+    if ( how == SIG_SETUSERMASKADDRESS )
+    {
+      current->userspace_blocked = set;
+      error = 0;
+      goto out;
+		}
+
		if (copy_from_user(&new_set, set, sizeof(*set)))
			goto out;
		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
@@ -2607,6 +2641,9 @@
			break;
		case SIG_SETMASK:
			current->blocked.sig[0] = new_set;
+      break;
+    case SIG_SETUSERMASKADDRESS:
+      current->userspace_blocked = (sigset_t *) set;
			break;
		}
--- pristine-linux-2.6.16/include/asm-generic/signal.h	2006-03-19  
21:53:29.000000000 -0800
+++ linux-2.6.16-userspacesigmask/include/asm-generic/signal.h	 
2006-10-09 18:13:36.000000000 -0700
@@ -7,6 +7,9 @@
#ifndef SIG_SETMASK
#define SIG_SETMASK        2	/* for setting the signal mask */
#endif
+#ifndef SIG_SETUSERMASKADDRESS
+#define SIG_SETUSERMASKADDRESS    8	/* for setting the optional  
userspace signal mask address */
+#endif
#ifndef __ASSEMBLY__
typedef void __signalfn_t(int);

