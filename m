Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbTBRScx>; Tue, 18 Feb 2003 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbTBRSb5>; Tue, 18 Feb 2003 13:31:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57865 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268013AbTBRSXU>; Tue, 18 Feb 2003 13:23:20 -0500
Subject: PATCH: part fix the highpoint timing/overclock bug
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:33:42 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCYo-0006ED-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/hpt366.c linux-2.5.61-ac2/drivers/ide/pci/hpt366.c
--- linux-2.5.61/drivers/ide/pci/hpt366.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/hpt366.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/hpt366.c		Version 0.34	Sept 17, 2002
+ * linux/drivers/ide/pci/hpt366.c		Version 0.34	Sept 17, 2002
  *
  * Copyright (C) 1999-2002		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -807,7 +807,7 @@
 	} else if (freq < 0xc8) {
 		pll = F_LOW_PCI_50;
 		if (hpt_minimum_revision(dev,8))
-			return -EOPNOTSUPP;
+			pci_set_drvdata(dev, NULL);
 		else if (hpt_minimum_revision(dev,5))
 			pci_set_drvdata(dev, (void *) fifty_base_hpt372);
 		else if (hpt_minimum_revision(dev,4))
@@ -820,7 +820,7 @@
 		if (hpt_minimum_revision(dev,8))
 		{
 			printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
-			return -EOPNOTSUPP;
+			pci_set_drvdata(dev, NULL);
 		}
 		else if (hpt_minimum_revision(dev,5))
 			pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
@@ -923,7 +923,7 @@
 	if (!pci_get_drvdata(dev))
 	{
 		printk(KERN_ERR "hpt366: unknown bus timing.\n");
-		return -EOPNOTSUPP;
+		pci_set_drvdata(dev, NULL);
 	}
 	return 0;
 }
@@ -1061,6 +1061,12 @@
 
 	if (!dmabase)
 		return;
+		
+	if(pci_get_drvdata(hwif->pci_dev) == NULL)
+	{
+		printk(KERN_WARNING "hpt: no known IDE timings, disabling DMA.\n");
+		return;
+	}
 
 	dma_old = hwif->INB(dmabase+2);
 
