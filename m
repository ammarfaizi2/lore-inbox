Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUEOIg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUEOIg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUEOIg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 04:36:27 -0400
Received: from ozlabs.org ([203.10.76.45]:55243 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264670AbUEOIfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 04:35:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16549.54870.831824.53961@cargo.ozlabs.ibm.com>
Date: Sat, 15 May 2004 18:35:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Handle altivec assist exception properly
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On machines with Altivec (i.e. G4 and G5 processors), the altivec
floating-point instructions can operate in two modes: one where
denormalized inputs or outputs are truncated to zero, and one where
they aren't.  In the latter mode the processor can take an exception
when it encounters denormalized floating-point inputs or outputs
rather than dealing with them in hardware.

This patch adds code to deal properly with the exception, by emulating
the instruction that caused the exception.  Previously the kernel
just switched the altivec unit into the truncate-to-zero mode, which
works but is a bit gross.  Fortunately there are only a limited set
of altivec instructions which can generate the assist exception, so we
don't have to emulate the whole altivec instruction set.

This patch also makes sure that we always have a handler for the
altivec unavailable exception.  Without this, if you run a kernel that
is not configured for altivec support on a machine with altivec, it
works fine until a user process tries to execute an altivec
instruction.  At that point the kernel thinks it has taken an unknown
exception and panics.  With this patch it sends a SIGILL to the
process instead.

Please apply.  I'll send a similar patch for ppc64 soon.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/kernel/Makefile ppc-2.5/arch/ppc/kernel/Makefile
--- linux-2.5/arch/ppc/kernel/Makefile	2004-02-06 22:15:13.000000000 +1100
+++ ppc-2.5/arch/ppc/kernel/Makefile	2004-05-15 17:46:57.005057600 +1000
@@ -29,6 +29,7 @@
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
+obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 
 ifdef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
diff -urN linux-2.5/arch/ppc/kernel/head.S ppc-2.5/arch/ppc/kernel/head.S
--- linux-2.5/arch/ppc/kernel/head.S	2004-05-06 09:37:13.000000000 +1000
+++ ppc-2.5/arch/ppc/kernel/head.S	2004-05-15 17:18:52.077955456 +1000
@@ -491,14 +491,16 @@
 /*
  * The Altivec unavailable trap is at 0x0f20.  Foo.
  * We effectively remap it to 0x3000.
+ * We include an altivec unavailable exception vector even if
+ * not configured for Altivec, so that you can't panic a
+ * non-altivec kernel running on a machine with altivec just
+ * by executing an altivec instruction.
  */
 	. = 0xf00
 	b	Trap_0f
 
 	. = 0xf20
-#ifdef CONFIG_ALTIVEC
 	b	AltiVecUnavailable
-#endif
 
 Trap_0f:
 	EXCEPTION_PROLOG
@@ -705,6 +707,7 @@
 #ifndef CONFIG_ALTIVEC
 #define AltivecAssistException	UnknownException
 #endif
+
 	EXCEPTION(0x1300, Trap_13, InstructionBreakpoint, EXC_XFER_EE)
 	EXCEPTION(0x1400, SMI, SMIException, EXC_XFER_EE)
 	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
@@ -746,12 +749,12 @@
 
 	. = 0x3000
 
-#ifdef CONFIG_ALTIVEC
 AltiVecUnavailable:
 	EXCEPTION_PROLOG
+#ifdef CONFIG_ALTIVEC
 	bne	load_up_altivec		/* if from user, just load it up */
-	EXC_XFER_EE_LITE(0xf20, KernelAltiVec)
 #endif /* CONFIG_ALTIVEC */
+	EXC_XFER_EE_LITE(0xf20, AltivecUnavailException)
 
 #ifdef CONFIG_PPC64BRIDGE
 DataAccess:
@@ -1633,7 +1636,7 @@
 	blr
 
 #endif /* CONFIG_POWER4 */
-	
+
 #ifdef CONFIG_8260
 /* Jump into the system reset for the rom.
  * We first disable the MMU, and then jump to the ROM reset address.
diff -urN linux-2.5/arch/ppc/kernel/traps.c ppc-2.5/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2004-05-15 13:32:15.618003856 +1000
+++ ppc-2.5/arch/ppc/kernel/traps.c	2004-05-15 17:19:43.756953480 +1000
@@ -631,17 +631,54 @@
 }
 #endif /* CONFIG_INT_TAU */
 
+void AltivecUnavailException(struct pt_regs *regs)
+{
+	static int kernel_altivec_count;
+
+#ifndef CONFIG_ALTIVEC
+	if (user_mode(regs)) {
+		/* A user program has executed an altivec instruction,
+		   but this kernel doesn't support altivec. */
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+#endif
+	/* The kernel has executed an altivec instruction without
+	   first enabling altivec.  Whinge but let it do it. */
+	if (++kernel_altivec_count < 10)
+		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%x)\n",
+		       current, regs->nip);
+	regs->msr |= MSR_VEC;
+}
+
 #ifdef CONFIG_ALTIVEC
 void
 AltivecAssistException(struct pt_regs *regs)
 {
+	int err;
+
 	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 	preempt_enable();
 
-	/* XXX quick hack for now: set the non-Java bit in the VSCR */
-	current->thread.vscr.u[3] |= 0x10000;
+	err = emulate_altivec(regs);
+	if (err == 0) {
+		regs->nip += 4;		/* skip emulated instruction */
+		emulate_single_step(regs);
+		return;
+	}
+
+	if (err == -EFAULT) {
+		/* got an error reading the instruction */
+		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
+	} else {
+		/* didn't recognize the instruction */
+		/* XXX quick hack for now: set the non-Java bit in the VSCR */
+		printk(KERN_ERR "unrecognized altivec instruction "
+		       "in %s at %lx\n", current->comm, regs->nip);
+		current->thread.vscr.u[3] |= 0x10000;
+	}
 }
 #endif /* CONFIG_ALTIVEC */
 
