Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUHXQtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUHXQtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268119AbUHXQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:49:16 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:50070 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S268126AbUHXQsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:48:09 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ralf Gerbig <rge@hsp-law.de>
Subject: Re: ACPI interrupt routing
Date: Tue, 24 Aug 2004 10:47:54 -0600
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>, Ralf Gerbig <rge-news@quengel.org>,
       linux-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
References: <m0isb9ispy.fsf@test3.hsp-law.de>
In-Reply-To: <m0isb9ispy.fsf@test3.hsp-law.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408241047.54796.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 August 2004 1:01 pm, Ralf Gerbig wrote:
> ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
> bt878(0): Bt878 (rev 17) at 01:06.1, irq: 10, <====================================

Can you try this patch, please?  The bt878 driver has the classic problem
of looking at pci_dev->irq before pci_enable_device().


Call pci_enable_device() before looking at pci_dev.  Also, call
pci_disable_device() when releasing the device.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/media/dvb/bt8xx/bt878.c 1.2 vs edited =====
--- 1.2/drivers/media/dvb/bt8xx/bt878.c	2003-12-30 01:40:50 -07:00
+++ edited/drivers/media/dvb/bt8xx/bt878.c	2004-08-24 10:42:54 -06:00
@@ -417,6 +417,8 @@
 
 	printk(KERN_INFO "bt878: Bt878 AUDIO function found (%d).\n",
 	       bt878_num);
+	if (pci_enable_device(dev))
+		return -EIO;
 
 	bt = &bt878[bt878_num];
 	bt->dev = dev;
@@ -426,11 +428,10 @@
 	bt->id = dev->device;
 	bt->irq = dev->irq;
 	bt->bt878_adr = pci_resource_start(dev, 0);
-	if (pci_enable_device(dev))
-		return -EIO;
 	if (!request_mem_region(pci_resource_start(dev, 0),
 				pci_resource_len(dev, 0), "bt878")) {
-		return -EBUSY;
+		result = -EBUSY;
+		goto fail0;
 	}
 
 	pci_read_config_byte(dev, PCI_CLASS_REVISION, &bt->revision);
@@ -501,6 +502,8 @@
       fail1:
 	release_mem_region(pci_resource_start(bt->dev, 0),
 			   pci_resource_len(bt->dev, 0));
+      fail0:
+	pci_disable_device(dev);
 	return result;
 }
 
@@ -540,6 +543,7 @@
 	bt878_mem_free(bt);
 
 	pci_set_drvdata(pci_dev, NULL);
+	pci_disable_device(pci_dev);
 	return;
 }
 
