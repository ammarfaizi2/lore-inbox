Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUHMMsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUHMMsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUHMMsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:48:53 -0400
Received: from ozlabs.org ([203.10.76.45]:28117 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265148AbUHMMsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:48:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.46738.785770.150599@cargo.ozlabs.ibm.com>
Date: Fri, 13 Aug 2004 22:39:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org, olh@suse.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC32: Handle misaligned string/multiple insns
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to the ppc32 alignment exception handler to make
it handle the load/store string and load/store multiple word
instructions.  This is an issue for older CPUs such as the PPC601,
which traps on load/store string instructions which cross a page
boundary (newer CPUs handle this in hardware).  I have a little test
program which exercises this code, so I am reasonably confident it's
correct.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/align.c pmac-2.5/arch/ppc/kernel/align.c
--- linux-2.5/arch/ppc/kernel/align.c	2004-06-19 10:05:02.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/align.c	2004-08-10 19:32:23.000000000 +1000
@@ -37,6 +37,7 @@
 #define U	0x10	/* update index register */
 #define M	0x20	/* multiple load/store */
 #define S	0x40	/* single-precision fp, or byte-swap value */
+#define SX	0x40	/* byte count in XER */
 #define HARD	0x80	/* string, stwcx. */
 
 #define DCBZ	0x5f	/* 8xx/82xx dcbz faults when cache not enabled */
@@ -88,10 +89,10 @@
 	INVALID,		/* 01 0 0101: lwax */
 	INVALID,		/* 01 0 0110 */
 	INVALID,		/* 01 0 0111 */
-	{ 0, LD+HARD },		/* 01 0 1000: lswx */
-	{ 0, LD+HARD },		/* 01 0 1001: lswi */
-	{ 0, ST+HARD },		/* 01 0 1010: stswx */
-	{ 0, ST+HARD },		/* 01 0 1011: stswi */
+	{ 4, LD+M+HARD+SX },	/* 01 0 1000: lswx */
+	{ 4, LD+M+HARD },	/* 01 0 1001: lswi */
+	{ 4, ST+M+HARD+SX },	/* 01 0 1010: stswx */
+	{ 4, ST+M+HARD },	/* 01 0 1011: stswi */
 	INVALID,		/* 01 0 1100 */
 	INVALID,		/* 01 0 1101 */
 	INVALID,		/* 01 0 1110 */
@@ -189,7 +190,9 @@
 #endif
 	int i, t;
 	int reg, areg;
+	int offset, nb0;
 	unsigned char __user *addr;
+	unsigned char *rptr;
 	union {
 		long l;
 		float f;
@@ -206,7 +209,8 @@
 	 * an alignment fault.  -- paulus
 	 */
 
-	instr = *((unsigned int *)regs->nip);
+	if (__get_user(instr, (unsigned int __user *) regs->nip))
+		return 0;
 	opcode = OPCD(instr);
 	reg = RS(instr);
 	areg = RA(instr);
@@ -230,7 +234,7 @@
 
 	nb = aligninfo[instr].len;
 	if (nb == 0) {
-		long *p;
+		long __user *p;
 		int i;
 
 		if (instr != DCBZ)
@@ -242,13 +246,19 @@
 		 * case when we are running with the cache disabled
 		 * for debugging.
 		 */
-		p = (long *) (regs->dar & -L1_CACHE_BYTES);
+		p = (long __user *) (regs->dar & -L1_CACHE_BYTES);
+		if (user_mode(regs)
+		    && verify_area(VERIFY_WRITE, p, L1_CACHE_BYTES))
+			return -EFAULT;
 		for (i = 0; i < L1_CACHE_BYTES / sizeof(long); ++i)
-			p[i] = 0;
+			if (__put_user(0, p+i))
+				return -EFAULT;
 		return 1;
 	}
 
 	flags = aligninfo[instr].flags;
+	if ((flags & (LD|ST)) == 0)
+		return 0;
 
 	/* For the 4xx-family & Book-E processors, the 'dar' field of the
 	 * pt_regs structure is overloaded and is really from the DEAR.
@@ -256,6 +266,66 @@
 
 	addr = (unsigned char __user *)regs->dar;
 
+	if (flags & M) {
+		/* lmw, stmw, lswi/x, stswi/x */
+		nb0 = 0;
+		if (flags & HARD) {
+			if (flags & SX) {
+				nb = regs->xer & 127;
+				if (nb == 0)
+					return 1;
+			} else {
+				if (__get_user(instr,
+					    (unsigned int __user *)regs->nip))
+					return 0;
+				nb = (instr >> 11) & 0x1f;
+				if (nb == 0)
+					nb = 32;
+			}
+			if (nb + reg * 4 > 128) {
+				nb0 = nb + reg * 4 - 128;
+				nb = 128 - reg * 4;
+			}
+		} else {
+			/* lwm, stmw */
+			nb = (32 - reg) * 4;
+		}
+		rptr = (unsigned char *) &regs->gpr[reg];
+		if (flags & LD) {
+			for (i = 0; i < nb; ++i)
+				if (__get_user(rptr[i], addr+i))
+					return -EFAULT;
+			if (nb0 > 0) {
+				rptr = (unsigned char *) &regs->gpr[0];
+				addr += nb;
+				for (i = 0; i < nb0; ++i)
+					if (__get_user(rptr[i], addr+i))
+						return -EFAULT;
+			}
+			for (; (i & 3) != 0; ++i)
+				rptr[i] = 0;
+		} else {
+			for (i = 0; i < nb; ++i)
+				if (__put_user(rptr[i], addr+i))
+					return -EFAULT;
+			if (nb0 > 0) {
+				rptr = (unsigned char *) &regs->gpr[0];
+				addr += nb;
+				for (i = 0; i < nb0; ++i)
+					if (__put_user(rptr[i], addr+i))
+						return -EFAULT;
+			}
+		}
+		return 1;
+	}
+
+	offset = 0;
+	if (nb < 4) {
+		/* read/write the least significant bits */
+		data.l = 0;
+		offset = 4 - nb;
+	}
+
 	/* Verify the address of the operand */
 	if (user_mode(regs)) {
 		if (verify_area((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb))
@@ -268,45 +338,26 @@
 			giveup_fpu(current);
 		preempt_enable();
 	}
-	if (flags & M)
-		return 0;		/* too hard for now */
 
-	/* If we read the operand, copy it in */
+	/* If we read the operand, copy it in, else get register values */
 	if (flags & LD) {
-		if (nb == 2) {
-			data.v[0] = data.v[1] = 0;
-			if (__get_user(data.v[2], addr)
-			    || __get_user(data.v[3], addr+1))
+		for (i = 0; i < nb; ++i)
+			if (__get_user(data.v[offset+i], addr+i))
 				return -EFAULT;
-		} else {
-			for (i = 0; i < nb; ++i)
-				if (__get_user(data.v[i], addr+i))
-					return -EFAULT;
-		}
+	} else if (flags & F) {
+		data.d = current->thread.fpr[reg];
+	} else {
+		data.l = regs->gpr[reg];
 	}
 
 	switch (flags & ~U) {
-	case LD+SE:
+	case LD+SE:	/* sign extend */
 		if (data.v[2] >= 0x80)
 			data.v[0] = data.v[1] = -1;
-		/* fall through */
-	case LD:
-		regs->gpr[reg] = data.l;
-		break;
-	case LD+S:
-		if (nb == 2) {
-			SWAP(data.v[2], data.v[3]);
-		} else {
-			SWAP(data.v[0], data.v[3]);
-			SWAP(data.v[1], data.v[2]);
-		}
-		regs->gpr[reg] = data.l;
-		break;
-	case ST:
-		data.l = regs->gpr[reg];
 		break;
+
+	case LD+S:	/* byte-swap */
 	case ST+S:
-		data.l = regs->gpr[reg];
 		if (nb == 2) {
 			SWAP(data.v[2], data.v[3]);
 		} else {
@@ -314,50 +365,34 @@
 			SWAP(data.v[1], data.v[2]);
 		}
 		break;
-	case LD+F:
-		current->thread.fpr[reg] = data.d;
-		break;
-	case ST+F:
-		data.d = current->thread.fpr[reg];
-		break;
-	/* these require some floating point conversions... */
-	/* we'd like to use the assignment, but we have to compile
-	 * the kernel with -msoft-float so it doesn't use the
-	 * fp regs for copying 8-byte objects. */
+
+	/* Single-precision FP load and store require conversions... */
 	case LD+F+S:
 		preempt_disable();
 		enable_kernel_fp();
-		cvt_fd(&data.f, &current->thread.fpr[reg], &current->thread.fpscr);
-		/* current->thread.fpr[reg] = data.f; */
+		cvt_fd(&data.f, &data.d, &current->thread.fpscr);
 		preempt_enable();
 		break;
 	case ST+F+S:
 		preempt_disable();
 		enable_kernel_fp();
-		cvt_df(&current->thread.fpr[reg], &data.f, &current->thread.fpscr);
-		/* data.f = current->thread.fpr[reg]; */
+		cvt_df(&data.d, &data.f, &current->thread.fpscr);
 		preempt_enable();
 		break;
-	default:
-		printk("align: can't handle flags=%x\n", flags);
-		return 0;
 	}
 
 	if (flags & ST) {
-		if (nb == 2) {
-			if (__put_user(data.v[2], addr)
-			    || __put_user(data.v[3], addr+1))
+		for (i = 0; i < nb; ++i)
+			if (__put_user(data.v[offset+i], addr+i))
 				return -EFAULT;
-		} else {
-			for (i = 0; i < nb; ++i)
-				if (__put_user(data.v[i], addr+i))
-					return -EFAULT;
-		}
+	} else if (flags & F) {
+		current->thread.fpr[reg] = data.d;
+	} else {
+		regs->gpr[reg] = data.l;
 	}
 
-	if (flags & U) {
+	if (flags & U)
 		regs->gpr[areg] = regs->dar;
-	}
 
 	return 1;
 }
