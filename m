Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269405AbUJSKhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269405AbUJSKhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269406AbUJSKgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:36:53 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63393
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269405AbUJSKUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 06:20:25 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019093414.GA18086@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <1098173546.12223.737.camel@thomas>
	 <20041019090428.GA17204@elte.hu> <1098176615.12223.753.camel@thomas>
	 <20041019093414.GA18086@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098180746.12223.811.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 12:12:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 11:34, Ingo Molnar wrote:
> > Hmm, the sleep_on() variants are used quite a lot over the kernel.
> > Whats wrong with them and to what should they be converted ?
> 
> they are racy on SMP. It does:
> The proper interface is wait_event() (and variants).

Sorry for beeing stupid. I remebered the wait_event stuff immidiately
after hitting send (:

> your patch probably only works due to timing - the wakeup always happens
> after sleep_on() has been called.
> 
> this particular NFS case is probably only correct due to userspace
> behavior. The code is apparently relying on the wake_up() never
> happening _before_ we do the sleep_on().

Correct fix appended. I think it's more sane than the locked mutex, as
we actually come back if lockd is not started for any reason.

> so, could you try the init_MUTEX_LOCKED() fix plus the patch below -
> does that turn off the deadlock assert? (Plus also uncomment the
> RWSEM_BUG() around line 130.)

Yep, that fixes the problem

tglx

--- 2.6.9-rc4-mm1-RT-U5/fs/lockd/svc.c.orig 2004-10-19
10:02:17.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U5/fs/lockd/svc.c     2004-10-19 11:34:12.000000000
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
@@ -258,8 +259,15 @@
                        "lockd_up: create thread failed, error=%d\n",
error);
                goto destroy_and_out;
        }
-       down(&lockd_start);
-
+       /*
+        * Wait for the lockd process to start, but since we're holding
+        * the lockd semaphore, we can't wait around forever ...
+        */
+       if (wait_event_interruptible_timeout(lockd_start,
+                                            nlmsvc_pid != 0, HZ)) {
+               printk(KERN_WARNING
+                       "lockd_down: lockd failed to start\n");
+       }
        /*
         * Note: svc_serv structures have an initial use count of 1,
         * so we exit through here on both success and failure.
@@ -298,16 +306,12 @@
         * Wait for the lockd process to exit, but since we're holding
         * the lockd semaphore, we can't wait around forever ...
         */
-       clear_thread_flag(TIF_SIGPENDING);
-       interruptible_sleep_on_timeout(&lockd_exit, HZ);
-       if (nlmsvc_pid) {
+       if (wait_event_interruptible_timeout(lockd_exit,
+                                            nlmsvc_pid == 0, HZ)) {
                printk(KERN_WARNING
                        "lockd_down: lockd failed to exit, clearing
pid\n");
                nlmsvc_pid = 0;
        }
-       spin_lock_irq(&current->sighand->siglock);
-       recalc_sigpending();
-       spin_unlock_irq(&current->sighand->siglock);
 out:
        up(&nlmsvc_sema);
 }
@@ -423,7 +427,6 @@

 static int __init init_nlm(void)
 {
-       init_MUTEX_LOCKED(&lockd_start);
        nlm_sysctl_table = register_sysctl_table(nlm_sysctl_root, 0);
        return nlm_sysctl_table ? 0 : -ENOMEM;
 }



