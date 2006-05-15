Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWEOIin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWEOIin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWEOIim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:38:42 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:8888 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964828AbWEOIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:38:42 -0400
Date: Mon, 15 May 2006 04:38:29 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm 01/02] Update rt-mutex-design.txt per Randy Dunlap
In-Reply-To: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605150437110.12114@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the changes that Randy suggested.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex-design.txt	2006-05-15 04:05:14.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-15 04:27:00.000000000 -0400
@@ -31,17 +31,17 @@ priority process is prevented from runni
 an undetermined amount of time.

 The classic example of unbounded priority inversion is were you have three
-processes, lets call them processes A, B, and C, where A is the highest priority
-process, C is the lowest, and B is in between. A tries to grab a lock that C
-owns and must wait and lets C run to release the lock. But in the meantime,
-B executes, and since B is of a higher priority than C, it preempts C, but
-by doing so, it is in fact preempting A which is a higher priority process.
+processes, let's call them processes A, B, and C, where A is the highest
+priority process, C is the lowest, and B is in between. A tries to grab a lock
+that C owns and must wait and lets C run to release the lock. But in the
+meantime, B executes, and since B is of a higher priority than C, it preempts C,
+but by doing so, it is in fact preempting A which is a higher priority process.
 Now there's no way of knowing how long A will be sleeping waiting for C
 to release the lock, because for all we know, B is a CPU hog and will
 never give C a chance to release the lock.  This is called unbounded priority
 inversion.

-Here's a little ascii art to show the problem.
+Here's a little ASCII art to show the problem.

    grab lock L1 (owned by C)
      |
@@ -62,7 +62,7 @@ for this document.  Here we only discuss

 PI is where a process inherits the priority of another process if the other
 process blocks on a lock owned by the current process.  To make this easier
-to understand, lets use the previous example, with processes A, B, and C again.
+to understand, let's use the previous example, with processes A, B, and C again.

 This time, when A blocks on the lock owned by C, C would inherit the priority
 of A.  So now if B becomes runnable, it would not preempt C, since C now has
@@ -84,18 +84,18 @@ mutex    - In this document, to differen
            PI and spin locks that are used in the PI code, from now on
            the PI locks will be called a mutex.

-lock     - In this document from now on, I will use the term lock when refering
-           to spin locks that are used to protect parts of the PI algorithm.
-           These locks disable preemption for UP (when CONFIG_PREEMPT is
-           enabled) and on SMP prevents multiple CPUs from entering critical
-           sections simultaneously.
+lock     - In this document from now on, I will use the term lock when
+           referring to spin locks that are used to protect parts of the PI
+           algorithm.  These locks disable preemption for UP (when
+           CONFIG_PREEMPT is enabled) and on SMP prevents multiple CPUs from
+           entering critical sections simultaneously.

 spin lock - Same as lock above.

 waiter   - A waiter is a struct that is stored on the stack of a blocked
            process.  Since the scope of the waiter is within the code for
            a process being blocked on the mutex, it is fine to allocate
-           the waiter on the process' stack (local variable).  This
+           the waiter on the process's stack (local variable).  This
            structure holds a pointer to the task, as well as the mutex that
            the task is blocked on.  It also has the plist node structures to
            place the task in the waiter_list of a mutex as well as the
@@ -111,7 +111,7 @@ top waiter - The highest priority proces
 top pi waiter - The highest priority process waiting on one of the mutexes
                 that a specific process owns.

-Note:  task and process are used interchangeably in this document.  Mostly to
+Note:  task and process are used interchangeably in this document, mostly to
        differentiate between two processes that are being described together.


@@ -142,7 +142,7 @@ The chain would be:
    E->L4->D->L3->C->L2->B->L1->A

 To show where two chains merge, we could add another process F and
-another mutex L5 where B owns L5 and F is blocked on mutex L5
+another mutex L5 where B owns L5 and F is blocked on mutex L5.

 The chain for F would be:

@@ -160,12 +160,12 @@ Here we show both chains:
                  F->L5-+

 For PI to work, the processes at the right end of these chains (or we may
-also call the Top of the chain), must be equal to or higher in priority
+also call the Top of the chain) must be equal to or higher in priority
 than the processes to the left or below in the chain.

 Also since a mutex may have more than one process blocked on it, we can
 have multiple chains merge at mutexes.  If we add another process G that is
