Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVHAVkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVHAVkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVHAViY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:38:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58353 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261220AbVHAVgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:36:32 -0400
Subject: wakeup race checking for RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, rostedt@goodmis.org
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 01 Aug 2005 14:36:29 -0700
Message-Id: <1122932189.4623.25.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the interest of CC'ing everyone here's another patch .

This checks for wake_up_process() calls inside was preempt off sections.
So if it was a spinlock , and you call wake_up_process() it will trigger
a warning.. These are problematic cause in RT the wake_up_process() (if
it's an RT task) will cause a context switch immediately , but with out
RT you don't context switch till you unlock the last spinlock ..

There is also some checking on lock_depth , includes all types of locks
that are not rt_mutex types. I noticed that my test system went to lock
depth ~17 !

Daniel

Index: linux-2.6.12/include/linux/init_task.h
===================================================================
--- linux-2.6.12.orig/include/linux/init_task.h	2005-07-31 19:19:42.000000000 +0000
+++ linux-2.6.12/include/linux/init_task.h	2005-07-31 19:23:53.000000000 +0000
@@ -63,6 +63,12 @@
 
 extern struct group_info init_groups;
 
+#ifdef CONFIG_DEBUG_PREEMPT
+# define INIT_LOCK_COUNT(x)	.lock_count	= x,
+#else
+# define INIT_LOCK_COUNT(x)
+#endif
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -74,6 +80,7 @@ extern struct group_info init_groups;
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
+	INIT_LOCK_COUNT(0)						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.normal_prio	= MAX_PRIO-20,					\
Index: linux-2.6.12/include/linux/rt_lock.h
===================================================================
--- linux-2.6.12.orig/include/linux/rt_lock.h	2005-07-31 19:19:42.000000000 +0000
+++ linux-2.6.12/include/linux/rt_lock.h	2005-07-31 19:23:53.000000000 +0000
@@ -80,6 +80,9 @@ struct rt_mutex {
 	char 			*name, *file;
 	int			line;
 # endif
+# ifdef CONFIG_DEBUG_PREEMPT
+	int			was_preempt_off;
+# endif
 };
 
 /*
@@ -96,6 +99,12 @@ struct rt_mutex_waiter {
 #endif
 };
 
+#ifdef CONFIG_DEBUG_PREEMPT
+# define __WAS_PREEMPT_OFF(x)	, .was_preempt_off = x
+#else
+# define __WAS_PREEMPT_OFF(x)	, .was_preempt_off = x
+#endif
+
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __RT_MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) \
 	, .name = #lockname, .file = __FILE__, .line = __LINE__
@@ -124,6 +133,7 @@ struct rt_mutex_waiter {
 #define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED \
 	__PLIST_INIT(lockname) \
+	__WAS_PREEMPT_OFF(0)	\
 	__RT_MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) \
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER }
 
@@ -155,6 +165,7 @@ typedef struct {
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED, .save_state = 1 \
 	__PLIST_INIT((lockname).lock.lock) \
 	, .file = __FILE__, .line = __LINE__ \
+	__WAS_PREEMPT_OFF(1)	\
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER
 #  define _RW_LOCK_UNLOCKED(lockname) \
 	(rwlock_t) { { { __RW_LOCK_UNLOCKED(lockname), .name = #lockname } } }
@@ -188,6 +199,7 @@ typedef struct {
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED \
 	__PLIST_INIT(((lockname).lock)) \
 	, .save_state = 1, .file = __FILE__, .line = __LINE__ \
+	__WAS_PREEMPT_OFF(1)	\
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER
 # define _SPIN_LOCK_UNLOCKED(lockname) \
 	(spinlock_t) { { __SPIN_LOCK_UNLOCKED(lockname), .name = #lockname } }
Index: linux-2.6.12/include/linux/sched.h
===================================================================
--- linux-2.6.12.orig/include/linux/sched.h	2005-07-31 19:19:42.000000000 +0000
+++ linux-2.6.12/include/linux/sched.h	2005-07-31 19:39:38.000000000 +0000
@@ -54,6 +54,14 @@ extern int debug_direct_keyboard;
 # define debug_direct_keyboard 0
 #endif
 
+#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPT_RT)
+extern int check_locking_preempt_off(struct task_struct *p);
+extern void check_preempt_wakeup(struct task_struct * p);
+#else
+#define check_locking_preempt_off(x)	(0)
+#define check_preempt_wakeup(p)	do { } while(0)
+#endif
+
 #ifdef CONFIG_RT_DEADLOCK_DETECT
   extern void deadlock_trace_off(void);
   extern void show_held_locks(struct task_struct *filter);
@@ -889,14 +897,19 @@ struct task_struct {
 /* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
 	spinlock_t proc_lock;
 
-#define MAX_PREEMPT_TRACE 16
+#define MAX_PREEMPT_TRACE 20
 
 #ifdef CONFIG_PREEMPT_TRACE
 	unsigned long preempt_trace_eip[MAX_PREEMPT_TRACE];
 	unsigned long preempt_trace_parent_eip[MAX_PREEMPT_TRACE];
 #endif
+
+#define MAX_LOCK_STACK	MAX_PREEMPT_TRACE 
 #ifdef CONFIG_DEBUG_PREEMPT
 	int lock_count;
+# ifdef CONFIG_PREEMPT_RT
+	struct rt_mutex *owned_lock[MAX_LOCK_STACK];
+# endif
 #endif
 	/* realtime bits */
 	struct list_head delayed_put;
Index: linux-2.6.12/kernel/rt.c
===================================================================
--- linux-2.6.12.orig/kernel/rt.c	2005-07-31 19:19:42.000000000 +0000
+++ linux-2.6.12/kernel/rt.c	2005-07-31 19:53:16.000000000 +0000
@@ -248,6 +248,40 @@ void zap_rt_locks(void)
 #endif
 }
 
