Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUJBOqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUJBOqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 10:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUJBOqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 10:46:25 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:6688 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266273AbUJBOqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 10:46:16 -0400
To: greg@kroah.com, tom.l.nguyen@intel.com
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Sat, 02 Oct 2004 07:46:14 -0700
Message-ID: <52is9tw53d.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] Add __iomem annotations to drivers/pci/msi.c
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 02 Oct 2004 14:46:14.0813 (UTC) FILETIME=[9133CCD0:01C4A88E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/pci/msi.c uses the mask_base member of struct msi_desc to hold
both an offset within the PCI config header (for MSI mode) and an
ioremap cookie (for MSI-X mode).  This patch splits the field into a
union so that we can put these values into something appropriately
typed, so both gcc and sparse are happy.

Tested with my MSI-X device; unfortunately I don't have an MSI device
that supports masking so I can't test that, but the changes are pretty
small and "obviously correct."

Thanks,
  Roland


Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/drivers/pci/msi.c
===================================================================
--- linux-bk.orig/drivers/pci/msi.c	2004-10-01 13:15:47.000000000 -0700
+++ linux-bk/drivers/pci/msi.c	2004-10-01 14:50:35.000000000 -0700
@@ -58,7 +58,7 @@
 	struct msi_desc *entry;
 
 	entry = (struct msi_desc *)msi_desc[vector];
-	if (!entry || !entry->dev || !entry->mask_base)
+	if (!entry || !entry->dev)
 		return;
 	switch (entry->msi_attrib.type) {
 	case PCI_CAP_ID_MSI:
@@ -66,7 +66,9 @@
 		int		pos;
 		u32		mask_bits;
 
-		pos = entry->mask_base;
+		if (!entry->mask_base.msi)
+			return;
+		pos = entry->mask_base.msi;
 		pci_read_config_dword(entry->dev, pos, &mask_bits);
 		mask_bits &= ~(1);
 		mask_bits |= flag;
@@ -77,7 +79,10 @@
 	{
 		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_VECTOR_CTRL_OFFSET;
-		writel(flag, entry->mask_base + offset);
+
+		if (!entry->mask_base.msix)
+			return;
+		writel(flag, entry->mask_base.msix + offset);
 		break;
 	}
 	default:
@@ -118,12 +123,12 @@
 		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
 
-		address.lo_address.value = readl(entry->mask_base + offset);
+		address.lo_address.value = readl(entry->mask_base.msix + offset);
 		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
 		address.lo_address.value |= (cpu_mask_to_apicid(cpu_mask) <<
 			MSI_TARGET_CPU_SHIFT);
 		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
-		writel(address.lo_address.value, entry->mask_base + offset);
+		writel(address.lo_address.value, entry->mask_base.msix + offset);
 		break;
 	}
 	default:
@@ -548,7 +553,7 @@
 	dev->irq = vector;
 	entry->dev = dev;
 	if (is_mask_bit_support(control)) {
-		entry->mask_base = msi_mask_bits_reg(pos,
+		entry->mask_base.msi = msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
 	/* Replace with MSI handler */
@@ -606,7 +611,7 @@
 	u32 phys_addr, table_offset;
  	u16 control;
 	u8 bir;
-	void *base;
+	void __iomem *base;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	/* Request & Map MSI-X table region */
@@ -642,7 +647,7 @@
 		entry->msi_attrib.maskbit = 1;
 		entry->msi_attrib.default_vector = dev->irq;
 		entry->dev = dev;
-		entry->mask_base = (unsigned long)base;
+		entry->mask_base.msix = base;
 		if (!head) {
 			entry->link.head = vector;
 			entry->link.tail = vector;
@@ -806,7 +811,7 @@
 {
 	struct msi_desc *entry;
 	int head, entry_nr, type;
-	unsigned long base = 0L;
+	void __iomem *base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
@@ -818,7 +823,7 @@
 	type = entry->msi_attrib.type;
 	entry_nr = entry->msi_attrib.entry_nr;
 	head = entry->link.head;
-	base = entry->mask_base;
+	base = entry->mask_base.msix;
 	msi_desc[entry->link.head]->link.tail = entry->link.tail;
 	msi_desc[entry->link.tail]->link.head = entry->link.head;
 	entry->dev = NULL;
@@ -857,7 +862,7 @@
 			phys_addr = pci_resource_start (dev, bir);
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
-			iounmap((void*)base);
+			iounmap(base);
 			release_mem_region(phys_addr,
 				nr_entries * PCI_MSIX_ENTRY_SIZE);
 		}
@@ -870,7 +875,7 @@
 {
 	int vector = head, tail = 0;
 	int i = 0, j = 0, nr_entries = 0;
-	unsigned long base = 0L;
+	void __iomem *base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
@@ -894,7 +899,7 @@
 		nr_released_vectors--;
 		entries[i].vector = vector;
 		if (j != (entries + i)->entry) {
-			base = msi_desc[vector]->mask_base;
+			base = msi_desc[vector]->mask_base.msix;
 			msi_desc[vector]->msi_attrib.entry_nr =
 				(entries + i)->entry;
 			writel( readl(base + j * PCI_MSIX_ENTRY_SIZE +
@@ -1099,14 +1104,14 @@
    	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) > 0 &&
 		!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
 		int vector, head, tail = 0, warning = 0;
-		unsigned long base = 0L;
+		void __iomem *base = NULL;
 
 		vector = head = dev->irq;
 		while (head != tail) {
 			spin_lock_irqsave(&msi_lock, flags);
 			state = msi_desc[vector]->msi_attrib.state;
 			tail = msi_desc[vector]->link.tail;
-			base = msi_desc[vector]->mask_base;
+			base = msi_desc[vector]->mask_base.msix;
 			spin_unlock_irqrestore(&msi_lock, flags);
 			if (state)
 				warning = 1;
@@ -1129,7 +1134,7 @@
 			phys_addr = pci_resource_start (dev, bir);
 			phys_addr += (u32)(table_offset &
 				~PCI_MSIX_FLAGS_BIRMASK);
-			iounmap((void*)base);
+			iounmap(base);
 			release_mem_region(phys_addr, PCI_MSIX_ENTRY_SIZE *
 				multi_msix_capable(control));
 			printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on all vectors\n",
Index: linux-bk/drivers/pci/msi.h
===================================================================
--- linux-bk.orig/drivers/pci/msi.h	2004-10-01 13:15:47.000000000 -0700
+++ linux-bk/drivers/pci/msi.h	2004-10-01 11:13:23.000000000 -0700
@@ -152,7 +152,10 @@
 		__u16	tail;
 	}link;
 
-	unsigned long mask_base;
+	union {
+		int		msi;
+		void __iomem	*msix;
+	} mask_base;
 	struct pci_dev *dev;
 };
 
