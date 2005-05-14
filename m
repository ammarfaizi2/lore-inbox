Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVENT4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVENT4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 15:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVENT4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 15:56:36 -0400
Received: from everest.sosdg.org ([66.93.203.161]:46819 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261468AbVENTy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 15:54:58 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Sun, 15 May 2005 03:54:43 +0800
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org
Message-ID: <20050514195443.GA4598@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Scan-Signature: f3fcfbd3950e3b53c16c2648134569a7
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] LCA OOM-Killer v2.3
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                                                            Coywolf Qi Hunt
                                                         coywolf@lovecn.org
                                                               May 14, 2005

			LCA OOM-Killer v2.3


1. Acronyms

	OOM	Out of Memory
	LCA	Least Common Ancestor

2. Introduction

   The traditional solutions to fork bombs, such as ulimit are limited in
   usability and functionality.  If you put a cap on the resource limit to N,
   your system could always be able to afford N+1. Consider multiple logging's,
   you can not prevent attacks by simply using a resource limit.  And you can
   not easily prevent root fork bombs.

3. Philosophy

   Kernel is God, init is Jesus. Init could be /sbin/init or /bin/sh -
   whatsoever we've chosen.  So the kernel protects only the init process,
   not root processes, or other things.
   
   If we follow the UNIX philosophy that allow root to shoot his own foot,
   then we could protect root processes and kill other processes by user.
   Someone had advised me to kill on a per user basis.  We could do that,
   but I think that is doing revenge.  For instance, from tty1 one does
   normal work, but from tty2, I runs fork bomb.  The kernel should only kill
   the bomb from tty2.

   The LCA algorithm is to find out the malicious process, not the malicious
   user.  Leave that job to system admins, not the kernel.

4. Three Working Levels

   level 0

      Conservative level. last_chosen_parent will be forgotten after
      lca_time seconds. System could be "choking" periodically.
      The caught isn't guaranteed, but computing could still going on.

   level 1

      Modest level. last_chosen_parent is used only if it's younger than
      1<<lca_time++ seconds.  And the more hits, the longer(exponential)
      it will be memorized.  Some fork bombs could do fork bombings by
      their descendents. But they'll be caught sooner or later if they
      keep misbehaving.  At the beginning, level 2 works as level 1 in
      effect.  If fork bombing keeps happening, level 2 will be acting
      like level 3.  The caught is guaranteed in level 2.

   level 2

      Strong, fierce level. No expiration for last_chosen_parent.  Thus any
      fork bombs will be caught and killed immediately. But innocents could
      be mass killed.

5. Interfaces

	The sysctls and their default values:

	/proc/sys/vm/lca_level		0
	/proc/sys/vm/lca_time		5


6. Overhead Considerations

   It's one pointer and two list_head structures added to task_struct,
   exactly as ptrace.  Few users use ptrace, so ptrace is somewhat
   depreciated?

   Would you really care about 20 bytes for each process?  I usually
   have no more than 70 processes. That is 70 * 20 = 1400 bytes for me.
   Every 204 processes use up roughly one page of memory.

   In v1.0, only one pointer is added. So the overhead is 4 bytes per
   process.  But then find_lca() and the descendant killing have to be
   O(n^2). That's not acceptable.

   We might even be able to avoid the 20 bytes overhead by some heavy
   hacking or not trying to be strict POSIX compliant on this part.
   In this case, nearly no overhead at all.

7. Other Considerations

   1. The patch works as well as its previous release upon the normal test
      cases (a.sh, b.sh, c.sh and folkert).  With swapon, it will take longer
      time to trigger the OOM by kernel itself at present.  (I have other plans
      to improve it...)

      In addition to the 4 normal test cases, there are two ``pure'' fork bomb
      cases (canonical and pl.sh).  In pure fork bombing cases (just fork, no
      malloc), it will take longer time to trigger or often will not trigger
      the OOM by kernel itself at present.

      Here goes the bad news that the algorithm cannot deal with pure fork bombs
      for now (probably not in future either).  But the good news is that pure
      fork bombs are not fatal to the system.  The normal users will get messages
      like "fork resources temporarily unavailable". But root can still continue
      to work.  In my tests, although the system responds slowly, I can still use
      vi as root.

      As an LWN editorial says, this algorithm could be a "last line of defense".

   2. Direct hardware access processes and other important processes could be
      protected by /proc/<pid>/oom_adj.

