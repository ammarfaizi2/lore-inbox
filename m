Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVCTBvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVCTBvb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 20:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVCTBvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 20:51:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13501 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261967AbVCTBuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 20:50:24 -0500
Date: Sat, 19 Mar 2005 17:48:46 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Hicks <mort@sgi.com>, linux-mm <linux-mm@kvack.org>,
       Scott Emery <emery@sgi.com>, Bron Nelson <bron@sgi.com>,
       Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-Id: <20050320014847.16310.53697.sendpatchset@sam.engr.sgi.com>
Subject: [Patch] cpusets policy kill no swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question:

        Should I call oom_kill_process(), oom_kill_task(),
        or __oom_kill_task(), when the current task decides
        that it is better to die than to swap, so calls the
        routine mm/oom_kill.c:oom_attempt_suicide() that this
        patch adds, below?

        My best guess is either one of oom_kill_task() or
        __oom_kill_task() is fine, depending on whether I
        want to take down the rest of the tasks sharing the
        offending tasks mm.

Andrew will probably not want to pick up this patch, at least
until this question is answered.

Review and feedback is welcome.

===

This patch adds a boolean flag 'policy_kill_no_swap' to each
cpuset.  If this flag is set in some cpuset, and if a task
attached to that cpuset tries to allocate a page of memory and
gets far enough in the __alloc_pages() code that the _next_
step would be to wake the swapper (call wakeup_kswapd) then
instead of that, the task is killed immediately.

For normal desktop usage, this makes almost no sense, and so
of course the default setting of 'policy_kill_no_swap' is false
(zero).

For certain HPC apps on big iron numa, this policy has been found
to be essential.  In these cases, the app has been carefully
sized to fit, tightly, on the CPUs and Memory Nodes allowed
to it.  The app may consume dozens or hundreds of nodes, using
up almost all the main memory on each node, running for hours
or days in very tight coupling.  Such an app as would use
policy_kill_no_swap must not swap, for two reasons:

 1) If it starts to swap, then the required performance is
    hopelessly and totally lost.  The customer requires the
    application to come down at that point.

 2) If it starts to swap, it starts to impact the performance
    of other apps elsewhere on the system.  This was much worse
    on Linux 2.4 kernels, where the swapper was not well behaved.
    But even on Linux 2.6 kernels, additional i/o and kernel
    work is invoked, which has unpredictable impact on the
    remaining system performance.

The implementation is simple enough.  Each cpuset directory has
one more special file, 'policy_kill_no_swap', containing a zero
(false) or one (true).  The default is false.  The value is
inherited by newly created sub-cpusets.

A hook is added to mm/page_alloc.c:__alloc_pages(), just before
the wakeup_kswapd() logic, which checks this flag in the current
tasks cpuset, and kills the process if the flag is set, with
an explanatory printk.  A new routine, oom_attempt_suicide(),
is added to mm/oom_kill.c, to handle the killing.  If this
happens, the task never gets to the point of invoking the
swapper.

This mechanisms differs from a general purpose out-of-memory
killer in various ways, including:

 * An oom-killer tries to score the bad buy, to avoid shooting
   the innocent little task that just happened to ask for one
   page too many.
 * The policy_kill_no_swap hook kills the current requester.
 * It takes severe memory pressure to wake up an oom-killer.
 * The policy_kill_no_swap hook triggers on the slightest
   pressure that exceeds readily free memory.
 * The oom-killer can be useful on a general purpose system.
 * The policy_kill_no_swap hook is only useful for carefully
   tuned apps running on dedicated nodes on large systems.

In short - simple enough, but quite specialized.

This patch has been built, booted and tested for function on
an ia64 SN2 platform.  It has been built with and without
CONFIG_CPUSETS enabled on an i386 platform.