-blocked on mutex L2.
+blocked on mutex L2:

   G->L2->B->L1->A

@@ -190,9 +190,9 @@ The implementation of plist is out of sc
 very important to understand what it does.

 There are a few differences between plist and list, the most important one
-is that plist is a priority sorted link list.  This means that the priorities
-of the plist are sorted, such that it takes O(1) to retrieve the highest
-priority item in the list.  Obviously this is useful to store processes
+being that plist is a priority sorted linked list.  This means that the
+priorities of the plist are sorted, such that it takes O(1) to retrieve the
+highest priority item in the list.  Obviously this is useful to store processes
 based on their priorities.

 Another difference, which is important for implementation, is that, unlike
@@ -235,45 +235,49 @@ Depth of the PI Chain

 The maximum depth of the PI chain is not dynamic, and could actually be
 defined.  But is very complex to figure it out, since it depends on all
-the nesting of mutexes.  Lets look at the example where we have 3 mutexes,
+the nesting of mutexes.  Let's look at the example where we have 3 mutexes,
 L1, L2, and L3, and four separate functions func1, func2, func3 and func4.
 The following shows a locking order of L1->L2->L3, but may not actually
 be directly nested that way.

-void func1 () {
-     mutex_lock(L1);
+void func1(void)
+{
+	mutex_lock(L1);

-     /* do anything */
+	/* do anything */

-     mutex_unlock(L1);
+	mutex_unlock(L1);
 }

-void func2 () {
-     mutex_lock(L1);
-     mutex_lock(L2);
+void func2(void)
+{
+	mutex_lock(L1);
+	mutex_lock(L2);

-     /* do something */
+	/* do something */

-     mutex_unlock(L2);
-     mutex_unlock(L1);
+	mutex_unlock(L2);
+	mutex_unlock(L1);
 }

-void func3 () {
-     mutex_lock(L2);
-     mutex_lock(L3);
+void func3(void)
+{
+	mutex_lock(L2);
+	mutex_lock(L3);

-     /* do something else */
+	/* do something else */

-     mutex_unlock(L3);
-     mutex_unlock(L2);
+	mutex_unlock(L3);
+	mutex_unlock(L2);
 }

-void func4 () {
-     mutex_lock(L3);
+void func4(void)
+{
+	mutex_lock(L3);

-     /* do something again */
+	/* do something again */

-     mutex_unlock(L3);
+	mutex_unlock(L3);
 }

 Now we add 4 processes that run each of these functions separately.
@@ -309,9 +313,9 @@ Mutex owner and flags
 The mutex structure contains a pointer to the owner of the mutex.  If the
 mutex is not owned, this owner is set to NULL.  Since all architectures
 have the task structure on at least a four byte alignment (and if this is
-not true, the rtmutex.c code will be broken!), this allows for the least
-two significant bits to be used as flags.  This part is also described
-in Documentation/rt-mutex.txt, but will also be briefly descried here.
+not true, the rtmutex.c code will be broken!), this allows for the two
+least significant bits to be used as flags.  This part is also described
+in Documentation/rt-mutex.txt, but will also be briefly described here.

 Bit 0 is used as the "Pending Owner" flag.  This is described later.
 Bit 1 is used as the "Has Waiters" flags.  This is also described later
@@ -365,7 +369,7 @@ to already be taken), rt_mutex_get_prio,
 rt_mutex_getprio and rt_mutex_setprio are only used in __rt_mutex_adjust_prio.

 rt_mutex_getprio returns the priority that the task should have.  Either the
-tasks own normal priority, or if a process of a higher priority is waiting on
+task's own normal priority, or if a process of a higher priority is waiting on
 a mutex owned by the task, then that higher priority should be returned.
 Since the pi_list of a task holds an order by priority list of all the top
 waiters of all the mutexes that the task owns, rt_mutex_getprio simply needs
@@ -375,7 +379,7 @@ priority back.
 (Note:  if looking at the code, you will notice that the lower number of
         prio is returned.  This is because the prio field in the task structure
         is an inverse order of the actual priority.  So a "prio" of 5 is
-        of higher priority than a "prio" of 10).
+        of higher priority than a "prio" of 10.)

 __rt_mutex_adjust_prio examines the result of rt_mutex_getprio, and if the
 result does not equal the task's current priority, then rt_mutex_setprio
@@ -387,7 +391,7 @@ It is interesting to note that __rt_mute
 or decrease the priority of the task.  In the case that a higher priority
 process has just blocked on a mutex owned by the task, __rt_mutex_adjust_prio
 would increase/boost the task's priority.  But if a higher priority task
-were for some reason leave the mutex (timeout or signal), this same function
+were for some reason to leave the mutex (timeout or signal), this same function
 would decrease/unboost the priority of the task.  That is because the pi_list
 always contains the highest priority task that is waiting on a mutex owned
 by the task, so we only need to compare the priority of that top pi waiter
@@ -403,13 +407,13 @@ The implementation has gone through seve
 with what we believe is the best.  It walks the PI chain by only grabbing
 at most two locks at a time, and is very efficient.

-The rt_mutex_adjust_prio_chain can be used to both boost processes to higher
-priorities, or sometimes it is used to lower priorities.
+The rt_mutex_adjust_prio_chain can be used either to boost or lower process
+priorities.

-The rt_mutex_adjust_prio_chain is called with a task to be checked for
-PI (de)boosting (the owner of a mutex that a process is blocking on), a flag to
+rt_mutex_adjust_prio_chain is called with a task to be checked for PI
+(de)boosting (the owner of a mutex that a process is blocking on), a flag to
 check for deadlocking, the mutex that the task owns, and a pointer to a waiter
-that is the process' waiter struct that is blocked on the mutex (although this
+that is the process's waiter struct that is blocked on the mutex (although this
 parameter may be NULL for deboosting).

 For this explanation, I will not mention deadlock detection. This explanation