8. FYI

   LCA OOM-killer previous releases
      v2.1 http://lwn.net/Articles/129286/ 
      v2.2 http://lwn.net/Articles/134388/

   Defending against fork bombs
      http://lwn.net/Articles/134513/

   Test cases
      http://freeforge.net/~coywolf/pub/oom-bomb/


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

 fs/proc/base.c            |    3 
 include/linux/init_task.h |    3 
 include/linux/oom_kill.h  |   18 ++++
 include/linux/sched.h     |    9 --
 include/linux/sysctl.h    |    2 
 kernel/exit.c             |   31 ++++++
 kernel/fork.c             |    4 
 kernel/sysctl.c           |   22 ++++
 mm/oom_kill.c             |  205 +++++++++++++++++++++++++++++++++-------------
 9 files changed, 232 insertions(+), 65 deletions(-)

diff -pruN 2.6.12-rc4-mm1/fs/proc/base.c 2.6.12-rc4-mm1-cy/fs/proc/base.c
--- 2.6.12-rc4-mm1/fs/proc/base.c	2005-05-12 19:25:19.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/fs/proc/base.c	2005-05-13 16:35:42.000000000 +0800
@@ -69,6 +69,7 @@
 #include <linux/seccomp.h>
 #include <linux/cpuset.h>
 #include <linux/audit.h>
+#include <linux/oom_kill.h>
 #include "internal.h"
 
 /*
@@ -469,8 +470,6 @@ static int proc_pid_schedstat(struct tas
 }
 #endif
 
-/* The badness from the OOM killer */
-unsigned long badness(struct task_struct *p, unsigned long uptime);
 static int proc_oom_score(struct task_struct *task, char *buffer)
 {
 	unsigned long points;
diff -pruN 2.6.12-rc4-mm1/include/linux/init_task.h 2.6.12-rc4-mm1-cy/include/linux/init_task.h
--- 2.6.12-rc4-mm1/include/linux/init_task.h	2005-05-12 19:25:31.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/include/linux/init_task.h	2005-05-13 16:35:42.000000000 +0800
@@ -90,6 +90,9 @@ extern struct group_info init_groups;
 	.parent		= &tsk,						\
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
+	.bio_parent	= &tsk,						\
+	.bio_children	= LIST_HEAD_INIT(tsk.bio_children),		\
+	.bio_sibling	= LIST_HEAD_INIT(tsk.bio_sibling),		\
 	.group_leader	= &tsk,						\
 	.group_info	= &init_groups,					\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
diff -pruN 2.6.12-rc4-mm1/include/linux/oom_kill.h 2.6.12-rc4-mm1-cy/include/linux/oom_kill.h
--- 2.6.12-rc4-mm1/include/linux/oom_kill.h	1970-01-01 08:00:00.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/include/linux/oom_kill.h	2005-05-13 16:35:42.000000000 +0800
@@ -0,0 +1,18 @@
+/*
+ * include/linux/oom_kill.h
+ *
+ * LCA OOM-killer Header
+ * Copyright (C)  2005.5.9  Coywolf Qi Hunt
+ */
+
+#ifndef _LINUX_OOM_KILL_H
+#define _LINUX_OOM_KILL_H
+
+extern unsigned int lca_level;
+extern unsigned int lca_time;
+extern spinlock_t last_chosen_parent_lock;
+extern struct task_struct *last_chosen_parent;
+
+unsigned long badness(struct task_struct *p, unsigned long uptime);
+
+#endif /* _LINUX_OOM_KILL_H */
diff -pruN 2.6.12-rc4-mm1/include/linux/sched.h 2.6.12-rc4-mm1-cy/include/linux/sched.h
--- 2.6.12-rc4-mm1/include/linux/sched.h	2005-05-12 19:25:32.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/include/linux/sched.h	2005-05-13 16:35:42.000000000 +0800
@@ -663,11 +663,7 @@ struct task_struct {
 	unsigned did_exec:1;
 	pid_t pid;
 	pid_t tgid;
-	/* 
-	 * pointers to (original) parent process, youngest child, younger sibling,
-	 * older sibling, respectively.  (p->father can be replaced with 
-	 * p->parent->pid)
-	 */
+
 	struct task_struct *real_parent; /* real parent process (when being debugged) */
 	struct task_struct *parent;	/* parent process */
 	/*
@@ -676,6 +672,9 @@ struct task_struct {
 	 */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
+	struct task_struct *bio_parent;	/* biological parent process */
+	struct list_head bio_children;
+	struct list_head bio_sibling;
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
diff -pruN 2.6.12-rc4-mm1/include/linux/sysctl.h 2.6.12-rc4-mm1-cy/include/linux/sysctl.h
--- 2.6.12-rc4-mm1/include/linux/sysctl.h	2005-05-12 19:25:33.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/include/linux/sysctl.h	2005-05-13 16:35:42.000000000 +0800
@@ -171,6 +171,8 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_LCA_LEVEL	 = 29,	/* LCA oom-killer work level */
+	VM_LCA_TIME	 = 30,	/* for last_chosen_parent time out */
 };
 
 
diff -pruN 2.6.12-rc4-mm1/kernel/exit.c 2.6.12-rc4-mm1-cy/kernel/exit.c
--- 2.6.12-rc4-mm1/kernel/exit.c	2005-05-12 19:25:34.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/kernel/exit.c	2005-05-13 16:35:42.000000000 +0800
@@ -29,6 +29,7 @@
 #include <linux/perfctr.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/oom_kill.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -55,6 +56,7 @@ static void __unhash_process(struct task
 	}
 
 	REMOVE_LINKS(p);
