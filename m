Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261753AbSI2Tph>; Sun, 29 Sep 2002 15:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSI2Tph>; Sun, 29 Sep 2002 15:45:37 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:47534 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261753AbSI2Tpb>; Sun, 29 Sep 2002 15:45:31 -0400
Date: Sun, 29 Sep 2002 21:50:48 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] break out task_struct from sched.h
Message-ID: <Pine.LNX.4.33.0209292137550.7800-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch separates struct task_struct from <linux/sched.h> to 
a new header <linux/task_struct.h>, so that dereferencing 'current'
doesn't require to #include <linux/sched.h> and all of the 138 files it 
drags in.
 
This is a preparatory step (and currently part of) the patch to remove
614 superfluous #includes of <linux/sched.h> at
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-16.patch.gz

I hope you are the appropriate lieutnant for this kind of janitorial stuff 
and would ask you to pass this on to Linus.

Thanks,
Tim (Tim Schmielau <tim@physik3.uni-rostock.de>)


--- linux-2.5.39/include/linux/sched.h	Sat Sep 28 16:53:22 2002
+++ linux-2.5.39-sr0/include/linux/sched.h	Sat Sep 28 16:58:10 2002
@@ -9,11 +9,11 @@
 #include <linux/capability.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
+#include <linux/task_struct.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -22,7 +22,6 @@
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
-#include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
@@ -92,10 +91,6 @@
 
 #include <linux/time.h>
 #include <linux/param.h>
-#include <linux/resource.h>
-#include <linux/timer.h>
-
-#include <asm/processor.h>
 
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
@@ -279,171 +274,7 @@
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
-	spinlock_t sigmask_lock;	/* Protects signal and blocked */
-	struct signal_struct *sig;
-
-	sigset_t blocked, real_blocked, shared_unblocked;
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
-
-/*
- * Ptrace flags
- */
 
-#define PT_PTRACED	0x00000001
-#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
-#define PT_TRACESYSGOOD	0x00000004
-#define PT_PTRACE_CAP	0x00000008	/* ptracer can follow suid-exec */
 
 /*
  * Limit the stack by to some sane default: root can always

--- linux-2.5.39/include/linux/task_struct.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.39-sr0/include/linux/task_struct.h	Sat Sep 28 17:05:52 2002
@@ -0,0 +1,189 @@
+#ifndef _LINUX_TASK_STRUCT_H
+#define _LINUX_TASK_STRUCT_H
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
+#include <asm/processor.h>
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/wait.h>
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
+	spinlock_t sigmask_lock;	/* Protects signal and blocked */
+	struct signal_struct *sig;
+
+	sigset_t blocked, real_blocked, shared_unblocked;
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
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_TASK_STRUCT_H */

