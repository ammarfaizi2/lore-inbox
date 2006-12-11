Return-Path: <linux-kernel-owner+w=401wt.eu-S1762611AbWLKKsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762611AbWLKKsw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762653AbWLKKsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:48:52 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:37454 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762611AbWLKKsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:48:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=iNyOcUxuAG/e/UE6pl5Iugnx3IOfAy3Uj2NgtUpJU9DeB6GCpl0rCYdNkQ9GdoGc/tQbC47Kh6EdNS0wxW2b5zUlBxQ3GI0ltv6/iAiMnRFlWocMqI0eXPBnQAdtH8FhtHhoVIgs3iyglGGAHBVWNki++FI6cge2kObjPpv/ZPU=
Date: Mon, 11 Dec 2006 18:48:47 +0800
From: "Li Yu" <raise.sail@gmail.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: A simple priority ceiling framework and an implementation for mutex.
Message-ID: <200612111848436406815@gmail.com>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some tips of the design:

	1. The prio_floor linked-list save all mutex is holded by each task in time order. It is a stack data srtucture.
	2. The prio_rmin member of the mutex_waiter is used for tracing current minimum-value(highest) priority of this mutex.
	3. It seem the task_struct->nr_null_floors have a bit of redundancy, it's used to guarantee everything's OK when we failed to allocate prio_floor structure.
	4. At last, the magic value PRIO_UNDERGROUND	(0x19491001), it is the Chinese National Day ;)

The most largest question is how meansure the performance of this patch ?  I have no any good idea for this.

Good luck.

Signed-off-by: Li Yu <raise.sail@gmail.com>

diff -Naurp linux-2.6.19/include/linux/prio_ceiling.h linux-2.6.19.ceiling/include/linux/prio_ceiling.h
--- linux-2.6.19/include/linux/prio_ceiling.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.19.ceiling/include/linux/prio_ceiling.h	2006-12-11 14:39:09.000000000 +0800
@@ -0,0 +1,17 @@
+#ifndef _LINUX_PRIO_CEILING_H
+#define _LINUX_PRIO_CEILING_H
+
+#ifdef __KERNEL__
+
+struct prio_floor {
+	struct prio_floor *next; /* linked in priority stair */
+	void *id;	/* which mutex own this floor ? */
+	int prio; /* save the priority when acquire */
+};
+
+#define FLOOR_ID_NONE ((void*)0)
+#define FLOOR_ID_NEXT ((void*)1)
+
+#endif /* __KERNEL__ */
+
+#endif
diff -Naurp linux-2.6.19/include/linux/sched.h linux-2.6.19.ceiling/include/linux/sched.h
--- linux-2.6.19/include/linux/sched.h	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19.ceiling/include/linux/sched.h	2006-12-11 14:39:44.000000000 +0800
@@ -2,7 +2,6 @@
 #define _LINUX_SCHED_H
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
-
 /*
  * cloning flags:
  */