+	list_del_init(&p->bio_sibling);
 }
 
 void release_task(struct task_struct * p)
@@ -224,6 +226,9 @@ static inline int has_stopped_jobs(int p
  * been inherited from a user process, so we reset them to sane values here.
  *
  * NOTE that reparent_to_init() gives the caller full capabilities.
+ *
+ * We change kernel threads' current->bio_*, thus find_lca()
+ * will not catch it.  -- coywolf
  */
 static inline void reparent_to_init(void)
 {
@@ -235,6 +240,9 @@ static inline void reparent_to_init(void
 	current->parent = child_reaper;
 	current->real_parent = child_reaper;
 	SET_LINKS(current);
+	list_del_init(&current->bio_sibling);
+	current->bio_parent = child_reaper;
+	list_add_tail(&current->bio_sibling, &child_reaper->bio_children);
 
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
@@ -514,7 +522,7 @@ static void exit_mm(struct task_struct *
 	mmput(mm);
 }
 
-static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
+static inline void choose_new_parent(task_t *p, task_t *reaper)
 {
 	/*
 	 * Make sure we're not reparenting to ourselves and that
@@ -611,7 +619,7 @@ static inline void forget_original_paren
 	 * Search them and reparent children.
 	 */
 	list_for_each_safe(_p, _n, &father->children) {
-		int ptrace;
+		long ptrace;
 		p = list_entry(_p,struct task_struct,sibling);
 
 		ptrace = p->ptrace;
@@ -621,7 +629,7 @@ static inline void forget_original_paren
 
 		if (father == p->real_parent) {
 			/* reparent with a reaper, real father it's us */
-			choose_new_parent(p, reaper, child_reaper);
+			choose_new_parent(p, reaper);
 			reparent_thread(p, father, 0);
 		} else {
 			/* reparent ptraced task to its real parent */
@@ -642,9 +650,24 @@ static inline void forget_original_paren
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
 		p = list_entry(_p,struct task_struct,ptrace_list);
-		choose_new_parent(p, reaper, child_reaper);
+		choose_new_parent(p, reaper);
 		reparent_thread(p, father, 1);
 	}
+
+	list_for_each_safe(_p, _n,  &father->bio_children) {
+		p = list_entry(_p, struct task_struct, bio_sibling);
+		list_del_init(&p->bio_sibling);
+		p->bio_parent = father->bio_parent;
+		list_add_tail(&p->bio_sibling, &(p->bio_parent)->bio_children);
+	}
+
+	spin_lock(&last_chosen_parent_lock);
+	if (unlikely(father == last_chosen_parent)) {
+		last_chosen_parent = father->bio_parent;
+		if (last_chosen_parent->pid == 1)
+			last_chosen_parent = NULL;
+	}
+	spin_unlock(&last_chosen_parent_lock);
 }
 
 /*
diff -pruN 2.6.12-rc4-mm1/kernel/fork.c 2.6.12-rc4-mm1-cy/kernel/fork.c
--- 2.6.12-rc4-mm1/kernel/fork.c	2005-05-12 19:25:34.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/kernel/fork.c	2005-05-13 16:35:42.000000000 +0800
@@ -914,6 +914,8 @@ static task_t *copy_process(unsigned lon
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	INIT_LIST_HEAD(&p->bio_children);
+	INIT_LIST_HEAD(&p->bio_sibling);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
 	spin_lock_init(&p->proc_lock);
@@ -1046,6 +1048,7 @@ static task_t *copy_process(unsigned lon
 	else
 		p->real_parent = current;
 	p->parent = p->real_parent;
+	p->bio_parent = current;
 
 	if (clone_flags & CLONE_THREAD) {
 		spin_lock(&current->sighand->siglock);
@@ -1096,6 +1099,7 @@ static task_t *copy_process(unsigned lon
 	p->ioprio = current->ioprio;
 
 	SET_LINKS(p);
+	list_add_tail(&p->bio_sibling, &current->bio_children);
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
diff -pruN 2.6.12-rc4-mm1/kernel/sysctl.c 2.6.12-rc4-mm1-cy/kernel/sysctl.c
--- 2.6.12-rc4-mm1/kernel/sysctl.c	2005-05-12 19:25:34.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/kernel/sysctl.c	2005-05-13 16:35:42.000000000 +0800
@@ -41,6 +41,7 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/oom_kill.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -650,6 +651,7 @@ static ctl_table kern_table[] = {
 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
 static int zero;
+static int two = 2;
 static int one_hundred = 100;
 
 
@@ -837,6 +839,26 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_LCA_LEVEL,
+		.procname	= "lca_level",
+		.data		= &lca_level,
+		.maxlen		= sizeof(lca_level),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &two,
+	},
+	{
+		.ctl_name	= VM_LCA_TIME,
+		.procname	= "lca_time",
+		.data		= &lca_time,
+		.maxlen		= sizeof(lca_time),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -pruN 2.6.12-rc4-mm1/mm/oom_kill.c 2.6.12-rc4-mm1-cy/mm/oom_kill.c
--- 2.6.12-rc4-mm1/mm/oom_kill.c	2005-04-22 11:08:05.000000000 +0800
+++ 2.6.12-rc4-mm1-cy/mm/oom_kill.c	2005-05-13 16:35:42.000000000 +0800
@@ -5,6 +5,9 @@
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
  *
+ *  Copyright (C)  2005.5  Coywolf Qi Hunt
+ *	LCA OOM-killer added
+ *
  *  The routines in this file are used to kill a process when
  *  we're seriously out of memory. This gets called from kswapd()
  *  in linux/mm/vmscan.c when we really run out of memory.
@@ -15,13 +18,18 @@
  *  kernel subsystems and hints as to where to find out what things do.
  */
 
+/* #define DEBUG */
+
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 
-/* #define DEBUG */
+unsigned int lca_level = 0;
+unsigned int lca_time  = 5;
+DEFINE_SPINLOCK(last_chosen_parent_lock);
+struct task_struct *last_chosen_parent = NULL;
 
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
@@ -56,22 +64,22 @@ unsigned long badness(struct task_struct
 	points = p->mm->total_vm;
 
 	/*
-	 * Processes which fork a lot of child processes are likely
-	 * a good choice. We add the vmsize of the childs if they
+	 * Processes which have a lot of bio_children processes are likely
+	 * a good choice. We add the vmsize of the bio_children if they
 	 * have an own mm. This prevents forking servers to flood the
-	 * machine with an endless amount of childs
+	 * machine with an endless amount of childs.
 	 */
-	list_for_each(tsk, &p->children) {
+	list_for_each(tsk, &p->bio_children) {
 		struct task_struct *chld;
-		chld = list_entry(tsk, struct task_struct, sibling);
+		chld = list_entry(tsk, struct task_struct, bio_sibling);
 		if (chld->mm != p->mm && chld->mm)
-			points += chld->mm->total_vm;
+			points += chld->mm->total_vm / 8;
 	}
 
 	/*
 	 * CPU time is in tens of seconds and run time is in thousands
-         * of seconds. There is no particular reason for this other than
-         * that it turned out to work very well in practice.
+	 * of seconds. There is no particular reason for this other than
+	 * that it turned out to work very well in practice.
 	 */
 	cpu_time = (cputime_to_jiffies(p->utime) + cputime_to_jiffies(p->stime))
 		>> (SHIFT_HZ + 3);
@@ -122,14 +130,57 @@ unsigned long badness(struct task_struct
 			points >>= -(p->oomkilladj);
 	}
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
-#endif
+	pr_debug("OOMkill: task %d (%s) got %lu points\n",
+			p->pid, p->comm, points);
+
 	return points;
 }
 
 /*
+ * LCA: Least Common Ancestor
+ *
+ * Returns NULL if no LCA (LCA is init or swapper)
+ *
+ * I prefer to use task_t for function parameters, and
+ * struct task_struct elsewhere.  -- coywolf
+ */
+static struct task_struct * find_lca(task_t *p1, task_t *p2)
+{
+	struct task_struct *tsk1 = p1;
+	struct task_struct *tsk2 = p2;
+	struct task_struct *lca = NULL;
+
+	if (tsk1 == tsk2) {
+		lca = tsk1;
+		goto out;
+	}
+
+	while (tsk1->bio_parent != &init_task) {
+		list_move(&tsk1->bio_sibling, &tsk1->bio_parent->bio_children);
+		tsk1 = tsk1->bio_parent;
+	}
+
+	while (tsk2->bio_parent != &init_task) {
+		list_move_tail(&tsk2->bio_sibling, 
+				&tsk2->bio_parent->bio_children);
+		tsk2 = tsk2->bio_parent;
+	}
+
+	while (tsk1 == tsk2) {
+		tsk1 = list_entry(tsk1->bio_children.next, struct task_struct,
+				bio_sibling);
+		tsk2 = list_entry(tsk2->bio_children.prev, struct task_struct,
+				bio_sibling);
+	}
+
+	if (tsk1->bio_parent->pid > 1)
+		lca = tsk1->bio_parent;
+
+out:
+	return lca;
+}
+
+/*
  * Simple selection loop. We chose the process with the highest
  * number of 'points'. We expect the caller will lock the tasklist.
  *
@@ -138,9 +189,10 @@ unsigned long badness(struct task_struct
 static struct task_struct * select_bad_process(void)
 {
 	unsigned long maxpoints = 0;
-	struct task_struct *g, *p;
+	struct task_struct *g, *p, *lca;
 	struct task_struct *chosen = NULL;
 	struct timespec uptime;
+	static unsigned long timeout;
 
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p)
@@ -151,10 +203,24 @@ static struct task_struct * select_bad_p
 			/*
 			 * This is in the process of releasing memory so wait it
 			 * to finish before killing some other task by mistake.
+			 *
+			 * But we do not wait if it hits more than 10 times in a
+			 * 5 seconds interval.  -- coywolf
 			 */
 			if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags & PF_EXITING)) &&
-			    !(p->flags & PF_DEAD))
-				return ERR_PTR(-1UL);
+			    !(p->flags & PF_DEAD)) {
+				static unsigned long timeout, count;
+
+				if (time_after(jiffies, timeout))
+					count = 0;
+				printk("releasing memory: process %d (%s) count=%lu\n", p->pid, p->comm, count++);
+				if (count < 10) {
+					timeout = jiffies + (5 * HZ);
+					return ERR_PTR(-1UL);
+				}
+				continue;
+			}
+
 			if (p->flags & PF_SWAPOFF)
 				return p;
 
@@ -165,6 +231,44 @@ static struct task_struct * select_bad_p
 			}
 		}
 	while_each_thread(g, p);
