Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbUANWwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUANWwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:52:17 -0500
Received: from fmr05.intel.com ([134.134.136.6]:63622 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265141AbUANWsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:48:04 -0500
Date: Wed, 14 Jan 2004 14:49:56 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 2/10: modifications to the core
Message-ID: <0401141449.dbBcncYdzckbldFceb8bkcYaHaIc2aoc9031@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0401141449.XaoaCdSa2dWdXcWdVbecoaVabdMcIcQc9031@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are modifications needed to support fuqueues and
fulocks. They are, in a nutshell:

- Move some stuff from kernel/futex.c to futex.h to make it
usable by more people.

- Add neccesary fields to the task_struct.

- Hookup to initialization and cleanup points for process
creation and destruction.

- Hookup into the signalling and time out code for wait
cancellation, as well as for changing task priorities.

- Add error codes for dead-owner and not-recoverable.


 include/asm-generic/errno-base.h |    4 +++
 include/linux/futex.h            |   52 +++++++++++++++++++++++++++++++++++++++
 include/linux/init_task.h        |    5 +++
 include/linux/sched.h            |    9 ++++++
 kernel/Makefile                  |    3 +-
 kernel/exit.c                    |    3 ++
 kernel/fork.c                    |    2 +
 kernel/futex.c                   |   39 +++--------------------------
 kernel/sched.c                   |   52 ++++++++++++++++++++++++++++++++++++++-
 kernel/signal.c                  |   16 +++++++++++-
 kernel/timer.c                   |   11 +++++++-
 11 files changed, 157 insertions(+), 39 deletions(-)

--- linux/include/linux/futex.h:1.1.1.1	Thu Jul 10 12:27:31 2003
+++ linux/include/linux/futex.h	Sun Nov 16 07:21:32 2003
@@ -9,7 +9,11 @@
 #define FUTEX_FD (2)
 #define FUTEX_REQUEUE (3)
 
+#ifdef __KERNEL__
 
+#include <linux/jhash.h>
+
+struct timespec;
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
 			  struct timespec __user *utime, u32 __user *uaddr2);
 
@@ -17,4 +21,52 @@
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2);
 
+/*
+ * Futexes are matched on equal values of this key.
+ * The key type depends on whether it's a shared or private mapping.
+ * Don't rearrange members without looking at futex_hash_key().
+ *
+ * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
+ * We set bit 0 to indicate if it's an inode-based key.
+ */
+union futex_key {
+	struct {
+		unsigned long pgoff;
+		struct inode *inode;
+		int offset;
+	} shared;
+	struct {
+		unsigned long uaddr;
+		struct mm_struct *mm;
+		int offset;
+	} private;
+	struct {
+		unsigned long word;
+		void *ptr;
+		int offset;
+	} both;
+};
+
+static inline
+u32 futex_hash_key (const union futex_key *key)
+{
+  u32 hash = jhash2((u32*)&key->both.word,
+                    (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+                    key->both.offset);
+  return hash;
+}
+
+static inline
+int match_futex_key (const union futex_key *key1, const union futex_key *key2)
+{
+	return (key1->both.word == key2->both.word
+		&& key1->both.ptr == key2->both.ptr
+		&& key1->both.offset == key2->both.offset);
+}
+
+extern int get_futex_key (unsigned long uaddr, union futex_key *key);
+extern void get_key_refs(union futex_key *key);
+extern void drop_key_refs(union futex_key *key);
+
+#endif /* #ifdef __KERNEL__ */
 #endif
--- linux/include/linux/init_task.h:1.1.1.2	Thu Aug 28 12:38:00 2003
+++ linux/include/linux/init_task.h	Sun Nov 16 07:21:32 2003
@@ -108,6 +108,11 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.fuqueue_wait_lock	= SPIN_LOCK_UNLOCKED,			\
+	.fuqueue_wait	= NULL,						\
+	.fuqueue_waiter	= NULL,						\
+	.fulock_olist	= olist_INIT(&tsk.fulock_olist),		\
+	.fulock_olist_lock = SPIN_LOCK_UNLOCKED,			\
 }
 
 
--- linux/include/linux/sched.h:1.1.1.11	Tue Jan 13 21:13:50 2004
+++ linux/include/linux/sched.h	Wed Jan 14 11:13:30 2004
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/fulock-olist.h>    /* olist_t */
 
 struct exec_domain;
 
@@ -326,7 +327,8 @@
 	struct sigqueue *sigq;		/* signal queue entry. */
 };
 
