Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbWFAGeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbWFAGeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWFAGeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:34:36 -0400
Received: from palrel10.hp.com ([156.153.255.245]:27278 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S965196AbWFAGef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:34:35 -0400
Date: Wed, 31 May 2006 23:35:47 -0700
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060601063547.GA5531@esmail.cup.hp.com>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net> <20060217075829.GB22451@esmail.cup.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217075829.GB22451@esmail.cup.hp.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 11:58:29PM -0800, Grant Grundler wrote:
> Log Entry:
...
> 	Second part of this patch deals with "useless" code.
> 	We walk through the steps to find the phys_addr and then
> 	don't use the result. I suspect the intent was to zero
> 	out the respective MSI-X entry but I'm not sure at the moment.
> 	Delete the code inside the #if 0/#endif if it's really
> 	not needed.

The code is really not needed.
Roland Dreier/Greg KH removed the release_mem_region() calls that
were the only consumers of phys_addr:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0503.0/1540.html

patch below deletes the "dead" code.

thanks,
grant

Signed-off-by: Grant Grundler <iod00d@hp.com>


--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1008,33 +1008,8 @@ static int msi_free_vector(struct pci_de
 				entry_nr * PCI_MSIX_ENTRY_SIZE +
 				PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET);
 
-		if (head == vector) {
-			/*
-			 * Detect last MSI-X vector to be released.
-			 * Release the MSI-X memory-mapped table.
-			 */
-#if 0
-			int pos, nr_entries;
-			unsigned long phys_addr;
-			u32 table_offset;
-			u16 control;
-			u8 bir;
-
-   			pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-			pci_read_config_word(dev, msi_control_reg(pos),
-				&control);
-			nr_entries = multi_msix_capable(control);
-			pci_read_config_dword(dev, msix_table_offset_reg(pos),
-				&table_offset);
-			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-			table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
-			phys_addr = pci_resource_start(dev, bir) + table_offset;
-/*
- * FIXME!  and what did you want to do with phys_addr?
- */
-#endif
+		if (head == vector)
 			iounmap(base);
-		}
 	}
 
 	return 0;
@@ -1300,24 +1275,6 @@ void msi_remove_pci_irq_vectors(struct p
 		}
 		msi_free_vector(dev, vector, 0);
 		if (warning) {
-			/* Force to release the MSI-X memory-mapped table */
-#if 0
-			unsigned long phys_addr;
-			u32 table_offset;
-			u16 control;
-			u8 bir;
-
-			pci_read_config_word(dev, msi_control_reg(pos),
-				&control);
-			pci_read_config_dword(dev, msix_table_offset_reg(pos),
-				&table_offset);
-			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-			table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
-			phys_addr = pci_resource_start(dev, bir) + table_offset;
-/*
- * FIXME! and what did you want to do with phys_addr?
- */
-#endif
 			iounmap(base);
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
 			       "called without free_irq() on all MSI-X vectors\n",
