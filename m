Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVEWP4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVEWP4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVEWPzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:55:21 -0400
Received: from fmr20.intel.com ([134.134.136.19]:39625 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261900AbVEWPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:47:28 -0400
Message-Id: <20050523154229.089202000@csdlinux-2.jf.intel.com>
References: <20050523153906.988390000@csdlinux-2.jf.intel.com>
Date: Mon, 23 May 2005 08:39:10 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: tony.luck@intel.com, rohit.seth@intel.com, rusty.lynch@intel.com,
       prasanna@in.ibm.com, ananth@in.ibm.com, systemtap@sources.redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: [patch 4/4] Kprobes support for IA64
Content-Disposition: inline; filename=kprobes-branch-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is required to support kprobe on branch/call instructions.
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
=====================================================================
 arch/ia64/kernel/kprobes.c |  131 +++++++++++++++++++++++++++++++++++++++------
 include/asm-ia64/kprobes.h |   17 +++++
 2 files changed, 132 insertions(+), 16 deletions(-)

Index: linux-2.6.12-rc4/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4.orig/arch/ia64/kernel/kprobes.c	2005-05-23 07:57:22.848550199 -0700
+++ linux-2.6.12-rc4/arch/ia64/kernel/kprobes.c	2005-05-23 07:57:24.205972057 -0700
@@ -120,25 +120,75 @@
 	unsigned long arm_addr = addr & ~0xFULL;
 	unsigned long slot = addr & 0xf;
 	unsigned long template;
+    	unsigned long major_opcode = 0;
+    	unsigned long lx_type_inst = 0;
+    	unsigned long kprobe_inst = 0;
 	bundle_t bundle;
+   
+   	p->ainsn.inst_flag = 0;
+   	p->ainsn.target_br_reg = 0;
 
 	memcpy(&bundle, &p->ainsn.insn.bundle, sizeof(bundle_t));
+    	template = bundle.quad0.template;
+    	if (slot == 1 && bundle_encoding[template][1] == L) {
+    		lx_type_inst = 1;
+     		slot = 2;
+    	}
+   
 
-	template = bundle.quad0.template;
-	if (slot == 1 && bundle_encoding[template][1] == L)
-		slot = 2;
 	switch (slot) {
 	case 0:
+   		major_opcode = (bundle.quad0.slot0 >> SLOT0_OPCODE_SHIFT);
+    		kprobe_inst = bundle.quad0.slot0;
 		bundle.quad0.slot0 = BREAK_INST;
 		break;
 	case 1:
+    		major_opcode = (bundle.quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
+    		kprobe_inst = (bundle.quad0.slot1_p0 |
+    				(bundle.quad1.slot1_p1 << (64-46)));
 		bundle.quad0.slot1_p0 = BREAK_INST;
 		bundle.quad1.slot1_p1 = (BREAK_INST >> (64-46));
 		break;
 	case 2:
+    		major_opcode = (bundle.quad1.slot2 >> SLOT2_OPCODE_SHIFT);
+    		kprobe_inst = bundle.quad1.slot2;
 		bundle.quad1.slot2 = BREAK_INST;
 		break;
 	}
+    	/*
+    	 * Look for IP relative Branches, IP relative call or
+    	 * IP relative predicate instructions
+    	 */
+    	if (bundle_encoding[template][slot] == B) {
+    		switch (major_opcode) {
+    			case INDIRECT_CALL_OPCODE:
+    				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+    				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+    				break;
+    			case IP_RELATIVE_PREDICT_OPCODE:
+    			case IP_RELATIVE_BRANCH_OPCODE:
+    				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
+    				break;
+    			case IP_RELATIVE_CALL_OPCODE:
+    				p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
+    				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+    				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+    				break;
+    			default:
+    				/* Do nothing */
+    				break;
+    		}
+    	} else if (lx_type_inst) {
+    		switch (major_opcode) {
+    			case LONG_CALL_OPCODE:
+    				p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
+    				p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
+   				break;
+    			default:
+    				/* Do nothing */
+    				break;
+    		}
+    	}
 
  	/* Flush icache for the instruction at the emulated address */
 	flush_icache_range((unsigned long)&p->ainsn.insn.bundle,
@@ -170,24 +220,75 @@
  * We are resuming execution after a single step fault, so the pt_regs
  * structure reflects the register state after we executed the instruction
  * located in the kprobe (p->ainsn.insn.bundle).  We still need to adjust
- * the ip to point back to the original stack address, and if we see that
- * the slot has incremented back to zero, then we need to point to the next
- * slot location.
+ * the ip to point back to the original stack address. To set the IP address
+ * to original stack address, handle the case where we need to fixup the
+ * relative IP address and/or fixup branch register.
  */
 static void resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
-	unsigned long bundle = (unsigned long)p->addr & ~0xFULL;
+  	unsigned long bundle_addr = ((unsigned long) (&p->ainsn.insn.bundle)) & ~0xFULL;
+  	unsigned long resume_addr = (unsigned long)p->addr & ~0xFULL;
+ 	unsigned long template;
+ 	int slot = ((unsigned long)p->addr & 0xf);
 
-	/*
-	 * TODO: Handle cases where kprobe was inserted on a branch instruction
-	 */
+	template = p->opcode.bundle.quad0.template;
+
+ 	if (slot == 1 && bundle_encoding[template][1] == L)
+ 		slot = 2;
+
+	if (p->ainsn.inst_flag) {
+
+		if (p->ainsn.inst_flag & INST_FLAG_FIX_RELATIVE_IP_ADDR) {
+			/* Fix relative IP address */
+ 			regs->cr_iip = (regs->cr_iip - bundle_addr) + resume_addr;
+		}
 
-	if (!ia64_psr(regs)->ri)
-		regs->cr_iip = bundle + 0x10;
-	else
-		regs->cr_iip = bundle;
+		if (p->ainsn.inst_flag & INST_FLAG_FIX_BRANCH_REG) {
+		/*
+		 * Fix target branch register, software convention is
+		 * to use either b0 or b6 or b7, so just checking
+		 * only those registers
+		 */
+			switch (p->ainsn.target_br_reg) {
+			case 0:
+				if ((regs->b0 == bundle_addr) ||
+					(regs->b0 == bundle_addr + 0x10)) {
+					regs->b0 = (regs->b0 - bundle_addr) +
+						resume_addr;
+				}
+				break;
+			case 6:
+				if ((regs->b6 == bundle_addr) ||
+					(regs->b6 == bundle_addr + 0x10)) {
+					regs->b6 = (regs->b6 - bundle_addr) +
+						resume_addr;
+				}
+				break;
+			case 7:
+				if ((regs->b7 == bundle_addr) ||
+					(regs->b7 == bundle_addr + 0x10)) {
+					regs->b7 = (regs->b7 - bundle_addr) +
+						resume_addr;
+				}
+				break;
+			} /* end switch */
+		}
+		goto turn_ss_off;
+	}
 
-	ia64_psr(regs)->ss = 0;
+	if (slot == 2) {
+ 		if (regs->cr_iip == bundle_addr + 0x10) {
+ 			regs->cr_iip = resume_addr + 0x10;
+ 		}
+ 	} else {
+ 		if (regs->cr_iip == bundle_addr) {
+ 			regs->cr_iip = resume_addr;
+ 		}
+ 	}
+
+turn_ss_off:
+  	/* Turn off Single Step bit */
+  	ia64_psr(regs)->ss = 0;
 }
 
 static void prepare_ss(struct kprobe *p, struct pt_regs *regs)
Index: linux-2.6.12-rc4/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-ia64/kprobes.h	2005-05-23 07:57:22.851479886 -0700
+++ linux-2.6.12-rc4/include/asm-ia64/kprobes.h	2005-05-23 07:57:24.207925182 -0700
@@ -42,6 +42,17 @@
 	} quad1;
 } __attribute__((__aligned__(16)))  bundle_t;
 
+#define SLOT0_OPCODE_SHIFT	(37)
+#define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
+#define SLOT2_OPCODE_SHIFT 	(37)
+
+#define INDIRECT_CALL_OPCODE		(1)
+#define IP_RELATIVE_CALL_OPCODE		(5)
+#define IP_RELATIVE_BRANCH_OPCODE	(4)
+#define IP_RELATIVE_PREDICT_OPCODE	(7)
+#define LONG_BRANCH_OPCODE		(0xC)
+#define LONG_CALL_OPCODE		(0xD)
+
 typedef struct kprobe_opcode {
 	bundle_t bundle;
 } kprobe_opcode_t;
@@ -53,8 +64,12 @@
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
-	/* copy of the original instruction */
+	/* copy of the instruction to be emulated */
 	kprobe_opcode_t insn;
+ #define INST_FLAG_FIX_RELATIVE_IP_ADDR		1
+ #define INST_FLAG_FIX_BRANCH_REG		2
+ 	unsigned long inst_flag;
+ 	unsigned short target_br_reg;
 };
 
 /* ia64 does not need this */

--
