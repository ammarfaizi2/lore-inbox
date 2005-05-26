Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVEZRqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEZRqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVEZRqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:46:40 -0400
Received: from fmr18.intel.com ([134.134.136.17]:25032 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261649AbVEZRpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:45:30 -0400
Date: Thu, 26 May 2005 10:45:22 -0700
Message-Id: <200505261745.j4QHjMqx008858@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
Subject: [patch] Kprobes ia64 cleanup
To: akpm@osdl.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Rusty Lynch <rusty.lynch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 2.6.12-rc5-mm1 patch is a cleanup of the ia64 kprobes
implementation such that all of the bundle manipulation logic is 
concentrated in arch_prepare_kprobe(). 

With the current design for kprobes, the arch specific code only
has a chance to return failure inside the arch_prepare_kprobe() 
function.

This patch moves all of the work that was happening in arch_copy_kprobe()
and most of the work that was happening in arch_arm_kprobe() into
arch_prepare_kprobe().  By doing this we can add further robustness checks
in arch_arm_kprobe() and refuse to insert kprobes that will cause problems.

    --rusty

signed-off-by: Rusty Lynch <Rusty.lynch@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

 arch/ia64/kernel/kprobes.c |  178 +++++++++++++++++++--------------------------
 include/asm-ia64/kprobes.h |    7 +
 2 files changed, 84 insertions(+), 101 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -84,121 +84,97 @@ static enum instruction_type bundle_enco
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long) p->addr;
-	unsigned long bundle_addr = addr & ~0xFULL;
+	unsigned long *bundle_addr = (unsigned long *)(addr & ~0xFULL);
 	unsigned long slot = addr & 0xf;
-	bundle_t bundle;
 	unsigned long template;
+ 	unsigned long major_opcode = 0;
+ 	unsigned long lx_type_inst = 0;
+ 	unsigned long kprobe_inst = 0;
+	bundle_t *bundle = &p->ainsn.insn.bundle;
 
-	/*
-	 * TODO: Verify that a probe is not being inserted
-	 *       in sensitive regions of code
-	 * TODO: Verify that the memory holding the probe is rwx
-	 * TODO: verify this is a kernel address
-	 */
-	memcpy(&bundle, (unsigned long *)bundle_addr, sizeof(bundle_t));
-	template = bundle.quad0.template;
-	if (((bundle_encoding[template][1] == L) && slot > 1) || (slot > 2)) {
-		printk(KERN_WARNING "Attempting to insert unaligned kprobe at 0x%lx\n", addr);
-		return -EINVAL;
-	}
-	return 0;
-}
+	memcpy(&p->opcode.bundle, bundle_addr, sizeof(bundle_t));
+	memcpy(&p->ainsn.insn.bundle, bundle_addr, sizeof(bundle_t));
 
-void arch_copy_kprobe(struct kprobe *p)
-{
-	unsigned long addr = (unsigned long)p->addr;
-	unsigned long bundle_addr = addr & ~0xFULL;
+	p->ainsn.inst_flag = 0;
+	p->ainsn.target_br_reg = 0;
 
-	memcpy(&p->ainsn.insn.bundle, (unsigned long *)bundle_addr,
-				sizeof(bundle_t));
-	memcpy(&p->opcode.bundle, &p->ainsn.insn.bundle, sizeof(bundle_t));
-}
+ 	template = bundle->quad0.template;
 
