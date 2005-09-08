Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933013AbVIHDH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbVIHDH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 23:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbVIHDH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 23:07:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6876 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S933013AbVIHDHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 23:07:25 -0400
Message-ID: <431FAA7A.90503@us.ibm.com>
Date: Wed, 07 Sep 2005 22:05:30 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
References: <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org> <431A33D0.1040807@us.ibm.com> <20050903193958.GB30579@colo.lackof.org> <17182.32625.930500.874251@cargo.ozlabs.ibm.com> <20050907145818.GA25409@colo.lackof.org> <17183.27667.47675.454393@cargo.ozlabs.ibm.com> <20050908012116.GB2065@colo.lackof.org>
In-Reply-To: <20050908012116.GB2065@colo.lackof.org>
Content-Type: multipart/mixed;
 boundary="------------020406000004080601060408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406000004080601060408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Grundler wrote:
> On Thu, Sep 08, 2005 at 08:39:15AM +1000, Paul Mackerras wrote:
> 
>>Grant Grundler writes:
>>
>>
>>>I would argue it more obvious. People looking at the code
>>>are immediately going to realize it was a deliberate choice to
>>>not use a spinlock.
>>
>>It achieves exactly the same effect as spin_lock/spin_unlock, just
>>more verbosely. :)
> 
> 
> Not exactly identical. spin_try_lock() doesn't attempt to acquire
> the lock and thus force exclusive access to the cacheline.
> Other than that, I agree with you.
> 
> I don't see a problem with being verbose here since putting
> a spinlock around something that's already atomic (assignment)
> even caught Andrew's attention.

I reverted the patch to use a spinlock and added a comment. How
does this look?


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------020406000004080601060408
Content-Type: text/x-patch;
 name="pci_block_user_config_io_during_bist_again.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_block_user_config_io_during_bist_again.patch"


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

 drivers/pci/access.c    |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c |   20 +++++-----
 drivers/pci/pci.h       |    7 +++
 drivers/pci/proc.c      |   28 +++++++--------
 drivers/pci/syscall.c   |   14 +++----
 include/linux/pci.h     |    5 ++
 6 files changed, 132 insertions(+), 31 deletions(-)

diff -puN drivers/pci/access.c~pci_block_user_config_io_during_bist_again drivers/pci/access.c
--- linux-2.6/drivers/pci/access.c~pci_block_user_config_io_during_bist_again	2005-09-07 20:41:10.794881344 -0500
+++ linux-2.6-bjking1/drivers/pci/access.c	2005-09-07 21:11:14.085739464 -0500
@@ -60,3 +60,92 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
 EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