It would not surprise me if a few more such cpuset policy flags
showed up over the next year, to affect scheduling or allocation
for all tasks in a cpuset.  However I have no more such flags
queued up, or even with an agreed design, at this time.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.12-pj/Documentation/cpusets.txt
===================================================================
--- 2.6.12-pj.orig/Documentation/cpusets.txt	2005-03-19 01:10:46.000000000 -0800
+++ 2.6.12-pj/Documentation/cpusets.txt	2005-03-19 14:41:21.000000000 -0800
@@ -166,6 +166,7 @@ containing the following files describin
  - mems: list of Memory Nodes in that cpuset
  - cpu_exclusive flag: is cpu placement exclusive?
  - mem_exclusive flag: is memory placement exclusive?
+ - policy_kill_no_swap: kill task if its memory use would wake swapper
  - tasks: list of tasks (by pid) attached to that cpuset
 
 New cpusets are created using the mkdir system call or shell
@@ -333,7 +334,7 @@ Now you want to do something with this c
 
 In this directory you can find several files:
 # ls
-cpus  cpu_exclusive  mems  mem_exclusive  tasks
+cpu_exclusive  cpus  mem_exclusive  mems  policy_kill_no_swap  tasks
 
 Reading them will give you information about the state of this cpuset:
 the CPUs and Memory Nodes it can use, the processes that are using
