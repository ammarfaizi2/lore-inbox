Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUKMRgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUKMRgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 12:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUKMRgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 12:36:52 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:58246 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261846AbUKMRdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 12:33:06 -0500
From: Esben Nielsen <simlo@phys.au.dk>
Date: Sat, 13 Nov 2004 18:29:09 +0100
Message-Id: <200411131729.AA09315@da410.ifa.au.dk>
Subject: [PATCH] Real-Time Preemption, another mutex implementation.
Apparently-To: Bill Huey <bhuey@lnxw.com>
Apparently-To: linux-kernel@vger.kernel.org
Apparently-To: Ingo Molnar <mingo@elte.hu>
X-DAIMI-Spam-Score: -1.429 () ALL_TRUSTED,UNDISC_RECIPS
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I wanted to participate the in making Linux into a real-time system.
I figured that one of the building blocks missing was a mutex with priority 
inheritance. So I started to build a such as soon as Ingo's patch got stable 
enough for me to use on my labtop (-U9.2). 

Notice that this mutex implementation itself is not coupled too much to the 
real-time patch. It could be used upstream as it is as well. But the 
heavy usage of it ofcourse comes from the real-time patch.

Ingo have since implemented one a priority inheritance machanism. I have not
looked into it in much detail - I have had fun playing with my own :-) - but
I think that the algorithm I have used have some slight advantages in timing: 

Let us say each mutex has up to N waiters. Each task holds up to M muteces
and the maximum length of the dependency list ("task waits on a mutex 
which is owned by a task waiting on a mutex, which is owner by a task 
waiting on a mutex...") is L.

My implementation:
 Worst case time with spinlock held: O(N+M). Total time for locking a mutex
O(L*(N+M)). Worst case for releasing a mutex O(M) (with a spinlock held).

Ingo's: Time for giving a mutex to another: O(N*M) with spinlocks held!.

The main reason for this speedup is that I only keep the highest priority 
waiter on each mutex held by task on the list corresponding to 
task->pi_waiters and I keep the list sorted.

Furthermore, I can't see (without reading it too carefully) that Ingo's take
care of traversing the whole dependency list and boosting all the mutex owners
priority.

My implementation have a problem that RTOS people will not be happy about:
On a RTOS the time you have to wait for getting a mutex is worst case the
maximum time in which the mutex is locked by a task. In certain cases (SMB
or badly written real-time applications on UP) it is 2 times the maximum time 
a task can lock the mutex. It is still deterministic, though.

There is a full analyzes in a comment in the patch below.

Some people might argue that O(N+M) is not good enough when holding spinlocks -
especially if user space futexes shall also use this mechanism. Well, the 
queus can easily made into full scheduler wait-queues such it will be O(1). 
But the O(L) can never be avoided as far as I can see. Also notice: At leasst
one commercial RTOSs certified for safety critical applications also uses a 
sorted linked list in muteces. 

There is a still a lot to do:
1) Test that it really works. I have only tested that my UP labtop is stable.
I need to run some tests veryfying that the priority inheritance mechanism 
actually works.
2) I haven't tested it on a SMB system as I don't have any.
3) I traverse the dependency list with recursion, risking stack-overflow.
It needs to be changed to iteration.
4) Make sure it compiles and works with CONFIG_PRIORITY_MUTEX off :-)
5) Integrate it better into the kernel much, wrt. debugging etc. I don't know
the kernel internals - I am brand new to kernel coding - so I am not sure how
to do this. I do have a deadlock detection mechanism but it doesn't report
stuff very well.

But even though it is far from finshed I don't want to just sit on the work 
anymore. I think it is best to get the idea out.

Esben

diff -Naur linux-2.6.9-rc4-mm1-U9.2/arch/i386/Kconfig linux-2.6.9-rc4-mm1-U9.2-priom/arch/i386/Kconfig
--- linux-2.6.9-rc4-mm1-U9.2/arch/i386/Kconfig	2004-11-05 00:28:43.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/arch/i386/Kconfig	2004-11-13 10:08:44.000000000 +0100
@@ -586,6 +586,23 @@
 	  system.
 	  Say N if you are unsure.
 
+config PRIORITY_MUTEX
+	bool "Use priority based muteces"
+	default y
+	depends on PREEMPT_REALTIME
+	help
+          Use priority sorted mutexes with priority inheritance
+
+config MUTEX_DEADLOCK_DETECTION
+	bool "Try to detect deadlocks when taking muteces"
+	default n
+	depends on PRIORITY_MUTEX
+	help
+	  When a mutex is taken extra the taker runs checks wether the task
+          owning the mutex waits on a mutex and if the owner of this mutex
+          waits on a mutex etc. If it ends up with waiting on a mutex owned
+          by the current task we have a deadlock.
+
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/init_task.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/init_task.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/init_task.h	2004-11-05 00:28:44.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/init_task.h	2004-11-08 19:16:02.000000000 +0100
@@ -79,6 +79,11 @@
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
+	.muteces_held	= LIST_HEAD_INIT(tsk.muteces_held),	       	\
+        .mutex_waiters_lock = RAW_SPIN_LOCK_UNLOCKED,                   \
+	.mutex_waiters	= LIST_HEAD_INIT(tsk.mutex_waiters),	       	\
+        .waiting_on_mutex_lock = RAW_RW_LOCK_UNLOCKED,                  \
+        .waiting_on_mutex = NULL,                                       \
 	.time_slice	= HZ,						\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/list.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/list.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/list.h	2004-11-05 00:27:15.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/list.h	2004-10-28 15:02:36.000000000 +0200
@@ -492,6 +492,36 @@
 	for ((pos) = (pos)->next, prefetch((pos)->next); (pos) != (head); \
         	(pos) = rcu_dereference((pos)->next), prefetch((pos)->next))
 
+
+/**
+ * list_insert_sorted: Insert in a list by iterating from the beginning and 
+                insert your element when your condition say it is a good place.
+                Meant for having sorted lists.
+ * @elem        the &struct list_head to insert
+ * @head:	the head for your list.
+ * @member:     list-element in the list:
+ * @condition   the code you use to test wether a place is 
+                ok to elem before element "pos".
+ */
+#define list_insert_sorted(elem, head, member, condition) \
+	do { \
+		int found = 0; \
+		struct list_head *nhead = (head); \
+		typeof(*elem) *pos; \
+		list_for_each_entry(pos, nhead, member) { \
+			if(condition) { \
+				__list_add(&elem->member, pos->member.prev, \
+					   &pos->member); \
+				found = 1; \
+				break; \
+			} \
+		} \
+		if(!found) { \
+			list_add_tail(&elem->member, nhead); \
+		} \
+        } while(0); \
+
+
 /*
  * Double linked lists with a single pointer list head.
  * Mostly useful for hash tables where the two pointer list head is
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/mutex.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/mutex.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/mutex.h	2004-11-08 19:12:07.000000000 +0100
@@ -0,0 +1,30 @@
+#ifndef MUTEX_H
+#define MUTEX_H
+
+#include <linux/wait.h>
+
+typedef struct mutex_held
+{
+	struct task_struct *owner;
+	int times_taken;
+	int prev_prio;
+	struct list_head held_list;
+} mutex_held_t;
+
+typedef struct mutex
+{
+	int initialized;
+	mutex_held_t held;
+	wait_queue_head_t waiters;
+} mutex_t;
+
+extern void mutex_init(mutex_t *m);
+extern void mutex_lock(mutex_t *m);
+unsigned long mutex_lock_irqsave(mutex_t *mutex);
+void mutex_unlock_wait(mutex_t *mutex);
+extern int  mutex_trylock(mutex_t *m);
+extern void mutex_unlock(mutex_t *m);
+extern int mutex_is_locked(mutex_t *m);
+extern int atomic_dec_and_mutex_lock(atomic_t *atomic, mutex_t *mutex);
+
+#endif
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/realtime_lock.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/realtime_lock.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/realtime_lock.h	2004-11-05 00:28:44.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/realtime_lock.h	2004-10-28 08:11:25.000000000 +0200
@@ -94,13 +94,18 @@
 #endif
 
 #ifdef CONFIG_PREEMPT_REALTIME
-
+# ifdef CONFIG_PRIORITY_MUTEX
+#  include <linux/mutex.h>
+typedef mutex_t _mutex_t;
+# define SPIN_LOCK_UNLOCKED (mutex_t) { 0, }
+# else 
   typedef struct {
 	unsigned int initialized;
 	struct semaphore lock;
 	unsigned int break_lock;
   } _mutex_t;
-# define SPIN_LOCK_UNLOCKED (_mutex_t) { 0, }
+#  define SPIN_LOCK_UNLOCKED (_mutex_t) { 0, }
+# endif
 #else
   typedef raw_spinlock_t _mutex_t;
 # define SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/sched.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/sched.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/sched.h	2004-11-05 00:28:44.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/sched.h	2004-11-12 22:55:41.000000000 +0100
@@ -583,6 +583,29 @@
 	struct list_head run_list;
 	prio_array_t *array;
 
+#ifdef CONFIG_PRIORITY_MUTEX
+	int original_prio; /* Priority before getting the first mutex */
+
+	/* List of held muteces. Can only be manipulated and used
+	   by the task itself */
+	struct list_head muteces_held;
+
+	/* List of struct mutex_wait_elem (mutex.c). On this list is only
+	   the highest priority waiters. The list is sorted by priority.
+	   One must have the lock to manipulate the list. The lock is the
+	   inner-most lock, i.e. you can not take any other lock while holding
+	   this lock */
+	raw_spinlock_t mutex_waiters_lock;
+	struct list_head mutex_waiters;
+
+	/* This pointer is set/unset by the task itself while having a write
+	   lock. Others must use read lock while taking it.
+	   This write lock must be taken before the mutex lock */
+ 	struct mutex_wait_elem *waiting_on_mutex; 
+	raw_rwlock_t waiting_on_mutex_lock;
+#endif
+	
+
 	unsigned long sleep_avg;
 	long interactive_credit;
 	unsigned long long timestamp, last_ran;
