Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVL0CMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVL0CMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 21:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVL0CMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 21:12:40 -0500
Received: from fmr20.intel.com ([134.134.136.19]:57282 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750824AbVL0CMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 21:12:39 -0500
Subject: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Greg <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Content-Type: text/plain
Message-Id: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 27 Dec 2005 10:05:18 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add MSI(X) configure space save/restore in generic PCI helper.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

---

 linux-2.6.15-rc5-root/drivers/pci/msi.c        |  211 +++++++++++++++++++++----
 linux-2.6.15-rc5-root/drivers/pci/pci.c        |    6 
 linux-2.6.15-rc5-root/drivers/pci/pci.h        |    8 
 linux-2.6.15-rc5-root/include/linux/pci.h      |    1 
 linux-2.6.15-rc5-root/include/linux/pci_regs.h |    1 
 5 files changed, 198 insertions(+), 29 deletions(-)

diff -puN drivers/pci/msi.c~msi_save_restore drivers/pci/msi.c
--- linux-2.6.15-rc5/drivers/pci/msi.c~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
+++ linux-2.6.15-rc5-root/drivers/pci/msi.c	2005-12-27 09:00:10.000000000 +0800
@@ -499,6 +499,185 @@ void pci_scan_msi_device(struct pci_dev 
 		nr_reserved_vectors++;
 }
 
+int pci_save_msi_state(struct pci_dev *dev)
+{
+	int pos, i = 0;
+	u16 control;
+	u32 *cap;
+
+	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) <= 0 ||
+			dev->no_msi)
+		return 0;
+
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	if (!(control & PCI_MSI_FLAGS_ENABLE))
+		return 0;
+
+	cap = kzalloc(sizeof(u32) * 5, GFP_KERNEL);
+	if (!cap) {
+		printk(KERN_ERR "Out of memory in pci_save_msi_state\n");
+		return -ENOMEM;
+	}
+
+	pci_read_config_dword(dev, pos, &cap[i++]);
+	control = cap[0] >> 16;
+	pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, &cap[i++]);
+	if (control & PCI_MSI_FLAGS_64BIT) {
+		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, &cap[i++]);
+		pci_read_config_dword(dev, pos + PCI_MSI_DATA_64, &cap[i++]);
+	} else
+		pci_read_config_dword(dev, pos + PCI_MSI_DATA_32, &cap[i++]);
+	if (control & PCI_MSI_FLAGS_MASKBIT)
+		pci_read_config_dword(dev, pos + PCI_MSI_MASK_BIT, &cap[i++]);
+	dev->saved_cap_space[PCI_CAP_ID_MSI] = cap;
+	disable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+	return 0;
+}
+
+void pci_restore_msi_state(struct pci_dev *dev)
+{
+	int i = 0, pos;
+	u16 control;
+	u32 *cap = dev->saved_cap_space[PCI_CAP_ID_MSI];
+
+	if (!cap || (pos = pci_find_capability(dev, PCI_CAP_ID_MSI)) <= 0)
+		return;
+
+	control = cap[i++] >> 16;
+	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, cap[i++]);
+	if (control & PCI_MSI_FLAGS_64BIT) {
+		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, cap[i++]);
+		pci_write_config_dword(dev, pos + PCI_MSI_DATA_64, cap[i++]);
+	} else
+		pci_write_config_dword(dev, pos + PCI_MSI_DATA_32, cap[i++]);
+	if (control & PCI_MSI_FLAGS_MASKBIT)
+		pci_write_config_dword(dev, pos + PCI_MSI_MASK_BIT, cap[i++]);
+	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+	dev->saved_cap_space[PCI_CAP_ID_MSI] = NULL;
+	kfree(cap);
+}
+
+int pci_save_msix_state(struct pci_dev *dev)
+{
+	int pos;
+	u16 control;
+	u16 *save;
+
+	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) <= 0 ||
+		dev->no_msi)
+		return 0;
+
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	if (!(control & PCI_MSIX_FLAGS_ENABLE))
+		return 0;
+	save = kmalloc(sizeof(u16), GFP_KERNEL);
+	if (!save) {
+		printk(KERN_ERR "Out of memory in pci_save_msix_state\n");
+		return -ENOMEM;
+	}
+	*save = control;
+	dev->saved_cap_space[PCI_CAP_ID_MSIX] = save;
+	disable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+	return 0;
+}
+
+void pci_restore_msix_state(struct pci_dev *dev)
+{
+	u16 *control = dev->saved_cap_space[PCI_CAP_ID_MSIX];
+	u16 save;
+	int pos;
+	int vector, head, tail = 0;
+	void __iomem *base;
+	int j;
+	struct msg_address address;
+	struct msg_data data;
+	struct msi_desc *entry;
+	int temp;
+
+	if (control == NULL)
+		return;
+	save = *control;
+	dev->saved_cap_space[PCI_CAP_ID_MSIX] = NULL;
+	kfree(control);
+	if ((pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)) <= 0)
+		return;
+
+	/* route the table */
+	temp = dev->irq;
+	if (msi_lookup_vector(dev, PCI_CAP_ID_MSIX))
+		return;
+	vector = head = dev->irq;
+	while (head != tail) {
+		entry = msi_desc[vector];
+		base = entry->mask_base;
+		j = entry->msi_attrib.entry_nr;
+
+		msi_address_init(&address);
+		msi_data_init(&data, vector);
+
+		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
+		address.lo_address.value |= entry->msi_attrib.current_cpu <<
+					MSI_TARGET_CPU_SHIFT;
+
+		writel(address.lo_address.value,
+			base + j * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+		writel(address.hi_address,
+			base + j * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+		writel(*(u32*)&data,
+			base + j * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_DATA_OFFSET);
+
+		tail = msi_desc[vector]->link.tail;
+		vector = tail;
+	}
+	dev->irq = temp;
+
+	pci_write_config_word(dev, msi_control_reg(pos), save);
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+}
+
+static void msi_register_init(struct pci_dev *dev, struct msi_desc *entry)
+{
+	struct msg_address address;
+	struct msg_data data;
+	int pos, vector = dev->irq;
+	u16 control;
+
+   	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	/* Configure MSI capability structure */
+	msi_address_init(&address);
+	msi_data_init(&data, vector);
+	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
+				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
+	pci_write_config_dword(dev, msi_lower_address_reg(pos),
+			address.lo_address.value);
+	if (is_64bit_address(control)) {
+		pci_write_config_dword(dev,
+			msi_upper_address_reg(pos), address.hi_address);
+		pci_write_config_word(dev,
+			msi_data_reg(pos, 1), *((u32*)&data));
+	} else
+		pci_write_config_word(dev,
+			msi_data_reg(pos, 0), *((u32*)&data));
+	if (entry->msi_attrib.maskbit) {
+		unsigned int maskbits, temp;
+		/* All MSIs are unmasked by default, Mask them all */
+		pci_read_config_dword(dev,
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
+			&maskbits);
+		temp = (1 << multi_msi_capable(control));
+		temp = ((temp - 1) & ~temp);
+		maskbits |= temp;
+		pci_write_config_dword(dev,
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
+			maskbits);
+	}
+}
+
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -511,8 +690,6 @@ void pci_scan_msi_device(struct pci_dev 
 static int msi_capability_init(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
-	struct msg_address address;
-	struct msg_data data;
 	int pos, vector;
 	u16 control;
 
@@ -542,33 +719,8 @@ static int msi_capability_init(struct pc
 	/* Replace with MSI handler */
 	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
 	/* Configure MSI capability structure */
-	msi_address_init(&address);
-	msi_data_init(&data, vector);
-	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
-				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-	pci_write_config_dword(dev, msi_lower_address_reg(pos),
-			address.lo_address.value);
-	if (is_64bit_address(control)) {
-		pci_write_config_dword(dev,
-			msi_upper_address_reg(pos), address.hi_address);
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 1), *((u32*)&data));
-	} else
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 0), *((u32*)&data));
-	if (entry->msi_attrib.maskbit) {
-		unsigned int maskbits, temp;
-		/* All MSIs are unmasked by default, Mask them all */
-		pci_read_config_dword(dev,
-			msi_mask_bits_reg(pos, is_64bit_address(control)),
-			&maskbits);
-		temp = (1 << multi_msi_capable(control));
-		temp = ((temp - 1) & ~temp);
-		maskbits |= temp;
-		pci_write_config_dword(dev,
-			msi_mask_bits_reg(pos, is_64bit_address(control)),
-			maskbits);
-	}
+	msi_register_init(dev, entry);
+
 	attach_msi_entry(entry, vector);
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
@@ -717,6 +869,7 @@ int pci_enable_msi(struct pci_dev* dev)
 			vector_irq[dev->irq] = -1;
 			nr_released_vectors--;
 			spin_unlock_irqrestore(&msi_lock, flags);
