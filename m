Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbQKPBVD>; Wed, 15 Nov 2000 20:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129770AbQKPBUx>; Wed, 15 Nov 2000 20:20:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64908 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129768AbQKPBUj>;
	Wed, 15 Nov 2000 20:20:39 -0500
Date: Wed, 15 Nov 2000 16:35:45 -0800
Message-Id: <200011160035.QAA08442@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: adam@yggdrasil.com
CC: willy@meta-x.org, linux-kernel@vger.kernel.org
In-Reply-To: <200011160044.QAA24961@adam.yggdrasil.com>
Subject: Re: 2.4.0-test11-pre5/drivers/net/sunhme.c compile failure on x86
In-Reply-To: <200011160044.QAA24961@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a better fix:

--- drivers/net/sunhme.c.~1~	Sun Nov 12 02:23:30 2000
+++ drivers/net/sunhme.c	Wed Nov 15 16:34:44 2000
@@ -1600,6 +1600,10 @@
 	HMD(("happy_meal_init: old[%08x] bursts<",
 	     hme_read32(hp, gregs + GREG_CFG)));
 
+#ifndef __sparc__
+	/* It is always PCI and can handle 64byte bursts. */
+	hme_write32(hp, gregs + GREG_CFG, GREG_CFG_BURST64);
+#else
 	if ((hp->happy_bursts & DMA_BURST64) &&
 	    ((hp->happy_flags & HFLAG_PCI) != 0
 #ifdef CONFIG_SBUS
@@ -1633,6 +1637,7 @@
 		HMD(("XXX>"));
 		hme_write32(hp, gregs + GREG_CFG, 0);
 	}
+#endif /* __sparc__ */
 
 	/* Turn off interrupts we do not want to hear. */
 	HMD((", enable global interrupts, "));
@@ -2887,8 +2892,10 @@
 	/* And of course, indicate this is PCI. */
 	hp->happy_flags |= HFLAG_PCI;
 
+#ifdef __sparc__
 	/* Assume PCI happy meals can handle all burst sizes. */
 	hp->happy_bursts = DMA_BURSTBITS;
+#endif
 
 	hp->happy_block = (struct hmeal_init_block *)
 		pci_alloc_consistent(pdev, PAGE_SIZE, &hp->hblock_dvma);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
