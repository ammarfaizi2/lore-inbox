Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVFFR5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVFFR5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 13:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVFFRz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 13:55:27 -0400
Received: from fmr20.intel.com ([134.134.136.19]:51089 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261500AbVFFRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 13:54:33 -0400
Message-Id: <20050606174058.934378000@csdlinux-2.jf.intel.com>
References: <20050606173652.059047000@csdlinux-2.jf.intel.com>
Date: Mon, 06 Jun 2005 10:36:54 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       systemtap@sources.redhat.com, rusty.lynch@intel.com,
       davidm@napali.hpl.hp.com, alen.brunelle@hp.com,
       anil.s.keshavamurthy@intel.com
Subject: [patch 2/3] Kprobes IA64 cmp ctype unc support
Content-Disposition: inline; filename=kprobes-ia64-qp-fix2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current Kprobes when patching the original instruction
with the break instruction tries to retain the original
qualifying predicate(qp), however for cmp.crel.ctype where
ctype == unc, which is a special instruction always needs to be
executed irrespective of qp. Hence, if the instruction we are patching
is of this type, then we should not copy the original qp to 
the break instruction, this is because we always want the
break fault to happen so that we can emulate the instruction.

This patch is based on the feedback given by David Mosberger

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
===================================================================
 arch/ia64/kernel/kprobes.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 include/asm-ia64/kprobes.h |   17 +++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-rc5/arch/ia64/kernel/kprobes.c
@@ -137,6 +137,41 @@ static void update_kprobe_inst_flag(uint
 }
 
 /* 
+ * In this function we check to see if the instruction
+ * (qp) cmpx.crel.ctype p1,p2=r2,r3
+ * on which we are inserting kprobe is cmp instruction
+ * with ctype as unc.
+ */
+static uint is_cmp_ctype_unc_inst(uint template, uint slot, uint major_opcode,
+unsigned long kprobe_inst)
+{
+	cmp_inst_t cmp_inst;
+	uint ctype_unc = 0;
+
+	if (!((bundle_encoding[template][slot] == I) ||
+		(bundle_encoding[template][slot] == M)))
+		goto out;
+
+	if (!((major_opcode == 0xC) || (major_opcode == 0xD) ||
+		(major_opcode == 0xE)))
+		goto out;
+
+	cmp_inst.l = kprobe_inst;
+	if ((cmp_inst.f.x2 == 0) || (cmp_inst.f.x2 == 1)) {
+		/* Integere compare - Register Register (A6 type)*/
+		if ((cmp_inst.f.tb == 0) && (cmp_inst.f.ta == 0)
+				&&(cmp_inst.f.c == 1))
+			ctype_unc = 1;
+	} else if ((cmp_inst.f.x2 == 2)||(cmp_inst.f.x2 == 3)) {
+		/* Integere compare - Immediate Register (A8 type)*/
+		if ((cmp_inst.f.ta == 0) &&(cmp_inst.f.c == 1))
+			ctype_unc = 1;
+	}
+out:
+	return ctype_unc;
+}
+
+/* 
  * In this function we override the bundle with
  * the break instruction at the given slot.
  */
@@ -148,9 +183,13 @@ static void prepare_break_inst(uint temp
 
 	/*
 	 * Copy the original kprobe_inst qualifying predicate(qp)
-	 * to the break instruction
+	 * to the break instruction iff !is_cmp_ctype_unc_inst
+	 * because for cmp instruction with ctype equal to unc,
+	 * which is a special instruction always needs to be
+	 * executed regradless of qp
 	 */
-	break_inst |= (0x3f & kprobe_inst);
+	if (!is_cmp_ctype_unc_inst(template, slot, major_opcode, kprobe_inst))
+		break_inst |= (0x3f & kprobe_inst);
 
 	switch (slot) {
 	  case 0:
Index: linux-2.6.12-rc5/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.12-rc5.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.12-rc5/include/asm-ia64/kprobes.h
@@ -30,6 +30,23 @@
 
 #define BREAK_INST	(long)(__IA64_BREAK_KPROBE << 6)
 
+typedef union cmp_inst {
+	struct {
+	unsigned long long qp : 6;
+	unsigned long long p1 : 6;
+	unsigned long long c  : 1;
+	unsigned long long r2 : 7;
+	unsigned long long r3 : 7;
+	unsigned long long p2 : 6;
+	unsigned long long ta : 1;
+	unsigned long long x2 : 2;
+	unsigned long long tb : 1;
+	unsigned long long opcode : 4;
+	unsigned long long reserved : 23;
+	}f;
+	unsigned long long l;
+} cmp_inst_t; 
+
 struct kprobe;
 
 typedef struct _bundle {

--

