Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSKCDeR>; Sat, 2 Nov 2002 22:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSKCDeR>; Sat, 2 Nov 2002 22:34:17 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:52950 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S261581AbSKCDeO>; Sat, 2 Nov 2002 22:34:14 -0500
Message-ID: <3DC49ABE.2020801@quark.didntduck.org>
Date: Sat, 02 Nov 2002 22:40:46 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Dead code in i386 math-emu
Content-Type: multipart/mixed;
 boundary="------------030100070106070909080407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030100070106070909080407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This removes unused non-reentrant code in the fpu emulator.

--
				Brian Gerst

--------------030100070106070909080407
Content-Type: text/plain;
 name="mathemu-dead-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mathemu-dead-1"

diff -urN linux-2.5.45-bk1/arch/i386/math-emu/div_Xsig.S linux/arch/i386/math-emu/div_Xsig.S
--- linux-2.5.45-bk1/arch/i386/math-emu/div_Xsig.S	Sun Sep 15 22:18:24 2002
+++ linux/arch/i386/math-emu/div_Xsig.S	Sat Nov  2 22:17:52 2002
@@ -36,7 +36,6 @@
 #define	XsigH(x)	8(x)
 
 
-#ifndef NON_REENTRANT_FPU
 /*
 	Local storage on the stack:
 	Accumulator:	FPU_accum_3:FPU_accum_2:FPU_accum_1:FPU_accum_0
@@ -49,37 +48,12 @@
 #define FPU_result_2	-24(%ebp)
 #define FPU_result_1	-28(%ebp)
 
-#else
-.data
-/*
-	Local storage in a static area:
-	Accumulator:	FPU_accum_3:FPU_accum_2:FPU_accum_1:FPU_accum_0
- */
-	.align 4,0
-FPU_accum_3:
-	.long	0
-FPU_accum_2:
-	.long	0
-FPU_accum_1:
-	.long	0
-FPU_accum_0:
-	.long	0
-FPU_result_3:
-	.long	0
-FPU_result_2:
-	.long	0
-FPU_result_1:
-	.long	0
-#endif /* NON_REENTRANT_FPU */
-
 
 .text
 ENTRY(div_Xsig)
 	pushl	%ebp
 	movl	%esp,%ebp
-#ifndef NON_REENTRANT_FPU
 	subl	$28,%esp
-#endif /* NON_REENTRANT_FPU */ 
 
 	pushl	%esi
 	pushl	%edi
diff -urN linux-2.5.45-bk1/arch/i386/math-emu/reg_round.S linux/arch/i386/math-emu/reg_round.S
--- linux-2.5.45-bk1/arch/i386/math-emu/reg_round.S	Sun Sep 15 22:18:48 2002
+++ linux/arch/i386/math-emu/reg_round.S	Sat Nov  2 22:17:52 2002
@@ -85,23 +85,11 @@
 #define	UNMASKED_UNDERFLOW $2
 
 
-#ifndef NON_REENTRANT_FPU
 /*	Make the code re-entrant by putting
 	local storage on the stack: */
 #define FPU_bits_lost	(%esp)
 #define FPU_denormal	1(%esp)
 
-#else
-/*	Not re-entrant, so we can gain speed by putting
-	local storage in a static area: */
-.data
-	.align 4,0
-FPU_bits_lost:
-	.byte	0
-FPU_denormal:
-	.byte	0
-#endif /* NON_REENTRANT_FPU */
-
 
 .text
 .globl fpu_reg_round
@@ -124,9 +112,7 @@
 fpu_reg_round:			/* Normal entry point */
 	movl	PARAM4,%ecx
 
-#ifndef NON_REENTRANT_FPU
 	pushl	%ebx		/* adjust the stack pointer */
-#endif /* NON_REENTRANT_FPU */ 
 
 #ifdef PARANOID
 /* Cannot use this here yet */
@@ -428,9 +414,7 @@
 
 fpu_reg_round_special_exit:
 
-#ifndef NON_REENTRANT_FPU
 	popl	%ebx		/* adjust the stack pointer */
-#endif /* NON_REENTRANT_FPU */ 
 
 fpu_Arith_exit:
 	popl	%ebx
diff -urN linux-2.5.45-bk1/arch/i386/math-emu/reg_u_div.S linux/arch/i386/math-emu/reg_u_div.S
--- linux-2.5.45-bk1/arch/i386/math-emu/reg_u_div.S	Sun Sep 15 22:18:23 2002
+++ linux/arch/i386/math-emu/reg_u_div.S	Sat Nov  2 22:18:11 2002
@@ -31,7 +31,6 @@
 /* #define	dSIGH(x)	4(x) */
 
 