@@ -435,7 +439,7 @@ If the task is not blocked on a mutex th
 the top of the PI chain.

 A check is now done to see if the original waiter (the process that is blocked
-on the current mutex), is the top pi waiter of the task.  That is, is this
+on the current mutex) is the top pi waiter of the task.  That is, is this
 waiter on the top of the task's pi_list.  If it is not, it either means that
 there is another process higher in priority that is blocked on one of the
 mutexes that the task owns, or that the waiter has just woken up via a signal
@@ -455,7 +459,7 @@ is taken.  This is done by a spin_tryloc
 pi_lock and wait_lock goes in the opposite direction. If we fail to grab the
 lock, the pi_lock is released, and we restart the loop.

-Now that we have both the pi_lock of the task, as well as the wait_lock of
+Now that we have both the pi_lock of the task as well as the wait_lock of
 the mutex the task is blocked on, we update the task's waiter's plist node
 that is located on the mutex's wait_list.

@@ -466,8 +470,8 @@ task's entry in the owner's pi_list.  If
 process on the mutex's wait_list, then we remove the previous top waiter
 from the owner's pi_list, and replace it with the task.

-Note: It is possible that the task was the current top waiter on the mutex
-      in which case, the task is not yet on the pi_list of the waiter.  This
+Note: It is possible that the task was the current top waiter on the mutex,
+      in which case the task is not yet on the pi_list of the waiter.  This
       is OK, since plist_del does nothing if the plist node is not on any
       list.

@@ -477,16 +481,16 @@ task.  In this case, the task is removed
 and the new top waiter is added.

 Lastly, we unlock both the pi_lock of the task, as well as the mutex's
-wait_lock, and continue the loop again, this time the task is the owner
-of the previous mutex.
-
+wait_lock, and continue the loop again.  On the next iteration of the
+loop, the previous owner of the mutex will be the task that will be
+processed.

 Note: One might think that the owner of this mutex might have changed
       since we just grab the mutex's wait_lock. And one could be right.
-      The important thing to remember, is that the owner could not have
+      The important thing to remember is that the owner could not have
       become the task that is being processed in the PI chain, since
       we have taken that task's pi_lock at the beginning of the loop.
-      So as long as there is an owner of this mutex, that is not the same
+      So as long as there is an owner of this mutex that is not the same
       process as the tasked being worked on, we are OK.

       Looking closely at the code, one might be confused.  The check for the
@@ -534,7 +538,7 @@ and it would need to boost the lower pri
 latency of that critical section (since the low priority process just entered
 it).

-There's no reason a high priority process that gives up a mutex, should be
+There's no reason a high priority process that gives up a mutex should be
 penalized if it tries to take that mutex again.  If the new owner of the
 mutex has not woken up yet, there's no reason that the higher priority process
 could not take that mutex away.
