Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUFTR2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUFTR2l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUFTR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:28:37 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com.243.46.213.in-addr.arpa ([213.46.243.17]:36399 "EHLO amsfep12-int.chello.nl")
	by vger.kernel.org with ESMTP id S264641AbUFTRZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:25:56 -0400
Date: Sun, 20 Jun 2004 19:25:49 +0200
Message-Id: <200406201725.i5KHPnUv001479@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 450] M68k new gcc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fixes for when compiling with modern gcc (from Roman Zippel):
  - Avoid warning 'use of memory input without lvalue in asm operand 0 is
    deprecated' of newer gcc
  - Replace some '%/' with offical '%%' to escape a '%'

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/arch/m68k/kernel/signal.c	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/kernel/signal.c	2004-05-23 10:55:54.000000000 +0200
@@ -228,8 +228,8 @@
 		goto out;
 
 	    __asm__ volatile (".chip 68k/68881\n\t"
-			      "fmovemx %0,%/fp0-%/fp1\n\t"
-			      "fmoveml %1,%/fpcr/%/fpsr/%/fpiar\n\t"
+			      "fmovemx %0,%%fp0-%%fp1\n\t"
+			      "fmoveml %1,%%fpcr/%%fpsr/%%fpiar\n\t"
 			      ".chip 68k"
 			      : /* no outputs */
 			      : "m" (*sc->sc_fpregs), "m" (*sc->sc_fpcntl));
@@ -258,7 +258,7 @@
 	if (FPU_IS_EMU) {
 		/* restore fpu control register */
 		if (__copy_from_user(current->thread.fpcntl,
-				&uc->uc_mcontext.fpregs.f_pcr, 12))
+				uc->uc_mcontext.fpregs.f_fpcntl, 12))
 			goto out;
 		/* restore all other fpu register */
 		if (__copy_from_user(current->thread.fp,
@@ -298,12 +298,12 @@
 				     sizeof(fpregs)))
 			goto out;
 		__asm__ volatile (".chip 68k/68881\n\t"
-				  "fmovemx %0,%/fp0-%/fp7\n\t"
-				  "fmoveml %1,%/fpcr/%/fpsr/%/fpiar\n\t"
+				  "fmovemx %0,%%fp0-%%fp7\n\t"
+				  "fmoveml %1,%%fpcr/%%fpsr/%%fpiar\n\t"
 				  ".chip 68k"
 				  : /* no outputs */
 				  : "m" (*fpregs.f_fpregs),
-				    "m" (fpregs.f_pcr));
+				    "m" (*fpregs.f_fpcntl));
 	}
 	if (context_size &&
 	    __copy_from_user(fpstate + 4, (long *)&uc->uc_fpstate + 1,
@@ -586,12 +586,12 @@
 				sc->sc_fpstate[0x38] |= 1 << 3;
 		}
 		__asm__ volatile (".chip 68k/68881\n\t"
-				  "fmovemx %/fp0-%/fp1,%0\n\t"
-				  "fmoveml %/fpcr/%/fpsr/%/fpiar,%1\n\t"
+				  "fmovemx %%fp0-%%fp1,%0\n\t"
+				  "fmoveml %%fpcr/%%fpsr/%%fpiar,%1\n\t"
 				  ".chip 68k"
-				  : /* no outputs */
-				  : "m" (*sc->sc_fpregs),
-				    "m" (*sc->sc_fpcntl)
+				  : "=m" (*sc->sc_fpregs),
+				    "=m" (*sc->sc_fpcntl)
+				  : /* no inputs */
 				  : "memory");
 	}
 }
@@ -604,7 +604,7 @@
 
 	if (FPU_IS_EMU) {
 		/* save fpu control register */
-		err |= copy_to_user(&uc->uc_mcontext.fpregs.f_pcr,
+		err |= copy_to_user(uc->uc_mcontext.fpregs.f_fpcntl,
 				current->thread.fpcntl, 12);
 		/* save all other fpu register */
 		err |= copy_to_user(uc->uc_mcontext.fpregs.f_fpregs,
@@ -631,12 +631,12 @@
 				fpstate[0x38] |= 1 << 3;
 		}
 		__asm__ volatile (".chip 68k/68881\n\t"
-				  "fmovemx %/fp0-%/fp7,%0\n\t"
-				  "fmoveml %/fpcr/%/fpsr/%/fpiar,%1\n\t"
+				  "fmovemx %%fp0-%%fp7,%0\n\t"
+				  "fmoveml %%fpcr/%%fpsr/%%fpiar,%1\n\t"
 				  ".chip 68k"
-				  : /* no outputs */
-				  : "m" (*fpregs.f_fpregs),
-				    "m" (fpregs.f_pcr)
+				  : "=m" (*fpregs.f_fpregs),
+				    "=m" (*fpregs.f_fpcntl)
+				  : /* no inputs */
 				  : "memory");
 		err |= copy_to_user(&uc->uc_mcontext.fpregs, &fpregs,
 				    sizeof(fpregs));
--- linux-2.6.7/include/asm-m68k/ucontext.h	1998-02-13 01:30:13.000000000 +0100
+++ linux-m68k-2.6.7/include/asm-m68k/ucontext.h	2004-05-23 10:56:37.000000000 +0200
@@ -6,10 +6,8 @@
 typedef greg_t gregset_t[NGREG];
 
 typedef struct fpregset {
-	int f_pcr;
-	int f_psr;
-	int f_fpiaddr;
-	int f_fpregs[8][3];
+	int f_fpcntl[3];
+	int f_fpregs[8*3];
 } fpregset_t;
 
 struct mcontext {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
