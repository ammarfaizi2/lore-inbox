Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbRBJOuY>; Sat, 10 Feb 2001 09:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131529AbRBJOuO>; Sat, 10 Feb 2001 09:50:14 -0500
Received: from smtp.mountain.net ([198.77.1.35]:55813 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131528AbRBJOuD>;
	Sat, 10 Feb 2001 09:50:03 -0500
Message-ID: <3A8554FA.AB33BE05@mountain.net>
Date: Sat, 10 Feb 2001 09:49:30 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Athlon-SMP compiles & runs. inline fns honored.
Content-Type: multipart/mixed;
 boundary="------------699B5749B9537350FE61A949"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------699B5749B9537350FE61A949
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan

I found one way to break the circularity. The association of type and struct
definitions with interlocking inline functions caused the problem. This
extracts task_struct from linux/sched.h to its own header,
linux/task_struct.h. There are a few modifications elsewhere to support
this. I'm not sure all the changes were necessary, but they are working as I
write:

$ uname -a
Linux mercury 2.4.1 #3 SMP Sat Feb 10 08:28:39 EST 2001 i686 unknown
$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 1
model name	: AMD-K7(tm) Processor
stepping	: 2
cpu MHz		: 704.949
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat mmx
syscall mmxext 3dnowext 3dnow
bogomips	: 1405.74

I don't have access to a real SMP Athlon box, so I'd appreciate test reports
on the real thing. I expect some polishing will be needed.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
--------------699B5749B9537350FE61A949
Content-Type: text/plain; charset=us-ascii;
 name="k7-smp-inlined.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k7-smp-inlined.patch"

diff -uNr linux-2.4.1-pristine/include/asm-i386/string.h linux/include/asm-i386/string.h
--- linux-2.4.1-pristine/include/asm-i386/string.h	Tue Feb  6 03:55:24 2001
+++ linux/include/asm-i386/string.h	Sat Feb 10 08:28:32 2001
@@ -289,10 +289,9 @@
 
 /* All this just for in_interrupt() ... */
 
-#include <asm/system.h>
-#include <asm/ptrace.h>
+#include <linux/task_struct.h>
+#include <asm/current.h>
 #include <linux/smp.h>
-#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <asm/mmx.h>
 
diff -uNr linux-2.4.1-pristine/include/linux/capability.h linux/include/linux/capability.h
--- linux-2.4.1-pristine/include/linux/capability.h	Thu Feb  8 23:55:24 2001
+++ linux/include/linux/capability.h	Sat Feb 10 07:41:19 2001
@@ -14,7 +14,9 @@
 #define _LINUX_CAPABILITY_H
 
 #include <linux/types.h>
+/* Try removing -- we'll see if there are parasitic users
 #include <linux/fs.h>
+*/
 
 /* User-level do most of the mapping between kernel and user
    capabilities based on the version tag given by the kernel. The
diff -uNr linux-2.4.1-pristine/include/linux/mm_struct.h linux/include/linux/mm_struct.h
--- linux-2.4.1-pristine/include/linux/mm_struct.h	Wed Dec 31 19:00:00 1969
+++ linux/include/linux/mm_struct.h	Sat Feb 10 08:02:15 2001
@@ -0,0 +1,47 @@
+#ifndef _LINUX_MM_STRUCT_H
+#define _LINUX_MM_STRUCT_H
+/*
+ *  linux/struct_mm.h
+ *  Extracted from linux/sched.h: 02/09/2001 Tom Leete
+ *  
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+#include <asm/spinlock.h>
+
+
+#ifndef _LINUX_MM_H
+struct vm_area_struct;
+#endif
+
+struct mm_struct {
+	struct vm_area_struct * mmap;		/* list of VMAs */
+	struct vm_area_struct * mmap_avl;	/* tree of VMAs */
+	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	pgd_t * pgd;
+	atomic_t mm_users;			/* How many users with user space? */
+	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
+	int map_count;				/* number of VMAs */
+	struct semaphore mmap_sem;
+	spinlock_t page_table_lock;
+
+	struct list_head mmlist;		/* List of all active mm's */
+
+	unsigned long start_code, end_code, start_data, end_data;
+	unsigned long start_brk, brk, start_stack;
+	unsigned long arg_start, arg_end, env_start, env_end;
+	unsigned long rss, total_vm, locked_vm;
+	unsigned long def_flags;
+	unsigned long cpu_vm_mask;
+	unsigned long swap_address;
+
+	/* Architecture-specific MM context */
+	mm_context_t context;
+};
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_STRUCT_H */
diff -uNr linux-2.4.1-pristine/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.4.1-pristine/include/linux/sched.h	Thu Feb  8 23:55:24 2001
+++ linux/include/linux/sched.h	Sat Feb 10 08:28:32 2001
@@ -11,6 +11,7 @@
 #include <linux/threads.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/time.h>
 #include <linux/times.h>
 #include <linux/timex.h>
 