+
+static u32 pci_user_cached_config(struct pci_dev *dev, int pos)
+{
+	u32 data;
+
+	data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])];
+	data >>= (pos % sizeof(dev->saved_config_space[0])) * 8;
+	return data;
+}
+
+#define PCI_USER_READ_CONFIG(size,type)					\
+int pci_user_read_config_##size						\
+	(struct pci_dev *dev, int pos, type *val)			\
+{									\
+	unsigned long flags;						\
+	int ret = 0;							\
+	u32 data = -1;							\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);				\
+	if (likely(!dev->block_ucfg_access))				\
+		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
+					pos, sizeof(type), &data);	\
+	else if (pos < sizeof(dev->saved_config_space))			\
+		data = pci_user_cached_config(dev, pos); 		\
+	spin_unlock_irqrestore(&pci_lock, flags);			\
+	*val = (type)data;						\
+	return ret;							\
+}
+
+#define PCI_USER_WRITE_CONFIG(size,type)				\
+int pci_user_write_config_##size					\
+	(struct pci_dev *dev, int pos, type val)			\
+{									\
+	unsigned long flags;						\
+	int ret = -EIO;							\
+	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	spin_lock_irqsave(&pci_lock, flags);				\
+	if (likely(!dev->block_ucfg_access))				\
+		ret = dev->bus->ops->write(dev->bus, dev->devfn,	\
+					pos, sizeof(type), val);	\
+	spin_unlock_irqrestore(&pci_lock, flags);			\
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
+ * When blocked, any writes will be bit bucketed and reads will return the
+ * data saved using pci_save_state for the first 64 bytes of config
+ * space and return 0xff for all other config reads.
+ **/
+void pci_block_user_cfg_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	pci_save_state(dev);
+
+	/* spinlock to synchronize with anyone reading config space now */
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_ucfg_access = 1;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+EXPORT_SYMBOL_GPL(pci_block_user_cfg_access);
+
+/**
+ * pci_unblock_user_cfg_access - Unblock userspace PCI config reads/writes
+ * @dev:	pci device struct
+ *
+ * This function allows userspace PCI config accesses to resume.
+ **/
+void pci_unblock_user_cfg_access(struct pci_dev *dev)
+{
+	unsigned long flags;
+
+	/* spinlock to synchronize with anyone reading saved config space */
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_ucfg_access = 0;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+EXPORT_SYMBOL_GPL(pci_unblock_user_cfg_access);
diff -puN drivers/pci/pci-sysfs.c~pci_block_user_config_io_during_bist_again drivers/pci/pci-sysfs.c
--- linux-2.6/drivers/pci/pci-sysfs.c~pci_block_user_config_io_during_bist_again	2005-09-07 20:41:10.796881040 -0500
+++ linux-2.6-bjking1/drivers/pci/pci-sysfs.c	2005-09-07 20:41:10.847873288 -0500
@@ -126,7 +126,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	if ((off & 1) && size) {
 		u8 val;
-		pci_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		data[off - init_off] = val;
 		off++;
 		size--;
@@ -134,7 +134,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	if ((off & 3) && size > 2) {
 		u16 val;
-		pci_read_config_word(dev, off, &val);
+		pci_user_read_config_word(dev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		off += 2;
@@ -143,7 +143,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (size > 3) {
 		u32 val;
-		pci_read_config_dword(dev, off, &val);
+		pci_user_read_config_dword(dev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		data[off - init_off + 2] = (val >> 16) & 0xff;
@@ -154,7 +154,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	if (size >= 2) {
 		u16 val;
-		pci_read_config_word(dev, off, &val);
+		pci_user_read_config_word(dev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		off += 2;
@@ -163,7 +163,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	if (size > 0) {
 		u8 val;
-		pci_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		data[off - init_off] = val;
 		off++;
 		--size;
@@ -188,7 +188,7 @@ pci_write_config(struct kobject *kobj, c
 	}
 	
 	if ((off & 1) && size) {
-		pci_write_config_byte(dev, off, data[off - init_off]);
+		pci_user_write_config_byte(dev, off, data[off - init_off]);
 		off++;
 		size--;
 	}
@@ -196,7 +196,7 @@ pci_write_config(struct kobject *kobj, c
 	if ((off & 3) && size > 2) {
 		u16 val = data[off - init_off];
 		val |= (u16) data[off - init_off + 1] << 8;
-                pci_write_config_word(dev, off, val);
+                pci_user_write_config_word(dev, off, val);
                 off += 2;
                 size -= 2;
         }
@@ -206,7 +206,7 @@ pci_write_config(struct kobject *kobj, c
 		val |= (u32) data[off - init_off + 1] << 8;
 		val |= (u32) data[off - init_off + 2] << 16;
 		val |= (u32) data[off - init_off + 3] << 24;
-		pci_write_config_dword(dev, off, val);
+		pci_user_write_config_dword(dev, off, val);
 		off += 4;
 		size -= 4;
 	}
@@ -214,13 +214,13 @@ pci_write_config(struct kobject *kobj, c
 	if (size >= 2) {
 		u16 val = data[off - init_off];
 		val |= (u16) data[off - init_off + 1] << 8;
-		pci_write_config_word(dev, off, val);
+		pci_user_write_config_word(dev, off, val);
 		off += 2;
 		size -= 2;
 	}
 
 	if (size) {
-		pci_write_config_byte(dev, off, data[off - init_off]);
+		pci_user_write_config_byte(dev, off, data[off - init_off]);
 		off++;
 		--size;
 	}
diff -puN drivers/pci/proc.c~pci_block_user_config_io_during_bist_again drivers/pci/proc.c
--- linux-2.6/drivers/pci/proc.c~pci_block_user_config_io_during_bist_again	2005-09-07 20:41:10.798880736 -0500
+++ linux-2.6-bjking1/drivers/pci/proc.c	2005-09-07 20:41:10.847873288 -0500
@@ -80,7 +80,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
-		pci_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
 		pos++;
@@ -89,7 +89,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
-		pci_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (unsigned short __user *) buf);
 		buf += 2;
 		pos += 2;
@@ -98,7 +98,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	while (cnt >= 4) {
 		unsigned int val;
-		pci_read_config_dword(dev, pos, &val);
+		pci_user_read_config_dword(dev, pos, &val);
 		__put_user(cpu_to_le32(val), (unsigned int __user *) buf);
 		buf += 4;
 		pos += 4;
@@ -107,7 +107,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if (cnt >= 2) {
 		unsigned short val;
-		pci_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (unsigned short __user *) buf);
 		buf += 2;
 		pos += 2;
@@ -116,7 +116,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if (cnt) {
 		unsigned char val;
-		pci_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
 		pos++;
@@ -151,7 +151,7 @@ proc_bus_pci_write(struct file *file, co
 	if ((pos & 1) && cnt) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
 		cnt--;
@@ -160,7 +160,7 @@ proc_bus_pci_write(struct file *file, co
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
 		__get_user(val, (unsigned short __user *) buf);
-		pci_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -169,7 +169,7 @@ proc_bus_pci_write(struct file *file, co
 	while (cnt >= 4) {
 		unsigned int val;
 		__get_user(val, (unsigned int __user *) buf);
-		pci_write_config_dword(dev, pos, le32_to_cpu(val));
+		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
@@ -178,7 +178,7 @@ proc_bus_pci_write(struct file *file, co
 	if (cnt >= 2) {
 		unsigned short val;
 		__get_user(val, (unsigned short __user *) buf);
-		pci_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -187,7 +187,7 @@ proc_bus_pci_write(struct file *file, co
 	if (cnt) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
 		cnt--;
@@ -484,10 +484,10 @@ static int show_dev_config(struct seq_fi
 
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
diff -puN drivers/pci/syscall.c~pci_block_user_config_io_during_bist_again drivers/pci/syscall.c
--- linux-2.6/drivers/pci/syscall.c~pci_block_user_config_io_during_bist_again	2005-09-07 20:41:10.803879976 -0500
+++ linux-2.6-bjking1/drivers/pci/syscall.c	2005-09-07 20:41:10.848873136 -0500
@@ -13,7 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <asm/uaccess.h>
-
+#include "pci.h"
 
 asmlinkage long
 sys_pciconfig_read(unsigned long bus, unsigned long dfn,
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
diff -puN include/linux/pci.h~pci_block_user_config_io_during_bist_again include/linux/pci.h
--- linux-2.6/include/linux/pci.h~pci_block_user_config_io_during_bist_again	2005-09-07 20:41:10.839874504 -0500
+++ linux-2.6-bjking1/include/linux/pci.h	2005-09-07 20:41:10.849872984 -0500
@@ -557,6 +557,7 @@ struct pci_dev {
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
+	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
@@ -912,6 +913,8 @@ extern void pci_disable_msix(struct pci_
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 #endif
 
+extern void pci_block_user_cfg_access(struct pci_dev *dev);
+extern void pci_unblock_user_cfg_access(struct pci_dev *dev);
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
@@ -962,6 +965,8 @@ static inline void pci_unregister_driver
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
+static inline void pci_block_user_cfg_access(struct pci_dev *dev) { }
+static inline void pci_unblock_user_cfg_access(struct pci_dev *dev) { }
 
 /* Power management related routines */
 static inline int pci_save_state(struct pci_dev *dev) { return 0; }
diff -puN drivers/pci/pci.h~pci_block_user_config_io_during_bist_again drivers/pci/pci.h
--- linux-2.6/drivers/pci/pci.h~pci_block_user_config_io_during_bist_again	2005-09-07 20:41:10.841874200 -0500
+++ linux-2.6-bjking1/drivers/pci/pci.h	2005-09-07 20:41:10.849872984 -0500
@@ -15,6 +15,13 @@ extern int pci_bus_alloc_resource(struct
 extern int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t state);
 
+extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
+extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
+extern int pci_user_read_config_dword(struct pci_dev *dev, int where, u32 *val);
+extern int pci_user_write_config_byte(struct pci_dev *dev, int where, u8 val);
+extern int pci_user_write_config_word(struct pci_dev *dev, int where, u16 val);
+extern int pci_user_write_config_dword(struct pci_dev *dev, int where, u32 val);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
_

--------------020406000004080601060408--
