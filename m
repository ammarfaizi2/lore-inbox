Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWBVIOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWBVIOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWBVIOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:14:44 -0500
Received: from fmr18.intel.com ([134.134.136.17]:6018 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932300AbWBVIOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:14:43 -0500
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060221052458.GA30022@kroah.com>
References: <1139389898.14976.11.camel@sli10-desk.sh.intel.com>
	 <20060221052458.GA30022@kroah.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 16:13:55 +0800
Message-Id: <1140596035.6056.16.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 13:24 +0800, Greg KH wrote:
> On Wed, Feb 08, 2006 at 05:11:38PM +0800, Shaohua Li wrote:
> > It appears the two patches are lost since I updated them per Matthew
> > Wilcox's comments. Resent them.
> >
> > Add MSI(X) configure sapce save/restore in generic PCI helper.
> 
> This patch conflicts with msi patches in the -mm tree today.  Can you
> redo it against the latest -mm tree?
Ok, this is the patch against latest -mm.

Add MSI(X) configure space save/restore in generic PCI helper.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.16-rc4-mm1-root/drivers/pci/msi.c   |  261 ++++++++++++++++++++++----
 linux-2.6.16-rc4-mm1-root/drivers/pci/pci.c   |    9 
 linux-2.6.16-rc4-mm1-root/drivers/pci/pci.h   |   12 +
 linux-2.6.16-rc4-mm1-root/include/linux/pci.h |   31 +++
 4 files changed, 282 insertions(+), 31 deletions(-)

diff -puN include/linux/pci.h~msi_save_restore include/linux/pci.h
--- linux-2.6.16-rc4-mm1/include/linux/pci.h~msi_save_restore	2006-02-21 10:58:21.000000000 +0800
+++ linux-2.6.16-rc4-mm1-root/include/linux/pci.h	2006-02-21 11:00:36.000000000 +0800
@@ -95,6 +95,12 @@ enum pci_channel_state {
 	pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
 };
 
+struct pci_cap_saved_state {
+	struct hlist_node next;
+	char cap_nr;
+	u32 data[0];
+};
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -154,6 +160,7 @@ struct pci_dev {
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
+	struct hlist_head saved_cap_space;
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
@@ -164,6 +171,30 @@ struct pci_dev {
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
diff -puN drivers/pci/pci.h~msi_save_restore drivers/pci/pci.h
--- linux-2.6.16-rc4-mm1/drivers/pci/pci.h~msi_save_restore	2006-02-21 11:00:53.000000000 +0800
+++ linux-2.6.16-rc4-mm1-root/drivers/pci/pci.h	2006-02-21 12:47:20.000000000 +0800
@@ -57,6 +57,18 @@ static inline void disable_msi_mode(stru
 static inline int msi_register(struct msi_ops *ops) { return 0; }
 #endif
 
+#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PM)
+int pci_save_msi_state(struct pci_dev *dev);
+int pci_save_msix_state(struct pci_dev *dev);
+int pci_restore_msi_state(struct pci_dev *dev);
+int pci_restore_msix_state(struct pci_dev *dev);
+#else
+static inline int pci_save_msi_state(struct pci_dev *dev) { return 0; }
+static inline int pci_save_msix_state(struct pci_dev *dev) { return 0; }
+static inline int pci_restore_msi_state(struct pci_dev *dev) { return 0; }
+static inline int pci_restore_msix_state(struct pci_dev *dev) { return 0; }
+#endif
+
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;
diff -puN drivers/pci/pci.c~msi_save_restore drivers/pci/pci.c
--- linux-2.6.16-rc4-mm1/drivers/pci/pci.c~msi_save_restore	2006-02-21 11:02:08.000000000 +0800
+++ linux-2.6.16-rc4-mm1-root/drivers/pci/pci.c	2006-02-21 12:49:15.000000000 +0800
@@ -453,6 +453,11 @@ pci_save_state(struct pci_dev *dev)
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++)
 		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
+	if ((i = pci_save_msi_state(dev)) != 0)
+		return i;
+	if ((i = pci_save_msix_state(dev)) != 0)
+		return i;
+
 	return 0;
 }
 
@@ -467,6 +472,10 @@ pci_restore_state(struct pci_dev *dev)
 
 	for (i = 0; i < 16; i++)
 		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
+	if ((i = pci_restore_msi_state(dev)) != 0)
+		return i;
+	if ((i = pci_restore_msix_state(dev)) != 0)
+		return i;
 	return 0;
 }
 
diff -puN drivers/pci/msi.c~msi_save_restore drivers/pci/msi.c
--- linux-2.6.16-rc4-mm1/drivers/pci/msi.c~msi_save_restore	2006-02-21 11:45:28.000000000 +0800
+++ linux-2.6.16-rc4-mm1-root/drivers/pci/msi.c	2006-02-21 14:13:44.000000000 +0800
@@ -514,6 +514,221 @@ void pci_scan_msi_device(struct pci_dev 
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
+	if (!pci_msi_enable || dev->no_msi)
+		return 0;
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (pos)
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
+int pci_restore_msi_state(struct pci_dev *dev)
+{
+	int i = 0, pos;
+	u16 control;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_MSI);
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!save_state || pos <= 0)
+		return 0;
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
+	return 0;
+}
+
+int pci_save_msix_state(struct pci_dev *dev)
+{
+	int pos;
+	u16 control;
+	struct pci_cap_saved_state *save_state;
+
+	if (!pci_msi_enable || dev->no_msi)
+		return 0;
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (pos <= 0)
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
+int pci_restore_msix_state(struct pci_dev *dev)
+{
+	u16 save;
+	int pos;
+	int vector, head, tail = 0;
+	void __iomem *base;
+	int j;
+	u32 address_hi;
+	u32 address_lo;
+	u32 data;
+	struct msi_desc *entry;
+	int temp;
+	struct pci_cap_saved_state *save_state;
+	int status = 0;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_MSIX);
+	if (!save_state)
+		return 0;
+	save = *((u16 *)&save_state->data[0]);
+	pci_remove_saved_cap(save_state);
+	kfree(save_state);
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (pos <= 0)
+		return 0;
+
+	/* route the table */
+	temp = dev->irq;
+	if (msi_lookup_vector(dev, PCI_CAP_ID_MSIX))
+		return -EINVAL;
+	vector = head = dev->irq;
+	while (head != tail) {
+		entry = msi_desc[vector];
+		base = entry->mask_base;
+		j = entry->msi_attrib.entry_nr;
+
+		/* Configure MSI-X capability structure */
+		status = msi_ops->setup(dev, vector,
+					&address_hi,
+					&address_lo,
+					&data);
+		if (status < 0)
+			break;
+
+		writel(address_lo,
+			base + j * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
+		writel(address_hi,
+			base + j * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
+		writel(data,
+			base + j * PCI_MSIX_ENTRY_SIZE +
+			PCI_MSIX_ENTRY_DATA_OFFSET);
+
+		tail = msi_desc[vector]->link.tail;
+		vector = tail;
+	}
+	dev->irq = temp;
+
+	if (status) {
+		printk(KERN_ERR "PCI %s: restore MSI-X configs failed\n", pci_name(dev));
+		return status;
+	}
+
+	pci_write_config_word(dev, msi_control_reg(pos), save);
+	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
+	return 0;
+}
+#endif
+
+static int msi_register_init(struct pci_dev *dev, struct msi_desc *entry)
+{
+	u32 address_lo;
+	u32 address_hi;
+	u32 data;
+	int pos, vector = dev->irq;
+	u16 control;
+	int status;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	pci_read_config_word(dev, msi_control_reg(pos), &control);
+
+	/* Configure MSI capability structure */
+	status = msi_ops->setup(dev, vector,
+				&address_hi,
+				&address_lo,
+				&data);
+	if (status < 0)
+		return status;
+
+	pci_write_config_dword(dev, msi_lower_address_reg(pos), address_lo);
+	if (is_64bit_address(control)) {
+		pci_write_config_dword(dev,
+			msi_upper_address_reg(pos), address_hi);
+		pci_write_config_word(dev, msi_data_reg(pos, 1), data);
+	} else
+		pci_write_config_word(dev, msi_data_reg(pos, 0), data);
+
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
+
+	return 0;
+}
+
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -527,9 +742,6 @@ static int msi_capability_init(struct pc
 {
 	int status;
 	struct msi_desc *entry;
-	u32 address_lo;
-	u32 address_hi;
-	u32 data;
 	int pos, vector;
 	u16 control;
 
@@ -558,11 +770,8 @@ static int msi_capability_init(struct pc
 		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
-	/* Configure MSI capability structure */
-	status = msi_ops->setup(dev, vector,
-				&address_hi,
-				&address_lo,
-				&data);
+
+	status = msi_register_init(dev, entry);
 	if (status < 0) {
 		dev->irq = entry->msi_attrib.default_vector;
 		kmem_cache_free(msi_cachep, entry);
@@ -571,27 +780,6 @@ static int msi_capability_init(struct pc
 	/* Replace with MSI handler */
 	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
 
-	pci_write_config_dword(dev, msi_lower_address_reg(pos), address_lo);
-	if (is_64bit_address(control)) {
-		pci_write_config_dword(dev,
-			msi_upper_address_reg(pos), address_hi);
-		pci_write_config_word(dev, msi_data_reg(pos, 1), data);
-	} else
-		pci_write_config_word(dev, msi_data_reg(pos, 0), data);
-
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
 	attach_msi_entry(entry, vector);
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
@@ -747,8 +935,19 @@ int pci_enable_msi(struct pci_dev* dev)
 			vector_irq[dev->irq] = -1;
 			nr_released_vectors--;
 			spin_unlock_irqrestore(&msi_lock, flags);
-			enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
-			return 0;
+			status = msi_register_init(dev, msi_desc[dev->irq]);
+			if (status == 0) {
+				enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
+				return 0;
+			}
+			/* Reroute failed, free the vector */
+			spin_lock_irqsave(&msi_lock, flags);
+			vector_irq[dev->irq] = 0; /* free it */
+			nr_released_vectors++;
+			spin_unlock_irqrestore(&msi_lock, flags);
+			/* Restore dev->irq to its default pin-assertion vector */
+			dev->irq = temp;
+			return status;
 		}
 		spin_unlock_irqrestore(&msi_lock, flags);
 		dev->irq = temp;
_



