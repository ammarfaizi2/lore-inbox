Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVBBPeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVBBPeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVBBPeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:34:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:64166 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262695AbVBBPdL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:33:11 -0500
Message-ID: <4200F2B2.3080306@us.ibm.com>
Date: Wed, 02 Feb 2005 09:33:06 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk> <41FFBDC9.2010206@us.ibm.com> <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------070409030905040602010907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409030905040602010907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Wilcox wrote:
> On Tue, Feb 01, 2005 at 11:35:05AM -0600, Brian King wrote:
> 
>>>If we've done a write to config space while the adapter was blocked,
>>>shouldn't we replay those accesses at this point?
>>
>>I did not think that was necessary.
> 
> 
> We have to do *something*.  We can't just throw away writes.
> 
> I see a few options:
> 
>  - Log all pending writes to config space and replay the log when the
>    device is unblocked.
>  - Fail writes to config space while the device is blocked.
>  - Write to the saved config space and then blat the saved config space
>    back to the device upon unblocking.

Here is an updated patch which will now fail writes to config space 
while the device is blocked. I have also fixed up the caching to return 
the correct data and tested it on both little endian and big endian 
machines.

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------070409030905040602010907
Content-Type: text/plain;
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

 linux-2.6.11-rc2-bk9-bjking1/drivers/pci/access.c    |   86 +++++++++++++++++++
 linux-2.6.11-rc2-bk9-bjking1/drivers/pci/pci-sysfs.c |   10 +-
 linux-2.6.11-rc2-bk9-bjking1/drivers/pci/pci.h       |    7 +
 linux-2.6.11-rc2-bk9-bjking1/drivers/pci/proc.c      |   30 +++---
 linux-2.6.11-rc2-bk9-bjking1/drivers/pci/syscall.c   |   14 +--
 linux-2.6.11-rc2-bk9-bjking1/include/linux/pci.h     |    7 +
 6 files changed, 127 insertions(+), 27 deletions(-)

