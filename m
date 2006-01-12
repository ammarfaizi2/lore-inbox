Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWALDSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWALDSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWALDSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:18:36 -0500
Received: from fmr17.intel.com ([134.134.136.16]:54740 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965007AbWALDSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:18:35 -0500
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
In-Reply-To: <20060112024732.GE19769@parisc-linux.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
	 <20060103231304.56e3228b.akpm@osdl.org>
	 <1136422680.30655.1.camel@sli10-desk.sh.intel.com>
	 <20060110202841.GZ19769@parisc-linux.org>
	 <1136942240.5750.35.camel@sli10-desk.sh.intel.com>
	 <20060111012625.GA29108@kroah.com>
	 <1136967502.5750.65.camel@sli10-desk.sh.intel.com>
	 <20060111155142.GA19828@kroah.com>
	 <1137033060.5750.68.camel@sli10-desk.sh.intel.com>
	 <20060112024732.GE19769@parisc-linux.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 11:17:51 +0800
Message-Id: <1137035871.5750.80.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 19:47 -0700, Matthew Wilcox wrote:
> On Thu, Jan 12, 2006 at 10:30:59AM +0800, Shaohua Li wrote:
> 
> Did you not understand my comment about using the hlist functions?
> 
> > +struct pci_cap_saved_state {
> > +	struct list_head next;
> 
> struct hlist_node list;

Add MSI(X) configure space save/restore in generic PCI helper.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.15-rc5-root/drivers/pci/msi.c   |  227 ++++++++++++++++++++++++++----
 linux-2.6.15-rc5-root/drivers/pci/pci.c   |    6 
 linux-2.6.15-rc5-root/drivers/pci/pci.h   |   11 +
 linux-2.6.15-rc5-root/include/linux/pci.h |   31 ++++
 5 files changed, 246 insertions(+), 29 deletions(-)

diff -puN drivers/pci/msi.c~msi_save_restore drivers/pci/msi.c
--- linux-2.6.15-rc5/drivers/pci/msi.c~msi_save_restore	2006-01-11 13:33:33.000000000 +0800
+++ linux-2.6.15-rc5-root/drivers/pci/msi.c	2006-01-12 10:13:41.000000000 +0800
@@ -499,6 +499,201 @@ void pci_scan_msi_device(struct pci_dev 
 		nr_reserved_vectors++;
 }
 
+#ifdef CONFIG_PM
+int pci_save_msi_state(struct pci_dev *dev)
+{
+	int pos, i = 0;
+	u16 control;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (pos <= 0 || dev->no_msi)
+		return 0;
+
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	if (!(control & PCI_MSI_FLAGS_ENABLE))
+		return 0;
+
+	save_state = kzalloc(sizeof(struct pci_cap_saved_state) + sizeof(u32) * 5,
+		GFP_KERNEL);
+	if (!save_state) {
+		printk(KERN_ERR "Out of memory in pci_save_msi_state\n");
+		return -ENOMEM;
+	}
+	cap = &save_state->data[0];
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
+	disable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+	save_state->cap_nr = PCI_CAP_ID_MSI;
+	pci_add_saved_cap(dev, save_state);
+	return 0;
+}
+
+void pci_restore_msi_state(struct pci_dev *dev)
+{
+	int i = 0, pos;
+	u16 control;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_MSI);
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!save_state || pos <= 0)
+		return;
+	cap = &save_state->data[0];
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
+	pci_remove_saved_cap(save_state);
+	kfree(save_state);
+}
+
+int pci_save_msix_state(struct pci_dev *dev)
+{
+	int pos;
+	u16 control;
+	struct pci_cap_saved_state *save_state;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (pos <= 0 || dev->no_msi)
+		return 0;
+
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+	if (!(control & PCI_MSIX_FLAGS_ENABLE))
+		return 0;
+	save_state = kzalloc(sizeof(struct pci_cap_saved_state) + sizeof(u16),
+		GFP_KERNEL);
+	if (!save_state) {
+		printk(KERN_ERR "Out of memory in pci_save_msix_state\n");
+		return -ENOMEM;
+	}
+	*((u16 *)&save_state->data[0]) = control;
+
+	disable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+	save_state->cap_nr = PCI_CAP_ID_MSIX;
+	pci_add_saved_cap(dev, save_state);
+	return 0;
+}
+
+void pci_restore_msix_state(struct pci_dev *dev)
+{
+	u16 save;
+	int pos;
+	int vector, head, tail = 0;
+	void __iomem *base;
+	int j;
+	struct msg_address address;
+	struct msg_data data;
+	struct msi_desc *entry;
+	int temp;
+	struct pci_cap_saved_state *save_state;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_MSIX);
+	if (!save_state)
+		return;
+	save = *((u16 *)&save_state->data[0]);
+	pci_remove_saved_cap(save_state);
+	kfree(save_state);
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (pos <= 0)
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
+#endif
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
@@ -511,8 +706,6 @@ void pci_scan_msi_device(struct pci_dev 
 static int msi_capability_init(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
-	struct msg_address address;
-	struct msg_data data;
 	int pos, vector;
 	u16 control;
 
@@ -542,33 +735,8 @@ static int msi_capability_init(struct pc
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
@@ -717,6 +885,7 @@ int pci_enable_msi(struct pci_dev* dev)
 			vector_irq[dev->irq] = -1;
 			nr_released_vectors--;
 			spin_unlock_irqrestore(&msi_lock, flags);
+			msi_register_init(dev, msi_desc[dev->irq]);
 			enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 			return 0;
 		}
diff -puN drivers/pci/pci.c~msi_save_restore drivers/pci/pci.c
--- linux-2.6.15-rc5/drivers/pci/pci.c~msi_save_restore	2006-01-11 13:33:33.000000000 +0800
+++ linux-2.6.15-rc5-root/drivers/pci/pci.c	2006-01-11 13:33:33.000000000 +0800
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
--- linux-2.6.15-rc5/drivers/pci/pci.h~msi_save_restore	2006-01-11 13:33:33.000000000 +0800
+++ linux-2.6.15-rc5-root/drivers/pci/pci.h	2006-01-12 10:24:48.000000000 +0800
@@ -58,6 +58,17 @@ void disable_msi_mode(struct pci_dev *de
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
 #endif
+#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PM)
+int pci_save_msi_state(struct pci_dev *dev);
+int pci_save_msix_state(struct pci_dev *dev);
+void pci_restore_msi_state(struct pci_dev *dev);
+void pci_restore_msix_state(struct pci_dev *dev);
+#else
+static inline int pci_save_msi_state(struct pci_dev *dev) { return 0; }
+static inline int pci_save_msix_state(struct pci_dev *dev) { return 0; }
+static inline void pci_restore_msi_state(struct pci_dev *dev) {}
+static inline void pci_restore_msix_state(struct pci_dev *dev) {}
+#endif
 
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
diff -puN include/linux/pci.h~msi_save_restore include/linux/pci.h
--- linux-2.6.15-rc5/include/linux/pci.h~msi_save_restore	2006-01-11 13:33:33.000000000 +0800
+++ linux-2.6.15-rc5-root/include/linux/pci.h	2006-01-12 11:01:39.000000000 +0800
@@ -78,6 +78,12 @@ typedef int __bitwise pci_power_t;
 #define PCI_UNKNOWN	((pci_power_t __force) 5)
 #define PCI_POWER_ERROR	((pci_power_t __force) -1)
 
+struct pci_cap_saved_state {
+	struct hlist_node next;
+	char cap_nr;
+	u32 data[0];
+};
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -135,6 +141,7 @@ struct pci_dev {
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
+	struct hlist_head saved_cap_space;
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
@@ -145,6 +152,30 @@ struct pci_dev {
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
+static inline struct pci_cap_saved_state *pci_find_saved_cap(
+	struct pci_dev *pci_dev,char cap)
+{
+	struct pci_cap_saved_state *tmp;
+	struct hlist_node *pos;
+
+	hlist_for_each_entry(tmp, pos, &pci_dev->saved_cap_space, next) {
+		if (tmp->cap_nr == cap)
+			return tmp;
+	}
+	return NULL;
+}
+
+static inline void pci_add_saved_cap(struct pci_dev *pci_dev,
+	struct pci_cap_saved_state *new_cap)
+{
+	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
+}
+
+static inline void pci_remove_saved_cap(struct pci_cap_saved_state *cap)
+{
+	hlist_del(&cap->next);
+}
+
 /*
  *  For PCI devices, the region numbers are assigned this way:
  *
_


