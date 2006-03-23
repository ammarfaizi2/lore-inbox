Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWCWU17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWCWU17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWCWU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:27:59 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:458 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750926AbWCWU17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:27:59 -0500
Subject: [PATCH -rt] get rid of unnecessary (un)likely's
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 15:27:48 -0500
Message-Id: <1143145668.17529.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas/Ingo

Looking at the code, I notice that there are a few likely and unlikely
flags that really don't belong.  Really there is two places, but for the
rt_mutex and rt_sems, they are the same.

We have in the blocking of the lock:

	if (unlikely(!waiter.task))
		task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);

Where, the first time around the for loop it is true, and the next time
around it is most likely false. So a fifty/fifty compare really
shouldn't use a likely or unlikely.

The next place is in the slow unlocks.  We have:

	if (likely(!rt_mutex_has_waiters(lock))) {
		lock->owner = NULL;
		spin_unlock_irqrestore(&lock->wait_lock, flags);
		return;
	}


Now this would be true if cmpxchg wasn't available.  But, if it is, then
this would actually be an unlikely case. We would fail the fast unlock
when we have waiters.  The supplied patch just removes this altogether,
but maybe it would be a good idea to have a little macro:

	if (cmpxchg_rt_waiters(!rt_mutex_has_waiters(lock))) {

with:

#if defined(__HAVE_ARCH_CMPXCHG)
...
#  define cmpxchg_rt_waiters(x) unlikely(x)
#else
...
#  define cmpxchg_rt_waiters(x) likely(x)
#endif

Just a thought.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt6/kernel/rtmutex.c
===================================================================
--- linux-2.6.16-rt6.orig/kernel/rtmutex.c	2006-03-23 15:10:57.000000000 -0500
+++ linux-2.6.16-rt6/kernel/rtmutex.c	2006-03-23 15:11:10.000000000 -0500
@@ -670,7 +670,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by an higher prio task.
 		 */
-		if (unlikely(!waiter.task))
+		if (!waiter.task)
 			task_blocks_on_rt_mutex(lock, &waiter, 0 __IP__);
 
 		/*
@@ -730,7 +730,7 @@ rt_lock_slowunlock(struct rt_mutex *lock
 
 	rt_mutex_deadlock_account_unlock(current);
 
-	if (likely(!rt_mutex_has_waiters(lock))) {
+	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return;
@@ -858,7 +858,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 		 * when we have been woken up by the previous owner
 		 * but the lock got stolen by an higher prio task.
 		 */
-		if (unlikely(!waiter.task)) {
+		if (!waiter.task) {
 			ret = task_blocks_on_rt_mutex(lock, &waiter,
 						      deadlock_detect __IP__);
 			if (ret == -EDEADLK)
@@ -961,7 +961,7 @@ rt_mutex_slowunlock(struct rt_mutex *loc
 
 	rt_mutex_deadlock_account_unlock(current);
 
-	if (likely(!rt_mutex_has_waiters(lock))) {
+	if (!rt_mutex_has_waiters(lock)) {
 		lock->owner = NULL;
 		spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return;