@@ -69,6 +68,7 @@ struct sched_param {
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
 #include <linux/completion.h>
+#include <linux/prio_ceiling.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
 #include <linux/topology.h>
@@ -501,6 +501,7 @@ struct signal_struct {
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define PRIO_UNDERGROUND	(0x19491001)
 
 #define rt_prio(prio)		unlikely((prio) < MAX_RT_PRIO)
 #define rt_task(p)		rt_prio((p)->prio)
@@ -790,6 +791,12 @@ struct task_struct {
 #endif
 	int load_weight;	/* for niceness load balancing purposes */
 	int prio, static_prio, normal_prio;
+
+	int prio_ceiling;	/* for priority ceiling */
+	struct prio_floor *prio_stair;
+	void *fly_floor;
+	unsigned long nr_null_floors;
+
 	struct list_head run_list;
 	struct prio_array *array;
 
@@ -1076,6 +1083,82 @@ static inline int is_init(struct task_st
 
 extern struct pid *cad_pid;
 
+#define task_top_prio_floor(task) ((task)->prio_stair)
+
+static inline void task_push_prio_floor(struct prio_floor *floor)
+{
+	struct task_struct *tsk = current;
+
+	if (unlikely(!floor)) { /* so we are safety when out of memory. */
+		++tsk->nr_null_floors;
+		return;
+	}
+
+	/* keep the top of priority stack have min priority in value. */
+	if (tsk->prio_stair && tsk->prio_stair->prio < floor->prio)
+		floor->prio = tsk->prio_stair->prio;
+	if (floor->prio < tsk->prio)
+		tsk->prio_ceiling = floor->prio;
+
+	if (tsk->prio_stair && tsk->prio_stair == floor) {
+		floor->next = tsk->prio_stair;
+		tsk->prio_stair = floor->next;
+	}
+	return;
+}
+
+static inline void task_pop_prio_floor(void)
+{
+	struct task_struct *tsk = current;
+	struct prio_floor *top;
+
+	if (unlikely(tsk->nr_null_floors)) {
+		--tsk->nr_null_floors;
+		return;
+	}
+
+	if ((top=tsk->prio_stair))
+		tsk->prio_stair = tsk->prio_stair->next;
+	tsk->prio_ceiling = (tsk->prio_stair ? tsk->prio_stair->prio : PRIO_UNDERGROUND);
+	return;
+}
+
+static inline void task_climb_down(struct task_struct *task)
+{
+	struct prio_floor *top = task->prio_stair;
+
+	if (!top) {
+		/* task hold not any mutex, to restore our normal priority game */
+		task->prio_ceiling = PRIO_UNDERGROUND; 
+		task->fly_floor = FLOOR_ID_NONE;
+		return;
+	}
+	if (task->fly_floor && FLOOR_ID_NEXT != task->fly_floor ) {
+		if (task->fly_floor == top->id)
+			task->fly_floor = FLOOR_ID_NEXT;		
+	} else
+		task->prio_ceiling = top->prio;
+}
+
+static inline void __task_climb_up(struct task_struct *task, struct prio_floor *floor)
+{
+	if (floor->prio >= task->prio_ceiling)
+		return;
+	task->prio_ceiling = floor->prio;
+	task->fly_floor = floor->id;
+}
+
+#define task_climb_up_wait __task_climb_up
+
+static inline void task_climb_up_wake(struct task_struct *task, void *id, int prio)
+{
+	struct prio_floor floor;
+
+	floor.id = id;
+	floor.prio = prio;
+	__task_climb_up(task, &floor);
+}
+
 extern void free_task(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
--- linux-2.6.19/kernel/sched.c	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19.ceiling/kernel/sched.c	2006-12-11 14:42:39.000000000 +0800
@@ -727,6 +727,9 @@ static inline int __normal_prio(struct t
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
+
+	if (!rt_prio(p->prio_ceiling) && p->prio_ceiling < prio)
+		prio = p->prio_ceiling;
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
diff -Naurp linux-2.6.19/include/linux/mutex.h linux-2.6.19.ceiling/include/linux/mutex.h
--- linux-2.6.19/include/linux/mutex.h	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19.ceiling/include/linux/mutex.h	2006-12-11 14:35:26.000000000 +0800
@@ -14,6 +14,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/linkage.h>
 #include <linux/lockdep.h>
+#include <linux/prio_ceiling.h>
 
 #include <asm/atomic.h>
 
@@ -49,6 +50,8 @@ struct mutex {
 	atomic_t		count;
 	spinlock_t		wait_lock;
 	struct list_head	wait_list;
+	struct task_struct	*holder;
+	struct prio_floor	floor;
 #ifdef CONFIG_DEBUG_MUTEXES
 	struct thread_info	*owner;
 	const char 		*name;
@@ -66,6 +69,7 @@ struct mutex {
 struct mutex_waiter {
 	struct list_head	list;
 	struct task_struct	*task;
+	int prio_rmin;
 #ifdef CONFIG_DEBUG_MUTEXES
 	struct mutex		*lock;
 	void			*magic;
--- linux-2.6.19/kernel/mutex.c	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19.ceiling/kernel/mutex.c	2006-12-11 14:39:57.000000000 +0800
@@ -89,6 +89,7 @@ void inline fastcall __sched mutex_lock(
 	 * 'unlocked' into 'locked' state.
 	 */
 	__mutex_fastpath_lock(&lock->count, __mutex_lock_slowpath);
+	task_push_prio_floor(&lock->floor);
 }
 
 EXPORT_SYMBOL(mutex_lock);
@@ -113,6 +114,7 @@ void fastcall __sched mutex_unlock(struc
 	 * The unlocking fastpath is the 0->1 transition from 'locked'
 	 * into 'unlocked' state:
 	 */
+	task_pop_prio_floor();
 	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_slowpath);
 }
 
@@ -135,6 +137,19 @@ __mutex_lock_common(struct mutex *lock, 
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	debug_mutex_add_waiter(lock, &waiter, task->thread_info);
 
+	if (!list_empty(&lock->wait_list)) {
+		struct mutex_waiter *last =
+				list_entry(lock->wait_list.prev,
+					   struct mutex_waiter, list);
+		if (task->prio < last->prio_rmin)
+			waiter.prio_rmin = task->prio;
+		else
+			waiter.prio_rmin = last->prio_rmin;
+	} else
+		waiter.prio_rmin = task->prio;
+	lock->floor.prio = waiter.prio_rmin;
+	lock->floor.id = lock;
+
 	/* add waiting tasks to the end of the waitqueue (FIFO): */
 	list_add_tail(&waiter.list, &lock->wait_list);
 	waiter.task = task;
@@ -167,6 +182,8 @@ __mutex_lock_common(struct mutex *lock, 
 			return -EINTR;
 		}
 		__set_task_state(task, state);
+		
+		task_climb_up_wait(lock->holder, &lock->floor);
 
 		/* didnt get the lock, go to sleep: */
 		spin_unlock_mutex(&lock->wait_lock, flags);
@@ -177,6 +194,8 @@ __mutex_lock_common(struct mutex *lock, 
 	/* got the lock - rejoice! */
 	mutex_remove_waiter(lock, &waiter, task->thread_info);
 	debug_mutex_set_owner(lock, task->thread_info);
+	
+	lock->holder = task;
 
 	/* set it to 0 if there are no waiters left: */
 	if (likely(list_empty(&lock->wait_list)))
@@ -229,14 +248,22 @@ __mutex_unlock_common_slowpath(atomic_t 
 	if (__mutex_slowpath_needs_to_unlock())
 		atomic_set(&lock->count, 1);
 
+	lock->holder = NULL;
+	task_climb_down(current);
+
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 				list_entry(lock->wait_list.next,
 					   struct mutex_waiter, list);
+		struct mutex_waiter *tailor =
+				list_entry(lock->wait_list.prev,
+					   struct mutex_waiter, list);
 
 		debug_mutex_wake_waiter(lock, waiter);
 
+		task_climb_up_wake(waiter->task, lock, tailor->prio_rmin);
+
 		wake_up_process(waiter->task);
 	}
 
@@ -331,8 +358,12 @@ static inline int __mutex_trylock_slowpa
  */
 int fastcall __sched mutex_trylock(struct mutex *lock)
 {
-	return __mutex_fastpath_trylock(&lock->count,
-					__mutex_trylock_slowpath);
+	if (__mutex_fastpath_trylock(&lock->count, __mutex_trylock_slowpath)) {
+		task_push_prio_floor(&lock->floor);
+		return 1;
+	} else
+		return 0;
+	
 }
 
 EXPORT_SYMBOL(mutex_trylock);