-
+struct fuqueue;
+struct fuqueue_waiter;
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 
@@ -464,6 +466,11 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+	struct fuqueue *fuqueue_wait; /* waiting for this qeueue */
+	struct fuqueue_waiter *fuqueue_waiter; /* waiting for this qeueue */
+	spinlock_t fuqueue_wait_lock; /* FIXME: locking too heavy -- better sollution? */
+	olist_t fulock_olist;	      /* Fulock ownership list */
+	spinlock_t fulock_olist_lock;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
--- linux/kernel/Makefile:1.1.1.7	Tue Jan 13 21:13:51 2004
+++ linux/kernel/Makefile	Wed Jan 14 11:13:33 2004
@@ -7,7 +7,8 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o \
+	    fuqueue.o fulock.o fulock-pp.o vlocator.o ufuqueue.o ufulock.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- linux/kernel/exit.c:1.1.1.8	Tue Jan 13 20:54:51 2004
+++ linux/kernel/exit.c	Wed Jan 14 11:13:33 2004
@@ -740,6 +740,8 @@
 
 }
 
+extern void exit_fulocks(struct task_struct *);
+
 NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -768,6 +770,7 @@
 	}
 
 	acct_process(code);
+	exit_fulocks(tsk);
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
--- linux/kernel/fork.c:1.1.1.11	Tue Jan 13 21:13:51 2004
+++ linux/kernel/fork.c	Wed Jan 14 11:13:33 2004
@@ -40,6 +40,7 @@
 
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
 extern void exit_sem(struct task_struct *tsk);
+extern void init_fulock (struct task_struct *task);
 
 /* The idle threads do not count..
  * Protected by write_lock_irq(&tasklist_lock)
@@ -968,6 +969,7 @@
 		goto bad_fork_cleanup_signal;
 	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
+	init_fulock(p);
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
--- linux/kernel/futex.c:1.1.1.6	Tue Jan 13 21:13:51 2004
+++ linux/kernel/futex.c	Wed Jan 14 11:13:33 2004
@@ -41,31 +41,6 @@
 
 #define FUTEX_HASHBITS 8
 
-/*
- * Futexes are matched on equal values of this key.
- * The key type depends on whether it's a shared or private mapping.
- * Don't rearrange members without looking at hash_futex().
- *
- * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
- * We set bit 0 to indicate if it's an inode-based key.
- */
-union futex_key {
-	struct {
-		unsigned long pgoff;
-		struct inode *inode;
-		int offset;
-	} shared;
-	struct {
-		unsigned long uaddr;
-		struct mm_struct *mm;
-		int offset;
-	} private;
-	struct {
-		unsigned long word;
-		void *ptr;
-		int offset;
-	} both;
-};
 
 /*
  * We use this hashed waitqueue instead of a normal wait_queue_t, so
@@ -109,9 +84,7 @@
  */
 static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
-	u32 hash = jhash2((u32*)&key->both.word,
-			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
-			  key->both.offset);
+	u32 hash = futex_hash_key (key);
 	return &futex_queues[hash & ((1 << FUTEX_HASHBITS)-1)];
 }
 
@@ -120,9 +93,7 @@
  */
 static inline int match_futex(union futex_key *key1, union futex_key *key2)
 {
-	return (key1->both.word == key2->both.word
-		&& key1->both.ptr == key2->both.ptr
-		&& key1->both.offset == key2->both.offset);
+	return match_futex_key (key1, key2);
 }
 
 /*
@@ -137,7 +108,7 @@
  *
  * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
-static int get_futex_key(unsigned long uaddr, union futex_key *key)
+int get_futex_key(unsigned long uaddr, union futex_key *key)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -232,7 +203,7 @@
  * NOTE: mmap_sem MUST be held between get_futex_key() and calling this
  * function, if it is called at all.  mmap_sem keeps key->shared.inode valid.
  */
