Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUBRERR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUBRERN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:17:13 -0500
Received: from dp.samba.org ([66.70.73.150]:10157 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263310AbUBREPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:15:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: dmorris@metavize.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited 
In-reply-to: Your message of "Mon, 16 Feb 2004 21:27:58 -0800."
             <20040216212758.437af444.akpm@osdl.org> 
Date: Wed, 18 Feb 2004 15:14:23 +1100
Message-Id: <20040218041527.E802A2C4C5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040216212758.437af444.akpm@osdl.org> you write:
> If the schedule_timeout() expires then this wakeup will occur from within
> the timer interrupt - current could point at any old thing.  We will get
> bogus warnings.

Yes.  How about this:

Name: Who's Spuriously Waking Futexes?
Author: Andrew Morton, Rusty Russell
Status: Experimental

Someone is triggering the WARN_ON() in futex.c.  We know that software
suspend could do it, in theory.  But noone else should be.

This code adds a PF_FUTEX_DEBUG flag, which is set in the futex code
when we sleep, and also when we wake up.  If a task with
PF_FUTEX_DEBUG is woken by a task without PF_FUTEX_DEBUG, we have
found our culprit.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31103-linux-2.6.3-rc4/include/linux/sched.h .31103-linux-2.6.3-rc4.updated/include/linux/sched.h
--- .31103-linux-2.6.3-rc4/include/linux/sched.h	2004-02-17 17:54:03.000000000 +1100
+++ .31103-linux-2.6.3-rc4.updated/include/linux/sched.h	2004-02-18 14:55:05.000000000 +1100
@@ -500,6 +500,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_FUTEX_DEBUG	0x00400000
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31103-linux-2.6.3-rc4/kernel/futex.c .31103-linux-2.6.3-rc4.updated/kernel/futex.c
--- .31103-linux-2.6.3-rc4/kernel/futex.c	2004-02-17 17:54:04.000000000 +1100
+++ .31103-linux-2.6.3-rc4.updated/kernel/futex.c	2004-02-18 15:09:15.000000000 +1100
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
@@ -505,7 +512,11 @@ static int futex_wait(unsigned long uadd
 	if (time == 0)
 		return -ETIMEDOUT;
 	/* A spurious wakeup should never happen. */
-	WARN_ON(!signal_pending(current));
+	if (!signal_pending(current)) {
+		printk("futex_wait woken: %lu %i %lu\n",
+		       uaddr, val, time);
+		WARN_ON(1);
+	}
 	return -EINTR;
 
  out_unqueue:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31103-linux-2.6.3-rc4/kernel/sched.c .31103-linux-2.6.3-rc4.updated/kernel/sched.c
--- .31103-linux-2.6.3-rc4/kernel/sched.c	2004-02-17 17:54:04.000000000 +1100
+++ .31103-linux-2.6.3-rc4.updated/kernel/sched.c	2004-02-18 14:55:05.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31103-linux-2.6.3-rc4/kernel/timer.c .31103-linux-2.6.3-rc4.updated/kernel/timer.c
--- .31103-linux-2.6.3-rc4/kernel/timer.c	2004-02-04 15:39:15.000000000 +1100
+++ .31103-linux-2.6.3-rc4.updated/kernel/timer.c	2004-02-18 14:55:05.000000000 +1100
@@ -971,6 +971,13 @@ static void process_timeout(unsigned lon
 	wake_up_process((task_t *)__data);
 }
 
+static void futex_timeout(unsigned long __data)
+{
+	current->flags |= PF_FUTEX_DEBUG;
+	wake_up_process((task_t *)__data);
+	current->flags &= ~PF_FUTEX_DEBUG;
+}
+
 /**
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
@@ -1037,7 +1044,10 @@ signed long schedule_timeout(signed long
 	init_timer(&timer);
 	timer.expires = expire;
 	timer.data = (unsigned long) current;
-	timer.function = process_timeout;
+	if (current->flags & PF_FUTEX_DEBUG)
+		timer.function = futex_timeout;
+	else
+		timer.function = process_timeout;
 
 	add_timer(&timer);
 	schedule();


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