Index: 2.6.12-pj/include/linux/cpuset.h
===================================================================
--- 2.6.12-pj.orig/include/linux/cpuset.h	2005-03-19 00:38:05.000000000 -0800
+++ 2.6.12-pj/include/linux/cpuset.h	2005-03-19 02:06:41.000000000 -0800
@@ -24,6 +24,7 @@ void cpuset_update_current_mems_allowed(
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
 int cpuset_zone_allowed(struct zone *z);
+int cpuset_is_kill_no_swap(void);
 extern struct file_operations proc_cpuset_operations;
 extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
@@ -53,6 +54,11 @@ static inline int cpuset_zone_allowed(st
 	return 1;
 }
 
+static inline int cpuset_is_kill_no_swap(void)
+{
+	return 0;
+}
+
 static inline char *cpuset_task_status_allowed(struct task_struct *task,
 							char *buffer)
 {
Index: 2.6.12-pj/include/linux/swap.h
===================================================================
--- 2.6.12-pj.orig/include/linux/swap.h	2005-03-19 00:38:05.000000000 -0800
+++ 2.6.12-pj/include/linux/swap.h	2005-03-19 14:59:04.000000000 -0800
@@ -149,6 +149,7 @@ struct swap_list_t {
 
 /* linux/mm/oom_kill.c */
 extern void out_of_memory(int gfp_mask);
+extern void oom_attempt_suicide(const char *msg);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
Index: 2.6.12-pj/kernel/cpuset.c
===================================================================
--- 2.6.12-pj.orig/kernel/cpuset.c	2005-03-19 01:10:43.000000000 -0800
+++ 2.6.12-pj/kernel/cpuset.c	2005-03-19 16:22:00.000000000 -0800
@@ -83,6 +83,7 @@ struct cpuset {
 typedef enum {
 	CS_CPU_EXCLUSIVE,
 	CS_MEM_EXCLUSIVE,
+	CS_KILL_NO_SWAP,
 	CS_REMOVED,
 	CS_NOTIFY_ON_RELEASE
 } cpuset_flagbits_t;
@@ -98,6 +99,11 @@ static inline int is_mem_exclusive(const
 	return !!test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
 }
 
+static inline int is_kill_no_swap(const struct cpuset *cs)
+{
+	return !!test_bit(CS_KILL_NO_SWAP, &cs->flags);
+}
+
 static inline int is_removed(const struct cpuset *cs)
 {
 	return !!test_bit(CS_REMOVED, &cs->flags);
@@ -643,8 +649,7 @@ static int update_nodemask(struct cpuset
 
 /*
  * update_flag - read a 0 or a 1 in a file and update associated flag
- * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
- *						CS_NOTIFY_ON_RELEASE)
+ * bit: which cpuset_flagbits_t bit (CS_*) to update
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
  */
@@ -736,6 +741,7 @@ typedef enum {
 	FILE_MEMLIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
+	FILE_KILL_NO_SWAP,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
@@ -783,6 +789,9 @@ static ssize_t cpuset_common_file_write(
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
 		break;
+	case FILE_KILL_NO_SWAP:
+		retval = update_flag(CS_KILL_NO_SWAP, cs, buffer);
+		break;
 	case FILE_NOTIFY_ON_RELEASE:
 		retval = update_flag(CS_NOTIFY_ON_RELEASE, cs, buffer);
 		break;
@@ -884,6 +893,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_MEM_EXCLUSIVE:
 		*s++ = is_mem_exclusive(cs) ? '1' : '0';
 		break;
+	case FILE_KILL_NO_SWAP:
+		*s++ = is_kill_no_swap(cs) ? '1' : '0';
+		break;
 	case FILE_NOTIFY_ON_RELEASE:
 		*s++ = notify_on_release(cs) ? '1' : '0';
 		break;
@@ -1210,6 +1222,11 @@ static struct cftype cft_mem_exclusive =
 	.private = FILE_MEM_EXCLUSIVE,
 };
 
+static struct cftype cft_kill_no_swap = {
+	.name = "policy_kill_no_swap",
+	.private = FILE_KILL_NO_SWAP,
+};
+
 static struct cftype cft_notify_on_release = {
 	.name = "notify_on_release",
 	.private = FILE_NOTIFY_ON_RELEASE,
@@ -1227,6 +1244,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_mem_exclusive)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_kill_no_swap)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
@@ -1257,6 +1276,8 @@ static long cpuset_create(struct cpuset 
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
+	if (is_kill_no_swap(parent))
+		set_bit(CS_KILL_NO_SWAP, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
@@ -1501,6 +1522,14 @@ int cpuset_zone_allowed(struct zone *z)
 }
 
 /*
+ * Should current task be killed to avoid kicking swapper?
+ */
+int cpuset_is_kill_no_swap(void)
+{
+	return current->cpuset && is_kill_no_swap(current->cpuset);
+}
+
+/*
  * proc_cpuset_show()
  *  - Print tasks cpuset path into seq_file.
  *  - Used for /proc/<pid>/cpuset.
Index: 2.6.12-pj/mm/oom_kill.c
===================================================================
--- 2.6.12-pj.orig/mm/oom_kill.c	2005-03-19 00:38:04.000000000 -0800
+++ 2.6.12-pj/mm/oom_kill.c	2005-03-19 16:37:10.000000000 -0800
@@ -15,6 +15,7 @@
  *  kernel subsystems and hints as to where to find out what things do.
  */
 
+#include <linux/interrupt.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
@@ -290,3 +291,32 @@ retry:
 	__set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(1);
 }
+
+/**
+ * oom_attempt_suicide - Unless we're in interrupt or a 'special' malloc,
+ * or already trying to exit, die.
+ */
+
+void oom_attempt_suicide(const char *msg)
+{
+	struct mm_struct *mm;
+
+	if (in_interrupt())
+		return;
+	if (current->flags & PF_MEMALLOC)
+		return;
+	if (test_tsk_thread_flag(current, TIF_MEMDIE))
+		return;
+	if (current->flags & PF_EXITING)
+		return;
+
+	printk(KERN_CRIT "Killing process %d (%s) - %s\n",
+					current->pid, current->comm, msg);
+	read_lock(&tasklist_lock);
+	mm = oom_kill_task(current);
+	read_unlock(&tasklist_lock);
+	if (mm)
+		mmput(mm);
+	__set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(1);
+}
Index: 2.6.12-pj/mm/page_alloc.c
===================================================================
--- 2.6.12-pj.orig/mm/page_alloc.c	2005-03-19 00:38:04.000000000 -0800
+++ 2.6.12-pj/mm/page_alloc.c	2005-03-19 14:58:38.000000000 -0800
@@ -774,6 +774,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 			goto got_pg;
 	}
 
+	if (cpuset_is_kill_no_swap())
+		oom_attempt_suicide("cpuset policy_kill_no_swap set");
+
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z, order);
 

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
