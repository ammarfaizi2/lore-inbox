Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVBTO4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVBTO4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBTO4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:56:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:53685 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261840AbVBTOzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:55:10 -0500
Date: Sun, 20 Feb 2005 15:54:57 +0100 (MET)
Message-Id: <200502201454.j1KEsvUB029447@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-rc3-mm2] perfctr-2.7.10 API update 1/4: common
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This set of patches form the first half of a major perfctr API update.
The goal is to change the upload-new-control-data system call to be
much more generic and independent of struct layouts. To this end the
upload-new-control-data syscall will become
	ret = sys_vperfctr_write(fd, namespace, data, datalen)
where namespace determines how data is to be interpreted. Initially
there will probably be one namespace for perfctr's software state,
and one CPU-specific namespace for pure hardware state; the latter
will probably be expressed generically as a <reg.nr, reg.value> array.

This API change will however require that the write() operation doesn't
imply a (re)start of the context, since usually more than one write will
be needed to upload all control data. Therefore this first set of patches
alter the API so that control data uploads and parameterless state changes
are performed by different system calls. The current control() call becomes
a light-weight write() call, but still using the old control data layout.
A new unified control() call is introduced for state changes, replacing and
extending the current unlink() and iresume() calls.

perfctr-2.7.10 update, 1/4:
- Added new sys_vperfctr_control(), with UNLINK, SUSPEND,
  RESUME, and CLEAR sub-commands. Deleted sys_vperfctr_unlink()
  and sys_vperfctr_iresume(). Changed sys_vperfctr_write()
  to only update control data and not reenable the context.
  RESUME now works both for resuming after overflow interrupts
  and for restarting after changing control data.
- Renamed old sys_vperfctr_control() to sys_vperfctr_write().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/version.h |    2 
 drivers/perfctr/virtual.c |  233 ++++++++++++++++++++++++++++------------------
 include/linux/perfctr.h   |   19 ++-
 kernel/sys_ni.c           |    3 
 4 files changed, 159 insertions(+), 98 deletions(-)

diff -rupN linux-2.6.11-rc3-mm2/drivers/perfctr/version.h linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/drivers/perfctr/version.h
--- linux-2.6.11-rc3-mm2/drivers/perfctr/version.h	2005-02-20 12:39:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/drivers/perfctr/version.h	2005-02-20 13:17:43.000000000 +0100
@@ -1 +1 @@
-#define VERSION "2.7.9"
+#define VERSION "2.7.10"
diff -rupN linux-2.6.11-rc3-mm2/drivers/perfctr/virtual.c linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/drivers/perfctr/virtual.c
--- linux-2.6.11-rc3-mm2/drivers/perfctr/virtual.c	2005-02-20 12:39:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/drivers/perfctr/virtual.c	2005-02-20 13:17:43.000000000 +0100
@@ -1,7 +1,7 @@
-/* $Id: virtual.c,v 1.110 2004/11/24 00:38:30 mikpe Exp $
+/* $Id: virtual.c,v 1.111 2005/02/20 11:56:44 mikpe Exp $
  * Virtual per-process performance counters.
  *
- * Copyright (C) 1999-2004  Mikael Pettersson
+ * Copyright (C) 1999-2005  Mikael Pettersson
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -39,8 +39,10 @@ struct vperfctr {
 #ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 	atomic_t bad_cpus_allowed;
 #endif
+	unsigned int preserve;
+	unsigned int resume_cstatus;
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
-	unsigned int iresume_cstatus;
+	unsigned int ireload_needed; /* only valid if resume_cstatus != 0 */
 #endif
 	/* children_lock protects inheritance_id and children,
 	   when parent is not the one doing release_task() */
@@ -64,14 +66,8 @@ static inline void vperfctr_set_ihandler
 	perfctr_cpu_set_ihandler(vperfctr_ihandler);
 }
 
-static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr)
-{
-	perfctr->iresume_cstatus = 0;
-}
-
 #else
 static inline void vperfctr_set_ihandler(void) { }
