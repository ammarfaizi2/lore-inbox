Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUBQFVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUBQFTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:19:17 -0500
Received: from dp.samba.org ([66.70.73.150]:27084 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265995AbUBQFTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:19:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dirk Morris <dmorris@metavize.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited 
In-reply-to: Your message of "Mon, 16 Feb 2004 11:16:19 -0800."
             <40311703.8070309@metavize.com> 
Date: Tue, 17 Feb 2004 15:39:33 +1100
Message-Id: <20040217051911.6AC112C066@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <40311703.8070309@metavize.com> you write:
> Please send me the patch, and I'll give you some updated information.

Here it is: Andrew's patch updated and fixed.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Who's Spuriously Waking Futexes?
Author: Andrew Morton, Rusty Russell
Status: Tested on 2.6.3-bk1

Someone is triggering the WARN_ON() in futex.c.  We know that software
suspend could do it, in theory.  But noone else should be.

This code adds a PF_FUTEX_DEBUG flag, which is set in the futex code
when we sleep, and also when we wake up.  If a task with
PF_FUTEX_DEBUG is woken by a task without PF_FUTEX_DEBUG, we have
found our culprit.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/include/linux/sched.h .6375-linux-2.6.3-rc3-bk1.updated/include/linux/sched.h
--- .6375-linux-2.6.3-rc3-bk1/include/linux/sched.h	2004-02-15 18:17:21.000000000 +1100
+++ .6375-linux-2.6.3-rc3-bk1.updated/include/linux/sched.h	2004-02-17 12:01:47.000000000 +1100
@@ -500,6 +500,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_FUTEX_DEBUG	0x00400000
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/kernel/futex.c .6375-linux-2.6.3-rc3-bk1.updated/kernel/futex.c
--- .6375-linux-2.6.3-rc3-bk1/kernel/futex.c	2004-02-15 18:17:21.000000000 +1100
+++ .6375-linux-2.6.3-rc3-bk1.updated/kernel/futex.c	2004-02-17 12:01:47.000000000 +1100
@@ -269,7 +269,11 @@ static void wake_futex(struct futex_q *q
 	 * The lock in wake_up_all() is a crucial memory barrier after the
 	 * list_del_init() and also before assigning to q->lock_ptr.
 	 */
+	
+	current->flags |= PF_FUTEX_DEBUG;
 	wake_up_all(&q->waiters);
+	current->flags &= ~PF_FUTEX_DEBUG;
+
 	/*
 	 * The waiting task can free the futex_q as soon as this is written,
 	 * without taking any locks.  This must come last.
@@ -490,8 +494,11 @@ static int futex_wait(unsigned long uadd
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/kernel/sched.c .6375-linux-2.6.3-rc3-bk1.updated/kernel/sched.c
--- .6375-linux-2.6.3-rc3-bk1/kernel/sched.c	2004-02-15 18:17:22.000000000 +1100
+++ .6375-linux-2.6.3-rc3-bk1.updated/kernel/sched.c	2004-02-17 12:02:24.000000000 +1100
@@ -658,6 +658,14 @@ static int try_to_wake_up(task_t * p, un
 	long old_state;
 	runqueue_t *rq;
 
+	if ((p->flags & PF_FUTEX_DEBUG)
+	    && !(current->flags & PF_FUTEX_DEBUG)) {
+		printk("%s %i waking %s: %i %i\n",
+		       current->comm, (int)in_interrupt(),
+		       p->comm, p->tgid, p->pid);
+		WARN_ON(1);
+	}
+
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
