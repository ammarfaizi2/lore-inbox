Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVC1Em4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVC1Em4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 23:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVC1Em4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 23:42:56 -0500
Received: from everest.2mbit.com ([24.123.221.2]:4072 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261698AbVC1EmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 23:42:18 -0500
Date: Sun, 27 Mar 2005 23:42:17 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch] oom lca -- fork bombing killer
Message-ID: <20050328044217.GA6362@everest.sosdg.org>
Reply-To: coywolf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



							   March 28, 2005
							  Coywolf Qi Hunt
							coywolf@gmail.com


			Linux OOM LCA (Least Common Ancestor) Patch

				An anti Fork Bombing Solution


Introduction

   People complain that linux is still vulnerable to the ancient fork bombing.
   A quick scratch <http://freeforge.net/~coywolf/oom-bomb/> simply running
   as normal user could make a linux box totally unusable.

   Another example is in the recent thread: oom with 2.6.11
   <http://lkml.org/lkml/2005/3/17/142>

   The only way currently to deal with fork bombing is to limit the number of
   running processes or the forking rate. This patch brings a new way to find
   out and kill the possible fork bombing processes or any misbehaving processes
   taking up too much memory.

   The patch applies to 2.6.12-rc1-mm3 and seems able to kill various fork 
   bombings. 
   

Simple Experiment Result

   It is tested on an 256M desktop box. With swapoff and in console, it works
   pretty well.  After the fork bomber has forked into about 1500 instances,

	RES = 1036k
	SHR = 876k
	1500*(1036k-876k)=234M

   it got killed completely.

   When the fork bomber is running as root, kernel first kills the X server and 
   XFce4 el al, immediately kernel kills the bomb totally too.

   I haven't tested with swapon yet. The hard disk would keep swapping badly 
   then.  
   
   When in X, the screen got corrupted, but the box can still reboot through
   ctrl+alt+del. 


The oom LCA algorithm details

   1. New elements add to struct task_struct :
      struct task_struct *bio_parent
      struct list_head bio_children;
      struct list_head bio_sibling;

      Adds struct task_struct *bio_parent to struct task_struct.
      Unlike struct task_struct *parent, user programs can not change it
      by daemon(3).  It is describing the facts except when it is a kernel
      thread. We don't plan to oom kill any kernel threads.

   2. If a process is malicious, we'll consider its children malicious too. 
      So we kill the choose process and all its descendants. This way we'll be
      far faster than the tumor forking. LCA always grows upwards.

   3. LCA(Least Common Ancestor Algorithm, I choose the term LCA for it is more 
      widely used than NCA(Nearest Common Ancestor) according to google.)
      We remember the last killed process' parent, next time we'll kill
      the remembered last_chosen_parent and the new worst process(the highest
      badness)'s least common ancestor. NOTE if find_lca() fails, we just kill 
      the worst process and we must _update_ the last_kill_process to a new 
      value.

   4. Calculates oom badness
      bio_children is considered instead of children.


Not quite related changes

   I also include some other obvious cleanups. They are:

      1. hides reparent_to_init(), reparent_to_init() should be called only by
         daemonize()
      2. removes obsolete code comments in task_struct
      3. removes an obsolete parameter from choose_new_parent() and cleanups
      4. in reparent_thread(), ptrace should be type long, not int.
      5. cleanups in mm/oom_kill.c


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

 arch/i386/mach-voyager/voyager_thread.c |    1 
 include/linux/init_task.h               |    3 
 include/linux/sched.h                   |   10 --
 kernel/exit.c                           |   34 ++++++-
 kernel/fork.c                           |    4 
 mm/oom_kill.c                           |  141 ++++++++++++++++++++------------
 6 files changed, 129 insertions(+), 64 deletions(-)

diff -pruN 2.6.12-rc1-mm3/arch/i386/mach-voyager/voyager_thread.c 2.6.12-rc1-mm3-cy/arch/i386/mach-voyager/voyager_thread.c
--- 2.6.12-rc1-mm3/arch/i386/mach-voyager/voyager_thread.c	2004-08-20 14:39:58.000000000 +0800
+++ 2.6.12-rc1-mm3-cy/arch/i386/mach-voyager/voyager_thread.c	2005-03-28 10:18:24.000000000 +0800
@@ -126,7 +126,6 @@ thread(void *unused)
 
 	kvoyagerd_running = 1;
 
-	reparent_to_init();
 	daemonize(THREAD_NAME);
 
 	set_timeout = 0;