@@ -200,30 +201,7 @@
 /* Number of map areas at which the AVL tree is activated. This is arbitrary. */
 #define AVL_MIN_MAP_COUNT	32
 
-struct mm_struct {
-	struct vm_area_struct * mmap;		/* list of VMAs */
-	struct vm_area_struct * mmap_avl;	/* tree of VMAs */
-	struct vm_area_struct * mmap_cache;	/* last find_vma result */
-	pgd_t * pgd;
-	atomic_t mm_users;			/* How many users with user space? */
-	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
-	int map_count;				/* number of VMAs */
-	struct semaphore mmap_sem;
-	spinlock_t page_table_lock;
-
-	struct list_head mmlist;		/* List of all active mm's */
-
-	unsigned long start_code, end_code, start_data, end_data;
-	unsigned long start_brk, brk, start_stack;
-	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm;
-	unsigned long def_flags;
-	unsigned long cpu_vm_mask;
-	unsigned long swap_address;
-
-	/* Architecture-specific MM context */
-	mm_context_t context;
-};
+#include <linux/mm_struct.h>
 
 extern int mmlist_nr;
 
@@ -275,127 +253,7 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-struct task_struct {
-	/*
-	 * offsets of these are hardcoded elsewhere - touch with care
-	 */
-	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	unsigned long flags;	/* per process flags, defined below */
-	int sigpending;
-	mm_segment_t addr_limit;	/* thread address space:
-					 	0-0xBFFFFFFF for user-thead
-						0-0xFFFFFFFF for kernel-thread
-					 */
-	struct exec_domain *exec_domain;
-	volatile long need_resched;
-	unsigned long ptrace;
-
-	int lock_depth;		/* Lock depth */
-
-/*
- * offset 32 begins here on 32-bit platforms. We keep
- * all fields in a single cacheline that are needed for
- * the goodness() loop in schedule().
- */
-	long counter;
-	long nice;
-	unsigned long policy;
-	struct mm_struct *mm;
-	int has_cpu, processor;
-	unsigned long cpus_allowed;
-	/*
-	 * (only the 'next' pointer fits into the cacheline, but
-	 * that's just fine.)
-	 */
-	struct list_head run_list;
-	unsigned long sleep_time;
-
-	struct task_struct *next_task, *prev_task;
-	struct mm_struct *active_mm;
-
-/* task state */
-	struct linux_binfmt *binfmt;
-	int exit_code, exit_signal;
-	int pdeath_signal;  /*  The signal sent when the parent dies  */
-	/* ??? */
-	unsigned long personality;
-	int dumpable:1;
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
-	struct semaphore *vfork_sem;		/* for vfork() */
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
-	int link_count;
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
-};
+#include <linux/task_struct.h>
 
 /*
  * Per process flags
diff -uNr linux-2.4.1-pristine/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.4.1-pristine/include/linux/signal.h	Thu Feb  8 23:55:24 2001
+++ linux/include/linux/signal.h	Sat Feb 10 08:28:32 2001
@@ -14,10 +14,7 @@
 	siginfo_t info;
 };
 
-struct sigpending {
-	struct sigqueue *head, **tail;
-	sigset_t signal;
-};
+#include <linux/sigpending.h>
 
 /*
  * Define some primitives to manipulate sigset_t.
diff -uNr linux-2.4.1-pristine/include/linux/sigpending.h linux/include/linux/sigpending.h
--- linux-2.4.1-pristine/include/linux/sigpending.h	Wed Dec 31 19:00:00 1969
+++ linux/include/linux/sigpending.h	Sat Feb 10 07:41:20 2001
@@ -0,0 +1,19 @@
+#ifndef _LINUX_SIGPENDING_H
+#define _LINUX_SIGPENDING_H
+
+#include <asm/signal.h>
+
+#ifdef __KERNEL__
+
+#ifndef _LINUX_SIGNAL_H
+struct sigqueue;
+#endif
+
+struct sigpending {
+	struct sigqueue *head, **tail;
+	sigset_t signal;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_SIGPENDING_H */
diff -uNr linux-2.4.1-pristine/include/linux/task_struct.h linux/include/linux/task_struct.h
--- linux-2.4.1-pristine/include/linux/task_struct.h	Wed Dec 31 19:00:00 1969
+++ linux/include/linux/task_struct.h	Sat Feb 10 08:26:57 2001
@@ -0,0 +1,212 @@
+#ifndef _LINUX_TASK_STRUCT_H
+#define _LINUX_TASK_STRUCT_H
+/*
+ *  struct_task.h:
+ *      Extracted from linux/sched.h:  01/09/2001 Tom Leete
+ *      sched.h is too high level, there are things like string.h
+ *      which need to dereference data in this struct, was introducing
+ *      circular dependencies.
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+/* for run_list, thread_group */
+#include <linux/list.h>
+
+/* for addr_limit, thread */
+#include <asm/processor.h>
+
+/* for real_timer */
+#include <linux/timer.h>
+
+/* for times */
+#include <linux/times.h>
+
+/* for sigmask_lock, alloc_lock */
+#include <linux/spinlock.h>
+
+/* for rlim[] */
+#include <linux/resource.h>
+
+/* for blocked */
+#include <asm/signal.h>
+
+/* for pending */
+#include <linux/sigpending.h>
+
+/* for wait_chldexit*/
+#include <linux/wait.h>
+
+/* for caps */
+#include <linux/capability.h>
+
+#ifndef _PERSONALITY_H
+struct exec_domain;
+#endif
+
+#ifndef _STRUCT_MM_H
+struct mm_struct;
+#endif
+
+#ifndef _LINUX_BINFMTS_H
+struct linux_binfmt;
+#endif
+
+#ifndef _ARCH_SEMAPHORE_H
+struct semaphore;
+#endif
+
+#ifndef _LINUX_FS_STRUCT_H
+struct fs_struct;
+#endif
+
+#ifndef _LINUX_IPC_H
+struct sem_undo;
+struct sem_queue;
+#endif
+
+#ifndef _LINUX_TTY_H
+struct tty_struct;
+#endif
+
+/* Try removing /linux/fs.h in capability.h first
+#ifndef _LINUX_CAPABILITY_H
+typedef struct bogus_cap_struct {
+	__u32 cap;
+} kernel_cap_t;
+#endif
+*/
+
+#ifndef _LINUX_SCHED_H
+struct files_struct;
+struct user_struct;
+struct signal_struct;
+#endif
+
+struct task_struct {
+	/*
+	 * offsets of these are hardcoded elsewhere - touch with care
+	 */
+	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
+	unsigned long flags;	/* per process flags, defined below */
+	int sigpending;
+	mm_segment_t addr_limit;	/* thread address space:
+					 	0-0xBFFFFFFF for user-thead
+						0-0xFFFFFFFF for kernel-thread
+					 */
+  struct exec_domain *exec_domain; /* confusion alert :-) */
+	volatile long need_resched;
+	unsigned long ptrace;
+
+	int lock_depth;		/* Lock depth */
+
+/*
+ * offset 32 begins here on 32-bit platforms. We keep
+ * all fields in a single cacheline that are needed for
+ * the goodness() loop in schedule().
+ */
+	long counter;
+	long nice;
+	unsigned long policy;
+	struct mm_struct *mm;
+	int has_cpu, processor;
+	unsigned long cpus_allowed;
+	/*
+	 * (only the 'next' pointer fits into the cacheline, but
+	 * that's just fine.)
+	 */
+	struct list_head run_list;
+	unsigned long sleep_time;
+
+	struct task_struct *next_task, *prev_task;
+	struct mm_struct *active_mm;
+
+/* task state */
+	struct linux_binfmt *binfmt;
+	int exit_code, exit_signal;
+	int pdeath_signal;  /*  The signal sent when the parent dies  */
+	/* ??? */
+	unsigned long personality;
+	int dumpable:1;
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
+	struct semaphore *vfork_sem;		/* for vfork() */
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
+	int link_count;
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
+};
+
+#endif /*  __KERNEL__ */
+#endif /* _LINUX_TASK_STRUCT_H */

--------------699B5749B9537350FE61A949--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
