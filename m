Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVC3ET6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVC3ET6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVC3ET6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:19:58 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:63202 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261536AbVC3ETx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:19:53 -0500
Date: Tue, 29 Mar 2005 22:19:17 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, dan@embeddededge.com
Subject: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array (updated)
Message-ID: <Pine.LNX.4.61.0503292217290.17481@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

(Updated this patch to include a comment at Dan Malek's request.)

Cleaned up irq_to_siubit array so we no longer need to do 1 << (31-bit), 
just 1 << bit.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/syslib/cpm2_pic.c b/arch/ppc/syslib/cpm2_pic.c
--- a/arch/ppc/syslib/cpm2_pic.c	2005-03-29 22:15:24 -06:00
+++ b/arch/ppc/syslib/cpm2_pic.c	2005-03-29 22:15:24 -06:00
@@ -32,15 +32,17 @@
 	0, 0, 0, 0, 0, 0, 0, 0
 };
 
+/* bit numbers do not match the docs, these are precomputed so the bit for
+ * a given irq is (1 << irq_to_siubit[irq]) */
 static	u_char	irq_to_siubit[] = {
-	31, 16, 17, 18, 19, 20, 21, 22,
-	23, 24, 25, 26, 27, 28, 29, 30,
-	29, 30, 16, 17, 18, 19, 20, 21,
-	22, 23, 24, 25, 26, 27, 28, 31,
-	 0,  1,  2,  3,  4,  5,  6,  7,
-	 8,  9, 10, 11, 12, 13, 14, 15,
-	15, 14, 13, 12, 11, 10,  9,  8,
-	 7,  6,  5,  4,  3,  2,  1,  0
+	 0, 15, 14, 13, 12, 11, 10,  9, 
+	 8,  7,  6,  5,  4,  3,  2,  1, 
+	 2,  1, 15, 14, 13, 12, 11, 10, 
+	 9,  8,  7,  6,  5,  4,  3,  0, 
+	31, 30, 29, 28, 27, 26, 25, 24, 
+	23, 22, 21, 20, 19, 18, 17, 16, 
+	16, 17, 18, 19, 20, 21, 22, 23, 
+	24, 25, 26, 27, 28, 29, 30, 31, 
 };
 
 static void cpm2_mask_irq(unsigned int irq_nr)
@@ -54,7 +56,7 @@
 	word = irq_to_siureg[irq_nr];
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
 }
 
@@ -69,7 +71,7 @@
 	word = irq_to_siureg[irq_nr];
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+	ppc_cached_irq_mask[word] |= 1 << bit;
 	simr[word] = ppc_cached_irq_mask[word];
 }
 
@@ -85,9 +87,9 @@
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
 	sipnr = &(cpm2_immr->im_intctl.ic_sipnrh);
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
-	sipnr[word] = 1 << (31 - bit);
+	sipnr[word] = 1 << bit;
 }
 
 static void cpm2_end_irq(unsigned int irq_nr)
@@ -103,7 +105,7 @@
 		word = irq_to_siureg[irq_nr];
 
 		simr = &(cpm2_immr->im_intctl.ic_simrh);
-		ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+		ppc_cached_irq_mask[word] |= 1 << bit;
 		simr[word] = ppc_cached_irq_mask[word];
 	}
 }
