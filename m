Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVAJVzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVAJVzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVAJVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:52:54 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:24024 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262709AbVAJVnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:43:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=rJfj6WxO8+gJzRdniuDQLQ6FjVO/EjMsS9HVOA41dpYRBpkT2Bro41gdoiWDTA/O8eGqeaDjcECArTtXBioJbJxvg+/tHcQBvme4DDs3/EeQjm8X7KUIpybuMQfbx7GcvMDKTKTLVQ37uJyWOqdAPl1ENM7HAe3Ys/xIyd+dzJw=
Message-ID: <3f250c71050110134337c08ef0@mail.gmail.com>
Date: Mon, 10 Jan 2005 17:43:23 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: User space out of memory approach
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have done a comparison between the kernel version and user space
version and apparently the behavior is similar. You can also get this
patch and module to test it and compare with kernel OOM Killer. Here
goes a patch and a module that moves the kernel space OOM Killer
algorithm to user space. Let us know about your ideas.

*******************
PATCH
*******************

diff -urN linux-2.6.10/fs/proc/array.c linux-2.6.10-oom/fs/proc/array.c
--- linux-2.6.10/fs/proc/array.c	2004-12-24 17:35:00.000000000 -0400
+++ linux-2.6.10-oom/fs/proc/array.c	2005-01-10 15:42:26.000000000 -0400
@@ -470,3 +470,13 @@
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+int proc_pid_oom(struct task_struct *task, char * buffer)
+{
+	int res;
+	res = sprintf(buffer, "%d %lu %lu\n",
+		      task->pid,
+		      task->utime,
+		      task->stime);
+	return res;
+}
diff -urN linux-2.6.10/fs/proc/base.c linux-2.6.10-oom/fs/proc/base.c
--- linux-2.6.10/fs/proc/base.c	2004-12-24 17:35:00.000000000 -0400
+++ linux-2.6.10-oom/fs/proc/base.c	2005-01-10 15:42:26.000000000 -0400
@@ -60,6 +60,7 @@
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_OOM,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -86,6 +87,7 @@
 	PROC_TID_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
+	PROC_TID_OOM,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -132,6 +134,7 @@
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TGID_SCHEDSTAT, "schedstat", S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TGID_OOM,       "oom", S_IFREG|S_IRUGO),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -157,6 +160,7 @@
 #ifdef CONFIG_SCHEDSTATS
 	E(PROC_TID_SCHEDSTAT, "schedstat",S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TID_OOM,       "oom", S_IFREG|S_IRUGO),
 	{0,0,NULL,0}
 };
 
@@ -193,6 +197,7 @@
 int proc_tgid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
