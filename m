Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVEBVqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVEBVqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVEBVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:46:32 -0400
Received: from everest.sosdg.org ([66.93.203.161]:3482 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261159AbVEBVpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:45:22 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Tue, 3 May 2005 05:45:15 +0800
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Message-ID: <20050502214515.GA8891@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Scan-Signature: 97f9c37d4f0137cf35056489031e53fe
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] oom lca -- fork bombing killer v2.2
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


							      May 3, 2005
							  Coywolf Qi Hunt
							coywolf@gmail.com


		Linux OOM LCA (Least Common Ancestor) Patch v2.2

			A Fork Bombing Solution


This is oom lca killer v2.2. Here are the changes since the last release,

   1. bug fix: moves DEBUG ahead of header files

   2. warning fix: in pr_debug() format, %d -> %lu

   3. bug fix: in badness(), changes to add 1/3  of a child's total_vm,
      so the parent's badness point isn't always greater than its children's.

   4. Algorithm O(n) -> O(n^2)
   	in find_lca() and oom_kill_task() kill all descendants part

   5. splits out reparent_to_init() cleanup into a separate patch. (merged)

   6. bug fix: fix release memory waiting deadlock

   7. other severe bug fix

I didn't find a proper header file for the last_chosen_parent declaration.
Maybe in the future we create a new header file and move fs/proc/base.c::badness()
prototype there too. (http://lkml.org/lkml/2005/3/30/262)

Todo

   Make it SMP-safe


This patch protects my desktop computer from fork bombing attacks.
My desktop survived after these three bombers: (http://freeforge.net/~coywolf/pub/oom-bomb/)

	a.sh 
		The current stock oom-killer cannot handle. 

	b.sh 
		Harder than a.sh

	folkert
		The hardest one. (from Folkert van Heusden <folkert@vanheusden.com>)

With a.sh or b.sh, my desktop survived perfectly, xfce, firefox and etc still running after
oom kills offending processes, without touching any regular system processes.

With folkert, a lot of innocent processes got killed, but the system still survived.
The killing of X server left the screen state messed up, but the keyboard still responds,
caps lock and scroll lock LED's still work. klogd is still running. After ctrl+alt+del 
I can check the klog.

If swap is on, folkert brings the worst case.  Sysrq-f could be used to trigger the oom earlier.
In my case, it put my desktop unusable for 5~6 minutes until all 256M swap got used up and oom triggered.

In practice, this patch should be used together with fine tuned /proc/$pid/oom_adj to protect
direct hardware access processes and other important processes.

Providers and individuals who run public shell servers or other services with end user processes
will highly benefit from this functionality.


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

 include/linux/init_task.h |    3 
 include/linux/sched.h     |    9 +-
 kernel/exit.c             |   29 ++++++-
 kernel/fork.c             |    4 +
 mm/oom_kill.c             |  178 ++++++++++++++++++++++++++++++++--------------
 5 files changed, 160 insertions(+), 63 deletions(-)

diff -pruN 2.6.12-rc3-mm2/include/linux/init_task.h 2.6.12-rc3-mm2-cy/include/linux/init_task.h
--- 2.6.12-rc3-mm2/include/linux/init_task.h	2005-05-01 08:08:23.000000000 +0800
+++ 2.6.12-rc3-mm2-cy/include/linux/init_task.h	2005-05-01 19:25:09.000000000 +0800
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
diff -pruN 2.6.12-rc3-mm2/include/linux/sched.h 2.6.12-rc3-mm2-cy/include/linux/sched.h
--- 2.6.12-rc3-mm2/include/linux/sched.h	2005-05-01 08:08:24.000000000 +0800
+++ 2.6.12-rc3-mm2-cy/include/linux/sched.h	2005-05-01 19:25:09.000000000 +0800
@@ -661,11 +661,7 @@ struct task_struct {
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
@@ -674,6 +670,9 @@ struct task_struct {
 	 */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
+	struct task_struct *bio_parent;	/* biological parent process */
+	struct list_head bio_children;
+	struct list_head bio_sibling;
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
diff -pruN 2.6.12-rc3-mm2/kernel/exit.c 2.6.12-rc3-mm2-cy/kernel/exit.c
--- 2.6.12-rc3-mm2/kernel/exit.c	2005-05-01 08:08:25.000000000 +0800
+++ 2.6.12-rc3-mm2-cy/kernel/exit.c	2005-05-02 15:29:41.000000000 +0800
@@ -55,6 +55,7 @@ static void __unhash_process(struct task
 	}
 
 	REMOVE_LINKS(p);
+	list_del_init(&p->bio_sibling);
 }
 
 void release_task(struct task_struct * p)
@@ -224,6 +225,9 @@ static inline int has_stopped_jobs(int p
  * been inherited from a user process, so we reset them to sane values here.
  *
  * NOTE that reparent_to_init() gives the caller full capabilities.
+ *
+ * We change kernel threads' current->bio_*, thus find_lca()
+ * will not catch it.  -- coywolf
  */
 static inline void reparent_to_init(void)
 {
@@ -235,6 +239,9 @@ static inline void reparent_to_init(void
 	current->parent = child_reaper;
 	current->real_parent = child_reaper;
 	SET_LINKS(current);
+	list_del_init(&current->bio_sibling);
+	current->bio_parent = child_reaper;
+	list_add_tail(&current->bio_sibling, &child_reaper->bio_children);
 
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
@@ -514,7 +521,7 @@ static void exit_mm(struct task_struct *
 	mmput(mm);
 }
 
-static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
+static inline void choose_new_parent(task_t *p, task_t *reaper)
 {
 	/*
 	 * Make sure we're not reparenting to ourselves and that
@@ -591,6 +598,7 @@ static inline void reparent_thread(task_
 static inline void forget_original_parent(struct task_struct * father,
 					  struct list_head *to_release)
 {
+	extern struct task_struct *last_chosen_parent;
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p, *_n;
 
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
@@ -642,9 +650,22 @@ static inline void forget_original_paren
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
+	if (unlikely(father == last_chosen_parent)) {
+		last_chosen_parent = father->bio_parent;
+		if (last_chosen_parent->pid == 1)
+			last_chosen_parent = NULL;
+	}
 }
 
 /*
diff -pruN 2.6.12-rc3-mm2/kernel/fork.c 2.6.12-rc3-mm2-cy/kernel/fork.c
--- 2.6.12-rc3-mm2/kernel/fork.c	2005-05-01 08:08:25.000000000 +0800
+++ 2.6.12-rc3-mm2-cy/kernel/fork.c	2005-05-01 19:25:09.000000000 +0800
@@ -911,6 +911,8 @@ static task_t *copy_process(unsigned lon
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	INIT_LIST_HEAD(&p->bio_children);
+	INIT_LIST_HEAD(&p->bio_sibling);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
 	spin_lock_init(&p->proc_lock);
@@ -1043,6 +1045,7 @@ static task_t *copy_process(unsigned lon
 	else
 		p->real_parent = current;
 	p->parent = p->real_parent;
+	p->bio_parent = current;
 
 	if (clone_flags & CLONE_THREAD) {
 		spin_lock(&current->sighand->siglock);
@@ -1093,6 +1096,7 @@ static task_t *copy_process(unsigned lon
 	p->ioprio = current->ioprio;
 
 	SET_LINKS(p);
+	list_add_tail(&p->bio_sibling, &current->bio_children);
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
diff -pruN 2.6.12-rc3-mm2/mm/oom_kill.c 2.6.12-rc3-mm2-cy/mm/oom_kill.c
--- 2.6.12-rc3-mm2/mm/oom_kill.c	2005-04-22 11:08:05.000000000 +0800
+++ 2.6.12-rc3-mm2-cy/mm/oom_kill.c	2005-05-02 23:29:46.000000000 +0800
@@ -15,13 +15,15 @@
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
+struct task_struct *last_chosen_parent = NULL;
 
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
@@ -56,22 +58,22 @@ unsigned long badness(struct task_struct
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
@@ -122,14 +124,57 @@ unsigned long badness(struct task_struct
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
@@ -138,7 +183,7 @@ unsigned long badness(struct task_struct
 static struct task_struct * select_bad_process(void)
 {
 	unsigned long maxpoints = 0;
-	struct task_struct *g, *p;
+	struct task_struct *g, *p, *lca;
 	struct task_struct *chosen = NULL;
 	struct timespec uptime;
 
@@ -147,14 +192,25 @@ static struct task_struct * select_bad_p
 		/* skip the init task with pid == 1 */
 		if (p->pid > 1 && p->oomkilladj != OOM_DISABLE) {
 			unsigned long points;
+			static int count;
+			static unsigned long timeout;
 
 			/*
 			 * This is in the process of releasing memory so wait it
 			 * to finish before killing some other task by mistake.
 			 */
 			if ((unlikely(test_tsk_thread_flag(p, TIF_MEMDIE)) || (p->flags & PF_EXITING)) &&
-			    !(p->flags & PF_DEAD))
-				return ERR_PTR(-1UL);
+			    !(p->flags & PF_DEAD)) {
+				if (time_after(jiffies, timeout))
+					count = 0;
+				printk("releasing memory: process %d (%s) count=%d\n", p->pid, p->comm, count++);
+				if (count < 10) {
+					timeout = jiffies + (5 * HZ);
+					return ERR_PTR(-1UL);
+				}
+				continue;
+			}
+
 			if (p->flags & PF_SWAPOFF)
 				return p;
 
@@ -165,6 +221,27 @@ static struct task_struct * select_bad_p
 			}
 		}
 	while_each_thread(g, p);
+
+	if (!chosen)
+		goto out;
+
+	if (!last_chosen_parent) {
+		last_chosen_parent = chosen->bio_parent;
+		goto out1;
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
+
+out:
 	return chosen;
 }
 
@@ -184,11 +261,16 @@ static void __oom_kill_task(task_t *p)
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
@@ -202,47 +284,39 @@ static void __oom_kill_task(task_t *p)
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
@@ -255,7 +329,6 @@ static struct mm_struct *oom_kill_proces
  */
 void out_of_memory(unsigned int __nocast gfp_mask)
 {
-	struct mm_struct *mm = NULL;
 	task_t * p;
 
 	read_lock(&tasklist_lock);
@@ -274,14 +347,11 @@ retry:
 
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
