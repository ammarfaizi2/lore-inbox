Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVISUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVISUjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbVISUjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:39:06 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5298 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932630AbVISUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:39:05 -0400
Subject: [PATCH linux-2.6.13-rt14] Priority inversion bug
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>
Content-Type: multipart/mixed; boundary="=-gL3pzzWF8dlDzu+7L5Ul"
Organization: Kihon Technologies
Date: Mon, 19 Sep 2005 16:38:29 -0400
Message-Id: <1127162309.5097.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gL3pzzWF8dlDzu+7L5Ul
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ingo,

I just discovered a priority inversion bug with the current code.
Attached is code for a module that forces the situation and shows that
it is wrong.  What the module does is the following:

Creates three threads and two locks.

The parent takes lock L1 and creates the other threads where P1 is the
lowest priority and P3 is the highest.  It then wakes up P2 which tries
to grab the lock L1 which the parent already has (which should boost the
parent).  Then P1 wakes up, grabs it's own lock L2 and then grabs the
parent's lock L1 and it too will block.  Then P3 wakes up and grabs P1's
lock L2 and it blocks.  So this looks like this:

Parent-has-L1
P1-has-L2
  -blocked-L1
P2-blocked-L1
P3-blocked-L2

Now the fun part.  When the parent releases L1, P1 should get the lock
since P3 is the highest proirity and P1 inherits that prio.  But what
happens is that P2 gets the lock.  Here's the output of the module:

thread 2 running
thread 1 running
thread 1 got lock t2
thread 3 running
parent releasing the t1 lock!
thread 2 got lock t1
thread 1 got lock t1
thread 3 got lock t2

This bug was introduced by the addition of the plists.  This is because
the old way was to find who got the lock at the releasing of the lock.
Now it happens at the time a task blocks on the lock. But this
information is not updated when PI takes place.  So below is the patch
to fix this.  With the patch, I get the following output:

thread 2 running
thread 1 running
thread 1 got lock t2
thread 3 running
parent releasing the t1 lock!
thread 1 got lock t1
thread 3 got lock t2
thread 2 got lock t1

This shows that P1 got the lock and was able to run to release lock 2 so
that the P3 can run, as expected.

The patch simply changes pi_setprio to modify the pi_list in all cases.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 317)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -857,31 +857,30 @@
 			__raw_spin_lock(&l->wait_lock);
 
 		TRACE_BUG_ON_LOCKED(!lock_owner(l));
-		if ((ALL_TASKS_PI || rt_task(p)) && plist_empty(&w->pi_list)) {
-			TRACE_BUG_ON_LOCKED(was_rt);
-			plist_init(&w->pi_list, prio);
-			plist_add(&w->pi_list, &lock_owner(l)->task->pi_waiters);
 
-			plist_del(&w->list, &l->wait_list);
-			plist_init(&w->list, prio);
-			plist_add(&w->list, &l->wait_list);
-		}
-		/*
-		 * If the task is blocked on a lock, and we just restored
-		 * it from RT to non-RT then unregister the task from
-		 * the PI list and requeue it to the wait list.
-		 *
-		 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
-		 *        get PI handled.)
-		 */
-		if (!ALL_TASKS_PI && !rt_task(p) && !plist_empty(&w->pi_list)) {
-			TRACE_BUG_ON_LOCKED(!was_rt);
+		if (!plist_empty(&w->pi_list)) {
+			TRACE_BUG_ON_LOCKED(!was_rt && !ALL_TASKS_PI && !rt_task(p));
+			/*
+			 * If the task is blocked on a lock, and we just restored
+			 * it from RT to non-RT then unregister the task from
+			 * the PI list and requeue it to the wait list.
+			 *
+			 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
+			 *        get PI handled.)
+			 */
 			plist_del(&w->pi_list, &lock_owner(l)->task->pi_waiters);
-			plist_del(&w->list, &l->wait_list);
-			plist_init(&w->list, prio);
-			plist_add(&w->list, &l->wait_list);
+		} else
+			TRACE_BUG_ON_LOCKED((ALL_TASKS_PI || rt_task(p)) && was_rt);
+
+		if (ALL_TASKS_PI || rt_task(p)) {
+			plist_init(&w->pi_list,prio);
+			plist_add(&w->pi_list, &lock_owner(l)->task->pi_waiters);
 		}
 
+		plist_del(&w->list, &l->wait_list);
+		plist_init(&w->list, prio);
+		plist_add(&w->list, &l->wait_list);
+
 		pi_walk++;
 
 		if (p != task)


--=-gL3pzzWF8dlDzu+7L5Ul
Content-Disposition: attachment; filename=pi_test.c
Content-Type: text/x-csrc; name=pi_test.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/list.h>
#include <linux/spinlock.h>
#include <linux/sched.h>
#include <linux/kthread.h>
#include <linux/delay.h>
#include <linux/mm.h>

#include <asm/uaccess.h>

static spinlock_t t1 = SPIN_LOCK_UNLOCKED(t1);
static spinlock_t t2 = SPIN_LOCK_UNLOCKED(t2);

struct task_struct *threads[3];

static int run1(void *data)
{
	printk("thread 1 running\n");
	spin_lock(&t2);
	printk("thread 1 got lock t2\n");
	spin_lock(&t1);
	printk("thread 1 got lock t1\n");
	spin_unlock(&t1);
	spin_unlock(&t2);
	
	return 0;
}

static int run2(void *data)
{
	printk("thread 2 running\n");
	spin_lock(&t1);
	printk("thread 2 got lock t1\n");
	spin_unlock(&t1);
	return 0;
}

static int run3(void *data)
{
	printk("thread 3 running\n");
	spin_lock(&t2);
	printk("thread 3 got lock t2\n");
	spin_unlock(&t2);
	return 0;
}
static int pi_test_init(void)
{
	struct sched_param param = {.sched_priority = 10 };
	int n = 0;
	int i;

	printk("set sched myself\n");
	sched_setscheduler(current, SCHED_FIFO, 
			(struct sched_param __user*)&param);

	threads[n++] = kthread_create(run1, NULL, "thread1");
	threads[n++] = kthread_create(run2, NULL, "thread2");
	threads[n++] = kthread_create(run3, NULL, "thread3");

	spin_lock(&t1);

	for (i=0; i < n; i++) {
		param.sched_priority++;
		printk("set sched for thread[%d] %d\n",i,threads[i]->pid);
		sched_setscheduler(threads[i], SCHED_FIFO, 
				(struct sched_param __user*)&param);
	}

	/* first wake the middle process */
	wake_up_process(threads[1]);
	msleep(10);
	/* wake the lowest process that will block on the previous */
	wake_up_process(threads[0]);
	msleep(10);
	/* now wake the highest process which will block on the lowest
	 * but lets see who gets the lock when we let it go */
	wake_up_process(threads[2]);
	msleep(10);

	/* let the games begin! */
	printk("parent releasing the t1 lock!\n");
	spin_unlock(&t1);

	

	return 0;
}

static void pi_test_exit(void)
{
}

module_init(pi_test_init);
module_exit(pi_test_exit);

MODULE_LICENSE("GPL");


--=-gL3pzzWF8dlDzu+7L5Ul--