+int proc_pid_oom(struct task_struct*,char*);
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry,
struct vfsmount **mnt)
 {
@@ -1377,6 +1382,11 @@
 			ei->op.proc_read = proc_pid_schedstat;
 			break;
 #endif
+		case PROC_TID_OOM:
+		case PROC_TGID_OOM:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_oom;
+			break;
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
diff -urN linux-2.6.10/include/linux/oom_kill.h
linux-2.6.10-oom/include/linux/oom_kill.h
--- linux-2.6.10/include/linux/oom_kill.h	1969-12-31 20:00:00.000000000 -0400
+++ linux-2.6.10-oom/include/linux/oom_kill.h	2005-01-10
15:42:26.000000000 -0400
@@ -0,0 +1,6 @@
+struct candidate_process {
+	pid_t pid;
+	struct list_head pid_list;
+};
+
+struct list_head *loop_counter;
diff -urN linux-2.6.10/mm/#oom_kill.c# linux-2.6.10-oom/mm/#oom_kill.c#
--- linux-2.6.10/mm/#oom_kill.c#	2005-01-10 16:08:07.000000000 -0400
+++ linux-2.6.10-oom/mm/#oom_kill.c#	1969-12-31 20:00:00.000000000 -0400
@@ -1,366 +0,0 @@
-/*
- *  linux/mm/oom_kill.c
- * 
- *  Copyright (C)  1998,2000  Rik van Riel
- *	Thanks go out to Claus Fischer for some serious inspiration and
- *	for goading me into coding this file...
- *
- *  The routines in this file are used to kill a process when
- *  we're seriously out of memory. This gets called from kswapd()
- *  in linux/mm/vmscan.c when we really run out of memory.
- *
- *  Since we won't call these routines often (on a well-configured
- *  machine) this file will double as a 'coding guide' and a signpost
- *  for newbie kernel hackers. It features several pointers to major
- *  kernel subsystems and hints as to where to find out what things do.
- *
- *
- *  2005
- *  Bruna Moreira <bruna.moreira@indt.org.br>
- *  Edjard Mota <edjard.mota@indt.org.br>
- *  Ilias Biris <ext-ilias.biris@indt.org.br>
- *  Mauricio Lin <mauricio.lin@indt.org.br>
- * 
- *  Embedded Linux Lab - 10LE Institulo Nokia de Tecnologia - INdT 
- *
- *  Turn off the kernel space out of memory killer algorithm and provide
- *  support for user space out of memory killer.
- */
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/swap.h>
-#include <linux/timex.h>
-#include <linux/jiffies.h>
-#include <linux/oom_kill.h>
-
-/* #define DEBUG */
-
-/**
- * oom_badness - calculate a numeric value for how bad this task has been
- * @p: task struct of which task we should calculate
- * @p: current uptime in seconds
- *
- * The formula used is relatively simple and documented inline in the
- * function. The main rationale is that we want to select a good task
- * to kill when we run out of memory.
- *
- * Good in this context means that:
- * 1) we lose the minimum amount of work done
- * 2) we recover a large amount of memory
- * 3) we don't kill anything innocent of eating tons of memory
- * 4) we want to kill the minimum amount of processes (one)
- * 5) we try to kill the process the user expects us to kill, this
- *    algorithm has been meticulously tuned to meet the principle
- *    of least surprise ... (be careful when you change it)
- */
-
-struct candidate_process *candidate;
-
-EXPORT_SYMBOL(candidate);
-
-LIST_HEAD(pidqueue_head);
-
-EXPORT_SYMBOL(pidqueue_head);
-/*
-void show_candidate_comm(void)
-{
-	struct task_struct *g, *p;
-	int i = 0;
-
-	list_for_each(loop_counter, &pidqueue_head) {
-		candidate = list_entry(loop_counter, struct candidate_process, pid_list);
-		do_each_thread(g, p)
-			if (p->pid == candidate->pid) {
-				printk(KERN_DEBUG "A good walker leaves no tracks.%s\n", p->comm);
-				goto outer_loop;
-			}
-		while_each_thread(g, p);
-	  outer_loop:
-		continue;
-	}
-}
-
-EXPORT_SYMBOL(show_candidate_comm);
-*/
-static struct task_struct * select_process(void)
-{
-	struct task_struct *g, *p;
-	struct task_struct *chosen = NULL;
-	      
-	if (!list_empty(&pidqueue_head)) {
-		struct list_head *tmp;
-		list_for_each_safe(loop_counter, tmp, &pidqueue_head) {
-			candidate = list_entry(loop_counter, struct candidate_process, pid_list);
-			do_each_thread(g, p)
-				if (p->pid == candidate->pid) {
-					chosen = p;
-					list_del(&candidate->pid_list);
-					kfree(candidate);
-					goto exit;
-				}
-			while_each_thread(g, p);
-		}
-	}
-  exit:
-	return chosen;
-}
-
-static unsigned long badness(struct task_struct *p, unsigned long uptime)
-{
-	unsigned long points, cpu_time, run_time, s;
-
-	if (!p->mm)
-		return 0;
-
-	if (p->flags & PF_MEMDIE)
-		return 0;
-	/*
-	 * The memory size of the process is the basis for the badness.
-	 */
-	points = p->mm->total_vm;
-
-	/*
-	 * CPU time is in tens of seconds and run time is in thousands
-         * of seconds. There is no particular reason for this other than
-         * that it turned out to work very well in practice.
-	 */
-	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-
-	if (uptime >= p->start_time.tv_sec)
-		run_time = (uptime - p->start_time.tv_sec) >> 10;
-	else
-		run_time = 0;
-
-	s = int_sqrt(cpu_time);
-	if (s)
-		points /= s;
-	s = int_sqrt(int_sqrt(run_time));
-	if (s)
-		points /= s;
-
-	/*
-	 * Niced processes are most likely less important, so double
-	 * their badness points.
-	 */
-	if (task_nice(p) > 0)
-		points *= 2;
-
-	/*
-	 * Superuser processes are usually more important, so we make it
-	 * less likely that we kill those.
-	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
-				p->uid == 0 || p->euid == 0)
-		points /= 4;
-
-	/*
-	 * We don't want to kill a process with direct hardware access.
-	 * Not only could that mess up the hardware, but usually users
-	 * tend to only have this flag set on applications they think
-	 * of as important.
-	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
-		points /= 4;
-#ifdef DEBUG
-	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
-#endif
-	return points;
-}
-
-/*
- * Simple selection loop. We chose the process with the highest
- * number of 'points'. We expect the caller will lock the tasklist.
- *
- * (not docbooked, we don't want this one cluttering up the manual)
- */
-/*
-static struct task_struct * select_bad_process(void)
-{
-	unsigned long maxpoints = 0;
-	struct task_struct *g, *p;
-	struct task_struct *chosen = NULL;
-	struct timespec uptime;
-
-	do_posix_clock_monotonic_gettime(&uptime);
-	do_each_thread(g, p)
-		if (p->pid) {
-			unsigned long points = badness(p, uptime.tv_sec);
-			if (points > maxpoints) {
-				chosen = p;
-				maxpoints = points;
-			}
-			if (p->flags & PF_SWAPOFF)
-				return p;
-		}
-	while_each_thread(g, p);
-	return chosen;
-}
-*/
-/**
- * We must be careful though to never send SIGKILL a process with
- * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
- * we select a process with CAP_SYS_RAW_IO set).
- */
-static void __oom_kill_task(task_t *p)
-{
-	task_lock(p);
-	if (!p->mm || p->mm == &init_mm) {
-		WARN_ON(1);
-		printk(KERN_WARNING "tried to kill an mm-less task!\n");
-		task_unlock(p);
-		return;
-	}
-	task_unlock(p);
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
-
-	/*
-	 * We give our sacrificial lamb high priority and access to
-	 * all the memory it needs. That way it should be able to
-	 * exit() and clear out its resources quickly...
-	 */
-	p->time_slice = HZ;
-	p->flags |= PF_MEMALLOC | PF_MEMDIE;
-
-	/* This process has hardware access, be more careful. */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
-		force_sig(SIGTERM, p);
-	} else {
-		force_sig(SIGKILL, p);
-	}
-}
-
-static struct mm_struct *oom_kill_task(task_t *p)
-{
-	struct mm_struct *mm = get_task_mm(p);
-	if (!mm || mm == &init_mm)
-		return NULL;
-	__oom_kill_task(p);
-	return mm;
-}
-
-
-/**
- * oom_kill - kill the "best" process when we run out of memory
- *
- * If we run out of memory, we have the choice between either
- * killing a random task (bad), letting the system crash (worse)
- * OR try to be smart about which process to kill. Note that we
- * don't have to be perfect here, we just have to be good.
- */
-static void oom_kill(void)
-{
-	struct mm_struct *mm;
-	struct task_struct *g, *p, *q;
-	
-	read_lock(&tasklist_lock);
-retry:
-	printk(KERN_DEBUG "A good walker leaves no tracks.\n");
-	p = select_process();
-
-	/* Found nothing?!?! Either we hang forever, or we panic. */
-	if (!p) {
-		show_free_areas();
-		panic("Out of memory and no killable processes...\n");
-	}
-
-	mm = oom_kill_task(p);
-	if (!mm)
-		goto retry;
-	/*
-	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
-	 */
-	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q);
-	while_each_thread(g, q);
-	if (!p->mm)
-		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
-	read_unlock(&tasklist_lock);
-	mmput(mm);
-
-	/*
-	 * Make kswapd go out of the way, so "p" has a good chance of
-	 * killing itself before someone else gets the chance to ask
-	 * for more memory.
-	 */
-	yield();
-	return;
-}
-
-/**
- * out_of_memory - is the system out of memory?
- */
-void out_of_memory(int gfp_mask)
-{
-	/*
-	 * oom_lock protects out_of_memory()'s static variables.
-	 * It's a global lock; this is not performance-critical.
-	 */
-	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
-	static unsigned long first, last, count, lastkill;
-	unsigned long now, since;
-
-	spin_lock(&oom_lock);
-	now = jiffies;
-	since = now - last;
-	last = now;
-
-	/*
-	 * If it's been a long time since last failure,
-	 * we're not oom.
-	 */
-	if (since > 5*HZ)
-		goto reset;
-
-	/*
-	 * If we haven't tried for at least one second,
-	 * we're not really oom.
-	 */
-	since = now - first;
-	if (since < HZ)
-		goto out_unlock;
-
-	/*
-	 * If we have gotten only a few failures,
-	 * we're not really oom. 
-	 */
-	if (++count < 10)
-		goto out_unlock;
-
-	/*
-	 * If we just killed a process, wait a while
-	 * to give that task a chance to exit. This
-	 * avoids killing multiple processes needlessly.
-	 */
-	since = now - lastkill;
-	if (since < HZ*5)
-		goto out_unlock;
-
-	/*
-	 * Ok, really out of memory. Kill something.
-	 */
-	lastkill = now;
-
-	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
-	show_free_areas();
-
-	/* oom_kill() sleeps */
-	spin_unlock(&oom_lock);
-	oom_kill();
-	spin_lock(&oom_lock);
-
-reset:
-	/*
-	 * We dropped the lock above, so check to be sure the variable
-	 * first only ever increases to prevent false OOM's.
-	 */
-	if (time_after(now, first))
-		first = now;
-	count = 0;
-
-out_unlock:
-	spin_unlock(&oom_lock);
-}
diff -urN linux-2.6.10/mm/oom_kill.c linux-2.6.10-oom/mm/oom_kill.c
--- linux-2.6.10/mm/oom_kill.c	2004-12-24 17:34:57.000000000 -0400
+++ linux-2.6.10-oom/mm/oom_kill.c	2005-01-10 15:53:18.000000000 -0400
@@ -13,13 +13,26 @@
  *  machine) this file will double as a 'coding guide' and a signpost
  *  for newbie kernel hackers. It features several pointers to major
  *  kernel subsystems and hints as to where to find out what things do.