diff -urN linux-2.5/arch/ppc/kernel/vecemu.c ppc-2.5/arch/ppc/kernel/vecemu.c
--- linux-2.5/arch/ppc/kernel/vecemu.c	Thu Jan 01 10:00:00 1970
+++ ppc-2.5/arch/ppc/kernel/vecemu.c	Mon Nov 17 14:10:04 2003
@@ -0,0 +1,346 @@
+/*
+ * Routines to emulate some Altivec/VMX instructions, specifically
+ * those that can trap when given denormalized operands in Java mode.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+
+/* Functions in vector.S */
+extern void vaddfp(vector128 *dst, vector128 *a, vector128 *b);
+extern void vsubfp(vector128 *dst, vector128 *a, vector128 *b);
+extern void vmaddfp(vector128 *dst, vector128 *a, vector128 *b, vector128 *c);
+extern void vnmsubfp(vector128 *dst, vector128 *a, vector128 *b, vector128 *c);
+extern void vrefp(vector128 *dst, vector128 *src);
+extern void vrsqrtefp(vector128 *dst, vector128 *src);
+extern void vexptep(vector128 *dst, vector128 *src);
+
+static unsigned int exp2s[8] = {
+	0x800000,
+	0x8b95c2,
+	0x9837f0,
+	0xa5fed7,
+	0xb504f3,
+	0xc5672a,
+	0xd744fd,
+	0xeac0c7
+};
+
+/*
+ * Computes an estimate of 2^x.  The `s' argument is the 32-bit
+ * single-precision floating-point representation of x.
+ */
+static unsigned int eexp2(unsigned int s)
+{
+	int exp, pwr;
+	unsigned int mant, frac;
+
+	/* extract exponent field from input */
+	exp = ((s >> 23) & 0xff) - 127;
+	if (exp > 7) {
+		/* check for NaN input */
+		if (exp == 128 && (s & 0x7fffff) != 0)
+			return s | 0x400000;	/* return QNaN */
+		/* 2^-big = 0, 2^+big = +Inf */
+		return (s & 0x80000000)? 0: 0x7f800000;	/* 0 or +Inf */
+	}
+	if (exp < -23)
+		return 0x3f800000;	/* 1.0 */
+
+	/* convert to fixed point integer in 9.23 representation */
+	pwr = (s & 0x7fffff) | 0x800000;
+	if (exp > 0)
+		pwr <<= exp;
+	else
+		pwr >>= -exp;
+	if (s & 0x80000000)
+		pwr = -pwr;
+
+	/* extract integer part, which becomes exponent part of result */
+	exp = (pwr >> 23) + 126;
+	if (exp >= 254)
+		return 0x7f800000;
+	if (exp < -23)
+		return 0;
+
+	/* table lookup on top 3 bits of fraction to get mantissa */
+	mant = exp2s[(pwr >> 20) & 7];
+
+	/* linear interpolation using remaining 20 bits of fraction */
+	asm("mulhwu %0,%1,%2" : "=r" (frac)
+	    : "r" (pwr << 12), "r" (0x172b83ff));
+	asm("mulhwu %0,%1,%2" : "=r" (frac) : "r" (frac), "r" (mant));
+	mant += frac;
+
+	if (exp >= 0)
+		return mant + (exp << 23);
+
+	/* denormalized result */
+	exp = -exp;
+	mant += 1 << (exp - 1);
+	return mant >> exp;
+}
+
+/*
+ * Computes an estimate of log_2(x).  The `s' argument is the 32-bit
+ * single-precision floating-point representation of x.
+ */
+static unsigned int elog2(unsigned int s)
+{
+	int exp, mant, lz, frac;
+
+	exp = s & 0x7f800000;
+	mant = s & 0x7fffff;
+	if (exp == 0x7f800000) {	/* Inf or NaN */
+		if (mant != 0)
+			s |= 0x400000;	/* turn NaN into QNaN */
+		return s;
+	}
+	if ((exp | mant) == 0)		/* +0 or -0 */
+		return 0xff800000;	/* return -Inf */
+
+	if (exp == 0) {
+		/* denormalized */
+		asm("cntlzw %0,%1" : "=r" (lz) : "r" (mant));
+		mant <<= lz - 8;
+		exp = (-118 - lz) << 23;
+	} else {
+		mant |= 0x800000;
+		exp -= 127 << 23;
+	}
+
+	if (mant >= 0xb504f3) {				/* 2^0.5 * 2^23 */
+		exp |= 0x400000;			/* 0.5 * 2^23 */
+		asm("mulhwu %0,%1,%2" : "=r" (mant)
+		    : "r" (mant), "r" (0xb504f334));	/* 2^-0.5 * 2^32 */
+	}
+	if (mant >= 0x9837f0) {				/* 2^0.25 * 2^23 */
+		exp |= 0x200000;			/* 0.25 * 2^23 */
+		asm("mulhwu %0,%1,%2" : "=r" (mant)
+		    : "r" (mant), "r" (0xd744fccb));	/* 2^-0.25 * 2^32 */
+	}
+	if (mant >= 0x8b95c2) {				/* 2^0.125 * 2^23 */
+		exp |= 0x100000;			/* 0.125 * 2^23 */
+		asm("mulhwu %0,%1,%2" : "=r" (mant)
+		    : "r" (mant), "r" (0xeac0c6e8));	/* 2^-0.125 * 2^32 */
+	}
+	if (mant > 0x800000) {				/* 1.0 * 2^23 */
+		/* calculate (mant - 1) * 1.381097463 */
+		/* 1.381097463 == 0.125 / (2^0.125 - 1) */
+		asm("mulhwu %0,%1,%2" : "=r" (frac)
+		    : "r" ((mant - 0x800000) << 1), "r" (0xb0c7cd3a));
+		exp += frac;
+	}
+	s = exp & 0x80000000;
+	if (exp != 0) {
+		if (s)
+			exp = -exp;
+		asm("cntlzw %0,%1" : "=r" (lz) : "r" (exp));
+		lz = 8 - lz;
+		if (lz > 0)
+			exp >>= lz;
+		else if (lz < 0)
+			exp <<= -lz;
+		s += ((lz + 126) << 23) + exp;
+	}
+	return s;
+}
+
+#define VSCR_SAT	1
+
+static int ctsxs(unsigned int x, int scale, unsigned int *vscrp)
+{
+	int exp, mant;
+
+	exp = (x >> 23) & 0xff;
+	mant = x & 0x7fffff;
+	if (exp == 255 && mant != 0)
+		return 0;		/* NaN -> 0 */
+	exp = exp - 127 + scale;
+	if (exp < 0)
+		return 0;		/* round towards zero */
+	if (exp >= 31) {
+		/* saturate, unless the result would be -2^31 */
+		if (x + (scale << 23) != 0xcf000000)
+			*vscrp |= VSCR_SAT;
+		return (x & 0x80000000)? 0x80000000: 0x7fffffff;
+	}
+	mant |= 0x800000;
+	mant = (mant << 7) >> (30 - exp);
+	return (x & 0x80000000)? -mant: mant;
+}
+
+static unsigned int ctuxs(unsigned int x, int scale, unsigned int *vscrp)
+{
+	int exp;
+	unsigned int mant;
+
+	exp = (x >> 23) & 0xff;
+	mant = x & 0x7fffff;
+	if (exp == 255 && mant != 0)
+		return 0;		/* NaN -> 0 */
+	exp = exp - 127 + scale;
+	if (exp < 0)
+		return 0;		/* round towards zero */
+	if (x & 0x80000000) {
+		/* negative => saturate to 0 */
+		*vscrp |= VSCR_SAT;
+		return 0;
+	}
+	if (exp >= 32) {
+		/* saturate */
+		*vscrp |= VSCR_SAT;
+		return 0xffffffff;
+	}
+	mant |= 0x800000;
+	mant = (mant << 8) >> (31 - exp);
+	return mant;
+}
+
+/* Round to floating integer, towards 0 */
+static unsigned int rfiz(unsigned int x)
+{
+	int exp;
+
+	exp = ((x >> 23) & 0xff) - 127;
+	if (exp == 128 && (x & 0x7fffff) != 0)
+		return x | 0x400000;	/* NaN -> make it a QNaN */
+	if (exp >= 23)
+		return x;		/* it's an integer already (or Inf) */
+	if (exp < 0)
+		return x & 0x80000000;	/* |x| < 1.0 rounds to 0 */
+	return x & ~(0x7fffff >> exp);
+}
+
+/* Round to floating integer, towards +/- Inf */
+static unsigned int rfii(unsigned int x)
+{
+	int exp, mask;
+
+	exp = ((x >> 23) & 0xff) - 127;
+	if (exp == 128 && (x & 0x7fffff) != 0)
+		return x | 0x400000;	/* NaN -> make it a QNaN */
+	if (exp >= 23)
+		return x;		/* it's an integer already (or Inf) */
+	if ((x & 0x7fffffff) == 0)
+		return x;		/* +/-0 -> +/-0 */
+	if (exp < 0)
+		/* 0 < |x| < 1.0 rounds to +/- 1.0 */
+		return (x & 0x80000000) | 0x3f800000;
+	mask = 0x7fffff >> exp;
+	/* mantissa overflows into exponent - that's OK,
+	   it can't overflow into the sign bit */
+	return (x + mask) & ~mask;
+}
+
+/* Round to floating integer, to nearest */
+static unsigned int rfin(unsigned int x)
+{
+	int exp, half;
+
+	exp = ((x >> 23) & 0xff) - 127;
+	if (exp == 128 && (x & 0x7fffff) != 0)
+		return x | 0x400000;	/* NaN -> make it a QNaN */
+	if (exp >= 23)
+		return x;		/* it's an integer already (or Inf) */
+	if (exp < -1)
+		return x & 0x80000000;	/* |x| < 0.5 -> +/-0 */
+	if (exp == -1)
+		/* 0.5 <= |x| < 1.0 rounds to +/- 1.0 */
+		return (x & 0x80000000) | 0x3f800000;
+	half = 0x400000 >> exp;
+	/* add 0.5 to the magnitude and chop off the fraction bits */
+	return (x + half) & ~(0x7fffff >> exp);
+}
+
+int
+emulate_altivec(struct pt_regs *regs)
+{
+	unsigned int instr, i;
+	unsigned int va, vb, vc, vd;
+	vector128 *vrs;
+
+	if (get_user(instr, (unsigned int *) regs->nip))
+		return -EFAULT;
+	if ((instr >> 26) != 4)
+		return -EINVAL;		/* not an altivec instruction */
+	vd = (instr >> 21) & 0x1f;
+	va = (instr >> 16) & 0x1f;
+	vb = (instr >> 11) & 0x1f;
+	vc = (instr >> 6) & 0x1f;
+
+	vrs = current->thread.vr;
+	switch (instr & 0x3f) {
+	case 10:
+		switch (vc) {
+		case 0:	/* vaddfp */
+			vaddfp(&vrs[vd], &vrs[va], &vrs[vb]);
+			break;
+		case 1:	/* vsubfp */
+			vsubfp(&vrs[vd], &vrs[va], &vrs[vb]);
+			break;
+		case 4:	/* vrefp */
+			vrefp(&vrs[vd], &vrs[vb]);
+			break;
+		case 5:	/* vrsqrtefp */
+			vrsqrtefp(&vrs[vd], &vrs[vb]);
+			break;
+		case 6:	/* vexptefp */
+			for (i = 0; i < 4; ++i)
+				vrs[vd].u[i] = eexp2(vrs[vb].u[i]);
+			break;
+		case 7:	/* vlogefp */
+			for (i = 0; i < 4; ++i)
+				vrs[vd].u[i] = elog2(vrs[vb].u[i]);
+			break;
+		case 8:		/* vrfin */
+			for (i = 0; i < 4; ++i)
+				vrs[vd].u[i] = rfin(vrs[vb].u[i]);
+			break;
+		case 9:		/* vrfiz */
+			for (i = 0; i < 4; ++i)
+				vrs[vd].u[i] = rfiz(vrs[vb].u[i]);
+			break;
+		case 10:	/* vrfip */
+			for (i = 0; i < 4; ++i) {
+				u32 x = vrs[vb].u[i];
+				x = (x & 0x80000000)? rfiz(x): rfii(x);
+				vrs[vd].u[i] = x;
+			}
+			break;
+		case 11:	/* vrfim */
+			for (i = 0; i < 4; ++i) {
+				u32 x = vrs[vb].u[i];
+				x = (x & 0x80000000)? rfii(x): rfiz(x);
+				vrs[vd].u[i] = x;
+			}
+			break;
+		case 14:	/* vctuxs */
+			for (i = 0; i < 4; ++i)
+				vrs[vd].u[i] = ctuxs(vrs[vb].u[i], va,
+						&current->thread.vscr.u[3]);
+			break;
+		case 15:	/* vctsxs */
+			for (i = 0; i < 4; ++i)
+				vrs[vd].u[i] = ctsxs(vrs[vb].u[i], va,
+						&current->thread.vscr.u[3]);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case 46:	/* vmaddfp */
+		vmaddfp(&vrs[vd], &vrs[va], &vrs[vb], &vrs[vc]);
+		break;
+	case 47:	/* vnmsubfp */
+		vnmsubfp(&vrs[vd], &vrs[va], &vrs[vb], &vrs[vc]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff -urN linux-2.5/arch/ppc/kernel/vector.S ppc-2.5/arch/ppc/kernel/vector.S
--- linux-2.5/arch/ppc/kernel/vector.S	Thu Jan 01 10:00:00 1970
+++ ppc-2.5/arch/ppc/kernel/vector.S	Mon Nov 17 14:12:31 2003
@@ -0,0 +1,217 @@
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+/*
+ * The routines below are in assembler so we can closely control the
+ * usage of floating-point registers.  These routines must be called
+ * with preempt disabled.
+ */
+	.data
+fpzero:
+	.long	0
+fpone:
+	.long	0x3f800000	/* 1.0 in single-precision FP */
+fphalf:
+	.long	0x3f000000	/* 0.5 in single-precision FP */
+
+	.text
+/*
+ * Internal routine to enable floating point and set FPSCR to 0.
+ * Don't call it from C; it doesn't use the normal calling convention.
+ */
+fpenable:
+	mfmsr	r10
+	ori	r11,r10,MSR_FP
+	mtmsr	r11
+	isync
+	stfd	fr0,24(r1)
+	stfd	fr1,16(r1)
+	stfd	fr31,8(r1)
+	lis	r11,fpzero@ha
+	mffs	fr31
+	lfs	fr1,fpzero@l(r11)
+	mtfsf	0xff,fr1
+	blr
+
+fpdisable:
+	mtfsf	0xff,fr31
+	lfd	fr31,8(r1)
+	lfd	fr1,16(r1)
+	lfd	fr0,24(r1)
+	mtmsr	r10
+	isync
+	blr
+
+/*
+ * Vector add, floating point.
+ */
+	.globl	vaddfp
+vaddfp:
+	stwu	r1,-32(r1)
+	mflr	r0
+	stw	r0,36(r1)
+	bl	fpenable
+	li	r0,4
+	mtctr	r0
+	li	r6,0
+1:	lfsx	fr0,r4,r6
+	lfsx	fr1,r5,r6
+	fadds	fr0,fr0,fr1
+	stfsx	fr0,r3,r6
+	addi	r6,r6,4
+	bdnz	1b
+	bl	fpdisable
+	lwz	r0,36(r1)
+	mtlr	r0
+	addi	r1,r1,32
+	blr
+
+/*
+ * Vector subtract, floating point.
+ */
+	.globl	vsubfp
+vsubfp:
+	stwu	r1,-32(r1)
+	mflr	r0
+	stw	r0,36(r1)
+	bl	fpenable
+	li	r0,4
+	mtctr	r0
+	li	r6,0
+1:	lfsx	fr0,r4,r6
+	lfsx	fr1,r5,r6
+	fsubs	fr0,fr0,fr1
+	stfsx	fr0,r3,r6
+	addi	r6,r6,4
+	bdnz	1b
+	bl	fpdisable
+	lwz	r0,36(r1)
+	mtlr	r0
+	addi	r1,r1,32
+	blr
+
+/*
+ * Vector multiply and add, floating point.
+ */
+	.globl	vmaddfp
+vmaddfp:
+	stwu	r1,-48(r1)
+	mflr	r0
+	stw	r0,52(r1)
+	bl	fpenable
+	stfd	fr2,32(r1)
+	li	r0,4
+	mtctr	r0
+	li	r7,0
+1:	lfsx	fr0,r4,r7
+	lfsx	fr1,r5,r7
+	lfsx	fr2,r6,r7
+	fmadds	fr0,fr0,fr1,fr2
+	stfsx	fr0,r3,r7
+	addi	r7,r7,4
+	bdnz	1b
+	lfd	fr2,32(r1)
+	bl	fpdisable
+	lwz	r0,52(r1)
+	mtlr	r0
+	addi	r1,r1,48
+	blr
+
+/*
+ * Vector negative multiply and subtract, floating point.
+ */
+	.globl	vnmsubfp
+vnmsubfp:
+	stwu	r1,-48(r1)
+	mflr	r0
+	stw	r0,52(r1)
+	bl	fpenable
+	stfd	fr2,32(r1)
+	li	r0,4
+	mtctr	r0
+	li	r7,0
+1:	lfsx	fr0,r4,r7
+	lfsx	fr1,r5,r7
+	lfsx	fr2,r6,r7
+	fnmsubs	fr0,fr0,fr1,fr2
+	stfsx	fr0,r3,r7
+	addi	r7,r7,4
+	bdnz	1b
+	lfd	fr2,32(r1)
+	bl	fpdisable
+	lwz	r0,52(r1)
+	mtlr	r0
+	addi	r1,r1,48
+	blr
+
+/*
+ * Vector reciprocal estimate.  We just compute 1.0/x.
+ * r3 -> destination, r4 -> source.
+ */
+	.globl	vrefp
+vrefp:
+	stwu	r1,-32(r1)
+	mflr	r0
+	stw	r0,36(r1)
+	bl	fpenable
+	lis	r9,fpone@ha
+	li	r0,4
+	lfs	fr1,fpone@l(r9)
+	mtctr	r0
+	li	r6,0
+1:	lfsx	fr0,r4,r6
+	fdivs	fr0,fr1,fr0
+	stfsx	fr0,r3,r6
+	addi	r6,r6,4
+	bdnz	1b
+	bl	fpdisable
+	lwz	r0,36(r1)
+	mtlr	r0
+	addi	r1,r1,32
+	blr
+
+/*
+ * Vector reciprocal square-root estimate, floating point.
+ * We use the frsqrte instruction for the initial estimate followed
+ * by 2 iterations of Newton-Raphson to get sufficient accuracy.
+ * r3 -> destination, r4 -> source.
+ */
+	.globl	vrsqrtefp
+vrsqrtefp:
+	stwu	r1,-48(r1)
+	mflr	r0
+	stw	r0,52(r1)
+	bl	fpenable
+	stfd	fr2,32(r1)
+	stfd	fr3,40(r1)
+	stfd	fr4,48(r1)
+	stfd	fr5,56(r1)
+	lis	r9,fpone@ha
+	lis	r8,fphalf@ha
+	li	r0,4
+	lfs	fr4,fpone@l(r9)
+	lfs	fr5,fphalf@l(r8)
+	mtctr	r0
+	li	r6,0
+1:	lfsx	fr0,r4,r6
+	frsqrte	fr1,fr0		/* r = frsqrte(s) */
+	fmuls	fr3,fr1,fr0	/* r * s */
+	fmuls	fr2,fr1,fr5	/* r * 0.5 */
+	fnmsubs	fr3,fr1,fr3,fr4	/* 1 - s * r * r */
+	fmadds	fr1,fr2,fr3,fr1	/* r = r + 0.5 * r * (1 - s * r * r) */
+	fmuls	fr3,fr1,fr0	/* r * s */
+	fmuls	fr2,fr1,fr5	/* r * 0.5 */
+	fnmsubs	fr3,fr1,fr3,fr4	/* 1 - s * r * r */
+	fmadds	fr1,fr2,fr3,fr1	/* r = r + 0.5 * r * (1 - s * r * r) */
+	stfsx	fr1,r3,r6
+	addi	r6,r6,4
+	bdnz	1b
+	lfd	fr5,56(r1)
+	lfd	fr4,48(r1)
+	lfd	fr3,40(r1)
+	lfd	fr2,32(r1)
+	bl	fpdisable
+	lwz	r0,36(r1)
+	mtlr	r0
+	addi	r1,r1,32
+	blr
