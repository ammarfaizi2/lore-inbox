Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVFFR5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVFFR5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 13:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFFR4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 13:56:47 -0400
Received: from fmr18.intel.com ([134.134.136.17]:26796 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261516AbVFFRye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 13:54:34 -0400
Message-Id: <20050606174058.691662000@csdlinux-2.jf.intel.com>
References: <20050606173652.059047000@csdlinux-2.jf.intel.com>
Date: Mon, 06 Jun 2005 10:36:53 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       systemtap@sources.redhat.com, rusty.lynch@intel.com,
       davidm@napali.hpl.hp.com, alen.brunelle@hp.com,
       anil.s.keshavamurthy@intel.com
Subject: [patch 1/3] Kprobes IA64 arch prepare kprobes cleanup
Content-Disposition: inline; filename=kprobes-ia64-arch-prepare-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch_prepare_kprobes() was doing lots of functionality
in just one single function. This patch
attempts to clean up arch_prepare_kprobes() by moving
specific sub task to the following (new)functions
1)valid_kprobe_addr() -->> validate the given kprobe address
2)get_kprobe_inst(slot..)->> Retrives the instruction for a given slot from the bundle 
3)prepare_break_inst() -->> Prepares break instruction within the bundle
	3a)update_kprobe_inst_flag()-->>Updates the internal flags, required
			for proper emulation of the instruction at later
			point in time.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

===================================================================
 arch/ia64/kernel/kprobes.c |  191 ++++++++++++++++++++++++++++-----------------
 1 files changed, 121 insertions(+), 70 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -98,90 +98,141 @@ static inline void set_current_kprobe(st
 	current_kprobe = p;
 }
 
-int arch_prepare_kprobe(struct kprobe *p)
+/*
+ * In this function we check to see if the instruction
+ * is IP relative instruction and update the kprobe
+ * inst flag accordingly
+ */
+static void update_kprobe_inst_flag(uint template, uint  slot, uint major_opcode,
+	unsigned long kprobe_inst, struct kprobe *p)
 {
-	unsigned long addr = (unsigned long) p->addr;
-	unsigned long *bundle_addr = (unsigned long *)(addr & ~0xFULL);
-	unsigned long slot = addr & 0xf;
-	unsigned long template;
- 	unsigned long major_opcode = 0;
- 	unsigned long lx_type_inst = 0;
- 	unsigned long kprobe_inst = 0;
-	bundle_t *bundle = &p->ainsn.insn.bundle;
-
-	memcpy(&p->opcode.bundle, bundle_addr, sizeof(bundle_t));
-	memcpy(&p->ainsn.insn.bundle, bundle_addr, sizeof(bundle_t));
-
 	p->ainsn.inst_flag = 0;
 	p->ainsn.target_br_reg = 0;
 
- 	template = bundle->quad0.template;
+	if (bundle_encoding[template][slot] == B) {
+		switch (major_opcode) {
+		  case INDIRECT_CALL_OPCODE:
+	 		p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+ 			p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+ 			break;
+		  case IP_RELATIVE_PREDICT_OPCODE:
+		  case IP_RELATIVE_BRANCH_OPCODE:
+			p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
+ 			break;
+		  case IP_RELATIVE_CALL_OPCODE:
+ 			p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
+ 			p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+ 			p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+ 			break;
+		}
+ 	} else if (bundle_encoding[template][slot] == X) {
+		switch (major_opcode) {
+		  case LONG_CALL_OPCODE:
+			p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+			p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+		  break;
+		}
+	}
+	return;
+}
 