@@ -1227,4 +1250,9 @@
 
 #endif /* __KERNEL__ */
 
+#ifdef CONFIG_PRIORITY_MUTEX
+extern void mutex_set_task_priority_up(task_t *p, int new_prio);
+extern void mutex_set_task_priority_back_down(int prev_prio);
+#endif
+
 #endif
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/spinlock.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/spinlock.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/spinlock.h	2004-11-05 00:28:44.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/spinlock.h	2004-10-25 23:05:35.000000000 +0200
@@ -417,6 +417,23 @@
 
 extern int __bad_spinlock_type(void);
 
+#ifdef CONFIG_PRIORITY_MUTEX
+#include <linux/mutex.h>
+#define _mutex_lock         mutex_lock
+#define _mutex_lock_bh      mutex_lock
+#define _mutex_lock_irq     mutex_lock
+#define _mutex_lock_irqsave mutex_lock_irqsave
+#define _mutex_lock_wait    mutex_lock_wait
+#define _mutex_unlock       mutex_unlock
+#define _mutex_unlock_wait  mutex_unlock_wait
+#define _mutex_unlock_bh    mutex_unlock
+#define _mutex_unlock_irq   mutex_unlock
+#define _mutex_unlock_irqrestore(m,f) mutex_unlock(m)
+#define _mutex_trylock      mutex_trylock
+#define _mutex_trylock_bh   mutex_trylock
+#define _mutex_is_locked    mutex_is_locked
+#define _mutex_lock_init    mutex_init
+#else /* CONFIG_PRIORITY_MUTEX */
 extern void _mutex_lock(_mutex_t *mutex);
 extern void _mutex_lock_bh(_mutex_t *mutex);
 extern void _mutex_lock_irq(_mutex_t *mutex);
@@ -431,6 +448,7 @@
 extern int _mutex_is_locked(_mutex_t *mutex);
 extern int atomic_dec_and_mutex_lock(atomic_t *atomic, _mutex_t *mutex);
 extern void _mutex_lock_init(_mutex_t *mutex);
+#endif /* CONFIG_PRIORITY_MUTEX */
 
 #define TYPE_EQUAL(lock, type) \
 		__builtin_types_compatible_p(typeof(lock), type *)
diff -Naur linux-2.6.9-rc4-mm1-U9.2/include/linux/wait.h linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/wait.h
--- linux-2.6.9-rc4-mm1-U9.2/include/linux/wait.h	2004-11-05 00:28:44.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/include/linux/wait.h	2004-10-28 08:08:55.000000000 +0200
@@ -292,6 +292,15 @@
 	__add_wait_queue_tail(q,  wait);
 }
 
+
+/*
+ * Insert your task into the list sorted by priority.
+ * Must be called with the spinlock in the wait_queue_head_t held.
+ */
+extern void add_wait_queue_sorted_exclusive_locked(wait_queue_head_t *q,
+						   wait_queue_t * wait);
+
+
 /*
  * Must be called with the spinlock in the wait_queue_head_t held.
  */
diff -Naur linux-2.6.9-rc4-mm1-U9.2/kernel/fork.c linux-2.6.9-rc4-mm1-U9.2-priom/kernel/fork.c
--- linux-2.6.9-rc4-mm1-U9.2/kernel/fork.c	2004-11-05 00:28:43.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/kernel/fork.c	2004-11-08 19:19:07.000000000 +0100
@@ -172,6 +172,14 @@
 	INIT_LIST_HEAD(&tsk->private_pages);
 	tsk->private_pages_count = 0;
 
+#ifdef CONFIG_PRIORITY_MUTEX
+	INIT_LIST_HEAD(&tsk->muteces_held);
+	tsk->mutex_waiters_lock = RAW_SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&tsk->mutex_waiters);
+	tsk->waiting_on_mutex_lock = RAW_RW_LOCK_UNLOCKED;
+	tsk->waiting_on_mutex = NULL;
+#endif
+
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	return tsk;
diff -Naur linux-2.6.9-rc4-mm1-U9.2/kernel/mutex.c linux-2.6.9-rc4-mm1-U9.2-priom/kernel/mutex.c
--- linux-2.6.9-rc4-mm1-U9.2/kernel/mutex.c	2004-11-05 00:28:43.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/kernel/mutex.c	2004-11-13 17:14:15.000000000 +0100
@@ -2,15 +2,813 @@
  * Real-Time Preemption support
  *
  * Copyright (c) 2004 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ * CONFIG_PRIORITY_MUTEX code added by Esben Nielsen <simlo@phys.au.dk>
  */
 
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <asm/bug.h>
 
 #ifdef CONFIG_PREEMPT_REALTIME
+#ifdef CONFIG_PRIORITY_MUTEX
 
