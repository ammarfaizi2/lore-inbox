Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCPMjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUCPMjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:39:32 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:60857 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261326AbUCPMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:39:12 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modular OOM handlers for 2.6.4 (2/2)
Date: Tue, 16 Mar 2004 13:43:30 +0100
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200403161335.44755.tvrtko@croadria.com>
In-Reply-To: <200403161335.44755.tvrtko@croadria.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yZvVAOtCWHpybO0"
Message-Id: <200403161343.30885.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yZvVAOtCWHpybO0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


These are two additional handlers for OOM situation.

oom_panic - will make kernel panic in oom condition. It is usefull for some 
embedded developers as I understand.

oom_kill_parent - keeps tracks of parents whose children were killed in the 
past. When configurable (sysctl) threshold is passed, parent itself is 
killed. Also, parent sins are expired after some time (also configurable).

Regards,
Tvrtko

--Boundary-00=_yZvVAOtCWHpybO0
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="moom-2.6.4-modules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="moom-2.6.4-modules.patch"

diff -Naur linux-2.6.4/init/Kconfig linux-2.6.4-moom/init/Kconfig
--- linux-2.6.4/init/Kconfig	2004-03-16 12:46:05.000000000 +0100
+++ linux-2.6.4-moom/init/Kconfig	2004-03-16 12:36:13.000000000 +0100
@@ -207,6 +207,33 @@
   
 	  If unsure, say Y.
 			  	  
+config OOM_KILLER_PARENT_PROCESS_KILL	  
+	tristate "Parent process killer" if OOM_KILLER
+	default y
+	help
+	  This option enables an out-of-memory handler that not only attempts
+	  to kill bad processes to free up memory, but also kills parents
+	  that repeatedly produce bad children.
+
+	  Two tunables, oom_parent_max and oom_parent_expire, will be added
+	  and  to /proc/sys/vm/ to control how many children a parent is
+	  allowed to have terminated, and how long between terminated children
+	  before a parent is forgiven.
+  
+	  If unsure, say N.
+
+config OOM_KILLER_PANIC	  
+	tristate "OOM Panic" if OOM_KILLER
+	default y
+	help
+	  This option enables panic() to be called when a system is out of
+	  memory.  This feature along with /proc/sys/kernel/panic allows a
+	  different behavior on out-of-memory conditions when the standard
+	  behavior (killing processes in an attempt to recover) does not
+	  make sense.
+  
+	  If unsure, say N.
+
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
 	help
diff -Naur linux-2.6.4/mm/Makefile linux-2.6.4-moom/mm/Makefile
--- linux-2.6.4/mm/Makefile	2004-03-16 12:46:05.000000000 +0100
+++ linux-2.6.4-moom/mm/Makefile	2004-03-16 12:37:20.000000000 +0100
@@ -15,3 +15,5 @@
 
 obj-$(CONFIG_OOM_KILLER)  += oom_notify.o
 obj-$(CONFIG_OOM_KILLER_CLASSIC)  += oom_kill.o
