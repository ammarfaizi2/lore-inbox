Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263222AbVCDVsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbVCDVsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbVCDVpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:45:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:32929 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263108AbVCDUyP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:15 -0500
Cc: roland@topspin.com
Subject: [PATCH] PCI: clean up the msi api
In-Reply-To: <1109969637195@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:58 -0800
Message-Id: <11099696383032@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.21, 2005/02/17 15:07:01-08:00, roland@topspin.com

[PATCH] PCI: clean up the msi api

Remove the call to request_mem_region() in msix_capability_init() to
grab the MSI-X vector table.  Drivers should be using
pci_request_regions() so that they own all of the PCI BARs, and the
MSI-X core should trust it's being called by a correct driver.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/msi.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	2005-03-04 12:41:47 -08:00
+++ b/drivers/pci/msi.c	2005-03-04 12:41:47 -08:00
@@ -616,15 +616,10 @@
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 	phys_addr = pci_resource_start (dev, bir);
 	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
-	if (!request_mem_region(phys_addr,
-		nr_entries * PCI_MSIX_ENTRY_SIZE,
-		"MSI-X vector table"))
-		return -ENOMEM;
 	base = ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
-	if (base == NULL) {
-		release_mem_region(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
+	if (base == NULL)
 		return -ENOMEM;
-	}
+
 	/* MSI-X Table Initialization */
 	for (i = 0; i < nvec; i++) {
 		entry = alloc_msi_entry();
@@ -859,8 +854,6 @@
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
 			iounmap(base);
-			release_mem_region(phys_addr,
-				nr_entries * PCI_MSIX_ENTRY_SIZE);
 		}
 	}
 
@@ -1133,8 +1126,6 @@
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
 			iounmap(base);
-			release_mem_region(phys_addr, PCI_MSIX_ENTRY_SIZE *
-				multi_msix_capable(control));
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
 			       "called without free_irq() on all MSI-X vectors\n",
 			       pci_name(dev));

