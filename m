Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVAJXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVAJXFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVAJXD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:03:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26871 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262564AbVAJW5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:57:53 -0500
Message-ID: <41E3086D.90506@us.ibm.com>
Date: Mon, 10 Jan 2005 16:57:49 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de>
In-Reply-To: <20050110162950.GB14039@muc.de>
Content-Type: multipart/mixed;
 boundary="------------020802000900000804020604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020802000900000804020604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
>>The problem I am trying to solve is the userspace PCI access methods 
>>accessing my config space when the adapter is not able to handle such an 
>>access. Today these accesses bypass the device driver altogether and 
>>there is no way to stop them. An alternative to this patch would be to 
> 
> 
> For this I would add a semaphore or a lock bit to pci_dev.
> Probably a simple flag is good enough that is checked by sysfs/proc
> and return EBUSY when set. 

How about something like this... (only compile tested at this point)


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------020802000900000804020604
Content-Type: text/plain;
 name="pci_block_user_config_io_during_bist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_block_user_config_io_during_bist.patch"


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

 linux-2.6.10-bk13-bjking1/drivers/pci/access.c    |   83 ++++++++++++++++++++++
 linux-2.6.10-bk13-bjking1/drivers/pci/pci-sysfs.c |   10 +-
 linux-2.6.10-bk13-bjking1/drivers/pci/proc.c      |   28 +++----
 linux-2.6.10-bk13-bjking1/drivers/pci/syscall.c   |   12 +--
 linux-2.6.10-bk13-bjking1/include/linux/pci.h     |   12 ++-
 5 files changed, 119 insertions(+), 26 deletions(-)

