Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263194AbUKTXru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbUKTXru (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbUKTXrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:47:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2973 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263194AbUKTXix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:38:53 -0500
Message-ID: <419FD58A.3010309@us.ibm.com>
Date: Sat, 20 Nov 2004 17:38:50 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>	 <1100917635.9398.12.camel@localhost.localdomain>	 <1100934567.3669.12.camel@gaston> <1100954543.11822.8.camel@localhost.localdomain>
In-Reply-To: <1100954543.11822.8.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------080204020605090908000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080204020605090908000809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> Some of the Intel CPU's are very bad at lock handling so it is an issue.
> Also most PCI config accesses nowdays go to onboard devices whose
> behaviour may well be quite different to PCI anyway. PCI has become a
> device management API.

Does this following patch address your issues with this patch, Alan?

It still doesn't address Greg's issue about making this apply to the
pci_bus_* functions as well, but I'm not sure of a good way to do that
due to the reasons given earlier.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------080204020605090908000809
Content-Type: text/plain;
 name="pci_block_config_io_during_bist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_block_config_io_during_bist.patch"


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



---

 linux-2.6.10-rc2-bk5-bjking1/drivers/pci/access.c |  103 ++++++++++++++++++++++
 linux-2.6.10-rc2-bk5-bjking1/include/linux/pci.h  |   37 ++-----
 2 files changed, 114 insertions(+), 26 deletions(-)

diff -puN drivers/pci/access.c~pci_block_config_io_during_bist drivers/pci/access.c
--- linux-2.6.10-rc2-bk5/drivers/pci/access.c~pci_block_config_io_during_bist	2004-11-20 16:07:19.000000000 -0600
+++ linux-2.6.10-rc2-bk5-bjking1/drivers/pci/access.c	2004-11-20 16:40:32.000000000 -0600
@@ -60,3 +60,106 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
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
+ * the data last saved using pci_save_state for the first 64 bytes
+ * of config space and return ff's for all other config reads.
+ *
+ * Return value:
+ * 	nothing
+ **/
+void pci_block_config_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
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
diff -puN include/linux/pci.h~pci_block_config_io_during_bist include/linux/pci.h
--- linux-2.6.10-rc2-bk5/include/linux/pci.h~pci_block_config_io_during_bist	2004-11-20 16:07:19.000000000 -0600
+++ linux-2.6.10-rc2-bk5-bjking1/include/linux/pci.h	2004-11-20 16:07:19.000000000 -0600
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

_

--------------080204020605090908000809--

