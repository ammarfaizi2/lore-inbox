Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbREEHbk>; Sat, 5 May 2001 03:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREEHba>; Sat, 5 May 2001 03:31:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35601 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131563AbREEHbJ>; Sat, 5 May 2001 03:31:09 -0400
Subject: Athlon possible fixes
To: linux-kernel@vger.kernel.org
Date: Sat, 5 May 2001 08:35:06 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vwaq-0000Jk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming Manfred's diagnosis is right something like this might fix it

*note*: Not tested this is just off the top of my head...


--- arch/i386/lib/mmx.c~	Sun Apr 15 16:49:54 2001
+++ arch/i386/lib/mmx.c	Sat May  5 08:03:17 2001
@@ -57,7 +57,11 @@
 		: : "r" (from) );
 		
 	
-	for(; i>0; i--)
+	/*
+	 *	While we have at least 320 bytes left to copy
+	 */
+	 
+	for(; i>5; i--)
 	{
 		__asm__ __volatile__ (
 		"1:  prefetch 320(%0)\n"
@@ -89,6 +93,31 @@
 		from+=64;
 		to+=64;
 	}
+
+	/*
+	 *	While we have at least 64 bytes left to copy
+	 */
+	 
+	for(; i>0; i--)
+	{
+		__asm__ __volatile__ (
+		"  movq (%0), %%mm0\n"
+		"  movq 8(%0), %%mm1\n"
+		"  movq 16(%0), %%mm2\n"
+		"  movq 24(%0), %%mm3\n"
+		"  movq %%mm0, (%1)\n"
+		"  movq %%mm1, 8(%1)\n"
+		"  movq %%mm2, 16(%1)\n"
+		"  movq %%mm3, 24(%1)\n"
+		"  movq 32(%0), %%mm0\n"
+		"  movq 40(%0), %%mm1\n"
+		"  movq 48(%0), %%mm2\n"
+		"  movq 56(%0), %%mm3\n"
+		"  movq %%mm0, 32(%1)\n"
+		"  movq %%mm1, 40(%1)\n"
+		"  movq %%mm2, 48(%1)\n"
+		"  movq %%mm3, 56(%1)\n"
+		: : "r" (from), "r" (to) : "memory");
 	/*
 	 *	Now do the tail of the block
 	 */
@@ -163,7 +192,11 @@
 		".previous"
 		: : "r" (from) );
 
-	for(i=0; i<4096/64; i++)
+	/*
+	 *	While there is at least 320 bytes to copy
+	 */
+	 
+	for(i=0; i<59; i++)
 	{
 		__asm__ __volatile__ (
 		"1: prefetch 320(%0)\n"
@@ -195,6 +228,35 @@
 		from+=64;
 		to+=64;
 	}
+
+	/*
+	 *	Finish off the page
+	 */
+	 
+	for(; i<64; i++)
+	{
+		__asm__ __volatile__ (
+		"   movq (%0), %%mm0\n"
+		"   movntq %%mm0, (%1)\n"
+		"   movq 8(%0), %%mm1\n"
+		"   movntq %%mm1, 8(%1)\n"
+		"   movq 16(%0), %%mm2\n"
+		"   movntq %%mm2, 16(%1)\n"
+		"   movq 24(%0), %%mm3\n"
+		"   movntq %%mm3, 24(%1)\n"
+		"   movq 32(%0), %%mm4\n"
+		"   movntq %%mm4, 32(%1)\n"
+		"   movq 40(%0), %%mm5\n"
+		"   movntq %%mm5, 40(%1)\n"
+		"   movq 48(%0), %%mm6\n"
+		"   movntq %%mm6, 48(%1)\n"
+		"   movq 56(%0), %%mm7\n"
+		"   movntq %%mm7, 56(%1)\n"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+	}
+
 	/* since movntq is weakly-ordered, a "sfence" is needed to become
 	 * ordered again.
 	 */
@@ -270,7 +332,11 @@
 		".previous"
 		: : "r" (from) );
 
-	for(i=0; i<4096/64; i++)
+	/*
+	 *	Copy the page until we have 320 bytes to go
+	 */
+	 
+	for(i=0; i<59; i++)
 	{
 		__asm__ __volatile__ (
 		"1: prefetch 320(%0)\n"
@@ -298,6 +364,34 @@
 		"	.align 4\n"
 		"	.long 1b, 3b\n"
 		".previous"
+		: : "r" (from), "r" (to) : "memory");
+		from+=64;
+		to+=64;
+	}
+
+	/*
+	 *	Copy the tail of the page
+	 */
+	 
+	for(; i<64; i++)
+	{
+		__asm__ __volatile__ (
+		"   movq (%0), %%mm0\n"
+		"   movq 8(%0), %%mm1\n"
+		"   movq 16(%0), %%mm2\n"
+		"   movq 24(%0), %%mm3\n"
+		"   movq %%mm0, (%1)\n"
+		"   movq %%mm1, 8(%1)\n"
+		"   movq %%mm2, 16(%1)\n"
+		"   movq %%mm3, 24(%1)\n"
+		"   movq 32(%0), %%mm0\n"
+		"   movq 40(%0), %%mm1\n"
+		"   movq 48(%0), %%mm2\n"
+		"   movq 56(%0), %%mm3\n"
+		"   movq %%mm0, 32(%1)\n"
+		"   movq %%mm1, 40(%1)\n"
+		"   movq %%mm2, 48(%1)\n"
+		"   movq %%mm3, 56(%1)\n"
 		: : "r" (from), "r" (to) : "memory");
 		from+=64;
 		to+=64;