-	if (((bundle_encoding[template][1] == L) && slot > 1) || (slot > 2)) {
-		printk(KERN_WARNING "Attempting to insert unaligned kprobe at 0x%lx\n",
-				addr);
-		return -EINVAL;
+/* 
+ * In this function we override the bundle with
+ * the break instruction at the given slot.
+ */
+static void prepare_break_inst(uint template, uint  slot, uint major_opcode,
+	unsigned long kprobe_inst, struct kprobe *p)
+{
+	unsigned long break_inst = BREAK_INST;
+	bundle_t *bundle = &p->ainsn.insn.bundle;
+
+	/*
+	 * Copy the original kprobe_inst qualifying predicate(qp)
+	 * to the break instruction
+	 */
+	break_inst |= (0x3f & kprobe_inst);
+
+	switch (slot) {
+	  case 0:
+		bundle->quad0.slot0 = break_inst;
+		break;
+	  case 1:
+		bundle->quad0.slot1_p0 = break_inst;
+		bundle->quad1.slot1_p1 = break_inst >> (64-46);
+		break;
+	  case 2:
+		bundle->quad1.slot2 = break_inst;
+		break;
 	}
 
- 	if (slot == 1 && bundle_encoding[template][1] == L) {
- 		lx_type_inst = 1;
-  		slot = 2;
- 	}
+	/* 
+	 * Update the instruction flag, so that we can
+	 * emulate the instruction properly after we 
+	 * single step on original instruction
+	 */
+	update_kprobe_inst_flag(template, slot, major_opcode, kprobe_inst, p);
+}
+
+static inline void get_kprobe_inst(bundle_t *bundle, uint slot,
+	       	unsigned long *kprobe_inst, uint *major_opcode)
+{
+	unsigned long kprobe_inst_p0, kprobe_inst_p1;
+	unsigned int template;
+
+	template = bundle->quad0.template;
 
 	switch (slot) {
-	case 0:
- 		major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
- 		kprobe_inst = bundle->quad0.slot0;
-		bundle->quad0.slot0 = BREAK_INST | (0x3f & kprobe_inst);
+	  case 0:
+ 		*major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
+ 		*kprobe_inst = bundle->quad0.slot0;
 		break;
-	case 1:
- 		major_opcode = (bundle->quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
- 		kprobe_inst = (bundle->quad0.slot1_p0 |
- 				(bundle->quad1.slot1_p1 << (64-46)));
-		bundle->quad0.slot1_p0 = BREAK_INST | (0x3f & kprobe_inst);
-		bundle->quad1.slot1_p1 = (BREAK_INST >> (64-46));
+	  case 1:
+ 		*major_opcode = (bundle->quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
+  		kprobe_inst_p0 = bundle->quad0.slot1_p0;
+  		kprobe_inst_p1 = bundle->quad1.slot1_p1;
+  		*kprobe_inst = kprobe_inst_p0 | (kprobe_inst_p1 << (64-46));
 		break;
-	case 2:
- 		major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
- 		kprobe_inst = bundle->quad1.slot2;
-		bundle->quad1.slot2 = BREAK_INST | (0x3f & kprobe_inst);
+	  case 2:
+ 		*major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
+ 		*kprobe_inst = bundle->quad1.slot2;
 		break;
 	}
+}
 
- 	/*
- 	 * Look for IP relative Branches, IP relative call or
- 	 * IP relative predicate instructions
- 	 */
- 	if (bundle_encoding[template][slot] == B) {
- 		switch (major_opcode) {
- 			case INDIRECT_CALL_OPCODE:
- 				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
- 				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
- 				break;
- 			case IP_RELATIVE_PREDICT_OPCODE:
- 			case IP_RELATIVE_BRANCH_OPCODE:
- 				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
- 				break;
- 			case IP_RELATIVE_CALL_OPCODE:
- 				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
- 				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
- 				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
- 				break;
- 			default:
- 				/* Do nothing */
- 				break;
- 		}
- 	} else if (lx_type_inst) {
- 		switch (major_opcode) {
- 			case LONG_CALL_OPCODE:
- 				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
- 				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
-				break;
- 			default:
- 				/* Do nothing */
- 				break;
- 		}
+static int valid_kprobe_addr(int template, int slot, unsigned long addr)
+{
+	if ((slot > 2) || ((bundle_encoding[template][1] == L) && slot > 1)) {
+		printk(KERN_WARNING "Attempting to insert unaligned kprobe at 0x%lx\n",
+				addr);
+		return -EINVAL;
 	}
+	return 0;
+}
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	unsigned long addr = (unsigned long) p->addr;
+	unsigned long *kprobe_addr = (unsigned long *)(addr & ~0xFULL);
+	unsigned long kprobe_inst=0;
+	unsigned int slot = addr & 0xf, template, major_opcode = 0;
+	bundle_t *bundle = &p->ainsn.insn.bundle;
+
+	memcpy(&p->opcode.bundle, kprobe_addr, sizeof(bundle_t));
+	memcpy(&p->ainsn.insn.bundle, kprobe_addr, sizeof(bundle_t));
+
+ 	template = bundle->quad0.template;
+
+	if(valid_kprobe_addr(template, slot, addr))
+		return -EINVAL;
+
+	/* Move to slot 2, if bundle is MLX type and kprobe slot is 1 */
+ 	if (slot == 1 && bundle_encoding[template][1] == L)
+  		slot++;
+
+	/* Get kprobe_inst and major_opcode from the bundle */
+	get_kprobe_inst(bundle, slot, &kprobe_inst, &major_opcode);
+
+	prepare_break_inst(template, slot, major_opcode, kprobe_inst, p);
 
 	return 0;
 }
@@ -277,7 +328,7 @@ static void resume_execution(struct kpro
  		if (regs->cr_iip == bundle_addr) {
  			regs->cr_iip = resume_addr;
  		}
- 	}
+	}
 
 turn_ss_off:
   	/* Turn off Single Step bit */

--

