Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUCPCCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbUCPB7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:59:38 -0500
Received: from [64.62.253.241] ([64.62.253.241]:20996 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S263376AbUCPB5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:57:02 -0500
Date: Mon, 15 Mar 2004 17:59:06 -0800
From: Bryan Rittmeyer <bryan@staidm.org>
To: linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
Message-ID: <20040316015906.GA22401@staidm.org>
References: <20040313041547.GB11512@staidm.org> <20040313091110.GA30393@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313091110.GA30393@gate.ebshome.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 01:11:10AM -0800, Eugene Surovegin wrote:
> I reported this problem on -embedded list half a year ago.
> This is already fixed in 2.4 tree, not sure about 2.6

Thanks. The fix in linuxppc-2.4 is cleaner than my prior patch.
Here's a forward port to linuxppc-2.5-benh:

--- linuxppc-2.5-benh/arch/ppc/lib/string.S.orig	2004-02-19 18:08:13.000000000 -0800
+++ linuxppc-2.5-benh/arch/ppc/lib/string.S	2004-03-15 17:05:38.000000000 -0800
@@ -436,48 +436,57 @@
 73:	stwu	r9,4(r6)
 	bdnz	72b
 
+	.section __ex_table,"a"
+	.align	2
+	.long	70b,100f
+	.long	71b,101f
+	.long	72b,102f
+	.long	73b,103f
+	.text
+
 58:	srwi.	r0,r5,LG_CACHELINE_BYTES /* # complete cachelines */
 	clrlwi	r5,r5,32-LG_CACHELINE_BYTES
 	li	r11,4
 	beq	63f
 
-#if !defined(CONFIG_8xx)
+#ifdef CONFIG_8xx
+	/* Don't use prefetch on 8xx */
+	mtctr	r0
+53:	COPY_16_BYTES_WITHEX(0)
+	bdnz	53b
+
+#else /* not CONFIG_8xx */
 	/* Here we decide how far ahead to prefetch the source */
+	li	r3,4
+	cmpwi	r0,1
+	li	r7,0
+	ble	114f
+	li	r7,1
 #if MAX_COPY_PREFETCH > 1
 	/* Heuristically, for large transfers we prefetch
 	   MAX_COPY_PREFETCH cachelines ahead.  For small transfers
 	   we prefetch 1 cacheline ahead. */
 	cmpwi	r0,MAX_COPY_PREFETCH
-	li	r7,1
-	li	r3,4
-	ble	111f
+	ble	112f
 	li	r7,MAX_COPY_PREFETCH
-111:	mtctr	r7
-112:	dcbt	r3,r4
+112:	mtctr	r7
+111:	dcbt	r3,r4
 	addi	r3,r3,CACHELINE_BYTES
-	bdnz	112b
-#else /* MAX_COPY_PREFETCH == 1 */
-	li	r3,CACHELINE_BYTES + 4
-	dcbt	r11,r4
-#endif /* MAX_COPY_PREFETCH */
-#endif /* CONFIG_8xx */
-
-	mtctr	r0
-53:
-#if !defined(CONFIG_8xx)
+	bdnz	111b
+#else
 	dcbt	r3,r4
+	addi	r3,r3,CACHELINE_BYTES
+#endif /* MAX_COPY_PREFETCH > 1 */
+
+114:	subf	r8,r7,r0
+	mr	r0,r7
+	mtctr	r8
+
+53:	dcbt	r3,r4
 54:	dcbz	r11,r6
-#endif
-/* had to move these to keep extable in order */
 	.section __ex_table,"a"
 	.align	2
-	.long	70b,100f
-	.long	71b,101f
-	.long	72b,102f
-	.long	73b,103f
-#if !defined(CONFIG_8xx)
 	.long	54b,105f
-#endif
 	.text
 /* the main body of the cacheline loop */
 	COPY_16_BYTES_WITHEX(0)
@@ -495,6 +504,11 @@
 #endif
 #endif
 	bdnz	53b
+	cmpwi	r0,0
+	li	r3,4
+	li	r7,0
+	bne	114b
+#endif /* CONFIG_8xx */	
 
 63:	srwi.	r0,r5,2
 	mtctr	r0
--- linuxppc-2.5-benh/arch/ppc/kernel/misc.S.orig	2004-03-15 17:20:13.000000000 -0800
+++ linuxppc-2.5-benh/arch/ppc/kernel/misc.S	2004-03-15 17:35:22.000000000 -0800
@@ -783,9 +783,18 @@
 _GLOBAL(copy_page)
 	addi	r3,r3,-4
 	addi	r4,r4,-4
+
+#ifdef CONFIG_8xx
+	/* don't use prefetch on 8xx */
+    	li	r0,4096/L1_CACHE_LINE_SIZE
+	mtctr	r0
+1:	COPY_16_BYTES
+	bdnz	1b
+	blr
+
+#else	/* not 8xx, we can prefetch */
 	li	r5,4
 
-#ifndef CONFIG_8xx
 #if MAX_COPY_PREFETCH > 1
 	li	r0,MAX_COPY_PREFETCH
 	li	r11,4
@@ -793,19 +802,17 @@
 11:	dcbt	r11,r4
 	addi	r11,r11,L1_CACHE_LINE_SIZE
 	bdnz	11b
-#else /* MAX_L1_COPY_PREFETCH == 1 */
+#else /* MAX_COPY_PREFETCH == 1 */
 	dcbt	r5,r4
 	li	r11,L1_CACHE_LINE_SIZE+4
-#endif /* MAX_L1_COPY_PREFETCH */
-#endif /* CONFIG_8xx */
-
-	li	r0,4096/L1_CACHE_LINE_SIZE
+#endif /* MAX_COPY_PREFETCH */
+	li	r0,4096/L1_CACHE_LINE_SIZE - MAX_COPY_PREFETCH
+	crclr	4*cr0+eq
+2:
 	mtctr	r0
 1:
-#ifndef CONFIG_8xx
 	dcbt	r11,r4
 	dcbz	r5,r3
-#endif
 	COPY_16_BYTES
 #if L1_CACHE_LINE_SIZE >= 32
 	COPY_16_BYTES
@@ -821,6 +828,12 @@
 #endif
 #endif
 	bdnz	1b
+	beqlr
+	crnot	4*cr0+eq,4*cr0+eq
+	li	r0,MAX_COPY_PREFETCH
+	li	r11,4
+	b	2b
+#endif	/* CONFIG_8xx */
 	blr
 
 /*


-Bryan

