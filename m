Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbUKRBDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbUKRBDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbUKRBDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:03:24 -0500
Received: from ozlabs.org ([203.10.76.45]:50332 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262586AbUKRA7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:59:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.62402.289937.407188@cargo.ozlabs.ibm.com>
Date: Thu, 18 Nov 2004 11:58:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 move emulate_step to arch/ppc64/lib
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the emulate_step function, which is used in xmon's
single-stepping code, out of xmon.c and into arch/ppc64/lib/sstep.c,
so that kprobes can use it too.

Andrew: if you prefer to defer this until after 2.6.10, that's OK, but
I think it would be safe to go in now, since the only thing it can
break is xmon.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/lib/Makefile test/arch/ppc64/lib/Makefile
--- linux-2.5/arch/ppc64/lib/Makefile	2004-07-12 09:12:03.000000000 +1000
+++ test/arch/ppc64/lib/Makefile	2004-11-18 11:14:04.180366608 +1100
@@ -15,3 +15,4 @@
 obj-$(CONFIG_PCI)	+= e2a.o
 endif
 
+lib-$(CONFIG_XMON) += sstep.o
diff -urN linux-2.5/arch/ppc64/lib/sstep.c test/arch/ppc64/lib/sstep.c
--- /dev/null	2004-08-12 23:33:25.000000000 +1000
+++ test/arch/ppc64/lib/sstep.c	2004-11-18 11:21:40.464360680 +1100
@@ -0,0 +1,141 @@
+/*
+ * Single-step support.
+ *
+ * Copyright (C) 2004 Paul Mackerras <paulus@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <asm/sstep.h>
+#include <asm/processor.h>
+
+extern char SystemCall_common[];
+
+/* Bits in SRR1 that are copied from MSR */
+#define MSR_MASK	0xffffffff87c0ffff
+
+/*
+ * Determine whether a conditional branch instruction would branch.
+ */
+static int branch_taken(unsigned int instr, struct pt_regs *regs)
+{
+	unsigned int bo = (instr >> 21) & 0x1f;
+	unsigned int bi;
+
+	if ((bo & 4) == 0) {
+		/* decrement counter */
+		--regs->ctr;
+		if (((bo >> 1) & 1) ^ (regs->ctr == 0))
+			return 0;
+	}
+	if ((bo & 0x10) == 0) {
+		/* check bit from CR */
+		bi = (instr >> 16) & 0x1f;
+		if (((regs->ccr >> (31 - bi)) & 1) != ((bo >> 3) & 1))
+			return 0;
+	}
+	return 1;
+}
+
+/* 
+ * Emulate instructions that cause a transfer of control.
+ * Returns 1 if the step was emulated, 0 if not,
+ * or -1 if the instruction is one that should not be stepped,
+ * such as an rfid, or a mtmsrd that would clear MSR_RI.
+ */
+int emulate_step(struct pt_regs *regs, unsigned int instr)
+{
+	unsigned int opcode, rd;
+	unsigned long int imm;
+
+	opcode = instr >> 26;
+	switch (opcode) {
+	case 16:	/* bc */
+		imm = (signed short)(instr & 0xfffc);
+		if ((instr & 2) == 0)
+			imm += regs->nip;
+		regs->nip += 4;
+		if ((regs->msr & MSR_SF) == 0)
+			regs->nip &= 0xffffffffUL;
+		if (instr & 1)
+			regs->link = regs->nip;
+		if (branch_taken(instr, regs))
+			regs->nip = imm;
+		return 1;
+	case 17:	/* sc */
+		/*
+		 * N.B. this uses knowledge about how the syscall
+		 * entry code works.  If that is changed, this will
+		 * need to be changed also.
+		 */
+		regs->gpr[9] = regs->gpr[13];
+		regs->gpr[11] = regs->nip + 4;
+		regs->gpr[12] = regs->msr & MSR_MASK;
+		regs->gpr[13] = (unsigned long) get_paca();
+		regs->nip = (unsigned long) &SystemCall_common;
+		regs->msr = MSR_KERNEL;
+		return 1;
+	case 18:	/* b */
+		imm = instr & 0x03fffffc;
+		if (imm & 0x02000000)
+			imm -= 0x04000000;
+		if ((instr & 2) == 0)
+			imm += regs->nip;
+		if (instr & 1) {
+			regs->link = regs->nip + 4;
+			if ((regs->msr & MSR_SF) == 0)
+				regs->link &= 0xffffffffUL;
+		}
+		if ((regs->msr & MSR_SF) == 0)
+			imm &= 0xffffffffUL;
+		regs->nip = imm;
+		return 1;
+	case 19:
+		switch (instr & 0x7fe) {
+		case 0x20:	/* bclr */
+		case 0x420:	/* bcctr */
+			imm = (instr & 0x400)? regs->ctr: regs->link;
+			regs->nip += 4;
+			if ((regs->msr & MSR_SF) == 0) {
+				regs->nip &= 0xffffffffUL;
+				imm &= 0xffffffffUL;
+			}
+			if (instr & 1)
+				regs->link = regs->nip;
+			if (branch_taken(instr, regs))
+				regs->nip = imm;
+			return 1;
+		case 0x24:	/* rfid, scary */
+			return -1;
+		}
+	case 31:
+		rd = (instr >> 21) & 0x1f;
+		switch (instr & 0x7fe) {
+		case 0xa6:	/* mfmsr */
+			regs->gpr[rd] = regs->msr & MSR_MASK;
+			regs->nip += 4;
+			if ((regs->msr & MSR_SF) == 0)
+				regs->nip &= 0xffffffffUL;
+			return 1;
+		case 0x164:	/* mtmsrd */
+			/* only MSR_EE and MSR_RI get changed if bit 15 set */
+			/* mtmsrd doesn't change MSR_HV and MSR_ME */
+			imm = (instr & 0x10000)? 0x8002: 0xefffffffffffefffUL;
+			imm = (regs->msr & MSR_MASK & ~imm)
+				| (regs->gpr[rd] & imm);
+			if ((imm & MSR_RI) == 0)
+				/* can't step mtmsrd that would clear MSR_RI */
+				return -1;
+			regs->msr = imm;
+			regs->nip += 4;
+			if ((imm & MSR_SF) == 0)
+				regs->nip &= 0xffffffffUL;
+			return 1;
+		}
+	}
+	return 0;
+}
diff -urN linux-2.5/arch/ppc64/xmon/xmon.c test/arch/ppc64/xmon/xmon.c
--- linux-2.5/arch/ppc64/xmon/xmon.c	2004-10-26 16:06:41.000000000 +1000
+++ test/arch/ppc64/xmon/xmon.c	2004-11-18 11:21:33.745317056 +1100
@@ -31,6 +31,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/cputable.h>
 #include <asm/rtas.h>
+#include <asm/sstep.h>
 
 #include "nonstdio.h"
 #include "privinst.h"
@@ -85,9 +86,6 @@
 
 #define BP_NUM(bp)	((bp) - bpts + 1)
 
-/* Bits in SRR1 that are copied from MSR */
-#define MSR_MASK	0xffffffff87c0ffff
-
 /* Prototypes */
 static int cmds(struct pt_regs *);
 static int mread(unsigned long, void *, int);
@@ -132,7 +130,6 @@
 static void bootcmds(void);
 void dump_segments(void);
 static void symbol_lookup(void);
-static int emulate_step(struct pt_regs *regs, unsigned int instr);
 static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after);
 static const char *getvecname(unsigned long vec);