-static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr) { }
 #endif
 
 #ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
@@ -280,10 +276,11 @@ static void vperfctr_handle_overflow(str
 		       __FUNCTION__, tsk->pid);
 		return;
 	}
+	perfctr->ireload_needed = 1;
 	/* suspend a-mode and i-mode PMCs, leaving only TSC on */
 	/* XXX: some people also want to suspend the TSC */
-	perfctr->iresume_cstatus = perfctr->cpu_state.cstatus;
-	if (perfctr_cstatus_has_tsc(perfctr->iresume_cstatus)) {
+	perfctr->resume_cstatus = perfctr->cpu_state.cstatus;
+	if (perfctr_cstatus_has_tsc(perfctr->resume_cstatus)) {
 		perfctr->cpu_state.cstatus = perfctr_mk_cstatus(1, 0, 0);
 		vperfctr_resume(perfctr);
 	} else
@@ -387,7 +384,7 @@ static void vperfctr_unlink(struct task_
 	task_unlock(owner);
 
 	perfctr->cpu_state.cstatus = 0;
-	vperfctr_clear_iresume_cstatus(perfctr);
+	perfctr->resume_cstatus = 0;
 	if (do_unlink)
 		put_vperfctr(perfctr);
 }
@@ -486,7 +483,7 @@ void __vperfctr_resume(struct vperfctr *
 		if (unlikely(atomic_read(&perfctr->bad_cpus_allowed)) &&
 		    perfctr_cstatus_nrctrs(perfctr->cpu_state.cstatus)) {
 			perfctr->cpu_state.cstatus = 0;
-			vperfctr_clear_iresume_cstatus(perfctr);
+			perfctr->resume_cstatus = 0;
 			BUG_ON(current->state != TASK_RUNNING);
 			send_sig(SIGILL, current, 1);
 			return;
@@ -539,15 +536,13 @@ void __vperfctr_set_cpus_allowed(struct 
  *								*
  ****************************************************************/
 
-static int do_vperfctr_control(struct vperfctr *perfctr,
-			       const struct vperfctr_control __user *argp,
-			       unsigned int argbytes,
-			       struct task_struct *tsk)
+static int do_vperfctr_write(struct vperfctr *perfctr,
+			     const struct vperfctr_control __user *argp,
+			     unsigned int argbytes,
+			     struct task_struct *tsk)
 {
 	struct vperfctr_control *control;
 	int err;
-	unsigned int next_cstatus;
-	unsigned int nrctrs, i;
 
 	if (!tsk)
 		return -ESRCH;	/* attempt to update unlinked perfctr */
@@ -571,46 +566,63 @@ static int do_vperfctr_control(struct vp
 	if (argbytes < sizeof *control)
 		memset((char*)control + argbytes, 0, sizeof *control - argbytes);
 
-	if (control->cpu_control.nractrs || control->cpu_control.nrictrs) {
+	/* PREEMPT note: preemption is disabled over the entire
+	   region since we're updating an active perfctr. */
+	preempt_disable();
+	if (IS_RUNNING(perfctr)) {
+		if (tsk == current)
+			vperfctr_suspend(perfctr);
+		perfctr->cpu_state.cstatus = 0;
+		perfctr->resume_cstatus = 0;
+	}
+	perfctr->cpu_state.control = control->cpu_control;
+	/* XXX: validate si_signo? */
+	perfctr->si_signo = control->si_signo;
+	perfctr->preserve = control->preserve;
+
+	preempt_enable();
+	err = 0;
+
+ out_kfree:
+	kfree(control);
+	return err;
+}
+
+static int vperfctr_enable_control(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	int err;
+	unsigned int next_cstatus;
+	unsigned int nrctrs, i;
+
+	if (perfctr->cpu_state.control.nractrs || perfctr->cpu_state.control.nrictrs) {
 		cpumask_t old_mask, new_mask;
 
 		old_mask = tsk->cpus_allowed;
 		cpus_andnot(new_mask, old_mask, perfctr_cpus_forbidden_mask);
 
-		err = -EINVAL;
 		if (cpus_empty(new_mask))
-			goto out_kfree;
+			return -EINVAL;
 		if (!cpus_equal(new_mask, old_mask))
 			set_cpus_allowed(tsk, new_mask);
 	}
 
-	/* PREEMPT note: preemption is disabled over the entire
-	   region since we're updating an active perfctr. */
-	preempt_disable();
-	if (IS_RUNNING(perfctr)) {
-		if (tsk == current)
-			vperfctr_suspend(perfctr);
-		perfctr->cpu_state.cstatus = 0;
-		vperfctr_clear_iresume_cstatus(perfctr);
-	}
-	perfctr->cpu_state.control = control->cpu_control;
+	perfctr->cpu_state.cstatus = 0;
+	perfctr->resume_cstatus = 0;
+
 	/* remote access note: perfctr_cpu_update_control() is ok */
 	err = perfctr_cpu_update_control(&perfctr->cpu_state, 0);
 	if (err < 0)
-		goto out;
+		return err;
 	next_cstatus = perfctr->cpu_state.cstatus;
 	if (!perfctr_cstatus_enabled(next_cstatus))
-		goto out;
-
-	/* XXX: validate si_signo? */
-	perfctr->si_signo = control->si_signo;
+		return 0;
 
 	if (!perfctr_cstatus_has_tsc(next_cstatus))
 		perfctr->cpu_state.tsc_sum = 0;
 
 	nrctrs = perfctr_cstatus_nrctrs(next_cstatus);
 	for(i = 0; i < nrctrs; ++i)
-		if (!(control->preserve & (1<<i)))
+		if (!(perfctr->preserve & (1<<i)))
 			perfctr->cpu_state.pmc[i].sum = 0;
 
 	spin_lock(&perfctr->children_lock);
@@ -618,28 +630,28 @@ static int do_vperfctr_control(struct vp
 	memset(&perfctr->children, 0, sizeof perfctr->children);
 	spin_unlock(&perfctr->children_lock);
 
-	if (tsk == current)
-		vperfctr_resume(perfctr);
-
- out:
-	preempt_enable();
- out_kfree:
-	kfree(control);
-	return err;
+	return 0;
 }
 
-static int do_vperfctr_iresume(struct vperfctr *perfctr, const struct task_struct *tsk)
+static inline void vperfctr_ireload(struct vperfctr *perfctr)
 {
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
-	unsigned int iresume_cstatus;
+	if (perfctr->ireload_needed) {
+		perfctr->ireload_needed = 0;
+		/* remote access note: perfctr_cpu_ireload() is ok */
+		perfctr_cpu_ireload(&perfctr->cpu_state);
+	}
+#endif
+}
+
+static int do_vperfctr_resume(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	unsigned int resume_cstatus;
+	int ret;
 
 	if (!tsk)
 		return -ESRCH;	/* attempt to update unlinked perfctr */
 
-	iresume_cstatus = perfctr->iresume_cstatus;
-	if (!perfctr_cstatus_has_ictrs(iresume_cstatus))
-		return -EPERM;
-
 	/* PREEMPT note: preemption is disabled over the entire
 	   region because we're updating an active perfctr. */
 	preempt_disable();
@@ -647,21 +659,44 @@ static int do_vperfctr_iresume(struct vp
 	if (IS_RUNNING(perfctr) && tsk == current)
 		vperfctr_suspend(perfctr);
 
-	perfctr->cpu_state.cstatus = iresume_cstatus;
-	perfctr->iresume_cstatus = 0;
-
-	/* remote access note: perfctr_cpu_ireload() is ok */
-	perfctr_cpu_ireload(&perfctr->cpu_state);
+	resume_cstatus = perfctr->resume_cstatus;
+	if (perfctr_cstatus_enabled(resume_cstatus)) {
+		perfctr->cpu_state.cstatus = resume_cstatus;
+		perfctr->resume_cstatus = 0;
+		vperfctr_ireload(perfctr);
+		ret = 0;
+	} else {
+		ret = vperfctr_enable_control(perfctr, tsk);
+		resume_cstatus = perfctr->cpu_state.cstatus;
+	}
 
-	if (tsk == current)
+	if (ret >= 0 && perfctr_cstatus_enabled(resume_cstatus) && tsk == current)
 		vperfctr_resume(perfctr);
 
 	preempt_enable();
 
+	return ret;
+}
+
+static int do_vperfctr_suspend(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	if (!tsk)
+		return -ESRCH;	/* attempt to update unlinked perfctr */
+
+	/* PREEMPT note: preemption is disabled over the entire
+	   region since we're updating an active perfctr. */
+	preempt_disable();
+
+	if (IS_RUNNING(perfctr)) {
+		if (tsk == current)
+			vperfctr_suspend(perfctr);
+		perfctr->resume_cstatus = perfctr->cpu_state.cstatus;
+		perfctr->cpu_state.cstatus = 0;
+	}
+
+	preempt_enable();
+
 	return 0;
-#else
-	return -ENOSYS;
-#endif
 }
 
 static int do_vperfctr_unlink(struct vperfctr *perfctr, struct task_struct *tsk)
@@ -671,6 +706,49 @@ static int do_vperfctr_unlink(struct vpe
 	return 0;
 }
 
+static int do_vperfctr_clear(struct vperfctr *perfctr, struct task_struct *tsk)
+{
+	if (!tsk)
+		return -ESRCH;	/* attempt to update unlinked perfctr */
+
+	/* PREEMPT note: preemption is disabled over the entire
+	   region because we're updating an active perfctr. */
+	preempt_disable();
+
+	if (IS_RUNNING(perfctr) && tsk == current)
+		vperfctr_suspend(perfctr);
+
+	memset(&perfctr->cpu_state, 0, sizeof perfctr->cpu_state);
+	perfctr->resume_cstatus = 0;
+
+	spin_lock(&perfctr->children_lock);
+	perfctr->inheritance_id = 0;
+	memset(&perfctr->children, 0, sizeof perfctr->children);
+	spin_unlock(&perfctr->children_lock);
+
+	preempt_enable();
+
+	return 0;
+}
+
+static int do_vperfctr_control(struct vperfctr *perfctr,
+			       unsigned int cmd,
+			       struct task_struct *tsk)
+{
+	switch (cmd) {
+	case VPERFCTR_CONTROL_UNLINK:
+		return do_vperfctr_unlink(perfctr, tsk);
+	case VPERFCTR_CONTROL_SUSPEND:
+		return do_vperfctr_suspend(perfctr, tsk);
+	case VPERFCTR_CONTROL_RESUME:
+		return do_vperfctr_resume(perfctr, tsk);
+	case VPERFCTR_CONTROL_CLEAR:
+		return do_vperfctr_clear(perfctr, tsk);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int do_vperfctr_read(struct vperfctr *perfctr,
 			    unsigned int cmd,
 			    void __user *argp,
@@ -1051,30 +1129,9 @@ static void vperfctr_put_tsk(struct task
 		put_task_struct(tsk);
 }
 
-asmlinkage long sys_vperfctr_control(int fd,
-				     const struct vperfctr_control __user *argp,
-				     unsigned int argbytes)
-{
-	struct vperfctr *perfctr;
-	struct task_struct *tsk;
-	int ret;
-
-	perfctr = fd_get_vperfctr(fd);
-	if (IS_ERR(perfctr))
-		return PTR_ERR(perfctr);
-	tsk = vperfctr_get_tsk(perfctr);
-	if (IS_ERR(tsk)) {
-		ret = PTR_ERR(tsk);
-		goto out;
-	}
-	ret = do_vperfctr_control(perfctr, argp, argbytes, tsk);
-	vperfctr_put_tsk(tsk);
- out:
-	put_vperfctr(perfctr);
-	return ret;
-}
-
-asmlinkage long sys_vperfctr_unlink(int fd)
+asmlinkage long sys_vperfctr_write(int fd,
+				   const struct vperfctr_control __user *argp,
+				   unsigned int argbytes)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -1088,14 +1145,14 @@ asmlinkage long sys_vperfctr_unlink(int 
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_unlink(perfctr, tsk);
+	ret = do_vperfctr_write(perfctr, argp, argbytes, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
 	return ret;
 }
 
-asmlinkage long sys_vperfctr_iresume(int fd)
+asmlinkage long sys_vperfctr_control(int fd, unsigned int cmd)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -1109,7 +1166,7 @@ asmlinkage long sys_vperfctr_iresume(int
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_iresume(perfctr, tsk);
+	ret = do_vperfctr_control(perfctr, cmd, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
diff -rupN linux-2.6.11-rc3-mm2/include/linux/perfctr.h linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/include/linux/perfctr.h
--- linux-2.6.11-rc3-mm2/include/linux/perfctr.h	2005-02-20 12:39:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/include/linux/perfctr.h	2005-02-20 13:17:43.000000000 +0100
@@ -1,7 +1,7 @@
-/* $Id: perfctr.h,v 1.85 2004/11/24 00:38:21 mikpe Exp $
+/* $Id: perfctr.h,v 1.88 2005/02/20 12:03:08 mikpe Exp $
  * Performance-Monitoring Counters driver
  *
- * Copyright (C) 1999-2004  Mikael Pettersson
+ * Copyright (C) 1999-2005  Mikael Pettersson
  */
 #ifndef _LINUX_PERFCTR_H
 #define _LINUX_PERFCTR_H
@@ -54,6 +54,12 @@ struct vperfctr_control {
 	struct perfctr_cpu_control cpu_control;
 };
 
+/* commands for sys_vperfctr_control() */
+#define VPERFCTR_CONTROL_UNLINK		0x01
+#define VPERFCTR_CONTROL_SUSPEND	0x02
+#define VPERFCTR_CONTROL_RESUME		0x03
+#define VPERFCTR_CONTROL_CLEAR		0x04
+
 /* commands for sys_vperfctr_read() */
 #define VPERFCTR_READ_SUM	0x01
 #define VPERFCTR_READ_CONTROL	0x02
@@ -72,11 +78,10 @@ struct vperfctr_control;
  * The perfctr system calls.
  */
 asmlinkage long sys_vperfctr_open(int tid, int creat);
-asmlinkage long sys_vperfctr_control(int fd,
-				     const struct vperfctr_control __user *argp,
-				     unsigned int argbytes);
-asmlinkage long sys_vperfctr_unlink(int fd);
-asmlinkage long sys_vperfctr_iresume(int fd);
+asmlinkage long sys_vperfctr_control(int fd, unsigned int cmd);
+asmlinkage long sys_vperfctr_write(int fd,
+				   const struct vperfctr_control __user *argp,
+				   unsigned int argbytes);
 asmlinkage long sys_vperfctr_read(int fd, unsigned int cmd, void __user *argp, unsigned int argbytes);
 
 extern struct perfctr_info perfctr_info;
diff -rupN linux-2.6.11-rc3-mm2/kernel/sys_ni.c linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/kernel/sys_ni.c
--- linux-2.6.11-rc3-mm2/kernel/sys_ni.c	2005-02-20 12:39:30.000000000 +0100
+++ linux-2.6.11-rc3-mm2.perfctr-2.7.10-common-update/kernel/sys_ni.c	2005-02-20 13:17:43.000000000 +0100
@@ -69,8 +69,7 @@ cond_syscall(compat_sys_mq_notify)
 cond_syscall(compat_sys_mq_getsetattr)
 cond_syscall(sys_vperfctr_open)
 cond_syscall(sys_vperfctr_control)
-cond_syscall(sys_vperfctr_unlink)
-cond_syscall(sys_vperfctr_iresume)
+cond_syscall(sys_vperfctr_write)
 cond_syscall(sys_vperfctr_read)
 cond_syscall(sys_mbind)
 cond_syscall(sys_get_mempolicy)
