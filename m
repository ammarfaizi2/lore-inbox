Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUJSIRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUJSIRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJSIRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:17:37 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61089
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268301AbUJSIRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:17:24 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041018145008.GA25707@elte.hu>
References: <20041011215909.GA20686@elte.hu>
	 <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
	 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu>  <20041018145008.GA25707@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098173365.12223.734.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 10:09:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:50, Ingo Molnar wrote:
> i have released the -U5 Real-Time Preemption patch:
> 

starting nfsd triggers the deadlock detection, but it's not really a
deadlock.

The first nfsd thread acquires nlmsvc_sema. The other 7 nfsd threads
wait on it. The first thread creates lockd and tries to get lockd_start,
which is initialized locked and will be released when the lockd thread
starts. The deadlock complains about a deadlock on nlmsvc_sema inside of
down(&lockd_start). ?

Converting lockd_start to a waitqueue solves the problem and is more
sane, than the locked mutex.

tglx

--- 2.6.9-rc4-mm1-RT-U5/fs/lockd/svc.c.orig     2004-10-19
10:02:17.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U5/fs/lockd/svc.c  2004-10-19 09:54:22.000000000
+0200
@@ -46,7 +46,7 @@
 int                            nlmsvc_grace_period;
 unsigned long                  nlmsvc_timeout;

-static DECLARE_MUTEX(lockd_start);
+static DECLARE_WAIT_QUEUE_HEAD(lockd_start);
 static DECLARE_WAIT_QUEUE_HEAD(lockd_exit);

 /*
@@ -109,7 +109,7 @@
         * Let our maker know we're running.
         */
        nlmsvc_pid = current->pid;
-       up(&lockd_start);
+       wake_up(&lockd_start);

        daemonize("lockd");

@@ -230,6 +230,7 @@
                printk(KERN_WARNING
                        "lockd_up: no pid, %d users??\n", nlmsvc_users);

+
        error = -ENOMEM;
        serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE);
        if (!serv) {
@@ -258,7 +259,19 @@
                        "lockd_up: create thread failed, error=%d\n",
error);
                goto destroy_and_out;
        }
-       down(&lockd_start);
+       /*
+        * Wait for the lockd process to start, but since we're holding
+        * the lockd semaphore, we can't wait around forever ...
+        */
+       clear_thread_flag(TIF_SIGPENDING);
+       interruptible_sleep_on_timeout(&lockd_start, HZ);
+       if (!nlmsvc_pid) {
+               printk(KERN_WARNING
+                       "lockd_down: lockd failed to start\n");
+       }
+       spin_lock_irq(&current->sighand->siglock);
+       recalc_sigpending();
+       spin_unlock_irq(&current->sighand->siglock);

        /*
         * Note: svc_serv structures have an initial use count of 1,
@@ -423,7 +436,6 @@

 static int __init init_nlm(void)
 {
-       init_MUTEX_LOCKED(&lockd_start);
        nlm_sysctl_table = register_sysctl_table(nlm_sysctl_root, 0);
        return nlm_sysctl_table ? 0 : -ENOMEM;
 }


Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 mountdBUG: semaphore deadlock detected!
.. task nfsd/1246 is holding c89f4560.
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
Call Trace:
 [<c0117fc7>] copy_process+0x5f7/0xc30
 [<c01c4e62>] __delay+0x12/0x20
 [<c01fe460>] serial8250_console_write+0x170/0x280
 [<c011930e>] __call_console_drivers+0x5e/0x60
 [<c011982a>] release_console_sem+0xda/0xe0
 [<c01196a7>] vprintk+0x107/0x160
 [<c01196a7>] vprintk+0x107/0x160
 [<c012a3ae>] __kernel_text_address+0x2e/0x40
 [<c0106bf5>] show_trace+0x35/0x90
 [<c0106bf5>] show_trace+0x35/0x90
 [<c0106cd0>] show_stack+0x80/0xa0
 [<c01c2976>] __rwsem_deadlock+0x136/0x180
 [<c01c28aa>] __rwsem_deadlock+0x6a/0x180
 [<c02c3c33>] __down_write+0x93/0x170
 [<c01c3033>] down_write+0x43/0x80
 [<c89e661d>] lockd_up+0x9d/0x120 [lockd]
 [<c89e62e0>] lockd+0x0/0x2a0 [lockd]
 [<c883d2e1>] nfsd+0x91/0x380 [nfsd]
 [<c0105e12>] ret_from_fork+0x6/0x14
 [<c883d250>] nfsd+0x0/0x380 [nfsd]
 [<c0103ffd>] kernel_thread_helper+0x5/0x18
...#0 task nfsd/1246 is holding c89f4560.
BUG: semaphore deadlock: nfsd/1252 is blocked on c89f4560, deadlocking
nfsd/1246
c733df60 00000046 c7adad10 c03d6060 00000000 00000000 00000000 00000000
       00000000 00000000 c7a306f0 00005b6e 39133ac7 0000001a c7adae6c
c7adad10
       c7adad10 c7584400 00000000 c02c3cad c89f4560 c6853f6c c6819f6c
c7adad10
Call Trace:
 [<c02c3cad>] __down_write+0x10d/0x170
 [<c01c3033>] down_write+0x43/0x80
 [<c89e6591>] lockd_up+0x11/0x120 [lockd]
 [<c883d250>] nfsd+0x0/0x380 [nfsd]
 [<c883d2e1>] nfsd+0x91/0x380 [nfsd]
 [<c0105e12>] ret_from_fork+0x6/0x14
 [<c883d250>] nfsd+0x0/0x380 [nfsd]
 [<c0103ffd>] kernel_thread_helper+0x5/0x18
------------[ cut here ]------------


