Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUG1RJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUG1RJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267336AbUG1RJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:09:17 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:11806 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267333AbUG1RIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:08:05 -0400
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, bjorn.helgaas@hp.com,
       tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH][1/2] Stop using dev->bus->ops directly in msi.c
X-Message-Flag: Warning: May contain useful information
References: <200407261615.52261.bjorn.helgaas@hp.com>
	<52llh65r6s.fsf@topspin.com> <200407261734.46494.bjorn.helgaas@hp.com>
	<20040726164324.683ff471.akpm@osdl.org> <524qnu5j8l.fsf@topspin.com>
	<20040726183917.65927925.akpm@osdl.org>
	<20040727023927.GB24599@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 28 Jul 2004 10:08:03 -0700
In-Reply-To: <20040727023927.GB24599@kroah.com> (Greg KH's message of "Mon,
 26 Jul 2004 22:39:28 -0400")
Message-ID: <521xiwys98.fsf_-_@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jul 2004 17:08:04.0127 (UTC) FILETIME=[71E292F0:01C474C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First half of the MSI rewrite: pure cleanup.  Use proper
pci_read_config_xxx() and pci_write_config_xxx() functions instead of
accessing raw dev->bus->ops.

Index: linux-2.6.8-rc2/drivers/pci/msi.c
===================================================================
--- linux-2.6.8-rc2.orig/drivers/pci/msi.c
+++ linux-2.6.8-rc2/drivers/pci/msi.c
@@ -64,15 +64,13 @@
 	case PCI_CAP_ID_MSI:
 	{
 		int		pos;
-		unsigned int	mask_bits;
+		u32		mask_bits;
 
 		pos = entry->mask_base;
-	        entry->dev->bus->ops->read(entry->dev->bus, entry->dev->devfn,
-				pos, 4, &mask_bits);
+		pci_read_config_dword(entry->dev, pos, &mask_bits);
 		mask_bits &= ~(1);
 		mask_bits |= flag;
-	        entry->dev->bus->ops->write(entry->dev->bus, entry->dev->devfn,
-				pos, 4, mask_bits);
+		pci_write_config_dword(entry->dev, pos, mask_bits);
 		break;
 	}
 	case PCI_CAP_ID_MSIX:
@@ -105,15 +103,13 @@
    		if (!(pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI)))
 			return;
 
-	        entry->dev->bus->ops->read(entry->dev->bus, entry->dev->devfn,
-			msi_lower_address_reg(pos), 4,
+		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
 			&address.lo_address.value);
 		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
 		address.lo_address.value |= (cpu_mask_to_apicid(cpu_mask) <<
 			MSI_TARGET_CPU_SHIFT);
 		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
-		entry->dev->bus->ops->write(entry->dev->bus, entry->dev->devfn,
-			msi_lower_address_reg(pos), 4,
+		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
 			address.lo_address.value);
 		break;
 	}
@@ -383,51 +379,45 @@
 
 static void enable_msi_mode(struct pci_dev *dev, int pos, int type)
 {
-	u32 control;
+	u16 control;
 
-	dev->bus->ops->read(dev->bus, dev->devfn,
-		msi_control_reg(pos), 2, &control);
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	if (type == PCI_CAP_ID_MSI) {
 		/* Set enabled bits to single MSI & enable MSI_enable bit */
 		msi_enable(control, 1);
-	        dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_control_reg(pos), 2, control);
+		pci_write_config_word(dev, msi_control_reg(pos), control);
 	} else {
 		msix_enable(control);
-	        dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_control_reg(pos), 2, control);
+		pci_write_config_word(dev, msi_control_reg(pos), control);
 	}
     	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
 		/* PCI Express Endpoint device detected */
-		u32 cmd;
-	        dev->bus->ops->read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
+		u16 cmd;
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		cmd |= PCI_COMMAND_INTX_DISABLE;
-	        dev->bus->ops->write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 }
 
 static void disable_msi_mode(struct pci_dev *dev, int pos, int type)
 {
-	u32 control;
+	u16 control;
 
-	dev->bus->ops->read(dev->bus, dev->devfn,
-		msi_control_reg(pos), 2, &control);
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	if (type == PCI_CAP_ID_MSI) {
 		/* Set enabled bits to single MSI & enable MSI_enable bit */
 		msi_disable(control);
-	        dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_control_reg(pos), 2, control);
+		pci_write_config_word(dev, msi_control_reg(pos), control);
 	} else {
 		msix_disable(control);
-	        dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_control_reg(pos), 2, control);
+		pci_write_config_word(dev, msi_control_reg(pos), control);
 	}
     	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
 		/* PCI Express Endpoint device detected */
-		u32 cmd;
-	        dev->bus->ops->read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
+		u16 cmd;
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		cmd &= ~PCI_COMMAND_INTX_DISABLE;
-	        dev->bus->ops->write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 }
 
