Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWJALic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWJALic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWJALiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:38:04 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:28892 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751827AbWJALh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:37:57 -0400
Date: Sun, 1 Oct 2006 13:37:19 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 4/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <Pine.LNX.4.64.0610011337170.29459@frodo.shire>
References: <20061001112829.630288000@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Documentation/rt-mutex-design.txt |   45 +++++++++++++++++++++++++++++++++-----
  1 file changed, 40 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rt/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.18-rt.orig/Documentation/rt-mutex-design.txt
+++ linux-2.6.18-rt/Documentation/rt-mutex-design.txt
@@ -229,6 +229,23 @@ pi_list.  This list is protected by a sp
  called pi_lock.  This lock may also be taken in interrupt context, so when
  locking the pi_lock, interrupts must be disabled.

+Boosting prio sched lifo
+------------------------
+A task's boosting prio is used to avoid lowering a task priority below what
+the priority it is boosting another to. A task is never given a priority
+less than boosting prio. This is needed because in the event of a signal or a
+timeout the task has to perform the deboosting of the owner. But if it
+already has lower priority it might not get the needed CPU to do that.
+boosting prio is reset when the task gets the lock or it is signalled/timed out
+and have done it's deboosting. For that reason the extra boosting is only
+giving to tasks running inside the down operations. But while inside a down
+operation boosting prio is never lowered. That is the task priority is never
+decreased.
+While boosting prio is active the task is made "sched lifo". I.e. it schedules
+in lifo order among equal priority tasks instead of the usual fifo order. This
+is again done to make sure that a task being signalled while sleeping inside
+the down operation will get the CPU before the task being boosted, such it can
+perform the deboost operation.

  Depth of the PI Chain
  ---------------------
@@ -370,11 +387,21 @@ rt_mutex_getprio and rt_mutex_setprio ar

  rt_mutex_getprio returns the priority that the task should have.  Either the
  task's own normal priority, or if a process of a higher priority is waiting on
-a mutex owned by the task, then that higher priority should be returned.
+a mutex owned by the task, then that higher priority should be returned. If
+the task is currently boosting another task to some priority, rt_mutex_getprio
+will return at least that priority. This is because deboosting in the event of
+a signal or a timeout must be performed by this task. But if this task has
+lower priority than the task being boosted it might not get a CPU to run on -
+especially on UP machines.
+rt_mutex_getprio_real returns the task's priority without taking boosting_prio
+into account. This is used as the priority for the waiter list and thus
+also for the PI list. If rt_mutex_getprio was used the order in the wait_list
+would be incorrect and the task would boost too much.
+
  Since the pi_list of a task holds an order by priority list of all the top
-waiters of all the mutexes that the task owns, rt_mutex_getprio simply needs
-to compare the top pi waiter to its own normal priority, and return the higher
-priority back.
+waiters of all the mutexes that the task owns, rt_mutex_getprio_real simply
+needs to compare the top pi waiter to its own normal priority, and return the
+higher priority back.

  (Note:  if looking at the code, you will notice that the lower number of
          prio is returned.  This is because the prio field in the task structure
@@ -680,6 +707,10 @@ If the owner is also blocked on a lock,
  (or deadlock checking is on), we unlock the wait_lock of the mutex and go ahead
  and run rt_mutex_adjust_prio_chain on the owner, as described earlier.

+In the second round of the loop we might fail getting the lock but
+waiter.task might not be NULL. In that case we also release the wait_lock and
+call rt_mutex_adjust_prio_chain in case some priority was changed.
+
  Now all locks are released, and if the current process is still blocked on a
  mutex (waiter "task" field is not NULL), then we go to sleep (call schedule).

@@ -690,6 +721,7 @@ The schedule can then wake up for a few
    1) we were given pending ownership of the mutex.
    2) we received a signal and was TASK_INTERRUPTIBLE
    3) we had a timeout and was TASK_INTERRUPTIBLE
+  4) our priority was changed and we have to perform priority adjustments

  In any of these cases, we continue the loop and once again try to grab the
  ownership of the mutex.  If we succeed, we exit the loop, otherwise we continue
@@ -711,6 +743,8 @@ pi_list of the owner.  If this process w
  the rt_mutex_adjust_prio_chain needs to be executed again on the owner,
  but this time it will be lowering the priorities.

+At the end we need to reset boosting prio and adjust our own priority.
+

  Unlocking the Mutex
  -------------------
@@ -759,8 +793,10 @@ We now clear the "pi_blocked_on" field o
  the mutex still has waiters pending, we add the new top waiter to the pi_list
  of the pending owner.

-Finally we unlock the pi_lock of the pending owner and wake it up.
+We also reset the boosting prio of the pending owner and removes the sched lifo
+property: Now it is the owner and it can't be boosting anyone.

+Finally we unlock the pi_lock of the pending owner and wake it up.

  Contact
  -------

--
