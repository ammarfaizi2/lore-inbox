Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVAJSBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVAJSBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVAJRzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:55:39 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:16024 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262378AbVAJRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:39:30 -0500
To: Greg KH <greg@kroah.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
X-Message-Flag: Warning: May contain useful information
References: <52sm59yzsx.fsf@topspin.com>
	<Pine.LNX.4.61.0501101022500.26637@montezuma.fsmlabs.com>
	<20050110173133.GA30605@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 10 Jan 2005 09:39:02 -0800
In-Reply-To: <20050110173133.GA30605@kroah.com> (Greg KH's message of "Mon,
 10 Jan 2005 09:31:34 -0800")
Message-ID: <52k6qlyyix.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] PCI: Clean up printks in msi.c
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 10 Jan 2005 17:39:03.0345 (UTC) FILETIME=[46A33A10:01C4F73B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> I agree.  Roland, care to change it?

No problem, here's the patch without any "success" message.


Add "PCI:" prefixes and fix up the formatting and grammar of printks
in drivers/pci/msi.c.  The main motivation was to fix the shouting
"MSI INIT SUCCESS" message printed when an MSI-using driver is first
started, but while we're at it we might as well tidy up all the messages.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/drivers/pci/msi.c
===================================================================
--- linux-bk.orig/drivers/pci/msi.c	2005-01-10 08:32:50.208912010 -0800
+++ linux-bk/drivers/pci/msi.c	2005-01-10 09:37:37.868724920 -0800
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

