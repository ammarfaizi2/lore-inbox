Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVC1XlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVC1XlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVC1XlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:41:17 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36347 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262127AbVC1Xht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:37:49 -0500
Date: Tue, 29 Mar 2005 01:37:40 +0200 (MEST)
Message-Id: <200503282337.j2SNbe9h013501@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm3 3/3] perfctr: mapped state cleanup: common
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr common updates for mapped state cleanup:
- Update virtual.c for perfctr_cpu_state layout change.
- Add perfctr sysfs attribute providing user-space with the offset
  in an mmap()ed perfctr object to the user-visible state.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/init.c    |    7 +++++++
 drivers/perfctr/version.h |    2 +-
 drivers/perfctr/virtual.c |   46 +++++++++++++++++++++++-----------------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff -rupN linux-2.6.12-rc1-mm3/drivers/perfctr/init.c linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-common/drivers/perfctr/init.c
--- linux-2.6.12-rc1-mm3/drivers/perfctr/init.c	2005-03-28 17:26:13.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-common/drivers/perfctr/init.c	2005-03-28 23:05:37.000000000 +0200
@@ -42,6 +42,12 @@ tsc_to_cpu_mult_show(struct class *class
 }
 
 static ssize_t
+state_user_offset_show(struct class *class, char *buf)
+{
+	return sprintf(buf, "%u\n", (unsigned int)offsetof(struct perfctr_cpu_state, user));
+}
+
+static ssize_t
 cpus_online_show(struct class *class, char *buf)
 {
 	int ret = cpumask_scnprintf(buf, PAGE_SIZE-1, cpu_online_map);
@@ -62,6 +68,7 @@ static struct class_attribute perfctr_cl
 	__ATTR_RO(cpu_features),
 	__ATTR_RO(cpu_khz),
 	__ATTR_RO(tsc_to_cpu_mult),
+	__ATTR_RO(state_user_offset),
 	__ATTR_RO(cpus_online),
 	__ATTR_RO(cpus_forbidden),
 	__ATTR_NULL
diff -rupN linux-2.6.12-rc1-mm3/drivers/perfctr/version.h linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-common/drivers/perfctr/version.h
--- linux-2.6.12-rc1-mm3/drivers/perfctr/version.h	2005-03-28 17:26:14.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-common/drivers/perfctr/version.h	2005-03-28 23:05:37.000000000 +0200
@@ -1 +1 @@
-#define VERSION "2.7.12"
+#define VERSION "2.7.14"
diff -rupN linux-2.6.12-rc1-mm3/drivers/perfctr/virtual.c linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-common/drivers/perfctr/virtual.c
--- linux-2.6.12-rc1-mm3/drivers/perfctr/virtual.c	2005-03-28 17:26:14.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-common/drivers/perfctr/virtual.c	2005-03-28 23:05:37.000000000 +0200
@@ -54,7 +54,7 @@ struct vperfctr {
 	struct work_struct work;
 	struct task_struct *parent_tsk;
 };
-#define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
+#define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.user.cstatus)
 
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 
@@ -254,9 +254,9 @@ static void vperfctr_ihandler(unsigned l
 		       __FUNCTION__, tsk->pid);
 		return;
 	}
-	if (!perfctr_cstatus_has_ictrs(perfctr->cpu_state.cstatus)) {
+	if (!perfctr_cstatus_has_ictrs(perfctr->cpu_state.user.cstatus)) {
 		printk(KERN_ERR "%s: BUG! vperfctr has cstatus %#x (pid %d, comm %s)\n",
-		       __FUNCTION__, perfctr->cpu_state.cstatus, tsk->pid, tsk->comm);
+		       __FUNCTION__, perfctr->cpu_state.user.cstatus, tsk->pid, tsk->comm);
 		return;
 	}
 	vperfctr_suspend(perfctr);
