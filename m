Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSF3VBB>; Sun, 30 Jun 2002 17:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSF3VBA>; Sun, 30 Jun 2002 17:01:00 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:44562 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S311710AbSF3VA4>; Sun, 30 Jun 2002 17:00:56 -0400
Date: Sun, 30 Jun 2002 23:03:21 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] break task_struct out of sched.h
Message-ID: <Pine.LNX.4.33.0206302250140.11122-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - move task_struct from <linux/sched.h> to its own header file
   <linux/task_struct.h>, and include it in sched.h.
 - Remove now unused #includes in sched.h, which get included
   through task_struct.h anyways.
 - include task_struct.h from <asm/current.h>, as "current->foo"  
   is by far the most often way of accessing current.

With this change files doing "current->foo" don't need to include sched.h
any more.

Patch applies to 2.5.24, a patch for 2.5.24-dj2 can be downloaded from
http://www.physik3.uni-rostock.de/tim/kernel/2.5/task_struct.h-05-dj.patch.gz

Tim


--- linux-2.5.24/include/linux/sched.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-task_struct/include/linux/sched.h	Sun Jun 30 20:34:47 2002
@@ -9,12 +9,11 @@
 #include <linux/capability.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/times.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
+#include <linux/task_struct.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -23,7 +22,6 @@
 #include <asm/mmu.h>
 
 #include <linux/smp.h>
-#include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
@@ -83,10 +81,6 @@
 
 #include <linux/time.h>
 #include <linux/param.h>
-#include <linux/resource.h>
-#include <linux/timer.h>
-
-#include <asm/processor.h>
 
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
@@ -244,127 +238,6 @@
 
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

--- linux-2.5.24/include/linux/task_struct.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.24-task_struct/include/linux/task_struct.h	Sun Jun 30 20:34:47 2002
@@ -0,0 +1,144 @@
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
+#include <asm/processor.h>
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/wait.h>
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

--- linux-2.5.24/include/asm-alpha/current.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-task_struct/include/asm-alpha/current.h	Sun Jun 30 22:06:58 2002
@@ -1,6 +1,7 @@
 #ifndef _ALPHA_CURRENT_H
 #define _ALPHA_CURRENT_H
 
+#include <linux/task_struct.h>
 #include <asm/thread_info.h>
 
 #define get_current()	(current_thread_info()->task + 0)

--- linux-2.5.24/include/asm-arm/current.h	Fri Jun 21 00:53:54 2002
+++ linux-2.5.24-task_struct/include/asm-arm/current.h	Sun Jun 30 22:07:28 2002
@@ -1,6 +1,7 @@
 #ifndef _ASMARM_CURRENT_H
 #define _ASMARM_CURRENT_H
 
+#include <linux/task_struct.h>
 #include <asm/thread_info.h>
 
 static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));

--- linux-2.5.24/include/asm-cris/current.h	Fri Jun 21 00:53:52 2002
+++ linux-2.5.24-task_struct/include/asm-cris/current.h	Sun Jun 30 22:07:59 2002
@@ -1,7 +1,7 @@
 #ifndef _CRIS_CURRENT_H
 #define _CRIS_CURRENT_H
 
