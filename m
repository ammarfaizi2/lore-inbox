Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262831AbSJLGxg>; Sat, 12 Oct 2002 02:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262835AbSJLGxg>; Sat, 12 Oct 2002 02:53:36 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:15745 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S262831AbSJLGxV>; Sat, 12 Oct 2002 02:53:21 -0400
Date: Sat, 12 Oct 2002 08:59:09 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: John Levon <levon@movementarian.org>,
       Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: [patch] tasks.h
Message-ID: <Pine.LNX.4.33.0210120842070.25918-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First rough cut at a <linux/tasks.h> header file that breaks out 
task_struct from <linux/sched.h>, along with most of the declarations 
depending on it.
As it will be easy to move more definitions from sched.h to tasks.h, but 
difficult to move them back, I took a rather minimalistic approach. 

More work will be neccessary to completely disentangle both files, so that 
sched.h doesn't need to include tasks.h. Biggest obstacle is get_task_mm()
which needs both task_struct and mm_struct. Maybe I'll break out something 
like a <linux/task_mm.h> later.

For now this is sufficcient for me as it allows me to continue with my 
patch to remove #large_number of <linux/sched.h> includes. Analysis for 
2.5.42 is on the way.

Tim

--- linux-2.5.42/include/linux/sched.h	Wed Oct  9 00:28:26 2002
+++ linux-2.5.42-ts/include/linux/sched.h	Sat Oct 12 06:08:12 2002
@@ -9,11 +9,11 @@
 #include <linux/capability.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
+#include <linux/tasks.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -22,7 +22,6 @@
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
-#include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
@@ -92,44 +91,6 @@
 
 #include <linux/time.h>
 #include <linux/param.h>
