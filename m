Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUJUHCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUJUHCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUJUHBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:01:47 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:15240 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270147AbUJUG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:59:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Sonypi: use pci_get_device
Date: Thu, 21 Oct 2004 01:59:35 -0500
User-Agent: KMail/1.6.2
Cc: stelian@popies.net
References: <200410210154.58301.dtor_core@ameritech.net> <200410210158.12014.dtor_core@ameritech.net> <200410210158.57064.dtor_core@ameritech.net>
In-Reply-To: <200410210158.57064.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210159.38252.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1980, 2004-10-21 01:48:41-05:00, dtor_core@ameritech.net
  Sonypi: switch from pci_find_device to pci_get_device.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sonypi.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-21 01:54:57 -05:00
+++ b/drivers/char/sonypi.c	2004-10-21 01:54:57 -05:00
@@ -750,11 +750,16 @@
 	.shutdown	= sonypi_shutdown,
 };
 
-static int __devinit sonypi_probe(struct pci_dev *pcidev)
+static int __devinit sonypi_probe(void)
 {
 	int i, ret;
 	struct sonypi_ioport_list *ioport_list;
 	struct sonypi_irq_list *irq_list;
+	struct pci_dev *pcidev;
+
+	pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
+				 PCI_DEVICE_ID_INTEL_82371AB_3,
+				 NULL);
 
 	spin_lock_init(&sonypi_device.queue.s_lock);
 	init_waitqueue_head(&sonypi_device.proc_list);
@@ -881,6 +886,7 @@
 out2:
 	misc_deregister(&sonypi_misc_device);
 out1:
+	pci_dev_put(sonypi_device.dev);
 	return ret;
 }
 
@@ -896,6 +902,7 @@
 	platform_device_unregister(sonypi_device.pdev);
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
+	pci_dev_put(sonypi_device.dev);
 	misc_deregister(&sonypi_misc_device);
 	printk(KERN_INFO "sonypi: removed.\n");
 }
@@ -920,7 +927,6 @@
 
 static int __init sonypi_init_module(void)
 {
-	struct pci_dev *pcidev;
 	int ret;
 
 	if (!dmi_check_system(sonypi_dmi_table))
@@ -930,10 +936,7 @@
 	if (ret)
 		return ret;
 
-	pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
-				 PCI_DEVICE_ID_INTEL_82371AB_3,
-				 NULL);
-	ret = sonypi_probe(pcidev);
+	ret = sonypi_probe();
 	if (ret)
 		driver_unregister(&sonypi_driver);
 
