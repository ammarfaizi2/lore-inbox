Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUFWAng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUFWAng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUFWAng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:43:36 -0400
Received: from ozlabs.org ([203.10.76.45]:9103 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265115AbUFWAmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:42:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.49822.580683.770735@cargo.ozlabs.ibm.com>
Date: Wed, 23 Jun 2004 09:37:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Handle altivec assist exception properly
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the PPC64 counterpart of the PPC32 Altivec assist exception
handler that went in recently.

On PPC64 machines with Altivec (i.e. machines that use the PPC970
chip, such as the G5 powermac), the altivec floating-point
instructions can operate in two modes: one where denormalized inputs
or outputs are truncated to zero, and one where they aren't.  In the
latter mode the processor can take an exception when it encounters
denormalized floating-point inputs or outputs rather than dealing with
them in hardware.

This patch adds code to deal properly with the exception, by emulating the
instruction that caused the exception.  Previously the kernel just switched
the altivec unit into the truncate-to-zero mode, which works but is a bit
gross.  Fortunately there are only a limited set of altivec instructions
which can generate the assist exception, so we don't have to emulate the
whole altivec instruction set.

Note that Altivec is Motorola's name for the PowerPC vector/SIMD
instructions; IBM calls the same thing VMX, and currently only IBM
makes 64-bit PowerPC CPU chips.  Nevertheless, I have used the term
Altivec in the PPC64 code for consistency with the PPC32 code.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/Makefile test25/arch/ppc64/kernel/Makefile
--- linux-2.5/arch/ppc64/kernel/Makefile	2004-04-13 09:25:09.000000000 +1000
+++ test25/arch/ppc64/kernel/Makefile	2004-06-23 09:03:59.592925968 +1000
@@ -56,4 +56,6 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
 endif
 
+obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+
 CFLAGS_ioctl32.o += -Ifs/
diff -urN linux-2.5/arch/ppc64/kernel/traps.c test25/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-06-18 19:06:50.000000000 +1000
+++ test25/arch/ppc64/kernel/traps.c	2004-06-23 09:05:33.429904472 +1000
@@ -544,9 +544,39 @@
 void
 AltivecAssistException(struct pt_regs *regs)
 {
+	int err;
+	siginfo_t info;
+
+	if (!user_mode(regs)) {
+		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
+		       " at %lx\n", regs->nip);
+		die("Kernel VMX/Altivec assist exception", regs, SIGILL);
+	}
+
 	flush_altivec_to_thread(current);
-	/* XXX quick hack for now: set the non-Java bit in the VSCR */
-	current->thread.vscr.u[3] |= 0x10000;
+
+	err = emulate_altivec(regs);
+	if (err == 0) {
+		regs->nip += 4;		/* skip emulated instruction */
+		emulate_single_step(regs);
+		return;
+	}
+
+	if (err == -EFAULT) {
+		/* got an error reading the instruction */
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		info.si_code = SEGV_MAPERR;
+		info.si_addr = (void *) regs->nip;
+		force_sig_info(SIGSEGV, &info, current);
+	} else {
+		/* didn't recognize the instruction */
+		/* XXX quick hack for now: set the non-Java bit in the VSCR */
+		if (printk_ratelimit())
+			printk(KERN_ERR "Unrecognized altivec instruction "
+			       "in %s at %lx\n", current->comm, regs->nip);
+		current->thread.vscr.u[3] |= 0x10000;
+	}
 }
 #endif /* CONFIG_ALTIVEC */
 
