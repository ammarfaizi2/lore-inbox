Return-Path: <linux-kernel-owner+w=401wt.eu-S1751638AbWLMWbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWLMWbO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWLMWbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:31:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56429 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751638AbWLMWbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:31:13 -0500
X-Greylist: delayed 1483 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 17:31:13 EST
Date: Wed, 13 Dec 2006 16:06:23 -0600 (CST)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: linux-mips@linux-mips.org, Pat Gefre <pfg@sgi.com>,
       Stanislaw Skowronek <skylark@linux-mips.org>
Subject: [PATCH] IOC3/IOC4: PCI mem space resources
Message-ID: <20061213155832.C56992@pkunk.americas.sgi.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI IOC3 and IOC4 PCI devices implement memory space apertures, not
I/O space apertures.  Use the appropriate region management functions.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
---
I'd appreciate a review/ack by the MIPS folks, just in case I'm unaware of
something special on those systems.

 misc/ioc4.c          |    6 +++---
 serial/ioc4_serial.c |    6 +++---
 sn/ioc3.c            |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)
---
diff --git a/drivers/misc/ioc4.c b/drivers/misc/ioc4.c
index b995a15..6a5a05d 100644
--- a/drivers/misc/ioc4.c
+++ b/drivers/misc/ioc4.c
@@ -309,7 +309,7 @@ ioc4_probe(struct pci_dev *pdev, const s
 		ret = -ENODEV;
 		goto out_pci;
 	}
-	if (!request_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs),
+	if (!request_mem_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs),
 			    "ioc4_misc")) {
 		printk(KERN_WARNING
 		       "%s: Unable to request IOC4 misc region "
@@ -379,7 +379,7 @@ ioc4_probe(struct pci_dev *pdev, const s
 	return 0;
 
 out_misc_region:
-	release_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs));
+	release_mem_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs));
 out_pci:
 	kfree(idd);
 out_idd:
@@ -418,7 +418,7 @@ ioc4_remove(struct pci_dev *pdev)
 		       "Device removal may be incomplete.\n",
 		       __FUNCTION__, pci_name(idd->idd_pdev));
 	}
-	release_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs));
+	release_mem_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs));
 
 	/* Disable IOC4 and relinquish */
 	pci_disable_device(pdev);
diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
index c862f67..f540212 100644
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -2685,7 +2685,7 @@ static int ioc4_serial_remove_one(struct
 		free_irq(control->ic_irq, soft);
 		if (soft->is_ioc4_serial_addr) {
 			iounmap(soft->is_ioc4_serial_addr);
-			release_region((unsigned long)
+			release_mem_region((unsigned long)
 			     soft->is_ioc4_serial_addr,
 				sizeof(struct ioc4_serial));
 		}
@@ -2790,7 +2790,7 @@ ioc4_serial_attach_one(struct ioc4_drive
 	/* request serial registers */
 	tmp_addr1 = idd->idd_bar0 + IOC4_SERIAL_OFFSET;
 
-	if (!request_region(tmp_addr1, sizeof(struct ioc4_serial),
+	if (!request_mem_region(tmp_addr1, sizeof(struct ioc4_serial),
 					"sioc4_uart")) {
 		printk(KERN_WARNING
 			"ioc4 (%p): unable to get request region for "
@@ -2889,7 +2889,7 @@ out3:
 out2:
 	if (serial)
 		iounmap(serial);
-	release_region(tmp_addr1, sizeof(struct ioc4_serial));
+	release_mem_region(tmp_addr1, sizeof(struct ioc4_serial));
 out1:
 
 	return ret;
diff --git a/drivers/sn/ioc3.c b/drivers/sn/ioc3.c
index cd6b653..2dd6eed 100644
--- a/drivers/sn/ioc3.c
+++ b/drivers/sn/ioc3.c
@@ -654,7 +654,7 @@ #endif
 		ret = -ENODEV;
 		goto out_pci;
 	}
-	if (!request_region(idd->pma, IOC3_PCI_SIZE, "ioc3")) {
+	if (!request_mem_region(idd->pma, IOC3_PCI_SIZE, "ioc3")) {
 		printk(KERN_WARNING
 		       "%s: Unable to request IOC3 region "
 		       "for pci_dev %s.\n",
@@ -744,7 +744,7 @@ #endif
 	return 0;
 
 out_misc_region:
-	release_region(idd->pma, IOC3_PCI_SIZE);
+	release_mem_region(idd->pma, IOC3_PCI_SIZE);
 out_pci:
 	kfree(idd);
 out_idd:
@@ -785,7 +785,7 @@ static void ioc3_remove(struct pci_dev *
 	if(idd->dual_irq)
 		free_irq(idd->irq_eth, (void *)idd);
 	iounmap(idd->vma);
-	release_region(idd->pma, IOC3_PCI_SIZE);
+	release_mem_region(idd->pma, IOC3_PCI_SIZE);
 
 	/* Disable IOC3 and relinquish */
 	pci_disable_device(pdev);