+
+/* HOW THIS MUTEX WORKS:
+
+  Datastructures:
+   There are 3 structures at work
+    task_t
+    mutex_t
+    mutex_wait_elem_t
+
+
+   When a task wants to take a mutex it makes a mutex_wait_elem_t on it's
+   stack. This is used as element in the 2 following lists:
+
+    mutex->waiters.task_list:
+      The list of tasks waiting to get the mutex. This list is sorted, highest
+      priority (i.e. lowest task->prio) first.
+
+    task->mutex_waiters:
+      This is a list of tasks waiting to get a mutex which this tasks holds.
+      Only the _first_ waiter of each mutex is on this list. This list is
+      also sorted according to priority.
+
+   Each mutex have a pointer, mutex->held.owner, to the task holding/owning
+   the mutex. Whenever this is NULL a task is free to take the mutex. When
+   releasing a mutex the releasing owner sets it to NULL or the task first
+   on mutex->waiters.task_list and wakes that task up.
+
+   The tasks on the wait list have a pointer to the mutex_wait_elem_t 
+   representing them in the wait-queue, task->waiting_on_mutex. This is used
+   to follow depending waiters, increasing priority and to detect deadlocks.
+
+   Each task also have a list of muteces held, task->muteces_held. This isn't
+   really used for anything but is keeped in there so it can be used for 
+   debugging.
+
+  Locking:
+    Each mutex is only manipulated while holding it's spinlock, 
+    mutex->waiters.lock. Especially the owner and the wait list can only be
+    accessed while having this spinlock.
+    task->waiting_on_mutex is locked with a rw-lock, 
+    task->waiting_on_mutex_lock.
+    The list task->mutex_waiters is locked by the spinlock 
+    task->mutex_waiters_lock.
+
+    The locking hiracy is that you should first take 
+    task->waiting_on_mutex_lock then mutex->waiters.lock and last 
+    task->mutex_waiters_lock to avoid deadlocks. You can hold all 3 types 
+    of locks or just some of them. You should never hold more than 1 of each
+    kind, forinstance locking both mutex1->waiters.lock and 
+    mutex2->waiters.lock is asking for deadlocks.
+
+  Basic algorithm:
+   mutex_lock:
+     lock mutex->waiters.lock.
+     Is mutex->owner==NULL? 
+        Set mutex->owner = current 
+        unlock mutex->waiters.lock
+        return.
+  
+     Else, i.e. mutex->owner!=NULL
+       Unlock the mutex.
+       Lock the current tasks's waiting_on_mutex_lock. Lock the mutex again.
+       (Unlock, lock again to avoid deadlock).
+
+       Check again if the mutex is still locked.
+ 
+       Initialize mutex_wait_elem_t on the stack. Set
+       current->waiting_on_mutex to point to this element. Insert it into the
+       mutex' wait list. If it is first on the list lock the mutex' owner's
+       waiters lock and insert the wait element here as well. Remember to
+       remove the old head of the wait list representing on the 
+       owner->mutex_waiters wait list (there is only one wait element 
+       per mutex on that list.)
+
+       If the priority of current task has higher priority than mutex' owner
+       (that is very likely on UP systems) increase the owner's priority.
+
+       Unlock the mutex-lock and waiting_on_mutex_lock.
+
+       (The scheduler can now reschedule us out.)
+        
+       If the owner's priority was increased re-sort the waiting lists 
+       of the owner:
+          Take the mutex' owner's waiting_on_mutex_lock. If it is waiting
+          on a mutex lock that mutex, remove the waiting element 
+          (owner->waiting_on_mutex) from the wait lists and reinsert it at
+          the right spots in the lists. If the owner of this other mutex has 
+          lower priority increase it. Unlock the mutex and 
+          waiting_on_mutex_lock.
+          If the other mutex' owner's priority was increased repeat all this
+          for the new owner.
+       
+         
+       schedule(), i.e. wait for some other task to wake me up.
+
+       Lock waiting_on_mutex_lock. Lock mutex.
+       Set waiting_on_mutex=NULL
+       Set mutex' owner to current task. Insert the mutex in the held list.
+
+       Remove the wait element from the mutex's waiting list. 
+       If the list isn't empty:
+          Lock this task's waiting_on_mutex_lock
+          Insert the new head of the list into waiting_on_mutex.
+          Unock this task's waiting_on_mutex_lock
+
+       Unlock mutex.
+       Unlock waiting_on_mutex_lock
+
+    mutex_unlock:
+       Lock the mutex.
+       Lock this task's mutex_waiters_list_lock.
+
+       If there is a waiter on the mutex:
+          Remove the wait element from this task's mutex_waiters list.
+          Set the mutex's owner to the first waiter
+       Otherwise:
+          Set the mutex's owner to NULL.
+
+       Set the priority back to the original priority but not lower than
+       the priority of the first element of the mutex_waiters_list.
+
+       Unlock this task's mutex_waiters_list_lock.
+       Unlock the mutex lock.       
+
+
+  DOES THIS WORK?
+    There are 2 facts you have to notice:
+     a) Each task can only wait for one mutex.
+     b) A task unlocking a mutex can not be waiting on a mutex.
+     c) Waiting tasks can only get their priorities increased, never 
+        descreased.
+
+    First let us ignore the fact that rescheduling can take place before
+    the mutex-locker is finished sorting all the lists. Let us also ignore
+    that none-realtime tasks can be moved around in priority by the scheduler.
+
+    Clearly, whenever you try to take a mutex the owner and all those tasks
+    the owner waits on will be moved to at least your priority. All the lists
+    are sorted again.
+ 
+    When you unlock a mutex you are set down to the priority of the
+    highest priority waiter or your original priority. Notice due to b) there
+    is no lists to re-sort.
+
+    Now if we try to take into account that rescheduling can occur between 
+    setting the owner's priority and before the lists of the mutex on which
+    the owner is waiting on are resorted. Let us try to draw it:
+      current ->mutex1 -> owner  -> mutex2 -> owner2
+                          other1 ->
+                          other2 ->
+                          ...
+
+    Two bad things can happen in that timeslice:
+      1) Another task can start waiting on mutex2. The list is unsorted.
+         But as we insert from the beginning scanning until we find a task
+         with lower priority than otherX, otherX will be correctly inserted
+         even though  it can suddenly meet owner which has too high priority
+         relatively to where it is placed on the list.
+         When the resorting of owner kicks in later the list will be 
+         strictly sorted again.
+      2) Owner2 will unlock_mutex2. Now owner might not get it even though
+         it has highest priority! Other1 will thus take the place of owner2 in
+         the above drawing. This can keep happening until current gets 
+         mutex2's lock. 
+         The window in which this can happen is the task-latency of current
+         plus a few instructions. 
+         
+         On a UP RT system: You have to count in the task-latency anyway so no 
+         harm is really done! If current is the highest priority (real-time) 
+         task involved it will not be preempted by the others. There is thus
+         no problem.
+         In the case that owner2 originally has higher priority than current 
+         owner2 will get the CPU to release mutex2 to other1 rather than owner.
+         In that case current will get in and boost other1 as soon as owner2 
+         sleeps. I.e. you worst case waiting is increased by 1 worst locking 
+         time of mutex2 by this implementation. (Notice that this will only
+         happen in "bad" applications where owner2 sleeps while having the 
+         mutex!).
+
+         On a SMB system owner2 might run on another CPU. In that case it can
+         get to mutex_unlock() before current get the list resorted no
+         matter what the priority differences are. You thus get into the
+         same problem as just above. But your locking delay can never be
+         increased by more that 1 extra worst case locking of mutex2.
+
+
+    I thus claim this system works as well as various implementations on
+    existing RTOS. The only drawback is that the worst case time before getting
+    a mutex is not 1 times the worst case locking time but 2 times the
+    worst case locking time in "bad" applications on UP systems or on SMB
+    systems in general. 
+   
+  TIMING ANALYZED:
+    Let us say each mutex has up to N waiters. Each task holds up to M muteces
+    and the maximum length of the dependency list ("task waits on a mutex 
+    which is owned by a task waiting on a mutex, which is owner by a task 
+    waiting on a mutex...") is L.
+
+    Then locking a mutex takes
+     With the mutex spinlock locked:
+      O(N) to insert itself into the mutex's waiting list.
+      O(M) to insert into the owners mutex_waiters which can have M elements.
+     This repeats itself O(L) times as it recurses through the dependency list
+     but all spinlocks are unlocked between each.
+
+     I.e.: 
+      Maximum increase to the interrupt latency: O(N)+O(M).
+      Total time to take a mutex: O(L)*(O(N)+O(M))
+
+    Unlocking a mutex:
+      O(M) because the worst place is reinserting the next waiter into 
+     current task's mutex_waiters.
+    
+    If the application is behaving nicely, i.e. not blocking on anything but
+    muteces while holding a mutex, and we are on a UP system all O(N) and O(M) 
+    can be replaced by 1. This is because only the highest priority task can
+    get the CPU to ever call mutex_lock() and that will insert itself as 
+    the first on each list when it blocks on a mutex.
+    
+
+    Esben Nielsen
+    13. Nov 2004.
+*/
+
+
+#ifdef MUTEX_DEADLOCK_DETECTION
+#define CHECK_FOR_DEADLOCK 1
+#else
+#define CHECK_FOR_DEADLOCK 0
+#endif
+
+#define RECURSIVE_MUTEX
+/* #define CHECK_OWNERS_LIST */
+
+#define DEBUG_INIT             0x01
+#define DEBUG_QUEUE            0x02
+#define DEBUG_HELD_LIST        0x04
+#define DEBUG_HELD             0x08
+#define DEBUG_PRIOSET          0x10
+#define DEBUG_WAITER_LIST      0x20
+#define DEBUG_REORDER          0x40
+#define DEBUG_REORDER_OWNER    0x80
+
+
+#define DEBUG_FLAGS              (DEBUG_REORDER_OWNER)
+
+#define PRINT(level,fmt, args...) \
+        printk(level"%d:%s:%s:%s:%d: "fmt"\n", \
+               current->pid,current->comm, __FUNCTION__, \
+               __FILE__, __LINE__,##args)
+
+#define ERROR(fmt,args...) PRINT(KERN_ERR,fmt,##args)
+
+#define DEBUG(flag, fmt, args...) \
+do { \
+     if(flag & DEBUG_FLAGS) \
+          PRINT(KERN_INFO,fmt,##args); \
+} while(0)
+
+
+
+typedef struct mutex_wait_elem {
+	mutex_t *mutex;           /* Mutex this element points to */
+	wait_queue_t wait;        /* Node in the list of tasks waiting on this
+                                     mutex */
+	int on_owners_list;       /* is set if it is added to the owners list
+				     already */
+	struct list_head owners_list; /* For the list of mutex_waiters on
+					 the task_t */
+} mutex_wait_elem_t;
+
+#define DECLARE_MUTEX_WAIT(name, mutex, tsk) \
+        mutex_wait_elem_t name = \
+                  { mutex, __WAITQUEUE_INITIALIZER(name.wait, tsk), \
+                    0, { NULL,NULL} }
+
+static void mutex_held_init(mutex_held_t *mh)
+{
+	mh->owner = NULL;
+	mh->held_list.next = mh->held_list.prev = &mh->held_list;
+}
+
+/* Mark the mutex as being taken by the current task */
+static void mutex_held_take(mutex_held_t *m)
+{
+	task_t *tsk = get_current();
+
+	DEBUG(DEBUG_HELD, "mh: %p", m);
+
+	m->owner = tsk;
+	m->times_taken = 1;
+	m->prev_prio = tsk->prio;
+	if(list_empty(&tsk->muteces_held)) {
+		tsk->original_prio = tsk->prio;
+	}
+  	list_add(&m->held_list, &tsk->muteces_held);
+}
+
+static mutex_wait_elem_t *mutex_first_waiter(mutex_t *m)
+{
+	if(list_empty(&m->waiters.task_list)) {
+		return NULL;
+	}
+	else {
+		return list_entry(m->waiters.task_list.next,
+				  mutex_wait_elem_t,wait.task_list);
+	}
+}
+
+void mutex_init(mutex_t *m)
+{
+	DEBUG(DEBUG_INIT, "m=%p", m);
+	m->initialized = 1;
+	mutex_held_init(&m->held);
+	m->waiters.lock = RAW_SPIN_LOCK_UNLOCKED;
+	m->waiters.task_list.prev = m->waiters.task_list.next =
+		&m->waiters.task_list;
+}
+
+EXPORT_SYMBOL(mutex_init);
+
+/* Returns 1 if the task ought to schedule as soon as the spinlock is released
+   called with the spinlock locked.
+ */
+static int mutex_give(mutex_t *m)
+{
+	task_t *tsk = get_current();
+	int prev_prio;
+	unsigned long flags;
+	mutex_wait_elem_t *w;
+#ifdef CHECK_OWNERS_LIST
+	mutex_wait_elem_t *waits_on_this = NULL;
+#endif
+
+	DEBUG(DEBUG_HELD, "m: %p", m);
+
+	prev_prio = tsk->original_prio;
+	list_del(&m->held.held_list);
+
+	/* Find the first waiter for some _other_ mutex than this.
+	   Since only the first waiter of each mutex is on the list it is
+	   the 1st or 2nd on the list so this iteration is in fact
+	   very short :-) 
+	   We can not set the priority lower than the priority of that
+	   waiter.
+	*/
+	spin_lock_irqsave(&tsk->mutex_waiters_lock, flags);
+ 	list_for_each_entry(w, &tsk->mutex_waiters, owners_list) { 
+		WARN_ON(!w->on_owners_list);
+		DEBUG(DEBUG_WAITER_LIST,"w: %p",w);
+		if(w->mutex!=m) {
+			prev_prio = min(prev_prio,w->wait.task->prio);
+			/* No need to continue as the list is sorted */
+#ifndef CHECK_OWNERS_LIST
+			break;
+#else
+		}
+		else {
+			/* There is only one these on the list */
+			waits_on_this = w;		
+#endif
+		}
+	}
+
+#ifdef CHECK_OWNERS_LIST
+	DEBUG(DEBUG_WAITER_LIST,"w: %p, waits_on_this: %p",w, waits_on_this);
+#endif
+
+	w = mutex_first_waiter(m);
+#ifdef CHECK_OWNERS_LIST
+	if(waits_on_this) {
+		WARN_ON(w!=waits_on_this);
+		WARN_ON(!waits_on_this->on_owners_list);
+		/* Remove the first waiter of the mutex from this tasks waiter-list */
+		list_del(&waits_on_this->owners_list);
+		waits_on_this->on_owners_list = 0;
+	}
+	else {
+ 		WARN_ON(w);
+	}
+#else
+	if(w) {
+		list_del(&w->owners_list);
+		w->on_owners_list=0;
+	}
+#endif
+	spin_unlock_irqrestore(&tsk->mutex_waiters_lock, flags);
+
+	if(w) {
+		m->held.owner = w->wait.task;
+		wake_up_locked(&m->waiters, &flags);
+	}
+	else {	  
+		m->held.owner = NULL;
+	}
+	if(prev_prio>tsk->prio) {
+		mutex_set_task_priority_back_down(prev_prio);
+		return 1;
+	}
+	return 0;
+}
+
+static int mutex_is_uninitialized(mutex_t *m)
+{
+	return !m->initialized;
+}
+
+static task_t *get_mutex_owner(mutex_t *m)
+{
+	return m->held.owner;
+}
+
+static void mutex_take(mutex_t *m)
+{
+	mutex_held_take(&m->held);
+}
+
+static void mutex_insert_wait_queue(mutex_t *m, mutex_wait_elem_t *wait)
+{
+	mutex_wait_elem_t *prev_head = mutex_first_waiter(m);
+	task_t *owner = get_mutex_owner(m);
+
+	DEBUG(DEBUG_QUEUE,"wait: %p, prev_head: %p, owner: %s(%d)",
+	      wait, prev_head, owner->comm, owner->pid);
+
+	add_wait_queue_sorted_exclusive_locked(&m->waiters, 
+					       &wait->wait);
+
+	if(mutex_first_waiter(m) == wait && prev_head!=wait) {
+		int prio = wait->wait.task->prio;
+		if(likely(owner)) {
+			unsigned long flags;
+			spin_lock_irqsave(&owner->mutex_waiters_lock, flags);
+			if(prev_head) {
+				DEBUG(DEBUG_WAITER_LIST,"prev_head: %p",
+				      prev_head);
+				if(unlikely(!prev_head->on_owners_list)) {
+					if(prev_head->wait.task!=owner) {
+						DEBUG(-1, 
+						      "owner: %s(%d), "
+						      "prev_head: %p, "
+						      "m: %p, wait: %p, "
+						      "prev_head->task:%s(%d)",
+						      owner->comm, owner->pid,
+						      prev_head,m,wait,
+						      prev_head->wait.task->comm,
+						      prev_head->wait.task->pid);
+					}
+				}
+				else {
+					list_del(&prev_head->owners_list);
+					prev_head->on_owners_list = 0;
+				}
+			}
+			DEBUG(DEBUG_WAITER_LIST,"wait: %p, owner: %s(%d)",
+			      wait, owner->comm, owner->pid);
+			list_insert_sorted(wait, &owner->mutex_waiters, 
+					   owners_list,
+					   prio < pos->wait.task->prio);
+			wait->on_owners_list = 1;
+			spin_unlock_irqrestore(&owner->mutex_waiters_lock, 
+					       flags);
+		}
+		else {
+			WARN_ON(1);
+		}
+
+	}
+	else {
+		WARN_ON(!prev_head);
+		WARN_ON(prev_head==wait);
+		if(prev_head && owner) {
+			if(prev_head->wait.task==owner) {
+				/* The owner is going to take the mutex
+				   but this task got in and inserted itself
+				   on the wait - list. In this case
+				   prev_head is still on the list but
+				   ofcourse not on the owner's list */
+			}
+			else {
+				unsigned long flags;
+				int found = 0;
+				mutex_wait_elem_t *w;
+				spin_lock_irqsave(&owner->mutex_waiters_lock, flags);
+		
+				list_for_each_entry( w, &owner->mutex_waiters,
+						     owners_list) {
+					WARN_ON(!w->on_owners_list);
+					if(w==prev_head) {
+						found=1;
+						break;
+					}
+				}
+				WARN_ON(!found);
+				spin_unlock_irqrestore(&owner->mutex_waiters_lock, 
+						       flags);
+			}
+		}
+		else {
+			WARN_ON(1);
+		}
+	}
+}
+
+static void mutex_reorder_wait_list(task_t *tsk)
+{
+	mutex_wait_elem_t *wait;
+	task_t *owner;
+	int set_prio = 0;
+	unsigned long flags;
+	mutex_t *m;
+	
+	read_lock(&tsk->waiting_on_mutex_lock);
+	wait = tsk->waiting_on_mutex;
+	if(!wait) {
+		read_unlock(&tsk->waiting_on_mutex_lock);
+		return;
+	}
+		
+	m = wait->mutex;
+
+	spin_lock_irqsave(&m->waiters.lock, flags);
+	owner = get_mutex_owner(m);
+	if(unlikely(!owner)) {
+		ERROR("owner is NULL!");
+		goto out_unlock;
+	}
+
+	DEBUG(DEBUG_REORDER,"tsk: %s(%d), m: %p, owner: %s(%d), "
+	      "wait: %p, prio: %d",
+	      tsk->comm,tsk->pid, m, owner->comm, owner->pid, wait, tsk->prio);
+	
+	WARN_ON(tsk!=wait->wait.task);
+
+	if(unlikely(owner==tsk)) {
+		/* We already got the mutex! - no need to reorder */
+		DEBUG(DEBUG_REORDER_OWNER,"waiter %s(%d) "
+		      "already got the mutex", owner->comm, owner->pid);
+		goto out_unlock;
+	}
+	/* If it is first on the list there is no reason to do anything :-) */
+	if(wait!=mutex_first_waiter(m)) {
+		if(unlikely(wait->on_owners_list)) {
+			WARN_ON(1);
+			list_del(&wait->owners_list);
+			wait->on_owners_list = 0;
+		}
+	       
+		remove_wait_queue_locked(&m->waiters,&wait->wait);
+		/* mutex_insert_wait_queue() can also inserts into owner's
+		   mutex_waiters list. This only happens to elements first on
+		   mutex's wait list. As we weren't first on that list we wont
+		   get a double insert */
+		mutex_insert_wait_queue(m, wait);
+	}
+	else {
+		WARN_ON(!wait->on_owners_list);
+	}
+
+
+	/* Ups, we have current waiting on a mutex owned by (tsk which waits
+	   for a mutex owned by)+ owner - deadlock! */
+	if(unlikely((owner==current))) {
+		printk(KERN_CRIT "Deadlock detected! %s(%d) waits "
+		       "on itself!\n", current->comm, current->pid);
+		goto out_unlock;
+	}
+
+	set_prio = (owner->prio > tsk->prio);
+	if(CHECK_FOR_DEADLOCK || set_prio) {
+		get_task_struct(owner);
+		if(set_prio)
+			mutex_set_task_priority_up(owner, tsk->prio);
+	}
+
+	
+ out_unlock:
+	spin_unlock_irqrestore(&m->waiters.lock, flags);
+	_read_unlock(tsk->waiting_on_mutex_lock);
+	
+	if(CHECK_FOR_DEADLOCK || set_prio) {
+		mutex_reorder_wait_list(owner);
+		put_task_struct(owner);
+	}
+	
+
+}
+
+static void mutex_add_to_queue(mutex_t *m)
+{
+	unsigned long flags;
+	struct task_struct *tsk = current;
+	mutex_wait_elem_t *w;
+	DECLARE_MUTEX_WAIT(wait, m, tsk);
+	
+	DEBUG(DEBUG_QUEUE, "m: %p", m);
+
+	tsk->state = TASK_UNINTERRUPTIBLE;
+
+	_write_lock(tsk->waiting_on_mutex_lock);
+	spin_lock_irqsave(&m->waiters.lock,flags);
+
+	mutex_insert_wait_queue(m, &wait);
+	tsk->waiting_on_mutex = &wait;
+
+        /* How to tell the compiler the condition is likely the first time
+	   and unlikely the second time? */
+	while(get_mutex_owner(m) && get_mutex_owner(m)!=tsk) {
+		task_t *owner = get_mutex_owner(m);
+		int set_prio = (owner->prio > tsk->prio);
+		if(CHECK_FOR_DEADLOCK || set_prio) {
+			get_task_struct(owner);
+			mutex_set_task_priority_up(owner, tsk->prio);
+		}
+
+	  	spin_unlock_irqrestore(&m->waiters.lock, flags);
+		_write_unlock(tsk->waiting_on_mutex_lock);
+
+		if(CHECK_FOR_DEADLOCK || set_prio) {		
+			mutex_reorder_wait_list(owner);
+			put_task_struct(owner);
+		}
+
+		schedule();
+
+		_write_lock(tsk->waiting_on_mutex_lock);
+		spin_lock_irqsave(&m->waiters.lock,flags);
+
+		DEBUG(DEBUG_QUEUE, "m: %p, owner: %s",
+		      m,get_mutex_owner(m)->comm);
+	} 
+	
+	tsk->waiting_on_mutex = NULL;
+
+	mutex_take(m);
+	remove_wait_queue_locked(&m->waiters, &wait.wait);
+	w = mutex_first_waiter(m);
+	if(w && !w->on_owners_list) {
+		/* There is a room such it could have been added
+		   already! */
+		unsigned long flags;
+		int prio = w->wait.task->prio;
+		spin_lock_irqsave(&tsk->mutex_waiters_lock, flags);
+		list_insert_sorted(w,
+				   &tsk->mutex_waiters, 
+				   owners_list,
+				   prio < pos->wait.task->prio);
+		w->on_owners_list = 1;
+		spin_unlock_irqrestore(&tsk->mutex_waiters_lock, flags);
+	}
+	  
+
+	tsk->state = TASK_RUNNING;
+  	spin_unlock_irqrestore(&m->waiters.lock,flags);
+	_write_unlock(tsk->waiting_on_mutex_lock);
+	DEBUG(DEBUG_QUEUE, "m: %p, owner: %s",
+	      m,get_mutex_owner(m)->comm);
+}
+
+void mutex_lock(mutex_t *m)
+{
+	unsigned long flags;
+
+	if(unlikely(mutex_is_uninitialized(m)))
+		mutex_init(m);
+	   
+	might_sleep();
+	spin_lock_irqsave(&m->waiters.lock,flags);
+	if(likely(!get_mutex_owner(m)))	{
+		mutex_take(m);
+		spin_unlock_irqrestore(&m->waiters.lock,flags);
+		return;
+	}
+
+	if(unlikely(get_current()==get_mutex_owner(m))) {
+#ifdef RECURSIVE_MUTEX
+		m->held.times_taken++;
+#else
+		WARN_ON(1);
+#endif
+		spin_unlock_irqrestore(&m->waiters.lock,flags);
+		return;
+	}
+	spin_unlock_irqrestore(&m->waiters.lock,flags);
+	mutex_add_to_queue(m);
+}
+
+EXPORT_SYMBOL(mutex_lock);
+
+int mutex_trylock(mutex_t *m)
+{
+	unsigned long flags;
+
+	if(unlikely(mutex_is_uninitialized(m)))
+		mutex_init(m);
+	   
+	spin_lock_irqsave(&m->waiters.lock,flags);
+	if(likely(!get_mutex_owner(m)))
+	{
+		mutex_take(m);
+		spin_unlock_irqrestore(&m->waiters.lock,flags);
+		return 1;
+	}
+
+	spin_unlock_irqrestore(&m->waiters.lock,flags);
+	return 0;
+}
+EXPORT_SYMBOL(mutex_trylock);
+
+unsigned long mutex_lock_irqsave(mutex_t *mutex)
+{
+	unsigned long flags;
+
+	mutex_lock(mutex);
+	local_save_flags(flags);
+
+	return flags;
+}
+
+EXPORT_SYMBOL(mutex_lock_irqsave);
+
+void mutex_unlock(mutex_t *m)
+{
+	unsigned long flags;
+	int do_sched;
+
+	BUG_ON(mutex_is_uninitialized(m));
+
+	spin_lock_irqsave(&m->waiters.lock, flags);
+
+	if(unlikely(get_mutex_owner(m)!=get_current())) {
+		DEBUG(DEBUG_QUEUE, 
+		      "m=%p, owner: %s",
+		      m, get_mutex_owner(m)->comm);
+		WARN_ON(1);
+		spin_unlock_irqrestore(&m->waiters.lock, flags);
+		return;
+	}
+
+#ifdef RECURSIVE_MUTEX
+	if((--(m->held.times_taken))>0) {
+		spin_unlock_irqrestore(&m->waiters.lock, flags);
+		return;
+	}
+#endif
+
+	do_sched = mutex_give(m);
+	spin_unlock_irqrestore(&m->waiters.lock, flags);
+}
+
+EXPORT_SYMBOL(mutex_unlock);
+
+void mutex_unlock_wait(mutex_t *m)
+{
+	BUG_ON(mutex_is_uninitialized(m));
+	do {
+		barrier();
+	} while (mutex_is_locked(m));
+}
+
+EXPORT_SYMBOL(mutex_unlock_wait);
+
+int mutex_is_locked(mutex_t *m)
+{
+	int res;
+	unsigned long flags;
+	
+	if(unlikely(mutex_is_uninitialized(m)))
+		mutex_init(m);
+
+	spin_lock_irqsave(&m->waiters.lock, flags);
+
+	res = (get_mutex_owner(m)!=NULL);
+	
+	spin_unlock_irqrestore(&m->waiters.lock, flags);
+
+	return res;
+}
+
+EXPORT_SYMBOL(mutex_is_locked);
+
+int atomic_dec_and_mutex_lock(atomic_t *atomic, mutex_t *mutex)
+{
+	might_sleep();
+	mutex_lock(mutex);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	mutex_unlock(mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(atomic_dec_and_mutex_lock);
+
+#else /* CONFIG_PRIO_MUTEX */
 static void mutex_initialize(_mutex_t *mutex)
 {
 	if (!mutex->initialized) {
@@ -143,6 +941,7 @@
 
 EXPORT_SYMBOL(_mutex_lock_init);
 
+#endif /* CONFIG_PRIO_MUTEX */
 
 
 static void rw_mutex_initialize(rw_mutex_t *rw_mutex)
@@ -304,7 +1103,7 @@
 
 EXPORT_SYMBOL(_rw_mutex_is_locked);
 
-#else
+#else /* CONFIG_PREEMPT_REALTIME */
 void _mutex_lock(_mutex_t *mutex)
 {
 	_spin_lock(mutex);
@@ -395,5 +1194,4 @@
 }
 
 EXPORT_SYMBOL(_mutex_lock_init);
-
 #endif
diff -Naur linux-2.6.9-rc4-mm1-U9.2/kernel/mutex.c.bak linux-2.6.9-rc4-mm1-U9.2-priom/kernel/mutex.c.bak
--- linux-2.6.9-rc4-mm1-U9.2/kernel/mutex.c.bak	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/kernel/mutex.c.bak	2004-10-27 20:20:47.000000000 +0200
@@ -0,0 +1,640 @@
+/*
+ * Real-Time Preemption support
+ *
+ * Copyright (c) 2004 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <asm/bug.h>
+
+#ifdef CONFIG_PREEMPT_REALTIME
+#ifdef CONFIG_PRIORITY_MUTEX
+
+#define DEBUG(fmt, args...) /* printk("%s:%s:%d: "fmt"\n", __FUNCTION__, __FILE__, __LINE__, ##args) */
+
+void mutex_init(mutex_t *m)
+{
+	DEBUG("m=%p", m);
+	m->owner = NULL;
+	m->prev_prio = 1;
+	m->waiters.lock = RAW_SPIN_LOCK_UNLOCKED;
+	m->waiters.task_list.prev = m->waiters.task_list.next =
+		&m->waiters.task_list;
+}
+
+EXPORT_SYMBOL(mutex_init);
+
+static void mutex_take(mutex_t *m)
+{
+	m->owner = get_current();
+	m->prev_prio = get_current()->prio; 
+}
+
+/**
+ * list_insert_sorted	-	iterate over a list
+ * @elem        the &struct list_head to insert
+ * @head:	the head for your list.
+ * @condition(pos) the code you use to test wether a place is 
+                ok to elem before pos
+ */
+#define list_insert_sorted(elem, head, member, condition) \
+        do { \
+              int found = 0; \
+              struct list_head *nhead = (head); \
+              typeof(*elem) *pos; \
+              list_for_each_entry(pos, nhead, member) { \
+                      DEBUG("elem: %p, pos: %p", elem, pos); \
+		      if(condition) { \
+			      __list_add(&elem->member, pos->member.prev, &pos->member); \
+			      found = 1; \
+			      break; \
+		      } \
+              } \
+              if(!found) { \
+		      DEBUG("Not found: elem: %p",elem); \
+		      list_add_tail(nhead, &elem->member); \
+              } \
+        } while(0)
+
+void tmp_list_add_sorted(wait_queue_t *elem, struct list_head *head)
+{
+#define member task_list
+	do {
+		int found = 0; 
+		struct list_head *nhead = (head); 
+		typeof(*elem) *pos;
+		list_for_each_entry(pos, nhead, member) { 
+			DEBUG("elem: %p, pos: %p", elem, pos);
+			if(elem->task->static_prio < pos->task->static_prio) {
+				__list_add(&elem->member, pos->member.prev, 
+					   &pos->member);
+				found = 1;
+				break; 
+			}
+		}
+		if(!found) {
+			DEBUG("Not found: elem: %p",elem);
+			list_add_tail(&elem->member, nhead);
+		}
+        } while(0);
+#undef member
+}
+
+static inline void add_wait_queue_sorted_exclusive_locked(wait_queue_head_t *q,
+							  wait_queue_t * wait)
+{
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+ 	tmp_list_add_sorted(wait, &q->task_list); 
+/* 	__list_add(&wait->task_list, q->task_list.prev, &q->task_list); */
+/* 	list_insert_sorted(wait, &q->task_list, task_list, */
+/* 			   pos->task->static_prio > wait->task->static_prio); */
+}
+
+static void mutex_add_to_queue(mutex_t *m, unsigned long flags)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	DEBUG("tsk: %p", tsk);
+
+	tsk->state = TASK_UNINTERRUPTIBLE;
+	add_wait_queue_sorted_exclusive_locked(&m->waiters, &wait);
+	do {
+		DEBUG("m: %p, tsk: %p, owner: %p", m,tsk,m->owner);
+	  	spin_unlock_irqrestore(&m->waiters.lock, flags);
+		schedule();
+		spin_lock_irqsave(&m->waiters.lock,flags);
+		DEBUG("m: %p, tsk: %p, owner: %p", m,tsk,m->owner);
+	} while(unlikely(m->owner));
+	mutex_take(m);
+	remove_wait_queue_locked(&m->waiters, &wait);
+	wake_up_locked(&m->waiters, &flags); 
+  	spin_unlock_irqrestore(&m->waiters.lock,flags);
+	DEBUG("m: %p, tsk: %p, owner: %p", m,tsk,m->owner);
+	tsk->state = TASK_RUNNING;
+}
+
+void mutex_lock(mutex_t *m)
+{
+	unsigned long flags;
+	if(unlikely(m->prev_prio == -1))
+		mutex_init(m);
+	   
+	might_sleep();
+	spin_lock_irqsave(&m->waiters.lock,flags);
+	if(likely(!m->owner))
+	{
+		mutex_take(m);
+		spin_unlock_irqrestore(&m->waiters.lock,flags);
+		return;
+	}
+
+	if(unlikely(get_current()==m->owner))
+	{
+		WARN_ON(1);
+		spin_unlock_irqrestore(&m->waiters.lock,flags);
+		return;
+	}
+
+	mutex_add_to_queue(m, flags);
+}
+
+EXPORT_SYMBOL(mutex_lock);
+
+int mutex_trylock(mutex_t *m)
+{
+	unsigned long flags;
+
+	if(unlikely(m->prev_prio == -1))
+		mutex_init(m);
+	   
+	spin_lock_irqsave(&m->waiters.lock,flags);
+	if(likely(!m->owner))
+	{
+		mutex_take(m);
+		spin_unlock_irqrestore(&m->waiters.lock,flags);
+		return 1;
+	}
+
+	spin_unlock_irqrestore(&m->waiters.lock,flags);
+	return 0;
+}
+EXPORT_SYMBOL(mutex_trylock);
+
+unsigned long mutex_lock_irqsave(mutex_t *mutex)
+{
+	unsigned long flags;
+
+	mutex_lock(mutex);
+	local_save_flags(flags);
+
+	return flags;
+}
+
+EXPORT_SYMBOL(mutex_lock_irqsave);
+
+static void mutex_wake_next(mutex_t *m, unsigned long flags)
+{
+	DEBUG("m: %p, current: %p, owner: %p", m,current,m->owner);
+	wake_up_locked(&m->waiters, &flags);
+	spin_unlock_irqrestore(&m->waiters.lock, flags);
+}
+
+void mutex_unlock(mutex_t *m)
+{
+	unsigned long flags;
+
+	BUG_ON(m->prev_prio==-1);
+
+	spin_lock_irqsave(&m->waiters.lock, flags);
+
+	if(unlikely(m->owner!=get_current())) {
+		DEBUG("m=%p, m->owner=%p, current=%p",m, m->owner, get_current());
+		WARN_ON(1);
+		spin_unlock_irqrestore(&m->waiters.lock, flags);
+		return;
+	}
+
+	m->owner = NULL;
+	if(likely(list_empty(&m->waiters.task_list))) {
+		spin_unlock_irqrestore(&m->waiters.lock, flags);
+		return;
+	}
+    
+	mutex_wake_next(m, flags);
+}
+
+EXPORT_SYMBOL(mutex_unlock);
+
+void mutex_unlock_wait(mutex_t *m)
+{
+	BUG_ON(m->prev_prio==-1);
+	do {
+		barrier();
+	} while (mutex_is_locked(m));
+}
+
+EXPORT_SYMBOL(mutex_unlock_wait);
+
+int mutex_is_locked(mutex_t *m)
+{
+	int res;
+	unsigned long flags;
+	
+	if(unlikely(m->prev_prio==-1))
+		mutex_init(m);
+
+	spin_lock_irqsave(&m->waiters.lock, flags);
+
+	res = (m->owner!=NULL);
+	
+	spin_unlock_irqrestore(&m->waiters.lock, flags);
+
+	return res;
+}
+
+EXPORT_SYMBOL(mutex_is_locked);
+
+int atomic_dec_and_mutex_lock(atomic_t *atomic, mutex_t *mutex)
+{
+	might_sleep();
+	mutex_lock(mutex);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	mutex_unlock(mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(atomic_dec_and_mutex_lock);
+
+#else /* CONFIG_PRIO_MUTEX */
+static void mutex_initialize(_mutex_t *mutex)
+{
+	if (!mutex->initialized) {
+		mutex->initialized = 1;
+		init_MUTEX(&mutex->lock);
+//		WARN_ON(1);
+	}
+}
+
+void _mutex_lock(_mutex_t *mutex)
+{
+	might_sleep();
+	mutex_initialize(mutex);
+	down(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_lock);
+
+void _mutex_lock_bh(_mutex_t *mutex)
+{
+	_mutex_lock(mutex);
+//	local_bh_disable();
+}
+
+EXPORT_SYMBOL(_mutex_lock_bh);
+
+void _mutex_lock_irq(_mutex_t *mutex)
+{
+	_mutex_lock(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_lock_irq);
+
+unsigned long _mutex_lock_irqsave(_mutex_t *mutex)
+{
+	unsigned long flags;
+
+	_mutex_lock(mutex);
+	local_save_flags(flags);
+
+	return flags;
+}
+
+EXPORT_SYMBOL(_mutex_lock_irqsave);
+
+void _mutex_unlock(_mutex_t *mutex)
+{
+	if (!mutex->initialized) {
+		mutex_initialize(mutex);
+		WARN_ON(1);
+	};
+	up(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_unlock);
+
+void _mutex_unlock_wait(_mutex_t *mutex)
+{
+	BUG_ON(!mutex->initialized);
+	do {
+		barrier();
+	} while (_mutex_is_locked(mutex));
+}
+
+EXPORT_SYMBOL(_mutex_unlock_wait);
+
+void _mutex_unlock_bh(_mutex_t *mutex)
+{
+	BUG_ON(!mutex->initialized);
+	up(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_bh);
+
+void _mutex_unlock_irq(_mutex_t *mutex)
+{
+	BUG_ON(!mutex->initialized);
+	up(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_irq);
+
+void _mutex_unlock_irqrestore(_mutex_t *mutex, unsigned long flags)
+{
+	BUG_ON(!mutex->initialized);
+	up(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_irqrestore);
+
+int _mutex_trylock(_mutex_t *mutex)
+{
+	mutex_initialize(mutex);
+	return !down_trylock(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_trylock);
+
+int _mutex_trylock_bh(_mutex_t *mutex)
+{
+	return _mutex_trylock(mutex);
+}
+EXPORT_SYMBOL(_mutex_trylock_bh);
+
+int _mutex_is_locked(_mutex_t *mutex)
+{
+	return sem_is_locked(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_is_locked);
+
+int atomic_dec_and_mutex_lock(atomic_t *atomic, _mutex_t *mutex)
+{
+	might_sleep();
+	_mutex_lock(mutex);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	_mutex_unlock(mutex);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(atomic_dec_and_mutex_lock);
+
+void _mutex_lock_init(_mutex_t *mutex)
+{
+	mutex->initialized = 1;
+	init_MUTEX(&mutex->lock);
+}
+
+EXPORT_SYMBOL(_mutex_lock_init);
+
+#endif /* CONFIG_PRIO_MUTEX */
+
+
+static void rw_mutex_initialize(rw_mutex_t *rw_mutex)
+{
+	if (!rw_mutex->initialized) {
+		rw_mutex->initialized = 1;
+		init_rwsem(&rw_mutex->lock);
+//		WARN_ON(1);
+	}
+}
+
+int _rw_mutex_read_trylock(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	return down_read_trylock(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_trylock);
+
+int _rw_mutex_write_trylock(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	return down_write_trylock(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_trylock);
+
+void _rw_mutex_write_lock(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	down_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_lock);
+
+void _rw_mutex_read_lock(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	down_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_lock);
+
+void _rw_mutex_write_unlock(rw_mutex_t *rw_mutex)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_unlock);
+
+void _rw_mutex_read_unlock(rw_mutex_t *rw_mutex)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_unlock);
+
+unsigned long _rw_mutex_write_lock_irqsave(rw_mutex_t *rw_mutex)
+{
+	unsigned long flags;
+
+	rw_mutex_initialize(rw_mutex);
+	down_write(&rw_mutex->lock);
+
+	local_save_flags(flags);
+	return flags;
+}
+EXPORT_SYMBOL(_rw_mutex_write_lock_irqsave);
+
+unsigned long _rw_mutex_read_lock_irqsave(rw_mutex_t *rw_mutex)
+{
+	unsigned long flags;
+
+	rw_mutex_initialize(rw_mutex);
+	down_read(&rw_mutex->lock);
+
+	local_save_flags(flags);
+	return flags;
+}
+EXPORT_SYMBOL(_rw_mutex_read_lock_irqsave);
+
+void _rw_mutex_write_lock_irq(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	down_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_lock_irq);
+
+void _rw_mutex_read_lock_irq(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	down_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_lock_irq);
+
+void _rw_mutex_write_lock_bh(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	down_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_lock_bh);
+
+void _rw_mutex_read_lock_bh(rw_mutex_t *rw_mutex)
+{
+	rw_mutex_initialize(rw_mutex);
+	down_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_lock_bh);
+
+void _rw_mutex_write_unlock_irq(rw_mutex_t *rw_mutex)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_unlock_irq);
+
+void _rw_mutex_read_unlock_irq(rw_mutex_t *rw_mutex)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_unlock_irq);
+
+void _rw_mutex_write_unlock_bh(rw_mutex_t *rw_mutex)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_unlock_bh);
+
+void _rw_mutex_read_unlock_bh(rw_mutex_t *rw_mutex)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_unlock_bh);
+
+void _rw_mutex_write_unlock_irqrestore(rw_mutex_t *rw_mutex, unsigned long flags)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_write(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_write_unlock_irqrestore);
+
+void _rw_mutex_read_unlock_irqrestore(rw_mutex_t *rw_mutex, unsigned long flags)
+{
+	BUG_ON(!rw_mutex->initialized);
+	up_read(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_read_unlock_irqrestore);
+
+void _rw_mutex_init(rw_mutex_t *rw_mutex)
+{
+	rw_mutex->initialized = 1;
+	init_rwsem(&rw_mutex->lock);
+}
+EXPORT_SYMBOL(_rw_mutex_init);
+
+int _rw_mutex_is_locked(rw_mutex_t *rw_mutex)
+{
+	return rwsem_is_locked(&rw_mutex->lock);
+}
+
+EXPORT_SYMBOL(_rw_mutex_is_locked);
+
+#else /* CONFIG_PREEMPT_REALTIME */
+void _mutex_lock(_mutex_t *mutex)
+{
+	_spin_lock(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_lock);
+
+void _mutex_lock_bh(_mutex_t *mutex)
+{
+	_spin_lock_bh(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_lock_bh);
+
+void _mutex_lock_irq(_mutex_t *mutex)
+{
+	_spin_lock_irq(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_lock_irq);
+
+unsigned long _mutex_lock_irqsave(_mutex_t *mutex)
+{
+	return _spin_lock_irqsave(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_lock_irqsave);
+
+void _mutex_unlock(_mutex_t *mutex)
+{
+	_spin_unlock(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_unlock);
+
+void _mutex_unlock_wait(_mutex_t *mutex)
+{
+	_spin_unlock_wait(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_wait);
+
+void _mutex_unlock_bh(_mutex_t *mutex)
+{
+	_spin_unlock_bh(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_bh);
+
+void _mutex_unlock_irq(_mutex_t *mutex)
+{
+	_spin_unlock_irq(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_irq);
+
+void _mutex_unlock_irqrestore(_mutex_t *mutex, unsigned long flags)
+{
+	_spin_unlock_irqrestore(mutex, flags);
+}
+
+EXPORT_SYMBOL(_mutex_unlock_irqrestore);
+
+int _mutex_trylock(_mutex_t *mutex)
+{
+	return _spin_trylock(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_trylock);
+
+int _mutex_is_locked(_mutex_t *mutex)
+{
+	return _spin_is_locked(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_is_locked);
+
+int atomic_dec_and_mutex_lock(atomic_t *atomic, _mutex_t *mutex)
+{
+	return _atomic_dec_and_spin_lock(atomic, mutex);
+}
+
+EXPORT_SYMBOL(atomic_dec_and_mutex_lock);
+
+void _mutex_lock_init(_mutex_t *mutex)
+{
+	_spin_lock_init(mutex);
+}
+
+EXPORT_SYMBOL(_mutex_lock_init);
+#endif
diff -Naur linux-2.6.9-rc4-mm1-U9.2/kernel/sched.c linux-2.6.9-rc4-mm1-U9.2-priom/kernel/sched.c
--- linux-2.6.9-rc4-mm1-U9.2/kernel/sched.c	2004-11-05 00:28:43.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/kernel/sched.c	2004-11-06 20:00:36.000000000 +0100
@@ -606,6 +606,7 @@
 	if (rt_task(p))
 		return p->prio;
 
+
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
@@ -613,6 +614,14 @@
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
+
+#ifdef CONFIG_PRIORITY_MUTEX
+	/* Do not decrease priority while muteces are held 
+	   Increasing is good as it let the task release the mutex faster */
+	if( unlikely(!list_empty(&p->muteces_held)) &&  prio > p->prio )
+		prio = p->prio;
+#endif
+
 	return prio;
 }
 
@@ -3678,6 +3687,100 @@
 	return retval;
 }
 
+#ifdef CONFIG_PRIORITY_MUTEX
+
+/**
+ * Used by mutex.c's priority inheritance mechanism to
+ * boost the priority of the current owner of a mutex.
+ */
+void mutex_set_task_priority_up(task_t *p, int new_prio) 
+{
+	int oldprio;
+	prio_array_t *array;
+	unsigned long flags;
+	runqueue_t *rq;
+	
+	/*
+	 * We play safe to avoid deadlocks.
+	 */
+/* 	read_lock_irq(&tasklist_lock); */
+	
+	/*
+	 * To be able to change p->policy safely, the apropriate
+	 * runqueue lock must be held.
+	 */
+	rq = task_rq_lock(p, &flags);
+	
+	if(unlikely(p->prio < new_prio))
+		/* It already has the higher priority! */
+		/* unlikely on UP because then how should current be scheduled
+		   in ?? */
+		goto out_unlock;
+	
+	array = p->array;
+	if (array)
+		deactivate_task(p, task_rq(p));
+	oldprio = p->prio;
+	
+	p->prio = new_prio;
+	
+	if (array) {
+		__activate_task(p, task_rq(p));
+		/*
+		 * Reschedule if we are currently running on this runqueue and
+		 * our priority decreased, or if we are not currently running on
+		 * this runqueue and our priority is higher than the current's
+		 */
+		/* We know we increase the priority of p so there is no need
+		   to check that we decreasen the priority */
+		if (TASK_PREEMPTS_CURR(p, rq))
+			resched_task(rq->curr);
+	}
+
+ out_unlock:
+	task_rq_unlock(rq, &flags);
+/* 	read_unlock_irq(&tasklist_lock); */
+}
+
+/**
+ * Used by mutex.c's priority inheritance mechanism to
+ * boost the priority of the current owner of a mutex.
+ */
+void mutex_set_task_priority_back_down(int prev_prio)
+{
+	prio_array_t *array;
+	unsigned long flags;
+	runqueue_t *rq;
+	task_t *p = current; /* This happens to the current task */
+	/*
+	 * We play safe to avoid deadlocks.
+	 */
+	/* 	read_lock_irq(&tasklist_lock); */
+	
+	rq = task_rq_lock(p, &flags);
+		
+	array = p->array;
+	if (likely(array))
+		deactivate_task(p, task_rq(p));
+	else
+		WARN_ON(1); /* We ARE running so this shouldn't happen! */
+
+	p->prio = prev_prio;
+	
+	if (array) {
+		__activate_task(p, task_rq(p));
+
+		/* We know we have decreases the priority of p so we might not
+		   be first on the run-queue anymore */		
+		resched_task(rq->curr);
+	}
+
+	task_rq_unlock(rq, &flags);
+/* 	read_unlock_irq(&tasklist_lock); */
+}
+
+#endif
+
 long sched_setaffinity(pid_t pid, cpumask_t new_mask)
 {
 	task_t *p;
diff -Naur linux-2.6.9-rc4-mm1-U9.2/kernel/wait.c linux-2.6.9-rc4-mm1-U9.2-priom/kernel/wait.c
--- linux-2.6.9-rc4-mm1-U9.2/kernel/wait.c	2004-11-05 00:28:13.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/kernel/wait.c	2004-11-02 11:30:50.000000000 +0100
@@ -33,6 +33,15 @@
 }
 EXPORT_SYMBOL(add_wait_queue_exclusive);
 
+void add_wait_queue_sorted_exclusive_locked(wait_queue_head_t *q,
+							  wait_queue_t * wait)
+{
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	list_insert_sorted(wait, &q->task_list, task_list,
+			   wait->task->prio < pos->task->prio);
+}
+EXPORT_SYMBOL(add_wait_queue_sorted_exclusive_locked);
+
 void fastcall remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
 	unsigned long flags;
diff -Naur linux-2.6.9-rc4-mm1-U9.2/Makefile linux-2.6.9-rc4-mm1-U9.2-priom/Makefile
--- linux-2.6.9-rc4-mm1-U9.2/Makefile	2004-11-05 00:28:44.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/Makefile	2004-10-22 18:29:41.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 9
-EXTRAVERSION = -rc4-mm1-RT-U9.1
+EXTRAVERSION = -rc4-mm1-RT-U9.2-priom
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*
diff -Naur linux-2.6.9-rc4-mm1-U9.2/usr/Makefile linux-2.6.9-rc4-mm1-U9.2-priom/usr/Makefile
--- linux-2.6.9-rc4-mm1-U9.2/usr/Makefile	2004-11-05 00:28:13.000000000 +0100
+++ linux-2.6.9-rc4-mm1-U9.2-priom/usr/Makefile	2004-11-12 17:50:44.000000000 +0100
@@ -27,7 +27,7 @@
       cmd_gen_list = $(shell \
         if test -f $(CONFIG_INITRAMFS_SOURCE); then \
 	  if [ $(CONFIG_INITRAMFS_SOURCE) != $@ ]; then \
-	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
+	    echo 'cp -f -p $(CONFIG_INITRAMFS_SOURCE) $@'; \
 	  else \
 	    echo 'echo Using shipped $@'; \
 	  fi; \
@@ -35,6 +35,7 @@
 	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
 	else \
 	  echo 'echo Using shipped $@'; \
+          cp -f -p $(KBUILD_SRC)/usr/initramfs_list ./usr/; \
 	fi)
 
 
