Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVLJIU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVLJIU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVLJIUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:20:03 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:31705 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964964AbVLJITo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:44 -0500
Date: Sat, 10 Dec 2005 00:19:33 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081933.12303.75132.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 09/10] Cpuset: rebind vma mempolicies fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix more of longstanding bug in cpuset/mempolicy interaction.

NUMA mempolicies (mm/mempolicy.c) are constrained by the current
tasks cpuset to just the Memory Nodes allowed by that cpuset.
The kernel maintains internal state for each mempolicy, tracking
what nodes are used for the MPOL_INTERLEAVE, MPOL_BIND or
MPOL_PREFERRED policies.

When a tasks cpuset memory placement changes, whether because the
cpuset changed, or because the task was attached to a different
cpuset, then the tasks mempolicies have to be rebound to the
new cpuset placement, so as to preserve the cpuset-relative
numbering of the nodes in that policy.

An earlier fix handled such mempolicy rebinding for mempolicies
attached to a task.

This fix rebinds mempolicies attached to vma's (address
ranges in a tasks address space.)  Due to the need to hold
the task->mm->mmap_sem semaphore while updating vma's, the
rebinding of vma mempolicies has to be done when the cpuset
memory placement is changed, at which time mmap_sem can be
safely acquired.  The tasks mempolicy is rebound later, when
the task next attempts to allocate memory and notices that its
task->cpuset_mems_generation is out-of-date with its cpusets
mems_generation.

Because walking the tasklist to find all tasks attached to a
changing cpuset requires holding tasklist_lock, a spinlock,
one cannot update the vma's of the affected tasks while doing
the tasklist scan.  In general, one cannot acquire a semaphore
(which can sleep) while already holding a spinlock (such as
tasklist_lock).  So a list of mm references has to be built
up during the tasklist scan, then the tasklist lock dropped,
then for each mm, its mmap_sem acquired, and the vma's in that
mm rebound.

Once the tasklist lock is dropped, affected tasks may fork
new tasks, before their mm's are rebound.  A kernel global
'cpuset_being_rebound' is set to point to the cpuset being
rebound (there can only be one; cpuset modifications are done
under a global 'manage_sem' semaphore), and the mpol_copy code
that is used to copy a tasks mempolicies during fork catches
such forking tasks, and ensures their children are also rebound.

When a task is moved to a different cpuset, it is easier, as
there is only one task involved.  It's mm->vma's are scanned,
using the same mpol_rebind_policy() as used above.

It may happen that both the mpol_copy hook and the update done
via the tasklist scan update the same mm twice.  This is ok,
as the mempolicies of each vma in an mm keep track of what
mems_allowed they are relative to, and safely no-op a second
request to rebind to the same nodes.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/mempolicy.h |   18 ++++++++
 kernel/cpuset.c           |   94 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/mempolicy.c            |   29 ++++++++++++++
 3 files changed, 141 insertions(+)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-09 04:02:43.013074202 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-09 05:08:00.834840778 -0800
@@ -812,12 +812,24 @@ static int update_cpumask(struct cpuset 
 }
 
 /*
+ * Handle user request to change the 'mems' memory placement
+ * of a cpuset.  Needs to validate the request, update the
+ * cpusets mems_allowed and mems_generation, and for each
+ * task in the cpuset, rebind any vma mempolicies.
+ *
  * Call with manage_sem held.  May take callback_sem during call.
+ * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
+ * lock each such tasks mm->mmap_sem, scan its vma's and rebind
+ * their mempolicies to the cpusets new mems_allowed.
  */
 
 static int update_nodemask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
+	struct task_struct *g, *p;
+	struct mm_struct **mmarray;
+	int i, n, ntasks;
+	int fudge;
 	int retval;
 
 	trialcs = *cs;
@@ -839,6 +851,80 @@ static int update_nodemask(struct cpuset
 	cs->mems_generation = atomic_read(&cpuset_mems_generation);
 	up(&callback_sem);
 
+	set_cpuset_being_rebound(cs);		/* causes mpol_copy() rebind */
+
+	fudge = 10;				/* spare mmarray[] slots */
+	fudge += cpus_weight(cs->cpus_allowed);	/* imagine one fork-bomb/cpu */
+	retval = -ENOMEM;
+
+	/*
+	 * Allocate mmarray[] to hold mm reference for each task
+	 * in cpuset cs.  Can't kmalloc GFP_KERNEL while holding
+	 * tasklist_lock.  We could use GFP_ATOMIC, but with a
+	 * few more lines of code, we can retry until we get a big
+	 * enough mmarray[] w/o using GFP_ATOMIC.
+	 */
+	while (1) {
+		ntasks = atomic_read(&cs->count);	/* guess */
+		ntasks += fudge;
+		mmarray = kmalloc(ntasks * sizeof(*mmarray), GFP_KERNEL);
+		if (!mmarray)
+			goto done;
+		write_lock_irq(&tasklist_lock);		/* block fork */
+		if (atomic_read(&cs->count) <= ntasks)
+			break;				/* got enough */
+		kfree(mmarray);
+		write_unlock_irq(&tasklist_lock);	/* try again */
+	}
+
+	n = 0;
+
+	/* Load up mmarray[] with mm reference for each task in cpuset. */
+	do_each_thread(g, p) {
+		struct mm_struct *mm;
+
+		if (p->cpuset != cs)
+			continue;
+		mm = get_task_mm(p);
+		if (!mm)
+			continue;
+		if (n >= ntasks) {
+			if (printk_ratelimit()) {
+				printk (KERN_ERR
+					"Cpuset mempolicy rebind failed.\n");
+				BUG();
+			}
+			mmput(mm);
+			continue;
+		}
+		mmarray[n++] = mm;
+	} while_each_thread(g, p);
+	write_unlock_irq(&tasklist_lock);
+
+	/*
+	 * Now that we've dropped the tasklist spinlock, we can
+	 * rebind the vma mempolicies of each mm in mmarray[] to their
+	 * new cpuset, and release that mm.  The mpol_rebind_mm()
+	 * call takes mmap_sem, which we couldn't take while holding
+	 * tasklist_lock.  Forks can happen again now - the mpol_copy()
+	 * cpuset_being_rebound check will catch such forks, and rebind
+	 * their vma mempolicies too.  Because we still hold the global
+	 * cpuset manage_sem, we know that no other rebind effort will
+	 * be contending for the global variable cpuset_being_rebound.
+	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
+	 * is idempotent.
+	 */
+	for (i = 0; i < n; i++) {
+		struct mm_struct *mm = mmarray[i];
+
+		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mmput(mm);
+	}
+
+	/* We're done rebinding vma's to this cpusets new mems_allowed. */
+	kfree(mmarray);
+	set_cpuset_being_rebound(NULL);
+	retval = 0;
 done:
 	return retval;
 }