diff -pruN 2.6.12-rc1-mm3/include/linux/init_task.h 2.6.12-rc1-mm3-cy/include/linux/init_task.h
--- 2.6.12-rc1-mm3/include/linux/init_task.h	2005-03-26 13:21:10.000000000 +0800
+++ 2.6.12-rc1-mm3-cy/include/linux/init_task.h	2005-03-28 10:18:24.000000000 +0800
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
diff -pruN 2.6.12-rc1-mm3/include/linux/sched.h 2.6.12-rc1-mm3-cy/include/linux/sched.h
--- 2.6.12-rc1-mm3/include/linux/sched.h	2005-03-26 13:21:11.000000000 +0800
+++ 2.6.12-rc1-mm3-cy/include/linux/sched.h	2005-03-28 10:18:24.000000000 +0800
@@ -656,11 +656,7 @@ struct task_struct {
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
@@ -669,6 +665,9 @@ struct task_struct {
 	 */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
+	struct task_struct *bio_parent;	
+	struct list_head bio_children;
+	struct list_head bio_sibling;
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
@@ -1068,7 +1067,6 @@ extern void exit_itimers(struct signal_s
 
 extern NORET_TYPE void do_group_exit(int);
 
-extern void reparent_to_init(void);
 extern void daemonize(const char *, ...);
 extern int allow_signal(int);
 extern int disallow_signal(int);
diff -pruN 2.6.12-rc1-mm3/kernel/exit.c 2.6.12-rc1-mm3-cy/kernel/exit.c
--- 2.6.12-rc1-mm3/kernel/exit.c	2005-03-26 13:21:12.000000000 +0800
+++ 2.6.12-rc1-mm3-cy/kernel/exit.c	2005-03-28 10:18:24.000000000 +0800
@@ -52,6 +52,7 @@ static void __unhash_process(struct task
 	}
 
 	REMOVE_LINKS(p);
+	list_del_init(&p->bio_sibling);
 }
 
 void release_task(struct task_struct * p)
@@ -221,8 +222,11 @@ static inline int has_stopped_jobs(int p
  * been inherited from a user process, so we reset them to sane values here.
  *
  * NOTE that reparent_to_init() gives the caller full capabilities.
+ *
+ * We change kernel threads' current->bio_*, thus find_lca()
+ * will not catch it.  -- coywolf
  */
-void reparent_to_init(void)
+static inline void reparent_to_init(void)
 {
 	write_lock_irq(&tasklist_lock);
 
@@ -232,6 +236,9 @@ void reparent_to_init(void)
 	current->parent = child_reaper;
 	current->real_parent = child_reaper;
 	SET_LINKS(current);
+	list_del_init(&current->bio_sibling);
+	current->bio_parent = child_reaper;
+	list_add_tail(&current->bio_sibling, &child_reaper->bio_children);
 
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
@@ -511,16 +518,15 @@ void exit_mm(struct task_struct * tsk)
 	mmput(mm);
 }
 
-static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
+static inline void choose_new_parent(task_t *p, task_t *reaper)
 {
 	/*
 	 * Make sure we're not reparenting to ourselves and that
 	 * the parent is not a zombie.
 	 */
 	BUG_ON(p == reaper || reaper->exit_state >= EXIT_ZOMBIE);
+	BUG_ON(p->parent == reaper);
 	p->real_parent = reaper;
-	if (p->parent == p->real_parent)
-		BUG();
 }
 
 static inline void reparent_thread(task_t *p, task_t *father, int traced)
@@ -590,6 +596,7 @@ static inline void reparent_thread(task_
 static inline void forget_original_parent(struct task_struct * father,
 					  struct list_head *to_release)
 {
+	extern struct task_struct *last_chosen_parent;
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p, *_n;
 
@@ -610,7 +617,7 @@ static inline void forget_original_paren
 	 * Search them and reparent children.
 	 */
 	list_for_each_safe(_p, _n, &father->children) {
-		int ptrace;
+		long ptrace;
 		p = list_entry(_p,struct task_struct,sibling);
 
 		ptrace = p->ptrace;
@@ -620,7 +627,7 @@ static inline void forget_original_paren
 
 		if (father == p->real_parent) {
 			/* reparent with a reaper, real father it's us */
-			choose_new_parent(p, reaper, child_reaper);
+			choose_new_parent(p, reaper);
 			reparent_thread(p, father, 0);
 		} else {
 			/* reparent ptraced task to its real parent */
@@ -641,9 +648,22 @@ static inline void forget_original_paren
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
+		if (last_chosen_parent == &init_task)
+			last_chosen_parent = NULL;
+	}
 }
 
 /*
diff -pruN 2.6.12-rc1-mm3/kernel/fork.c 2.6.12-rc1-mm3-cy/kernel/fork.c
--- 2.6.12-rc1-mm3/kernel/fork.c	2005-03-26 13:21:12.000000000 +0800
+++ 2.6.12-rc1-mm3-cy/kernel/fork.c	2005-03-28 10:18:24.000000000 +0800
@@ -915,6 +915,8 @@ static task_t *copy_process(unsigned lon
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
+	INIT_LIST_HEAD(&p->bio_children);
+	INIT_LIST_HEAD(&p->bio_sibling);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
 	spin_lock_init(&p->proc_lock);
@@ -1044,6 +1046,7 @@ static task_t *copy_process(unsigned lon
 	else
 		p->real_parent = current;
 	p->parent = p->real_parent;
+	p->bio_parent = current;
 
 	if (clone_flags & CLONE_THREAD) {
 		spin_lock(&current->sighand->siglock);
@@ -1094,6 +1097,7 @@ static task_t *copy_process(unsigned lon
 	p->ioprio = current->ioprio;
 
 	SET_LINKS(p);
+	list_add_tail(&p->bio_sibling, &current->bio_children);
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
diff -pruN 2.6.12-rc1-mm3/mm/oom_kill.c 2.6.12-rc1-mm3-cy/mm/oom_kill.c
--- 2.6.12-rc1-mm3/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
+++ 2.6.12-rc1-mm3-cy/mm/oom_kill.c	2005-03-28 10:34:37.000000000 +0800
@@ -21,7 +21,9 @@
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 
-/* #define DEBUG */
+#define DEBUG
+
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
 			points += chld->mm->total_vm;
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
@@ -122,14 +124,34 @@ unsigned long badness(struct task_struct
 			points >>= -(p->oomkilladj);
 	}
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
-#endif
+	pr_debug("OOMkill: task %d (%s) got %d points\n",
+			p->pid, p->comm, points);
+
 	return points;
 }
 
 /*
+ * LCA: Least Common Ancestor
+ *
+ * Returns NULL if no LCA (LCA is init_task)
+ *
+ * I prefer to use task_t for function parameters, and
+ * struct task_struct elsewhere.  -- coywolf
+ */
+static struct task_struct * find_lca(task_t *p1, task_t *p2)
+{
+	struct task_struct *tsk1, *tsk2;
+
+	for (tsk1 = p1; tsk1 != &init_task; tsk1 = tsk1->bio_parent) {
+		for (tsk2 = p2; tsk2 != &init_task; tsk2 = tsk2->bio_parent)
+			if (tsk1 == tsk2)
+				return tsk1;
+	}
+
+	return NULL;
+}
+
+/*
  * Simple selection loop. We chose the process with the highest
  * number of 'points'. We expect the caller will lock the tasklist.
  *
@@ -138,7 +160,7 @@ unsigned long badness(struct task_struct
 static struct task_struct * select_bad_process(void)
 {
 	unsigned long maxpoints = 0;
-	struct task_struct *g, *p;
+	struct task_struct *g, *p, *lca;
 	struct task_struct *chosen = NULL;
 	struct timespec uptime;
 
@@ -165,9 +187,42 @@ static struct task_struct * select_bad_p
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
+	} else {
+		last_chosen_parent = chosen->bio_parent;
+	}
+
+out1:
+	if (last_chosen_parent == &init_task)
+		last_chosen_parent = NULL;
+
+out:
 	return chosen;
 }
 
+static int is_ancestor(task_t *ancestor, task_t *p)
+{
+	struct task_struct *tsk;
+
+	for (tsk = p; tsk != &init_task; tsk = tsk->bio_parent)
+		if (tsk == ancestor)
+			return 1;
+
+	return 0;
+}
+
 /**
  * We must be careful though to never send SIGKILL a process with
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
@@ -184,7 +239,7 @@ static void __oom_kill_task(task_t *p)
 	task_lock(p);
 	if (!p->mm || p->mm == &init_mm) {
 		WARN_ON(1);
-		printk(KERN_WARNING "tried to kill an mm-less task!\n");
+		printk(KERN_WARNING "tried to kill mm-less task %d (%s)!\n", p->pid, p->comm);
 		task_unlock(p);
 		return;
 	}
@@ -202,47 +257,37 @@ static void __oom_kill_task(task_t *p)
 	force_sig(SIGKILL, p);
 }
 
-static struct mm_struct *oom_kill_task(task_t *p)
+static int oom_kill_task(task_t *p)
 {
 	struct mm_struct *mm = get_task_mm(p);
-	task_t * g, * q;
+	struct task_struct *q;
 
 	if (!mm)
-		return NULL;
+		return 0;
 	if (mm == &init_mm) {
 		mmput(mm);
-		return NULL;
+		return 0;
 	}
 
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
+	if (list_empty(&p->bio_children)) {
+		mmput(mm);
+		__oom_kill_task(p);
+		return 1;
+	}
 
-	/* Try to kill a child first */
-	list_for_each(tsk, &p->children) {
-		c = list_entry(tsk, struct task_struct, sibling);
-		if (c->mm == p->mm)
-			continue;
-		mm = oom_kill_task(c);
-		if (mm)
-			return mm;
+	/* Kill all descendants */
+	for_each_process(q) {
+		if (q->pid > 1) {
+			if (test_tsk_thread_flag(q, TIF_MEMDIE) ||
+				(q->flags & PF_EXITING) || (q->flags & PF_DEAD))
+				continue;
+			if (is_ancestor(p, q))
+				__oom_kill_task(q);
+		}
 	}
-	return oom_kill_task(p);
+	
+	mmput(mm);
+	return 1;
 }
 
 /**
@@ -255,7 +300,6 @@ static struct mm_struct *oom_kill_proces
  */
 void out_of_memory(int gfp_mask)
 {
-	struct mm_struct *mm = NULL;
 	task_t * p;
 
 	read_lock(&tasklist_lock);
@@ -274,14 +318,11 @@ retry:
 
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

