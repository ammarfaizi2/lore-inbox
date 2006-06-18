Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWFRHbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWFRHbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFRHbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:31:20 -0400
Received: from mail32.syd.optusnet.com.au ([211.29.132.63]:18666 "EHLO
	mail32.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932123AbWFRHbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][8/29] track_mutexes-1.patch
Date: Sun, 18 Jun 2006 17:31:14 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4488
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181731.14664.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep a record of how many mutexes are held by any task. This allows cpu
scheduler code to use this information in decision making for tasks that
hold contended resources.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/init_task.h |    1 +
 include/linux/sched.h     |    1 +
 kernel/fork.c             |    1 +
 kernel/mutex.c            |   25 +++++++++++++++++++++++--
 4 files changed, 26 insertions(+), 2 deletions(-)

Index: linux-ck-dev/include/linux/init_task.h
===================================================================
--- linux-ck-dev.orig/include/linux/init_task.h	2006-06-18 15:20:14.000000000 +1000
+++ linux-ck-dev/include/linux/init_task.h	2006-06-18 15:23:44.000000000 +1000
@@ -120,6 +120,7 @@ extern struct group_info init_groups;
 	.blocked	= {{0}},					\
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
+	.mutexes_held	= 0,						\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:38.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:23:44.000000000 +1000
@@ -845,6 +845,7 @@ struct task_struct {
 	/* mutex deadlock detection */
 	struct mutex_waiter *blocked_on;
 #endif
+	unsigned long mutexes_held;
 
 /* journalling filesystem info */
 	void *journal_info;
Index: linux-ck-dev/kernel/fork.c
===================================================================
--- linux-ck-dev.orig/kernel/fork.c	2006-06-18 15:20:14.000000000 +1000
+++ linux-ck-dev/kernel/fork.c	2006-06-18 15:23:44.000000000 +1000
@@ -1022,6 +1022,7 @@ static task_t *copy_process(unsigned lon
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
+	p->mutexes_held = 0;
 	cpuset_fork(p);
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
Index: linux-ck-dev/kernel/mutex.c
===================================================================
--- linux-ck-dev.orig/kernel/mutex.c	2006-06-18 15:20:14.000000000 +1000
+++ linux-ck-dev/kernel/mutex.c	2006-06-18 15:23:44.000000000 +1000
@@ -58,6 +58,16 @@ EXPORT_SYMBOL(__mutex_init);
 static void fastcall noinline __sched
 __mutex_lock_slowpath(atomic_t *lock_count __IP_DECL__);
 
+static inline void inc_mutex_count(void)
+{
+	current->mutexes_held++;
+}
+
+static inline void dec_mutex_count(void)
+{
+	current->mutexes_held--;
+}
+
 /***
  * mutex_lock - acquire the mutex
  * @lock: the mutex to be acquired
@@ -87,6 +97,7 @@ void fastcall __sched mutex_lock(struct 
 	 * 'unlocked' into 'locked' state.
 	 */
 	__mutex_fastpath_lock(&lock->count, __mutex_lock_slowpath);
+	inc_mutex_count();
 }
 
 EXPORT_SYMBOL(mutex_lock);
@@ -112,6 +123,7 @@ void fastcall __sched mutex_unlock(struc
 	 * into 'unlocked' state:
 	 */
 	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_slowpath);
+	dec_mutex_count();
 }
 
 EXPORT_SYMBOL(mutex_unlock);
@@ -254,9 +266,14 @@ __mutex_lock_interruptible_slowpath(atom
  */
 int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
 {
+	int ret;
+
 	might_sleep();
-	return __mutex_fastpath_lock_retval
+	ret = __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_slowpath);
+	if (likely(!ret))
+		inc_mutex_count();
+	return ret;
 }
 
 EXPORT_SYMBOL(mutex_lock_interruptible);
@@ -308,8 +325,12 @@ static inline int __mutex_trylock_slowpa
  */
 int fastcall mutex_trylock(struct mutex *lock)
 {
-	return __mutex_fastpath_trylock(&lock->count,
+	int ret = __mutex_fastpath_trylock(&lock->count,
 					__mutex_trylock_slowpath);
+
+	if (likely(ret))
+		inc_mutex_count();
+	return ret;
 }
 
 EXPORT_SYMBOL(mutex_trylock);

-- 
-ck