diff -puN drivers/pci/access.c~pci_block_user_config_io_during_bist_again drivers/pci/access.c
--- linux-2.6.11-rc2-bk9/drivers/pci/access.c~pci_block_user_config_io_during_bist_again	2005-02-02 08:58:53.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/access.c	2005-02-02 09:15:30.000000000 -0600
@@ -60,3 +60,89 @@ EXPORT_SYMBOL(pci_bus_read_config_dword)
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
+	spin_lock_irqsave(&pci_lock, flags);
+	dev->block_ucfg_access = 0;
+	spin_unlock_irqrestore(&pci_lock, flags);
+}
+EXPORT_SYMBOL_GPL(pci_unblock_user_cfg_access);
diff -puN drivers/pci/pci-sysfs.c~pci_block_user_config_io_during_bist_again drivers/pci/pci-sysfs.c
--- linux-2.6.11-rc2-bk9/drivers/pci/pci-sysfs.c~pci_block_user_config_io_during_bist_again	2005-02-02 08:58:53.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/pci-sysfs.c	2005-02-02 08:58:53.000000000 -0600
@@ -110,7 +110,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (off & 3) {
 		unsigned char val;
-		pci_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		buf[off - init_off] = val;
 		off++;
 		if (--size == 0)
@@ -119,7 +119,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (size > 3) {
 		unsigned int val;
-		pci_read_config_dword(dev, off, &val);
+		pci_user_read_config_dword(dev, off, &val);
 		buf[off - init_off] = val & 0xff;
 		buf[off - init_off + 1] = (val >> 8) & 0xff;
 		buf[off - init_off + 2] = (val >> 16) & 0xff;
@@ -130,7 +130,7 @@ pci_read_config(struct kobject *kobj, ch
 
 	while (size > 0) {
 		unsigned char val;
-		pci_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		buf[off - init_off] = val;
 		off++;
 		--size;
@@ -154,7 +154,7 @@ pci_write_config(struct kobject *kobj, c
 	}
 
 	while (off & 3) {
-		pci_write_config_byte(dev, off, buf[off - init_off]);
+		pci_user_write_config_byte(dev, off, buf[off - init_off]);
 		off++;
 		if (--size == 0)
 			break;
@@ -171,7 +171,7 @@ pci_write_config(struct kobject *kobj, c
 	}
 
 	while (size > 0) {
-		pci_write_config_byte(dev, off, buf[off - init_off]);
+		pci_user_write_config_byte(dev, off, buf[off - init_off]);
 		off++;
 		--size;
 	}
diff -puN drivers/pci/proc.c~pci_block_user_config_io_during_bist_again drivers/pci/proc.c
--- linux-2.6.11-rc2-bk9/drivers/pci/proc.c~pci_block_user_config_io_during_bist_again	2005-02-02 08:58:53.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/proc.c	2005-02-02 08:58:53.000000000 -0600
@@ -16,6 +16,8 @@
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
+#include "pci.h"
+
 static int proc_initialized;	/* = 0 */
 
 static loff_t
@@ -79,7 +81,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if ((pos & 1) && cnt) {
 		unsigned char val;
-		pci_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
 		pos++;
@@ -88,7 +90,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
-		pci_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (unsigned short __user *) buf);
 		buf += 2;
 		pos += 2;
@@ -97,7 +99,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	while (cnt >= 4) {
 		unsigned int val;
-		pci_read_config_dword(dev, pos, &val);
+		pci_user_read_config_dword(dev, pos, &val);
 		__put_user(cpu_to_le32(val), (unsigned int __user *) buf);
 		buf += 4;
 		pos += 4;
@@ -106,7 +108,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if (cnt >= 2) {
 		unsigned short val;
-		pci_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, pos, &val);
 		__put_user(cpu_to_le16(val), (unsigned short __user *) buf);
 		buf += 2;
 		pos += 2;
@@ -115,7 +117,7 @@ proc_bus_pci_read(struct file *file, cha
 
 	if (cnt) {
 		unsigned char val;
-		pci_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
 		buf++;
 		pos++;
@@ -150,7 +152,7 @@ proc_bus_pci_write(struct file *file, co
 	if ((pos & 1) && cnt) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
 		cnt--;
@@ -159,7 +161,7 @@ proc_bus_pci_write(struct file *file, co
 	if ((pos & 3) && cnt > 2) {
 		unsigned short val;
 		__get_user(val, (unsigned short __user *) buf);
-		pci_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -168,7 +170,7 @@ proc_bus_pci_write(struct file *file, co
 	while (cnt >= 4) {
 		unsigned int val;
 		__get_user(val, (unsigned int __user *) buf);
-		pci_write_config_dword(dev, pos, le32_to_cpu(val));
+		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
@@ -177,7 +179,7 @@ proc_bus_pci_write(struct file *file, co
 	if (cnt >= 2) {
 		unsigned short val;
 		__get_user(val, (unsigned short __user *) buf);
-		pci_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
 		buf += 2;
 		pos += 2;
 		cnt -= 2;
@@ -186,7 +188,7 @@ proc_bus_pci_write(struct file *file, co
 	if (cnt) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, pos, val);
 		buf++;
 		pos++;
 		cnt--;
@@ -474,10 +476,10 @@ static int show_dev_config(struct seq_fi
 
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
--- linux-2.6.11-rc2-bk9/drivers/pci/syscall.c~pci_block_user_config_io_during_bist_again	2005-02-02 08:58:53.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/syscall.c	2005-02-02 08:58:53.000000000 -0600
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
--- linux-2.6.11-rc2-bk9/include/linux/pci.h~pci_block_user_config_io_during_bist_again	2005-02-02 08:58:53.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/include/linux/pci.h	2005-02-02 08:58:53.000000000 -0600
@@ -557,7 +557,8 @@ struct pci_dev {
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
-	
+	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
@@ -896,6 +897,8 @@ extern void pci_disable_msix(struct pci_
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 #endif
 
+extern void pci_block_user_cfg_access(struct pci_dev *dev);
+extern void pci_unblock_user_cfg_access(struct pci_dev *dev);
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
@@ -947,6 +950,8 @@ static inline void pci_unregister_driver
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
+static inline void pci_block_user_cfg_access(struct pci_dev *dev) { }
+static inline void pci_unblock_user_cfg_access(struct pci_dev *dev) { }
 
 /* Power management related routines */
 static inline int pci_save_state(struct pci_dev *dev) { return 0; }
diff -puN drivers/pci/pci.h~pci_block_user_config_io_during_bist_again drivers/pci/pci.h
--- linux-2.6.11-rc2-bk9/drivers/pci/pci.h~pci_block_user_config_io_during_bist_again	2005-02-02 08:58:53.000000000 -0600
+++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/pci.h	2005-02-02 08:58:53.000000000 -0600
@@ -11,6 +11,13 @@ extern int pci_bus_alloc_resource(struct
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
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

--------------070409030905040602010907--
