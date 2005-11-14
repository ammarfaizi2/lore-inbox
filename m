Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVKNVfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVKNVfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVKNVfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:35:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:14020 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932158AbVKNVdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:33:20 -0500
Message-Id: <20051114212530.486945000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:53 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 12/13] Change pid accesses: ia64 and mips
Content-Disposition: inline; filename=BB-ia64-and-mips
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: ia64 and mips
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for ia64 and mips architectures.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 arch/ia64/ia32/ia32_signal.c            |    4 
 arch/ia64/ia32/sys_ia32.c               |    6 -
 arch/ia64/kernel/mca.c                  |    4 
 arch/ia64/kernel/mca_drv.c              |    2 
 arch/ia64/kernel/perfmon.c              |  158 ++++++++++++++++----------------
 arch/ia64/kernel/perfmon_default_smpl.c |   16 +--
 arch/ia64/kernel/process.c              |    2 
 arch/ia64/kernel/signal.c               |    8 -
 arch/ia64/kernel/traps.c                |    6 -
 arch/ia64/kernel/unaligned.c            |    2 
 arch/ia64/mm/fault.c                    |    2 
 arch/ia64/sn/kernel/xpc_main.c          |    2 
 arch/mips/kernel/irixelf.c              |    8 -
 arch/mips/kernel/irixioctl.c            |    4 
 arch/mips/kernel/irixsig.c              |   20 ++--
 arch/mips/kernel/process.c              |    2 
 arch/mips/kernel/signal.c               |    4 
 arch/mips/kernel/signal32.c             |    4 
 arch/mips/kernel/signal_n32.c           |    2 
 arch/mips/kernel/sysirix.c              |  136 +++++++++++++--------------
 arch/mips/kernel/time.c                 |    2 
 arch/mips/kernel/traps.c                |    2 
 arch/mips/mm/fault.c                    |    4 
 23 files changed, 200 insertions(+), 200 deletions(-)

Index: linux-2.6.15-rc1/arch/ia64/ia32/ia32_signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/ia32/ia32_signal.c
+++ linux-2.6.15-rc1/arch/ia64/ia32/ia32_signal.c
@@ -868,7 +868,7 @@ setup_frame_ia32 (int sig, struct k_siga
 
 #if 0
 	printk("SIG deliver (%s:%d): sig=%d sp=%p pc=%lx ra=%x\n",
-               current->comm, current->pid, sig, (void *) frame, regs->cr_iip, frame->pretcode);
+               current->comm, task_pid(current), sig, (void *) frame, regs->cr_iip, frame->pretcode);
 #endif
 
 	return 1;
@@ -946,7 +946,7 @@ setup_rt_frame_ia32 (int sig, struct k_s
 
 #if 0
 	printk("SIG deliver (%s:%d): sp=%p pc=%lx ra=%x\n",
-               current->comm, current->pid, (void *) frame, regs->cr_iip, frame->pretcode);
+               current->comm, task_pid(current), (void *) frame, regs->cr_iip, frame->pretcode);
 #endif
 
 	return 1;
Index: linux-2.6.15-rc1/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/ia32/sys_ia32.c
+++ linux-2.6.15-rc1/arch/ia64/ia32/sys_ia32.c
@@ -769,7 +769,7 @@ emulate_mmap (struct file *file, unsigne
 			if (flags & MAP_SHARED)
 				printk(KERN_INFO
 				       "%s(%d): emulate_mmap() can't share head (addr=0x%lx)\n",
-				       current->comm, current->pid, start);
+				       current->comm, task_pid(current), start);
 			ret = mmap_subpage(file, start, min(PAGE_ALIGN(start), end), prot, flags,
 					   off);
 			if (IS_ERR((void *) ret))
@@ -782,7 +782,7 @@ emulate_mmap (struct file *file, unsigne
 			if (flags & MAP_SHARED)
 				printk(KERN_INFO
 				       "%s(%d): emulate_mmap() can't share tail (end=0x%lx)\n",
-				       current->comm, current->pid, end);
+				       current->comm, task_pid(current), end);
 			ret = mmap_subpage(file, max(start, PAGE_START(end)), end, prot, flags,
 					   (off + len) - offset_in_page(end));
 			if (IS_ERR((void *) ret))
@@ -812,7 +812,7 @@ emulate_mmap (struct file *file, unsigne
 
 	if ((flags & MAP_SHARED) && !is_congruent)
 		printk(KERN_INFO "%s(%d): emulate_mmap() can't share contents of incongruent mmap "
-		       "(addr=0x%lx,off=0x%llx)\n", current->comm, current->pid, start, off);
+		       "(addr=0x%lx,off=0x%llx)\n", current->comm, task_pid(current), start, off);
 
 	DBG("mmap_body: mapping [0x%lx-0x%lx) %s with poff 0x%llx\n", pstart, pend,
 	    is_congruent ? "congruent" : "not congruent", poff);