-#include <linux/resource.h>
-#include <linux/timer.h>
-
-#include <asm/processor.h>
-
-#define TASK_RUNNING		0
-#define TASK_INTERRUPTIBLE	1
-#define TASK_UNINTERRUPTIBLE	2
-#define TASK_STOPPED		4
-#define TASK_ZOMBIE		8
-#define TASK_DEAD		16
-
-#define __set_task_state(tsk, state_value)		\
-	do { (tsk)->state = (state_value); } while (0)
-#ifdef CONFIG_SMP
-#define set_task_state(tsk, state_value)		\
-	set_mb((tsk)->state, (state_value))
-#else
-#define set_task_state(tsk, state_value)		\
-	__set_task_state((tsk), (state_value))
-#endif
-
-#define __set_current_state(state_value)			\
-	do { current->state = (state_value); } while (0)
-#ifdef CONFIG_SMP
-#define set_current_state(state_value)		\
-	set_mb(current->state, (state_value))
-#else
-#define set_current_state(state_value)		\
-	__set_current_state(state_value)
-#endif
-
-/*
- * Scheduling policies
- */
-#define SCHED_NORMAL		0
-#define SCHED_FIFO		1
-#define SCHED_RR		2
 
 struct sched_param {
 	int sched_priority;
@@ -148,8 +109,6 @@
 extern rwlock_t tasklist_lock;
 extern spinlock_t mmlist_lock;
 
-typedef struct task_struct task_t;
-
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
 
@@ -275,172 +234,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
-struct backing_dev_info;
-
-struct task_struct {
-	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	struct thread_info *thread_info;
-	atomic_t usage;
-	unsigned long flags;	/* per process flags, defined below */
-	unsigned long ptrace;
-
-	int lock_depth;		/* Lock depth */
-
-	int prio, static_prio;
-	struct list_head run_list;
-	prio_array_t *array;
-
-	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
-
-	unsigned long policy;
-	unsigned long cpus_allowed;
-	unsigned int time_slice, first_time_slice;
-
-	struct list_head tasks;
-	struct list_head ptrace_children;
-	struct list_head ptrace_list;
-
-	struct mm_struct *mm, *active_mm;
-	struct list_head local_pages;
-
-	unsigned int allocation_order, nr_local_pages;
-
-/* task state */
-	struct linux_binfmt *binfmt;
-	int exit_code, exit_signal;
-	int pdeath_signal;  /*  The signal sent when the parent dies  */
-	/* ??? */
-	unsigned long personality;
-	int did_exec:1;
-	pid_t pid;
-	pid_t pgrp;
-	pid_t tty_old_pgrp;
-	pid_t session;
-	pid_t tgid;
-	/* boolean value for session group leader */
-	int leader;
-	/* 
-	 * pointers to (original) parent process, youngest child, younger sibling,
-	 * older sibling, respectively.  (p->father can be replaced with 
-	 * p->parent->pid)
-	 */
-	struct task_struct *real_parent; /* real parent process (when being debugged) */
-	struct task_struct *parent;	/* parent process */
-	struct list_head children;	/* list of my children */
-	struct list_head sibling;	/* linkage in my parent's children list */
-	struct task_struct *group_leader;
-
-	/* PID/PID hash table linkage. */
-	struct pid_link pids[PIDTYPE_MAX];
-
-	wait_queue_head_t wait_chldexit;	/* for wait4() */
-	struct completion *vfork_done;		/* for vfork() */
-	int *user_tid;				/* for CLONE_CLEARTID */
-
-	unsigned long rt_priority;
-	unsigned long it_real_value, it_prof_value, it_virt_value;
-	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
-	struct timer_list real_timer;
-	unsigned long utime, stime, cutime, cstime;
-	unsigned long start_time;
-	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
-/* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
-	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
-	int swappable:1;
-/* process credentials */
-	uid_t uid,euid,suid,fsuid;
-	gid_t gid,egid,sgid,fsgid;
-	int ngroups;
-	gid_t	groups[NGROUPS];
-	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
-	int keep_capabilities:1;
-	struct user_struct *user;
-/* limits */
-	struct rlimit rlim[RLIM_NLIMITS];
-	unsigned short used_math;
-	char comm[16];
-/* file system info */
-	int link_count, total_link_count;
-	struct tty_struct *tty; /* NULL if no tty */
-	unsigned int locks; /* How many file locks are being held */
-/* ipc stuff */
-	struct sysv_sem sysvsem;
-/* CPU-specific state of this task */
-	struct thread_struct thread;
-/* filesystem information */
-	struct fs_struct *fs;
-/* open file information */
-	struct files_struct *files;
-/* namespace */
-	struct namespace *namespace;
-/* signal handlers */
-	struct signal_struct *sig;
-
-	sigset_t blocked, real_blocked;
-	struct sigpending pending;
-
-	unsigned long sas_ss_sp;
-	size_t sas_ss_size;
-	int (*notifier)(void *priv);
-	void *notifier_data;
-	sigset_t *notifier_mask;
-	
-	void *security;
-
-/* Thread group tracking */
-   	u32 parent_exec_id;
-   	u32 self_exec_id;
-/* Protection of (de-)allocation: mm, files, fs, tty */
-	spinlock_t alloc_lock;
-/* context-switch lock */
-	spinlock_t switch_lock;
-
-/* journalling filesystem info */
-	void *journal_info;
-	struct dentry *proc_dentry;
-	struct backing_dev_info *backing_dev_info;
-};
-
-extern void __put_task_struct(struct task_struct *tsk);
-#define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
-#define put_task_struct(tsk) \
-do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
-
-/*
- * Per process flags
- */
-#define PF_ALIGNWARN	0x00000001	/* Print alignment warning msgs */
-					/* Not implemented yet, only for 486*/
-#define PF_STARTING	0x00000002	/* being created */
-#define PF_EXITING	0x00000004	/* getting shut down */
-#define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
-#define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
-#define PF_DUMPCORE	0x00000200	/* dumped core */
-#define PF_SIGNALED	0x00000400	/* killed by a signal */
-#define PF_MEMALLOC	0x00000800	/* Allocating memory */
-#define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
-#define PF_FREE_PAGES	0x00002000	/* per process page freeing */
-#define PF_FLUSHER	0x00004000	/* responsible for disk writeback */
-#define PF_NOWARN	0x00008000	/* debug: don't warn if alloc fails */
-
-#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
-#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
-#define PF_FROZEN	0x00040000	/* frozen for system suspend */
-#define PF_SYNC		0x00080000	/* performing fsync(), etc */
-#define PF_FSTRANS	0x00100000	/* inside a filesystem transaction */
-#define PF_KSWAPD	0x00200000	/* I am kswapd */
-
-/*
- * Ptrace flags
- */
-
-#define PT_PTRACED	0x00000001
-#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
-#define PT_TRACESYSGOOD	0x00000004
-#define PT_PTRACE_CAP	0x00000008	/* ptracer can follow suid-exec */
-
 /*
  * Limit the stack by to some sane default: root can always
  * increase this limit if needed..  8MB seems reasonable.
@@ -476,7 +269,6 @@
 };
 
 extern union thread_union init_thread_union;
-extern struct task_struct init_task;
 
 extern struct   mm_struct init_mm;
 
@@ -582,19 +374,6 @@
 	return ready !=	0;
 }
 
-/* True if we are on the alternate signal stack.  */
-
-static inline int on_sig_stack(unsigned long sp)
-{
-	return (sp - current->sas_ss_sp < current->sas_ss_size);
-}
-
-static inline int sas_ss_flags(unsigned long sp)
-{
-	return (current->sas_ss_size == 0 ? SS_DISABLE
-		: on_sig_stack(sp) ? SS_ONSTACK : 0);
-}
-
 extern int request_irq(unsigned int,
 		       void (*handler)(int, void *, struct pt_regs *),
 		       unsigned long, const char *, void *);
@@ -672,89 +451,6 @@
 #endif
 extern void kick_if_running(task_t * p);
 
-#define __wait_event(wq, condition) 					\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_UNINTERRUPTIBLE);		\
-		if (condition)						\
-			break;						\
-		schedule();						\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_event(wq, condition) 					\
-do {									\
-	if (condition)	 						\
-		break;							\
-	__wait_event(wq, condition);					\
-} while (0)
-
-#define __wait_event_interruptible(wq, condition, ret)			\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_INTERRUPTIBLE);			\
-		if (condition)						\
-			break;						\
-		if (!signal_pending(current)) {				\
-			schedule();					\
-			continue;					\
-		}							\
-		ret = -ERESTARTSYS;					\
-		break;							\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_event_interruptible(wq, condition)				\
-({									\
-	int __ret = 0;							\
-	if (!(condition))						\
-		__wait_event_interruptible(wq, condition, __ret);	\
-	__ret;								\
-})
-
-#define __wait_event_interruptible_timeout(wq, condition, ret)		\
-do {									\
-	wait_queue_t __wait;						\
-	init_waitqueue_entry(&__wait, current);				\
-									\
-	add_wait_queue(&wq, &__wait);					\
-	for (;;) {							\
-		set_current_state(TASK_INTERRUPTIBLE);			\
-		if (condition)						\
-			break;						\
-		if (!signal_pending(current)) {				\
-			ret = schedule_timeout(ret);			\
-			if (!ret)					\
-				break;					\
-			continue;					\
-		}							\
-		ret = -ERESTARTSYS;					\
-		break;							\
-	}								\
-	current->state = TASK_RUNNING;					\
-	remove_wait_queue(&wq, &__wait);				\
-} while (0)
-
-#define wait_event_interruptible_timeout(wq, condition, timeout)	\
-({									\
-	long __ret = timeout;						\
-	if (!(condition))						\
-		__wait_event_interruptible_timeout(wq, condition, __ret); \
-	__ret;								\
-})
-	
 /*
  * Must be called with the spinlock in the wait_queue_head_t held.
  */
@@ -774,88 +470,10 @@
 	__remove_wait_queue(q,  wait);
 }
 