@@ -1011,6 +1097,7 @@ static int attach_task(struct cpuset *cs
 	struct cpuset *oldcs;
 	cpumask_t cpus;
 	nodemask_t from, to;
+	struct mm_struct *mm;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -1060,6 +1147,13 @@ static int attach_task(struct cpuset *cs
 	to = cs->mems_allowed;
 
 	up(&callback_sem);
+
+	mm = get_task_mm(tsk);
+	if (mm) {
+		mpol_rebind_mm(mm, &to);
+		mmput(mm);
+	}
+
 	if (is_memory_migrate(cs))
 		do_migrate_pages(tsk->mm, &from, &to, MPOL_MF_MOVE_ALL);
 	put_task_struct(tsk);
--- 2.6.15-rc3-mm1.orig/mm/mempolicy.c	2005-12-09 04:02:42.980847269 -0800
+++ 2.6.15-rc3-mm1/mm/mempolicy.c	2005-12-09 04:02:43.092176676 -0800
@@ -1160,6 +1160,15 @@ struct page *alloc_pages_current(gfp_t g
 }
 EXPORT_SYMBOL(alloc_pages_current);
 
+/*
+ * If mpol_copy() sees current->cpuset == cpuset_being_rebound, then it
+ * rebinds the mempolicy its copying by calling mpol_rebind_policy()
+ * with the mems_allowed returned by cpuset_mems_allowed().  This
+ * keeps mempolicies cpuset relative after its cpuset moves.  See
+ * further kernel/cpuset.c update_nodemask().
+ */
+void *cpuset_being_rebound;
+
 /* Slow path of a mempolicy copy */
 struct mempolicy *__mpol_copy(struct mempolicy *old)
 {
@@ -1167,6 +1176,10 @@ struct mempolicy *__mpol_copy(struct mem
 
 	if (!new)
 		return ERR_PTR(-ENOMEM);
+	if (current_cpuset_is_being_rebound()) {
+		nodemask_t mems = cpuset_mems_allowed(current);
+		mpol_rebind_policy(old, &mems);
+	}
 	*new = *old;
 	atomic_set(&new->refcnt, 1);
 	if (new->policy == MPOL_BIND) {
@@ -1510,6 +1523,22 @@ void mpol_rebind_task(struct task_struct
 }
 
 /*
+ * Rebind each vma in mm to new nodemask.
+ *
+ * Call holding a reference to mm.  Takes mm->mmap_sem during call.
+ */
+
+void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
+{
+	struct vm_area_struct *vma;
+
+	down_write(&mm->mmap_sem);
+	for (vma = mm->mmap; vma; vma = vma->vm_next)
+		mpol_rebind_policy(vma->vm_policy, new);
+	up_write(&mm->mmap_sem);
+}
+
+/*
  * Display pages allocated per node and memory policy via /proc.
  */
 
--- 2.6.15-rc3-mm1.orig/include/linux/mempolicy.h	2005-12-09 04:02:42.925182565 -0800
+++ 2.6.15-rc3-mm1/include/linux/mempolicy.h	2005-12-09 04:02:43.095106397 -0800
@@ -150,6 +150,16 @@ extern void numa_policy_init(void);
 extern void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *new);
 extern void mpol_rebind_task(struct task_struct *tsk,
 					const nodemask_t *new);
+extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
+#define set_cpuset_being_rebound(x) (cpuset_being_rebound = (x))
+
+#ifdef CONFIG_CPUSET
+#define current_cpuset_is_being_rebound() \
+				(cpuset_being_rebound == current->cpuset)
+#else
+#define current_cpuset_is_being_rebound() 0
+#endif
+
 extern struct mempolicy default_policy;
 extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 		unsigned long addr);
@@ -158,6 +168,8 @@ extern unsigned slab_node(struct mempoli
 int do_migrate_pages(struct mm_struct *mm,
 	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags);
 
+extern void *cpuset_being_rebound;	/* Trigger mpol_copy vma rebind */
+
 #else
 
 struct mempolicy {};
@@ -227,6 +239,12 @@ static inline void mpol_rebind_task(stru
 {
 }
 
+static inline void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
+{
+}
+
+#define set_cpuset_being_rebound(x) do {} while (0)
+
 static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 		unsigned long addr)
 {

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
