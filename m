Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVAQXYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVAQXYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVAQWSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:18:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:63911 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262925AbVAQWCF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:05 -0500
Cc: roland@topspin.com
Subject: [PATCH] PCI: Clean up printks in msi.c
In-Reply-To: <11059993122424@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:52 -0800
Message-Id: <11059993122763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.4, 2005/01/14 15:57:49-08:00, roland@topspin.com

[PATCH] PCI: Clean up printks in msi.c

Add "PCI:" prefixes and fix up the formatting and grammar of printks
in drivers/pci/msi.c.  The main motivation was to fix the shouting
"MSI INIT SUCCESS" message printed when an MSI-using driver is first
started, but while we're at it we might as well tidy up all the messages.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/msi.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	2005-01-17 13:56:08 -08:00
+++ b/drivers/pci/msi.c	2005-01-17 13:56:08 -08:00
@@ -374,19 +374,18 @@
 
 	if ((status = msi_cache_init()) < 0) {
 		pci_msi_enable = 0;
-		printk(KERN_INFO "WARNING: MSI INIT FAILURE\n");
+		printk(KERN_WARNING "PCI: MSI cache init failed\n");
 		return status;
 	}
 	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
 	if (last_alloc_vector < 0) {
 		pci_msi_enable = 0;
-		printk(KERN_INFO "WARNING: ALL VECTORS ARE BUSY\n");
+		printk(KERN_WARNING "PCI: No interrupt vectors available for MSI\n");
 		status = -EBUSY;
 		return status;
 	}
 	vector_irq[last_alloc_vector] = 0;
 	nr_released_vectors++;
-	printk(KERN_INFO "MSI INIT SUCCESS\n");
 
 	return status;
 }
@@ -736,7 +735,9 @@
 	/* Check whether driver already requested for MSI-X vectors */
    	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 &&
 		!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
-			printk(KERN_INFO "Can't enable MSI. Device already had MSI-X vectors assigned\n");
+			printk(KERN_INFO "PCI: %s: Can't enable MSI.  "
+			       "Device already has MSI-X vectors assigned\n",
+			       pci_name(dev));
 			dev->irq = temp;
 			return -EINVAL;
 	}
@@ -774,9 +775,9 @@
 	}
 	if (entry->msi_attrib.state) {
 		spin_unlock_irqrestore(&msi_lock, flags);
-		printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on vector->%d\n",
-		dev->bus->number, PCI_SLOT(dev->devfn),	PCI_FUNC(dev->devfn),
-		dev->irq);
+		printk(KERN_WARNING "PCI: %s: pci_disable_msi() called without "
+		       "free_irq() on MSI vector %d\n",
+		       pci_name(dev), dev->irq);
 		BUG_ON(entry->msi_attrib.state > 0);
 	} else {
 		vector_irq[dev->irq] = 0; /* free it */
@@ -982,7 +983,9 @@
 	/* Check whether driver already requested for MSI vector */
    	if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0 &&
 		!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
-		printk(KERN_INFO "Can't enable MSI-X. Device already had MSI vector assigned\n");
+		printk(KERN_INFO "PCI: %s: Can't enable MSI-X.  "
+		       "Device already has an MSI vector assigned\n",
+		       pci_name(dev));
 		dev->irq = temp;
 		return -EINVAL;
 	}
@@ -1050,9 +1053,9 @@
 		spin_unlock_irqrestore(&msi_lock, flags);
 		if (warning) {
 			dev->irq = temp;
-			printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on all vectors\n",
-			dev->bus->number, PCI_SLOT(dev->devfn),
-			PCI_FUNC(dev->devfn));
+			printk(KERN_WARNING "PCI: %s: pci_disable_msix() called without "
+			       "free_irq() on all MSI-X vectors\n",
+			       pci_name(dev));
 			BUG_ON(warning > 0);
 		} else {
 			dev->irq = temp;
@@ -1088,9 +1091,9 @@
 		state = msi_desc[dev->irq]->msi_attrib.state;
 		spin_unlock_irqrestore(&msi_lock, flags);
 		if (state) {
-			printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on vector->%d\n",
-			dev->bus->number, PCI_SLOT(dev->devfn),
-			PCI_FUNC(dev->devfn), dev->irq);
+			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
+			       "called without free_irq() on MSI vector %d\n",
+			       pci_name(dev), dev->irq);
 			BUG_ON(state > 0);
 		} else /* Release MSI vector assigned to this device */
 			msi_free_vector(dev, dev->irq, 0);
@@ -1132,9 +1135,9 @@
 			iounmap(base);
 			release_mem_region(phys_addr, PCI_MSIX_ENTRY_SIZE *
 				multi_msix_capable(control));
-			printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on all vectors\n",
-				dev->bus->number, PCI_SLOT(dev->devfn),
-				PCI_FUNC(dev->devfn));
+			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
+			       "called without free_irq() on all MSI-X vectors\n",
+			       pci_name(dev));
 			BUG_ON(warning > 0);
 		}
 		dev->irq = temp;		/* Restore IOAPIC IRQ */