-#define remove_parent(p)	list_del_init(&(p)->sibling)
-#define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
-
-#define REMOVE_LINKS(p) do {					\
-	if (thread_group_leader(p))				\
-		list_del_init(&(p)->tasks);			\
-	remove_parent(p);					\
-	} while (0)
-
-#define SET_LINKS(p) do {					\
-	if (thread_group_leader(p))				\
-		list_add_tail(&(p)->tasks,&init_task.tasks);	\
-	add_parent(p, (p)->parent);				\
-	} while (0)
-
-static inline struct task_struct *eldest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.next,struct task_struct,sibling);
-}
-
-static inline struct task_struct *youngest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *older_sibling(struct task_struct *p)
-{
-	if (p->sibling.prev==&p->parent->children) return NULL;
-	return list_entry(p->sibling.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *younger_sibling(struct task_struct *p)
-{
-	if (p->sibling.next==&p->parent->children) return NULL;
-	return list_entry(p->sibling.next,struct task_struct,sibling);
-}
-
-#define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
-#define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
-
-#define for_each_process(p) \
-	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
-
-/*
- * Careful: do_each_thread/while_each_thread is a double loop so
- *          'break' will not work as expected - use goto instead.
- */
-#define do_each_thread(g, t) \
-	for (g = t = &init_task ; (g = t = next_task(g)) != &init_task ; ) do
-
-#define while_each_thread(g, t) \
-	while ((t = next_thread(t)) != g)
-
 extern task_t * FASTCALL(next_thread(task_t *p));
 
-#define thread_group_leader(p)	(p->pid == p->tgid)
-
-static inline int thread_group_empty(task_t *p)
-{
-	struct pid *pid = p->pids[PIDTYPE_TGID].pidptr;
-
-	return pid->task_list.next->next == &pid->task_list;
-}
-
-#define delay_group_leader(p) \
-		(thread_group_leader(p) && !thread_group_empty(p))
-
 extern void unhash_process(struct task_struct *p);
 
-/* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests inside tasklist_lock */
-static inline void task_lock(struct task_struct *p)
-{
-	spin_lock(&p->alloc_lock);
-}
-
-static inline void task_unlock(struct task_struct *p)
-{
-	spin_unlock(&p->alloc_lock);
-}
-
 /* write full pathname into buffer and return start of pathname */
 static inline char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
 				char *buf, int buflen)
@@ -875,7 +493,6 @@
 	return res;
 }
 
