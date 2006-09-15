Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWIOOH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWIOOH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIOOH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:07:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9642 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751482AbWIOOHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:07:25 -0400
Subject: [PATCH] zr36120: switch to pci_get_device refcounting API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mchehab@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:31:11 +0100
Message-Id: <1158330671.29932.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zr36120.c linux-2.6.18-rc6-mm1/drivers/media/video/zr36120.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/media/video/zr36120.c	2006-09-11 11:02:17.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/media/video/zr36120.c	2006-09-14 17:27:39.000000000 +0100
@@ -1836,16 +1840,16 @@
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
@@ -1863,17 +1867,18 @@
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
@@ -2037,6 +2043,9 @@
 		if (ztv->zoran_mem)
 			iounmap(ztv->zoran_mem);
 
+		/* Drop PCI device */
+		pci_dev_put(ztv->dev);
+		
 		video_unregister_device(&ztv->video_dev);
 		video_unregister_device(&ztv->vbi_dev);
 	}