+			msi_register_init(dev, msi_desc[dev->irq]);
 			enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 			return 0;
 		}
diff -puN drivers/pci/pci.c~msi_save_restore drivers/pci/pci.c
--- linux-2.6.15-rc5/drivers/pci/pci.c~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
+++ linux-2.6.15-rc5-root/drivers/pci/pci.c	2005-12-27 08:42:09.000000000 +0800
@@ -438,6 +438,10 @@ pci_save_state(struct pci_dev *dev)
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++)
 		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
+	if ((i = pci_save_msi_state(dev)) != 0)
+		return i;
+	if ((i = pci_save_msix_state(dev)) != 0)
+		return i;
 	return 0;
 }
 
@@ -452,6 +456,8 @@ pci_restore_state(struct pci_dev *dev)
 
 	for (i = 0; i < 16; i++)
 		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
+	pci_restore_msi_state(dev);
+	pci_restore_msix_state(dev);
 	return 0;
 }
 
diff -puN drivers/pci/pci.h~msi_save_restore drivers/pci/pci.h
--- linux-2.6.15-rc5/drivers/pci/pci.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
+++ linux-2.6.15-rc5-root/drivers/pci/pci.h	2005-12-27 08:42:36.000000000 +0800
@@ -55,8 +55,16 @@ extern int pci_msi_quirk;
 
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
+int pci_save_msi_state(struct pci_dev *dev);
+int pci_save_msix_state(struct pci_dev *dev);
+void pci_restore_msi_state(struct pci_dev *dev);
+void pci_restore_msix_state(struct pci_dev *dev);
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
+static inline void pci_save_msi_state(struct pci_dev *dev) {}
+static inline void pci_save_msix_state(struct pci_dev *dev) {}
+static inline void pci_restore_msi_state(struct pci_dev *dev) {}
+static inline void pci_restore_msix_state(struct pci_dev *dev) {}
 #endif
 
 extern int pcie_mch_quirk;
diff -puN include/linux/pci.h~msi_save_restore include/linux/pci.h
--- linux-2.6.15-rc5/include/linux/pci.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
+++ linux-2.6.15-rc5-root/include/linux/pci.h	2005-12-22 09:23:16.000000000 +0800
@@ -135,6 +135,7 @@ struct pci_dev {
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
+	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
diff -puN include/linux/pci_regs.h~msi_save_restore include/linux/pci_regs.h
--- linux-2.6.15-rc5/include/linux/pci_regs.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
+++ linux-2.6.15-rc5-root/include/linux/pci_regs.h	2005-12-22 09:23:16.000000000 +0800
@@ -199,6 +199,7 @@
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
 #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
+#define PCI_CAP_ID_MAX		PCI_CAP_ID_MSIX
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
 #define PCI_CAP_SIZEOF		4
_


