Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265877AbUFTRky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUFTRky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUFTR25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:28:57 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:50776 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S265877AbUFTRZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:25:56 -0400
Date: Sun, 20 Jun 2004 19:25:55 +0200
Message-Id: <200406201725.i5KHPtbt001489@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 452] M68k bus error handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Allow to catch a bus error via the exception mechanism (from Roman
Zippel)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/arch/m68k/kernel/traps.c	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/kernel/traps.c	2004-05-23 10:55:54.000000000 +0200
@@ -329,7 +329,8 @@
 		 * fault during mem_read/mem_write in ifpsp060/os.S
 		 */
 		send_fault_sig(&fp->ptregs);
-	} else {
+	} else if (!(fslw & (MMU060_RE|MMU060_WE)) ||
+		   send_fault_sig(&fp->ptregs) > 0) {
 		printk("pc=%#lx, fa=%#lx\n", fp->ptregs.pc, fp->un.fmt4.effaddr);
 		printk( "68060 access error, fslw=%lx\n", fslw );
 		trap_c( fp );
@@ -517,7 +518,7 @@
 			if (fp->un.fmt7.wb2a == fp->un.fmt7.faddr)
 				fp->un.fmt7.wb2s &= ~WBV_040;
 		}
-	} else {
+	} else if (send_fault_sig(&fp->ptregs) > 0) {
 		printk("68040 access error, ssw=%x\n", ssw);
 		trap_c(fp);
 	}
@@ -732,7 +733,7 @@
 				return;
 		} else if (!(mmusr & MMU_I)) {
 			/* probably a 020 cas fault */
-			if (!(ssw & RM))
+			if (!(ssw & RM) && send_fault_sig(&fp->ptregs) > 0)
 				printk("unexpected bus error (%#x,%#x)\n", ssw, mmusr);
 		} else if (mmusr & (MMU_B|MMU_L|MMU_S)) {
 			printk("invalid %s access at %#lx from pc %#lx\n",

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
