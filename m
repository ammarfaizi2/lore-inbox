Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFFRyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFFRyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFFRyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 13:54:52 -0400
Received: from fmr19.intel.com ([134.134.136.18]:24720 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261491AbVFFRy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 13:54:27 -0400
Message-Id: <20050606174059.177392000@csdlinux-2.jf.intel.com>
References: <20050606173652.059047000@csdlinux-2.jf.intel.com>
Date: Mon, 06 Jun 2005 10:36:55 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       systemtap@sources.redhat.com, rusty.lynch@intel.com,
       davidm@napali.hpl.hp.com, alen.brunelle@hp.com,
       anil.s.keshavamurthy@intel.com
Subject: [patch 3/3] Kprobes IA64 safe register kprobe
Content-Disposition: inline; filename=kprobes-ia64-safe-register-kprobe.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current kprobes does not yet handle register
kprobes on some of the following kind of instruction
which needs to be emulated in a special way.
1) mov r1=ip
2) chk -- Speculation check instruction
This patch attempts to fail register_kprobes() when
user tries to insert kprobes on the above kind of
instruction.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
===================================================================
 arch/ia64/kernel/kprobes.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -98,6 +98,48 @@ static inline void set_current_kprobe(st
 	current_kprobe = p;
 }
 
+/* 
+ * In this function we check to see if the instruction
+ * on which we are inserting kprobe is supported.
+ * Returns 0 if supported
+ * Returns -EINVAL if unsupported
+ */
+static int unsupported_inst(uint template, uint  slot, uint major_opcode,
+	unsigned long kprobe_inst, struct kprobe *p)
+{
+	unsigned long addr = (unsigned long)p->addr;
+	
+	if (bundle_encoding[template][slot] == I) {
+		switch (major_opcode) {
+			case 0x0: //I_UNIT_MISC_OPCODE:
+			/*
+			 * Check for Integer speculation instruction
+			 * - Bit 33-35 to be equal to 0x1
+			 */
+			if (((kprobe_inst >> 33) & 0x7) == 1) {
+				printk(KERN_WARNING 
+					"Kprobes on speculation inst at <0x%lx> not supported\n",
+					addr);
+				return -EINVAL;
+			}
+
+			/*
+			 * IP relative mov instruction
+			 *  - Bit 27-35 to be equal to 0x30
+			 */
+			if (((kprobe_inst >> 27) & 0x1FF) == 0x30) {
+				printk(KERN_WARNING 
+					"Kprobes on \"mov r1=ip\" at <0x%lx> not supported\n",
+					addr);
+				return -EINVAL;
+
+			}
+		}
+	}
+	return 0;
+}
+
+
 /*
  * In this function we check to see if the instruction
  * is IP relative instruction and update the kprobe
@@ -270,6 +312,9 @@ int arch_prepare_kprobe(struct kprobe *p
 
 	/* Get kprobe_inst and major_opcode from the bundle */
 	get_kprobe_inst(bundle, slot, &kprobe_inst, &major_opcode);
+	
+	if (unsupported_inst(template, slot, major_opcode, kprobe_inst, p))
+			return -EINVAL;
 
 	prepare_break_inst(template, slot, major_opcode, kprobe_inst, p);
 

--