@@ -480,14 +470,13 @@
 	struct msg_address address;
 	struct msg_data data;
 	int pos, vector;
-	u32 control;
+	u16 control;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	if (!pos)
 		return -EINVAL;
 
-	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
-		2, &control);
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	if (control & PCI_MSI_FLAGS_ENABLE)
 		return 0;
 
@@ -521,27 +510,27 @@
 	msi_data_init(&data, vector);
 	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
 				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-	dev->bus->ops->write(dev->bus, dev->devfn, msi_lower_address_reg(pos),
-				4, address.lo_address.value);
+	pci_write_config_dword(dev, msi_lower_address_reg(pos),
+			address.lo_address.value);
 	if (is_64bit_address(control)) {
-		dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_upper_address_reg(pos), 4, address.hi_address);
-		dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_data_reg(pos, 1), 2, *((u32*)&data));
+		pci_write_config_dword(dev, 
+			msi_upper_address_reg(pos), address.hi_address);
+		pci_write_config_word(dev, 
+			msi_data_reg(pos, 1), *((u32*)&data));
 	} else
-		dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_data_reg(pos, 0), 2, *((u32*)&data));
+		pci_write_config_word(dev, 
+			msi_data_reg(pos, 0), *((u32*)&data));
 	if (entry->msi_attrib.maskbit) {
 		unsigned int maskbits, temp;
 		/* All MSIs are unmasked by default, Mask them all */
-	        dev->bus->ops->read(dev->bus, dev->devfn,
-			msi_mask_bits_reg(pos, is_64bit_address(control)), 4,
+		pci_read_config_dword(dev, 
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
 			&maskbits);
 		temp = (1 << multi_msi_capable(control));
 		temp = ((temp - 1) & ~temp);
 		maskbits |= temp;
-		dev->bus->ops->write(dev->bus, dev->devfn,
-			msi_mask_bits_reg(pos, is_64bit_address(control)), 4,
+		pci_write_config_dword(dev, 
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
 			maskbits);
 	}
 	attach_msi_entry(entry, vector);
@@ -571,7 +560,7 @@
 	struct msg_data data;
 	int vector = 0, pos, dev_msi_cap, i;
 	u32 phys_addr, table_offset;
-	u32 control;
+	u16 control;
 	u8 bir;
 	void *base;
 
@@ -580,8 +569,7 @@
 		return -EINVAL;
 
 	/* Request & Map MSI-X table region */
-	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 2,
-		&control);
+ 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	if (control & PCI_MSIX_FLAGS_ENABLE)
 		return 0;
 
@@ -592,8 +580,8 @@
 	}
 
 	dev_msi_cap = multi_msix_capable(control);
-	dev->bus->ops->read(dev->bus, dev->devfn,
-		msix_table_offset_reg(pos), 4, &table_offset);
+ 	pci_read_config_dword(dev, msix_table_offset_reg(pos),
+ 		&table_offset);
 	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 	phys_addr = pci_resource_start (dev, bir);
 	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
@@ -728,7 +716,8 @@
 	struct msg_address address;
 	struct msg_data data;
 	int i, offset, pos, dev_msi_cap, vector;
-	u32 low_address, control;
+	u32 low_address;
+	u16 control;
 	unsigned long base = 0L;
 	unsigned long flags;
 
@@ -742,8 +731,7 @@
 	spin_unlock_irqrestore(&msi_lock, flags);
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos),
-		2, &control);
+ 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	dev_msi_cap = multi_msix_capable(control);
 	for (i = 1; i < dev_msi_cap; i++) {
 		if (!(low_address = readl(base + i * PCI_MSIX_ENTRY_SIZE)))
@@ -838,7 +826,7 @@
 	struct msi_desc *entry;
 	int i, head, pos, vec, free_vectors, alloc_vectors;
 	int *vectors = (int *)vector;
-	u32 control;
+	u16 control;
 	unsigned long flags;
 
 	if (!pci_msi_enable || !dev)
@@ -847,7 +835,7 @@
    	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
  		return -EINVAL;
 
-	dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
+ 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	if (nvec > multi_msix_capable(control))
 		return -EINVAL;
 
@@ -980,14 +968,13 @@
 	if (type == PCI_CAP_ID_MSIX) {
 		int i, pos, dev_msi_cap;
 		u32 phys_addr, table_offset;
-		u32 control;
+		u16 control;
 		u8 bir;
 
    		pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-		dev->bus->ops->read(dev->bus, dev->devfn, msi_control_reg(pos), 			2, &control);
+		pci_read_config_word(dev, msi_control_reg(pos), &control);
 		dev_msi_cap = multi_msix_capable(control);
-		dev->bus->ops->read(dev->bus, dev->devfn,
-			msix_table_offset_reg(pos), 4, &table_offset);
+		pci_read_config_dword(dev, msix_table_offset_reg(pos), &table_offset);
 		bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
 		phys_addr = pci_resource_start (dev, bir);
 		phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
