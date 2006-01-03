Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWACVMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWACVMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWACVHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46991 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932545AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 45/50] ia64: task_pt_regs()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNb-0008SZ-C8@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/ia64/ia32/elfcore32.h    |    3 +--
 arch/ia64/ia32/ia32_signal.c  |    4 ++--
 arch/ia64/ia32/ia32_support.c |    4 ++--
 arch/ia64/ia32/sys_ia32.c     |   12 ++++++------
 arch/ia64/kernel/perfmon.c    |   32 ++++++++++++++++----------------
 arch/ia64/kernel/process.c    |   12 ++++++------
 arch/ia64/kernel/ptrace.c     |   24 ++++++++++++------------
 arch/ia64/kernel/setup.c      |    2 +-
 arch/ia64/kernel/sys_ia64.c   |    2 +-
 drivers/input/evdev.c         |    2 +-
 include/asm-ia64/compat.h     |    2 +-
 include/asm-ia64/processor.h  |    2 +-
 include/asm-ia64/ptrace.h     |    4 ++--
 include/asm-ia64/system.h     |    8 ++++----
 14 files changed, 56 insertions(+), 57 deletions(-)

769c717f43c54cbf74712b31d57e808f412ccd55
diff --git a/arch/ia64/ia32/elfcore32.h b/arch/ia64/ia32/elfcore32.h
index b73b8b6..a47f63b 100644
--- a/arch/ia64/ia32/elfcore32.h
+++ b/arch/ia64/ia32/elfcore32.h
@@ -95,8 +95,7 @@ static inline void elf_core_copy_regs(el
 static inline int elf_core_copy_task_regs(struct task_struct *t,
 					  elf_gregset_t* elfregs)
 {
-	struct pt_regs *pp = ia64_task_regs(t);
-	ELF_CORE_COPY_REGS((*elfregs), pp);
+	ELF_CORE_COPY_REGS((*elfregs), task_pt_regs(t));
 	return 1;
 }
 
diff --git a/arch/ia64/ia32/ia32_signal.c b/arch/ia64/ia32/ia32_signal.c
index aa891c9..5856510 100644
--- a/arch/ia64/ia32/ia32_signal.c
+++ b/arch/ia64/ia32/ia32_signal.c
@@ -255,7 +255,7 @@ save_ia32_fpstate_live (struct _fpstate_
 	 */
 	fp_tos = (fsr>>11)&0x7;
 	fr8_st_map = (8-fp_tos)&0x7;
-	ptp = ia64_task_regs(tsk);
+	ptp = task_pt_regs(tsk);
 	fpregp = (struct _fpreg_ia32 *)(((unsigned long)buf + 15) & ~15);
 	ia64f2ia32f(fpregp, &ptp->f8);
 	copy_to_user(&save->_st[(0+fr8_st_map)&0x7], fpregp, sizeof(struct _fpreg_ia32));
@@ -389,7 +389,7 @@ restore_ia32_fpstate_live (struct _fpsta
 	fr8_st_map = (8-fp_tos)&0x7;
 	fpregp = (struct _fpreg_ia32 *)(((unsigned long)buf + 15) & ~15);
 
-	ptp = ia64_task_regs(tsk);
+	ptp = task_pt_regs(tsk);
 	copy_from_user(fpregp, &save->_st[(0+fr8_st_map)&0x7], sizeof(struct _fpreg_ia32));
 	ia32f2ia64f(&ptp->f8, fpregp);
 	copy_from_user(fpregp, &save->_st[(1+fr8_st_map)&0x7], sizeof(struct _fpreg_ia32));
diff --git a/arch/ia64/ia32/ia32_support.c b/arch/ia64/ia32/ia32_support.c
index 4f63004..c187743 100644
--- a/arch/ia64/ia32/ia32_support.c
+++ b/arch/ia64/ia32/ia32_support.c
@@ -58,7 +58,7 @@ load_desc (u16 selector)
 void
 ia32_load_segment_descriptors (struct task_struct *task)
 {
-	struct pt_regs *regs = ia64_task_regs(task);
+	struct pt_regs *regs = task_pt_regs(task);
 
 	/* Setup the segment descriptors */
 	regs->r24 = load_desc(regs->r16 >> 16);		/* ESD */
@@ -113,7 +113,7 @@ void
 ia32_load_state (struct task_struct *t)
 {
 	unsigned long eflag, fsr, fcr, fir, fdr, tssd;
-	struct pt_regs *regs = ia64_task_regs(t);
+	struct pt_regs *regs = task_pt_regs(t);
 
 	eflag = t->thread.eflag;
 	fsr = t->thread.fsr;
diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index dc28271..5a46213 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -1481,7 +1481,7 @@ getreg (struct task_struct *child, int r
 {
 	struct pt_regs *child_regs;
 
-	child_regs = ia64_task_regs(child);
+	child_regs = task_pt_regs(child);
 	switch (regno / sizeof(int)) {
 	      case PT_EBX: return child_regs->r11;
 	      case PT_ECX: return child_regs->r9;
@@ -1509,7 +1509,7 @@ putreg (struct task_struct *child, int r
 {
 	struct pt_regs *child_regs;
 
-	child_regs = ia64_task_regs(child);
+	child_regs = task_pt_regs(child);
 	switch (regno / sizeof(int)) {
 	      case PT_EBX: child_regs->r11 = value; break;
 	      case PT_ECX: child_regs->r9 = value; break;
@@ -1625,7 +1625,7 @@ save_ia32_fpstate (struct task_struct *t
 	 *  Stack frames start with 16-bytes of temp space
 	 */
 	swp = (struct switch_stack *)(tsk->thread.ksp + 16);
-	ptp = ia64_task_regs(tsk);
+	ptp = task_pt_regs(tsk);
 	tos = (tsk->thread.fsr >> 11) & 7;
 	for (i = 0; i < 8; i++)
 		put_fpreg(i, &save->st_space[i], ptp, swp, tos);
@@ -1658,7 +1658,7 @@ restore_ia32_fpstate (struct task_struct
 	 *  Stack frames start with 16-bytes of temp space
 	 */
 	swp = (struct switch_stack *)(tsk->thread.ksp + 16);
-	ptp = ia64_task_regs(tsk);
+	ptp = task_pt_regs(tsk);
 	tos = (tsk->thread.fsr >> 11) & 7;
 	for (i = 0; i < 8; i++)
 		get_fpreg(i, &save->st_space[i], ptp, swp, tos);
@@ -1689,7 +1689,7 @@ save_ia32_fpxstate (struct task_struct *
          *  Stack frames start with 16-bytes of temp space
          */
         swp = (struct switch_stack *)(tsk->thread.ksp + 16);
-        ptp = ia64_task_regs(tsk);
+        ptp = task_pt_regs(tsk);
 	tos = (tsk->thread.fsr >> 11) & 7;
         for (i = 0; i < 8; i++)
 		put_fpreg(i, (struct _fpreg_ia32 __user *)&save->st_space[4*i], ptp, swp, tos);
@@ -1733,7 +1733,7 @@ restore_ia32_fpxstate (struct task_struc
 	 *  Stack frames start with 16-bytes of temp space
 	 */
 	swp = (struct switch_stack *)(tsk->thread.ksp + 16);
-	ptp = ia64_task_regs(tsk);
+	ptp = task_pt_regs(tsk);
 	tos = (tsk->thread.fsr >> 11) & 7;
 	for (i = 0; i < 8; i++)
 	get_fpreg(i, (struct _fpreg_ia32 __user *)&save->st_space[4*i], ptp, swp, tos);
diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 410d480..a3f9e79 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -1709,7 +1709,7 @@ static void
 pfm_syswide_force_stop(void *info)
 {
 	pfm_context_t   *ctx = (pfm_context_t *)info;
-	struct pt_regs *regs = ia64_task_regs(current);
+	struct pt_regs *regs = task_pt_regs(current);
 	struct task_struct *owner;
 	unsigned long flags;
 	int ret;
@@ -1814,7 +1814,7 @@ pfm_flush(struct file *filp)
 	is_system = ctx->ctx_fl_system;
 
 	task = PFM_CTX_TASK(ctx);
-	regs = ia64_task_regs(task);
+	regs = task_pt_regs(task);
 
 	DPRINT(("ctx_state=%d is_current=%d\n",
 		state,
@@ -1944,7 +1944,7 @@ pfm_close(struct inode *inode, struct fi
 	is_system = ctx->ctx_fl_system;
 
 	task = PFM_CTX_TASK(ctx);
-	regs = ia64_task_regs(task);
+	regs = task_pt_regs(task);
 
 	DPRINT(("ctx_state=%d is_current=%d\n", 
 		state,
@@ -4051,7 +4051,7 @@ pfm_stop(pfm_context_t *ctx, void *arg, 
 	 	 */
 		ia64_psr(regs)->up = 0;
 	} else {
-		tregs = ia64_task_regs(task);
+		tregs = task_pt_regs(task);
 
 		/*
 	 	 * stop monitoring at the user level
@@ -4133,7 +4133,7 @@ pfm_start(pfm_context_t *ctx, void *arg,
 		ia64_psr(regs)->up = 1;
 
 	} else {
-		tregs = ia64_task_regs(ctx->ctx_task);
+		tregs = task_pt_regs(ctx->ctx_task);
 
 		/*
 		 * start monitoring at the kernel level the next
@@ -4403,7 +4403,7 @@ pfm_context_load(pfm_context_t *ctx, voi
 		/*
 		 * when not current, task MUST be stopped, so this is safe
 		 */
-		regs = ia64_task_regs(task);
+		regs = task_pt_regs(task);
 
 		/* force a full reload */
 		ctx->ctx_last_activation = PFM_INVALID_ACTIVATION;
@@ -4529,7 +4529,7 @@ pfm_context_unload(pfm_context_t *ctx, v
 	/*
 	 * per-task mode
 	 */
-	tregs = task == current ? regs : ia64_task_regs(task);
+	tregs = task == current ? regs : task_pt_regs(task);
 
 	if (task == current) {
 		/*
@@ -4592,7 +4592,7 @@ pfm_exit_thread(struct task_struct *task
 {
 	pfm_context_t *ctx;
 	unsigned long flags;
-	struct pt_regs *regs = ia64_task_regs(task);
+	struct pt_regs *regs = task_pt_regs(task);
 	int ret, state;
 	int free_ok = 0;
 
@@ -4925,7 +4925,7 @@ restart_args:
 	if (unlikely(ret)) goto abort_locked;
 
 skip_fd:
-	ret = (*func)(ctx, args_k, count, ia64_task_regs(current));
+	ret = (*func)(ctx, args_k, count, task_pt_regs(current));
 
 	call_made = 1;
 
@@ -5049,7 +5049,7 @@ pfm_handle_work(void)
 
 	pfm_clear_task_notify();
 
-	regs = ia64_task_regs(current);
+	regs = task_pt_regs(current);
 
 	/*
 	 * extract reason for being here and clear
@@ -5793,7 +5793,7 @@ pfm_syst_wide_update_task(struct task_st
 	 * on every CPU, so we can rely on the pid to identify the idle task.
 	 */
 	if ((info & PFM_CPUINFO_EXCL_IDLE) == 0 || task->pid) {
-		regs = ia64_task_regs(task);
+		regs = task_pt_regs(task);
 		ia64_psr(regs)->pp = is_ctxswin ? dcr_pp : 0;
 		return;
 	}
@@ -5876,7 +5876,7 @@ pfm_save_regs(struct task_struct *task)
 	flags = pfm_protect_ctx_ctxsw(ctx);
 
 	if (ctx->ctx_state == PFM_CTX_ZOMBIE) {
-		struct pt_regs *regs = ia64_task_regs(task);
+		struct pt_regs *regs = task_pt_regs(task);
 
 		pfm_clear_psr_up();
 
@@ -6076,7 +6076,7 @@ pfm_load_regs (struct task_struct *task)
 	BUG_ON(psr & IA64_PSR_I);
 
 	if (unlikely(ctx->ctx_state == PFM_CTX_ZOMBIE)) {
-		struct pt_regs *regs = ia64_task_regs(task);
+		struct pt_regs *regs = task_pt_regs(task);
 
 		BUG_ON(ctx->ctx_smpl_hdr);
 
@@ -6445,7 +6445,7 @@ pfm_alt_save_pmu_state(void *data)
 {
 	struct pt_regs *regs;
 
-	regs = ia64_task_regs(current);
+	regs = task_pt_regs(current);
 
 	DPRINT(("called\n"));
 
@@ -6471,7 +6471,7 @@ pfm_alt_restore_pmu_state(void *data)
 {
 	struct pt_regs *regs;
 
-	regs = ia64_task_regs(current);
+	regs = task_pt_regs(current);
 
 	DPRINT(("called\n"));
 
@@ -6753,7 +6753,7 @@ dump_pmu_state(const char *from)
 	local_irq_save(flags);
 
 	this_cpu = smp_processor_id();
-	regs     = ia64_task_regs(current);
+	regs     = task_pt_regs(current);
 	info     = PFM_CPUINFO_GET();
 	dcr      = ia64_getreg(_IA64_REG_CR_DCR);
 
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index e9904c7..309d596 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -328,7 +328,7 @@ ia64_save_extra (struct task_struct *tas
 #endif
 
 #ifdef CONFIG_IA32_SUPPORT
-	if (IS_IA32_PROCESS(ia64_task_regs(task)))
+	if (IS_IA32_PROCESS(task_pt_regs(task)))
 		ia32_save_state(task);
 #endif
 }
@@ -353,7 +353,7 @@ ia64_load_extra (struct task_struct *tas
 #endif
 
 #ifdef CONFIG_IA32_SUPPORT
-	if (IS_IA32_PROCESS(ia64_task_regs(task)))
+	if (IS_IA32_PROCESS(task_pt_regs(task)))
 		ia32_load_state(task);
 #endif
 }
@@ -488,7 +488,7 @@ copy_thread (int nr, unsigned long clone
 	 * If we're cloning an IA32 task then save the IA32 extra
 	 * state from the current task to the new task
 	 */
-	if (IS_IA32_PROCESS(ia64_task_regs(current))) {
+	if (IS_IA32_PROCESS(task_pt_regs(current))) {
 		ia32_save_state(p);
 		if (clone_flags & CLONE_SETTLS)
 			retval = ia32_clone_tls(p, child_ptregs);
@@ -701,7 +701,7 @@ int
 kernel_thread_helper (int (*fn)(void *), void *arg)
 {
 #ifdef CONFIG_IA32_SUPPORT
-	if (IS_IA32_PROCESS(ia64_task_regs(current))) {
+	if (IS_IA32_PROCESS(task_pt_regs(current))) {
 		/* A kernel thread is always a 64-bit process. */
 		current->thread.map_base  = DEFAULT_MAP_BASE;
 		current->thread.task_size = DEFAULT_TASK_SIZE;
@@ -722,7 +722,7 @@ flush_thread (void)
 	current->thread.flags &= ~(IA64_THREAD_FPH_VALID | IA64_THREAD_DBG_VALID);
 	ia64_drop_fpu(current);
 #ifdef CONFIG_IA32_SUPPORT
-	if (IS_IA32_PROCESS(ia64_task_regs(current))) {
+	if (IS_IA32_PROCESS(task_pt_regs(current))) {
 		ia32_drop_partial_page_list(current);
 		current->thread.task_size = IA32_PAGE_OFFSET;
 		set_fs(USER_DS);
@@ -755,7 +755,7 @@ exit_thread (void)
 	if (current->thread.flags & IA64_THREAD_DBG_VALID)
 		pfm_release_debug_registers(current);
 #endif
-	if (IS_IA32_PROCESS(ia64_task_regs(current)))
+	if (IS_IA32_PROCESS(task_pt_regs(current)))
 		ia32_drop_partial_page_list(current);
 }
 
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 4b19d04..c6f98e2 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -254,7 +254,7 @@ get_rnat (struct task_struct *task, stru
 	long num_regs, nbits;
 	struct pt_regs *pt;
 
-	pt = ia64_task_regs(task);
+	pt = task_pt_regs(task);
 	kbsp = (unsigned long *) sw->ar_bspstore;
 	ubspstore = (unsigned long *) pt->ar_bspstore;
 
@@ -314,7 +314,7 @@ put_rnat (struct task_struct *task, stru
 	struct pt_regs *pt;
 	unsigned long cfm, *urbs_kargs;
 
-	pt = ia64_task_regs(task);
+	pt = task_pt_regs(task);
 	kbsp = (unsigned long *) sw->ar_bspstore;
 	ubspstore = (unsigned long *) pt->ar_bspstore;
 
@@ -407,7 +407,7 @@ ia64_peek (struct task_struct *child, st
 
 	urbs_end = (long *) user_rbs_end;
 	laddr = (unsigned long *) addr;
-	child_regs = ia64_task_regs(child);
+	child_regs = task_pt_regs(child);
 	bspstore = (unsigned long *) child_regs->ar_bspstore;
 	krbs = (unsigned long *) child + IA64_RBS_OFFSET/8;
 	if (on_kernel_rbs(addr, (unsigned long) bspstore,
@@ -467,7 +467,7 @@ ia64_poke (struct task_struct *child, st
 	struct pt_regs *child_regs;
 
 	laddr = (unsigned long *) addr;
-	child_regs = ia64_task_regs(child);
+	child_regs = task_pt_regs(child);
 	bspstore = (unsigned long *) child_regs->ar_bspstore;
 	krbs = (unsigned long *) child + IA64_RBS_OFFSET/8;
 	if (on_kernel_rbs(addr, (unsigned long) bspstore,
@@ -567,7 +567,7 @@ thread_matches (struct task_struct *thre
 		 */
 		return 0;
 
-	thread_regs = ia64_task_regs(thread);
+	thread_regs = task_pt_regs(thread);
 	thread_rbs_end = ia64_get_user_rbs_end(thread, thread_regs, NULL);
 	if (!on_kernel_rbs(addr, thread_regs->ar_bspstore, thread_rbs_end))
 		return 0;
@@ -627,7 +627,7 @@ find_thread_for_addr (struct task_struct
 inline void
 ia64_flush_fph (struct task_struct *task)
 {
-	struct ia64_psr *psr = ia64_psr(ia64_task_regs(task));
+	struct ia64_psr *psr = ia64_psr(task_pt_regs(task));
 
 	/*
 	 * Prevent migrating this task while
@@ -653,7 +653,7 @@ ia64_flush_fph (struct task_struct *task
 void
 ia64_sync_fph (struct task_struct *task)
 {
-	struct ia64_psr *psr = ia64_psr(ia64_task_regs(task));
+	struct ia64_psr *psr = ia64_psr(task_pt_regs(task));
 
 	ia64_flush_fph(task);
 	if (!(task->thread.flags & IA64_THREAD_FPH_VALID)) {
@@ -794,7 +794,7 @@ access_uarea (struct task_struct *child,
 					  + offsetof(struct pt_regs, reg)))
 
 
-	pt = ia64_task_regs(child);
+	pt = task_pt_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
 
 	if ((addr & 0x7) != 0) {
@@ -1120,7 +1120,7 @@ ptrace_getregs (struct task_struct *chil
 	if (!access_ok(VERIFY_WRITE, ppr, sizeof(struct pt_all_user_regs)))
 		return -EIO;
 
-	pt = ia64_task_regs(child);
+	pt = task_pt_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
 	unw_init_from_blocked_task(&info, child);
 	if (unw_unwind_to_user(&info) < 0) {
@@ -1265,7 +1265,7 @@ ptrace_setregs (struct task_struct *chil
 	if (!access_ok(VERIFY_READ, ppr, sizeof(struct pt_all_user_regs)))
 		return -EIO;
 
-	pt = ia64_task_regs(child);
+	pt = task_pt_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
 	unw_init_from_blocked_task(&info, child);
 	if (unw_unwind_to_user(&info) < 0) {
@@ -1403,7 +1403,7 @@ ptrace_setregs (struct task_struct *chil
 void
 ptrace_disable (struct task_struct *child)
 {
-	struct ia64_psr *child_psr = ia64_psr(ia64_task_regs(child));
+	struct ia64_psr *child_psr = ia64_psr(task_pt_regs(child));
 
 	/* make sure the single step/taken-branch trap bits are not set: */
 	child_psr->ss = 0;
@@ -1463,7 +1463,7 @@ sys_ptrace (long request, pid_t pid, uns
 	if (ret < 0)
 		goto out_tsk;
 
-	pt = ia64_task_regs(child);
+	pt = task_pt_regs(child);
 	sw = (struct switch_stack *) (child->thread.ksp + 16);
 
 	switch (request) {
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5add0bc..acf87c6 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -788,7 +788,7 @@ cpu_init (void)
 #endif
 
 	/* Clear the stack memory reserved for pt_regs: */
-	memset(ia64_task_regs(current), 0, sizeof(struct pt_regs));
+	memset(task_pt_regs(current), 0, sizeof(struct pt_regs));
 
 	ia64_set_kr(IA64_KR_FPU_OWNER, 0);
 
diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index f2dbcd1..c7b943f 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -151,7 +151,7 @@ out:
 asmlinkage long
 sys_pipe (void)
 {
-	struct pt_regs *regs = ia64_task_regs(current);
+	struct pt_regs *regs = task_pt_regs(current);
 	int fd[2];
 	int retval;
 
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 9f2352b..f5a9305 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -156,7 +156,7 @@ struct input_event_compat {
 #ifdef CONFIG_X86_64
 #  define COMPAT_TEST test_thread_flag(TIF_IA32)
 #elif defined(CONFIG_IA64)
-#  define COMPAT_TEST IS_IA32_PROCESS(ia64_task_regs(current))
+#  define COMPAT_TEST IS_IA32_PROCESS(task_pt_regs(current))
 #elif defined(CONFIG_ARCH_S390)
 #  define COMPAT_TEST test_thread_flag(TIF_31BIT)
 #elif defined(CONFIG_MIPS)
diff --git a/include/asm-ia64/compat.h b/include/asm-ia64/compat.h
index aaf11f4..c0b1910 100644
--- a/include/asm-ia64/compat.h
+++ b/include/asm-ia64/compat.h
@@ -192,7 +192,7 @@ compat_ptr (compat_uptr_t uptr)
 static __inline__ void __user *
 compat_alloc_user_space (long len)
 {
-	struct pt_regs *regs = ia64_task_regs(current);
+	struct pt_regs *regs = task_pt_regs(current);
 	return (void __user *) (((regs->r12 & 0xffffffff) & -16) - len);
 }
 
diff --git a/include/asm-ia64/processor.h b/include/asm-ia64/processor.h
index 94e07e7..8c648bf 100644
--- a/include/asm-ia64/processor.h
+++ b/include/asm-ia64/processor.h
@@ -352,7 +352,7 @@ extern unsigned long get_wchan (struct t
 /* Return instruction pointer of blocked task TSK.  */
 #define KSTK_EIP(tsk)					\
   ({							\
-	struct pt_regs *_regs = ia64_task_regs(tsk);	\
+	struct pt_regs *_regs = task_pt_regs(tsk);	\
 	_regs->cr_iip + ia64_psr(_regs)->ri;		\
   })
 
diff --git a/include/asm-ia64/ptrace.h b/include/asm-ia64/ptrace.h
index 2c703d6..9471cdc 100644
--- a/include/asm-ia64/ptrace.h
+++ b/include/asm-ia64/ptrace.h
@@ -248,7 +248,7 @@ struct switch_stack {
 })
 
   /* given a pointer to a task_struct, return the user's pt_regs */
-# define ia64_task_regs(t)		(((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)
+# define task_pt_regs(t)		(((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)
 # define ia64_psr(regs)			((struct ia64_psr *) &(regs)->cr_ipsr)
 # define user_mode(regs)		(((struct ia64_psr *) &(regs)->cr_ipsr)->cpl != 0)
 # define user_stack(task,regs)	((long) regs - (long) task == IA64_STK_OFFSET - sizeof(*regs))
@@ -271,7 +271,7 @@ struct switch_stack {
    *
    * On ia64, we can clear the user's pt_regs->r8 to force a successful syscall.
    */
-# define force_successful_syscall_return()	(ia64_task_regs(current)->r8 = 0)
+# define force_successful_syscall_return()	(task_pt_regs(current)->r8 = 0)
 
   struct task_struct;			/* forward decl */
   struct unw_frame_info;		/* forward decl */
diff --git a/include/asm-ia64/system.h b/include/asm-ia64/system.h
index 635235f..b49d064 100644
--- a/include/asm-ia64/system.h
+++ b/include/asm-ia64/system.h
@@ -219,14 +219,14 @@ extern void ia64_load_extra (struct task
 
 #define IA64_HAS_EXTRA_STATE(t)							\
 	((t)->thread.flags & (IA64_THREAD_DBG_VALID|IA64_THREAD_PM_VALID)	\
-	 || IS_IA32_PROCESS(ia64_task_regs(t)) || PERFMON_IS_SYSWIDE())
+	 || IS_IA32_PROCESS(task_pt_regs(t)) || PERFMON_IS_SYSWIDE())
 
 #define __switch_to(prev,next,last) do {							 \
 	if (IA64_HAS_EXTRA_STATE(prev))								 \
 		ia64_save_extra(prev);								 \
 	if (IA64_HAS_EXTRA_STATE(next))								 \
 		ia64_load_extra(next);								 \
-	ia64_psr(ia64_task_regs(next))->dfh = !ia64_is_local_fpu_owner(next);			 \
+	ia64_psr(task_pt_regs(next))->dfh = !ia64_is_local_fpu_owner(next);			 \
 	(last) = ia64_switch_to((next));							 \
 } while (0)
 
@@ -238,8 +238,8 @@ extern void ia64_load_extra (struct task
  * the latest fph state from another CPU.  In other words: eager save, lazy restore.
  */
 # define switch_to(prev,next,last) do {						\
-	if (ia64_psr(ia64_task_regs(prev))->mfh && ia64_is_local_fpu_owner(prev)) {				\
-		ia64_psr(ia64_task_regs(prev))->mfh = 0;			\
+	if (ia64_psr(task_pt_regs(prev))->mfh && ia64_is_local_fpu_owner(prev)) {				\
+		ia64_psr(task_pt_regs(prev))->mfh = 0;			\
 		(prev)->thread.flags |= IA64_THREAD_FPH_VALID;			\
 		__ia64_save_fpu((prev)->thread.fph);				\
 	}									\
-- 
0.99.9.GIT

