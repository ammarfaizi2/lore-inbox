Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316846AbSEaVLu>; Fri, 31 May 2002 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSEaVLt>; Fri, 31 May 2002 17:11:49 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:53513 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316846AbSEaVLq>; Fri, 31 May 2002 17:11:46 -0400
Date: Fri, 31 May 2002 23:11:44 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: trivial linux patches <trivial@rustcorp.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] break task_struct out of sched.h
Message-ID: <Pine.LNX.4.33.0205312306220.19569-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Move task_struct from <linux/sched.h> to its own header file
   <linux/task_struct.h>, and include it in sched.h.

 - Remove now unused #includes in sched.h, which get included
   through task_struct.h anyways.

With this change files doing "current->foo" may include only
task_struct.h instead of the whole sched.h.

Tim


--- linux-2.5.19/include/linux/sched.h	Fri May 31 20:33:31 2002
+++ linux-2.5.19-ts/include/linux/sched.h	Fri May 31 22:22:04 2002
@@ -10,8 +10,6 @@
 #include <linux/tqueue.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/times.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
@@ -24,7 +22,6 @@
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
-#include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
@@ -84,10 +81,6 @@
 
 #include <linux/time.h>
 #include <linux/param.h>
-#include <linux/resource.h>
-#include <linux/timer.h>
-
-#include <asm/processor.h>
 
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
@@ -131,6 +124,7 @@
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
+#include <linux/task_struct.h>
 
 /*
  * This serializes "schedule()" and also protects
@@ -246,127 +240,6 @@
 
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
-
-typedef struct prio_array prio_array_t;
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
-	list_t run_list;
-	prio_array_t *array;
-
-	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
-
-	unsigned long policy;
-	unsigned long cpus_allowed;
-	unsigned int time_slice;
-
-	struct list_head tasks;
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
-	struct list_head thread_group;
-
-	/* PID hash table linkage. */
-	struct task_struct *pidhash_next;
-	struct task_struct **pidhash_pprev;
-
-	wait_queue_head_t wait_chldexit;	/* for wait4() */
-	struct completion *vfork_done;		/* for vfork() */
-
-	unsigned long rt_priority;
-	unsigned long it_real_value, it_prof_value, it_virt_value;
-	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
-	struct timer_list real_timer;
-	struct tms times;
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
-	sigset_t blocked;
-	struct sigpending pending;
-
-	unsigned long sas_ss_sp;
-	size_t sas_ss_size;
-	int (*notifier)(void *priv);
-	void *notifier_data;
-	sigset_t *notifier_mask;
-	
-/* Thread group tracking */
-   	u32 parent_exec_id;
-   	u32 self_exec_id;
-/* Protection of (de-)allocation: mm, files, fs, tty */
-	spinlock_t alloc_lock;
-
-/* journalling filesystem info */
-	void *journal_info;
-	struct dentry *proc_dentry;
-};
 
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)

--- linux-2.5.19/include/linux/task_struct.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.19-ts/include/linux/task_struct.h	Fri May 31 22:30:48 2002
@@ -0,0 +1,144 @@
+#ifndef _LINUX_TASK_STRUCT_H
+#define _LINUX_TASK_STRUCT_H
+
+#include <linux/types.h>
+#include <linux/times.h>
+#include <linux/sem.h>
+#include <linux/resource.h>
+#include <linux/timer.h>
+#include <asm/processor.h>
+
+#ifdef __KERNEL__
+
+#include <linux/capability.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <asm/atomic.h>
+#include <asm/signal.h>
+
+typedef struct prio_array prio_array_t;
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
+	list_t run_list;
+	prio_array_t *array;
+
+	unsigned long sleep_avg;
+	unsigned long sleep_timestamp;
+
+	unsigned long policy;
+	unsigned long cpus_allowed;
+	unsigned int time_slice;
+
+	struct list_head tasks;
+
+	struct mm_struct *mm, *active_mm;
+	struct list_head local_pages;
+
+	unsigned int allocation_order, nr_local_pages;
+
+/* task state */
+	struct linux_binfmt *binfmt;
+	int exit_code, exit_signal;
+	int pdeath_signal;	/*  The signal sent when the parent dies  */
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
+	struct task_struct *real_parent; /* real parent process	(when being debugged) */
+	struct task_struct *parent;	/* parent process */
+	struct list_head children;	/* list of my children */
+	struct list_head sibling;	/* linkage in my parent's children list */
+	struct list_head thread_group;
+
+	/* PID hash table linkage. */
+	struct task_struct *pidhash_next;
+	struct task_struct **pidhash_pprev;
+
+	wait_queue_head_t wait_chldexit;	/* for wait4() */
+	struct completion *vfork_done;		/* for vfork() */
+
+	unsigned long rt_priority;
+	unsigned long it_real_value, it_prof_value, it_virt_value;
+	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
+	struct timer_list real_timer;
+	struct tms times;
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
+	struct tty_struct *tty;		/* NULL if no tty */
+	unsigned int locks;		/* How many file locks are being held */
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
+	sigset_t blocked;
+	struct sigpending pending;
+
+	unsigned long sas_ss_sp;
+	size_t sas_ss_size;
+	int (*notifier)(void *priv);
+	void *notifier_data;
+	sigset_t *notifier_mask;
+	
+/* Thread group tracking */
+   	u32 parent_exec_id;
+   	u32 self_exec_id;
+/* Protection of (de-)allocation: mm, files, fs, tty */
+	spinlock_t alloc_lock;
+
+/* journalling filesystem info */
+	void *journal_info;
+	struct dentry *proc_dentry;
+};
+
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_TASK_STRUCT_H */


