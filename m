Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVC2WdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVC2WdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVC2WcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:32:06 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:1456 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261584AbVC2WbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:31:12 -0500
Date: Tue, 29 Mar 2005 16:30:37 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: Eugene Surovegin <ebs@ebshome.net>,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, shall@mvista.com,
       Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array
In-Reply-To: <20050329201209.GB30850@gate.ebshome.net>
Message-ID: <Pine.LNX.4.61.0503291627130.16284@blarg.somerset.sps.mot.com>
References: <20050329201209.GB30850@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Cleaned up irq_to_siubit array so we no longer need to do 1 << (31-bit), 
just 1 << bit.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/syslib/cpm2_pic.c b/arch/ppc/syslib/cpm2_pic.c
--- a/arch/ppc/syslib/cpm2_pic.c	2005-03-29 16:25:34 -06:00
+++ b/arch/ppc/syslib/cpm2_pic.c	2005-03-29 16:25:34 -06:00
@@ -33,14 +33,14 @@
 };
 
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
@@ -54,7 +54,7 @@
 	word = irq_to_siureg[irq_nr];
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
 }
 
@@ -69,7 +69,7 @@
 	word = irq_to_siureg[irq_nr];
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
-	ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+	ppc_cached_irq_mask[word] |= 1 << bit;
 	simr[word] = ppc_cached_irq_mask[word];
 }
 
@@ -85,9 +85,9 @@
 
 	simr = &(cpm2_immr->im_intctl.ic_simrh);
 	sipnr = &(cpm2_immr->im_intctl.ic_sipnrh);
-	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
+	ppc_cached_irq_mask[word] &= ~(1 << bit);
 	simr[word] = ppc_cached_irq_mask[word];
-	sipnr[word] = 1 << (31 - bit);
+	sipnr[word] = 1 << bit;
 }
 
 static void cpm2_end_irq(unsigned int irq_nr)
@@ -103,7 +103,7 @@
 		word = irq_to_siureg[irq_nr];
 
 		simr = &(cpm2_immr->im_intctl.ic_simrh);
-		ppc_cached_irq_mask[word] |= (1 << (31 - bit));
+		ppc_cached_irq_mask[word] |= 1 << bit;
 		simr[word] = ppc_cached_irq_mask[word];
 	}
 }
