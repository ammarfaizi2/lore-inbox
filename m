Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbUKMDFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUKMDFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKMDE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:04:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262651AbUKMDCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:02:37 -0500
Date: Sat, 13 Nov 2004 04:02:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] PCI cleanups
Message-ID: <20041113030203.GU2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does some cleanups in the PCI code:
- make OSC_UUID in drivers/pci/pci-acpi.c static
- remove the completely unused drivers/pci/hotplug/pciehp_sysfs.c
- remove other unused code

Please review which of these changes are correct and which conflict with 
pending changes.


diffstat output:
 arch/arm/mach-ixp4xx/common-pci.c  |   10 
 arch/i386/pci/irq.c                |   29 --
 arch/ia64/pci/pci.c                |    8 
 drivers/pci/hotplug/Makefile       |    1 
 drivers/pci/hotplug/pciehp.h       |    3 
 drivers/pci/hotplug/pciehp_sysfs.c |  143 -------------
 drivers/pci/msi.c                  |  301 -----------------------------
 drivers/pci/msi.h                  |    1 
 drivers/pci/pci-acpi.c             |   97 ---------
 drivers/pci/pci.c                  |   60 -----
 drivers/pci/rom.c                  |   52 -----
 include/linux/pci-acpi.h           |    2 
 include/linux/pci.h                |   12 -
 13 files changed, 1 insertion(+), 718 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/pciehp.h.old	2004-11-13 01:40:34.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/pciehp.h	2004-11-13 01:40:42.000000000 +0100
@@ -207,9 +207,6 @@
 #define msg_button_cancel	"PCI slot #%d - action canceled due to button press.\n"
 #define msg_button_ignore	"PCI slot #%d - button press ignored.  (action in progress...)\n"
 
-/* sysfs function for the hotplug controller info */
-extern void pciehp_create_ctrl_files	(struct controller *ctrl);
-
 /* controller functions */
 extern int	pciehprm_find_available_resources	(struct controller *ctrl);
 extern int	pciehp_event_start_thread	(void);
--- linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/Makefile.old	2004-11-13 02:09:16.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/Makefile	2004-11-13 02:09:35.000000000 +0100
@@ -51,7 +51,6 @@
 pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
-				pciehp_sysfs.o	\
 				pciehp_hpc.o
 ifdef CONFIG_ACPI_BUS
 	pciehp-objs += pciehprm_acpi.o
--- linux-2.6.10-rc1-mm5-full/include/linux/pci.h.old	2004-11-13 01:42:21.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/pci.h	2004-11-13 01:52:37.000000000 +0100
@@ -732,7 +732,6 @@
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
-int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
@@ -783,15 +782,12 @@
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
-int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
 /* ROM control related routines */
 void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size);
-void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size);
 void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
-void pci_remove_rom(struct pci_dev *pdev);
 
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
@@ -855,17 +851,11 @@
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
 static inline void pci_disable_msi(struct pci_dev *dev) {}
-static inline int pci_enable_msix(struct pci_dev* dev,
-	struct msix_entry *entries, int nvec) {return -1;}
-static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
 #else
 extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
 extern void pci_disable_msi(struct pci_dev *dev);
-extern int pci_enable_msix(struct pci_dev* dev,
-	struct msix_entry *entries, int nvec);
-extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 #endif
 
@@ -913,12 +903,10 @@
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
-static inline int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
-static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 /* Power management related routines */
--- linux-2.6.10-rc1-mm5-full/drivers/pci/msi.h.old	2004-11-13 03:16:34.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/msi.h	2004-11-13 03:15:56.000000000 +0100
@@ -21,7 +21,6 @@
 extern int vector_irq[NR_VECTORS];
 extern cpumask_t pending_irq_balance_cpumask[NR_IRQS];
 extern void (*interrupt[NR_IRQS])(void);
-extern int pci_vector_resources(int last, int nr_released);
 
 #ifdef CONFIG_SMP
 #define set_msi_irq_affinity	set_msi_affinity
