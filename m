Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKVT3J>; Wed, 22 Nov 2000 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129410AbQKVT27>; Wed, 22 Nov 2000 14:28:59 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:2830 "HELO
        dfmail.f-secure.com") by vger.kernel.org with SMTP
        id <S129091AbQKVT2r>; Wed, 22 Nov 2000 14:28:47 -0500
Date: Wed, 22 Nov 2000 20:09:44 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: <linux-kernel@vger.kernel.org>
cc: <linux-mm@kvack.org>
Subject: [PATCH] Reserved root VM + OOM killer
Message-ID: <Pine.LNX.4.30.0011221736000.14122-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



WHY?
Permanent memory need by user apps makes Linux uncontrollable in OOM
(out of memory) situation when OOM killer can't kill as fast as the
memory needed (and your superb 'free memory space' monitor/actor
developed in the last 5 years was also killed and init couldn't
restart it because of OOM). In the Unix world it's a common good
practice to reserve resources for root (see e.g. disk space, network
ports, file descriptors, processes, etc). Linux doesn't reserve
virtual memory for root so if OOM happens by user apps you get this
kind of messages as root when trying to make the system work again
properly or investigate what happend,

running a command from prompt:
  Memory exhausted
  Segmentation fault
  fork failed: resource temporarily unavailable
trying to login from console:
  Unable to load interpreter /lib/ld-linux.so.2
  error while loading shared libraries: libc.so.6:
      cannot map zero-fill pages: Cannot allocate memory
  error while loading shared libraries: libtermcap.so.2: failed
      to map segment from shared object: Cannot allocate memory
  xrealloc: cannot reallocate 128 bytes (0 bytes allocated)
  xmalloc: cannot allocate 562 bytes (0 bytes allocated)
trying to ssh via network:
  Received disconnect: Command terminated on signal 11.

WHAT?
This patch tries to reserve virtual memory for root, balance memory
usage between root and user apps if memory is overcommited and has
Rik's OOM killer that is much more clever about what to kill when OOM
happens than what's inlcuded in standard 2.2 kernels.

HOW?
No performance loss, RAM is always fully utilized (except if no swap),
the tunable reserved memory is on swap (or in caches) until it's
needed by root. There are two scenarios. When user apps don't
overcommit memory they will see only
  UVM = (real virtual memory) - (reserved virtual memory for root)
If memory is overcommited then user apps will also use the reserved
memory (otherwise there would be a performance loss as I guess) but
the kernel will try hard to push them back below UVM.

IN THE PATCH:
 - reserved VM for root
 - Rik's OOM killer from 2.4.0-test11 with "fixes":
   - PID 1 never gets killed by OOM killer
   - OOM killing takes place only in do_page_fault() [no two places in
        the kernel for process killing]
   - niced processes are not penalized
 - IPC shared mem can only be kvazi-overcommited (i.e. request is
       successful only if there is enough VM at the request time)

NOTES:
 - it's for 2.2 (late) kernels [tested with 2.2.18pre21, applies to
     2.2.18pre22 as well]
 - Intel only [page fault handling is implemented differently
     in different architectures, no common hooks but easy to fix]
 - SMP not tested
 - GUI environment not tested
 - tests were done with constant brk, mmap, zfod, cow, IPC shm fork
     bombs on mostly a 64-128 RAM MB + 80 MB swap box.
 - using IPC shared mem still can "kill" the box (unused mem not
     freed). Use Solar Designer kernel security patch or set
     /proc/sys/kernel/shmall according to your VM
 - it's not for common fork bombs (use e.g. fair scheduler,
     Fork Bomb Defuser, etc against them). Use ulimit -u if you want
     to test the patch and don't have enough CPU power
 - the reserved virtual memory can be set runtime via
     /proc/sys/vm/reserved The value is in pages (4096 bytes on x86)
 - On SMP you should probably increase this value in the function
     of you CPU's
 - if you have GB's of VM you can experience malloc() scalability
     problems, use glibc 2.2, limit your VM, raise the limits
     via malloc environment variables, etc.

PROBLEMS:
 - if killable task is in TASK_UNINTERRUPTIBLE constantly [e.g. becasue
     of network fs (smb, nfs, etc) problems] then OOM killer won't
     work ... at least this is what I suspect
 - schedule() doesn't always immediately schedules the killable task
 - probably others I'm not aware of

