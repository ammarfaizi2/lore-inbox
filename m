Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUF3M03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUF3M03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUF3MYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:24:20 -0400
Received: from aun.it.uu.se ([130.238.12.36]:417 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266656AbUF3MV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:21:59 -0400
Date: Wed, 30 Jun 2004 14:21:52 +0200 (MEST)
Message-Id: <200406301221.i5UCLq2X014232@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update 5/6: reduce stack usage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Reduce stack usage by using kmalloc() instead of the stack
  for temporary state and control copies.
- Eliminate some unnecessary cpumask_t copies. Use newish
  cpus_intersects() instead of cpus_and(); !cpus_empty().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm4/drivers/perfctr/init.c.~1~	2004-06-29 19:01:56.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/init.c	2004-06-30 01:14:20.000000000 +0200
@@ -54,14 +54,12 @@
 	if (infop && copy_to_user(infop, &perfctr_info, sizeof perfctr_info))
 		return -EFAULT;
 	if (cpusp) {
-		cpumask_t cpus = cpu_online_map;
-		int err = cpus_copy_to_user(cpusp, &cpus);
+		int err = cpus_copy_to_user(cpusp, &cpu_online_map);
 		if (err)
 			return err;
 	}
 	if (forbiddenp) {
-		cpumask_t cpus = perfctr_cpus_forbidden_mask;
-		int err = cpus_copy_to_user(forbiddenp, &cpus);
+		int err = cpus_copy_to_user(forbiddenp, &perfctr_cpus_forbidden_mask);
 		if (err)
 			return err;
 	}
--- linux-2.6.7-mm4/drivers/perfctr/virtual.c.~1~	2004-06-29 19:11:30.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/virtual.c	2004-06-30 02:29:12.000000000 +0200
@@ -364,10 +364,7 @@
 				 struct vperfctr *perfctr,
 				 cpumask_t new_mask)
 {
-	cpumask_t tmp;
-
-	cpus_and(tmp, new_mask, perfctr_cpus_forbidden_mask);
-	if (!cpus_empty(tmp)) {
+	if (cpus_intersects(new_mask, perfctr_cpus_forbidden_mask)) {
 		atomic_set(&perfctr->bad_cpus_allowed, 1);
 		printk(KERN_WARNING "perfctr: process %d (comm %s) issued unsafe"
 		       " set_cpus_allowed() on process %d (comm %s)\n",
@@ -391,7 +388,7 @@
 			       const struct vperfctr_control __user *argp,
 			       struct task_struct *tsk)
 {
-	struct vperfctr_control control;
+	struct vperfctr_control *control;
 	int err;
 	unsigned int next_cstatus;
 	unsigned int nrctrs, i;
@@ -399,18 +396,29 @@
 	if (!tsk)
 		return -ESRCH;	/* attempt to update unlinked perfctr */
 
-	if (copy_from_user(&control, argp, sizeof control))
-		return -EFAULT;
+	/* The control object can be large (over 300 bytes on i386),
+	   so kmalloc() it instead of storing it on the stack.
+	   We must use task-private storage to prevent racing with a
+	   monitor process attaching to us before the non-preemptible
+	   perfctr update step. Therefore we cannot store the copy
+	   in the perfctr object itself. */
+	control = kmalloc(sizeof(*control), GFP_USER);
+	if (!control)
+		return -ENOMEM;
+
+	err = -EFAULT;
+	if (copy_from_user(control, argp, sizeof *control))
+		goto out_kfree;
 
-	if (control.cpu_control.nractrs || control.cpu_control.nrictrs) {
-		cpumask_t tmp, old_mask, new_mask;
+	if (control->cpu_control.nractrs || control->cpu_control.nrictrs) {
+		cpumask_t old_mask, new_mask;
 
-		tmp = perfctr_cpus_forbidden_mask;
 		old_mask = tsk->cpus_allowed;
-		cpus_andnot(new_mask, old_mask, tmp);
+		cpus_andnot(new_mask, old_mask, perfctr_cpus_forbidden_mask);
 
+		err = -EINVAL;
 		if (cpus_empty(new_mask))
-			return -EINVAL;
+			goto out_kfree;
 		if (!cpus_equal(new_mask, old_mask))
 			set_cpus_allowed(tsk, new_mask);
 	}
@@ -424,7 +432,7 @@
 		perfctr->cpu_state.cstatus = 0;
 		vperfctr_clear_iresume_cstatus(perfctr);
 	}
-	perfctr->cpu_state.control = control.cpu_control;
+	perfctr->cpu_state.control = control->cpu_control;
 	/* remote access note: perfctr_cpu_update_control() is ok */
 	err = perfctr_cpu_update_control(&perfctr->cpu_state, 0);
 	if (err < 0)
@@ -434,14 +442,14 @@
 		goto out;
 
 	/* XXX: validate si_signo? */
-	perfctr->si_signo = control.si_signo;
+	perfctr->si_signo = control->si_signo;
 
 	if (!perfctr_cstatus_has_tsc(next_cstatus))
 		perfctr->cpu_state.tsc_sum = 0;
 
 	nrctrs = perfctr_cstatus_nrctrs(next_cstatus);
 	for(i = 0; i < nrctrs; ++i)
-		if (!(control.preserve & (1<<i)))
+		if (!(control->preserve & (1<<i)))
 			perfctr->cpu_state.pmc[i].sum = 0;
 
 	if (tsk == current)
@@ -449,6 +457,8 @@
 
  out:
 	preempt_enable();
+ out_kfree:
+	kfree(control);
 	return err;
 }
 
@@ -500,8 +510,21 @@
 			    struct vperfctr_control __user *controlp,
 			    const struct task_struct *tsk)
 {
-	struct perfctr_sum_ctrs sum;
-	struct vperfctr_control control;
+	struct {
+		struct perfctr_sum_ctrs sum;
+		struct vperfctr_control control;
+	} *tmp;
+	int ret;
+
+	/* The state snapshot can be large (almost 500 bytes on i386),
+	   so kmalloc() it instead of storing it on the stack.
+	   We must use task-private storage to prevent racing with a
+	   monitor process attaching to us during the preemptible
+	   copy_to_user() step. Therefore we cannot store the snapshot
+	   in the perfctr object itself. */
+	tmp = kmalloc(sizeof(*tmp), GFP_USER);
+	if (!tmp)
+		return -ENOMEM;
 
 	/* PREEMPT note: While we're reading our own control, another
 	   process may ptrace ATTACH to us and update our control.
@@ -515,22 +538,26 @@
 	}
 	if (sump) { //sum = perfctr->cpu_state.sum;
 		int j;
-		sum.tsc = perfctr->cpu_state.tsc_sum;
-		for(j = 0; j < ARRAY_SIZE(sum.pmc); ++j)
-			sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
+		tmp->sum.tsc = perfctr->cpu_state.tsc_sum;
+		for(j = 0; j < ARRAY_SIZE(tmp->sum.pmc); ++j)
+			tmp->sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
 	}
 	if (controlp) {
-		control.si_signo = perfctr->si_signo;
-		control.cpu_control = perfctr->cpu_state.control;
-		control.preserve = 0;
+		tmp->control.si_signo = perfctr->si_signo;
+		tmp->control.cpu_control = perfctr->cpu_state.control;
+		tmp->control.preserve = 0;
 	}
 	if (tsk == current)
 		preempt_enable();
-	if (sump && copy_to_user(sump, &sum, sizeof sum))
-		return -EFAULT;
-	if (controlp && copy_to_user(controlp, &control, sizeof control))
-		return -EFAULT;
-	return 0;
+	ret = -EFAULT;
+	if (sump && copy_to_user(sump, &tmp->sum, sizeof tmp->sum))
+		goto out;
+	if (controlp && copy_to_user(controlp, &tmp->control, sizeof tmp->control))
+		goto out;
+	ret = 0;
+ out:
+	kfree(tmp);
+	return ret;
 }
 
 /****************************************************************
