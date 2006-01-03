Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWACVLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWACVLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWACVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23695 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932495AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 02/50] alpha: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PG-4F@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

use task_thread_info() for accesses to thread_info of task in arch/alpha
and include/asm-alpha

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/alpha/kernel/process.c     |    4 ++--
 arch/alpha/kernel/ptrace.c      |   38 +++++++++++++++++++-------------------
 arch/alpha/kernel/smp.c         |    2 +-
 include/asm-alpha/mmu_context.h |    6 +++---
 include/asm-alpha/processor.h   |    2 +-
 include/asm-alpha/system.h      |    8 ++++----
 6 files changed, 30 insertions(+), 30 deletions(-)

15a26083e587b713a99f9e0a8ebd36edd7319acf
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a868261..f15a456 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -488,7 +488,7 @@ unsigned long
 thread_saved_pc(task_t *t)
 {
 	unsigned long base = (unsigned long)t->thread_info;
-	unsigned long fp, sp = t->thread_info->pcb.ksp;
+	unsigned long fp, sp = task_thread_info(t)->pcb.ksp;
 
 	if (sp > base && sp+6*8 < base + 16*1024) {
 		fp = ((unsigned long*)sp)[6];
@@ -518,7 +518,7 @@ get_wchan(struct task_struct *p)
 
 	pc = thread_saved_pc(p);
 	if (in_sched_functions(pc)) {
-		schedule_frame = ((unsigned long *)p->thread_info->pcb.ksp)[6];
+		schedule_frame = ((unsigned long *)task_thread_info(p)->pcb.ksp)[6];
 		return ((unsigned long *)schedule_frame)[12];
 	}
 	return pc;
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index bbd3753..c83ce5d 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -103,9 +103,9 @@ get_reg_addr(struct task_struct * task, 
 	unsigned long *addr;
 
 	if (regno == 30) {
-		addr = &task->thread_info->pcb.usp;
+		addr = &task_thread_info(task)->pcb.usp;
 	} else if (regno == 65) {
-		addr = &task->thread_info->pcb.unique;
+		addr = &task_thread_info(task)->pcb.unique;
 	} else if (regno == 31 || regno > 65) {
 		zero = 0;
 		addr = &zero;
@@ -125,7 +125,7 @@ get_reg(struct task_struct * task, unsig
 	if (regno == 63) {
 		unsigned long fpcr = *get_reg_addr(task, regno);
 		unsigned long swcr
-		  = task->thread_info->ieee_state & IEEE_SW_MASK;
+		  = task_thread_info(task)->ieee_state & IEEE_SW_MASK;
 		swcr = swcr_update_status(swcr, fpcr);
 		return fpcr | swcr;
 	}
@@ -139,8 +139,8 @@ static int
 put_reg(struct task_struct *task, unsigned long regno, unsigned long data)
 {
 	if (regno == 63) {
-		task->thread_info->ieee_state
-		  = ((task->thread_info->ieee_state & ~IEEE_SW_MASK)
+		task_thread_info(task)->ieee_state
+		  = ((task_thread_info(task)->ieee_state & ~IEEE_SW_MASK)
 		     | (data & IEEE_SW_MASK));
 		data = (data & FPCR_DYN_MASK) | ieee_swcr_to_fpcr(data);
 	}
@@ -188,35 +188,35 @@ ptrace_set_bpt(struct task_struct * chil
 		 * branch (emulation can be tricky for fp branches).
 		 */
 		displ = ((s32)(insn << 11)) >> 9;
-		child->thread_info->bpt_addr[nsaved++] = pc + 4;
+		task_thread_info(child)->bpt_addr[nsaved++] = pc + 4;
 		if (displ)		/* guard against unoptimized code */
-			child->thread_info->bpt_addr[nsaved++]
+			task_thread_info(child)->bpt_addr[nsaved++]
 			  = pc + 4 + displ;
 		DBG(DBG_BPT, ("execing branch\n"));
 	} else if (op_code == 0x1a) {
 		reg_b = (insn >> 16) & 0x1f;
-		child->thread_info->bpt_addr[nsaved++] = get_reg(child, reg_b);
+		task_thread_info(child)->bpt_addr[nsaved++] = get_reg(child, reg_b);
 		DBG(DBG_BPT, ("execing jump\n"));
 	} else {
-		child->thread_info->bpt_addr[nsaved++] = pc + 4;
+		task_thread_info(child)->bpt_addr[nsaved++] = pc + 4;
 		DBG(DBG_BPT, ("execing normal insn\n"));
 	}
 
 	/* install breakpoints: */
 	for (i = 0; i < nsaved; ++i) {
-		res = read_int(child, child->thread_info->bpt_addr[i],
+		res = read_int(child, task_thread_info(child)->bpt_addr[i],
 			       (int *) &insn);
 		if (res < 0)
 			return res;
-		child->thread_info->bpt_insn[i] = insn;
+		task_thread_info(child)->bpt_insn[i] = insn;
 		DBG(DBG_BPT, ("    -> next_pc=%lx\n",
-			      child->thread_info->bpt_addr[i]));
-		res = write_int(child, child->thread_info->bpt_addr[i],
+			      task_thread_info(child)->bpt_addr[i]));
+		res = write_int(child, task_thread_info(child)->bpt_addr[i],
 				BREAKINST);
 		if (res < 0)
 			return res;
 	}
-	child->thread_info->bpt_nsaved = nsaved;
+	task_thread_info(child)->bpt_nsaved = nsaved;
 	return 0;
 }
 
@@ -227,9 +227,9 @@ ptrace_set_bpt(struct task_struct * chil
 int
 ptrace_cancel_bpt(struct task_struct * child)
 {
-	int i, nsaved = child->thread_info->bpt_nsaved;
+	int i, nsaved = task_thread_info(child)->bpt_nsaved;
 
-	child->thread_info->bpt_nsaved = 0;
+	task_thread_info(child)->bpt_nsaved = 0;
 
 	if (nsaved > 2) {
 		printk("ptrace_cancel_bpt: bogus nsaved: %d!\n", nsaved);
@@ -237,8 +237,8 @@ ptrace_cancel_bpt(struct task_struct * c
 	}
 
 	for (i = 0; i < nsaved; ++i) {
-		write_int(child, child->thread_info->bpt_addr[i],
-			  child->thread_info->bpt_insn[i]);
+		write_int(child, task_thread_info(child)->bpt_addr[i],
+			  task_thread_info(child)->bpt_insn[i]);
 	}
 	return (nsaved != 0);
 }
@@ -369,7 +369,7 @@ do_sys_ptrace(long request, long pid, lo
 		if (!valid_signal(data))
 			break;
 		/* Mark single stepping.  */
-		child->thread_info->bpt_nsaved = -1;
+		task_thread_info(child)->bpt_nsaved = -1;
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		wake_up_process(child);
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index da0be34..4b87352 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -302,7 +302,7 @@ secondary_cpu_start(int cpuid, struct ta
 		 + hwrpb->processor_offset
 		 + cpuid * hwrpb->processor_size);
 	hwpcb = (struct pcb_struct *) cpu->hwpcb;
-	ipcb = &idle->thread_info->pcb;
+	ipcb = &task_thread_info(idle)->pcb;
 
 	/* Initialize the CPU's HWPCB to something just good enough for
 	   us to get started.  Immediately after starting, we'll swpctx
diff --git a/include/asm-alpha/mmu_context.h b/include/asm-alpha/mmu_context.h
index a714d0c..6f92482 100644
--- a/include/asm-alpha/mmu_context.h
+++ b/include/asm-alpha/mmu_context.h
@@ -156,7 +156,7 @@ ev5_switch_mm(struct mm_struct *prev_mm,
 	/* Always update the PCB ASN.  Another thread may have allocated
 	   a new mm->context (via flush_tlb_mm) without the ASN serial
 	   number wrapping.  We have no way to detect when this is needed.  */
-	next->thread_info->pcb.asn = mmc & HARDWARE_ASN_MASK;
+	task_thread_info(next)->pcb.asn = mmc & HARDWARE_ASN_MASK;
 }
 
 __EXTERN_INLINE void
@@ -235,7 +235,7 @@ init_new_context(struct task_struct *tsk
 		if (cpu_online(i))
 			mm->context[i] = 0;
 	if (tsk != current)
-		tsk->thread_info->pcb.ptbr
+		task_thread_info(tsk)->pcb.ptbr
 		  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 	return 0;
 }
@@ -249,7 +249,7 @@ destroy_context(struct mm_struct *mm)
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
-	tsk->thread_info->pcb.ptbr
+	task_thread_info(tsk)->pcb.ptbr
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
diff --git a/include/asm-alpha/processor.h b/include/asm-alpha/processor.h
index 059780a..e59a6ec 100644
--- a/include/asm-alpha/processor.h
+++ b/include/asm-alpha/processor.h
@@ -64,7 +64,7 @@ unsigned long get_wchan(struct task_stru
   (*(unsigned long *)(PT_REG(pc) + (unsigned long) ((tsk)->thread_info)))
 
 #define KSTK_ESP(tsk) \
-  ((tsk) == current ? rdusp() : (tsk)->thread_info->pcb.usp)
+  ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
 
 #define cpu_relax()	barrier()
 
diff --git a/include/asm-alpha/system.h b/include/asm-alpha/system.h
index 050e86d..ba19cf3 100644
--- a/include/asm-alpha/system.h
+++ b/include/asm-alpha/system.h
@@ -131,10 +131,10 @@ struct el_common_EV6_mcheck {
 extern void halt(void) __attribute__((noreturn));
 #define __halt() __asm__ __volatile__ ("call_pal %0 #halt" : : "i" (PAL_halt))
 
-#define switch_to(P,N,L)						\
-  do {									\
-    (L) = alpha_switch_to(virt_to_phys(&(N)->thread_info->pcb), (P));	\
-    check_mmu_context();						\
+#define switch_to(P,N,L)						 \
+  do {									 \
+    (L) = alpha_switch_to(virt_to_phys(&task_thread_info(N)->pcb), (P)); \
+    check_mmu_context();						 \
   } while (0)
 
 struct task_struct;
-- 
0.99.9.GIT

