Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUAOCGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266355AbUAOCGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:06:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:6561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266348AbUAOCGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:06:13 -0500
Date: Wed, 14 Jan 2004 18:06:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, hgdeoro@yahoo.com, mingo@redhat.com
Subject: Re: [2.6.1-mm2] Badness in futex_wait at kernel/futex.c:509
Message-Id: <20040114180638.66b89cec.akpm@osdl.org>
In-Reply-To: <20040115013723.33EF22C21C@lists.samba.org>
References: <20040113223612.4fe709d9.akpm@osdl.org>
	<20040115013723.33EF22C21C@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> In message <20040113223612.4fe709d9.akpm@osdl.org> you write:
> > Horacio de Oro <hgdeoro@yahoo.com> wrote:
> > >
> > > Hi!
> > > 
> > > This happen every time I switch from X to console:
> > > 
> > > Badness in futex_wait at kernel/futex.c:509
> > > Call Trace:
> > >  [futex_wait+434/448] futex_wait+0x1b2/0x1c0
> > >  [default_wake_function+0/32] default_wake_function+0x0/0x20
> > >  [default_wake_function+0/32] default_wake_function+0x0/0x20
> > >  [do_futex+112/128] do_futex+0x70/0x80
> > >  [sys_futex+292/320] sys_futex+0x124/0x140
> > >  [syscall_call+7/11] syscall_call+0x7/0xb
> > > 
> > 
> > 	/* A spurious wakeup should never happen. */
> > 	WARN_ON(!signal_pending(current));
> > 
> > (looks at Rusty)
> 
> You were the one who said spurious wakeups shouldn't happen 8)
> 
> This implies that the console code decided to do wake_up_process() on
> us.  We returned -EINTR to userspace, but there was no signal, which
> is odd.

Well this would seem to imply that this task woke up and ran while it was
still parked on q.waiters, yes?

> Anyone have any ideas *why*?

Nope.  This patch should identify the source of the wakeup.  Horacio, could
you please add it, see if you get a nice trace?  The patch is a bit racy
wrt task exit, but it should hold up for long enough to get a trace.

 include/linux/sched.h |    1 +
 kernel/futex.c        |    5 ++++-
 kernel/sched.c        |    3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff -puN kernel/futex.c~futex-wakeup-debug kernel/futex.c
--- 25/kernel/futex.c~futex-wakeup-debug	2004-01-14 18:01:10.000000000 -0800
+++ 25-akpm/kernel/futex.c	2004-01-14 18:01:10.000000000 -0800
@@ -491,8 +491,11 @@ static int futex_wait(unsigned long uadd
 	 * !list_empty() is safe here without any lock.
 	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
 	 */
-	if (likely(!list_empty(&q.list)))
+	if (likely(!list_empty(&q.list))) {
+		current->flags |= PF_FUTEX_DEBUG;
 		time = schedule_timeout(time);
+		current->flags &= ~PF_FUTEX_DEBUG;
+	}
 	__set_current_state(TASK_RUNNING);
 
 	/*
diff -puN include/linux/sched.h~futex-wakeup-debug include/linux/sched.h
--- 25/include/linux/sched.h~futex-wakeup-debug	2004-01-14 18:01:10.000000000 -0800
+++ 25-akpm/include/linux/sched.h	2004-01-14 18:01:10.000000000 -0800
@@ -500,6 +500,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_FUTEX_DEBUG	0x00400000
 
 #ifdef CONFIG_SMP
 #define SD_FLAG_NEWIDLE		1	/* Balance when about to become idle */
diff -puN kernel/sched.c~futex-wakeup-debug kernel/sched.c
--- 25/kernel/sched.c~futex-wakeup-debug	2004-01-14 18:01:10.000000000 -0800
+++ 25-akpm/kernel/sched.c	2004-01-14 18:01:10.000000000 -0800
@@ -770,6 +770,9 @@ static int try_to_wake_up(task_t * p, un
 	}
 	goto out_activate;
 
+	if (p->flags & PF_FUTEX_DEBUG)
+		WARN_ON(!signal_pending(p));
+
 repeat_lock_task:
 	task_rq_unlock(rq, &flags);
 	rq = task_rq_lock(p, &flags);

_


