Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbRGPLLX>; Mon, 16 Jul 2001 07:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbRGPLLE>; Mon, 16 Jul 2001 07:11:04 -0400
Received: from ns.heidelberg.com ([193.158.227.197]:10729 "EHLO
	wiens011.heidelberg.com") by vger.kernel.org with ESMTP
	id <S267277AbRGPLK6>; Mon, 16 Jul 2001 07:10:58 -0400
Date: Mon, 16 Jul 2001 13:11:00 +0200 (CEST)
From: Roman Fietze <fietze@swec.muh.de.heidelberg.com>
Reply-To: Roman Fietze <roman.fietze@de.heidelberg.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Arcnet fixes and support for Sohard
Message-ID: <Pine.LNX.4.33.0107161212590.12038-100000@kagcpd05.muh.de.heidelberg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here some patches to the Arcnet drivers based upon the 2.4.6. The
modifications run here w/o problems. The first bug fix has to do with the
resource handling, request_region returns NULL on error. The second bug
fix corrects the number of I/O bytes needed for a COM20020 (8 instead of
9), and the last (non bug) fix is to support Sohard's COM20020 boards.


diff -u -r linux-2.4.6/drivers/net/arcnet/com20020-pci.c linux-2.4.6-arcnet-patch/drivers/net/arcnet/com20020-pci.c
--- linux-2.4.6/drivers/net/arcnet/com20020-pci.c	Wed Apr 18 23:40:05 2001
+++ linux-2.4.6-arcnet-patch/drivers/net/arcnet/com20020-pci.c	Mon Jul 16 09:19:36 2001
@@ -1,5 +1,6 @@
 /*
- * Linux ARCnet driver - COM20020 PCI support (Contemporary Controls PCI20)
+ * Linux ARCnet driver - COM20020 PCI support
+ * for Contemporary Controls PCI20 and SOHARD SH-ARC PCI with com20020 chipset
  *
  * Written 1994-1999 by Avery Pennarun,
  *    based on an ISA version by David Woodhouse.
@@ -85,7 +86,21 @@
 	memset(lp, 0, sizeof(struct arcnet_local));
 	pdev->driver_data = dev;

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
@@ -151,6 +166,7 @@
 	{ 0x1571, 0xa204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{ 0x1571, 0xa205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{ 0x1571, 0xa206, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
+        { 0x10B5, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ARC_CAN_10MBIT },
 	{0,}
 };

diff -u -r linux-2.4.6/drivers/net/arcnet/com20020.c linux-2.4.6-arcnet-patch/drivers/net/arcnet/com20020.c
--- linux-2.4.6/drivers/net/arcnet/com20020.c	Tue Feb 13 22:15:05 2001
+++ linux-2.4.6-arcnet-patch/drivers/net/arcnet/com20020.c	Mon Jul 16 09:28:59 2001
@@ -1,6 +1,6 @@
 /*
  * Linux ARCnet driver - COM20020 chipset support
- *
+ *
  * Written 1997 by David Woodhouse.
  * Written 1994-1999 by Avery Pennarun.
  * Written 1999 by Martin Mares <mj@suse.cz>.
@@ -98,6 +98,9 @@
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
 	lp->setup2 = (lp->clockm << 4) | 8;

+	/* Enable P1Mode for backplane mode */
+	lp->setup = lp->setup | P1MODE;
+
 	SET_SUBADR(SUB_SETUP1);
 	outb(lp->setup, _XREG);

@@ -105,7 +108,7 @@
 	{
 		SET_SUBADR(SUB_SETUP2);
 		outb(lp->setup2, _XREG);
-
+
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
 		outb(0x18, _COMMAND);
@@ -183,7 +186,7 @@
 	{
 		SET_SUBADR(SUB_SETUP2);
 		outb(lp->setup2, _XREG);
-
+
 		/* must now write the magic "restart operation" command */
 		mdelay(1);
 		outb(0x18, _COMMAND);
@@ -202,7 +205,7 @@
 		return -ENODEV;
 	}
 	/* reserve the I/O region */
-	if (request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
 		free_irq(dev->irq, dev);
 		return -EBUSY;
 	}
@@ -218,7 +221,7 @@
 		BUGMSG(D_NORMAL, "Using extended timeout value of %d.\n", lp->timeout);

 	BUGMSG(D_NORMAL, "Using CKP %d - data rate %s.\n",
-	       lp->setup >> 1,
+	       lp->setup >> 1,
 	       clockrates[3 - ((lp->setup2 & 0xF0) >> 4) + ((lp->setup & 0x0F) >> 1)]);

 	if (!dev->init && register_netdev(dev)) {
@@ -230,9 +233,9 @@
 }


-/*
+/*
  * Do a hardware reset on the card, and set up necessary registers.
- *
+ *
  * This should be called as little as possible, because it disrupts the
  * token on the network (causes a RECON) and requires a significant delay.
  *
diff -u -r linux-2.4.6/include/linux/com20020.h linux-2.4.6-arcnet-patch/include/linux/com20020.h
--- linux-2.4.6/include/linux/com20020.h	Fri Apr  6 19:51:19 2001
+++ linux-2.4.6-arcnet-patch/include/linux/com20020.h	Mon Jul 16 09:57:32 2001
@@ -32,7 +32,7 @@
 void com20020_remove(struct net_device *dev);

 /* The number of low I/O ports used by the card. */
-#define ARCNET_TOTAL_SIZE 9
+#define ARCNET_TOTAL_SIZE 8

 /* various register addresses */
 #define _INTMASK  (ioaddr+0)	/* writable */
@@ -59,6 +59,8 @@

 /* in SETUP register */
 #define PROMISCset	0x10	/* enable RCV_ALL */
+#define P1MODE          0x80    /* enable P1-MODE for Backplane */
+#define SLOWARB         0x01    /* enable Slow Arbitration for >=5Mbps */

 /* COM2002x */
 #define SUB_TENTATIVE	0	/* tentative node ID */



Roman

-- 
Roman Fietze (Mail Code 6)     roman.fietze@de.heidelberg.com
Heidelberg Digital Finishing GmbH, Germany     DDF-T SWEC ESW