-static inline void get_key_refs(union futex_key *key)
+inline void get_key_refs(union futex_key *key)
 {
 	if (key->both.ptr != 0) {
 		if (key->both.offset & 1)
@@ -246,7 +217,7 @@
  * Drop a reference to the resource addressed by a key.
  * The hash bucket spinlock must not be held.
  */
-static void drop_key_refs(union futex_key *key)
+inline void drop_key_refs(union futex_key *key)
 {
 	if (key->both.ptr != 0) {
 		if (key->both.offset & 1)
--- linux/kernel/sched.c:1.1.1.15	Tue Jan 13 21:13:51 2004
+++ linux/kernel/sched.c	Wed Jan 14 11:13:33 2004
@@ -658,7 +658,8 @@
 	int success = 0;
 	long old_state;
 	runqueue_t *rq;
-
+	
+		
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
@@ -1761,6 +1762,8 @@
 
 EXPORT_SYMBOL(default_wake_function);
 
+extern void fuqueue_wait_cancel(struct task_struct *, int);
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve
@@ -1769,6 +1772,9 @@
  * There are circumstances in which we can try to wake a task which has already
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
+ *
+ * fuqueue_wait_cancel needs to hook up here to properly rescheduler
+ * priority inheritance/protected tasks. Check its doc to learn why.
  */
 static void __wake_up_common(wait_queue_head_t *q, unsigned int mode,
 			     int nr_exclusive, int sync)
@@ -1780,6 +1786,8 @@
 		unsigned flags;
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		flags = curr->flags;
+		if (unlikely(curr->task->fuqueue_wait != NULL))
+			fuqueue_wait_cancel(curr->task, -EINTR);
 		if (curr->func(curr, mode, sync) &&
 		    (flags & WQ_FLAG_EXCLUSIVE) &&
 		    !--nr_exclusive)
@@ -2106,6 +2114,46 @@
 	return pid ? find_task_by_pid(pid) : current;
 }
 
+/**
+ * Unconditionally set the effective priority of a task.
+ *
+ * Not too useful on SCHED_OTHER tasks, btw ...
+ * 
+ * @p Pointer to the task in question
+ * @prio New priority to set 
+ */
+#warning FIXME: need to play by POSIX rules on prio change and list repositioning because of prio inheritance
+
+void __set_prio (struct task_struct *p, int prio)
+{
+	runqueue_t *rq;
+	prio_array_t *array;
+	long flags;
+        int oldprio;
+	
+	rq = task_rq_lock(p, &flags);
+        oldprio = p->prio;
+	array = p->array;
+	if (!array) {
+		p->prio = prio;
+		goto out_unlock;
+	}
+	deactivate_task(p, task_rq(p));
+	p->prio = prio;
+	__activate_task(p, task_rq(p));
+        if (rq->curr == p) {
+                if (p->prio > oldprio)
+                        resched_task(rq->curr);
+        }
+	else if (TASK_PREEMPTS_CURR (p, rq))
+                resched_task(rq->curr);
+out_unlock:
+	task_rq_unlock (rq, &flags);
+}
+
+
+extern void fuqueue_chprio (struct task_struct *);
+
 /*
  * setscheduler - change the scheduling policy and/or RT priority of a thread.
  */
@@ -2185,6 +2233,8 @@
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
+	if (p->fuqueue_wait != NULL)
+		fuqueue_chprio(p);
 	if (array) {
 		__activate_task(p, task_rq(p));
 		/*
--- linux/kernel/signal.c:1.1.1.9	Tue Jan 13 20:54:51 2004
+++ linux/kernel/signal.c	Wed Jan 14 11:13:33 2004
@@ -524,6 +524,8 @@
 	return signr;
 }
 
+extern void fuqueue_wait_cancel (struct task_struct *, int);
+
 /*
  * Tell a process that it has a new active signal..
  *
@@ -547,12 +549,21 @@
 	 * executing another processor and just now entering stopped state.
 	 * By calling wake_up_process any time resume is set, we ensure
 	 * the process will wake up and handle its stop or death signal.
+	 * 
+	 * fuqueue_wait_cancel needs to hook up here to properly rescheduler
+	 * priority inheritance/protected tasks. The reason is that
+	 * when we resched a process that has boosted another one, we
+	 * need to kick its butt off the CPU (and lower its priority) ASAP
+	 * so that 't' can run.
 	 */
 	mask = TASK_INTERRUPTIBLE;
 	if (resume)
 		mask |= TASK_STOPPED;
-	if (!wake_up_state(t, mask))
+	if (!wake_up_state(t, mask)) {
+		if (unlikely (t->fuqueue_wait != NULL))
+			fuqueue_wait_cancel(t, -EINTR);
 		kick_process(t);
+	}
 }
 
 /*
@@ -675,6 +686,9 @@
 				set_tsk_thread_flag(t, TIF_SIGPENDING);
 				state |= TASK_INTERRUPTIBLE;
 			}
+			/* FIXME: I am not that sure we need to cancel here */
+			if (unlikely(t->fuqueue_wait != NULL))
+				fuqueue_wait_cancel(t, -EINTR);
 			wake_up_state(t, state);
 
 			t = next_thread(t);
--- linux/kernel/timer.c:1.1.1.10	Tue Jan 13 21:13:51 2004
+++ linux/kernel/timer.c	Wed Jan 14 11:13:34 2004
@@ -966,9 +966,18 @@
 
 #endif
 
+/*
+ * fuqueue_wait_cancel needs to hook up here to properly rescheduler
+ * priority inheritance/protected tasks. Check its doc to learn why.
+ */ 
+extern void fuqueue_wait_cancel(struct task_struct *, int);
+
 static void process_timeout(unsigned long __data)
 {
-	wake_up_process((task_t *)__data);
+	struct task_struct *task = (task_t *) __data;
+	if (unlikely(task->fuqueue_wait != NULL))
+		fuqueue_wait_cancel(task, -ETIMEDOUT);
+	wake_up_process(task);
 }
 
 /**
--- linux/include/asm-generic/errno-base.h:1.1.1.1	Thu Jul 10 12:27:27 2003
+++ linux/include/asm-generic/errno-base.h	Sun Nov 16 07:21:32 2003
@@ -36,4 +36,8 @@
 #define	EDOM		33	/* Math argument out of domain of func */
 #define	ERANGE		34	/* Math result not representable */
 
+  /* FIXME: ugly hack to avoid conflicts -- need to get better numbers */
+#define EOWNERDEAD      525     /* Mutex owner died */
+#define ENOTRECOVERABLE 526     /* Mutex state is not recoverable */
+
 #endif
