Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUF2D6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUF2D6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 23:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUF2D6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 23:58:22 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:44954 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S265395AbUF2D6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 23:58:08 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Jun 2004 13:58:03 +1000
Subject: [PATCH] Fix 2.6.7 Alpha compilation
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Message-Id: <E1Bf9kx-0006b1-6T@wombat.disy.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When using gcc 3.3.3 on alpha, the current BK head doesn't compile.
     -- there's an external declaration for abs() in the same scope as
     a macro definition in arch/alpha/time.c
     -- The compiler is picky about `const' declarations, which breaks
     on bitops.h.

Here's a patch to fix:

Index: linux-2.6-wip/include/asm-alpha/bitops.h
===================================================================
--- linux-2.6-wip.orig/include/asm-alpha/bitops.h
+++ linux-2.6-wip/include/asm-alpha/bitops.h
@@ -418,9 +418,9 @@
  * Find next one bit in a bitmap reasonably efficiently.
  */
 static inline unsigned long
-find_next_bit(void * addr, unsigned long size, unsigned long offset)
+find_next_bit(const void * addr, unsigned long size, unsigned long offset)
 {
-	unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
+	const unsigned long * p = ((const unsigned long *) addr) + (offset >> 6);
 	unsigned long result = offset & ~63UL;
 	unsigned long tmp;
 
Index: linux-2.6-wip/arch/alpha/kernel/time.c
===================================================================
--- linux-2.6-wip.orig/arch/alpha/kernel/time.c
+++ linux-2.6-wip/arch/alpha/kernel/time.c
@@ -523,7 +523,6 @@
  *      sets the minutes. Usually you won't notice until after reboot!
  */
 
-extern int abs(int);
 
 static int
 set_rtc_mmss(unsigned long nowtime)