+
+	if (!chosen)
+		goto out;
+
+	spin_lock(&last_chosen_parent_lock);
+	switch (lca_level) {
+		case 0:
+			if (!last_chosen_parent || time_after(jiffies, timeout)) {
+				timeout = jiffies + lca_time * HZ;
+				last_chosen_parent = chosen->bio_parent;
+				goto out1;
+			}
+		case 1:
+			if (!last_chosen_parent || time_after(jiffies, timeout)) {
+				timeout = jiffies + (1<<lca_time++) * HZ;
+				last_chosen_parent = chosen->bio_parent;
+				goto out1;
+			}
+		default:
+			if (!last_chosen_parent) {
+				last_chosen_parent = chosen->bio_parent;
+				goto out1;
+			}
+	}
+
+	lca = find_lca(last_chosen_parent, chosen);
+	if (lca) {
+		last_chosen_parent = lca->bio_parent;
+		chosen = lca;
+	} else
+		last_chosen_parent = chosen->bio_parent;
+
+out1:
+	if (last_chosen_parent->pid == 1)
+		last_chosen_parent = NULL;
+	spin_unlock(last_chosen_parent_lock);
+
+out:
 	return chosen;
 }
 
@@ -184,11 +288,16 @@ static void __oom_kill_task(task_t *p)
 	task_lock(p);
 	if (!p->mm || p->mm == &init_mm) {
 		WARN_ON(1);
-		printk(KERN_WARNING "tried to kill an mm-less task!\n");
+		printk(KERN_WARNING "tried to kill mm-less task %d (%s)!\n", p->pid, p->comm);
 		task_unlock(p);
 		return;
 	}
 	task_unlock(p);
