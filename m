Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbULNTls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbULNTls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbULNTlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:41:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25073 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261631AbULNTlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:41:05 -0500
Message-Id: <200412141941.iBEJf129020290@d03av04.boulder.ibm.com>
Subject: [PATCH 1/1] pci: Block config access during BIST (resend)
To: greg@kroah.com
Cc: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       brking@us.ibm.com
From: brking@us.ibm.com
Date: Tue, 14 Dec 2004 13:41:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some PCI adapters (eg. ipr scsi adapters) have an exposure today in that 
they issue BIST to the adapter to reset the card. If, during the time
it takes to complete BIST, userspace attempts to access PCI config space, 
the host bus bridge will master abort the access since the ipr adapter 
does not respond on the PCI bus for a brief period of time when running BIST. 
On PPC64 hardware, this master abort results in the host PCI bridge
isolating that PCI device from the rest of the system, making the device
unusable until Linux is rebooted. This patch is an attempt to close that
exposure by introducing some blocking code in the PCI code. When blocked,
writes will be humored and reads will return the cached value. Ben
Herrenschmidt has also mentioned that he plans to use this in PPC power
management.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.10-rc3-bk8-bjking1/drivers/pci/access.c |  104 ++++++++++++++++++++++
 linux-2.6.10-rc3-bk8-bjking1/include/linux/pci.h  |   37 ++-----
 2 files changed, 115 insertions(+), 26 deletions(-)

diff -puN include/linux/pci.h~pci_block_config_io_during_bist include/linux/pci.h
--- linux-2.6.10-rc3-bk8/include/linux/pci.h~pci_block_config_io_during_bist	2004-12-14 13:31:52.000000000 -0600
+++ linux-2.6.10-rc3-bk8-bjking1/include/linux/pci.h	2004-12-14 13:31:52.000000000 -0600
@@ -535,7 +535,8 @@ struct pci_dev {
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
-	
+	unsigned int	block_cfg_access:1;	/* config space access is blocked */
+
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
@@ -750,31 +751,12 @@ int pci_bus_read_config_dword (struct pc
 int pci_bus_write_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 val);
 int pci_bus_write_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 val);
 int pci_bus_write_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 val);
-
-static inline int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
-{
-	return pci_bus_read_config_byte (dev->bus, dev->devfn, where, val);
-}
-static inline int pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
-{
-	return pci_bus_read_config_word (dev->bus, dev->devfn, where, val);
-}
-static inline int pci_read_config_dword(struct pci_dev *dev, int where, u32 *val)
-{
-	return pci_bus_read_config_dword (dev->bus, dev->devfn, where, val);
-}
-static inline int pci_write_config_byte(struct pci_dev *dev, int where, u8 val)
-{
-	return pci_bus_write_config_byte (dev->bus, dev->devfn, where, val);
-}
-static inline int pci_write_config_word(struct pci_dev *dev, int where, u16 val)
-{
-	return pci_bus_write_config_word (dev->bus, dev->devfn, where, val);
-}
-static inline int pci_write_config_dword(struct pci_dev *dev, int where, u32 val)
-{
-	return pci_bus_write_config_dword (dev->bus, dev->devfn, where, val);
-}
+int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val);
+int pci_read_config_word(struct pci_dev *dev, int where, u16 *val);
+int pci_read_config_dword(struct pci_dev *dev, int where, u32 *val);
+int pci_write_config_byte(struct pci_dev *dev, int where, u8 val);
+int pci_write_config_word(struct pci_dev *dev, int where, u16 val);
+int pci_write_config_dword(struct pci_dev *dev, int where, u32 val);
 
 int pci_enable_device(struct pci_dev *dev);
 int pci_enable_device_bars(struct pci_dev *dev, int mask);