--- linux-2.6.10-rc1-mm5-full/drivers/pci/msi.c.old	2004-11-13 01:42:40.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/msi.c	2004-11-13 02:05:22.000000000 +0100
@@ -589,107 +589,6 @@
 }
 
 /**
- * msix_capability_init - configure device's MSI-X capability
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- *
- * Setup the MSI-X capability structure of device funtion with a
- * single MSI-X vector. A return of zero indicates the successful setup of
- * requested MSI-X entries with allocated vectors or non-zero for otherwise.
- **/
-static int msix_capability_init(struct pci_dev *dev,
-				struct msix_entry *entries, int nvec)
-{
-	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
-	struct msg_address address;
-	struct msg_data data;
-	int vector, pos, i, j, nr_entries, temp = 0;
-	u32 phys_addr, table_offset;
- 	u16 control;
-	u8 bir;
-	void __iomem *base;
-
-   	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	/* Request & Map MSI-X table region */
- 	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	nr_entries = multi_msix_capable(control);
- 	pci_read_config_dword(dev, msix_table_offset_reg(pos),
- 		&table_offset);
-	bir = (u8)(table_offset & PCI_MSIX_FLAGS_BIRMASK);
-	phys_addr = pci_resource_start (dev, bir);
-	phys_addr += (u32)(table_offset & ~PCI_MSIX_FLAGS_BIRMASK);
-	if (!request_mem_region(phys_addr,
-		nr_entries * PCI_MSIX_ENTRY_SIZE,
-		"MSI-X vector table"))
-		return -ENOMEM;
-	base = ioremap_nocache(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
-	if (base == NULL) {
-		release_mem_region(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
-		return -ENOMEM;
-	}
-	/* MSI-X Table Initialization */
-	for (i = 0; i < nvec; i++) {
-		entry = alloc_msi_entry();
-		if (!entry)
-			break;
-		if ((vector = get_msi_vector(dev)) < 0)
-			break;
-
- 		j = entries[i].entry;
- 		entries[i].vector = vector;
-		entry->msi_attrib.type = PCI_CAP_ID_MSIX;
- 		entry->msi_attrib.state = 0;		/* Mark it not active */
-		entry->msi_attrib.entry_nr = j;
-		entry->msi_attrib.maskbit = 1;
-		entry->msi_attrib.default_vector = dev->irq;
-		entry->dev = dev;
-		entry->mask_base = base;
-		if (!head) {
-			entry->link.head = vector;
-			entry->link.tail = vector;
-			head = entry;
-		} else {
-			entry->link.head = temp;
-			entry->link.tail = tail->link.tail;
-			tail->link.tail = vector;
-			head->link.head = vector;
-		}
-		temp = vector;
-		tail = entry;
-		/* Replace with MSI-X handler */
-		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
-		/* Configure MSI-X capability structure */
-		msi_address_init(&address);
-		msi_data_init(&data, vector);
-		entry->msi_attrib.current_cpu =
-			((address.lo_address.u.dest_id >>
-			MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-		writel(address.lo_address.value,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		writel(address.hi_address,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		writel(*(u32*)&data,
-			base + j * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_DATA_OFFSET);
-		attach_msi_entry(entry, vector);
-	}
-	if (i != nvec) {
-		i--;
-		for (; i >= 0; i--) {
-			vector = (entries + i)->vector;
-			msi_free_vector(dev, vector, 0);
-			(entries + i)->vector = 0;
-		}
-		return -EBUSY;
-	}
-	/* Set MSI-X enabled bits */
-	enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
-
-	return 0;
-}
-
-/**
  * pci_enable_msi - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  *
@@ -866,204 +765,6 @@
 	return 0;
 }
 
-static int reroute_msix_table(int head, struct msix_entry *entries, int *nvec)
-{
-	int vector = head, tail = 0;
-	int i, j = 0, nr_entries = 0;
-	void __iomem *base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&msi_lock, flags);
-	while (head != tail) {
-		nr_entries++;
-		tail = msi_desc[vector]->link.tail;
-		if (entries[0].entry == msi_desc[vector]->msi_attrib.entry_nr)
-			j = vector;
-		vector = tail;
-	}
-	if (*nvec > nr_entries) {
-		spin_unlock_irqrestore(&msi_lock, flags);
-		*nvec = nr_entries;
-		return -EINVAL;
-	}
-	vector = ((j > 0) ? j : head);
-	for (i = 0; i < *nvec; i++) {
-		j = msi_desc[vector]->msi_attrib.entry_nr;
-		msi_desc[vector]->msi_attrib.state = 0;	/* Mark it not active */
-		vector_irq[vector] = -1;		/* Mark it busy */
-		nr_released_vectors--;
-		entries[i].vector = vector;
-		if (j != (entries + i)->entry) {
-			base = msi_desc[vector]->mask_base;
-			msi_desc[vector]->msi_attrib.entry_nr =
-				(entries + i)->entry;
-			writel( readl(base + j * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET), base +
-				(entries + i)->entry * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-			writel(	readl(base + j * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET), base +
-				(entries + i)->entry * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-			writel( (readl(base + j * PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_DATA_OFFSET) & 0xff00) | vector,
-				base + (entries+i)->entry*PCI_MSIX_ENTRY_SIZE +
-				PCI_MSIX_ENTRY_DATA_OFFSET);
-		}
-		vector = msi_desc[vector]->link.tail;
-	}
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-	return 0;
-}
-
-/**
- * pci_enable_msix - configure device's MSI-X capability structure
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @data: pointer to an array of MSI-X entries
- * @nvec: number of MSI-X vectors requested for allocation by device driver
- *
- * Setup the MSI-X capability structure of device function with the number
- * of requested vectors upon its software driver call to request for
- * MSI-X mode enabled on its hardware device function. A return of zero
- * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X vectors. A return of < 0 indicates a failure.
- * Or a return of > 0 indicates that driver request is exceeding the number
- * of vectors available. Driver should use the returned value to re-send
- * its request.
- **/
-int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
-{
-	int status, pos, nr_entries, free_vectors;
-	int i, j, temp;
-	u16 control;
-	unsigned long flags;
-
-	if (!pci_msi_enable || !dev || !entries)
- 		return -EINVAL;
-
-	if ((status = msi_init()) < 0)
-		return status;
-
-   	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
- 		return -EINVAL;
-
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	if (control & PCI_MSIX_FLAGS_ENABLE)
-		return -EINVAL;			/* Already in MSI-X mode */
-
-	nr_entries = multi_msix_capable(control);
-	if (nvec > nr_entries)
-		return -EINVAL;
-
-	/* Check for any invalid entries */
-	for (i = 0; i < nvec; i++) {
-		if (entries[i].entry >= nr_entries)
-			return -EINVAL;		/* invalid entry */
-		for (j = i + 1; j < nvec; j++) {
-			if (entries[i].entry == entries[j].entry)
-				return -EINVAL;	/* duplicate entry */
-		}
-	}
-	temp = dev->irq;
-	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
-		/* Lookup Sucess */
-		nr_entries = nvec;
-		/* Reroute MSI-X table */
-		if (reroute_msix_table(dev->irq, entries, &nr_entries)) {
-			/* #requested > #previous-assigned */
-			dev->irq = temp;
-			return nr_entries;
-		}
-		dev->irq = temp;
-		enable_msi_mode(dev, pos, PCI_CAP_ID_MSIX);
-		return 0;
-	}
-	/* Check whether driver already requested for MSI vector */
-   	if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0 &&
-		!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
-		printk(KERN_INFO "Can't enable MSI-X. Device already had MSI vector assigned\n");
-		dev->irq = temp;
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&msi_lock, flags);
-	/*
-	 * msi_lock is provided to ensure that enough vectors resources are
-	 * available before granting.
-	 */
-	free_vectors = pci_vector_resources(last_alloc_vector,
-				nr_released_vectors);
-	/* Ensure that each MSI/MSI-X device has one vector reserved by
-	   default to avoid any MSI-X driver to take all available
- 	   resources */
-	free_vectors -= nr_reserved_vectors;
-	/* Find the average of free vectors among MSI-X devices */
-	if (nr_msix_devices > 0)
-		free_vectors /= nr_msix_devices;
-	spin_unlock_irqrestore(&msi_lock, flags);
-
-	if (nvec > free_vectors) {
-		if (free_vectors > 0)
-			return free_vectors;
-		else
-			return -EBUSY;
-	}
-
-	status = msix_capability_init(dev, entries, nvec);
-	if (!status && nr_msix_devices > 0)
-		nr_msix_devices--;
-
-	return status;
-}
-
-void pci_disable_msix(struct pci_dev* dev)
-{
-	int pos, temp;
-	u16 control;
-
-   	if (!dev || !(pos = pci_find_capability(dev, PCI_CAP_ID_MSIX)))
-		return;
-
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	if (!(control & PCI_MSIX_FLAGS_ENABLE))
-		return;
-
-	temp = dev->irq;
-	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
-		int state, vector, head, tail = 0, warning = 0;
-		unsigned long flags;
-
-		vector = head = dev->irq;
-		spin_lock_irqsave(&msi_lock, flags);
-		while (head != tail) {
-			state = msi_desc[vector]->msi_attrib.state;
-			if (state)
-				warning = 1;
-			else {
-				vector_irq[vector] = 0; /* free it */
-				nr_released_vectors++;
-			}
-			tail = msi_desc[vector]->link.tail;
-			vector = tail;
-		}
-		spin_unlock_irqrestore(&msi_lock, flags);
-		if (warning) {
-			dev->irq = temp;
-			printk(KERN_DEBUG "Driver[%d:%d:%d] unloaded wo doing free_irq on all vectors\n",
-			dev->bus->number, PCI_SLOT(dev->devfn),
-			PCI_FUNC(dev->devfn));
-			BUG_ON(warning > 0);
-		} else {
-			dev->irq = temp;
-			disable_msi_mode(dev,
-				pci_find_capability(dev, PCI_CAP_ID_MSIX),
-				PCI_CAP_ID_MSIX);
-
-		}
-	}
-}
-
 /**
  * msi_remove_pci_irq_vectors - reclaim MSI(X) vectors to unused state
  * @dev: pointer to the pci_dev data structure of MSI(X) device function
@@ -1143,5 +844,3 @@
 
 EXPORT_SYMBOL(pci_enable_msi);
 EXPORT_SYMBOL(pci_disable_msi);
-EXPORT_SYMBOL(pci_enable_msix);
-EXPORT_SYMBOL(pci_disable_msix);
--- linux-2.6.10-rc1-mm5-full/arch/i386/pci/irq.c.old	2004-11-13 03:16:59.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/arch/i386/pci/irq.c	2004-11-13 03:17:11.000000000 +0100
@@ -1085,32 +1085,3 @@
 	return 0;
 }
 
-int pci_vector_resources(int last, int nr_released)
-{
-	int count = nr_released;
-
-	int next = last;
-	int offset = (last % 8);
-
-	while (next < FIRST_SYSTEM_VECTOR) {
-		next += 8;
-#ifdef CONFIG_X86_64
-		if (next == IA32_SYSCALL_VECTOR)
-			continue;
-#else
-		if (next == SYSCALL_VECTOR)
-			continue;
-#endif
-		count++;
-		if (next >= FIRST_SYSTEM_VECTOR) {
-			if (offset%8) {
-				next = FIRST_DEVICE_VECTOR + offset;
-				offset++;
-				continue;
-			}
-			count--;
-		}
-	}
-
-	return count;
-}
--- linux-2.6.10-rc1-mm5-full/arch/ia64/pci/pci.c.old	2004-11-13 03:17:19.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/arch/ia64/pci/pci.c	2004-11-13 03:17:26.000000000 +0100
@@ -605,11 +605,3 @@
 	return rc;
 }
 
-int pci_vector_resources(int last, int nr_released)
-{
-	int count = nr_released;
-
- 	count += (IA64_LAST_DEVICE_VECTOR - last);
-
-	return count;
-}
--- linux-2.6.10-rc1-mm5-full/include/linux/pci-acpi.h.old	2004-11-13 01:45:33.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/pci-acpi.h	2004-11-13 01:45:43.000000000 +0100
@@ -48,14 +48,12 @@
 
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(u32 flags);
-extern acpi_status pci_osc_support_set(u32 flags);
 #else
 #if !defined(acpi_status)
 typedef u32 		acpi_status;
 #define AE_ERROR      	(acpi_status) (0x0001)
 #endif    
 static inline acpi_status pci_osc_control_set(u32 flags) {return AE_ERROR;}
-static inline acpi_status pci_osc_support_set(u32 flags) {return AE_ERROR;} 
 #endif
 
 #endif	/* _PCI_ACPI_H_ */
--- linux-2.6.10-rc1-mm5-full/drivers/pci/pci-acpi.c.old	2004-11-13 01:44:42.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/pci-acpi.c	2004-11-13 02:05:44.000000000 +0100
@@ -19,72 +19,7 @@
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
-u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
-
-static acpi_status  
-acpi_query_osc (
-	acpi_handle	handle,
-	u32		level,
-	void		*context,
-	void		**retval )
-{
-	acpi_status		status;
-	struct acpi_object_list	input;
-	union acpi_object 	in_params[4];
-	struct acpi_buffer	output;
-	union acpi_object 	out_obj;	
-	u32			osc_dw0;
-
-	/* Setting up output buffer */
-	output.length = sizeof(out_obj) + 3*sizeof(u32);  
-	output.pointer = &out_obj;
-	
-	/* Setting up input parameters */
-	input.count = 4;
-	input.pointer = in_params;
-	in_params[0].type 		= ACPI_TYPE_BUFFER;
-	in_params[0].buffer.length 	= 16;
-	in_params[0].buffer.pointer	= OSC_UUID;
-	in_params[1].type 		= ACPI_TYPE_INTEGER;
-	in_params[1].integer.value 	= 1;
-	in_params[2].type 		= ACPI_TYPE_INTEGER;
-	in_params[2].integer.value	= 3;
-	in_params[3].type		= ACPI_TYPE_BUFFER;
-	in_params[3].buffer.length 	= 12;
-	in_params[3].buffer.pointer 	= (u8 *)context;
-
-	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE (status)) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC Set fails. Status = 0x%04x\n", status);
-		return status;
-	}
-	if (out_obj.type != ACPI_TYPE_BUFFER) {
-		printk(KERN_DEBUG  
-			"Evaluate _OSC returns wrong type\n");
-		return AE_TYPE;
-	}
-	osc_dw0 = *((u32 *) out_obj.buffer.pointer);
-	if (osc_dw0) {
-		if (osc_dw0 & OSC_REQUEST_ERROR)
-			printk(KERN_DEBUG "_OSC request fails\n"); 
-		if (osc_dw0 & OSC_INVALID_UUID_ERROR)
-			printk(KERN_DEBUG "_OSC invalid UUID\n"); 
-		if (osc_dw0 & OSC_INVALID_REVISION_ERROR)
-			printk(KERN_DEBUG "_OSC invalid revision\n"); 
-		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
-			/* Update Global Control Set */
-			global_ctrlsets = *((u32 *)(out_obj.buffer.pointer+8));
-			return AE_OK;
-		}
-		return AE_ERROR;
-	}
-
-	/* Update Global Control Set */
-	global_ctrlsets = *((u32 *)(out_obj.buffer.pointer + 8));
-	return AE_OK;
-}
-
+static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status  
 acpi_run_osc (
@@ -147,36 +82,6 @@
 }
 
 /**
- * pci_osc_support_set - register OS support to Firmware
- * @flags: OS support bits
- *
- * Update OS support fields and doing a _OSC Query to obtain an update
- * from Firmware on supported control bits.
- **/
-acpi_status pci_osc_support_set(u32 flags)
-{
-	u32 temp;
-
-	if (!(flags & OSC_SUPPORT_MASKS)) {
-		return AE_TYPE;
-	}
-	ctrlset_buf[OSC_SUPPORT_TYPE] |= (flags & OSC_SUPPORT_MASKS);
-
-	/* do _OSC query for all possible controls */
-	temp = ctrlset_buf[OSC_CONTROL_TYPE];
-	ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
-	acpi_get_devices ( PCI_ROOT_HID_STRING,
-			acpi_query_osc,
-			ctrlset_buf,
-			NULL );
-	ctrlset_buf[OSC_QUERY_TYPE] = !OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] = temp;
-	return AE_OK;
-}
-EXPORT_SYMBOL(pci_osc_support_set);
-
-/**
  * pci_osc_control_set - commit requested control to Firmware
  * @flags: driver's requested control bits
  *
--- linux-2.6.10-rc1-mm5-full/drivers/pci/pci.c.old	2004-11-13 01:47:43.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/pci.c	2004-11-13 01:49:04.000000000 +0100
@@ -147,54 +147,6 @@
 }
 
 /**
- * pci_find_ext_capability - Find an extended capability
- * @dev: PCI device to query
- * @cap: capability code
- *
- * Returns the address of the requested extended capability structure
- * within the device's PCI configuration space or 0 if the device does
- * not support it.  Possible values for @cap:
- *
- *  %PCI_EXT_CAP_ID_ERR		Advanced Error Reporting
- *  %PCI_EXT_CAP_ID_VC		Virtual Channel
- *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
- *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
- */
-int pci_find_ext_capability(struct pci_dev *dev, int cap)
-{
-	u32 header;
-	int ttl = 480; /* 3840 bytes, minimum 8 bytes per capability */
-	int pos = 0x100;
-
-	if (dev->cfg_size <= 256)
-		return 0;
-
-	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-		return 0;
-
-	/*
-	 * If we have no capabilities, this is indicated by cap ID,
-	 * cap version and next pointer all being 0.
-	 */
-	if (header == 0)
-		return 0;
-
-	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (pos < 0x100)
-			break;
-
-		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
-			break;
-	}
-
-	return 0;
-}
-
-/**
  * pci_find_parent_resource - return resource region of parent bus of given region
  * @dev: PCI device structure contains resources to be searched
  * @res: child resource record for which parent is sought
@@ -718,17 +670,6 @@
 }
     
 int
-pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (!pci_dac_dma_supported(dev, mask))
-		return -EIO;
-
-	dev->dma_mask = mask;
-
-	return 0;
-}
-
-int
 pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	if (!pci_dma_supported(dev, mask))
@@ -790,7 +731,6 @@
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
--- linux-2.6.10-rc1-mm5-full/arch/arm/mach-ixp4xx/common-pci.c.old	2004-11-13 01:48:00.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/arch/arm/mach-ixp4xx/common-pci.c	2004-11-13 01:48:11.000000000 +0100
@@ -519,15 +519,6 @@
 }
     
 int
-pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (mask >= SZ_64M - 1 )
-		return 0;
-
-	return -EIO;
-}
-
-int
 pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	if (mask >= SZ_64M - 1 )
@@ -537,7 +528,6 @@
 }
 
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
--- linux-2.6.10-rc1-mm5-full/drivers/pci/rom.c.old	2004-11-13 01:51:35.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/rom.c	2004-11-13 01:52:44.000000000 +0100
@@ -130,40 +130,6 @@
 }
 
 /**
- * pci_map_rom_copy - map a PCI ROM to kernel space, create a copy
- * @dev: pointer to pci device struct
- * @size: pointer to receive size of pci window over ROM
- * @return: kernel virtual pointer to image of ROM
- *
- * Map a PCI ROM into kernel space. If ROM is boot video ROM,
- * the shadow BIOS copy will be returned instead of the 
- * actual ROM.
- */
-void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size)
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-	void __iomem *rom;
-	
-	rom = pci_map_rom(pdev, size);
-	if (!rom)
-		return NULL;
-		
-	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_SHADOW))
-		return rom;
-		
-	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);
-	if (!res->start) 
-		return rom;
-
-	res->end = res->start + *size; 
-	memcpy_fromio((void*)res->start, rom, *size);
-	pci_unmap_rom(pdev, rom);
-	res->flags |= IORESOURCE_ROM_COPY;
-	
-	return (void __iomem *)res->start;
-}
-
-/**
  * pci_unmap_rom - unmap the ROM from kernel space
  * @dev: pointer to pci device struct
  * @rom: virtual address of the previous mapping
@@ -186,22 +152,6 @@
 }
 
 /**
- * pci_remove_rom - disable the ROM and remove its sysfs attribute
- * @dev: pointer to pci device struct
- *
- */
-void 
-pci_remove_rom(struct pci_dev *pdev) 
-{
-	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
-	
-	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
-		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
-	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW | IORESOURCE_ROM_COPY)))
-		pci_disable_rom(pdev);
-}
-
-/**
  * pci_cleanup_rom - internal routine for freeing the ROM copy created 
  * by pci_map_rom_copy called from remove.c
  * @dev: pointer to pci device struct
@@ -220,6 +170,4 @@
 }
 
 EXPORT_SYMBOL(pci_map_rom);
-EXPORT_SYMBOL(pci_map_rom_copy);
 EXPORT_SYMBOL(pci_unmap_rom);
-EXPORT_SYMBOL(pci_remove_rom);
--- linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/pciehp_sysfs.c	2004-11-13 02:08:54.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,143 +0,0 @@
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <greg@kroah.com>
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/workqueue.h>
-#include <linux/pci.h>
-#include "pciehp.h"
-
-
-/* A few routines that create sysfs entries for the hot plug controller */
-
-static ssize_t show_ctrl (struct device *dev, char *buf)
-{
-	struct pci_dev *pci_dev;
-	struct controller *ctrl;
-	char * out = buf;
-	int index;
-	struct pci_resource *res;
-
-	pci_dev = container_of (dev, struct pci_dev, dev);
-	ctrl = pci_get_drvdata(pci_dev);
-
-	out += sprintf(buf, "Free resources: memory\n");
-	index = 11;
-	res = ctrl->mem_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: prefetchable memory\n");
-	index = 11;
-	res = ctrl->p_mem_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: IO\n");
-	index = 11;
-	res = ctrl->io_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: bus numbers\n");
-	index = 11;
-	res = ctrl->bus_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
-
-static ssize_t show_dev (struct device *dev, char *buf)
-{
-	struct pci_dev *pci_dev;
-	struct controller *ctrl;
-	char * out = buf;
-	int index;
-	struct pci_resource *res;
-	struct pci_func *new_slot;
-	struct slot *slot;
-
-	pci_dev = container_of (dev, struct pci_dev, dev);
-	ctrl = pci_get_drvdata(pci_dev);
-
-	slot=ctrl->slot;
-
-	while (slot) {
-		new_slot = pciehp_slot_find(slot->bus, slot->device, 0);
-		if (!new_slot)
-			break;
-		out += sprintf(out, "assigned resources: memory\n");
-		index = 11;
-		res = new_slot->mem_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: prefetchable memory\n");
-		index = 11;
-		res = new_slot->p_mem_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: IO\n");
-		index = 11;
-		res = new_slot->io_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: bus numbers\n");
-		index = 11;
-		res = new_slot->bus_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		slot=slot->next;
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR (dev, S_IRUGO, show_dev, NULL);
-
-void pciehp_create_ctrl_files (struct controller *ctrl)
-{
-	device_create_file (&ctrl->pci_dev->dev, &dev_attr_ctrl);
-	device_create_file (&ctrl->pci_dev->dev, &dev_attr_dev);
-}