@@ -148,7 +145,6 @@
 extern int setjmp(long *);
 extern void longjmp(long *, int);
 extern unsigned long _ASR;
-extern char SystemCall_common[];
 
 pte_t *find_linux_pte(pgd_t *pgdir, unsigned long va);	/* from htab.c */
 
@@ -488,6 +484,9 @@
 			if (stepped == 0) {
 				regs->nip = (unsigned long) &bp->instr[0];
 				atomic_inc(&bp->ref_count);
+			} else if (stepped < 0) {
+				printf("Couldn't single-step %s instruction\n",
+				    (IS_RFID(bp->instr[0])? "rfid": "mtmsrd"));
 			}
 		}
 	}
@@ -755,108 +754,6 @@
 		set_iabr(0);
 }
 
-static int branch_taken(unsigned int instr, struct pt_regs *regs)
-{
-	unsigned int bo = (instr >> 21) & 0x1f;
-	unsigned int bi;
-
-	if ((bo & 4) == 0) {
-		/* decrement counter */
-		--regs->ctr;
-		if (((bo >> 1) & 1) ^ (regs->ctr == 0))
-			return 0;
-	}
-	if ((bo & 0x10) == 0) {
-		/* check bit from CR */
-		bi = (instr >> 16) & 0x1f;
-		if (((regs->ccr >> (31 - bi)) & 1) != ((bo >> 3) & 1))
-			return 0;
-	}
-	return 1;
-}
-
-/*
- * Emulate instructions that cause a transfer of control.
- * Returns 1 if the step was emulated, 0 if not,
- * or -1 if the instruction is one that should not be stepped,
- * such as an rfid, or a mtmsrd that would clear MSR_RI.
- */
-static int emulate_step(struct pt_regs *regs, unsigned int instr)
-{
-	unsigned int opcode, rd;
-	unsigned long int imm;
-
-	opcode = instr >> 26;
-	switch (opcode) {
-	case 16:	/* bc */
-		imm = (signed short)(instr & 0xfffc);
-		if ((instr & 2) == 0)
-			imm += regs->nip;
-		regs->nip += 4;		/* XXX check 32-bit mode */
-		if (instr & 1)
-			regs->link = regs->nip;
-		if (branch_taken(instr, regs))
-			regs->nip = imm;
-		return 1;
-	case 17:	/* sc */
-		regs->gpr[9] = regs->gpr[13];
-		regs->gpr[11] = regs->nip + 4;
-		regs->gpr[12] = regs->msr & MSR_MASK;
-		regs->gpr[13] = (unsigned long) get_paca();
-		regs->nip = (unsigned long) &SystemCall_common;
-		regs->msr = MSR_KERNEL;
-		return 1;
-	case 18:	/* b */
-		imm = instr & 0x03fffffc;
-		if (imm & 0x02000000)
-			imm -= 0x04000000;
-		if ((instr & 2) == 0)
-			imm += regs->nip;
-		if (instr & 1)
-			regs->link = regs->nip + 4;
-		regs->nip = imm;
-		return 1;
-	case 19:
-		switch (instr & 0x7fe) {
-		case 0x20:	/* bclr */
-		case 0x420:	/* bcctr */
-			imm = (instr & 0x400)? regs->ctr: regs->link;
-			regs->nip += 4;		/* XXX check 32-bit mode */
-			if (instr & 1)
-				regs->link = regs->nip;
-			if (branch_taken(instr, regs))
-				regs->nip = imm;
-			return 1;
-		case 0x24:	/* rfid, scary */
-			printf("Can't single-step an rfid instruction\n");
-			return -1;
-		}
-	case 31:
-		rd = (instr >> 21) & 0x1f;
-		switch (instr & 0x7fe) {
-		case 0xa6:	/* mfmsr */
-			regs->gpr[rd] = regs->msr & MSR_MASK;
-			regs->nip += 4;
-			return 1;
-		case 0x164:	/* mtmsrd */
-			/* only MSR_EE and MSR_RI get changed if bit 15 set */
-			/* mtmsrd doesn't change MSR_HV and MSR_ME */
-			imm = (instr & 0x10000)? 0x8002: 0xefffffffffffefffUL;
-			imm = (regs->msr & MSR_MASK & ~imm)
-				| (regs->gpr[rd] & imm);
-			if ((imm & MSR_RI) == 0) {
-				printf("Can't step an instruction that would "
-				       "clear MSR.RI\n");
-				return -1;
-			}
-			regs->msr = imm;
-			regs->nip += 4;
-			return 1;
-		}
-	}
-	return 0;
-}
-
 /* Command interpreting routine */
 static char *last_cmd;
 
@@ -988,8 +885,11 @@
 	if ((regs->msr & (MSR_SF|MSR_PR|MSR_IR)) == (MSR_SF|MSR_IR)) {
 		if (mread(regs->nip, &instr, 4) == 4) {
 			stepped = emulate_step(regs, instr);
-			if (stepped < 0)
+			if (stepped < 0) {
+				printf("Couldn't single-step %s instruction\n",
+				       (IS_RFID(instr)? "rfid": "mtmsrd"));
 				return 0;
+			}
 			if (stepped > 0) {
 				regs->trap = 0xd00 | (regs->trap & 1);
 				printf("stepped to ");
diff -urN linux-2.5/include/asm-ppc64/sstep.h test/include/asm-ppc64/sstep.h
--- /dev/null	2004-08-12 23:33:25.000000000 +1000
+++ test/include/asm-ppc64/sstep.h	2004-11-18 11:14:59.596330520 +1100
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2004 Paul Mackerras <paulus@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+struct pt_regs;
+
+/* Emulate instructions that cause a transfer of control. */
+extern int emulate_step(struct pt_regs *regs, unsigned int instr);
