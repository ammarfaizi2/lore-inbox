Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbTIMCVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 22:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTIMCVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 22:21:46 -0400
Received: from fmr05.intel.com ([134.134.136.6]:30867 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261990AbTIMCV2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:21:28 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Rusty Lynch <rusty@linux.co.intel.com>
To: "Tvrtko A." =?iso-8859-2?Q?Ur=B9ulin?= <tvrtko@croadria.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309121058.54691.tvrtko@croadria.com>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> 
	<200309121058.54691.tvrtko@croadria.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Sep 2003 19:21:08 -0700
Message-Id: <1063419669.9766.2.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 01:58, Tvrtko A. Uršulin wrote:
> 
> > * Added a very simple (in fact I'm sure too simple) mm/om_panic.c that
> >   will panic on any oom condition
> >
> > The patch works (although by looking over oom_kill.c, I'm sure oom_panic.c
> > will panic too soon), but it is really only a quick hack to see how people
> > feel about such an approach.
> 
> I like it, but who am I to say... No so long ago I made a patch for 2.4.20 
> (attached) which extended OOM Killer functionality in a following way: If a 
> process of the same parent gets killed more than X times during Y seconds, 
> parent gets killed. 
> 
> Maybe this kind of module for your patch would be interesting for someone?
> 
> Regards,
> Tvrtko


I went ahead and added a new oom handler that is a combination of 
the original oom_kill.c combined with the changes from Tvrtko's patch
(originally written for 2.4.20) that kills off parents that keep producing
bad children.  It sounds a little right wing, but it works :->

Just walking around cube-ville I'm hearing lots of cool ideas for little oom 
handlers.  I know in past project where I was attempting to cram mozilla
into a resource deprived TV set-top box, I would have loved to have an oom
handler that always blamed mozilla (since it leaked like a sieve and was
constantly a pain in my ass) and nothing else.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1283.1.32 -> 1.1287 
#	     kernel/sysctl.c	1.53    -> 1.54   
#	       mm/oom_kill.c	1.24    -> 1.25   
#	include/linux/sysctl.h	1.51    -> 1.52   
#	         mm/Makefile	1.24    -> 1.26   
#	        init/Kconfig	1.28    -> 1.30   
#	               (new)	        -> 1.1     mm/oom_panic.c 
#	               (new)	        -> 1.1     mm/oom_notifier.c
#	               (new)	        -> 1.1     mm/oom_kill_parent.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/12	rusty@penguin.co.intel.com	1.1286
# Merge http://linux.bkbits.net:8080/linux-2.5
# into penguin.co.intel.com:/src/linux/linus
# --------------------------------------------
# 03/09/12	rusty@penguin.co.intel.com	1.1287
# Adding OOM handler that kills parents that produce bad children
# --------------------------------------------
#
diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Fri Sep 12 18:59:35 2003
+++ b/include/linux/notifier.h	Fri Sep 12 18:59:35 2003
@@ -66,5 +66,7 @@
 #define CPU_OFFLINE	0x0005 /* CPU (unsigned)v offline (still scheduling) */
 #define CPU_DEAD	0x0006 /* CPU (unsigned)v dead */
 
+#define OUT_OF_MEMORY  0x00007 /* Notify of critical memory shortage */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -Nru a/include/linux/oom_notifier.h b/include/linux/oom_notifier.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/oom_notifier.h	Fri Sep 12 18:59:35 2003
@@ -0,0 +1,7 @@
+#ifndef _LINUX_OOM_NOTIFIER_H
+#define _LINUX_OOM_NOTIFIER_H
+
+int register_oom_notifier(struct notifier_block * nb);
+int unregister_oom_notifier(struct notifier_block * nb);
+
+#endif /* _LINUX_OOM_NOTIFIER_H */
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Fri Sep 12 18:59:35 2003
+++ b/include/linux/sysctl.h	Fri Sep 12 18:59:35 2003
@@ -154,6 +154,8 @@
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_OOM_PARENT_MAX=22,
+	VM_OOM_PARENT_EXPIRE=23,
 };
 

diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	Fri Sep 12 18:59:35 2003
+++ b/init/Kconfig	Fri Sep 12 18:59:35 2003
@@ -162,6 +162,33 @@
 	  This option enables access to kernel configuration file and build
 	  information through /proc/config.gz.
 
+config OOM_KILL
+        bool "Kill process on out-of-memory conditions"
+	---help---
+	 This option enables the traditional oom_kill.c mechanism for
+         killing processes in an attempt to recover from an out-of-memory
+         condition.
+
+config OOM_PANIC
+	tristate "Panic on out-of-memory conditions"
+	---help---
+	 This option enables panic() to be called when a system is out of
+         memory.  This feature along with /proc/sys/kernel/panic allows a
+         different behavior on out-of-memory conditions when the standard
+         behavior (killing processes in an attempt to recover) does not 
+         make sense.
+
+config OOM_KPPID
+	bool "Kill bad parents along with their children when out-of-memory"
+	---help---
+	 This option enables an out-of-memory handler that not only attempts
+         to kill bad processes to free up memory, but also kills parents
+         that repeatedly produce bad children.
+
+         Two tunables, oom_parent_max and oom_parent_expire, will be added
+         and  to /proc/sys/vm/ to control how many children a parent is 
+         allowed to have terminated, and how long between terminated children
+         before a parent is forgiven.          
 
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Fri Sep 12 18:59:35 2003
+++ b/kernel/sysctl.c	Fri Sep 12 18:59:35 2003
@@ -59,6 +59,8 @@
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
+extern unsigned int oom_parent_max;
+extern unsigned int oom_parent_expire;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -672,6 +674,24 @@
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
 	},
