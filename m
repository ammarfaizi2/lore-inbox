Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129852AbRBSMf4>; Mon, 19 Feb 2001 07:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRBSMfq>; Mon, 19 Feb 2001 07:35:46 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:52647 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129852AbRBSMfd>; Mon, 19 Feb 2001 07:35:33 -0500
Message-ID: <3A911510.2F89D093@uow.edu.au>
Date: Mon, 19 Feb 2001 23:44:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Philipp Rumpf <prumpf@mandrakesoft.com>, Kenn Humborg <kenn@linux.ie>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread() & thread starting
In-Reply-To: <Pine.LNX.3.96.1010219040821.16489E-100000@mandrakesoft.mandrakesoft.com>,
		<Pine.LNX.3.96.1010219040821.16489E-100000@mandrakesoft.mandrakesoft.com> <25350.982578755@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> prumpf@mandrakesoft.com said:
> >  Why bother ?  It looks like a leftover debugging message which
> > doesn't make a lot of sense once the code is stable (what might make
> > sense is checking keventd is still around, but that's not what the
> > code is doing).

keventd *must* still be around.

And the code obviously isn't completely stable, and this debug
message has found something rather unpleasant.

I don't think we should run the init tasks when keventd may, or
may not be running.  Sure, the current code does, by happenstance,
all work correctly when keventd hasn't yet started running, and
when it's starting up.  But it's safer, saner and surer just
to crank the damn thing up before proceeding.

> > Proposed patch:
> 
> >  dwmw2 ?
> 
> Don't look at me. I didn't like the current_is_keventd stuff very much
> in the first place. akpm?

Heh. Tell that to wakeup_bdflush().

The all-singing fully-async + fully-sync + async with callback
patch was dropped, and until we can demonstrate that it
fixes a bug, it can stay dropped.  I think it _will_ fix
a bug, but the development of userspace hotplug infrastructure
hasn't reached the stage where the need for a kernel fix
has been proven.

I believe the right thing to do here is the RMK approach.

Here's a faintly tested patch.

--- linux-2.4.2-pre4/kernel/context.c	Sat Jan 13 04:52:41 2001
+++ lk/kernel/context.c	Mon Feb 19 23:33:38 2001
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/unistd.h>
 #include <linux/signal.h>
+#include <asm/semaphore.h>
 
 static DECLARE_TASK_QUEUE(tq_context);
 static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
@@ -26,19 +27,9 @@
 static int keventd_running;
 static struct task_struct *keventd_task;
 
-static int need_keventd(const char *who)
-{
-	if (keventd_running == 0)
-		printk(KERN_ERR "%s(): keventd has not started\n", who);
-	return keventd_running;
-}
-	
 int current_is_keventd(void)
 {
-	int ret = 0;
-	if (need_keventd(__FUNCTION__))
-		ret = (current == keventd_task);
-	return ret;
+	return (current == keventd_task);
 }
 
 /**
@@ -57,13 +48,12 @@
 int schedule_task(struct tq_struct *task)
 {
 	int ret;
-	need_keventd(__FUNCTION__);
 	ret = queue_task(task, &tq_context);
 	wake_up(&context_task_wq);
 	return ret;
 }
 
-static int context_thread(void *dummy)
+static int context_thread(void *sem)
 {
 	struct task_struct *curtask = current;
 	DECLARE_WAITQUEUE(wait, curtask);
@@ -85,6 +75,7 @@
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
+	up((struct semaphore *)sem);
 	/*
 	 * If one of the functions on a task queue re-adds itself
 	 * to the task queue we call schedule() in state TASK_RUNNING
@@ -146,9 +137,11 @@
 	remove_wait_queue(&context_task_done, &wait);
 }
 	
-int start_context_thread(void)
+int __init start_context_thread(void)
 {
-	kernel_thread(context_thread, NULL, CLONE_FS | CLONE_FILES);
+	DECLARE_MUTEX_LOCKED(sem);
+	kernel_thread(context_thread, &sem, CLONE_FS | CLONE_FILES);
+	down(&sem);
 	return 0;
 }
 
-
