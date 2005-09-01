Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVIAUt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVIAUt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVIAUt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:49:57 -0400
Received: from fmr23.intel.com ([143.183.121.15]:50396 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030370AbVIAUt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:49:56 -0400
Date: Thu, 1 Sep 2005 13:49:37 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: systemtap@sources.redhat.com, ananth@in.ibm.com, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: [PATCH]kprobes fix bug when probed on task and isr functions
Message-ID: <20050901134937.A29041@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch fixes a race condition where in system used to hang
or sometime crash within minutes when kprobes are inserted on 
ISR routine and a task routine.

The fix has been stress tested on i386, ia64, pp64 and on x86_64.
To reproduce the problem insert kprobes on schedule() and do_IRQ() functions and
you should see hang or system crash.

This patch should apply cleanly on 2.6.13-mm1 kernel.

Please apply.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


=====================================================
 arch/i386/kernel/kprobes.c   |    3 ++-
 arch/ia64/kernel/kprobes.c   |   22 +++++++++++++++++++---
 arch/ppc64/kernel/kprobes.c  |   11 ++++++-----
 arch/x86_64/kernel/kprobes.c |    3 ++-
 include/asm-ia64/kprobes.h   |    1 +
 include/asm-ppc64/kprobes.h  |    3 +++
 kernel/kprobes.c             |    8 ++++++++
 7 files changed, 41 insertions(+), 10 deletions(-)

Index: linux-2.6.13-mm1/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.13-mm1/arch/i386/kernel/kprobes.c
@@ -190,7 +190,8 @@ static int __kprobes kprobe_handler(stru
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS) {
+			if (kprobe_status == KPROBE_HIT_SS &&
+				*p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
 				regs->eflags &= ~TF_MASK;
 				regs->eflags |= kprobe_saved_eflags;
 				unlock_kprobes();
Index: linux-2.6.13-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.13-mm1/arch/ia64/kernel/kprobes.c
@@ -95,6 +95,17 @@ static void __kprobes update_kprobe_inst
 	p->ainsn.inst_flag = 0;
 	p->ainsn.target_br_reg = 0;
 
+	/* Check for Break instruction
+ 	 * Bits 37:40 Major opcode to be zero
+	 * Bits 27:32 X6 to be zero
+	 * Bits 32:35 X3 to be zero
+	 */
+	if ((!major_opcode) && (!((kprobe_inst >> 27) & 0x1FF)) ) {
+		/* is a break instruction */
+	 	p->ainsn.inst_flag |= INST_FLAG_BREAK_INST;
+		return;
+	}
+
 	if (bundle_encoding[template][slot] == B) {
 		switch (major_opcode) {
 		  case INDIRECT_CALL_OPCODE:
@@ -542,8 +553,11 @@ static void __kprobes prepare_ss(struct 
 	unsigned long bundle_addr = (unsigned long) &p->opcode.bundle;
 	unsigned long slot = (unsigned long)p->addr & 0xf;
 
-	/* Update instruction pointer (IIP) and slot number (IPSR.ri) */
-	regs->cr_iip = bundle_addr & ~0xFULL;
+	/* single step inline if break instruction */
+	if (p->ainsn.inst_flag == INST_FLAG_BREAK_INST)
+		regs->cr_iip = (unsigned long)p->addr & ~0xFULL;
+	else
+		regs->cr_iip = bundle_addr & ~0xFULL;
 
 	if (slot > 2)
 		slot = 0;
@@ -599,7 +613,9 @@ static int __kprobes pre_kprobes_handler
 	if (kprobe_running()) {
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS) {
+			if ( (kprobe_status == KPROBE_HIT_SS) &&
+	 		     (p->ainsn.inst_flag == INST_FLAG_BREAK_INST)) {
+  				ia64_psr(regs)->ss = 0;
 				unlock_kprobes();
 				goto no_kprobe;
 			}
Index: linux-2.6.13-mm1/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/ppc64/kernel/kprobes.c
+++ linux-2.6.13-mm1/arch/ppc64/kernel/kprobes.c
@@ -102,7 +102,7 @@ static inline void prepare_singlestep(st
 	regs->msr |= MSR_SE;
 
 	/* single step inline if it is a trap variant */
-	if (IS_TW(insn) || IS_TD(insn) || IS_TWI(insn) || IS_TDI(insn))
+	if (is_trap(insn))
 		regs->nip = (unsigned long)p->addr;
 	else
 		regs->nip = (unsigned long)p->ainsn.insn;
@@ -152,7 +152,9 @@ static inline int kprobe_handler(struct 
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS) {
+			kprobe_opcode_t insn = *p->ainsn.insn;
+			if (kprobe_status == KPROBE_HIT_SS &&
+					is_trap(insn)) {
 				regs->msr &= ~MSR_SE;
 				regs->msr |= kprobe_saved_msr;
 				unlock_kprobes();
@@ -192,8 +194,7 @@ static inline int kprobe_handler(struct 
 			 * trap variant, it could belong to someone else
 			 */
 			kprobe_opcode_t cur_insn = *addr;
-			if (IS_TW(cur_insn) || IS_TD(cur_insn) ||
-					IS_TWI(cur_insn) || IS_TDI(cur_insn))
+			if (is_trap(cur_insn))
 		       		goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
@@ -403,7 +404,7 @@ int __kprobes kprobe_exceptions_notify(s
 	default:
 		break;
 	}
-	preempt_enable();
+	preempt_enable_no_resched();
 	return ret;
 }
 
Index: linux-2.6.13-mm1/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.13-mm1/arch/x86_64/kernel/kprobes.c
@@ -311,7 +311,8 @@ int __kprobes kprobe_handler(struct pt_r
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);
 		if (p) {
-			if (kprobe_status == KPROBE_HIT_SS) {
+			if (kprobe_status == KPROBE_HIT_SS &&
+				*p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
 				regs->eflags &= ~TF_MASK;
 				regs->eflags |= kprobe_saved_rflags;
 				unlock_kprobes();
Index: linux-2.6.13-mm1/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.13-mm1/include/asm-ia64/kprobes.h
@@ -92,6 +92,7 @@ struct arch_specific_insn {
 	kprobe_opcode_t insn;
  #define INST_FLAG_FIX_RELATIVE_IP_ADDR		1
  #define INST_FLAG_FIX_BRANCH_REG		2
+ #define INST_FLAG_BREAK_INST			4
  	unsigned long inst_flag;
  	unsigned short target_br_reg;
 };
Index: linux-2.6.13-mm1/include/asm-ppc64/kprobes.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-ppc64/kprobes.h
+++ linux-2.6.13-mm1/include/asm-ppc64/kprobes.h
@@ -42,6 +42,9 @@ typedef unsigned int kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
+#define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
+			IS_TWI(instr) || IS_TDI(instr))
+
 #define ARCH_SUPPORTS_KRETPROBES
 void kretprobe_trampoline(void);
 
Index: linux-2.6.13-mm1/kernel/kprobes.c
===================================================================
--- linux-2.6.13-mm1.orig/kernel/kprobes.c
+++ linux-2.6.13-mm1/kernel/kprobes.c
@@ -155,14 +155,22 @@ void __kprobes free_insn_slot(kprobe_opc
 /* Locks kprobe: irqs must be disabled */
 void __kprobes lock_kprobes(void)
 {
+	unsigned long flags = 0;
+
+	local_irq_save(flags);
 	spin_lock(&kprobe_lock);
 	kprobe_cpu = smp_processor_id();
+ 	local_irq_restore(flags);
 }
 
 void __kprobes unlock_kprobes(void)
 {
+	unsigned long flags = 0;
+
+	local_irq_save(flags);
 	kprobe_cpu = NR_CPUS;
 	spin_unlock(&kprobe_lock);
+ 	local_irq_restore(flags);
 }
 
 /* You have to be holding the kprobe_lock */