@@ -279,12 +279,12 @@ static void vperfctr_handle_overflow(str
 	perfctr->ireload_needed = 1;
 	/* suspend a-mode and i-mode PMCs, leaving only TSC on */
 	/* XXX: some people also want to suspend the TSC */
-	perfctr->resume_cstatus = perfctr->cpu_state.cstatus;
+	perfctr->resume_cstatus = perfctr->cpu_state.user.cstatus;
 	if (perfctr_cstatus_has_tsc(perfctr->resume_cstatus)) {
-		perfctr->cpu_state.cstatus = perfctr_mk_cstatus(1, 0, 0);
+		perfctr->cpu_state.user.cstatus = perfctr_mk_cstatus(1, 0, 0);
 		vperfctr_resume(perfctr);
 	} else
-		perfctr->cpu_state.cstatus = 0;
+		perfctr->cpu_state.user.cstatus = 0;
 	si.si_signo = perfctr->si_signo;
 	si.si_errno = 0;
 	si.si_code = SI_PMC_OVF;
@@ -383,7 +383,7 @@ static void vperfctr_unlink(struct task_
 		owner->thread.perfctr = NULL;
 	task_unlock(owner);
 
-	perfctr->cpu_state.cstatus = 0;
+	perfctr->cpu_state.user.cstatus = 0;
 	perfctr->resume_cstatus = 0;
 	if (do_unlink)
 		put_vperfctr(perfctr);
@@ -418,15 +418,15 @@ static void do_vperfctr_release(struct v
 	if (parent_perfctr && child_perfctr) {
 		spin_lock(&parent_perfctr->children_lock);
 		if (parent_perfctr->inheritance_id == child_perfctr->inheritance_id) {
-			cstatus = parent_perfctr->cpu_state.cstatus;
+			cstatus = parent_perfctr->cpu_state.user.cstatus;
 			if (perfctr_cstatus_has_tsc(cstatus))
 				parent_perfctr->children.tsc +=
-					child_perfctr->cpu_state.tsc_sum +
+					child_perfctr->cpu_state.user.tsc_sum +
 					child_perfctr->children.tsc;
 			nrctrs = perfctr_cstatus_nrctrs(cstatus);
 			for(i = 0; i < nrctrs; ++i)
 				parent_perfctr->children.pmc[i] +=
-					child_perfctr->cpu_state.pmc[i].sum +
+					child_perfctr->cpu_state.user.pmc[i].sum +
 					child_perfctr->children.pmc[i];
 		}
 		spin_unlock(&parent_perfctr->children_lock);
@@ -481,8 +481,8 @@ void __vperfctr_resume(struct vperfctr *
 	if (IS_RUNNING(perfctr)) {
 #ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 		if (unlikely(atomic_read(&perfctr->bad_cpus_allowed)) &&
-		    perfctr_cstatus_nrctrs(perfctr->cpu_state.cstatus)) {
-			perfctr->cpu_state.cstatus = 0;
+		    perfctr_cstatus_nrctrs(perfctr->cpu_state.user.cstatus)) {
+			perfctr->cpu_state.user.cstatus = 0;
 			perfctr->resume_cstatus = 0;
 			BUG_ON(current->state != TASK_RUNNING);
 			send_sig(SIGILL, current, 1);
@@ -563,7 +563,7 @@ static int do_vperfctr_write(struct vper
 	if (IS_RUNNING(perfctr)) {
 		if (tsk == current)
 			vperfctr_suspend(perfctr);
-		perfctr->cpu_state.cstatus = 0;
+		perfctr->cpu_state.user.cstatus = 0;
 		perfctr->resume_cstatus = 0;
 	}
 
@@ -627,24 +627,24 @@ static int vperfctr_enable_control(struc
 			set_cpus_allowed(tsk, new_mask);
 	}
 
-	perfctr->cpu_state.cstatus = 0;
+	perfctr->cpu_state.user.cstatus = 0;
 	perfctr->resume_cstatus = 0;
 
 	/* remote access note: perfctr_cpu_update_control() is ok */
 	err = perfctr_cpu_update_control(&perfctr->cpu_state, 0);
 	if (err < 0)
 		return err;
-	next_cstatus = perfctr->cpu_state.cstatus;
+	next_cstatus = perfctr->cpu_state.user.cstatus;
 	if (!perfctr_cstatus_enabled(next_cstatus))
 		return 0;
 
 	if (!perfctr_cstatus_has_tsc(next_cstatus))
-		perfctr->cpu_state.tsc_sum = 0;
+		perfctr->cpu_state.user.tsc_sum = 0;
 
 	nrctrs = perfctr_cstatus_nrctrs(next_cstatus);
 	for(i = 0; i < nrctrs; ++i)
 		if (!(perfctr->preserve & (1<<i)))
-			perfctr->cpu_state.pmc[i].sum = 0;
+			perfctr->cpu_state.user.pmc[i].sum = 0;
 
 	spin_lock(&perfctr->children_lock);
 	perfctr->inheritance_id = new_inheritance_id();
@@ -682,13 +682,13 @@ static int do_vperfctr_resume(struct vpe
 
 	resume_cstatus = perfctr->resume_cstatus;
 	if (perfctr_cstatus_enabled(resume_cstatus)) {
-		perfctr->cpu_state.cstatus = resume_cstatus;
+		perfctr->cpu_state.user.cstatus = resume_cstatus;
 		perfctr->resume_cstatus = 0;
 		vperfctr_ireload(perfctr);
 		ret = 0;
 	} else {
 		ret = vperfctr_enable_control(perfctr, tsk);
-		resume_cstatus = perfctr->cpu_state.cstatus;
+		resume_cstatus = perfctr->cpu_state.user.cstatus;
 	}
 
 	if (ret >= 0 && perfctr_cstatus_enabled(resume_cstatus) && tsk == current)
@@ -711,8 +711,8 @@ static int do_vperfctr_suspend(struct vp
 	if (IS_RUNNING(perfctr)) {
 		if (tsk == current)
 			vperfctr_suspend(perfctr);
-		perfctr->resume_cstatus = perfctr->cpu_state.cstatus;
-		perfctr->cpu_state.cstatus = 0;
+		perfctr->resume_cstatus = perfctr->cpu_state.user.cstatus;
+		perfctr->cpu_state.user.cstatus = 0;
 	}
 
 	preempt_enable();
@@ -806,9 +806,9 @@ static int do_vperfctr_read(struct vperf
 		int j;
 
 		vperfctr_sample(perfctr);
-		tmp->sum.tsc = perfctr->cpu_state.tsc_sum;
+		tmp->sum.tsc = perfctr->cpu_state.user.tsc_sum;
 		for(j = 0; j < ARRAY_SIZE(tmp->sum.pmc); ++j)
-			tmp->sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
+			tmp->sum.pmc[j] = perfctr->cpu_state.user.pmc[j].sum;
 		ret = sizeof(tmp->sum);
 		break;
 	}