+#ifdef CONFIG_DEBUG_PREEMPT
+int check_locking_preempt_off(struct task_struct *p)
+{
+	int i = 0;
+	
+	for (;i < p->lock_count; i++) {
+		if (p->owned_lock[i]->was_preempt_off) return 1;
+	}
+	return 0;
+}
+
+void check_preempt_wakeup(struct task_struct * p)
+{
+	/*
+	 * Possible PREEMPT_RT race scenario when
+	 * wake_up_proces() is usually called with
+	 * preemption off , but PREEMPT_RT enables
+	 * it. If the task is dependent on preventing
+	 * context switches either with spinlocks
+	 * or rcu locks , then this could result in
+	 * hangs and race conditions.
+	 */
+	if (!preempt_count() && 
+		p->prio < current->prio &&
+		rt_task(p) &&
+		(current->rcu_read_lock_nesting != 0 ||
+		check_locking_preempt_off(current)) ) {
+			printk("BUG: %s/%d, possible wake_up race on %s/%d\n",
+				current->comm, current->pid, p->comm, p->pid);
+			dump_stack();
+		}
+}
+#endif
+
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 
 static void printk_task(struct task_struct *p)
@@ -853,6 +887,9 @@ static void __init_rt_mutex(struct rt_mu
 	lock->file = file;
 	lock->line = line;
 #endif
+#ifdef CONFIG_DEBUG_PREEMPT
+	lock->was_preempt_off = 0;
+#endif
 }
 
 void fastcall __init_rwsem(struct rw_semaphore *rwsem, int save_state,
@@ -880,6 +917,13 @@ void set_new_owner(struct rt_mutex *lock
 	lock->acquire_eip = eip;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
+	if (new_owner->task->lock_count < 0 || new_owner->task->lock_count >= MAX_LOCK_STACK) {
+		TRACE_OFF();
+		printk("BUG: %s/%d: lock count of %lu\n", 
+			new_owner->task->comm, new_owner->task->pid, new_owner->task->lock_count);
+		dump_stack();
+	}
+	new_owner->task->owned_lock[new_owner->task->lock_count] = lock;
 	new_owner->task->lock_count++;
 #endif
 }
@@ -1009,7 +1053,14 @@ static int __grab_lock(struct rt_mutex *
 	list_del_init(&lock->held_list);
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
+	if (owner->lock_count < 0 || owner->lock_count >= MAX_LOCK_STACK) {
+		TRACE_OFF();
+		printk("BUG: %s/%d: lock count of %lu\n", 
+			owner->comm, owner->pid, owner->lock_count);
+		dump_stack();
+	}
 	owner->lock_count--;
+	owner->owned_lock[owner->lock_count] = NULL;
 #endif
 	return 1;
 }
@@ -1317,7 +1368,14 @@ ____up_mutex(struct rt_mutex *lock, int 
 	__raw_spin_unlock(&pi_lock);
 	__raw_spin_unlock(&lock->wait_lock);
 #ifdef CONFIG_DEBUG_PREEMPT
+	if (current->lock_count < 0 || current->lock_count >= MAX_LOCK_STACK) {
+		TRACE_OFF();
+		printk("BUG: %s/%d: lock count of %lu\n", 
+			current->comm, current->pid, current->lock_count);
+		dump_stack();
+	}
 	current->lock_count--;
+	current->owned_lock[current->lock_count] = NULL;
 	if (!current->lock_count && !rt_prio(current->normal_prio) &&
 					rt_prio(current->prio)) {
 		static int once = 1;
@@ -2194,6 +2252,9 @@ EXPORT_SYMBOL(atomic_dec_and_spin_lock);
 void _spin_lock_init(spinlock_t *lock, char *name, char *file, int line)
 {
 	__init_rt_mutex(&lock->lock, 1, name, file, line);
+#ifdef CONFIG_DEBUG_PREEMPT
+	lock->lock.was_preempt_off = 1;
+#endif
 #ifdef CONFIG_DEBUG_RT_LOCKING_MODE
 	_raw_spin_lock_init(&lock->lock.debug_slock);
 #endif
@@ -2361,6 +2422,9 @@ EXPORT_SYMBOL(_read_unlock_irqrestore);
 void _rwlock_init(rwlock_t *rwlock, char *name, char *file, int line)
 {
 	__init_rwsem(&rwlock->lock, 1, name, file, line);
+#ifdef CONFIG_DEBUG_PREEMT
+	lock->lock.was_preempt_off = 1;
+#endif
 #ifdef CONFIG_DEBUG_RT_LOCKING_MODE
 	_raw_rwlock_init(&rwlock->lock.lock.debug_rwlock);
 #endif
Index: linux-2.6.12/kernel/sched.c
===================================================================
--- linux-2.6.12.orig/kernel/sched.c	2005-07-31 19:19:42.000000000 +0000
+++ linux-2.6.12/kernel/sched.c	2005-07-31 19:23:53.000000000 +0000
@@ -1552,7 +1552,10 @@ out:
 
 int fastcall wake_up_process(task_t * p)
 {
-	int ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
+	int ret; 
+
+	check_preempt_wakeup(p);
+	ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 				 TASK_RUNNING_MUTEX | TASK_INTERRUPTIBLE |
 				 TASK_UNINTERRUPTIBLE, 0, 0);
 	mcount();
@@ -1563,7 +1566,9 @@ EXPORT_SYMBOL(wake_up_process);
 
 int fastcall wake_up_process_sync(task_t * p)
 {
-	int ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
+	int ret; 
+	check_preempt_wakeup(p);
+	ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 				 TASK_RUNNING_MUTEX | TASK_INTERRUPTIBLE |
 				 TASK_UNINTERRUPTIBLE, 1, 0);
 	mcount();


