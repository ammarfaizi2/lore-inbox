Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWFNXIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWFNXIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWFNXIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:08:52 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:64206 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S964988AbWFNXIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:08:51 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 1/7] CCISS: disable device when returning failure
Date: Wed, 14 Jun 2006 17:08:33 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200606141707.27404.bjorn.helgaas@hp.com>
In-Reply-To: <200606141707.27404.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141708.33625.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If something fails after we call pci_enable_device(), we should call
pci_disable_device() before returning the failure.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc5-mm3/drivers/block/cciss.c
===================================================================
--- rc5-mm3.orig/drivers/block/cciss.c	2006-06-14 14:29:40.000000000 -0600
+++ rc5-mm3/drivers/block/cciss.c	2006-06-14 14:36:03.000000000 -0600
@@ -2744,7 +2744,7 @@
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
 	__u64 cfg_base_addr_index;
-	int i;
+	int i, err;
 
 	/* check to see if controller has been disabled */
 	/* BEFORE trying to enable it */
@@ -2752,13 +2752,14 @@
 	if(!(command & 0x02))
 	{
 		printk(KERN_WARNING "cciss: controller appears to be disabled\n");
-		return(-1);
+		return -ENODEV;
 	}
 
-	if (pci_enable_device(pdev))
+	err = pci_enable_device(pdev);
+	if (err)
 	{
 		printk(KERN_ERR "cciss: Unable to Enable PCI device\n");
-		return( -1);
+		return err;
 	}
 
 	subsystem_vendor_id = pdev->subsystem_vendor;
@@ -2824,7 +2825,8 @@
 	}
 	if (scratchpad != CCISS_FIRMWARE_READY) {
 		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
-		return -1;
+		err = -ENODEV;
+		goto err_out_disable_pdev;
 	}
 
 	/* get the address index number */
@@ -2841,7 +2843,8 @@
 	if (cfg_base_addr_index == -1) {
 		printk(KERN_WARNING "cciss: Cannot find cfg_base_addr_index\n");
 		release_io_mem(c);
-		return -1;
+		err = -ENODEV;
+		goto err_out_disable_pdev;
 	}
 
 	cfg_offset = readl(c->vaddr + SA5_CTMEM_OFFSET);
@@ -2868,7 +2871,8 @@
 		printk(KERN_WARNING "cciss: Sorry, I don't know how"
 			" to access the Smart Array controller %08lx\n", 
 				(unsigned long)board_id);
-		return -1;
+		err = -ENODEV;
+		goto err_out_disable_pdev;
 	}
 	if (  (readb(&c->cfgtable->Signature[0]) != 'C') ||
 	      (readb(&c->cfgtable->Signature[1]) != 'I') ||
@@ -2876,7 +2880,8 @@
 	      (readb(&c->cfgtable->Signature[3]) != 'S') )
 	{
 		printk("Does not appear to be a valid CISS config table\n");
-		return -1;
+		err = -ENODEV;
+		goto err_out_disable_pdev;
 	}
 
 #ifdef CONFIG_X86
@@ -2920,10 +2925,14 @@
 	{
 		printk(KERN_WARNING "cciss: unable to get board into"
 					" simple mode\n");
-		return -1;
+		err = -ENODEV;
+		goto err_out_disable_pdev;
 	}
 	return 0;
 
+err_out_disable_pdev:
+	pci_disable_device(pdev);
+	return err;
 }
 
 /* 
