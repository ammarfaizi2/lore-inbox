Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUGAB3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUGAB3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUGAB3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:29:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24033 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263596AbUGAB3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:29:37 -0400
Date: Wed, 30 Jun 2004 18:29:23 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix dual UICs in 4xx PIC support
Message-ID: <20040630182923.B8683@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a case where we were not correctly acking the base cascade
controller on PPC4xx. Patch from Pavel Bartusek <pba@sysgo.com>

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/syslib/ppc4xx_pic.c 1.10 vs edited =====
--- 1.10/arch/ppc/syslib/ppc4xx_pic.c	Tue May 18 07:48:10 2004
+++ edited/arch/ppc/syslib/ppc4xx_pic.c	Wed Jun 30 18:21:16 2004
@@ -234,6 +234,9 @@
 	case 1:
 		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
 		mtdcr(DCRN_UIC_SR(UIC1), (1 << (31 - bit)));
+#if (NR_UICS == 2)
+		mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - UIC0_UIC1NC)));
+#endif
 #if (NR_UICS > 2)
 		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
 #endif
@@ -285,6 +288,9 @@
 			break;
 		case 1:
 			mtdcr(DCRN_UIC_SR(UIC1), 1 << (31 - bit));
+#if (NR_UICS == 2)
+			mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - UIC0_UIC1NC)));
+#endif
 #if (NR_UICS > 2)
 			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC1NC);
 #endif
@@ -423,7 +429,7 @@
 		       bit, sense);
 #endif
 		ppc_cached_sense_mask[word] |=
-		    (sense & IRQ_SENSE_MASK) << (31 - bit);
+		    (~sense & IRQ_SENSE_MASK) << (31 - bit);
 		ppc_cached_pol_mask[word] |=
 		    ((sense & IRQ_POLARITY_MASK) >> 1) << (31 - bit);
 		switch (word) {