+ *
+ *
+ *  2004
+ *  Bruna Moreira <bruna.moreira@indt.org.br>
+ *  Edjard Mota <edjard.mota@indt.org.br>
+ *  Ilias Biris <ext-ilias.biris@indt.org.br>
+ *  Mauricio Lin <mauricio.lin@indt.org.br>
+ * 
+ *  Embedded Linux Lab - 10LE Institulo Nokia de Tecnologia - INdT 
+ *
+ *  Turn off the kernel space out of memory killer algorithm and provide
+ *  support for user space out of memory killer.
  */
-
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/oom_kill.h>
 
 /* #define DEBUG */
 
@@ -42,6 +55,57 @@
  *    of least surprise ... (be careful when you change it)
  */
 
+struct candidate_process *candidate;
+
+EXPORT_SYMBOL(candidate);
+
+LIST_HEAD(pidqueue_head);
+
+EXPORT_SYMBOL(pidqueue_head);
+/*
+void show_candidate_comm(void)
+{
+	struct task_struct *g, *p;
+	int i = 0;
+
+	list_for_each(loop_counter, &pidqueue_head) {
+		candidate = list_entry(loop_counter, struct candidate_process, pid_list);
+		do_each_thread(g, p)
+			if (p->pid == candidate->pid) {
+				printk(KERN_DEBUG "A good walker leaves no tracks.%s\n", p->comm);
+				goto outer_loop;
+			}
+		while_each_thread(g, p);
+	  outer_loop:
+		continue;
+	}
+}
+
+EXPORT_SYMBOL(show_candidate_comm);
+*/
+static struct task_struct * select_process(void)
+{
+	struct task_struct *g, *p;
+	struct task_struct *chosen = NULL;
+	      
+	if (!list_empty(&pidqueue_head)) {
+		struct list_head *tmp;
+		list_for_each_safe(loop_counter, tmp, &pidqueue_head) {
+			candidate = list_entry(loop_counter, struct candidate_process, pid_list);
+			do_each_thread(g, p)
+				if (p->pid == candidate->pid) {
+					chosen = p;
+					list_del(&candidate->pid_list);
+					kfree(candidate);
+					goto exit;
+				}
+			while_each_thread(g, p);
+		}
+	}
+  exit:
+	return chosen;
+}
+
 static unsigned long badness(struct task_struct *p, unsigned long uptime)
 {
 	unsigned long points, cpu_time, run_time, s;
@@ -111,6 +175,7 @@
  *
  * (not docbooked, we don't want this one cluttering up the manual)
  */
+/*
 static struct task_struct * select_bad_process(void)
 {
 	unsigned long maxpoints = 0;
@@ -132,7 +197,7 @@
 	while_each_thread(g, p);
 	return chosen;
 }
-
+*/
 /**
  * We must be careful though to never send SIGKILL a process with
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
@@ -191,7 +256,8 @@
 	
 	read_lock(&tasklist_lock);
 retry:
-	p = select_bad_process();
+	printk(KERN_DEBUG "A good walker leaves no tracks.\n");
+	p = select_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (!p) {



******************
Module oom.c
******************

/*  2005
 *  Bruna Moreira <bruna.moreira@indt.org.br>
 *  Edjard Mota <edjard.mota@indt.org.br>
 *  Ilias Biris <ext-ilias.biris@indt.org.br>
 *  Mauricio Lin <mauricio.lin@indt.org.br>
 * 
 *  Embedded Linux Lab - 10LE Institulo Nokia de Tecnologia - INdT 
 *
 *  Create a /proc/oom that allows user space Out of Memory Killer 
 *  to write the list of pids through it to the kernel. When out of
 *  memory happens the kernel selects the process to be killed from
 *  /proc/oom.
 *
 *  Approach suggested by Tony Lindgren <tony@atomide.com>
 */

#include <linux/module.h> 
#include <linux/kernel.h> 
#include <linux/init.h> 
#include <linux/proc_fs.h> 
#include <linux/sched.h> 
#include <linux/oom_kill.h>
#include <asm/uaccess.h>

#define MODULE_NAME "oom"


extern struct candidate_process *candidate;

static unsigned int nr_pids;

static struct proc_dir_entry *oom_file;

extern struct list_head pidqueue_head;

static DECLARE_MUTEX(user_oom_lock);

static unsigned long size_of_bytes;

static inline void add_to_pidqueue(struct candidate_process * p)
{
	list_add_tail(&p->pid_list, &pidqueue_head);
	nr_pids++;
	//printk(KERN_DEBUG "add nr_pids = %d (%d) \n", nr_pids, p->pid);
}

static inline void del_from_pidqueue(struct candidate_process * p)
{
        nr_pids--;
	//printk(KERN_DEBUG "delete nr_pids = %d \n", nr_pids);
        list_del(&p->pid_list);
}

static inline void del_all_from_pidqueue(void)
{
	if (!list_empty(&pidqueue_head)) {
		struct list_head *tmp;
		list_for_each_safe(loop_counter, tmp, &pidqueue_head) {
			candidate = list_entry(loop_counter, struct candidate_process, pid_list);
			del_from_pidqueue(candidate);
			kfree(candidate);
		}
	}
}

static int proc_read_oom(char *page, char **start,
			  off_t off, int count,
			  int *eof, void *data)
{
	int len = 0;
	char *output;
	char *item;
	
	if (!list_empty(&pidqueue_head)) {
		item = kmalloc(6, GFP_KERNEL);
		output = kmalloc(size_of_bytes, GFP_KERNEL);		
		strcpy(output, "");
		list_for_each(loop_counter, &pidqueue_head) {
			candidate = list_entry(loop_counter, struct candidate_process, pid_list);
			sprintf(item, "%d ", candidate->pid);
			strcat(output, item);
		}
		strcat(output, "\n");
		len = sprintf(page, output);
		kfree(output);
		kfree(item);
	}
	else {
		len = sprintf(page, "\n");
	}

	
	return len;
}

static int proc_write_oom(struct file *file,
			  const char *buffer,
			  unsigned long count,
			  void *data)
{
	unsigned long len;
	char *input, *item;
	len = count;
	input = kmalloc(count+1, GFP_KERNEL);
        
	if (!input)
		return -ENOMEM;
	if(copy_from_user(input, buffer, count)) {
		kfree(input);
		return -EFAULT;
	}
	input[count] = ' ';
	len = strlen(input);
	int prev_index = 0;
	int i;
	
	if (down_interruptible(&user_oom_lock)) {
		kfree(input);
		return -EINTR;
	}

	del_all_from_pidqueue();
	for (i=0; i<len; i++) {
		if (input[i] == ' ') {
			input[i] = '\0';
			item = kmalloc(i-prev_index, GFP_KERNEL);
			strcpy(item, &input[prev_index]);
			prev_index = i+1;			
			candidate = (struct candidate_process *)kmalloc(sizeof(struct
candidate_process), GFP_KERNEL);
			candidate->pid = simple_strtoul(item, NULL, 10);
			add_to_pidqueue(candidate);
			kfree(item);
		}
	}
	size_of_bytes = len;
	up(&user_oom_lock);
	kfree(input);
	return count;
}

static int __init init_oom(void) 
{
	int flag = 0;
	oom_file = create_proc_entry("oom", S_IRUGO | S_IWUSR, NULL);
	oom_file->read_proc = proc_read_oom;
	oom_file->write_proc = proc_write_oom;
	oom_file->owner = THIS_MODULE;
	nr_pids = 0;
	size_of_bytes = 0;
	printk(KERN_DEBUG "%s included\n", MODULE_NAME);
	return flag;
}

static void __exit cleanup_oom(void)
{
	del_all_from_pidqueue();
    	remove_proc_entry("oom", NULL);
	printk(KERN_DEBUG "%s removed\n", MODULE_NAME);
}

module_init(init_oom);
module_exit(cleanup_oom);
MODULE_LICENSE("GPL");



***********************
Makefile for module
***********************
obj-m := oom.o

MAKE := /usr/bin/make
KDIR := $(HOME)/linux-2.6.10-oom
PWD := $(PWD)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules



************************
README
************************
1. Getting the kernel
Create a directory called "download" in your home and go to this directory
# mkdir download
# cd download

Download the kernel 2.6.9 from
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2 to the
directory you have created previuosly.

Extract it in your home as below

# tar xjvf download/linux-2.6.10.tar.bz2

Rename the kernel directory to linux-2.6.10-oom

# mv linux-2.6.10 linux-2.6.10-oom

Go to the kernel source tree and patch the kernel using "2.6.9.oom.patch"

# cd linux-2.6.10-oom
# patch -p1 < ../2.6.10.oom.patch

The command above assumes that you have put the patch file in your
home directory.

Configure you kernel using "make menuconfig" or "make xconfig"



2. Compiling the kernel module

After compiling your kernel you have to compile the kernel module "oom.c"

Put the Makefile and oom.c in the same directory.

Type make in order to create the "oom.ko" as below

# make

After typing make, check if it was created the "oom.ko" in your
current directory.



3. Run the oom module

You have to insert the module now as root:

# insmod oom.ko

Check if the /proc/oom was created in your system.

# cat /proc/oom
#
# echo 11 22 33 > /proc/oom
# cat /proc/oom
# 11 22 33

4. User OOM (Optional)
After that you can compile the user_oom.c as below (you can compile it
as normal user):
# gcc user_oom.c -o user_oom -lm

As root you have to run it:

# ./user_oom



************************
TODO
************************
Reorganize the kernel and user space code (remove some superfluous
stuff or move them to a more viable file) in order to reduce the
stack space or make the code more readable and clear.

Change some static allocation to dynamic allocation as array to linked list.

Create a /dev/oom to get the memory info instead of reading it from
/proc/meminfo continuously.


Suggestions are welcome. The user space OOM application (optional)
will be sent later.

BR,

Mauricio Lin.