- 
 /**
  * get_task_mm - acquire a reference to the task's mm
  *
@@ -896,54 +513,6 @@
 }
  
  
-/* set thread flags in other task's structures
- * - see asm/thread_info.h for TIF_xxxx flags available
- */
-static inline void set_tsk_thread_flag(struct task_struct *tsk, int flag)
-{
-	set_ti_thread_flag(tsk->thread_info,flag);
-}
-
-static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
-{
-	clear_ti_thread_flag(tsk->thread_info,flag);
-}
-
-static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
-{
-	return test_and_set_ti_thread_flag(tsk->thread_info,flag);
-}
-
-static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
-{
-	return test_and_clear_ti_thread_flag(tsk->thread_info,flag);
-}
-
-static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
-{
-	return test_ti_thread_flag(tsk->thread_info,flag);
-}
-
-static inline void set_tsk_need_resched(struct task_struct *tsk)
-{
-	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
-}
-
-static inline void clear_tsk_need_resched(struct task_struct *tsk)
-{
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
-}
-
-static inline int signal_pending(struct task_struct *p)
-{
-	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
-}
-  
-static inline int need_resched(void)
-{
-	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
-}
-
 extern void __cond_resched(void);
 static inline void cond_resched(void)
 {
@@ -985,34 +554,6 @@
 
 extern FASTCALL(void recalc_sigpending_tsk(struct task_struct *t));
 extern void recalc_sigpending(void);
-
-/*
- * Wrappers for p->thread_info->cpu access. No-op on UP.
- */
-#ifdef CONFIG_SMP
-
-static inline unsigned int task_cpu(struct task_struct *p)
-{
-	return p->thread_info->cpu;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-	p->thread_info->cpu = cpu;
-}
-
-#else
-
-static inline unsigned int task_cpu(struct task_struct *p)
-{
-	return 0;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-}
-
-#endif /* CONFIG_SMP */
 
 #endif /* __KERNEL__ */
 
--- linux-2.5.42/include/linux/tasks.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.42-ts/include/linux/tasks.h	Sat Oct 12 06:08:18 2002
@@ -0,0 +1,483 @@
+#ifndef _LINUX_TASKS_H
+#define _LINUX_TASKS_H
+
+#include <asm/atomic.h> /* sem.h needs this first */
+#include <linux/capability.h>
+#include <linux/types.h>
+#include <linux/times.h>
+#include <linux/spinlock.h>
+#include <linux/sem.h>
+#include <linux/signal.h>
+#include <linux/resource.h>
+#include <linux/timer.h>
+#include <linux/pid.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <asm/processor.h>
+#include <asm/current.h>
+
+
+#define TASK_RUNNING		0
+#define TASK_INTERRUPTIBLE	1
+#define TASK_UNINTERRUPTIBLE	2
+#define TASK_STOPPED		4
+#define TASK_ZOMBIE		8
+#define TASK_DEAD		16
+
+#define __set_task_state(tsk, state_value)		\
+	do { (tsk)->state = (state_value); } while (0)
+#ifdef CONFIG_SMP
+#define set_task_state(tsk, state_value)		\
+	set_mb((tsk)->state, (state_value))
+#else
+#define set_task_state(tsk, state_value)		\
+	__set_task_state((tsk), (state_value))
+#endif
+
+#define __set_current_state(state_value)			\
+	do { current->state = (state_value); } while (0)
+#ifdef CONFIG_SMP
+#define set_current_state(state_value)		\
+	set_mb(current->state, (state_value))
+#else
+#define set_current_state(state_value)		\
+	__set_current_state(state_value)
+#endif
+
+/*
+ * Scheduling policies
+ */
+#define SCHED_NORMAL		0
+#define SCHED_FIFO		1
+#define SCHED_RR		2
+
+
+#ifdef __KERNEL__
+
+
+typedef struct prio_array prio_array_t;
+struct backing_dev_info;
+
+struct task_struct {
+	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
+	struct thread_info *thread_info;
+	atomic_t usage;
+	unsigned long flags;	/* per process flags, defined below */
+	unsigned long ptrace;
+
+	int lock_depth;		/* Lock depth */
+
+	int prio, static_prio;
+	struct list_head run_list;
+	prio_array_t *array;
+
+	unsigned long sleep_avg;
+	unsigned long sleep_timestamp;
+
+	unsigned long policy;
+	unsigned long cpus_allowed;
+	unsigned int time_slice, first_time_slice;
+
+	struct list_head tasks;
+	struct list_head ptrace_children;
+	struct list_head ptrace_list;
+
+	struct mm_struct *mm, *active_mm;
+	struct list_head local_pages;
+
+	unsigned int allocation_order, nr_local_pages;
+
+/* task state */
+	struct linux_binfmt *binfmt;
+	int exit_code, exit_signal;
+	int pdeath_signal;  /*  The signal sent when the parent dies  */
+	/* ??? */
+	unsigned long personality;
+	int did_exec:1;
+	pid_t pid;
+	pid_t pgrp;
+	pid_t tty_old_pgrp;
+	pid_t session;
+	pid_t tgid;
+	/* boolean value for session group leader */
+	int leader;
+	/* 
+	 * pointers to (original) parent process, youngest child, younger sibling,
+	 * older sibling, respectively.  (p->father can be replaced with 
+	 * p->parent->pid)
+	 */
+	struct task_struct *real_parent; /* real parent process (when being debugged) */
+	struct task_struct *parent;	/* parent process */
+	struct list_head children;	/* list of my children */
+	struct list_head sibling;	/* linkage in my parent's children list */
+	struct task_struct *group_leader;
+
+	/* PID/PID hash table linkage. */
+	struct pid_link pids[PIDTYPE_MAX];
+
+	wait_queue_head_t wait_chldexit;	/* for wait4() */
+	struct completion *vfork_done;		/* for vfork() */
+	int *user_tid;				/* for CLONE_CLEARTID */
+
+	unsigned long rt_priority;
+	unsigned long it_real_value, it_prof_value, it_virt_value;
+	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
+	struct timer_list real_timer;
+	unsigned long utime, stime, cutime, cstime;
+	unsigned long start_time;
+	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+/* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
+	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
+	int swappable:1;
+/* process credentials */
+	uid_t uid,euid,suid,fsuid;
+	gid_t gid,egid,sgid,fsgid;
+	int ngroups;
+	gid_t	groups[NGROUPS];
+	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
+	int keep_capabilities:1;
+	struct user_struct *user;
+/* limits */
+	struct rlimit rlim[RLIM_NLIMITS];
+	unsigned short used_math;
+	char comm[16];
+/* file system info */
+	int link_count, total_link_count;
+	struct tty_struct *tty; /* NULL if no tty */
+	unsigned int locks; /* How many file locks are being held */
+/* ipc stuff */
+	struct sysv_sem sysvsem;
+/* CPU-specific state of this task */
+	struct thread_struct thread;
+/* filesystem information */
+	struct fs_struct *fs;
+/* open file information */
+	struct files_struct *files;
+/* namespace */
+	struct namespace *namespace;
+/* signal handlers */
+	struct signal_struct *sig;
+
+	sigset_t blocked, real_blocked;
+	struct sigpending pending;
+
+	unsigned long sas_ss_sp;
+	size_t sas_ss_size;
+	int (*notifier)(void *priv);
+	void *notifier_data;
+	sigset_t *notifier_mask;
+	
+	void *security;
+
+/* Thread group tracking */
+   	u32 parent_exec_id;
+   	u32 self_exec_id;
+/* Protection of (de-)allocation: mm, files, fs, tty */
+	spinlock_t alloc_lock;
+/* context-switch lock */
+	spinlock_t switch_lock;
+
+/* journalling filesystem info */
+	void *journal_info;
+	struct dentry *proc_dentry;
+	struct backing_dev_info *backing_dev_info;
+};
+
+typedef struct task_struct task_t;
+
+extern void __put_task_struct(struct task_struct *tsk);
+#define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
+#define put_task_struct(tsk) \
+do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
+
+/*
+ * Per process flags
+ */
+#define PF_ALIGNWARN	0x00000001	/* Print alignment warning msgs */
+					/* Not implemented yet, only for 486*/
+#define PF_STARTING	0x00000002	/* being created */
+#define PF_EXITING	0x00000004	/* getting shut down */
+#define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
+#define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
+#define PF_DUMPCORE	0x00000200	/* dumped core */
+#define PF_SIGNALED	0x00000400	/* killed by a signal */
+#define PF_MEMALLOC	0x00000800	/* Allocating memory */
+#define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
+#define PF_FREE_PAGES	0x00002000	/* per process page freeing */
+#define PF_FLUSHER	0x00004000	/* responsible for disk writeback */
+#define PF_NOWARN	0x00008000	/* debug: don't warn if alloc fails */
+
+#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
+#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
+#define PF_FROZEN	0x00040000	/* frozen for system suspend */
+#define PF_SYNC		0x00080000	/* performing fsync(), etc */
+#define PF_FSTRANS	0x00100000	/* inside a filesystem transaction */
+#define PF_KSWAPD	0x00200000	/* I am kswapd */
+
+/*
+ * Ptrace flags
+ */
+
+#define PT_PTRACED	0x00000001
+#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
+#define PT_TRACESYSGOOD	0x00000004
+#define PT_PTRACE_CAP	0x00000008	/* ptracer can follow suid-exec */
+
+extern struct task_struct init_task;
+
+
+/* True if we are on the alternate signal stack.  */
+
+static inline int on_sig_stack(unsigned long sp)
+{
+	return (sp - current->sas_ss_sp < current->sas_ss_size);
+}
+
+static inline int sas_ss_flags(unsigned long sp)
+{
+	return (current->sas_ss_size == 0 ? SS_DISABLE
+		: on_sig_stack(sp) ? SS_ONSTACK : 0);
+}
+
+#define __wait_event(wq, condition) 					\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (condition)						\
+			break;						\
+		schedule();						\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event(wq, condition) 					\
+do {									\
+	if (condition)	 						\
+		break;							\
+	__wait_event(wq, condition);					\
+} while (0)
+
+#define __wait_event_interruptible(wq, condition, ret)			\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_INTERRUPTIBLE);			\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			schedule();					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_interruptible(wq, condition)				\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__wait_event_interruptible(wq, condition, __ret);	\
+	__ret;								\
+})
+
+#define __wait_event_interruptible_timeout(wq, condition, ret)		\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_INTERRUPTIBLE);			\
+		if (condition)						\
+			break;						\
+		if (!signal_pending(current)) {				\
+			ret = schedule_timeout(ret);			\
+			if (!ret)					\
+				break;					\
+			continue;					\
+		}							\
+		ret = -ERESTARTSYS;					\
+		break;							\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define wait_event_interruptible_timeout(wq, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!(condition))						\
+		__wait_event_interruptible_timeout(wq, condition, __ret); \
+	__ret;								\
+})
+	
+#define remove_parent(p)	list_del_init(&(p)->sibling)
+#define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
+
+#define REMOVE_LINKS(p) do {					\
+	if (thread_group_leader(p))				\
+		list_del_init(&(p)->tasks);			\
+	remove_parent(p);					\
+	} while (0)
+
+#define SET_LINKS(p) do {					\
+	if (thread_group_leader(p))				\
+		list_add_tail(&(p)->tasks,&init_task.tasks);	\
+	add_parent(p, (p)->parent);				\
+	} while (0)
+
+static inline struct task_struct *eldest_child(struct task_struct *p)
+{
+	if (list_empty(&p->children)) return NULL;
+	return list_entry(p->children.next,struct task_struct,sibling);
+}
+
+static inline struct task_struct *youngest_child(struct task_struct *p)
+{
+	if (list_empty(&p->children)) return NULL;
+	return list_entry(p->children.prev,struct task_struct,sibling);
+}
+
+static inline struct task_struct *older_sibling(struct task_struct *p)
+{
+	if (p->sibling.prev==&p->parent->children) return NULL;
+	return list_entry(p->sibling.prev,struct task_struct,sibling);
+}
+
+static inline struct task_struct *younger_sibling(struct task_struct *p)
+{
+	if (p->sibling.next==&p->parent->children) return NULL;
+	return list_entry(p->sibling.next,struct task_struct,sibling);
+}
+
+#define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
+#define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
+
+#define for_each_process(p) \
+	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+
+/*
+ * Careful: do_each_thread/while_each_thread is a double loop so
+ *          'break' will not work as expected - use goto instead.
+ */
+#define do_each_thread(g, t) \
+	for (g = t = &init_task ; (g = t = next_task(g)) != &init_task ; ) do
+
+#define while_each_thread(g, t) \
+	while ((t = next_thread(t)) != g)
+
+#define thread_group_leader(p)	(p->pid == p->tgid)
+
+static inline int thread_group_empty(task_t *p)
+{
+	struct pid *pid = p->pids[PIDTYPE_TGID].pidptr;
+
+	return pid->task_list.next->next == &pid->task_list;
+}
+
+#define delay_group_leader(p) \
+		(thread_group_leader(p) && !thread_group_empty(p))
+
+/* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests inside tasklist_lock */
+static inline void task_lock(struct task_struct *p)
+{
+	spin_lock(&p->alloc_lock);
+}
+
+static inline void task_unlock(struct task_struct *p)
+{
+	spin_unlock(&p->alloc_lock);
+}
+
+ 
+/* set thread flags in other task's structures
+ * - see asm/thread_info.h for TIF_xxxx flags available
+ */
+static inline void set_tsk_thread_flag(struct task_struct *tsk, int flag)
+{
+	set_ti_thread_flag(tsk->thread_info,flag);
+}
+
+static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+{
+	clear_ti_thread_flag(tsk->thread_info,flag);
+}
+
+static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+{
+	return test_and_set_ti_thread_flag(tsk->thread_info,flag);
+}
+
+static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+{
+	return test_and_clear_ti_thread_flag(tsk->thread_info,flag);
+}
+
+static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
+{
+	return test_ti_thread_flag(tsk->thread_info,flag);
+}
+
+static inline void set_tsk_need_resched(struct task_struct *tsk)
+{
+	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+}
+
+static inline void clear_tsk_need_resched(struct task_struct *tsk)
+{
+	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+}
+
+static inline int signal_pending(struct task_struct *p)
+{
+	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
+}
+  
+static inline int need_resched(void)
+{
+	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
+}
+
+/*
+ * Wrappers for p->thread_info->cpu access. No-op on UP.
+ */
+#ifdef CONFIG_SMP
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return p->thread_info->cpu;
+}
+
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+	p->thread_info->cpu = cpu;
+}
+
+#else
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+}
+
+#endif /* CONFIG_SMP */
+
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_TASKS_H */