Index: linux-2.6.15-rc1/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/mca.c
@@ -755,9 +755,9 @@ ia64_mca_modify_original_stack(struct pt
 	 * (swapper or nested MCA/INIT) then use the start of the previous comm
 	 * field suffixed with its cpu.
 	 */
-	if (previous_current->pid)
+	if (previous_task_pid(current))
 		snprintf(comm, sizeof(comm), "%s %d",
-			current->comm, previous_current->pid);
+			current->comm, previous_task_pid(current));
 	else {
 		int l;
 		if ((p = strchr(previous_current->comm, ' ')))
Index: linux-2.6.15-rc1/arch/ia64/kernel/mca_drv.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/mca_drv.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/mca_drv.c
@@ -124,7 +124,7 @@ void
 mca_handler_bh(unsigned long paddr)
 {
 	printk(KERN_DEBUG "OS_MCA: process [pid: %d](%s) encounters MCA.\n",
-		current->pid, current->comm);
+		task_pid(current), current->comm);
 
 	spin_lock(&mca_bh_lock);
 	switch (mca_page_isolate(paddr)) {
Index: linux-2.6.15-rc1/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/perfmon.c
@@ -154,14 +154,14 @@
  */
 #define PROTECT_CTX(c, f) \
 	do {  \
-		DPRINT(("spinlock_irq_save ctx %p by [%d]\n", c, current->pid)); \
+		DPRINT(("spinlock_irq_save ctx %p by [%d]\n", c, task_pid(current))); \
 		spin_lock_irqsave(&(c)->ctx_lock, f); \
-		DPRINT(("spinlocked ctx %p  by [%d]\n", c, current->pid)); \
+		DPRINT(("spinlocked ctx %p  by [%d]\n", c, task_pid(current))); \
 	} while(0)
 
 #define UNPROTECT_CTX(c, f) \
 	do { \
-		DPRINT(("spinlock_irq_restore ctx %p by [%d]\n", c, current->pid)); \
+		DPRINT(("spinlock_irq_restore ctx %p by [%d]\n", c, task_pid(current))); \
 		spin_unlock_irqrestore(&(c)->ctx_lock, f); \
 	} while(0)
 
@@ -223,12 +223,12 @@
 #ifdef PFM_DEBUGGING
 #define DPRINT(a) \
 	do { \
-		if (unlikely(pfm_sysctl.debug >0)) { printk("%s.%d: CPU%d [%d] ", __FUNCTION__, __LINE__, smp_processor_id(), current->pid); printk a; } \
+		if (unlikely(pfm_sysctl.debug >0)) { printk("%s.%d: CPU%d [%d] ", __FUNCTION__, __LINE__, smp_processor_id(), task_pid(current)); printk a; } \
 	} while (0)
 
 #define DPRINT_ovfl(a) \
 	do { \
-		if (unlikely(pfm_sysctl.debug > 0 && pfm_sysctl.debug_ovfl >0)) { printk("%s.%d: CPU%d [%d] ", __FUNCTION__, __LINE__, smp_processor_id(), current->pid); printk a; } \
+		if (unlikely(pfm_sysctl.debug > 0 && pfm_sysctl.debug_ovfl >0)) { printk("%s.%d: CPU%d [%d] ", __FUNCTION__, __LINE__, smp_processor_id(), task_pid(current)); printk a; } \
 	} while (0)
 #endif
 
@@ -868,7 +868,7 @@ pfm_mask_monitoring(struct task_struct *
 	unsigned long mask, val, ovfl_mask;
 	int i;
 
-	DPRINT_ovfl(("masking monitoring for [%d]\n", task->pid));
+	DPRINT_ovfl(("masking monitoring for [%d]\n", task_pid(task)));
 
 	ovfl_mask = pmu_conf->ovfl_val;
 	/*
@@ -948,12 +948,12 @@ pfm_restore_monitoring(struct task_struc
 	ovfl_mask = pmu_conf->ovfl_val;
 
 	if (task != current) {
-		printk(KERN_ERR "perfmon.%d: invalid task[%d] current[%d]\n", __LINE__, task->pid, current->pid);
+		printk(KERN_ERR "perfmon.%d: invalid task[%d] current[%d]\n", __LINE__, task_pid(task), task_pid(current));
 		return;
 	}
 	if (ctx->ctx_state != PFM_CTX_MASKED) {
 		printk(KERN_ERR "perfmon.%d: task[%d] current[%d] invalid state=%d\n", __LINE__,
-			task->pid, current->pid, ctx->ctx_state);
+			task_pid(task), task_pid(current), ctx->ctx_state);
 		return;
 	}
 	psr = pfm_get_psr();
@@ -1007,7 +1007,7 @@ pfm_restore_monitoring(struct task_struc
 		if ((mask & 0x1) == 0UL) continue;
 		th->pmcs[i] = ctx->ctx_pmcs[i];
 		ia64_set_pmc(i, th->pmcs[i]);
-		DPRINT(("[%d] pmc[%d]=0x%lx\n", task->pid, i, th->pmcs[i]));
+		DPRINT(("[%d] pmc[%d]=0x%lx\n", task_pid(task), i, th->pmcs[i]));
 	}
 	ia64_srlz_d();
 
@@ -1400,7 +1400,7 @@ pfm_remove_smpl_mapping(struct task_stru
 
 	/* sanity checks */
 	if (task->mm == NULL || size == 0UL || vaddr == NULL) {
-		printk(KERN_ERR "perfmon: pfm_remove_smpl_mapping [%d] invalid context mm=%p\n", task->pid, task->mm);
+		printk(KERN_ERR "perfmon: pfm_remove_smpl_mapping [%d] invalid context mm=%p\n", task_pid(task), task->mm);
 		return -EINVAL;
 	}
 
@@ -1417,7 +1417,7 @@ pfm_remove_smpl_mapping(struct task_stru
 
 	up_write(&task->mm->mmap_sem);
 	if (r !=0) {
-		printk(KERN_ERR "perfmon: [%d] unable to unmap sampling buffer @%p size=%lu\n", task->pid, vaddr, size);
+		printk(KERN_ERR "perfmon: [%d] unable to unmap sampling buffer @%p size=%lu\n", task_pid(task), vaddr, size);
 	}
 
 	DPRINT(("do_unmap(%p, %lu)=%d\n", vaddr, size, r));
@@ -1459,7 +1459,7 @@ pfm_free_smpl_buffer(pfm_context_t *ctx)
 	return 0;
 
 invalid_free:
-	printk(KERN_ERR "perfmon: pfm_free_smpl_buffer [%d] no buffer\n", current->pid);
+	printk(KERN_ERR "perfmon: pfm_free_smpl_buffer [%d] no buffer\n", task_pid(current));
 	return -EINVAL;
 }
 #endif
@@ -1512,13 +1512,13 @@ pfm_read(struct file *filp, char __user 
 	unsigned long flags;
   	DECLARE_WAITQUEUE(wait, current);
 	if (PFM_IS_FILE(filp) == 0) {
-		printk(KERN_ERR "perfmon: pfm_poll: bad magic [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_poll: bad magic [%d]\n", task_pid(current));
 		return -EINVAL;
 	}
 
 	ctx = (pfm_context_t *)filp->private_data;
 	if (ctx == NULL) {
-		printk(KERN_ERR "perfmon: pfm_read: NULL ctx [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_read: NULL ctx [%d]\n", task_pid(current));
 		return -EINVAL;
 	}
 
@@ -1572,7 +1572,7 @@ pfm_read(struct file *filp, char __user 
 
 		PROTECT_CTX(ctx, flags);
 	}
-	DPRINT(("[%d] back to running ret=%ld\n", current->pid, ret));
+	DPRINT(("[%d] back to running ret=%ld\n", task_pid(current), ret));
   	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&ctx->ctx_msgq_wait, &wait);
 
@@ -1581,7 +1581,7 @@ pfm_read(struct file *filp, char __user 
 	ret = -EINVAL;
 	msg = pfm_get_next_msg(ctx);
 	if (msg == NULL) {
-		printk(KERN_ERR "perfmon: pfm_read no msg for ctx=%p [%d]\n", ctx, current->pid);
+		printk(KERN_ERR "perfmon: pfm_read no msg for ctx=%p [%d]\n", ctx, task_pid(current));
 		goto abort_locked;
 	}
 
@@ -1612,13 +1612,13 @@ pfm_poll(struct file *filp, poll_table *
 	unsigned int mask = 0;
 
 	if (PFM_IS_FILE(filp) == 0) {
-		printk(KERN_ERR "perfmon: pfm_poll: bad magic [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_poll: bad magic [%d]\n", task_pid(current));
 		return 0;
 	}
 
 	ctx = (pfm_context_t *)filp->private_data;
 	if (ctx == NULL) {
-		printk(KERN_ERR "perfmon: pfm_poll: NULL ctx [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_poll: NULL ctx [%d]\n", task_pid(current));
 		return 0;
 	}
 
@@ -1657,7 +1657,7 @@ pfm_do_fasync(int fd, struct file *filp,
 	ret = fasync_helper (fd, filp, on, &ctx->ctx_async_queue);
 
 	DPRINT(("pfm_fasync called by [%d] on ctx_fd=%d on=%d async_queue=%p ret=%d\n",
-		current->pid,
+		task_pid(current),
 		fd,
 		on,
 		ctx->ctx_async_queue, ret));
@@ -1672,13 +1672,13 @@ pfm_fasync(int fd, struct file *filp, in
 	int ret;
 
 	if (PFM_IS_FILE(filp) == 0) {
-		printk(KERN_ERR "perfmon: pfm_fasync bad magic [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_fasync bad magic [%d]\n", task_pid(current));
 		return -EBADF;
 	}
 
 	ctx = (pfm_context_t *)filp->private_data;
 	if (ctx == NULL) {
-		printk(KERN_ERR "perfmon: pfm_fasync NULL ctx [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_fasync NULL ctx [%d]\n", task_pid(current));
 		return -EBADF;
 	}
 	/*
@@ -1724,7 +1724,7 @@ pfm_syswide_force_stop(void *info)
 	if (owner != ctx->ctx_task) {
 		printk(KERN_ERR "perfmon: pfm_syswide_force_stop CPU%d unexpected owner [%d] instead of [%d]\n",
 			smp_processor_id(),
-			owner->pid, ctx->ctx_task->pid);
+			owner->pid, ctx->ctx_task_pid(task));
 		return;
 	}
 	if (GET_PMU_CTX() != ctx) {
@@ -1734,7 +1734,7 @@ pfm_syswide_force_stop(void *info)
 		return;
 	}
 
-	DPRINT(("on CPU%d forcing system wide stop for [%d]\n", smp_processor_id(), ctx->ctx_task->pid));	
+	DPRINT(("on CPU%d forcing system wide stop for [%d]\n", smp_processor_id(), ctx->ctx_task_pid(task)));
 	/*
 	 * the context is already protected in pfm_close(), we simply
 	 * need to mask interrupts to avoid a PMU interrupt race on
@@ -1786,7 +1786,7 @@ pfm_flush(struct file *filp)
 
 	ctx = (pfm_context_t *)filp->private_data;
 	if (ctx == NULL) {
-		printk(KERN_ERR "perfmon: pfm_flush: NULL ctx [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_flush: NULL ctx [%d]\n", task_pid(current));
 		return -EBADF;
 	}
 
@@ -1934,7 +1934,7 @@ pfm_close(struct inode *inode, struct fi
 	
 	ctx = (pfm_context_t *)filp->private_data;
 	if (ctx == NULL) {
-		printk(KERN_ERR "perfmon: pfm_close: NULL ctx [%d]\n", current->pid);
+		printk(KERN_ERR "perfmon: pfm_close: NULL ctx [%d]\n", task_pid(current));
 		return -EBADF;
 	}
 
@@ -2031,7 +2031,7 @@ pfm_close(struct inode *inode, struct fi
 	 	 */
 		ctx->ctx_state = PFM_CTX_ZOMBIE;
 
-		DPRINT(("zombie ctx for [%d]\n", task->pid));
+		DPRINT(("zombie ctx for [%d]\n", task_pid(task)));
 		/*
 		 * cannot free the context on the spot. deferred until
 		 * the task notices the ZOMBIE state
@@ -2435,7 +2435,7 @@ pfm_setup_buffer_fmt(struct task_struct 
 	/* invoke and lock buffer format, if found */
 	fmt = pfm_find_buffer_fmt(arg->ctx_smpl_buf_id);
 	if (fmt == NULL) {
-		DPRINT(("[%d] cannot find buffer format\n", task->pid));
+		DPRINT(("[%d] cannot find buffer format\n", task_pid(task)));
 		return -EINVAL;
 	}
 
@@ -2446,7 +2446,7 @@ pfm_setup_buffer_fmt(struct task_struct 
 
 	ret = pfm_buf_fmt_validate(fmt, task, ctx_flags, cpu, fmt_arg);
 
-	DPRINT(("[%d] after validate(0x%x,%d,%p)=%d\n", task->pid, ctx_flags, cpu, fmt_arg, ret));
+	DPRINT(("[%d] after validate(0x%x,%d,%p)=%d\n", task_pid(task), ctx_flags, cpu, fmt_arg, ret));
 
 	if (ret) goto error;
 
@@ -2568,23 +2568,23 @@ pfm_task_incompatible(pfm_context_t *ctx
 	 * no kernel task or task not owner by caller
 	 */
 	if (task->mm == NULL) {
-		DPRINT(("task [%d] has not memory context (kernel thread)\n", task->pid));
+		DPRINT(("task [%d] has not memory context (kernel thread)\n", task_pid(task)));
 		return -EPERM;
 	}
 	if (pfm_bad_permissions(task)) {
-		DPRINT(("no permission to attach to  [%d]\n", task->pid));
+		DPRINT(("no permission to attach to  [%d]\n", task_pid(task)));
 		return -EPERM;
 	}
 	/*
 	 * cannot block in self-monitoring mode
 	 */
 	if (CTX_OVFL_NOBLOCK(ctx) == 0 && task == current) {
-		DPRINT(("cannot load a blocking context on self for [%d]\n", task->pid));
+		DPRINT(("cannot load a blocking context on self for [%d]\n", task_pid(task)));
 		return -EINVAL;
 	}
 
 	if (task->exit_state == EXIT_ZOMBIE) {
-		DPRINT(("cannot attach to  zombie task [%d]\n", task->pid));
+		DPRINT(("cannot attach to  zombie task [%d]\n", task_pid(task)));
 		return -EBUSY;
 	}
 
@@ -2594,7 +2594,7 @@ pfm_task_incompatible(pfm_context_t *ctx
 	if (task == current) return 0;
 
 	if ((task->state != TASK_STOPPED) && (task->state != TASK_TRACED)) {
-		DPRINT(("cannot attach to non-stopped task [%d] state=%ld\n", task->pid, task->state));
+		DPRINT(("cannot attach to non-stopped task [%d] state=%ld\n", task_pid(task), task->state));
 		return -EBUSY;
 	}
 	/*
@@ -2616,7 +2616,7 @@ pfm_get_task(pfm_context_t *ctx, pid_t p
 	/* XXX: need to add more checks here */
 	if (pid < 2) return -EPERM;
 
-	if (pid != current->pid) {
+	if (pid != task_pid(current)) {
 
 		read_lock(&tasklist_lock);
 
@@ -3481,7 +3481,7 @@ pfm_use_debug_registers(struct task_stru
 
 	if (pmu_conf->use_rr_dbregs == 0) return 0;
 
-	DPRINT(("called for [%d]\n", task->pid));
+	DPRINT(("called for [%d]\n", task_pid(task)));
 
 	/*
 	 * do it only once
@@ -3512,7 +3512,7 @@ pfm_use_debug_registers(struct task_stru
 	DPRINT(("ptrace_use_dbregs=%u  sys_use_dbregs=%u by [%d] ret = %d\n",
 		  pfm_sessions.pfs_ptrace_use_dbregs,
 		  pfm_sessions.pfs_sys_use_dbregs,
-		  task->pid, ret));
+		  task_pid(task), ret));
 
 	UNLOCK_PFS(flags);
 
@@ -3537,7 +3537,7 @@ pfm_release_debug_registers(struct task_
 
 	LOCK_PFS(flags);
 	if (pfm_sessions.pfs_ptrace_use_dbregs == 0) {
-		printk(KERN_ERR "perfmon: invalid release for [%d] ptrace_use_dbregs=0\n", task->pid);
+		printk(KERN_ERR "perfmon: invalid release for [%d] ptrace_use_dbregs=0\n", task_pid(task));
 		ret = -1;
 	}  else {
 		pfm_sessions.pfs_ptrace_use_dbregs--;
@@ -3589,7 +3589,7 @@ pfm_restart(pfm_context_t *ctx, void *ar
 
 	/* sanity check */
 	if (unlikely(task == NULL)) {
-		printk(KERN_ERR "perfmon: [%d] pfm_restart no task\n", current->pid);
+		printk(KERN_ERR "perfmon: [%d] pfm_restart no task\n", task_pid(current));
 		return -EINVAL;
 	}
 
@@ -3598,7 +3598,7 @@ pfm_restart(pfm_context_t *ctx, void *ar
 		fmt = ctx->ctx_buf_fmt;
 
 		DPRINT(("restarting self %d ovfl=0x%lx\n",
-			task->pid,
+			task_pid(task),
 			ctx->ctx_ovfl_regs[0]));
 
 		if (CTX_HAS_SMPL(ctx)) {
@@ -3622,11 +3622,11 @@ pfm_restart(pfm_context_t *ctx, void *ar
 				pfm_reset_regs(ctx, ctx->ctx_ovfl_regs, PFM_PMD_LONG_RESET);
 
 			if (rst_ctrl.bits.mask_monitoring == 0) {
-				DPRINT(("resuming monitoring for [%d]\n", task->pid));
+				DPRINT(("resuming monitoring for [%d]\n", task_pid(task)));
 
 				if (state == PFM_CTX_MASKED) pfm_restore_monitoring(task);
 			} else {
-				DPRINT(("keeping monitoring stopped for [%d]\n", task->pid));
+				DPRINT(("keeping monitoring stopped for [%d]\n", task_pid(task)));
 
 				// cannot use pfm_stop_monitoring(task, regs);
 			}
@@ -3683,10 +3683,10 @@ pfm_restart(pfm_context_t *ctx, void *ar
 	 * "self-monitoring".
 	 */
 	if (CTX_OVFL_NOBLOCK(ctx) == 0 && state == PFM_CTX_MASKED) {
-		DPRINT(("unblocking [%d] \n", task->pid));
+		DPRINT(("unblocking [%d] \n", task_pid(task)));
 		up(&ctx->ctx_restart_sem);
 	} else {
-		DPRINT(("[%d] armed exit trap\n", task->pid));
+		DPRINT(("[%d] armed exit trap\n", task_pid(task)));
 
 		ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_RESET;
 
@@ -3774,7 +3774,7 @@ pfm_write_ibr_dbr(int mode, pfm_context_
 	 * don't bother if we are loaded and task is being debugged
 	 */
 	if (is_loaded && (thread->flags & IA64_THREAD_DBG_VALID) != 0) {
-		DPRINT(("debug registers already in use for [%d]\n", task->pid));
+		DPRINT(("debug registers already in use for [%d]\n", task_pid(task)));
 		return -EBUSY;
 	}
 
@@ -3815,7 +3815,7 @@ pfm_write_ibr_dbr(int mode, pfm_context_
 	 * is shared by all processes running on it
  	 */
 	if (first_time && can_access_pmu) {
-		DPRINT(("[%d] clearing ibrs, dbrs\n", task->pid));
+		DPRINT(("[%d] clearing ibrs, dbrs\n", task_pid(task)));
 		for (i=0; i < pmu_conf->num_ibrs; i++) {
 			ia64_set_ibr(i, 0UL);
 			ia64_dv_serialize_instruction();
@@ -4062,7 +4062,7 @@ pfm_stop(pfm_context_t *ctx, void *arg, 
 		 * monitoring disabled in kernel at next reschedule
 		 */
 		ctx->ctx_saved_psr_up = 0;
-		DPRINT(("task=[%d]\n", task->pid));
+		DPRINT(("task=[%d]\n", task_pid(task)));
 	}
 	return 0;
 }
@@ -4228,7 +4228,7 @@ pfm_context_load(pfm_context_t *ctx, voi
 
 	DPRINT(("load_pid [%d] using_dbreg=%d\n", req->load_pid, ctx->ctx_fl_using_dbreg));
 
-	if (CTX_OVFL_NOBLOCK(ctx) == 0 && req->load_pid == current->pid) {
+	if (CTX_OVFL_NOBLOCK(ctx) == 0 && req->load_pid == task_pid(current)) {
 		DPRINT(("cannot use blocking mode on self\n"));
 		return -EINVAL;
 	}
@@ -4267,11 +4267,11 @@ pfm_context_load(pfm_context_t *ctx, voi
 
 		if (is_system) {
 			if (pfm_sessions.pfs_ptrace_use_dbregs) {
-				DPRINT(("cannot load [%d] dbregs in use\n", task->pid));
+				DPRINT(("cannot load [%d] dbregs in use\n", task_pid(task)));
 				ret = -EBUSY;
 			} else {
 				pfm_sessions.pfs_sys_use_dbregs++;
-				DPRINT(("load [%d] increased sys_use_dbreg=%u\n", task->pid, pfm_sessions.pfs_sys_use_dbregs));
+				DPRINT(("load [%d] increased sys_use_dbreg=%u\n", task_pid(task), pfm_sessions.pfs_sys_use_dbregs));
 				set_dbregs = 1;
 			}
 		}
@@ -4363,7 +4363,7 @@ pfm_context_load(pfm_context_t *ctx, voi
 
 			/* allow user level control */
 			ia64_psr(regs)->sp = 0;
-			DPRINT(("clearing psr.sp for [%d]\n", task->pid));
+			DPRINT(("clearing psr.sp for [%d]\n", task_pid(task)));
 
 			SET_LAST_CPU(ctx, smp_processor_id());
 			INC_ACTIVATION();
@@ -4398,7 +4398,7 @@ pfm_context_load(pfm_context_t *ctx, voi
 		 */
 		SET_PMU_OWNER(task, ctx);
 
-		DPRINT(("context loaded on PMU for [%d]\n", task->pid));
+		DPRINT(("context loaded on PMU for [%d]\n", task_pid(task)));
 	} else {
 		/*
 		 * when not current, task MUST be stopped, so this is safe
@@ -4462,7 +4462,7 @@ pfm_context_unload(pfm_context_t *ctx, v
 	int prev_state, is_system;
 	int ret;
 
-	DPRINT(("ctx_state=%d task [%d]\n", ctx->ctx_state, task ? task->pid : -1));
+	DPRINT(("ctx_state=%d task [%d]\n", ctx->ctx_state, task ? task_pid(task) : -1));
 
 	prev_state = ctx->ctx_state;
 	is_system  = ctx->ctx_fl_system;
@@ -4537,7 +4537,7 @@ pfm_context_unload(pfm_context_t *ctx, v
 		 */
 		ia64_psr(regs)->sp = 1;
 
-		DPRINT(("setting psr.sp for [%d]\n", task->pid));
+		DPRINT(("setting psr.sp for [%d]\n", task_pid(task)));
 	}
 	/*
 	 * save PMDs to context
@@ -4577,7 +4577,7 @@ pfm_context_unload(pfm_context_t *ctx, v
 	ctx->ctx_fl_can_restart  = 0;
 	ctx->ctx_fl_going_zombie = 0;
 
-	DPRINT(("disconnected [%d] from context\n", task->pid));
+	DPRINT(("disconnected [%d] from context\n", task_pid(task)));
 
 	return 0;
 }
@@ -4600,7 +4600,7 @@ pfm_exit_thread(struct task_struct *task
 
 	PROTECT_CTX(ctx, flags);
 
-	DPRINT(("state=%d task [%d]\n", ctx->ctx_state, task->pid));
+	DPRINT(("state=%d task [%d]\n", ctx->ctx_state, task_pid(task)));
 
 	state = ctx->ctx_state;
 	switch(state) {
@@ -4609,13 +4609,13 @@ pfm_exit_thread(struct task_struct *task
 	 		 * only comes to thios function if pfm_context is not NULL, i.e., cannot
 			 * be in unloaded state
 	 		 */
-			printk(KERN_ERR "perfmon: pfm_exit_thread [%d] ctx unloaded\n", task->pid);
+			printk(KERN_ERR "perfmon: pfm_exit_thread [%d] ctx unloaded\n", task_pid(task));
 			break;
 		case PFM_CTX_LOADED:
 		case PFM_CTX_MASKED:
 			ret = pfm_context_unload(ctx, NULL, 0, regs);
 			if (ret) {
-				printk(KERN_ERR "perfmon: pfm_exit_thread [%d] state=%d unload failed %d\n", task->pid, state, ret);
+				printk(KERN_ERR "perfmon: pfm_exit_thread [%d] state=%d unload failed %d\n", task_pid(task), state, ret);
 			}
 			DPRINT(("ctx unloaded for current state was %d\n", state));
 
@@ -4624,12 +4624,12 @@ pfm_exit_thread(struct task_struct *task
 		case PFM_CTX_ZOMBIE:
 			ret = pfm_context_unload(ctx, NULL, 0, regs);
 			if (ret) {
-				printk(KERN_ERR "perfmon: pfm_exit_thread [%d] state=%d unload failed %d\n", task->pid, state, ret);
+				printk(KERN_ERR "perfmon: pfm_exit_thread [%d] state=%d unload failed %d\n", task_pid(task), state, ret);
 			}
 			free_ok = 1;
 			break;
 		default:
-			printk(KERN_ERR "perfmon: pfm_exit_thread [%d] unexpected state=%d\n", task->pid, state);
+			printk(KERN_ERR "perfmon: pfm_exit_thread [%d] unexpected state=%d\n", task_pid(task), state);
 			break;
 	}
 	UNPROTECT_CTX(ctx, flags);
@@ -4713,7 +4713,7 @@ recheck:
 	DPRINT(("context %d state=%d [%d] task_state=%ld must_stop=%d\n",
 		ctx->ctx_fd,
 		state,
-		task->pid,
+		task_pid(task),
 		task->state, PFM_CMD_STOPPED(cmd)));
 
 	/*
@@ -4760,7 +4760,7 @@ recheck:
 	 */
 	if (PFM_CMD_STOPPED(cmd)) {
 		if ((task->state != TASK_STOPPED) && (task->state != TASK_TRACED)) {
-			DPRINT(("[%d] task not in stopped state\n", task->pid));
+			DPRINT(("[%d] task not in stopped state\n", task_pid(task)));
 			return -EBUSY;
 		}
 		/*
@@ -4853,7 +4853,7 @@ restart_args:
 	 * limit abuse to min page size
 	 */
 	if (unlikely(sz > PFM_MAX_ARGSIZE)) {
-		printk(KERN_ERR "perfmon: [%d] argument too big %lu\n", current->pid, sz);
+		printk(KERN_ERR "perfmon: [%d] argument too big %lu\n", task_pid(current), sz);
 		return -E2BIG;
 	}
 
@@ -4998,11 +4998,11 @@ pfm_context_force_terminate(pfm_context_
 {
 	int ret;
 
-	DPRINT(("entering for [%d]\n", current->pid));
+	DPRINT(("entering for [%d]\n", task_pid(current)));
 
 	ret = pfm_context_unload(ctx, NULL, 0, regs);
 	if (ret) {
-		printk(KERN_ERR "pfm_context_force_terminate: [%d] unloaded failed with %d\n", current->pid, ret);
+		printk(KERN_ERR "pfm_context_force_terminate: [%d] unloaded failed with %d\n", task_pid(current), ret);
 	}
 
 	/*
@@ -5039,7 +5039,7 @@ pfm_handle_work(void)
 
 	ctx = PFM_GET_CTX(current);
 	if (ctx == NULL) {
-		printk(KERN_ERR "perfmon: [%d] has no PFM context\n", current->pid);
+		printk(KERN_ERR "perfmon: [%d] has no PFM context\n", task_pid(current));
 		return;
 	}
 
@@ -5236,7 +5236,7 @@ pfm_overflow_handler(struct task_struct 
 	DPRINT_ovfl(("pmc0=0x%lx pid=%d iip=0x%lx, %s "
 		     "used_pmds=0x%lx\n",
 			pmc0,
-			task ? task->pid: -1,
+			task ? task_pid(task): -1,
 			(regs ? regs->cr_iip : 0),
 			CTX_OVFL_NOBLOCK(ctx) ? "nonblocking" : "blocking",
 			ctx->ctx_used_pmds[0]));
@@ -5450,7 +5450,7 @@ pfm_overflow_handler(struct task_struct 
 sanity_check:
 	printk(KERN_ERR "perfmon: CPU%d overflow handler [%d] pmc0=0x%lx\n",
 			smp_processor_id(),
-			task ? task->pid : -1,
+			task ? task_pid(task) : -1,
 			pmc0);
 	return;
 
@@ -5483,7 +5483,7 @@ stop_monitoring:
 	 *
 	 * Overall pretty hairy stuff....
 	 */
-	DPRINT(("ctx is zombie for [%d], converted to spurious\n", task ? task->pid: -1));
+	DPRINT(("ctx is zombie for [%d], converted to spurious\n", task ? task_pid(task): -1));
 	pfm_clear_psr_up();
 	ia64_psr(regs)->up = 0;
 	ia64_psr(regs)->sp = 1;
@@ -5544,13 +5544,13 @@ pfm_do_interrupt_handler(int irq, void *
 
 report_spurious1:
 	printk(KERN_INFO "perfmon: spurious overflow interrupt on CPU%d: process %d has no PFM context\n",
-		this_cpu, task->pid);
+		this_cpu, task_pid(task));
 	pfm_unfreeze_pmu();
 	return -1;
 report_spurious2:
 	printk(KERN_INFO "perfmon: spurious overflow interrupt on CPU%d: process %d, invalid flag\n", 
 		this_cpu, 
-		task->pid);
+		task_pid(task));
 	pfm_unfreeze_pmu();
 	return -1;
 }
@@ -5792,7 +5792,7 @@ pfm_syst_wide_update_task(struct task_st
 	 * pid 0 is guaranteed to be the idle task. There is one such task with pid 0
 	 * on every CPU, so we can rely on the pid to identify the idle task.
 	 */
-	if ((info & PFM_CPUINFO_EXCL_IDLE) == 0 || task->pid) {
+	if ((info & PFM_CPUINFO_EXCL_IDLE) == 0 || task_pid(task)) {
 		regs = ia64_task_regs(task);
 		ia64_psr(regs)->pp = is_ctxswin ? dcr_pp : 0;
 		return;
@@ -5836,7 +5836,7 @@ pfm_force_cleanup(pfm_context_t *ctx, st
 	ia64_psr(regs)->sp = 1;
 
 	if (GET_PMU_OWNER() == task) {
-		DPRINT(("cleared ownership for [%d]\n", ctx->ctx_task->pid));
+		DPRINT(("cleared ownership for [%d]\n", ctx->ctx_task_pid(task)));
 		SET_PMU_OWNER(NULL, NULL);
 	}
 
@@ -5848,7 +5848,7 @@ pfm_force_cleanup(pfm_context_t *ctx, st
 	task->thread.pfm_context  = NULL;
 	task->thread.flags       &= ~IA64_THREAD_PM_VALID;
 
-	DPRINT(("force cleanup for [%d]\n",  task->pid));
+	DPRINT(("force cleanup for [%d]\n",  task_pid(task)));
 }
 
 
@@ -6400,7 +6400,7 @@ pfm_flush_pmds(struct task_struct *task,
 
 		if (PMD_IS_COUNTING(i)) {
 			DPRINT(("[%d] pmd[%d] ctx_pmd=0x%lx hw_pmd=0x%lx\n",
-				task->pid,
+				task_pid(task),
 				i,
 				ctx->ctx_pmds[i].val,
 				val & ovfl_val));
@@ -6422,11 +6422,11 @@ pfm_flush_pmds(struct task_struct *task,
 			 */
 			if (pmc0 & (1UL << i)) {
 				val += 1 + ovfl_val;
-				DPRINT(("[%d] pmd[%d] overflowed\n", task->pid, i));
+				DPRINT(("[%d] pmd[%d] overflowed\n", task_pid(task), i));
 			}
 		}
 
-		DPRINT(("[%d] ctx_pmd[%d]=0x%lx  pmd_val=0x%lx\n", task->pid, i, val, pmd_val));
+		DPRINT(("[%d] ctx_pmd[%d]=0x%lx  pmd_val=0x%lx\n", task_pid(task), i, val, pmd_val));
 
 		if (is_self) task->thread.pmds[i] = pmd_val;
 
@@ -6765,14 +6765,14 @@ dump_pmu_state(const char *from)
 	printk("CPU%d from %s() current [%d] iip=0x%lx %s\n", 
 		this_cpu, 
 		from, 
-		current->pid, 
+		task_pid(current),
 		regs->cr_iip,
 		current->comm);
 
 	task = GET_PMU_OWNER();
 	ctx  = GET_PMU_CTX();
 
-	printk("->CPU%d owner [%d] ctx=%p\n", this_cpu, task ? task->pid : -1, ctx);
+	printk("->CPU%d owner [%d] ctx=%p\n", this_cpu, task ? task_pid(task) : -1, ctx);
 
 	psr = pfm_get_psr();
 
@@ -6822,7 +6822,7 @@ pfm_inherit(struct task_struct *task, st
 {
 	struct thread_struct *thread;
 
-	DPRINT(("perfmon: pfm_inherit clearing state for [%d]\n", task->pid));
+	DPRINT(("perfmon: pfm_inherit clearing state for [%d]\n", task_pid(task)));
 
 	thread = &task->thread;
 
Index: linux-2.6.15-rc1/arch/ia64/kernel/perfmon_default_smpl.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/perfmon_default_smpl.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/perfmon_default_smpl.c
@@ -45,11 +45,11 @@ default_validate(struct task_struct *tas
 	int ret = 0;
 
 	if (data == NULL) {
-		DPRINT(("[%d] no argument passed\n", task->pid));
+		DPRINT(("[%d] no argument passed\n", task_pid(task)));
 		return -EINVAL;
 	}
 
-	DPRINT(("[%d] validate flags=0x%x CPU%d\n", task->pid, flags, cpu));
+	DPRINT(("[%d] validate flags=0x%x CPU%d\n", task_pid(task), flags, cpu));
 
 	/*
 	 * must hold at least the buffer header + one minimally sized entry
@@ -89,7 +89,7 @@ default_init(struct task_struct *task, v
 	hdr->hdr_count        = 0UL;
 
 	DPRINT(("[%d] buffer=%p buf_size=%lu hdr_size=%lu hdr_version=%u cur_offs=%lu\n",
-		task->pid,
+		task_pid(task),
 		buf,
 		hdr->hdr_buf_size,
 		sizeof(*hdr),
@@ -111,7 +111,7 @@ default_handler(struct task_struct *task
 	unsigned char ovfl_notify;
 
 	if (unlikely(buf == NULL || arg == NULL|| regs == NULL || task == NULL)) {
-		DPRINT(("[%d] invalid arguments buf=%p arg=%p\n", task->pid, buf, arg));
+		DPRINT(("[%d] invalid arguments buf=%p arg=%p\n", task_pid(task), buf, arg));
 		return -EINVAL;
 	}
 
@@ -140,7 +140,7 @@ default_handler(struct task_struct *task
 	hdr->hdr_count++;
 
 	DPRINT_ovfl(("[%d] count=%lu cur=%p last=%p free_bytes=%lu ovfl_pmd=%d ovfl_notify=%d npmds=%u\n",
-			task->pid,
+			task_pid(task),
 			hdr->hdr_count,
 			cur, last,
 			last-cur,
@@ -157,7 +157,7 @@ default_handler(struct task_struct *task
 	 * system-wide:
 	 * 	- this is not necessarily the task controlling the session
 	 */
-	ent->pid            = current->pid;
+	ent->pid            = task_pid(current);
 	ent->ovfl_pmd  	    = ovfl_pmd;
 	ent->last_reset_val = arg->pmd_last_reset; //pmd[0].reg_last_reset_val;
 
@@ -169,7 +169,7 @@ default_handler(struct task_struct *task
 	ent->tstamp    = stamp;
 	ent->cpu       = smp_processor_id();
 	ent->set       = arg->active_set;
-	ent->tgid      = current->tgid;
+	ent->tgid      = task_tgid(current);
 
 	/*
 	 * selectively store PMDs in increasing index number
@@ -246,7 +246,7 @@ default_restart(struct task_struct *task
 static int
 default_exit(struct task_struct *task, void *buf, struct pt_regs *regs)
 {
-	DPRINT(("[%d] exit(%p)\n", task->pid, buf));
+	DPRINT(("[%d] exit(%p)\n", task_pid(task), buf));
 	return 0;
 }
 
Index: linux-2.6.15-rc1/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/process.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/process.c
@@ -109,7 +109,7 @@ show_regs (struct pt_regs *regs)
 	unsigned long ip = regs->cr_iip + ia64_psr(regs)->ri;
 
 	print_modules();
-	printk("\nPid: %d, CPU %d, comm: %20s\n", current->pid, smp_processor_id(), current->comm);
+	printk("\nPid: %d, CPU %d, comm: %20s\n", task_pid(current), smp_processor_id(), current->comm);
 	printk("psr : %016lx ifs : %016lx ip  : [<%016lx>]    %s\n",
 	       regs->cr_ipsr, regs->cr_ifs, ip, print_tainted());
 	print_symbol("ip is at %s\n", ip);
Index: linux-2.6.15-rc1/arch/ia64/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/signal.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/signal.c
@@ -257,7 +257,7 @@ ia64_rt_sigreturn (struct sigscratch *sc
 
 #if DEBUG_SIG
 	printk("SIG return (%s:%d): sp=%lx ip=%lx\n",
-	       current->comm, current->pid, scr->pt.r12, scr->pt.cr_iip);
+	       current->comm, task_pid(current), scr->pt.r12, scr->pt.cr_iip);
 #endif
 	/*
 	 * It is more difficult to avoid calling this function than to
@@ -270,7 +270,7 @@ ia64_rt_sigreturn (struct sigscratch *sc
 	si.si_signo = SIGSEGV;
 	si.si_errno = 0;
 	si.si_code = SI_KERNEL;
-	si.si_pid = current->pid;
+	si.si_pid = task_pid(current);
 	si.si_uid = current->uid;
 	si.si_addr = sc;
 	force_sig_info(SIGSEGV, &si, current);
@@ -375,7 +375,7 @@ force_sigsegv_info (int sig, void __user
 	si.si_signo = SIGSEGV;
 	si.si_errno = 0;
 	si.si_code = SI_KERNEL;
-	si.si_pid = current->pid;
+	si.si_pid = task_pid(current);
 	si.si_uid = current->uid;
 	si.si_addr = addr;
 	force_sig_info(SIGSEGV, &si, current);
@@ -448,7 +448,7 @@ setup_frame (int sig, struct k_sigaction
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sig=%d sp=%lx ip=%lx handler=%p\n",
-	       current->comm, current->pid, sig, scr->pt.r12, frame->sc.sc_ip, frame->handler);
+	       current->comm, task_pid(current), sig, scr->pt.r12, frame->sc.sc_ip, frame->handler);
 #endif
 	return 1;
 }
Index: linux-2.6.15-rc1/arch/ia64/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/traps.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/traps.c
@@ -107,7 +107,7 @@ die (const char *str, struct pt_regs *re
 
 	if (++die.lock_owner_depth < 3) {
 		printk("%s[%d]: %s %ld [%d]\n",
-			current->comm, current->pid, str, err, ++die_counter);
+			current->comm, task_pid(current), str, err, ++die_counter);
 		(void) notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 		show_regs(regs);
   	} else
@@ -346,7 +346,7 @@ handle_fpu_swa (int fp_fault, struct pt_
 		++fpu_swa_count;
 		printk(KERN_WARNING
 		       "%s(%d): floating-point assist fault at ip %016lx, isr %016lx\n",
-		       current->comm, current->pid, regs->cr_iip + ia64_psr(regs)->ri, isr);
+		       current->comm, task_pid(current), regs->cr_iip + ia64_psr(regs)->ri, isr);
 	}
 
 	exception = fp_emulate(fp_fault, bundle, &regs->cr_ipsr, &regs->ar_fpsr, &isr, &regs->pr,
@@ -482,7 +482,7 @@ ia64_fault (unsigned long vector, unsign
 		if (code == 8) {
 # ifdef CONFIG_IA64_PRINT_HAZARDS
 			printk("%s[%d]: possible hazard @ ip=%016lx (pr = %016lx)\n",
-			       current->comm, current->pid,
+			       current->comm, task_pid(current),
 			       regs.cr_iip + ia64_psr(&regs)->ri, regs.pr);
 # endif
 			return;
Index: linux-2.6.15-rc1/arch/ia64/kernel/unaligned.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/kernel/unaligned.c
+++ linux-2.6.15-rc1/arch/ia64/kernel/unaligned.c
@@ -1330,7 +1330,7 @@ ia64_handle_unaligned (unsigned long ifa
 			size_t len;
 
 			len = sprintf(buf, "%s(%d): unaligned access to 0x%016lx, "
-				      "ip=0x%016lx\n\r", current->comm, current->pid,
+				      "ip=0x%016lx\n\r", current->comm, task_pid(current),
 				      ifa, regs->cr_iip + ipsr->ri);
 			/*
 			 * Don't call tty_write_message() if we're in the kernel; we might
Index: linux-2.6.15-rc1/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/mm/fault.c
+++ linux-2.6.15-rc1/arch/ia64/mm/fault.c
@@ -241,7 +241,7 @@ ia64_do_page_fault (unsigned long addres
 
   out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (task_pid(current) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
Index: linux-2.6.15-rc1/arch/ia64/sn/kernel/xpc_main.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/ia64/sn/kernel/xpc_main.c
+++ linux-2.6.15-rc1/arch/ia64/sn/kernel/xpc_main.c
@@ -508,7 +508,7 @@ xpc_activating(void *__partid)
 	ret = sched_setscheduler(current, SCHED_FIFO, &param);
 	if (ret != 0) {
 		dev_warn(xpc_part, "unable to set pid %d to a realtime "
-			"priority, ret=%d\n", current->pid, ret);
+			"priority, ret=%d\n", task_pid(current), ret);
 	}
 
 	/* allow this thread and its children to run on any CPU */
Index: linux-2.6.15-rc1/arch/mips/kernel/irixelf.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/irixelf.c
+++ linux-2.6.15-rc1/arch/mips/kernel/irixelf.c
@@ -556,9 +556,9 @@ static void irix_map_prda_page(void)
 		return;
 
 	pp = (struct prda *) v;
-	pp->prda_sys.t_pid  = current->pid;
+	pp->prda_sys.t_pid  = task_pid(current);
 	pp->prda_sys.t_prid = read_c0_prid();
-	pp->prda_sys.t_rpid = current->pid;
+	pp->prda_sys.t_rpid = task_pid(current);
 
 	/* We leave the rest set to zero */
 }
@@ -1148,11 +1148,11 @@ static int irix_core_dump(long signr, st
 	prstatus.pr_info.si_signo = prstatus.pr_cursig = signr;
 	prstatus.pr_sigpend = current->pending.signal.sig[0];
 	prstatus.pr_sighold = current->blocked.sig[0];
-	psinfo.pr_pid = prstatus.pr_pid = current->pid;
+	psinfo.pr_pid = prstatus.pr_pid = task_pid(current);
 	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
 	psinfo.pr_pgrp = prstatus.pr_pgrp = process_group(current);
 	psinfo.pr_sid = prstatus.pr_sid = current->signal->session;
-	if (current->pid == current->tgid) {
+	if (task_pid(current) == task_tgid(current)) {
 		/*
 		 * This is the record for the group leader.  Add in the
 		 * cumulative times of previous dead threads.  This total
Index: linux-2.6.15-rc1/arch/mips/kernel/irixioctl.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/irixioctl.c
+++ linux-2.6.15-rc1/arch/mips/kernel/irixioctl.c
@@ -62,7 +62,7 @@ asmlinkage int irix_ioctl(int fd, unsign
 	int i, error = 0;
 
 #ifdef DEBUG_IOCTLS
-	printk("[%s:%d] irix_ioctl(%d, ", current->comm, current->pid, fd);
+	printk("[%s:%d] irix_ioctl(%d, ", current->comm, task_pid(current), fd);
 #endif
 	switch(cmd) {
 	case 0x00005401:
@@ -236,7 +236,7 @@ asmlinkage int irix_ioctl(int fd, unsign
 		sys_write(2, msg, strlen(msg));
 		set_fs(old_fs);
 		printk("[%s:%d] Does unimplemented IRIX ioctl cmd %08lx\n",
-		       current->comm, current->pid, cmd);
+		       current->comm, task_pid(current), cmd);
 		do_exit(255);
 #else
 		error = sys_ioctl (fd, cmd, arg);
Index: linux-2.6.15-rc1/arch/mips/kernel/irixsig.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/irixsig.c
+++ linux-2.6.15-rc1/arch/mips/kernel/irixsig.c
@@ -232,7 +232,7 @@ irix_sigreturn(struct pt_regs *regs)
 	sig = (int) regs->regs[base + 6];
 #ifdef DEBUG_SIG
 	printk("[%s:%d] IRIX sigreturn(scp[%p],ucp[%p],sig[%d])\n",
-	       current->comm, current->pid, context, magic, sig);
+	       current->comm, task_pid(current), context, magic, sig);
 #endif
 	if (!context)
 		context = magic;
@@ -473,7 +473,7 @@ asmlinkage int irix_sigpoll_sys(unsigned
 
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigpoll_sys(%p,%p,%p)\n",
-	       current->comm, current->pid, set, info, tp);
+	       current->comm, task_pid(current), set, info, tp);
 #endif
 
 	/* Must always specify the signal set. */
@@ -586,7 +586,7 @@ repeat:
 	tsk = current;
 	list_for_each(_p,&tsk->children) {
 		p = list_entry(_p,struct task_struct,sibling);
-		if ((type == IRIX_P_PID) && p->pid != pid)
+		if ((type == IRIX_P_PID) && task_pid(p) != pid)
 			continue;
 		if ((type == IRIX_P_PGID) && process_group(p) != pid)
 			continue;
@@ -613,7 +613,7 @@ repeat:
 
 			retval = __put_user(SIGCHLD, &info->sig);
 			retval |= __put_user(0, &info->code);
-			retval |= __put_user(p->pid, &info->stuff.procinfo.pid);
+			retval |= __put_user(task_pid(p), &info->stuff.procinfo.pid);
 			retval |= __put_user((p->exit_code >> 8) & 0xff,
 			           &info->stuff.procinfo.procdata.child.status);
 			retval |= __put_user(p->utime, &info->stuff.procinfo.procdata.child.utime);
@@ -631,7 +631,7 @@ repeat:
 				getrusage(p, RUSAGE_BOTH, ru);
 			retval = __put_user(SIGCHLD, &info->sig);
 			retval |= __put_user(1, &info->code);      /* CLD_EXITED */
-			retval |= __put_user(p->pid, &info->stuff.procinfo.pid);
+			retval |= __put_user(task_pid(p), &info->stuff.procinfo.pid);
 			retval |= __put_user((p->exit_code >> 8) & 0xff,
 			           &info->stuff.procinfo.procdata.child.status);
 			retval |= __put_user(p->utime,
@@ -701,7 +701,7 @@ asmlinkage int irix_getcontext(struct pt
 
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_getcontext(%p)\n",
-	       current->comm, current->pid, ctx);
+	       current->comm, task_pid(current), ctx);
 #endif
 
 	if (!access_ok(VERIFY_WRITE, ctx, sizeof(*ctx)));
@@ -749,7 +749,7 @@ asmlinkage void irix_setcontext(struct p
 
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_setcontext(%p)\n",
-	       current->comm, current->pid, ctx);
+	       current->comm, task_pid(current), ctx);
 #endif
 
 	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx)))
@@ -806,7 +806,7 @@ asmlinkage int irix_sigstack(struct irix
 {
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigstack(%p,%p)\n",
-	       current->comm, current->pid, new, old);
+	       current->comm, task_pid(current), new, old);
 #endif
 	if (new) {
 		if (!access_ok(VERIFY_READ, new, sizeof(*new)))
@@ -828,7 +828,7 @@ asmlinkage int irix_sigaltstack(struct i
 {
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigaltstack(%p,%p)\n",
-	       current->comm, current->pid, new, old);
+	       current->comm, task_pid(current), new, old);
 #endif
 	if (new)
 		if (!access_ok(VERIFY_READ, new, sizeof(*new)))
@@ -852,7 +852,7 @@ asmlinkage int irix_sigsendset(struct ir
 		return -EFAULT;
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigsendset([%d,%d,%d,%d,%d],%d)\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       pset->cmd, pset->ltype, pset->lid, pset->rtype, pset->rid,
 	       sig);
 #endif
Index: linux-2.6.15-rc1/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/process.c
+++ linux-2.6.15-rc1/arch/mips/kernel/process.c
@@ -170,7 +170,7 @@ int copy_thread(int nr, unsigned long cl
 	}
 #endif
 	childregs->regs[2] = 0;	/* Child gets zero as return value */
-	regs->regs[2] = p->pid;
+	regs->regs[2] = task_pid(p);
 
 	if (childregs->cp0_status & ST0_CU0) {
 		childregs->regs[28] = (unsigned long) ti;
Index: linux-2.6.15-rc1/arch/mips/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/signal.c
+++ linux-2.6.15-rc1/arch/mips/kernel/signal.c
@@ -314,7 +314,7 @@ int setup_frame(struct k_sigaction * ka,
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       frame, regs->cp0_epc, frame->regs[31]);
 #endif
         return 1;
@@ -374,7 +374,7 @@ int setup_rt_frame(struct k_sigaction * 
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
 	return 1;
Index: linux-2.6.15-rc1/arch/mips/kernel/signal32.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/signal32.c
+++ linux-2.6.15-rc1/arch/mips/kernel/signal32.c
@@ -691,7 +691,7 @@ int setup_frame_32(struct k_sigaction * 
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       frame, regs->cp0_epc, frame->sf_code);
 #endif
 	return 1;
@@ -762,7 +762,7 @@ int setup_rt_frame_32(struct k_sigaction
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       frame, regs->cp0_epc, frame->rs_code);
 #endif
 	return 1;
Index: linux-2.6.15-rc1/arch/mips/kernel/signal_n32.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/signal_n32.c
+++ linux-2.6.15-rc1/arch/mips/kernel/signal_n32.c
@@ -181,7 +181,7 @@ int setup_rt_frame_n32(struct k_sigactio
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%p\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       frame, regs->cp0_epc, regs->regs[31]);
 #endif
 	return 1;
Index: linux-2.6.15-rc1/arch/mips/kernel/sysirix.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/sysirix.c
+++ linux-2.6.15-rc1/arch/mips/kernel/sysirix.c
@@ -64,7 +64,7 @@ asmlinkage int irix_sysmp(struct pt_regs
 		break;
 	default:
 		printk("SYSMP[%s:%d]: Unsupported opcode %d\n",
-		       current->comm, current->pid, (int)cmd);
+		       current->comm, task_pid(current), (int)cmd);
 		error = -EINVAL;
 		break;
 	}
@@ -99,7 +99,7 @@ asmlinkage int irix_prctl(unsigned optio
 	switch (option) {
 	case PR_MAXPROCS:
 		printk("irix_prctl[%s:%d]: Wants PR_MAXPROCS\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = max_threads;
 		break;
 
@@ -107,7 +107,7 @@ asmlinkage int irix_prctl(unsigned optio
 		struct task_struct *task;
 
 		printk("irix_prctl[%s:%d]: Wants PR_ISBLOCKED\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		read_lock(&tasklist_lock);
 		task = find_task_by_pid(va_arg(args, pid_t));
 		error = -ESRCH;
@@ -122,7 +122,7 @@ asmlinkage int irix_prctl(unsigned optio
 		long value = va_arg(args, long);
 
 		printk("irix_prctl[%s:%d]: Wants PR_SETSTACKSIZE<%08lx>\n",
-		       current->comm, current->pid, (unsigned long) value);
+		       current->comm, task_pid(current), (unsigned long) value);
 		if (value > RLIM_INFINITY)
 			value = RLIM_INFINITY;
 		if (capable(CAP_SYS_ADMIN)) {
@@ -147,25 +147,25 @@ asmlinkage int irix_prctl(unsigned optio
 
 	case PR_GETSTACKSIZE:
 		printk("irix_prctl[%s:%d]: Wants PR_GETSTACKSIZE\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = current->signal->rlim[RLIMIT_STACK].rlim_cur;
 		break;
 
 	case PR_MAXPPROCS:
 		printk("irix_prctl[%s:%d]: Wants PR_MAXPROCS\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = 1;
 		break;
 
 	case PR_UNBLKONEXEC:
 		printk("irix_prctl[%s:%d]: Wants PR_UNBLKONEXEC\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL;
 		break;
 
 	case PR_SETEXITSIG:
 		printk("irix_prctl[%s:%d]: Wants PR_SETEXITSIG\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 
 		/* We can probably play some game where we set the task
 		 * exit_code to some non-zero value when this is requested,
@@ -176,31 +176,31 @@ asmlinkage int irix_prctl(unsigned optio
 
 	case PR_RESIDENT:
 		printk("irix_prctl[%s:%d]: Wants PR_RESIDENT\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = 0; /* Compatibility indeed. */
 		break;
 
 	case PR_ATTACHADDR:
 		printk("irix_prctl[%s:%d]: Wants PR_ATTACHADDR\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL;
 		break;
 
 	case PR_DETACHADDR:
 		printk("irix_prctl[%s:%d]: Wants PR_DETACHADDR\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL;
 		break;
 
 	case PR_TERMCHILD:
 		printk("irix_prctl[%s:%d]: Wants PR_TERMCHILD\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL;
 		break;
 
 	case PR_GETSHMASK:
 		printk("irix_prctl[%s:%d]: Wants PR_GETSHMASK\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL; /* Until I have the sproc() stuff in. */
 		break;
 
@@ -210,19 +210,19 @@ asmlinkage int irix_prctl(unsigned optio
 
 	case PR_COREPID:
 		printk("irix_prctl[%s:%d]: Wants PR_COREPID\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL;
 		break;
 
 	case PR_ATTACHADDRPERM:
 		printk("irix_prctl[%s:%d]: Wants PR_ATTACHADDRPERM\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		error = -EINVAL;
 		break;
 
 	default:
 		printk("irix_prctl[%s:%d]: Non-existant opcode %d\n",
-		       current->comm, current->pid, option);
+		       current->comm, task_pid(current), option);
 		error = -EINVAL;
 		break;
 	}
@@ -320,7 +320,7 @@ asmlinkage int irix_syssgi(struct pt_reg
 		retval = prom_setenv(name, value);
 		/* XXX make sure retval conforms to syssgi(2) */
 		printk("[%s:%d] setnvram(\"%s\", \"%s\"): retval %d",
-		       current->comm, current->pid, name, value, retval);
+		       current->comm, task_pid(current), name, value, retval);
 /*		if (retval == PROM_ENOENT)
 		  	retval = -ENOENT; */
 		break;
@@ -330,7 +330,7 @@ asmlinkage int irix_syssgi(struct pt_reg
 	case SGI_SETPGID: {
 #ifdef DEBUG_PROCGRPS
 		printk("[%s:%d] setpgid(%d, %d) ",
-		       current->comm, current->pid,
+		       current->comm, task_pid(current),
 		       (int) regs->regs[base + 5], (int)regs->regs[base + 6]);
 #endif
 		retval = sys_setpgid(regs->regs[base + 5], regs->regs[base + 6]);
@@ -426,7 +426,7 @@ asmlinkage int irix_syssgi(struct pt_reg
 
 	case SGI_GETSID:
 #ifdef DEBUG_PROCGRPS
-		printk("[%s:%d] getsid(%d) ", current->comm, current->pid,
+		printk("[%s:%d] getsid(%d) ", current->comm, task_pid(current),
 		       (int) regs->regs[base + 5]);
 #endif
 		retval = sys_getsid(regs->regs[base + 5]);
@@ -582,7 +582,7 @@ out:
 asmlinkage int irix_getpid(struct pt_regs *regs)
 {
 	regs->regs[3] = current->real_parent->pid;
-	return current->pid;
+	return task_pid(current);
 }
 
 asmlinkage int irix_getuid(struct pt_regs *regs)
@@ -680,7 +680,7 @@ asmlinkage int irix_mount(char __user *d
 	unsigned long flags, char __user *type, void __user *data, int datalen)
 {
 	printk("[%s:%d] irix_mount(%p,%p,%08lx,%p,%p,%d)\n",
-	       current->comm, current->pid,
+	       current->comm, task_pid(current),
 	       dev_name, dir_name, flags, type, data, datalen);
 
 	return sys_mount(dev_name, dir_name, type, flags, data);
@@ -779,7 +779,7 @@ asmlinkage int irix_setpgrp(int flags)
 	int error;
 
 #ifdef DEBUG_PROCGRPS
-	printk("[%s:%d] setpgrp(%d) ", current->comm, current->pid, flags);
+	printk("[%s:%d] setpgrp(%d) ", current->comm, task_pid(current), flags);
 #endif
 	if(!flags)
 		error = process_group(current);
@@ -849,7 +849,7 @@ asmlinkage int irix_exece(struct pt_regs
 asmlinkage unsigned long irix_gethostid(void)
 {
 	printk("[%s:%d]: irix_gethostid() called...\n",
-	       current->comm, current->pid);
+	       current->comm, task_pid(current));
 
 	return -EINVAL;
 }
@@ -857,7 +857,7 @@ asmlinkage unsigned long irix_gethostid(
 asmlinkage unsigned long irix_sethostid(unsigned long val)
 {
 	printk("[%s:%d]: irix_sethostid(%08lx) called...\n",
-	       current->comm, current->pid, val);
+	       current->comm, task_pid(current), val);
 
 	return -EINVAL;
 }
@@ -1082,7 +1082,7 @@ asmlinkage unsigned long irix_mmap32(uns
 asmlinkage int irix_madvise(unsigned long addr, int len, int behavior)
 {
 	printk("[%s:%d] Wheee.. irix_madvise(%08lx,%d,%d)\n",
-	       current->comm, current->pid, addr, len, behavior);
+	       current->comm, task_pid(current), addr, len, behavior);
 
 	return -EINVAL;
 }
@@ -1090,7 +1090,7 @@ asmlinkage int irix_madvise(unsigned lon
 asmlinkage int irix_pagelock(char __user *addr, int len, int op)
 {
 	printk("[%s:%d] Wheee.. irix_pagelock(%p,%d,%d)\n",
-	       current->comm, current->pid, addr, len, op);
+	       current->comm, task_pid(current), addr, len, op);
 
 	return -EINVAL;
 }
@@ -1098,7 +1098,7 @@ asmlinkage int irix_pagelock(char __user
 asmlinkage int irix_quotactl(struct pt_regs *regs)
 {
 	printk("[%s:%d] Wheee.. irix_quotactl()\n",
-	       current->comm, current->pid);
+	       current->comm, task_pid(current));
 
 	return -EINVAL;
 }
@@ -1108,14 +1108,14 @@ asmlinkage int irix_BSDsetpgrp(int pid, 
 	int error;
 
 #ifdef DEBUG_PROCGRPS
-	printk("[%s:%d] BSDsetpgrp(%d, %d) ", current->comm, current->pid,
+	printk("[%s:%d] BSDsetpgrp(%d, %d) ", current->comm, task_pid(current),
 	       pid, pgrp);
 #endif
 	if(!pid)
-		pid = current->pid;
+		pid = task_pid(current);
 
 	/* Wheee, weird sysv thing... */
-	if ((pgrp == 0) && (pid == current->pid))
+	if ((pgrp == 0) && (pid == task_pid(current)))
 		error = sys_setsid();
 	else
 		error = sys_setpgid(pid, pgrp);
@@ -1130,7 +1130,7 @@ asmlinkage int irix_BSDsetpgrp(int pid, 
 asmlinkage int irix_systeminfo(int cmd, char __user *buf, int cnt)
 {
 	printk("[%s:%d] Wheee.. irix_systeminfo(%d,%p,%d)\n",
-	       current->comm, current->pid, cmd, buf, cnt);
+	       current->comm, task_pid(current), cmd, buf, cnt);
 
 	return -EINVAL;
 }
@@ -1257,7 +1257,7 @@ asmlinkage int irix_xstat(int version, c
 
 #ifdef DEBUG_XSTAT
 	printk("[%s:%d] Wheee.. irix_xstat(%d,%s,%p) ",
-	       current->comm, current->pid, version, filename, statbuf);
+	       current->comm, task_pid(current), version, filename, statbuf);
 #endif
 
 	retval = vfs_stat(filename, &stat);
@@ -1283,7 +1283,7 @@ asmlinkage int irix_lxstat(int version, 
 
 #ifdef DEBUG_XSTAT
 	printk("[%s:%d] Wheee.. irix_lxstat(%d,%s,%p) ",
-	       current->comm, current->pid, version, filename, statbuf);
+	       current->comm, task_pid(current), version, filename, statbuf);
 #endif
 
 	error = vfs_lstat(filename, &stat);
@@ -1310,7 +1310,7 @@ asmlinkage int irix_fxstat(int version, 
 
 #ifdef DEBUG_XSTAT
 	printk("[%s:%d] Wheee.. irix_fxstat(%d,%d,%p) ",
-	       current->comm, current->pid, version, fd, statbuf);
+	       current->comm, task_pid(current), version, fd, statbuf);
 #endif
 
 	error = vfs_fstat(fd, &stat);
@@ -1333,7 +1333,7 @@ asmlinkage int irix_xmknod(int ver, char
 {
 	int retval;
 	printk("[%s:%d] Wheee.. irix_xmknod(%d,%s,%x,%x)\n",
-	       current->comm, current->pid, ver, filename, mode, dev);
+	       current->comm, task_pid(current), ver, filename, mode, dev);
 
 	switch(ver) {
 	case 2:
@@ -1352,7 +1352,7 @@ asmlinkage int irix_xmknod(int ver, char
 asmlinkage int irix_swapctl(int cmd, char __user *arg)
 {
 	printk("[%s:%d] Wheee.. irix_swapctl(%d,%p)\n",
-	       current->comm, current->pid, cmd, arg);
+	       current->comm, task_pid(current), cmd, arg);
 
 	return -EINVAL;
 }
@@ -1372,7 +1372,7 @@ asmlinkage int irix_statvfs(char __user 
 	int error, i;
 
 	printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
-	       current->comm, current->pid, fname, buf);
+	       current->comm, task_pid(current), fname, buf);
 	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs)))
 		return -EFAULT;
 
@@ -1416,7 +1416,7 @@ asmlinkage int irix_fstatvfs(int fd, str
 	int error, i;
 
 	printk("[%s:%d] Wheee.. irix_fstatvfs(%d,%p)\n",
-	       current->comm, current->pid, fd, buf);
+	       current->comm, task_pid(current), fd, buf);
 
 	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs)))
 		return -EFAULT;
@@ -1457,7 +1457,7 @@ out:
 asmlinkage int irix_priocntl(struct pt_regs *regs)
 {
 	printk("[%s:%d] Wheee.. irix_priocntl()\n",
-	       current->comm, current->pid);
+	       current->comm, task_pid(current));
 
 	return -EINVAL;
 }
@@ -1465,7 +1465,7 @@ asmlinkage int irix_priocntl(struct pt_r
 asmlinkage int irix_sigqueue(int pid, int sig, int code, int val)
 {
 	printk("[%s:%d] Wheee.. irix_sigqueue(%d,%d,%d,%d)\n",
-	       current->comm, current->pid, pid, sig, code, val);
+	       current->comm, task_pid(current), pid, sig, code, val);
 
 	return -EINVAL;
 }
@@ -1568,7 +1568,7 @@ asmlinkage int irix_mmap64(struct pt_reg
 asmlinkage int irix_dmi(struct pt_regs *regs)
 {
 	printk("[%s:%d] Wheee.. irix_dmi()\n",
-	       current->comm, current->pid);
+	       current->comm, task_pid(current));
 
 	return -EINVAL;
 }
@@ -1577,7 +1577,7 @@ asmlinkage int irix_pread(int fd, char _
 			  int off1, int off2)
 {
 	printk("[%s:%d] Wheee.. irix_pread(%d,%p,%d,%d,%d,%d)\n",
-	       current->comm, current->pid, fd, buf, cnt, off64, off1, off2);
+	       current->comm, task_pid(current), fd, buf, cnt, off64, off1, off2);
 
 	return -EINVAL;
 }
@@ -1586,7 +1586,7 @@ asmlinkage int irix_pwrite(int fd, char 
 			   int off1, int off2)
 {
 	printk("[%s:%d] Wheee.. irix_pwrite(%d,%p,%d,%d,%d,%d)\n",
-	       current->comm, current->pid, fd, buf, cnt, off64, off1, off2);
+	       current->comm, task_pid(current), fd, buf, cnt, off64, off1, off2);
 
 	return -EINVAL;
 }
@@ -1597,7 +1597,7 @@ asmlinkage int irix_sgifastpath(int cmd,
 {
 	printk("[%s:%d] Wheee.. irix_fastpath(%d,%08lx,%08lx,%08lx,%08lx,"
 	       "%08lx,%08lx)\n",
-	       current->comm, current->pid, cmd, arg0, arg1, arg2,
+	       current->comm, task_pid(current), cmd, arg0, arg1, arg2,
 	       arg3, arg4, arg5);
 
 	return -EINVAL;
@@ -1621,7 +1621,7 @@ asmlinkage int irix_statvfs64(char __use
 	int error, i;
 
 	printk("[%s:%d] Wheee.. irix_statvfs64(%s,%p)\n",
-	       current->comm, current->pid, fname, buf);
+	       current->comm, task_pid(current), fname, buf);
 	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs64))) {
 		error = -EFAULT;
 		goto out;
@@ -1667,7 +1667,7 @@ asmlinkage int irix_fstatvfs64(int fd, s
 	int error, i;
 
 	printk("[%s:%d] Wheee.. irix_fstatvfs64(%d,%p)\n",
-	       current->comm, current->pid, fd, buf);
+	       current->comm, task_pid(current), fd, buf);
 
 	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs))) {
 		error = -EFAULT;
@@ -1711,7 +1711,7 @@ asmlinkage int irix_getmountid(char __us
 	int err;
 
 	printk("[%s:%d] irix_getmountid(%s, %p)\n",
-	       current->comm, current->pid, fname, midbuf);
+	       current->comm, task_pid(current), fname, midbuf);
 	if (!access_ok(VERIFY_WRITE, midbuf, (sizeof(unsigned long) * 4)))
 		return -EFAULT;
 
@@ -1733,7 +1733,7 @@ asmlinkage int irix_nsproc(unsigned long
 			   unsigned long arg, unsigned long sp, int slen)
 {
 	printk("[%s:%d] Wheee.. irix_nsproc(%08lx,%08lx,%08lx,%08lx,%d)\n",
-	       current->comm, current->pid, entry, mask, arg, sp, slen);
+	       current->comm, task_pid(current), entry, mask, arg, sp, slen);
 
 	return -EINVAL;
 }
@@ -1799,7 +1799,7 @@ asmlinkage int irix_ngetdents(unsigned i
 
 #ifdef DEBUG_GETDENTS
 	printk("[%s:%d] ngetdents(%d, %p, %d, %p) ", current->comm,
-	       current->pid, fd, dirent, count, eob);
+	       task_pid(current), fd, dirent, count, eob);
 #endif
 	error = -EBADF;
 	file = fget(fd);
@@ -1898,7 +1898,7 @@ asmlinkage int irix_getdents64(int fd, v
 
 #ifdef DEBUG_GETDENTS
 	printk("[%s:%d] getdents64(%d, %p, %d) ", current->comm,
-	       current->pid, fd, dirent, cnt);
+	       task_pid(current), fd, dirent, cnt);
 #endif
 	error = -EBADF;
 	if (!(file = fget(fd)))
@@ -1946,7 +1946,7 @@ asmlinkage int irix_ngetdents64(int fd, 
 
 #ifdef DEBUG_GETDENTS
 	printk("[%s:%d] ngetdents64(%d, %p, %d) ", current->comm,
-	       current->pid, fd, dirent, cnt);
+	       task_pid(current), fd, dirent, cnt);
 #endif
 	error = -EBADF;
 	if (!(file = fget(fd)))
@@ -1995,41 +1995,41 @@ asmlinkage int irix_uadmin(unsigned long
 	case 1:
 		/* Reboot */
 		printk("[%s:%d] irix_uadmin: Wants to reboot...\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 2:
 		/* Shutdown */
 		printk("[%s:%d] irix_uadmin: Wants to shutdown...\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 4:
 		/* Remount-root */
 		printk("[%s:%d] irix_uadmin: Wants to remount root...\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 8:
 		/* Kill all tasks. */
 		printk("[%s:%d] irix_uadmin: Wants to kill all tasks...\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 256:
 		/* Set magic mushrooms... */
 		printk("[%s:%d] irix_uadmin: Wants to set magic mushroom[%d]...\n",
-		       current->comm, current->pid, (int) func);
+		       current->comm, task_pid(current), (int) func);
 		retval = -EINVAL;
 		goto out;
 
 	default:
 		printk("[%s:%d] irix_uadmin: Unknown operation [%d]...\n",
-		       current->comm, current->pid, (int) op);
+		       current->comm, task_pid(current), (int) op);
 		retval = -EINVAL;
 		goto out;
 	};
@@ -2051,20 +2051,20 @@ asmlinkage int irix_utssys(char __user *
 	case 2:
 		/* ustat() */
 		printk("[%s:%d] irix_utssys: Wants to do ustat()\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 3:
 		/* fusers() */
 		printk("[%s:%d] irix_utssys: Wants to do fusers()\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	default:
 		printk("[%s:%d] irix_utssys: Wants to do unknown type[%d]\n",
-		       current->comm, current->pid, (int) type);
+		       current->comm, task_pid(current), (int) type);
 		retval = -EINVAL;
 		goto out;
 	}
@@ -2083,7 +2083,7 @@ asmlinkage int irix_fcntl(int fd, int cm
 
 #ifdef DEBUG_FCNTL
 	printk("[%s:%d] irix_fcntl(%d, %d, %d) ", current->comm,
-	       current->pid, fd, cmd, arg);
+	       task_pid(current), fd, cmd, arg);
 #endif
 	if (cmd == IRIX_F_ALLOCSP){
 		return 0;
@@ -2102,26 +2102,26 @@ asmlinkage int irix_ulimit(int cmd, int 
 	switch(cmd) {
 	case 1:
 		printk("[%s:%d] irix_ulimit: Wants to get file size limit.\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 2:
 		printk("[%s:%d] irix_ulimit: Wants to set file size limit.\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 3:
 		printk("[%s:%d] irix_ulimit: Wants to get brk limit.\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	case 4:
 #if 0
 		printk("[%s:%d] irix_ulimit: Wants to get fd limit.\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 #endif
@@ -2130,13 +2130,13 @@ asmlinkage int irix_ulimit(int cmd, int 
 
 	case 5:
 		printk("[%s:%d] irix_ulimit: Wants to get txt offset.\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		retval = -EINVAL;
 		goto out;
 
 	default:
 		printk("[%s:%d] irix_ulimit: Unknown command [%d].\n",
-		       current->comm, current->pid, cmd);
+		       current->comm, task_pid(current), cmd);
 		retval = -EINVAL;
 		goto out;
 	}
@@ -2147,7 +2147,7 @@ out:
 asmlinkage int irix_unimp(struct pt_regs *regs)
 {
 	printk("irix_unimp [%s:%d] v0=%d v1=%d a0=%08lx a1=%08lx a2=%08lx "
-	       "a3=%08lx\n", current->comm, current->pid,
+	       "a3=%08lx\n", current->comm, task_pid(current),
 	       (int) regs->regs[2], (int) regs->regs[3],
 	       regs->regs[4], regs->regs[5], regs->regs[6], regs->regs[7]);
 
Index: linux-2.6.15-rc1/arch/mips/kernel/time.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/time.c
+++ linux-2.6.15-rc1/arch/mips/kernel/time.c
@@ -409,7 +409,7 @@ static long last_rtc_update;
  */
 void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	if (current->pid)
+	if (task_pid(current))
 		profile_tick(CPU_PROFILING, regs);
 	update_process_times(user_mode(regs));
 }
Index: linux-2.6.15-rc1/arch/mips/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/kernel/traps.c
+++ linux-2.6.15-rc1/arch/mips/kernel/traps.c
@@ -267,7 +267,7 @@ void show_registers(struct pt_regs *regs
 	show_regs(regs);
 	print_modules();
 	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
-	        current->comm, current->pid, current_thread_info(), current);
+	        current->comm, task_pid(current), current_thread_info(), current);
 	show_stack(current, (long *) regs->regs[29]);
 	show_trace(current, (long *) regs->regs[29]);
 	show_code((unsigned int *) regs->cp0_epc);
Index: linux-2.6.15-rc1/arch/mips/mm/fault.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/mips/mm/fault.c
+++ linux-2.6.15-rc1/arch/mips/mm/fault.c
@@ -43,7 +43,7 @@ asmlinkage void do_page_fault(struct pt_
 
 #if 0
 	printk("Cpu%d[%s:%d:%0*lx:%ld:%0*lx]\n", smp_processor_id(),
-	       current->comm, current->pid, field, address, write,
+	       current->comm, task_pid(current), field, address, write,
 	       field, regs->cp0_epc);
 #endif
 
@@ -172,7 +172,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (task_pid(tsk) == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;

--