@@ -870,6 +852,9 @@ extern void pci_disable_msix(struct pci_
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 #endif
 
+extern int pci_start_bist(struct pci_dev *dev);
+extern void pci_block_config_access(struct pci_dev *dev);
+extern void pci_unblock_config_access(struct pci_dev *dev);
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
diff -puN drivers/pci/access.c~pci_block_config_io_during_bist drivers/pci/access.c
--- linux-2.6.10-rc3-bk8/drivers/pci/access.c~pci_block_config_io_during_bist	2004-12-14 13:31:52.000000000 -0600
+++ linux-2.6.10-rc3-bk8-bjking1/drivers/pci/access.c	2004-12-14 13:31:52.000000000 -0600
@@ -60,3 +60,107 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
 EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
+
+#define PCI_READ_CONFIG(size,type)	\
+int pci_read_config_##size	\
+	(struct pci_dev *dev, int pos, type *val)	\
+{									\
+	unsigned long flags;					\
+	int ret = 0;						\
+	u32 data = -1;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);		\
+	if (likely(!dev->block_cfg_access))				\
+		ret = dev->bus->ops->read(dev->bus, dev->devfn, pos, sizeof(type), &data); \
+	else if (pos < sizeof(dev->saved_config_space))		\
+		data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])]; \
+	spin_unlock_irqrestore(&pci_lock, flags);		\
+	*val = (type)data;					\
+	return ret;							\
+}
+
+#define PCI_WRITE_CONFIG(size,type)	\
+int pci_write_config_##size	\
+	(struct pci_dev *dev, int pos, type val)		\
+{									\
+	unsigned long flags;					\
+	int ret = 0;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);		\
+	if (likely(!dev->block_cfg_access))					\
+		ret = dev->bus->ops->write(dev->bus, dev->devfn, pos, sizeof(type), val); \
+	spin_unlock_irqrestore(&pci_lock, flags);		\
+	return ret;							\
+}
+
+PCI_READ_CONFIG(byte, u8)
+PCI_READ_CONFIG(word, u16)
+PCI_READ_CONFIG(dword, u32)
+PCI_WRITE_CONFIG(byte, u8)
+PCI_WRITE_CONFIG(word, u16)
+PCI_WRITE_CONFIG(dword, u32)
+
+/**
+ * pci_block_config_access - Block PCI config reads/writes
+ * @dev:	pci device struct
+ *
+ * This function blocks any PCI config accesses from occurring.
+ * When blocked, any writes will be humored and reads will return
+ * the data saved using pci_save_state for the first 64 bytes
+ * of config space and return ff's for all other config reads.
+ *
+ * Return value:
+ * 	nothing
+ **/
+void pci_block_config_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	pci_save_state(dev);
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_cfg_access = 1;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+
+/**
+ * pci_unblock_config_access - Unblock PCI config reads/writes
+ * @dev:	pci device struct
+ *
+ * This function allows PCI config accesses to resume.
+ *
+ * Return value:
+ * 	nothing
+ **/
+void pci_unblock_config_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_cfg_access = 0;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+
+/**
+ * pci_start_bist - Start BIST on a PCI device
+ * @dev:	pci device struct
+ *
+ * This function allows a device driver to start BIST
+ * when PCI config accesses are disabled.
+ *
+ * Return value:
+ * 	nothing
+ **/
+int pci_start_bist(struct pci_dev *dev)
+{
+	return pci_bus_write_config_byte(dev->bus, dev->devfn, PCI_BIST, PCI_BIST_START);
+}
+
+EXPORT_SYMBOL(pci_read_config_byte);
+EXPORT_SYMBOL(pci_read_config_word);
+EXPORT_SYMBOL(pci_read_config_dword);
+EXPORT_SYMBOL(pci_write_config_byte);
+EXPORT_SYMBOL(pci_write_config_word);
+EXPORT_SYMBOL(pci_write_config_dword);
+EXPORT_SYMBOL(pci_start_bist);
+EXPORT_SYMBOL(pci_block_config_access);
+EXPORT_SYMBOL(pci_unblock_config_access);
_