diff -puN drivers/pci/pci-sysfs.c~pci_block_user_config_io_during_bist drivers/pci/pci-sysfs.c
--- linux-2.6.10-bk13/drivers/pci/pci-sysfs.c~pci_block_user_config_io_during_bist	2005-01-10 11:14:49.000000000 -0600
+++ linux-2.6.10-bk13-bjking1/drivers/pci/pci-sysfs.c	2005-01-10 12:48:43.000000000 -0600
@@ -109,7 +109,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (off & 3) {
 		unsigned char val;
-		pci_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		buf[off - init_off] = val;
 		off++;
 		if (--size == 0)
@@ -118,7 +118,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (size > 3) {
 		unsigned int val;
-		pci_read_config_dword(dev, off, &val);
+		pci_user_read_config_dword(dev, off, &val);
 		buf[off - init_off] = val & 0xff;
 		buf[off - init_off + 1] = (val >> 8) & 0xff;
 		buf[off - init_off + 2] = (val >> 16) & 0xff;
@@ -129,7 +129,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (size > 0) {
 		unsigned char val;
-		pci_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		buf[off - init_off] = val;
 		off++;
 		--size;
@@ -153,7 +153,7 @@ pci_write_config(struct kobject *kobj, c
 	}
 
 	while (off & 3) {
-		pci_write_config_byte(dev, off, buf[off - init_off]);
+		pci_user_write_config_byte(dev, off, buf[off - init_off]);
 		off++;
 		if (--size == 0)
 			break;
@@ -170,7 +170,7 @@ pci_write_config(struct kobject *kobj, c
 	}
 
 	while (size > 0) {
-		pci_write_config_byte(dev, off, buf[off - init_off]);
+		pci_user_write_config_byte(dev, off, buf[off - init_off]);
 		off++;
 		--size;
 	}
diff -puN drivers/pci/access.c~pci_block_user_config_io_during_bist drivers/pci/access.c
--- linux-2.6.10-bk13/drivers/pci/access.c~pci_block_user_config_io_during_bist	2005-01-10 11:15:46.000000000 -0600
+++ linux-2.6.10-bk13-bjking1/drivers/pci/access.c	2005-01-10 14:29:57.000000000 -0600
@@ -60,3 +60,86 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
 EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
+
+#define PCI_USER_READ_CONFIG(size,type)	\
+int pci_user_read_config_##size	\
+	(struct pci_dev *dev, int pos, type *val)	\
+{									\
+	unsigned long flags;					\
+	int ret = 0;						\
+	u32 data = -1;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);		\
+	if (likely(!dev->block_ucfg_access))				\
+		ret = dev->bus->ops->read(dev->bus, dev->devfn, pos, sizeof(type), &data); \
+	else if (pos < sizeof(dev->saved_config_space))		\
+		data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])]; \
+	else								\
+		ret = -EBUSY;					\
+	spin_unlock_irqrestore(&pci_lock, flags);		\
+	*val = (type)data;					\
+	return ret;							\
+}
+
+#define PCI_USER_WRITE_CONFIG(size,type)	\
+int pci_user_write_config_##size	\
+	(struct pci_dev *dev, int pos, type val)		\
+{									\
+	unsigned long flags;					\
+	int ret = -EBUSY;						\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);		\
+	if (likely(!dev->block_ucfg_access))					\
+		ret = dev->bus->ops->write(dev->bus, dev->devfn, pos, sizeof(type), val); \
+	spin_unlock_irqrestore(&pci_lock, flags);		\
+	return ret;							\
+}
+
+PCI_USER_READ_CONFIG(byte, u8)
+PCI_USER_READ_CONFIG(word, u16)
+PCI_USER_READ_CONFIG(dword, u32)
+PCI_USER_WRITE_CONFIG(byte, u8)
+PCI_USER_WRITE_CONFIG(word, u16)
+PCI_USER_WRITE_CONFIG(dword, u32)
+
+/**
+ * pci_block_user_cfg_access - Block userspace PCI config reads/writes
+ * @dev:	pci device struct
+ *
+ * This function blocks any userspace PCI config accesses from occurring.
+ * When blocked, any writes will return -EBUSY and reads will return the
+ * data saved using pci_save_state for the first 64 bytes of config
+ * space and return -EBUSY for all other config reads.
+ *
+ * Return value:
+ * 	nothing
+ **/
+void pci_block_user_cfg_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	pci_save_state(dev);
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_ucfg_access = 1;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+EXPORT_SYMBOL(pci_block_user_cfg_access);
+
+/**
+ * pci_unblock_user_cfg_access - Unblock userspace PCI config reads/writes
+ * @dev:	pci device struct
+ *
+ * This function allows userspace PCI config accesses to resume.
+ *
+ * Return value:
+ * 	nothing
+ **/
+void pci_unblock_user_cfg_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_ucfg_access = 0;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+EXPORT_SYMBOL(pci_unblock_user_cfg_access);
diff -puN include/linux/pci.h~pci_block_user_config_io_during_bist include/linux/pci.h
--- linux-2.6.10-bk13/include/linux/pci.h~pci_block_user_config_io_during_bist	2005-01-10 11:23:03.000000000 -0600
+++ linux-2.6.10-bk13-bjking1/include/linux/pci.h	2005-01-10 13:17:09.000000000 -0600
@@ -535,7 +535,8 @@ struct pci_dev {
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
-	
+	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
@@ -776,6 +777,13 @@ static inline int pci_write_config_dword
 	return pci_bus_write_config_dword (dev->bus, dev->devfn, where, val);
 }
 
+int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
+int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
+int pci_user_read_config_dword(struct pci_dev *dev, int where, u32 *val);
+int pci_user_write_config_byte(struct pci_dev *dev, int where, u8 val);
+int pci_user_write_config_word(struct pci_dev *dev, int where, u16 val);
+int pci_user_write_config_dword(struct pci_dev *dev, int where, u32 val);
+
 int pci_enable_device(struct pci_dev *dev);
 int pci_enable_device_bars(struct pci_dev *dev, int mask);
 void pci_disable_device(struct pci_dev *dev);