@@ -551,7 +555,7 @@ and continue with the mutex.
 Taking of a mutex (The walk through)
 ------------------------------------

-OK, now lets take a look at the detailed walk through of what happens when
+OK, now let's take a look at the detailed walk through of what happens when
 taking a mutex.

 The first thing that is tried is the fast taking of the mutex.  This is
@@ -611,12 +615,13 @@ means that if the mutex doesn't have any
 to update the pending owner's pi_list, since we only worry about processes
 blocked on the current mutex.

-If there is waiters on this mutex, and we just stole the ownership, we need
+If there are waiters on this mutex, and we just stole the ownership, we need
 to take the top waiter, remove it from the pi_list of the pending owner, and
 add it to the current pi_list.  Note that at this moment, the pending owner
 is no longer on the list of waiters.  This is fine, since the pending owner
 would add itself back when it realizes that it had the ownership stolen
-from itself.
+from itself.  When the pending owner tries to grab the mutex, it will fail
+in try_to_take_rt_mutex if the owner field points to another process.

 2) No owner
 -----------
@@ -642,7 +647,9 @@ Now we enter a loop that will continue t
 fail from a timeout or signal.

 Once again we try to take the mutex.  This will usually fail the first time
-in the loop, but not usually the second.
+in the loop, since it had just failed to get the mutex.  But the second time
+in the loop, this would likely succeed, since the task would likely be
+the pending owner.

 If the mutex is TASK_INTERRUPTIBLE a check for signals and timeout is done
 here.
@@ -666,9 +673,9 @@ priority process currently waiting on th
 previous top waiter process (if it exists) from the pi_list of the owner,
 and add the current process to that list.  Since the pi_list of the owner
 has changed, we call rt_mutex_adjust_prio on the owner to see if the owner
-should adjust it's priority accordingly.
+should adjust its priority accordingly.

-If the owner is also blocked on a lock, and had it's pi_list changed
+If the owner is also blocked on a lock, and had its pi_list changed
 (or deadlock checking is on), we unlock the wait_lock of the mutex and go ahead
 and run rt_mutex_adjust_prio_chain on the owner, as described earlier.

@@ -714,17 +721,22 @@ take the slow path when unlocking the mu
 waiters, the owner field of the mutex would equal the current process and
 the mutex can be unlocked by just replacing the owner field with NULL.

-If the owner field has the "Has Waiters" bit set, (or CMPXCHG is not available)
+If the owner field has the "Has Waiters" bit set (or CMPXCHG is not available),
 the slow unlock path is taken.

 The first thing done in the slow unlock path is to take the wait_lock of the
 mutex.  This synchronizes the locking and unlocking of the mutex.

-A check is made to see if the mutex has waiters or not, this can be the case for
-architectures without CMPXCHG, or a waiter had hit the timeout or signal and
-removed itself between the time the "Has Waiters" bit was checked and this
-check.  If there are no waiters than the mutex owner field is set to NULL,
-the wait_lock is released and nothing more is needed.
+A check is made to see if the mutex has waiters or not.  On architectures that
+do not have CMPXCHG, this is the location that the owner of the mutex will
+determine if a waiter needs to be awoken or not.  On architectures that
+do have CMPXCHG, that check is done in the fast path, but it is still needed
+in the slow path too.  If a waiter of a mutex woke up because of a signal
+or timeout between the time the owner failed the fast path CMPXCHG check and
+the grabbing of the wait_lock, the mutex may not have any waiters, thus the
+owner still needs to make this check. If there are no waiters than the mutex
+owner field is set to NULL, the wait_lock is released and nothing more is
+needed.

 If there are waiters, then we need to wake one up and give that waiter
 pending ownership.
@@ -746,7 +758,7 @@ We now clear the "pi_blocked_on" field o
 the mutex still has waiters pending, we add the new top waiter to the pi_list
 of the pending owner.

-Finally we unlock the pi_lock of the pending owner, and wake it up.
+Finally we unlock the pi_lock of the pending owner and wake it up.


 Contact
@@ -760,8 +772,7 @@ Credits

 Author:  Steven Rostedt <rostedt@goodmis.org>

-Reviewers:  Ingo Molnar, Thomas Gleixner, and Thomas Duetsch.
-
+Reviewers:  Ingo Molnar, Thomas Gleixner, Thomas Duetsch, and Randy Dunlap

 Updates
 -------