Standard disclaimer applies. It worked fine for me but maybe it will
eat your whole computer and pets :) It's not perfect but seems good
enough and I definitely found it much better then what is in 2.2
kernels. Of course your experience can be completely different. Please
let me know.

	Szaka

diff -urw linux-2.2.18pre21/arch/i386/mm/Makefile linux/arch/i386/mm/Makefile
--- linux-2.2.18pre21/arch/i386/mm/Makefile	Fri Nov  1 04:56:43 1996
+++ linux/arch/i386/mm/Makefile	Tue Nov 21 03:03:15 2000
@@ -8,6 +8,6 @@
 # Note 2! The CFLAGS definition is now in the main makefile...

 O_TARGET := mm.o
-O_OBJS	 := init.o fault.o ioremap.o extable.o
+O_OBJS	 := init.o fault.o ioremap.o extable.o ../../../mm/oom_kill.o

 include $(TOPDIR)/Rules.make
diff -urw linux-2.2.18pre21/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.2.18pre21/arch/i386/mm/fault.c	Wed May  3 20:16:31 2000
+++ linux/arch/i386/mm/fault.c	Tue Nov 21 05:49:36 2000
@@ -23,6 +23,7 @@
 #include <asm/hardirq.h>

 extern void die(const char *,struct pt_regs *,long);
+extern int oom_kill(void);

 /*
  * Ugly, ugly, but the goto's result in better assembly..
@@ -291,25 +292,14 @@
 	up(&mm->mmap_sem);
 	if (error_code & 4)
 	{
-		if (tsk->oom_kill_try++ > 10 ||
-		    !((regs->eflags >> 12) & 3))
-		{
-			printk("VM: killing process %s\n", tsk->comm);
+		if (oom_kill()) {
+			printk(KERN_ERR "Out of Memory: Killed process "
+				"%d (%s)\n", tsk->pid, tsk->comm);
 			do_exit(SIGKILL);
-		}
-		else
-		{
-			/*
-			 * The task is running with privilegies and so we
-			 * trust it and we give it a chance to die gracefully.
-			 */
-			printk("VM: terminating process %s\n", tsk->comm);
-			force_sig(SIGTERM, current);
-			if (tsk->oom_kill_try > 1)
-			{
+		} else {
+			/* we must kill a different process */
 				tsk->policy |= SCHED_YIELD;
 				schedule();
-			}
 			return;
 		}
 	}
diff -urw linux-2.2.18pre21/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.2.18pre21/include/linux/sysctl.h	Thu Nov  9 08:20:19 2000
+++ linux/include/linux/sysctl.h	Tue Nov 21 08:43:22 2000
@@ -122,7 +122,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_ROOT_RESERVED=11	/* int: number of pages reserved for root */
 };


diff -urw linux-2.2.18pre21/ipc/shm.c linux/ipc/shm.c
--- linux-2.2.18pre21/ipc/shm.c	Wed Jun  7 17:26:44 2000
+++ linux/ipc/shm.c	Mon Nov 13 03:50:51 2000
@@ -101,8 +101,8 @@
 		return -ENOMEM;
 	}