-#ifndef NON_REENTRANT_FPU
 /*
 	Local storage on the stack:
 	Result:		FPU_accum_3:FPU_accum_2:FPU_accum_1:FPU_accum_0
@@ -45,30 +44,6 @@
 #define FPU_result_2	-24(%ebp)
 #define FPU_ovfl_flag	-28(%ebp)
 
-#else
-.data
-/*
-	Local storage in a static area:
-	Result:		FPU_accum_3:FPU_accum_2:FPU_accum_1:FPU_accum_0
-	Overflow flag:	ovfl_flag
- */
-	.align 4,0
-FPU_accum_3:
-	.long	0
-FPU_accum_2:
-	.long	0
-FPU_accum_1:
-	.long	0
-FPU_accum_0:
-	.long	0
-FPU_result_1:
-	.long	0
-FPU_result_2:
-	.long	0
-FPU_ovfl_flag:
-	.byte	0
-#endif /* NON_REENTRANT_FPU */
-
 #define REGA	PARAM1
 #define REGB	PARAM2
 #define DEST	PARAM3
@@ -77,9 +52,7 @@
 ENTRY(FPU_u_div)
 	pushl	%ebp
 	movl	%esp,%ebp
-#ifndef NON_REENTRANT_FPU
 	subl	$28,%esp
-#endif /* NON_REENTRANT_FPU */
 
 	pushl	%esi
 	pushl	%edi
diff -urN linux-2.5.45-bk1/arch/i386/math-emu/reg_u_mul.S linux/arch/i386/math-emu/reg_u_mul.S
--- linux-2.5.45-bk1/arch/i386/math-emu/reg_u_mul.S	Sun Sep 15 22:18:22 2002
+++ linux/arch/i386/math-emu/reg_u_mul.S	Sat Nov  2 22:18:30 2002
@@ -27,29 +27,15 @@
 
 
 
-#ifndef NON_REENTRANT_FPU
 /*  Local storage on the stack: */
 #define FPU_accum_0	-4(%ebp)	/* ms word */
 #define FPU_accum_1	-8(%ebp)
 
-#else
-/*  Local storage in a static area: */
-.data
-	.align 4,0
-FPU_accum_0:
-	.long	0
-FPU_accum_1:
-	.long	0
-#endif /* NON_REENTRANT_FPU */
-
-
 .text
 ENTRY(FPU_u_mul)
 	pushl	%ebp
 	movl	%esp,%ebp
-#ifndef NON_REENTRANT_FPU
 	subl	$8,%esp
-#endif /* NON_REENTRANT_FPU */ 
 
 	pushl	%esi
 	pushl	%edi
diff -urN linux-2.5.45-bk1/arch/i386/math-emu/wm_sqrt.S linux/arch/i386/math-emu/wm_sqrt.S
--- linux-2.5.45-bk1/arch/i386/math-emu/wm_sqrt.S	Sun Sep 15 22:18:21 2002
+++ linux/arch/i386/math-emu/wm_sqrt.S	Sat Nov  2 22:18:51 2002
@@ -29,7 +29,6 @@
 #include "fpu_emu.h"
 
 
-#ifndef NON_REENTRANT_FPU
 /*	Local storage on the stack: */
 #define FPU_accum_3	-4(%ebp)	/* ms word */
 #define FPU_accum_2	-8(%ebp)
@@ -46,40 +45,12 @@
 #define FPU_fsqrt_arg_1	-24(%ebp)
 #define FPU_fsqrt_arg_0	-28(%ebp)	/* ls word, at most the ms bit is set */
 
-#else
-/*	Local storage in a static area: */
-.data
-	.align 4,0
-FPU_accum_3:
-	.long	0		/* ms word */
-FPU_accum_2:
-	.long	0
-FPU_accum_1:
-	.long	0
-FPU_accum_0:
-	.long	0
-
-/* The de-normalised argument:
-                    sq_2                  sq_1              sq_0
-          b b b b b b b ... b b b   b b b .... b b b   b 0 0 0 ... 0
-             ^ binary point here
- */
-FPU_fsqrt_arg_2:
-	.long	0		/* ms word */
-FPU_fsqrt_arg_1:
-	.long	0
-FPU_fsqrt_arg_0:
-	.long	0		/* ls word, at most the ms bit is set */
-#endif /* NON_REENTRANT_FPU */ 
-
 
 .text
 ENTRY(wm_sqrt)
 	pushl	%ebp
 	movl	%esp,%ebp
-#ifndef NON_REENTRANT_FPU
 	subl	$28,%esp
-#endif /* NON_REENTRANT_FPU */
 	pushl	%esi
 	pushl	%edi
 	pushl	%ebx

--------------030100070106070909080407--

