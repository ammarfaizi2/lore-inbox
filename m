Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUEKAO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUEKAO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEKAO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:14:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8096 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261793AbUEKAOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:14:42 -0400
Date: Mon, 10 May 2004 17:13:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: paulus@samba.org, ebs@ebshome.net, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] PPC32: Fix copy prefetch on non coherent PPCs
Message-ID: <20040510171351.B26495@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the condition where prefetching cache lines beyond
a buffer can cause data corruption on non cache coherent PPCs. It is
a port of the version that went into 2.4. From Eugene Surovegin
<ebs@ebshome.net>. Please apply.

-Matt

===== arch/ppc/kernel/misc.S 1.53 vs edited =====
--- 1.53/arch/ppc/kernel/misc.S	Sat Mar 13 17:57:41 2004
+++ edited/arch/ppc/kernel/misc.S	Mon Mar 15 17:33:33 2004
@@ -777,9 +777,18 @@
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
@@ -787,19 +796,17 @@
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
@@ -815,7 +822,12 @@
 #endif
 #endif
 	bdnz	1b
-	blr
+	beqlr
+	crnot	4*cr0+eq,4*cr0+eq
+	li	r0,MAX_COPY_PREFETCH
+	li	r11,4
+	b	2b
+#endif	/* CONFIG_8xx */
 
 /*
  * void atomic_clear_mask(atomic_t mask, atomic_t *addr)
===== arch/ppc/lib/string.S 1.8 vs edited =====
--- 1.8/arch/ppc/lib/string.S	Sun Aug  3 21:32:06 2003
+++ edited/arch/ppc/lib/string.S	Mon Mar 15 17:30:43 2004
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
