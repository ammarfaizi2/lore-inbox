Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293715AbSCAUYS>; Fri, 1 Mar 2002 15:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293716AbSCAUYB>; Fri, 1 Mar 2002 15:24:01 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:14597 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S293715AbSCAUXe>; Fri, 1 Mar 2002 15:23:34 -0500
Date: Fri, 1 Mar 2002 21:22:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] moving task_struct
Message-ID: <Pine.LNX.4.21.0203012040220.32042-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below simply moves task_struct into its own header file.
This makes thread_info and task_struct indepedent from sched.h and will 
allows archs to decide themselves the dependencies between these
structures.

bye, Roman

diff -Nur -X /opt/home/roman/nodiff linux-2.5.6-pre2/include/linux/sched.h linux-task_struct/include/linux/sched.h
--- linux-2.5.6-pre2/include/linux/sched.h	Fri Mar  1 19:59:34 2002
+++ linux-task_struct/include/linux/sched.h	Fri Mar  1 20:10:21 2002
@@ -1,17 +1,13 @@
 #ifndef _LINUX_SCHED_H
 #define _LINUX_SCHED_H
 
-#include <asm/param.h>	/* for HZ */
-
 extern unsigned long event;
 
 #include <linux/config.h>
-#include <linux/capability.h>
+#include <linux/task_struct.h>
 #include <linux/tqueue.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/times.h>
 #include <linux/timex.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
@@ -24,7 +20,6 @@
 
 #include <linux/smp.h>
 #include <linux/sem.h>
-#include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
@@ -139,8 +134,6 @@
 extern rwlock_t tasklist_lock;
 extern spinlock_t mmlist_lock;
 
-typedef struct task_struct task_t;
-
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
 extern void show_state(void);
@@ -227,129 +220,6 @@
 
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
-	struct task_struct *next_task, *prev_task;
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
-	 * p->p_pptr->pid)
-	 */
-	struct task_struct *p_opptr, *p_pptr, *p_cptr, *p_ysptr, *p_osptr;
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
-	struct sem_undo *semundo;
-	struct sem_queue *semsleeping;
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
-};
-
-extern void __put_task_struct(struct task_struct *tsk);
-#define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
-#define put_task_struct(tsk) \
-do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
 
 /*
  * Per process flags
diff -Nur -X /opt/home/roman/nodiff linux-2.5.6-pre2/include/linux/task_struct.h linux-task_struct/include/linux/task_struct.h
--- linux-2.5.6-pre2/include/linux/task_struct.h	Thu Jan  1 01:00:00 1970
+++ linux-task_struct/include/linux/task_struct.h	Fri Mar  1 20:16:24 2002
@@ -0,0 +1,139 @@
+#ifndef _LINUX_TASK_STRUCT_H
+#define _LINUX_TASK_STRUCT_H
+
+#include <linux/list.h>
+#include <linux/capability.h>
+#include <linux/resource.h>
+#include <linux/signal.h>
+#include <linux/timer.h>
+#include <linux/times.h>
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <asm/atomic.h>
+#include <asm/param.h>
+
+typedef struct task_struct task_t;
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
+	struct task_struct *next_task, *prev_task;
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
+	 * p->p_pptr->pid)
+	 */
+	struct task_struct *p_opptr, *p_pptr, *p_cptr, *p_ysptr, *p_osptr;
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
+	struct tty_struct *tty; /* NULL if no tty */
+	unsigned int locks; /* How many file locks are being held */
+/* ipc stuff */
+	struct sem_undo *semundo;
+	struct sem_queue *semsleeping;
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
+};
+
+extern void __put_task_struct(struct task_struct *tsk);
+#define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
+#define put_task_struct(tsk) \
+do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
+
+#endif	/* _LINUX_TASK_STRUCT_H */