+obj-$(CONFIG_OOM_KILLER_PANIC)  += oom_panic.o
+obj-$(CONFIG_OOM_KILLER_PARENT_PROCESS_KILL)  += oom_kill_parent.o
diff -Naur linux-2.6.4/mm/oom_kill_parent.c linux-2.6.4-moom/mm/oom_kill_parent.c
--- linux-2.6.4/mm/oom_kill_parent.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.4-moom/mm/oom_kill_parent.c	2004-03-16 13:11:52.000000000 +0100
@@ -0,0 +1,485 @@
+/*
+ *  linux/mm/oom_kill_parent.c
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
+ *
+ *  Copyright (C)  2003 Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *  Extended  to keep per parent process statistics and to kill parent processes
+ *  which keep producing bad children.
+ *
+ *  Modularized by using notifies by --rustyl <rusty@linux.intel.com>
+ *  Final modularization (C) 2003,2004  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *
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
+#include <linux/oom_notify.h>
+#include <linux/sysctl.h>
+
+#define OOM_HISTORY_SIZE	32
+
+#define OOM_DEFAULT_VALUE	(10)
+#define OOM_DEFAULT_EXPIRE	(5*60)
+
+static unsigned int oom_parent_max = OOM_DEFAULT_VALUE;
+static unsigned int oom_parent_expire = OOM_DEFAULT_EXPIRE;
+
+static struct ctl_table_header *oom_root_table_header;
+
+static ctl_table oom_table[] = {
+	{1, "oom_parent_max",
+	 &oom_parent_max, sizeof(int), 0644, NULL, &proc_dointvec},
+	{2, "oom_parent_expire",
+	 &oom_parent_expire, sizeof(int), 0644, NULL, &proc_dointvec},
+	{ 0 }
+};
+
+static ctl_table oom_dir_table[] = {
+	{VM_OOM, "oom", NULL, 0, 0555, oom_table},
+	{0}
+};
+
+static ctl_table oom_root_table[] = {
+	{CTL_VM, "vm", NULL, 0, 0555, oom_dir_table},
+	{0}
+};
+
+struct parent_record
+{
+	pid_t				pid;
+	struct task_struct	*task;
+	unsigned long		last_kill;
+	unsigned long		value;
+};
+
+static struct parent_record	blacklist[OOM_HISTORY_SIZE];
+
+/* #define DEBUG */
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
+static struct mm_struct *oom_kill_task(task_t *p);
+
+static void	process_blacklist(void)
+{
+	struct parent_record	*p;
+	struct task_struct	*task;
+
+	unsigned int	i;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
+		p = &blacklist[i];
+		if ( p->pid ) {
+			task = find_task_by_pid(p->pid);
+			if ( task != p->task ) {
+				dbg("Parent %d (%p) removed from list - does not exist",p->pid, p->task);
+				p->pid = 0;
+			}
+			else if ( abs(jiffies - p->last_kill) >= (oom_parent_expire*HZ) ) {
+				dbg("Parent %d (%p) removed from list - expired",p->pid, p->task);
+				p->pid = 0;
+			}
+			else if ( p->value >= oom_parent_max ) {
+				error("Will kill parent process %d (%s)",p->pid,p->task->comm);
+				p->pid = 0;
+				oom_kill_task(p->task);
+			}
+		}
+	}
+}
+
+static struct parent_record	*find_in_blacklist(struct task_struct *task)
+{
+	struct parent_record	*p = NULL;
+	unsigned int i;
+
+	if ( !task )
+		return NULL;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
+		p = &blacklist[i];
+		if ( p->pid ) {
+			if ( (task->pid == p->pid) && (task == p->task) )
+				return p;
+		}
+	}
+
+	return NULL;
+}
+
+static struct parent_record	*blacklist_parent(struct task_struct *task)
+{
+	struct parent_record	*p;
+	unsigned int i;
+
+	if ( !task )
+		return NULL;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
+		p = &blacklist[i];
+		if ( !p->pid )
+			break;
+	}
+
+	if ( p->pid )
+		return NULL;
+
+	p->pid= task->pid;
+	p->task = task;
+	p->last_kill = jiffies;
+	p->value = 0;
+
+	return p;
+}
+
+static int badness(struct task_struct *p)
+{
+	int points, cpu_time, run_time, s;
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
+	s = int_sqrt(cpu_time);
+	if (s)
+		points /= s;
+	s = int_sqrt(int_sqrt(run_time));
+	if (s)
+		points /= s;
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
+	#ifdef DEBUG
+	dbg("Task %d (%s) got %d points",p->pid, p->comm, points);
+	#endif
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
+		warn("Tried to kill an mm-less task!");
+		task_unlock(p);
+		return;
+	}
+	task_unlock(p);
+	error("Killed process %d (%s).", p->pid, p->comm);
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
+	struct mm_struct *mm = get_task_mm(p);
+	if (!mm || mm == &init_mm)
+		return NULL;
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
+	struct parent_record *parent;
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
+	/* Add or update statistics for a parent processs */
+	if ( p->parent && (p->parent->pid > 1) ) {
+		parent = find_in_blacklist(p->parent);
+		if ( !parent ) {
+			dbg("Adding parent (%d) to black list because of %d",p->parent->pid, p->pid);
+			parent = blacklist_parent(p->parent);
+		}
+		else {
+			dbg("Parent (%d) black list value increased to %ld",parent->pid, parent->value);
+			parent->value++;
+			parent->last_kill = jiffies;
+		}
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
+		info("Fixed up OOM kill of mm-less task");
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
+	 * Process kill history...
+	 */
+	process_blacklist();
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
+static int __init init_oom_parent_kill(void)
+{
+	int err;
+
+	info("Installing parent kill out of memory handler");
+	err = register_oom_notifier(&oom_nb);
+	if (err)
+		error("Error installing parent kill out of memory handler!");
+	
+	oom_root_table_header = register_sysctl_table(oom_root_table, 1);
+	if (!oom_root_table_header)
+		error("Error installing oom sysctl table!");
+
+	return err;
+}
+
+static void __exit exit_oom_parent_kill(void)
+{
+	if (oom_root_table_header)
+		unregister_sysctl_table(oom_root_table_header);
+	
+	unregister_oom_notifier(&oom_nb);
+	info("Unregistered parent kill out of memory handler");
+}
+
+MODULE_LICENSE("GPL");
+MODULE_PARM(oom_parent_max, "i");
+MODULE_PARM_DESC(oom_parent_max, "Maximum number of bad childs parent can produce" );
+MODULE_PARM(oom_parent_expire, "i");
+MODULE_PARM_DESC(oom_parent_expire, "Time period in seconds after which parents past sins are forgotten" );
+
+module_init(init_oom_parent_kill);
+module_exit(exit_oom_parent_kill);
diff -Naur linux-2.6.4/mm/oom_panic.c linux-2.6.4-moom/mm/oom_panic.c
--- linux-2.6.4/mm/oom_panic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.4-moom/mm/oom_panic.c	2004-03-16 12:50:35.000000000 +0100
@@ -0,0 +1,50 @@
+/*
+ * linux/mm/oom_panic.c
+ *
+ * This is a very simple component that will cause the kernel to
+ * panic on out-of-memory conditions.  The behavior of panic can be
+ * further controlled with /proc/sys/kernel/panic.
+ *
+ *       --rustyl <rusty@linux.intel.com>
+ *
+ * Final modularization (C) 2003,2004  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
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
+
+	info("Installing oom_panic handler");
+	err = register_oom_notifier(&oom_nb);
+	if (err)
+		error("Error installing oom_panic handler!");
+
+	return err;
+}
+
+static void __exit exit_oom_panic(void)
+{
+	unregister_oom_notifier(&oom_nb);
+}
+
+MODULE_LICENSE("GPL");
+
+module_init(init_oom_panic);
+module_exit(exit_oom_panic);

--Boundary-00=_yZvVAOtCWHpybO0--
