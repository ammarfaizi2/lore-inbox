Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUHDViG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUHDViG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHDVeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:34:02 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:49348 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267443AbUHDVdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:33:01 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ibmasm: add missing pci_enable_device()
Date: Wed, 4 Aug 2004 15:32:55 -0600
User-Agent: KMail/1.6.2
Cc: amax@us.ibm.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041532.55146.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have this hardware, so this has not been tested.


Add pci_enable_device()/pci_disable_device().  In the past, drivers
often worked without this, but it is now required in order to route
PCI interrupts correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/misc/ibmasm/module.c 1.2 vs edited =====
--- 1.2/drivers/misc/ibmasm/module.c	2004-05-14 06:00:50 -06:00
+++ edited/drivers/misc/ibmasm/module.c	2004-08-04 13:15:46 -06:00
@@ -62,10 +62,17 @@
 	int result = -ENOMEM;
 	struct service_processor *sp;
 
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
+			DRIVER_NAME, pci_name(pdev));
+		return -ENODEV;
+	}
+
 	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
 	if (sp == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
-		return result;
+		result = -ENOMEM;
+		goto error_kmalloc;
 	}
 	memset(sp, 0, sizeof(struct service_processor));
 
@@ -148,6 +155,8 @@
 	ibmasm_event_buffer_exit(sp);
 error_eventbuffer:
 	kfree(sp);
+error_kmalloc:
+	pci_disable_device(pdev);
 
 	return result;
 }
@@ -166,6 +175,7 @@
 	iounmap(sp->base_address);
 	ibmasm_event_buffer_exit(sp);
 	kfree(sp);
+	pci_disable_device(pdev);
 }
 
 static struct pci_device_id ibmasm_pci_table[] =