+#ifdef CONFIG_OOM_KPPID
+	{
+		.ctl_name       = VM_OOM_PARENT_MAX,
+		.procname       = "oom_parent_max",
+                .data           = &oom_parent_max,
+                .maxlen         = sizeof(oom_parent_max),
+		.mode           = 0644,
+                .proc_handler   = &proc_dointvec,
+	},
+	{
+		.ctl_name       = VM_OOM_PARENT_EXPIRE,
+		.procname       = "oom_parent_expire",
+                .data           = &oom_parent_expire,
+                .maxlen         = sizeof(oom_parent_expire),
+		.mode           = 0644,
+                .proc_handler   = &proc_dointvec,
+	},
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
 		.ctl_name	= VM_HUGETLB_PAGES,
diff -Nru a/mm/Makefile b/mm/Makefile
--- a/mm/Makefile	Fri Sep 12 18:59:35 2003
+++ b/mm/Makefile	Fri Sep 12 18:59:35 2003
@@ -7,8 +7,12 @@
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
 			   shmem.o vmalloc.o
 
-obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
+obj-y			:= bootmem.o filemap.o mempool.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
-			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
+			   slab.o swap.o truncate.o vmscan.o oom_notifier.o \
+                           $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_OOM_PANIC) += oom_panic.o
+obj-$(CONFIG_OOM_KILL)  += oom_kill.o
+obj-$(CONFIG_OOM_KPPID) += oom_kill_parent.o
diff -Nru a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c	Fri Sep 12 18:59:35 2003
+++ b/mm/oom_kill.c	Fri Sep 12 18:59:35 2003
@@ -20,6 +20,10 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
 
 /* #define DEBUG */
 
