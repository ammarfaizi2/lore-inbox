Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTBOTT0>; Sat, 15 Feb 2003 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBOTTZ>; Sat, 15 Feb 2003 14:19:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265099AbTBOTS2>; Sat, 15 Feb 2003 14:18:28 -0500
Subject: PATCH: bring 2.5 arcnet into line with 2.4
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:28:40 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7zM-0007JK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a request region breakage
Fixes a size request error
Handles a new card type

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/net/arcnet/com20020.c linux-2.5.61-ac1/drivers/net/arcnet/com20020.c
--- linux-2.5.61/drivers/net/arcnet/com20020.c	2003-02-10 18:38:17.000000000 +0000
+++ linux-2.5.61-ac1/drivers/net/arcnet/com20020.c	2003-02-14 23:22:10.000000000 +0000
@@ -98,6 +98,10 @@
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
 	lp->setup2 = (lp->clockm << 4) | 8;
 
+	/* CHECK: should we do this for SOHARD cards ? */
+	/* Enable P1Mode for backplane mode */
+	lp->setup = lp->setup | P1MODE;
+
 	SET_SUBADR(SUB_SETUP1);
 	outb(lp->setup, _XREG);
 
@@ -202,7 +206,7 @@
 		return -ENODEV;
 	}
 	/* reserve the I/O region */
-	if (request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
 		free_irq(dev->irq, dev);
 		return -EBUSY;
 	}
@@ -300,8 +304,9 @@
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 	int ioaddr = dev->base_addr;
 
-	if (open)
+	if (open) {
 		MOD_INC_USE_COUNT;
+	}
 	else {
 		/* disable transmitter */
 		lp->config &= ~TXENcfg;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/net/arcnet/com20020-pci.c linux-2.5.61-ac1/drivers/net/arcnet/com20020-pci.c
--- linux-2.5.61/drivers/net/arcnet/com20020-pci.c	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.61-ac1/drivers/net/arcnet/com20020-pci.c	2003-02-14 23:22:15.000000000 +0000
@@ -1,5 +1,6 @@
 /*
- * Linux ARCnet driver - COM20020 PCI support (Contemporary Controls PCI20)
+ * Linux ARCnet driver - COM20020 PCI support
+ * Contemporary Controls PCI20 and SOHARD SH-ARC PCI
  * 
  * Written 1994-1999 by Avery Pennarun,
  *    based on an ISA version by David Woodhouse.
@@ -86,7 +87,21 @@
 	memset(lp, 0, sizeof(struct arcnet_local));
 	pci_set_drvdata(pdev, dev);
 
-	ioaddr = pci_resource_start(pdev, 2);
+	// SOHARD needs PCI base addr 4
+	if (pdev->vendor==0x10B5) {
+		BUGMSG(D_NORMAL, "SOHARD\n");
+		ioaddr = pci_resource_start(pdev, 4);
+	}
+	else {
+		BUGMSG(D_NORMAL, "Contemporary Controls\n");
+		ioaddr = pci_resource_start(pdev, 2);
+	}
+
+	// Dummy access after Reset
+	// ARCNET controller needs this access to detect bustype
+	outb(0x00,ioaddr+1);
+	inb(ioaddr+1);
+
 	dev->base_addr = ioaddr;
 	dev->irq = pdev->irq;
 	dev->dev_addr[0] = node;
@@ -152,6 +167,7 @@
 	{ 0x1571, 0xa204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{ 0x1571, 0xa205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{ 0x1571, 0xa206, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
+	{ 0x10B5, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{0,}
 };
 