diff -urN linux-2.5/arch/ppc64/kernel/vecemu.c test25/arch/ppc64/kernel/vecemu.c
--- /dev/null	2004-06-08 10:44:27.000000000 +1000
+++ test25/arch/ppc64/kernel/vecemu.c	2004-06-23 09:03:59.597925208 +1000
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
diff -urN linux-2.5/arch/ppc64/kernel/vector.S test25/arch/ppc64/kernel/vector.S
--- /dev/null	2004-06-08 10:44:27.000000000 +1000
+++ test25/arch/ppc64/kernel/vector.S	2004-06-23 09:03:59.598925056 +1000
@@ -0,0 +1,172 @@
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+/*
+ * The routines below are in assembler so we can closely control the
+ * usage of floating-point registers.  These routines must be called
+ * with preempt disabled.
+ */
+	.section ".toc","aw"
+fpzero:
+	.tc	FD_0_0[TC],0
+fpone:
+	.tc	FD_3ff00000_0[TC],0x3ff0000000000000	/* 1.0 */
+fphalf:
+	.tc	FD_3fe00000_0[TC],0x3fe0000000000000	/* 0.5 */
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
+	stfd	fr31,-8(r1)
+	stfd	fr0,-16(r1)
+	stfd	fr1,-24(r1)
+	mffs	fr31
+	lfd	fr1,fpzero@toc(r2)
+	mtfsf	0xff,fr1
+	blr
+
+fpdisable:
+	mtlr	r12
+	mtfsf	0xff,fr31
+	lfd	fr1,-24(r1)
+	lfd	fr0,-16(r1)
+	lfd	fr31,-8(r1)
+	mtmsr	r10
+	isync
+	blr
+
+/*
+ * Vector add, floating point.
+ */
+_GLOBAL(vaddfp)
+	mflr	r12
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
+	b	fpdisable
+
+/*
+ * Vector subtract, floating point.
+ */
+_GLOBAL(vsubfp)
+	mflr	r12
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
+	b	fpdisable
+
+/*
+ * Vector multiply and add, floating point.
+ */
+_GLOBAL(vmaddfp)
+	mflr	r12
+	bl	fpenable
+	stfd	fr2,-32(r1)
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
+	lfd	fr2,-32(r1)
+	b	fpdisable
+
+/*
+ * Vector negative multiply and subtract, floating point.
+ */
+_GLOBAL(vnmsubfp)
+	mflr	r12
+	bl	fpenable
+	stfd	fr2,-32(r1)
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
+	lfd	fr2,-32(r1)
+	b	fpdisable
+
+/*
+ * Vector reciprocal estimate.  We just compute 1.0/x.
+ * r3 -> destination, r4 -> source.
+ */
+_GLOBAL(vrefp)
+	mflr	r12
+	bl	fpenable
+	li	r0,4
+	lfd	fr1,fpone@toc(r2)
+	mtctr	r0
+	li	r6,0
+1:	lfsx	fr0,r4,r6
+	fdivs	fr0,fr1,fr0
+	stfsx	fr0,r3,r6
+	addi	r6,r6,4
+	bdnz	1b
+	b	fpdisable
+
+/*
+ * Vector reciprocal square-root estimate, floating point.
+ * We use the frsqrte instruction for the initial estimate followed
+ * by 2 iterations of Newton-Raphson to get sufficient accuracy.
+ * r3 -> destination, r4 -> source.
+ */
+_GLOBAL(vrsqrtefp)
+	mflr	r12
+	bl	fpenable
+	stfd	fr2,-32(r1)
+	stfd	fr3,-40(r1)
+	stfd	fr4,-48(r1)
+	stfd	fr5,-56(r1)
+	li	r0,4
+	lfd	fr4,fpone@toc(r2)
+	lfd	fr5,fphalf@toc(r2)
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
+	lfd	fr5,-56(r1)
+	lfd	fr4,-48(r1)
+	lfd	fr3,-40(r1)
+	lfd	fr2,-32(r1)
+	b	fpdisable
diff -urN linux-2.5/include/asm-ppc64/system.h test25/include/asm-ppc64/system.h
--- linux-2.5/include/asm-ppc64/system.h	2004-06-21 20:50:02.000000000 +1000
+++ test25/include/asm-ppc64/system.h	2004-06-23 09:03:59.599924904 +1000
@@ -116,6 +116,7 @@
 extern void giveup_altivec(struct task_struct *);
 extern void disable_kernel_altivec(void);
 extern void enable_kernel_altivec(void);
+extern int emulate_altivec(struct pt_regs *);
 extern void cvt_fd(float *from, double *to, unsigned long *fpscr);
 extern void cvt_df(double *from, float *to, unsigned long *fpscr);
 