+	if (p->pid == 1) {
+		WARN_ON(1);
+		printk(KERN_WARNING "2ed tried to kill init!\n");
+		return;
+	}
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
 
 	/*
@@ -202,47 +311,39 @@ static void __oom_kill_task(task_t *p)
 	force_sig(SIGKILL, p);
 }
 
-static struct mm_struct *oom_kill_task(task_t *p)
+static int oom_kill_task(task_t *p)
 {
 	struct mm_struct *mm = get_task_mm(p);
-	task_t * g, * q;
+	struct task_struct *t = p;
+	struct list_head *n;
 
 	if (!mm)
-		return NULL;
+		return 0;
 	if (mm == &init_mm) {
 		mmput(mm);
-		return NULL;
+		return 0;
 	}
+	mmput(mm);
 
-	__oom_kill_task(p);
-	/*
-	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
-	 */
-	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q);
-	while_each_thread(g, q);
-
-	return mm;
-}
-
-static struct mm_struct *oom_kill_process(struct task_struct *p)
-{
- 	struct mm_struct *mm;
-	struct task_struct *c;
-	struct list_head *tsk;
-
-	/* Try to kill a child first */
-	list_for_each(tsk, &p->children) {
-		c = list_entry(tsk, struct task_struct, sibling);
-		if (c->mm == p->mm)
-			continue;
-		mm = oom_kill_task(c);
-		if (mm)
-			return mm;
+	/* Kill all its descendants if any and itself */
+repeat:
+	n = &t->bio_children;
+	while (!list_empty(n)) {
+		n = n->next;
+		t = list_entry(n, struct task_struct, bio_sibling);
+		n = &t->bio_children;
 	}
-	return oom_kill_task(p);
+
+	if (!(test_tsk_thread_flag(t, TIF_MEMDIE) || (t->flags & PF_EXITING)
+		|| (t->flags & PF_DEAD)) && t->mm)
+		__oom_kill_task(t);
+
+	list_del_init(&t->bio_sibling);
+	t = t->bio_parent;
+	if (t != p->bio_parent)
+		goto repeat;
+	
+	return 1;
 }
 
 /**
@@ -255,7 +356,6 @@ static struct mm_struct *oom_kill_proces
  */
 void out_of_memory(unsigned int __nocast gfp_mask)
 {
-	struct mm_struct *mm = NULL;
 	task_t * p;
 
 	read_lock(&tasklist_lock);
@@ -274,14 +374,11 @@ retry:
 
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-	mm = oom_kill_process(p);
-	if (!mm)
+	if (!oom_kill_task(p))
 		goto retry;
 
  out:
 	read_unlock(&tasklist_lock);
-	if (mm)
-		mmput(mm);
 
 	/*
 	 * Give "p" a good chance of killing itself before we
