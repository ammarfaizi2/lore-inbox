Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTH2O6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTH2O5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:57:31 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:63022 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261318AbTH2OwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:07 -0400
Date: Fri, 29 Aug 2003 16:51:14 +0200
Message-Id: <200308291451.h7TEpE6v005926@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k FPU emulator
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k FPU emulator: Add fgetman, fgetexp and fsqrt (from Michael Müller and
Roman Zippel)

--- linux-2.4.23-pre1/arch/m68k/math-emu/fp_emu.h	Mon Apr  1 13:00:29 2002
+++ linux-m68k-2.4.23-pre1/arch/m68k/math-emu/fp_emu.h	Wed Jul 23 22:06:23 2003
@@ -115,6 +115,15 @@
 	__res;							\
 })
 
+#define fp_conv_long2ext(dest, src) ({				\
+	register struct fp_ext *__dest asm ("a0") = dest;	\
+	register int __src asm ("d0") = src;			\
+								\
+	asm volatile ("jsr fp_conv_ext2long"			\
+			: : "d" (__src), "a" (__dest)		\
+			: "a1", "d1", "d2", "memory");		\
+})
+
 #else /* __ASSEMBLY__ */
 
 /*
--- linux-2.4.23-pre1/arch/m68k/math-emu/fp_log.c	Sun Aug 15 20:47:29 1999
+++ linux-m68k-2.4.23-pre1/arch/m68k/math-emu/fp_log.c	Wed Jul 23 22:06:23 2003
@@ -17,10 +17,22 @@
 
 #include "fp_emu.h"
 
+static const struct fp_ext fp_one =
+{
+	0, 0, 0x3fff, { 0 }
+};
+
+extern struct fp_ext *fp_fadd(struct fp_ext *dest, const struct fp_ext *src);
+extern struct fp_ext *fp_fdiv(struct fp_ext *dest, const struct fp_ext *src);
+extern struct fp_ext *fp_fmul(struct fp_ext *dest, const struct fp_ext *src);
+
 struct fp_ext *
 fp_fsqrt(struct fp_ext *dest, struct fp_ext *src)
 {
-	uprint("fsqrt\n");
+	struct fp_ext tmp, src2;
+	int i, exp;
+
+	dprint(PINSTR, "fsqrt\n");
 
 	fp_monadic_check(dest, src);
 
@@ -34,6 +46,56 @@
 	if (IS_INF(dest))
 		return dest;
 
+	/*
+	 *		 sqrt(m) * 2^(p)	, if e = 2*p
+	 * sqrt(m*2^e) = 
+	 *		 sqrt(2*m) * 2^(p)	, if e = 2*p + 1
+	 *
+	 * So we use the last bit of the exponent to decide wether to
+	 * use the m or 2*m.
+	 *
+	 * Since only the fractional part of the mantissa is stored and
+	 * the integer part is assumed to be one, we place a 1 or 2 into
+	 * the fixed point representation.
+	 */
+	exp = dest->exp;
+	dest->exp = 0x3FFF;
+	if (!(exp & 1))		/* lowest bit of exponent is set */
+		dest->exp++;
+	fp_copy_ext(&src2, dest);
+
+	/*
+	 * The taylor row arround a for sqrt(x) is:
+	 *	sqrt(x) = sqrt(a) + 1/(2*sqrt(a))*(x-a) + R
+	 * With a=1 this gives:
+	 *	sqrt(x) = 1 + 1/2*(x-1)
+	 *		= 1/2*(1+x)
+	 */
+	fp_fadd(dest, &fp_one);
+	dest->exp--;		/* * 1/2 */
+
+	/*
+	 * We now apply the newton rule to the function
+	 *	f(x) := x^2 - r
+	 * which has a null point on x = sqrt(r).
+	 *
+	 * It gives:
+	 * 	x' := x - f(x)/f'(x)
+	 *	    = x - (x^2 -r)/(2*x)
+	 *	    = x - (x - r/x)/2
+	 *          = (2*x - x + r/x)/2
+	 *	    = (x + r/x)/2
+	 */
+	for (i = 0; i < 9; i++) {
+		fp_copy_ext(&tmp, &src2);
+
+		fp_fdiv(&tmp, dest);
+		fp_fadd(dest, &tmp);
+		dest->exp--;
+	}
+
+	dest->exp += (exp - 0x3FFF) / 2;
+
 	return dest;
 }
 
@@ -123,19 +185,38 @@
 struct fp_ext *
 fp_fgetexp(struct fp_ext *dest, struct fp_ext *src)
 {
-	uprint("fgetexp\n");
+	dprint(PINSTR, "fgetexp\n");
 
 	fp_monadic_check(dest, src);
 
+	if (IS_INF(dest)) {
+		fp_set_nan(dest);
+		return dest;
+	}
+	if (IS_ZERO(dest))
+		return dest;
+
+	fp_conv_long2ext(dest, (int)dest->exp - 0x3FFF);
+
+	fp_normalize_ext(dest);
+
 	return dest;
 }
 
 struct fp_ext *
 fp_fgetman(struct fp_ext *dest, struct fp_ext *src)
 {
-	uprint("fgetman\n");
+	dprint(PINSTR, "fgetman\n");
 
 	fp_monadic_check(dest, src);
+
+	if (IS_ZERO(dest))
+		return dest;
+
+	if (IS_INF(dest))
+		return dest;
+
+	dest->exp = 0x3FFF;
 
 	return dest;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
