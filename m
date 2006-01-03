Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWACVOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWACVOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWACVN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:13:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24463 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932571AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 05/50] amd64: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PM-6N@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/x86_64/kernel/i387.c    |    2 +-
 arch/x86_64/kernel/i8259.c   |    2 +-
 arch/x86_64/kernel/process.c |    2 +-
 arch/x86_64/kernel/smpboot.c |    2 +-
 arch/x86_64/kernel/traps.c   |    4 ++--
 include/asm-x86_64/i387.h    |    8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

76a5747f473913b4f63206d46410dda234b2d8b9
diff --git a/arch/x86_64/kernel/i387.c b/arch/x86_64/kernel/i387.c
index d9b22b6..a5d7e16 100644
--- a/arch/x86_64/kernel/i387.c
+++ b/arch/x86_64/kernel/i387.c
@@ -95,7 +95,7 @@ int save_i387(struct _fpstate __user *bu
 	if (!used_math())
 		return 0;
 	clear_used_math(); /* trigger finit */
-	if (tsk->thread_info->status & TS_USEDFPU) {
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {
 		err = save_i387_checking((struct i387_fxsave_struct __user *)buf);
 		if (err) return err;
 		stts();
diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
index 6e5101a..d7123b0 100644
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -133,7 +133,7 @@ static void end_8259A_irq (unsigned int 
 {
 	if (irq > 256) { 
 		char var;
-		printk("return %p stack %p ti %p\n", __builtin_return_address(0), &var, current->thread_info); 
+		printk("return %p stack %p ti %p\n", __builtin_return_address(0), &var, task_thread_info(current)); 
 
 		BUG(); 
 	}
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 7519fc5..d0cfcc2 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -435,7 +435,7 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.rsp0 = (unsigned long) (childregs+1);
 	p->thread.userrsp = me->thread.userrsp; 
 
-	set_ti_thread_flag(p->thread_info, TIF_FORK);
+	set_tsk_thread_flag(p, TIF_FORK);
 
 	p->thread.fs = me->thread.fs;
 	p->thread.gs = me->thread.gs;
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index ecbd7b8..e92eec2 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -785,7 +785,7 @@ do_rest:
 	init_rsp = c_idle.idle->thread.rsp;
 	per_cpu(init_tss,cpu).rsp0 = init_rsp;
 	initial_code = start_secondary;
-	clear_ti_thread_flag(c_idle.idle->thread_info, TIF_FORK);
+	clear_tsk_thread_flag(c_idle.idle, TIF_FORK);
 
 	printk(KERN_INFO "Booting processor %d/%d APIC 0x%x\n", cpu,
 		cpus_weight(cpu_present_map),
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index bf337f4..96a56c0 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -282,7 +282,7 @@ void show_registers(struct pt_regs *regs
 	printk("CPU %d ", cpu);
 	__show_regs(regs);
 	printk("Process %s (pid: %d, threadinfo %p, task %p)\n",
-		cur->comm, cur->pid, cur->thread_info, cur);
+		cur->comm, cur->pid, task_thread_info(cur), cur);
 
 	/*
 	 * When in-kernel, we also print out the stack and code at the
@@ -867,7 +867,7 @@ asmlinkage void math_state_restore(void)
 	if (!used_math())
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
-	me->thread_info->status |= TS_USEDFPU;
+	task_thread_info(me)->status |= TS_USEDFPU;
 }
 
 void do_call_debug(struct pt_regs *regs) 
diff --git a/include/asm-x86_64/i387.h b/include/asm-x86_64/i387.h
index aa39cfd..2cd852e 100644
--- a/include/asm-x86_64/i387.h
+++ b/include/asm-x86_64/i387.h
@@ -30,7 +30,7 @@ extern int save_i387(struct _fpstate __u
  */
 
 #define unlazy_fpu(tsk) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) \
+	if (task_thread_info(tsk)->status & TS_USEDFPU) \
 		save_init_fpu(tsk); \
 } while (0)
 
@@ -46,9 +46,9 @@ static inline void tolerant_fwait(void)
 }
 
 #define clear_fpu(tsk) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {	\
 		tolerant_fwait();				\
-		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
+		task_thread_info(tsk)->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
@@ -135,7 +135,7 @@ static inline void save_init_fpu( struct
 {
 	asm volatile( "rex64 ; fxsave %0 ; fnclex"
 		      : "=m" (tsk->thread.i387.fxsave));
-	tsk->thread_info->status &= ~TS_USEDFPU;
+	task_thread_info(tsk)->status &= ~TS_USEDFPU;
 	stts();
 }
 
-- 
0.99.9.GIT

