Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030657AbWJCXHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbWJCXHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbWJCXHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:07:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2285 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030657AbWJCXHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:07:36 -0400
Subject: [PATCH] video4linux: complete conversion to hotplug safe PCI API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, mchehab@infradead.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 00:32:59 +0100
Message-Id: <1159918379.17553.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/media/video/zoran_card.c linux-2.6.18-mm3/drivers/media/video/zoran_card.c
--- linux.vanilla-2.6.18-mm3/drivers/media/video/zoran_card.c	2006-10-03 19:23:09.282343336 +0100
+++ linux-2.6.18-mm3/drivers/media/video/zoran_card.c	2006-09-25 12:21:26.000000000 +0100
@@ -1278,9 +1278,7 @@
 
 	zoran_num = 0;
 	while (zoran_num < BUZ_MAX &&
-	       (dev =
-		pci_find_device(PCI_VENDOR_ID_ZORAN,
-				PCI_DEVICE_ID_ZORAN_36057, dev)) != NULL) {
+	       (dev = pci_get_device(PCI_VENDOR_ID_ZORAN, PCI_DEVICE_ID_ZORAN_36057, dev)) != NULL) {
 		card_num = card[zoran_num];
 		zr = &zoran[zoran_num];
 		memset(zr, 0, sizeof(struct zoran));	// Just in case if previous cycle failed
@@ -1541,7 +1539,8 @@
 				goto zr_detach_vfe;
 			}
 		}
-
+		/* Success so keep the pci_dev referenced */
+		pci_dev_get(zr->pci_dev);
 		zoran_num++;
 		continue;
 
@@ -1563,6 +1562,9 @@
 		iounmap(zr->zr36057_mem);
 		continue;
 	}
+	if (dev)	/* Clean up ref count on early exit */
+		pci_dev_put(dev);
+		
 	if (zoran_num == 0) {
 		dprintk(1, KERN_INFO "No known MJPEG cards found.\n");
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/media/video/zr36120.c linux-2.6.18-mm3/drivers/media/video/zr36120.c
--- linux.vanilla-2.6.18-mm3/drivers/media/video/zr36120.c	2006-10-03 19:23:09.286342728 +0100
+++ linux-2.6.18-mm3/drivers/media/video/zr36120.c	2006-09-28 14:52:58.000000000 +0100
@@ -1840,16 +1840,16 @@
 	struct zoran *ztv;
 	struct pci_dev *dev = NULL;
 	unsigned char revision;
-	int zoran_num=0;
+	int zoran_num = 0;
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_ZORAN,PCI_DEVICE_ID_ZORAN_36120, dev)))
+	while ((dev = pci_get_device(PCI_VENDOR_ID_ZORAN,PCI_DEVICE_ID_ZORAN_36120, dev)))
 	{
 		/* Ok, a ZR36120/ZR36125 found! */
 		ztv = &zorans[zoran_num];
 		ztv->dev = dev;
 
 		if (pci_enable_device(dev))
-			return -EIO;
+			continue;
 
 		pci_read_config_byte(dev, PCI_CLASS_REVISION, &revision);
 		printk(KERN_INFO "zoran: Zoran %x (rev %d) ",
@@ -1867,17 +1867,18 @@
 		{
 			iounmap(ztv->zoran_mem);
 			printk(KERN_ERR "zoran: Bad irq number or handler\n");
-			return -EINVAL;
+			continue;
 		}
 		if (result==-EBUSY)
 			printk(KERN_ERR "zoran: IRQ %d busy, change your PnP config in BIOS\n",dev->irq);
 		if (result < 0) {
 			iounmap(ztv->zoran_mem);
-			return result;
+			continue;
 		}
 		/* Enable bus-mastering */
 		pci_set_master(dev);
-
+		/* Keep a reference */
+		pci_dev_get(dev);
 		zoran_num++;
 	}
 	if(zoran_num)
@@ -2041,6 +2042,9 @@
 		if (ztv->zoran_mem)
 			iounmap(ztv->zoran_mem);
 
+		/* Drop PCI device */
+		pci_dev_put(ztv->dev);
+		
 		video_unregister_device(&ztv->video_dev);
 		video_unregister_device(&ztv->vbi_dev);
 	}
@@ -2057,13 +2061,12 @@
 
 	handle_chipset();
 	zoran_cards = find_zoran();
-	if (zoran_cards<0)
-		/* no cards found, no need for a driver */
+	if (zoran_cards <= 0)
 		return -EIO;
 
 	/* initialize Zorans */
 	for (card=0; card<zoran_cards; card++) {
-		if (init_zoran(card)<0) {
+		if (init_zoran(card) < 0) {
 			/* only release the zorans we have registered */
 			release_zoran(card);
 			return -EIO;

