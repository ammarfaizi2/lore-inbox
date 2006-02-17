Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWBQH6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWBQH6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWBQH6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:58:21 -0500
Received: from palrel10.hp.com ([156.153.255.245]:49798 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932572AbWBQH6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:58:20 -0500
Date: Thu, 16 Feb 2006 23:58:29 -0800
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060217075829.GB22451@esmail.cup.hp.com>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:14:22AM -0600, Miller, Mike (OS Dev) wrote:
> Hello,
> Has anyone tested MSI-X on ia64 based platforms? We're using a 2.6.9
> variant and a cciss driver with MSI/MSI-X support. The kernel has MSI
> enabled. On ia64 the MSI-X table is all zeroes. On Intel x86_64
> platforms the table contains valid data and everything works as
> expected.

Greg,
The root cause is the use of u32 to describe a PCI resource "start".
phys_addr needs to be "unsigned long". More details in Log entry below.
Patch applies to 2.6.16-rc3 and should apply to 2.6.15 as well.

I tested this with 2.6.15 on the same HW Mike Miller was having problems.


My clue from the PCI 3.0 spec:
| 6.8.2. MSI-X Capability and Table Structures
| ...
| Each structure is mapped by a Base Address register (BAR) belonging
| to the function,located beginning at 10h in Configuration Space.
| A BAR Indicator register (BIR) indicates which BAR, and a
| QWORD-aligned Offset indicates where the structure begins
| relative to the base address associated with the BAR. The BAR is
| permitted to be either 32-bit or 64-bit, but must map Memory Space.
| A function is permitted to map both structures with the same BAR,
| or to map each structure with a different BAR.


"or 64-bit".  This is also relevant to boxen which do not
equivalently map 32-bit PCI MMIO and Host physical address space.

thanks,
grant


Log Entry:

	Use "unsigned long" when dealing with PCI resources.
	The BAR Indicator Register (BIR) can be a 64-bit value
	or the resource could be a 64-bit host physical address.

	Enables ib_mthca and cciss drivers to use MSI-X on ia64 HW.
	Problem showed up now because of new system firmware on one platform.
	Symptom will either be memory corruption or MCA.

	Second part of this patch deals with "useless" code.
	We walk through the steps to find the phys_addr and then
	don't use the result. I suspect the intent was to zero
	out the respective MSI-X entry but I'm not sure at the moment.
	Delete the code inside the #if 0/#endif if it's really
	not needed.

Signed-off-by: Grant Grundler <iod00d@hp.com>


--- linux-2.6.16-rc3/drivers/pci/msi.c	4 Feb 2006 04:51:55 -0000	1.17
+++ linux-ggg/drivers/pci/msi.c	17 Feb 2006 07:04:41 -0000
@@ -597,7 +597,8 @@ static int msix_capability_init(struct p
 	struct msg_address address;
 	struct msg_data data;
 	int vector, pos, i, j, nr_entries, temp = 0;
-	u32 phys_addr, table_offset;
+	unsigned long phys_addr;
+	u32 table_offset;
  	u16 control;
 	u8 bir;
 	void __iomem *base;
@@ -606,11 +607,11 @@ static int msix_capability_init(struct p
 	/* Request & Map MSI-X table region */
  	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	nr_entries = multi_msix_capable(control);
- 	pci_read_config_dword(dev, msix_table_offset_reg(pos),
- 		&table_offset);
+
+ 	pci_read_config_dword(dev, msix_table_offset_reg(pos), &table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-	phys_addr = pci_resource_start (dev, bir);
-	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
+	table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
+	phys_addr = pci_resource_start (dev, bir) + table_offset;
 	base = ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
 	if (base == NULL)
 		return -ENOMEM;
@@ -826,8 +827,10 @@ static int msi_free_vector(struct pci_de
 			 * Detect last MSI-X vector to be released.
 			 * Release the MSI-X memory-mapped table.
 			 */
+#if 0
 			int pos, nr_entries;
-			u32 phys_addr, table_offset;
+			unsigned long phys_addr;
+			u32 table_offset;
 			u16 control;
 			u8 bir;
 
@@ -838,9 +841,12 @@ static int msi_free_vector(struct pci_de
 			pci_read_config_dword(dev, msix_table_offset_reg(pos),
 				&table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-			phys_addr = pci_resource_start (dev, bir);
-			phys_addr += (u32)(table_offset &
-				~PCI_MSIX_FLAGS_BIRMASK);
+			table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
+			phys_addr = pci_resource_start(dev, bir) + table_offset;
+/*
+ * FIXME!  and what did you want to do with phys_addr?
+ */
+#endif
 			iounmap(base);
 		}
 	}
@@ -1101,7 +1107,9 @@ void msi_remove_pci_irq_vectors(struct p
 		msi_free_vector(dev, vector, 0);
 		if (warning) {
 			/* Force to release the MSI-X memory-mapped table */
-			u32 phys_addr, table_offset;
+#if 0
+			unsigned long phys_addr;
+			u32 table_offset;
 			u16 control;
 			u8 bir;
 
@@ -1110,9 +1118,12 @@ void msi_remove_pci_irq_vectors(struct p
 			pci_read_config_dword(dev, msix_table_offset_reg(pos),
 				&table_offset);
 			bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-			phys_addr = pci_resource_start (dev, bir);
-			phys_addr += (u32)(table_offset &
-				~PCI_MSIX_FLAGS_BIRMASK);
+			table_offset &= ~PCI_MSIX_FLAGS_BIRMASK;
+			phys_addr = pci_resource_start(dev, bir) + table_offset;
+/*
+ * FIXME! and what did you want to do with phys_addr?
+ */
+#endif
 			iounmap(base);
 			printk(KERN_WARNING "PCI: %s: msi_remove_pci_irq_vectors() "
 			       "called without free_irq() on all MSI-X vectors\n",