@@ -230,7 +234,7 @@
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+static void out_of_memory_killer(void)
 {
 	/*
 	 * oom_lock protects out_of_memory()'s static variables.
@@ -305,3 +309,20 @@
 out_unlock:
 	spin_unlock(&oom_lock);
 }
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	out_of_memory_killer();
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_kill(void)
+{
+	printk("Registering oom_kill handler\n");
+	return register_oom_notifier(&oom_nb);
+}
+module_init(init_oom_kill);
diff -Nru a/mm/oom_kill_parent.c b/mm/oom_kill_parent.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/oom_kill_parent.c	Fri Sep 12 18:59:35 2003
@@ -0,0 +1,435 @@
+/*
+ *  linux/mm/oom_kill_parent.c
+ * 
+ *  Copyright (C)  1998,2000  Rik van Riel
+ *  Copyright (C)  2003 Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *
+ *  Based on the original linux/mm/oom_kill.c combined with a patch
+ *  submitted to LKML by Tvrtko A. Ursulin that would kill parents
+ *  that continue to produce bad children.
+ *      --rustyl <rusty@linux.intel.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/swap.h>
+#include <linux/timex.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
+
+#define OOM_BLACK_LIST_SIZE	32
+#define OOM_DEFAULT_VALUE	(10)
+#define OOM_DEFAULT_EXPIRE	(5*60)
+
+struct parent_record
+{
+	pid_t pid;
+	struct task_struct *task;
+	unsigned long last_kill;
+	unsigned long value;
+};
+
+unsigned int oom_parent_max = OOM_DEFAULT_VALUE;
+unsigned int oom_parent_expire = OOM_DEFAULT_EXPIRE;
+
+static struct parent_record black_list[OOM_BLACK_LIST_SIZE];
+
+#define DEBUG 1
+
+#ifdef DEBUG
+#define dbg(format, arg...)					\
+	do {							\
+			printk (KERN_DEBUG "OOM: " format "\n",	\
+				## arg);                        \
+	} while(0)
+#else
+#define dbg(format, arg...)
+#endif
+#define warn(format, arg...)					  \
+	do {							  \
+			printk (KERN_WARNING "OOM: " format "\n", \
+				## arg);                          \
+	} while(0)
+#define error(format, arg...)					        \
+	do {							        \
+			printk (KERN_ERR "Out-of-Memory: " format "\n",	\
+				## arg);                                \
+	} while(0)
+
+static struct parent_record *find_in_black_list(struct task_struct *task)
+{
+	struct parent_record *p = NULL;
+	unsigned int i;
+
+	if ( !task )
+		return NULL;
+
+	for ( i = 0; i < OOM_BLACK_LIST_SIZE; i++ ) {
+		p = &black_list[i];
+		if ( p->pid )
+			if ( (task->pid == p->pid) && (task == p->task) )
+				return p;
+	}
+
+	return NULL;
+}
+
+static void black_list_parent(struct task_struct *task)
+{
+	struct parent_record *p;
+	int i;
+
+	if ( !task && !task->parent )
+		return;
+
+	for ( i = 0; i < OOM_BLACK_LIST_SIZE; i++ ) {
+		p = &black_list[i];
+		if ( !p->pid )
+			break;
+	}
+	if (p->pid) {
+		dbg("black list is full... %d is getting off easy", 
+		    task->parent->pid);
+		return;
+	}
+	p->pid= task->parent->pid;
+	p->task = task->parent;
+	p->last_kill = jiffies;
+	p->value = 0;
+
+	return;
+}
+
+/**
+ * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
+ * @x: integer of which to calculate the sqrt
+ * 
+ * A very rough approximation to the sqrt() function.
+ */
+static unsigned int int_sqrt(unsigned int x)
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
+ * 5) we try to kill the process the user expects us to kill, this
+ *    algorithm has been meticulously tuned to meet the principle
+ *    of least surprise ... (be careful when you change it)
+ */
+
+static int badness(struct task_struct *p)
+{
+	int points, cpu_time, run_time;
+
+	if (!p->mm)
+		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
+	/*
+	 * The memory size of the process is the basis for the badness.
+	 */
+	points = p->mm->total_vm;
+
+	/*
+	 * CPU time is in seconds and run time is in minutes. There is no
+	 * particular reason for this other than that it turned out to work
+	 * very well in practice.
+	 */
+	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
+	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
+
+	points /= int_sqrt(cpu_time);
+	points /= int_sqrt(int_sqrt(run_time));
+
+	/*
+	 * Niced processes are most likely less important, so double
+	 * their badness points.
+	 */
+	if (task_nice(p) > 0)
+		points *= 2;
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
+
+	dbg("task %d (%s) got %d points", p->pid, p->comm, points);
+	return points;
+}
+
+/*
+ * Simple selection loop. We chose the process with the highest
+ * number of 'points'. We expect the caller will lock the tasklist.
+ *
+ * (not docbooked, we don't want this one cluttering up the manual)
+ */
+static struct task_struct * select_bad_process(void)
+{
+	int maxpoints = 0;
+	struct task_struct *g, *p;
+	struct task_struct *chosen = NULL;
+
+	do_each_thread(g, p)
+		if (p->pid) {
+			int points = badness(p);
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
+			if (p->flags & PF_SWAPOFF)
+				return p;
+		}
+	while_each_thread(g, p);
+	return chosen;
+}
+
+/**
+ * We must be careful though to never send SIGKILL a process with
+ * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
+ * we select a process with CAP_SYS_RAW_IO set).
+ */
+static void __oom_kill_task(task_t *p)
+{
+	task_lock(p);
+	if (!p->mm || p->mm == &init_mm) {
+		WARN_ON(1);
+		warn("tried to kill an mm-less task!");
+		task_unlock(p);
+		return;
+	}
+	task_unlock(p);
+	error("Killed process %d (%s)", p->pid, p->comm);
+
+	/*
+	 * We give our sacrificial lamb high priority and access to
+	 * all the memory it needs. That way it should be able to
+	 * exit() and clear out its resources quickly...
+	 */
+	p->time_slice = HZ;
+	p->flags |= PF_MEMALLOC | PF_MEMDIE;
+
+	/* This process has hardware access, be more careful. */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+		force_sig(SIGTERM, p);
+	} else {
+		force_sig(SIGKILL, p);
+	}
+}
+
+static struct mm_struct *oom_kill_task(task_t *p)
+{
+	struct parent_record *r;
+	struct mm_struct *mm = get_task_mm(p);
+	if (!mm || mm == &init_mm)
+		return NULL;
+
+	/* 
+	 * Hold parents accountable for their punk children :->
+	 */	
+	if (p->parent && p->parent->pid != 1) {
+		r = find_in_black_list(p->parent);
+		if (!r) {
+			dbg("Adding parent (%d) to black list because of %d",
+			    p->parent->pid, p->pid);
+			black_list_parent(p);
+		} else {
+			if ( abs(jiffies - r->last_kill) >= 
+			     (oom_parent_expire*HZ) ) {
+				dbg("Removing parent (%d) from black list: "
+				    "expired", 
+				    r->pid);
+				r->pid = 0;
+			} else if ( r->value >= oom_parent_max ) {
+				dbg("Marking parent (%d) for termination", 
+				    r->pid);
+				r->pid = 0;
+				p = r->task;
+			} else {
+				r->value++;
+				r->last_kill = jiffies;
+				dbg("Parent (%d) black list value increased "
+				    "to %ld", 
+				    r->pid, r->value);
+			}
+		}
+	}
+
+	__oom_kill_task(p);
+	return mm;
+}
+
+
+/**
+ * oom_kill - kill the "best" process when we run out of memory
+ *
+ * If we run out of memory, we have the choice between either
+ * killing a random task (bad), letting the system crash (worse)
+ * OR try to be smart about which process to kill. Note that we
+ * don't have to be perfect here, we just have to be good.
+ */
+static void oom_kill(void)
+{
+	struct mm_struct *mm;
+	struct task_struct *g, *p, *q;
+
+	read_lock(&tasklist_lock);
+retry:
+	p = select_bad_process();
+
+	/* Found nothing?!?! Either we hang forever, or we panic. */
+	if (!p) {
+		show_free_areas();
+		panic("Out of memory and no killable processes...\n");
+	}
+
+	mm = oom_kill_task(p);
+	if (!mm)
+		goto retry;
+	/*
+	 * kill all processes that share the ->mm (i.e. all threads),
+	 * but are in a different thread group
+	 */
+	do_each_thread(g, q)
+		if (q->mm == mm && q->tgid != p->tgid)
+			__oom_kill_task(q);
+	while_each_thread(g, q);
+	if (!p->mm)
+		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
+	read_unlock(&tasklist_lock);
+	mmput(mm);
+
+	/*
+	 * Make kswapd go out of the way, so "p" has a good chance of
+	 * killing itself before someone else gets the chance to ask
+	 * for more memory.
+	 */
+	yield();
+	return;
+}
+
+/**
+ * out_of_memory - is the system out of memory?
+ */
+static void out_of_memory_killer(void)
+{
+	/*
+	 * oom_lock protects out_of_memory()'s static variables.
+	 * It's a global lock; this is not performance-critical.
+	 */
+	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long first, last, count, lastkill;
+	unsigned long now, since;
+
+	/*
+	 * Enough swap space left?  Not OOM.
+	 */
+	if (nr_swap_pages > 0)
+		return;
+
+	spin_lock(&oom_lock);
+	now = jiffies;
+	since = now - last;
+	last = now;
+
+	/*
+	 * If it's been a long time since last failure,
+	 * we're not oom.
+	 */
+	last = now;
+	if (since > 5*HZ)
+		goto reset;
+
+	/*
+	 * If we haven't tried for at least one second,
+	 * we're not really oom.
+	 */
+	since = now - first;
+	if (since < HZ)
+		goto out_unlock;
+
+	/*
+	 * If we have gotten only a few failures,
+	 * we're not really oom. 
+	 */
+	if (++count < 10)
+		goto out_unlock;
+
+	/*
+	 * If we just killed a process, wait a while
+	 * to give that task a chance to exit. This
+	 * avoids killing multiple processes needlessly.
+	 */
+	since = now - lastkill;
+	if (since < HZ*5)
+		goto out_unlock;
+
+	/*
+	 * Ok, really out of memory. Kill something.
+	 */
+	lastkill = now;
+
+	/* oom_kill() sleeps */
+	spin_unlock(&oom_lock);
+	oom_kill();
+	spin_lock(&oom_lock);
+
+reset:
+	/*
+	 * We dropped the lock above, so check to be sure the variable
+	 * first only ever increases to prevent false OOM's.
+	 */
+	if (time_after(now, first))
+		first = now;
+	count = 0;
+
+out_unlock:
+	spin_unlock(&oom_lock);
+}
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	out_of_memory_killer();
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_kill(void)
+{
+	dbg("Registering oom_kill_parent handler");
+	return register_oom_notifier(&oom_nb);
+}
+module_init(init_oom_kill);
diff -Nru a/mm/oom_notifier.c b/mm/oom_notifier.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/oom_notifier.c	Fri Sep 12 18:59:35 2003
@@ -0,0 +1,38 @@
+/*
+ * linux/mm/oom_notifier.c
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/vermagic.h>
+#include <linux/notifier.h>
+
+static DECLARE_MUTEX(notify_mutex);
+static struct notifier_block * oom_notify_list = 0;
+
+int register_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_register(&oom_notify_list, nb);
+	up(&notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(register_oom_notifier);
+
+int unregister_oom_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_unregister(&oom_notify_list, nb);
+	up(&notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(unregister_oom_notifier);
+
+void out_of_memory(void)
+{
+	down(&notify_mutex);
+	notifier_call_chain(&oom_notify_list, OUT_OF_MEMORY, 0);
+	up(&notify_mutex);
+}
diff -Nru a/mm/oom_panic.c b/mm/oom_panic.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/oom_panic.c	Fri Sep 12 18:59:35 2003
@@ -0,0 +1,42 @@
+/*
+ * linux/mm/oom_panic.c
+ *
+ * This is a very simple component that will cause the kernel to 
+ * panic on out-of-memory conditions.  The behavior of panic can be
+ * further controlled with /proc/sys/kernel/panic.
+ *       
+ *       --rustyl <rusty@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	panic("Out-Of-Memory");
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_panic(void)
+{
+	int err;
+	printk(KERN_INFO "Installing oom_panic handler\n");
+	err = register_oom_notifier(&oom_nb);
+	if (err) printk(KERN_ERR "Error installing oom_panic handler\n");
+	return err;
+}
+
+static void __exit exit_oom_panic(void)
+{
+	unregister_oom_notifier(&oom_nb);
+}
+
+module_init(init_oom_panic);
+module_exit(exit_oom_panic);
+MODULE_LICENSE("GPL");