@@ -870,6 +878,8 @@ extern void pci_disable_msix(struct pci_
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 #endif
 
+extern void pci_block_user_cfg_access(struct pci_dev *dev);
+extern void pci_unblock_user_cfg_access(struct pci_dev *dev);
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
diff -puN drivers/pci/syscall.c~pci_block_user_config_io_during_bist drivers/pci/syscall.c
--- linux-2.6.10-bk13/drivers/pci/syscall.c~pci_block_user_config_io_during_bist	2005-01-10 12:49:16.000000000 -0600
+++ linux-2.6.10-bk13-bjking1/drivers/pci/syscall.c	2005-01-10 12:49:50.000000000 -0600
@@ -38,13 +38,13 @@ sys_pciconfig_read(unsigned long bus, un
 	lock_kernel();
 	switch (len) {
 	case 1:
-		cfg_ret = pci_read_config_byte(dev, off, &byte);
+		cfg_ret = pci_user_read_config_byte(dev, off, &byte);
 		break;
 	case 2:
-		cfg_ret = pci_read_config_word(dev, off, &word);
+		cfg_ret = pci_user_read_config_word(dev, off, &word);
 		break;
 	case 4:
-		cfg_ret = pci_read_config_dword(dev, off, &dword);
+		cfg_ret = pci_user_read_config_dword(dev, off, &dword);
 		break;
 	default:
 		err = -EINVAL;
@@ -112,7 +112,7 @@ sys_pciconfig_write(unsigned long bus, u
 		err = get_user(byte, (u8 __user *)buf);
 		if (err)
 			break;
-		err = pci_write_config_byte(dev, off, byte);
+		err = pci_user_write_config_byte(dev, off, byte);
 		if (err != PCIBIOS_SUCCESSFUL)
 			err = -EIO;
 		break;
@@ -121,7 +121,7 @@ sys_pciconfig_write(unsigned long bus, u
 		err = get_user(word, (u16 __user *)buf);
 		if (err)
 			break;
-		err = pci_write_config_word(dev, off, word);
+		err = pci_user_write_config_word(dev, off, word);
 		if (err != PCIBIOS_SUCCESSFUL)
 			err = -EIO;
 		break;
@@ -130,7 +130,7 @@ sys_pciconfig_write(unsigned long bus, u
 		err = get_user(dword, (u32 __user *)buf);
 		if (err)
 			break;
-		err = pci_write_config_dword(dev, off, dword);
+		err = pci_user_write_config_dword(dev, off, dword);
 		if (err != PCIBIOS_SUCCESSFUL)
 			err = -EIO;
 		break;
diff -puN drivers/pci/proc.c~pci_block_user_config_io_during_bist drivers/pci/proc.c
--- linux-2.6.10-bk13/drivers/pci/proc.c~pci_block_user_config_io_during_bist	2005-01-10 12:50:05.000000000 -0600
+++ linux-2.6.10-bk13-bjking1/drivers/pci/proc.c	2005-01-10 12:51:04.000000000 -0600
@@ -79,7 +79,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
-		pci_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
 		pos++;
@@ -88,7 +88,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
-		pci_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (unsigned short __user *) buf);
 		buf += 2;
 		pos += 2;
@@ -97,7 +97,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	while (cnt >= 4) {
 		unsigned int val;
-		pci_read_config_dword(dev, pos, &val);
+		pci_user_read_config_dword(dev, pos, &val);
 		__put_user(cpu_to_le32(val), (unsigned int __user *) buf);
 		buf += 4;
 		pos += 4;
@@ -106,7 +106,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if (cnt >= 2) {
 		unsigned short val;
-		pci_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (unsigned short __user *) buf);
 		buf += 2;
 		pos += 2;
@@ -115,7 +115,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if (cnt) {
 		unsigned char val;
-		pci_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
 		pos++;
@@ -150,7 +150,7 @@ proc_bus_pci_write(struct file *file, co
 	if ((pos & 1) && cnt) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
 		cnt--;
@@ -159,7 +159,7 @@ proc_bus_pci_write(struct file *file, co
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
 		__get_user(val, (unsigned short __user *) buf);
-		pci_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -168,7 +168,7 @@ proc_bus_pci_write(struct file *file, co
 	while (cnt >= 4) {
 		unsigned int val;
 		__get_user(val, (unsigned int __user *) buf);
-		pci_write_config_dword(dev, pos, le32_to_cpu(val));
+		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
@@ -177,7 +177,7 @@ proc_bus_pci_write(struct file *file, co
 	if (cnt >= 2) {
 		unsigned short val;
 		__get_user(val, (unsigned short __user *) buf);
-		pci_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -186,7 +186,7 @@ proc_bus_pci_write(struct file *file, co
 	if (cnt) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
 		cnt--;
@@ -474,10 +474,10 @@ static int show_dev_config(struct seq_fi
 
 	drv = pci_dev_driver(dev);
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
-	pci_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
-	pci_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
+	pci_user_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	pci_user_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
+	pci_user_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
+	pci_user_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
 	seq_printf(m, "  Bus %2d, device %3d, function %2d:\n",
 	       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	class = pci_class_name(class_rev >> 16);
_

--------------020802000900000804020604--