-struct task_struct;
+#include <linux/task_struct.h>
 
 static inline struct task_struct * get_current(void)
 {

--- linux-2.5.24/include/asm-i386/current.h	Fri Jun 21 00:53:49 2002
+++ linux-2.5.24-task_struct/include/asm-i386/current.h	Sun Jun 30 22:08:25 2002
@@ -1,9 +1,8 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
+#include <linux/task_struct.h>
 #include <asm/thread_info.h>
-
-struct task_struct;
 
 static inline struct task_struct * get_current(void)
 {

--- linux-2.5.24/include/asm-ia64/current.h	Fri Jun 21 00:53:48 2002
+++ linux-2.5.24-task_struct/include/asm-ia64/current.h	Sun Jun 30 22:08:45 2002
@@ -1,6 +1,8 @@
 #ifndef _ASM_IA64_CURRENT_H
 #define _ASM_IA64_CURRENT_H
 
+#include <linux/task_struct.h>
+
 /*
  * Copyright (C) 1998-2000 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>

--- linux-2.5.24/include/asm-m68k/current.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-task_struct/include/asm-m68k/current.h	Sun Jun 30 22:08:58 2002
@@ -1,6 +1,8 @@
 #ifndef _M68K_CURRENT_H
 #define _M68K_CURRENT_H
 
+#include <linux/task_struct.h>
+
 register struct task_struct *current __asm__("%a2");
 
 #endif /* !(_M68K_CURRENT_H) */

--- linux-2.5.24/include/asm-mips/current.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-task_struct/include/asm-mips/current.h	Sun Jun 30 22:09:37 2002
@@ -11,6 +11,8 @@
 
 #ifdef _LANGUAGE_C
 
+#include <linux/task_struct.h>
+
 /* MIPS rules... */
 register struct task_struct *current asm("$28");
 

--- linux-2.5.24/include/asm-mips64/current.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-task_struct/include/asm-mips64/current.h	Sun Jun 30 22:09:43 2002
@@ -10,6 +10,8 @@
 
 #ifdef _LANGUAGE_C
 
+#include <linux/task_struct.h>
+
 /* MIPS rules... */
 register struct task_struct *current asm("$28");
 

--- linux-2.5.24/include/asm-parisc/current.h	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-task_struct/include/asm-parisc/current.h	Sun Jun 30 22:10:04 2002
@@ -1,9 +1,8 @@
 #ifndef _PARISC_CURRENT_H
 #define _PARISC_CURRENT_H
 
+#include <linux/task_struct.h>
 #include <asm/processor.h>
-
-struct task_struct;
 
 static inline struct task_struct * get_current(void)
 {

--- linux-2.5.24/include/asm-ppc/current.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-task_struct/include/asm-ppc/current.h	Sun Jun 30 22:10:22 2002
@@ -5,6 +5,8 @@
 #ifndef _PPC_CURRENT_H
 #define _PPC_CURRENT_H
 
+#include <linux/task_struct.h>
+
 /*
  * We keep `current' in r2 for speed.
  */

--- linux-2.5.24/include/asm-ppc64/current.h	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-task_struct/include/asm-ppc64/current.h	Sun Jun 30 22:10:29 2002
@@ -1,6 +1,8 @@
 #ifndef _PPC64_CURRENT_H
 #define _PPC64_CURRENT_H
 
+#include <linux/task_struct.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License

--- linux-2.5.24/include/asm-s390/current.h	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-task_struct/include/asm-s390/current.h	Sun Jun 30 22:10:38 2002
@@ -13,9 +13,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/task_struct.h>
 #include <asm/thread_info.h>
-
-struct task_struct;
 
 static inline struct task_struct * get_current(void)
 {

--- linux-2.5.24/include/asm-s390x/current.h	Fri Jun 21 00:53:57 2002
+++ linux-2.5.24-task_struct/include/asm-s390x/current.h	Sun Jun 30 22:10:45 2002
@@ -13,9 +13,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/task_struct.h>
 #include <asm/thread_info.h>
-
-struct task_struct;
 
 static inline struct task_struct * get_current(void)
 {

--- linux-2.5.24/include/asm-sh/current.h	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-task_struct/include/asm-sh/current.h	Sun Jun 30 22:10:57 2002
@@ -6,7 +6,7 @@
  *
  */
 
-struct task_struct;
+#include <linux/task_struct.h>
 
 static __inline__ struct task_struct * get_current(void)
 {

--- linux-2.5.24/include/asm-sparc/current.h	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-task_struct/include/asm-sparc/current.h	Sun Jun 30 22:11:04 2002
@@ -1,6 +1,8 @@
 #ifndef _SPARC_CURRENT_H
 #define _SPARC_CURRENT_H
 
+#include <linux/task_struct.h>
+
 /* Sparc rules... */
 register struct task_struct *current asm("g6");
 

--- linux-2.5.24/include/asm-sparc64/current.h	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-task_struct/include/asm-sparc64/current.h	Sun Jun 30 22:11:10 2002
@@ -1,6 +1,7 @@
 #ifndef _SPARC64_CURRENT_H
 #define _SPARC64_CURRENT_H
 
+#include <linux/task_struct.h>
 #include <asm/thread_info.h>
 
 register struct task_struct *current asm("g4");

--- linux-2.5.24/include/asm-x86_64/current.h	Fri Jun 21 00:53:43 2002
+++ linux-2.5.24-task_struct/include/asm-x86_64/current.h	Sun Jun 30 22:11:32 2002
@@ -2,8 +2,8 @@
 #define _X86_64_CURRENT_H
 
 #if !defined(__ASSEMBLY__) 
-struct task_struct;
 
+#include <linux/task_struct.h>
 #include <asm/pda.h>
 
 static inline struct task_struct *get_current(void) 