-	shp->shm_pages = (ulong *) vmalloc (numpages*sizeof(ulong));
-	if (!shp->shm_pages) {
+	if (!vm_enough_memory(numpages)
+	    || !(shp->shm_pages = (ulong *) vmalloc(numpages*sizeof(ulong)))) {
 		shm_segs[id] = (struct shmid_kernel *) IPC_UNUSED;
 		wake_up (&shm_lock);
 		kfree(shp);
diff -urw linux-2.2.18pre21/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.2.18pre21/kernel/sysctl.c	Thu Nov  9 08:20:19 2000
+++ linux/kernel/sysctl.c	Tue Nov 21 08:44:11 2000
@@ -32,6 +32,7 @@
 #if defined(CONFIG_SYSCTL)

 /* External variables not in a header file. */
+extern int vm_reserved;
 extern int panic_timeout;
 extern int console_loglevel, C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
@@ -249,6 +250,8 @@
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
+	{VM_ROOT_RESERVED, "reserved",
+	 &vm_reserved, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_BUFFERMEM, "buffermem",
 	 &buffer_mem, sizeof(buffer_mem_t), 0644, NULL, &proc_dointvec},
 	{VM_PAGECACHE, "pagecache",
diff -urw linux-2.2.18pre21/mm/mmap.c linux/mm/mmap.c
--- linux-2.2.18pre21/mm/mmap.c	Thu Nov  9 08:20:19 2000
+++ linux/mm/mmap.c	Tue Nov 21 08:45:14 2000
@@ -40,6 +40,7 @@
 kmem_cache_t *vm_area_cachep;

 int sysctl_overcommit_memory;
+int vm_reserved;

 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -67,6 +68,8 @@
 	free += nr_free_pages;
 	free += nr_swap_pages;
 	free -= (page_cache.min_percent + buffer_mem.min_percent + 2)*num_physpages/100;
+	if (current->uid && free < vm_reserved)
+		return 0;
 	return free > pages;
 }

@@ -872,6 +875,23 @@

 void __init vma_init(void)
 {
+        struct sysinfo i;
+
+        /*
+	 * Setup default reserved VM pages for root. You can tune it
+         * via /proc/sys/vm/reserved. Default value is based on RAM size
+         *    - no reserved pages if RAM is less than 8MB
+         *    - 5MB should be enough on boxes w/ RAM > 100 MB
+         *    - otherwise reserve 5%
+	 */
+        si_meminfo(&i);
+        if (i.totalram < 8 * 1024 * 1024)
+                vm_reserved = 0;
+        else if (i.totalram > 100 * 1024 * 1024)
+                vm_reserved = 5 * 1024 * 1024 >> PAGE_SHIFT;
+        else
+                vm_reserved = (i.totalram >> PAGE_SHIFT) / 20;
+
 	vm_area_cachep = kmem_cache_create("vm_area_struct",
 					   sizeof(struct vm_area_struct),
 					   0, SLAB_HWCACHE_ALIGN,
diff -urw linux-2.2.18pre21/mm/oom_kill.c linux/mm/oom_kill.c
--- linux-2.2.18pre21/mm/oom_kill.c	Fri Nov 17 00:07:57 2000
+++ linux/mm/oom_kill.c	Wed Nov 22 17:59:04 2000
@@ -0,0 +1,186 @@
+/*
+ *  linux/mm/oom_kill.c
+ *
+ *  Copyright (C)  1998,2000  Rik van Riel
+ *	Thanks go out to Claus Fischer for some serious inspiration and
+ *	for goading me into coding this file...
+ *
+ *  The routines in this file are used to kill a process when
+ *  we're seriously out of memory. This gets called from kswapd()
+ *  in linux/mm/vmscan.c when we really run out of memory.
+ *
+ *  Since we won't call these routines often (on a well-configured
+ *  machine) this file will double as a 'coding guide' and a signpost
+ *  for newbie kernel hackers. It features several pointers to major
+ *  kernel subsystems and hints as to where to find out what things do.
+ */
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/swap.h>
+#include <linux/swapctl.h>
+#include <linux/timex.h>
+
+/* #define DEBUG */
+
+/**
+ * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
+ * @x: integer of which to calculate the sqrt
+ *
+ * A rough approximation to the sqrt() function.
+ */
+static inline unsigned int int_sqrt(unsigned int x)
+{
+	unsigned int out = x;
+	while (x & ~(unsigned int)1) x >>=2, out >>=1;
+	if (x) out -= out >> 2;
+	return (out ? out : 1);
+}
+
+/**
+ * oom_badness - calculate a numeric value for how bad this task has been
+ * @p: task struct of which task we should calculate
+ *
+ * The formula used is relatively simple and documented inline in the
+ * function. The main rationale is that we want to select a good task
+ * to kill when we run out of memory.
+ *
+ * Good in this context means that:
+ * 1) we lose the minimum amount of work done
+ * 2) we recover a large amount of memory
+ * 3) we don't kill anything innocent of eating tons of memory
+ * 4) we want to kill the minimum amount of processes (one)
+ */
+
+static int badness(struct task_struct *p)
+{
+	int points, cpu_time, run_time;
+
+	if (!p->mm)
+		return 0;
+	/*
+	 * The memory size of the process is the basis for the badness.
+	 */
+	points = p->mm->total_vm;
+
+	/*
+	 * CPU time is in seconds and run time is in minutes. There is no
+	 * particular reason for this other than that it turned out to work
+	 * very well in practice. This is not safe against jiffie wraps
+	 * but we don't care _that_ much...
+	 */
+	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
+	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+
+	points /= int_sqrt(cpu_time);
+	points /= int_sqrt(int_sqrt(run_time));
+
+	/*
+	 * Superuser processes are usually more important, so we make it
+	 * less likely that we kill those.
+	 */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
+				p->uid == 0 || p->euid == 0)
+		points /= 4;
+
+	/*
+	 * We don't want to kill a process with direct hardware access.
+	 * Not only could that mess up the hardware, but usually users
+	 * tend to only have this flag set on applications they think
+	 * of as important.
+	 */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
+		points /= 4;
+#ifdef DEBUG
+	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
+	p->pid, p->comm, points);
+#endif
+	return points;
+}
+
+/*
+ * Simple selection loop. We chose the process with the highest
+ * number of 'points'. We need the locks to make sure that the
+ * list of task structs doesn't change while we look the other way.
+ *
+ * (not docbooked, we don't want this one cluttering up the manual)
+ */
+static struct task_struct * select_bad_process(void)
+{
+	int maxpoints = 0;
+	struct task_struct *p = NULL;
+	struct task_struct *chosen = NULL;
+
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (p->pid > 1) {
+			int points = badness(p);
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
+		}
+	}
+	read_unlock(&tasklist_lock);
+	return chosen;
+}
+
+/**
+ * oom_kill - kill the "best" process when we run out of memory
+ *
+ * If we run out of memory, we have the choice between either
+ * killing a random task (bad), letting the system crash (worse)
+ * OR try to be smart about which process to kill. Note that we
+ * don't have to be perfect here, we just have to be good.
+ *
+ * We must be careful though to never send SIGKILL a process with
+ * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
+ * we select a process with CAP_SYS_RAW_IO set).
+ */
+int oom_kill(void)
+{
+
+	struct task_struct *p = select_bad_process();
+
+        /* Found nothing?!?! Either we hang forever, or we panic. */
+	if (p == NULL)
+                panic("Out of memory and no killable processes...\n");
+
+        /*
+         * We give our sacrificial lamb high priority and access to
+         * all the memory it needs. That way it should be able to
+         * exit() and clear out its resources quickly...
+         */
+        p->counter = 5 * HZ;
+        p->flags |= PF_MEMALLOC;
+
+        if ((p->oom_kill_try++ > 10)
+		|| !(cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)))
+	{
+		if (p == current) {
+			return 1;
+		} else {
+			printk(KERN_ERR "Out of Memory: Killed process "
+				"%d (%s), saved process %d (%s)\n",
+				p->pid, p->comm, current->pid, current->comm);
+			force_sig(SIGKILL, p);
+		}
+	} else {
+		/* This process has hardware access, be more careful */
+		if (p == current) {
+			printk(KERN_ERR "Out of Memory: Terminating process "
+				"%d (%s)\n", p->pid, p->comm);
+		} else {
+			printk(KERN_ERR "Out of Memory: Terminating process "
+				"%d (%s), saved process %d (%s).\n",
+				p->pid, p->comm, current->pid, current->comm);
+		}
+		force_sig(SIGTERM, p);
+	}
+
+	if ((p != current) || (p->oom_kill_try > 1))
+		p->counter = 2 * DEF_PRIORITY;
+
+	return 0;
+}
+
diff -urw linux-2.2.18pre21/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.2.18pre21/mm/vmscan.c	Fri Nov 17 00:07:57 2000
+++ linux/mm/vmscan.c	Wed Nov 22 18:10:40 2000
@@ -20,6 +20,8 @@

 #include <asm/pgtable.h>

+extern int vm_enough_memory(long pages);
+
 /*
  * The swap-out functions return 1 if they successfully
  * threw something out, and we got a free page. It returns
@@ -384,11 +386,16 @@
 	int swapcount;
 	int count = SWAP_CLUSTER_MAX;

+	/* Don't try for non-root if memory is less than reserved for root */
+	if (!vm_enough_memory(1))
+		return 0;
+
 	lock_kernel();

 	/* Always trim SLAB caches when memory gets low. */
 	kmem_cache_reap(gfp_mask);

+again:
 	priority = 6;
 	do {
 		while (shrink_mmap(priority, gfp_mask)) {
@@ -419,9 +426,10 @@
 done:
 	unlock_kernel();

-	if (!ret)
-		printk("VM: do_try_to_free_pages failed for %s...\n",
-				current->comm);
+	/* Don't flood this message */
+	if (0 && !ret) {
+		printk("VM: do_try_to_free_pages failed for %s...\n", current->comm);
+	}
 	/* Return success if we freed a page. */
 	return ret;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