-void arch_arm_kprobe(struct kprobe *p)
-{
-	unsigned long addr = (unsigned long)p->addr;
-	unsigned long arm_addr = addr & ~0xFULL;
-	unsigned long slot = addr & 0xf;
-	unsigned long template;
-    	unsigned long major_opcode = 0;
-    	unsigned long lx_type_inst = 0;
-    	unsigned long kprobe_inst = 0;
-	bundle_t bundle;
-
-   	p->ainsn.inst_flag = 0;
-   	p->ainsn.target_br_reg = 0;
-
-	memcpy(&bundle, &p->ainsn.insn.bundle, sizeof(bundle_t));
-    	template = bundle.quad0.template;
-    	if (slot == 1 && bundle_encoding[template][1] == L) {
-    		lx_type_inst = 1;
-     		slot = 2;
-    	}
+	if (((bundle_encoding[template][1] == L) && slot > 1) || (slot > 2)) {
+		printk(KERN_WARNING "Attempting to insert unaligned kprobe at 0x%lx\n",
+				addr);
+		return -EINVAL;
+	}
 
+ 	if (slot == 1 && bundle_encoding[template][1] == L) {
+ 		lx_type_inst = 1;
+  		slot = 2;
+ 	}
 
 	switch (slot) {
 	case 0:
-   		major_opcode = (bundle.quad0.slot0 >> SLOT0_OPCODE_SHIFT);
-    		kprobe_inst = bundle.quad0.slot0;
-		bundle.quad0.slot0 = BREAK_INST;
+ 		major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
+ 		kprobe_inst = bundle->quad0.slot0;
+		bundle->quad0.slot0 = BREAK_INST;
 		break;
 	case 1:
-    		major_opcode = (bundle.quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
-    		kprobe_inst = (bundle.quad0.slot1_p0 |
-    				(bundle.quad1.slot1_p1 << (64-46)));
-		bundle.quad0.slot1_p0 = BREAK_INST;
-		bundle.quad1.slot1_p1 = (BREAK_INST >> (64-46));
+ 		major_opcode = (bundle->quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
+ 		kprobe_inst = (bundle->quad0.slot1_p0 |
+ 				(bundle->quad1.slot1_p1 << (64-46)));
+		bundle->quad0.slot1_p0 = BREAK_INST;
+		bundle->quad1.slot1_p1 = (BREAK_INST >> (64-46));
 		break;
 	case 2:
-    		major_opcode = (bundle.quad1.slot2 >> SLOT2_OPCODE_SHIFT);
-    		kprobe_inst = bundle.quad1.slot2;
-		bundle.quad1.slot2 = BREAK_INST;
+ 		major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
+ 		kprobe_inst = bundle->quad1.slot2;
+		bundle->quad1.slot2 = BREAK_INST;
 		break;
 	}
-    	/*
-    	 * Look for IP relative Branches, IP relative call or
-    	 * IP relative predicate instructions
-    	 */
-    	if (bundle_encoding[template][slot] == B) {
-    		switch (major_opcode) {
-    			case INDIRECT_CALL_OPCODE:
-    				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
-    				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
-    				break;
-    			case IP_RELATIVE_PREDICT_OPCODE:
-    			case IP_RELATIVE_BRANCH_OPCODE:
-    				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
-    				break;
-    			case IP_RELATIVE_CALL_OPCODE:
-    				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
-    				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
-    				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
-    				break;
-    			default:
-    				/* Do nothing */
-    				break;
-    		}
-    	} else if (lx_type_inst) {
-    		switch (major_opcode) {
-    			case LONG_CALL_OPCODE:
-    				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
-    				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
-   				break;
-    			default:
-    				/* Do nothing */
-    				break;
-    		}
-    	}
-
- 	/* Flush icache for the instruction at the emulated address */
-	flush_icache_range((unsigned long)&p->ainsn.insn.bundle,
-			(unsigned long)&p->ainsn.insn.bundle +
-			sizeof(bundle_t));
-	/*
-	 * Patch the original instruction with the probe instruction
-	 * and flush the instruction cache
-	 */
-	memcpy((char *) arm_addr, (char *) &bundle, sizeof(bundle_t));
+
+ 	/*
+ 	 * Look for IP relative Branches, IP relative call or
+ 	 * IP relative predicate instructions
+ 	 */
+ 	if (bundle_encoding[template][slot] == B) {
+ 		switch (major_opcode) {
+ 			case INDIRECT_CALL_OPCODE:
+ 				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+ 				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+ 				break;
+ 			case IP_RELATIVE_PREDICT_OPCODE:
+ 			case IP_RELATIVE_BRANCH_OPCODE:
+ 				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
+ 				break;
+ 			case IP_RELATIVE_CALL_OPCODE:
+ 				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
+ 				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+ 				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+ 				break;
+ 			default:
+ 				/* Do nothing */
+ 				break;
+ 		}
+ 	} else if (lx_type_inst) {
+ 		switch (major_opcode) {
+ 			case LONG_CALL_OPCODE:
+ 				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+ 				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+				break;
+ 			default:
+ 				/* Do nothing */
+ 				break;
+ 		}
+	}
+
+	return 0;
+}
+
+void arch_arm_kprobe(struct kprobe *p)
+{
+	unsigned long addr = (unsigned long)p->addr;
+	unsigned long arm_addr = addr & ~0xFULL;
+
+	memcpy((char *)arm_addr, &p->ainsn.insn.bundle, sizeof(bundle_t));
 	flush_icache_range(arm_addr, arm_addr + sizeof(bundle_t));
 }
 
@@ -226,7 +202,7 @@ void arch_remove_kprobe(struct kprobe *p
  */
 static void resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
-  	unsigned long bundle_addr = ((unsigned long) (&p->ainsn.insn.bundle)) & ~0xFULL;
+  	unsigned long bundle_addr = ((unsigned long) (&p->opcode.bundle)) & ~0xFULL;
   	unsigned long resume_addr = (unsigned long)p->addr & ~0xFULL;
  	unsigned long template;
  	int slot = ((unsigned long)p->addr & 0xf);
@@ -293,7 +269,7 @@ turn_ss_off:
 
 static void prepare_ss(struct kprobe *p, struct pt_regs *regs)
 {
-	unsigned long bundle_addr = (unsigned long) &p->ainsn.insn.bundle;
+	unsigned long bundle_addr = (unsigned long) &p->opcode.bundle;
 	unsigned long slot = (unsigned long)p->addr & 0xf;
 
 	/* Update instruction pointer (IIP) and slot number (IPSR.ri) */
Index: linux-2.6.12-rc5/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc5.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-rc5/include/asm-ia64/kprobes.h
@@ -30,6 +30,8 @@
 
 #define BREAK_INST	(long)(__IA64_BREAK_KPROBE << 6)
 
+struct kprobe;
+
 typedef struct _bundle {
 	struct {
 		unsigned long long template : 5;
@@ -79,6 +81,11 @@ static inline void jprobe_return(void)
 {
 }
 
+/* ia64 does not need this */
+static inline void arch_copy_kprobe(struct kprobe *p)
+{
+}
+
 #ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
