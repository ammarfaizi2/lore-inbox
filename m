Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUHXTKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUHXTKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUHXTKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:10:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32164 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268212AbUHXTJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:09:33 -0400
Date: Tue, 24 Aug 2004 20:09:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: boutcher@cs.umn.edu
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>, martins@au.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: VPD in sysfs
Message-ID: <20040824190931.GB16196@parcelfarce.linux.theplanet.co.uk>
References: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk> <20040820142143.GB14144@parcelfarce.linux.theplanet.co.uk> <20040820194525.GA13970@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820194525.GA13970@cs.umn.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 02:45:25PM -0500, Dave C Boutcher wrote:
> Ya, I ran into some similar restrictions with a driver I was
> writing...after talking to gregkh, you are going to have to go down a
> level and use kobjects directly...each piece of data will have a kobject, 
> and that's what you dereference in the show method. 

I was a little more sneaky than that ...

Clearly this is not ready for merging yet, but it shows where I'm going
atm.

Todo:

 - Automatically set up VPD for devices with it in their capability list
 - Write code for devices with PCI 2.1 VPD
 - Write code for sym2 that doesn't quite conform to PCI 2.1
 - Allow writable attributes for PCI 2.2 VPD
 - Teardown code for when the device goes away
 - Figure out why checksum doesn't work (I think I know)
 - Write a proper autoexpanding array data type

Index: vpd-2.6/drivers/net/tg3.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/tg3.c,v
retrieving revision 1.20
diff -u -p -r1.20 tg3.c
--- vpd-2.6/drivers/net/tg3.c	13 Aug 2004 14:29:46 -0000	1.20
+++ vpd-2.6/drivers/net/tg3.c	24 Aug 2004 18:59:50 -0000
@@ -8272,6 +8272,8 @@ static int __devinit tg3_init_one(struct
 	 */
 	pci_save_state(tp->pdev, tp->pci_cfg_state);
 
+	pci_setup_vpd(pdev);
+
 	printk(KERN_INFO "%s: Tigon3 [partno(%s) rev %04x PHY(%s)] (PCI%s:%s:%s) %sBaseT Ethernet ",
 	       dev->name,
 	       tp->board_part_number,
Index: vpd-2.6/drivers/pci/Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/Makefile,v
retrieving revision 1.7
diff -u -p -r1.7 Makefile
--- vpd-2.6/drivers/pci/Makefile	13 Aug 2004 14:29:50 -0000	1.7
+++ vpd-2.6/drivers/pci/Makefile	24 Aug 2004 18:59:50 -0000
@@ -5,6 +5,7 @@
 obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
 			names.o pci-driver.o search.o pci-sysfs.o
 obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_VPD) += vpd.o
 
 ifndef CONFIG_SPARC64
 obj-y += setup-res.o
Index: vpd-2.6/drivers/pci/vpd.c
===================================================================
RCS file: vpd-2.6/drivers/pci/vpd.c
diff -N vpd-2.6/drivers/pci/vpd.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ vpd-2.6/drivers/pci/vpd.c	24 Aug 2004 18:59:50 -0000
@@ -0,0 +1,284 @@
+/*
+ * drivers/pci/vpd.c
+ *
+ * Retrieves VPD from a PCI device and exposes it through sysfs
+ *
+ * Copyright (c) Matthew Wilcox 2004
+ */
+
+#include <linux/isapnp.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <asm/uaccess.h>
+
+/* XXX: sysfs should expose these properly */
+
+extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
+extern struct dentry * sysfs_get_dentry(struct dentry *, const char *);
+extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
+
+
+/* XXX: krealloc should be moved to mm/slab.c */
+
+static void * krealloc(void *ptr, size_t newsize, int flags)
+{
+	int size = ksize(ptr);
+	void *newptr = kmalloc(newsize, flags);
+	if (!newptr)
+		return NULL;
+	if (size > newsize)
+		size = newsize;
+	memcpy(newptr, ptr, size);
+	kfree(ptr);
+	return newptr;
+}
+
+static inline int isapnp_get_len(unsigned char *data, int *idx, enum isapnp_tag *tag)
+{
+	int i, x, len;
+
+	i = *idx;
+	x = data[i++];
+
+	if (x & 0x80) {
+		len = data[i] | (data[i + 1] << 8);
+		i += 2;
+	} else {
+		len = x & 7;
+		x >>= 3;
+	}
+
+	printk("VPD: idx %d tag %x len %d\n", i, x, len);
+	*idx = i;
+	*tag = x;
+	return len;
+}
+
+static ssize_t vpd_read(struct file *file, char __user *buf, size_t count,
+		loff_t *ppos)
+{
+	int err;
+	char *data = file->f_dentry->d_fsdata;
+	int len = strlen(data);
+	loff_t pos = *ppos;
+
+	if (pos > len)
+		return 0;
+	if (pos + count > len)
+		count = len - pos;
+	err = copy_to_user(buf, data + pos, count);
+	if (err)
+		return -EFAULT;
+	*ppos += count;
+	return count;
+}
+
+static ssize_t vpd_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static struct file_operations vpd_file_operations = {
+	.read = vpd_read,
+	.write = vpd_write,
+	.llseek = generic_file_llseek,
+};
+
+static int vpd_create_file(struct dentry *dir, char *name, char *contents, int mode)
+{
+	struct dentry *dentry;
+	int err;
+
+	printk("VPD: Creating %s %s\n", name, contents);
+
+	dget(dir);
+
+	down(&dir->d_inode->i_sem);
+	dentry = sysfs_get_dentry(dir, name);
+	err = PTR_ERR(dentry);
+	if (IS_ERR(dentry))
+		goto out;
+	err = sysfs_create(dentry, mode, NULL);
+	if (err)
+		goto dput;
+	dentry->d_inode->i_size = strlen(contents);
+	dentry->d_inode->i_fop = &vpd_file_operations;
+	dentry->d_fsdata = contents;
+
+ dput:
+	dput(dentry);
+ out:
+	up(&dir->d_inode->i_sem);
+	dput(dir);
+	return err;
+}
+
+static int vpd_create_name(struct dentry *dir, unsigned char *data, int len)
+{
+	char *content = kmalloc(len + 1, GFP_KERNEL);
+	memcpy(content, data, len);
+	content[len] = '\0';
+	return vpd_create_file(dir, "name", content, 0444);
+}
+
+static int vpd_create_tags(struct dentry *dir, unsigned char *data, int len,
+		int mode)
+{
+	int error, i = 0;
+	while (i < len) {
+		int l = data[i + 2];
+		char *tagcont = kmalloc(l + 4, GFP_KERNEL);
+		tagcont[0] = data[i];
+		tagcont[1] = data[i + 1];
+		tagcont[2] = '\0';
+		memcpy(tagcont + 3, data + i + 3, l);
+		tagcont[l + 3] = '\0';
+		error = vpd_create_file(dir, tagcont, tagcont + 3, mode);
+		if (error)
+			return error;
+		i += l + 3;
+		printk("i = %d, len = %d\n", i, len);
+	}
+
+	return 0;
+}
+
+static int vpd_checksum_data(unsigned char *data, int len)
+{
+	int i;
+	unsigned char accum = 0;
+	for (i = 0; i < len; i++) {
+		accum += data[i];
+		printk("pos 0x%x byte 0x%x, cxsum = 0x%x\n", i, data[i], accum);
+	}
+	return (accum == 0);
+}
+
+static int pci_dev_add_vpd(struct device *dev, unsigned char *data, int len)
+{
+	int err, i = 0;
+	struct dentry *dir;
+
+	vpd_checksum_data(data, len);
+//	if (!vpd_checksum_data(data, len))
+//		return -EINVAL;
+
+	err = sysfs_create_subdir(&dev->kobj, "vpd", &dir);
+	if (err)
+		return err;
+
+	for (;;) {
+		enum isapnp_tag tag;
+		int len = isapnp_get_len(data, &i, &tag);
+		if (tag == ISA_TAG_END) {
+			break;
+		} else if (tag == ISA_TAG_ANSIIDSTR) {
+			err = vpd_create_name(dir, data + i, len);
+		} else if (tag == ISA_TAG_VPD_R) {
+			err = vpd_create_tags(dir, data + i, len, 0444);
+		} else if (tag == ISA_TAG_VPD_W) {
+			err = vpd_create_tags(dir, data + i, len, 0644);
+		}
+		if (err)
+			break;
+		i += len;
+	}
+
+	return err;
+}
+
+static int pci_vpd_read_cap(struct pci_dev *dev, int addr, char *data, int off)
+{
+	u16 areg;
+	u32 dreg;
+
+	if (off > PCI_VPD_ADDR_MASK)
+		return -ENXIO;
+
+	pci_write_config_word(dev, addr + PCI_VPD_ADDR, off);
+	do {
+		pci_read_config_word(dev, addr + PCI_VPD_ADDR, &areg);
+	} while ((areg & PCI_VPD_ADDR_F) == 0);
+	pci_read_config_dword(dev, addr + PCI_VPD_DATA, &dreg);
+
+	data[off]	= (dreg >> 0)  & 0xff;
+	data[off + 1]	= (dreg >> 8)  & 0xff;
+	data[off + 2]	= (dreg >> 16) & 0xff;
+	data[off + 3]	= (dreg >> 24) & 0xff;
+
+	return 0;
+}
+
+static int pci_setup_vpd_cap(struct pci_dev *dev, int addr)
+{
+	int err;
+	unsigned int i = 0, vpd_size = 32;
+	unsigned char *vpd = kmalloc(vpd_size, GFP_KERNEL);
+	unsigned int tag, next_tag = 0;
+
+	for (;;) {
+		if (i == vpd_size) {
+			vpd_size *= 2;
+			char *new_vpd = krealloc(vpd, vpd_size, GFP_KERNEL);
+			if (!new_vpd) {
+				kfree(vpd);
+				return -ENOMEM;
+			}
+			vpd = new_vpd;
+		}
+
+		err = pci_vpd_read_cap(dev, addr, vpd, i);
+		if (err)
+			break;
+		i += 4;
+		if (next_tag >= i)
+			continue;
+		tag = vpd[next_tag];
+		if (tag & 0x80) {
+			if (next_tag + 2 >= i)
+				continue;
+			next_tag += 3 + vpd[next_tag + 1] +
+					(vpd[next_tag + 2] << 8);
+		} else {
+			next_tag += tag & 7;
+			tag >>= 3;
+		}
+
+		if (tag != ISA_TAG_END)
+			continue;
+
+		if (next_tag > i) {
+			err = pci_vpd_read_cap(dev, addr, vpd, i);
+			i += 4;
+		}
+		break;
+	}
+
+	if (err)
+		return err;
+
+	err = pci_dev_add_vpd(&dev->dev, vpd, i);
+
+	kfree(vpd);
+	return err;
+}
+
+/* PCI 2.1 specified a ROM-based method of finding the VPD. */
+static int pci_setup_vpd_old(struct pci_dev *dev)
+{
+	return -ENXIO;
+}
+
+int pci_setup_vpd(struct pci_dev *dev)
+{
+	int vpd_addr = pci_find_capability(dev, PCI_CAP_ID_VPD);
+
+	if (vpd_addr)
+		return pci_setup_vpd_cap(dev, vpd_addr);
+	return pci_setup_vpd_old(dev);
+}
+
+EXPORT_SYMBOL(pci_setup_vpd);
+EXPORT_SYMBOL(device_add_vpd);
+EXPORT_SYMBOL(device_remove_vpd);
Index: vpd-2.6/drivers/pnp/isapnp/core.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pnp/isapnp/core.c,v
retrieving revision 1.8
diff -u -p -r1.8 core.c
--- vpd-2.6/drivers/pnp/isapnp/core.c	20 Jul 2004 22:06:37 -0000	1.8
+++ vpd-2.6/drivers/pnp/isapnp/core.c	24 Aug 2004 18:59:50 -0000
@@ -72,24 +72,24 @@ MODULE_LICENSE("GPL");
 #define _PNPWRP		0xa79
 
 /* short tags */
-#define _STAG_PNPVERNO		0x01
-#define _STAG_LOGDEVID		0x02
-#define _STAG_COMPATDEVID	0x03
-#define _STAG_IRQ		0x04
-#define _STAG_DMA		0x05
-#define _STAG_STARTDEP		0x06
-#define _STAG_ENDDEP		0x07
-#define _STAG_IOPORT		0x08
-#define _STAG_FIXEDIO		0x09
-#define _STAG_VENDOR		0x0e
-#define _STAG_END		0x0f
+#define _STAG_PNPVERNO		ISA_TAG_PNPVERNO
+#define _STAG_LOGDEVID		ISA_TAG_LOGDEVID
+#define _STAG_COMPATDEVID	ISA_TAG_COMPATDEVID
+#define _STAG_IRQ		ISA_TAG_IRQ
+#define _STAG_DMA		ISA_TAG_DMA
+#define _STAG_STARTDEP		ISA_TAG_STARTDEP
+#define _STAG_ENDDEP		ISA_TAG_ENDDEP
+#define _STAG_IOPORT		ISA_TAG_IOPORT
+#define _STAG_FIXEDIO		ISA_TAG_FIXEDIO
+#define _STAG_VENDOR		ISA_TAG_VENDOR_S
+#define _STAG_END		ISA_TAG_END
 /* long tags */
-#define _LTAG_MEMRANGE		0x81
-#define _LTAG_ANSISTR		0x82
-#define _LTAG_UNICODESTR	0x83
-#define _LTAG_VENDOR		0x84
-#define _LTAG_MEM32RANGE	0x85
-#define _LTAG_FIXEDMEM32RANGE	0x86
+#define _LTAG_MEMRANGE		ISA_TAG_MEMRANGE
+#define _LTAG_ANSISTR		ISA_TAG_ANSIIDSTR
+#define _LTAG_UNICODESTR	ISA_TAG_UNICODEIDSTR
+#define _LTAG_VENDOR		ISA_TAG_VENDOR_L
+#define _LTAG_MEM32RANGE	ISA_TAG_MEM32RANGE
+#define _LTAG_FIXEDMEM32RANGE	ISA_TAG_FIXEDMEM32RANGE
 
 static unsigned char isapnp_checksum_value;
 static DECLARE_MUTEX(isapnp_cfg_mutex);
Index: vpd-2.6/fs/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/fs/Kconfig,v
retrieving revision 1.17
diff -u -p -r1.17 Kconfig
--- vpd-2.6/fs/Kconfig	13 Aug 2004 14:30:02 -0000	1.17
+++ vpd-2.6/fs/Kconfig	24 Aug 2004 18:59:51 -0000
@@ -832,6 +832,10 @@ config SYSFS
 
 	Designers of embedded systems may wish to say N here to conserve space.
 
+config VPD
+	def_bool y
+	depends on SYSFS
+
 config DEVFS_FS
 	bool "/dev file system support (OBSOLETE)"
 	depends on EXPERIMENTAL
Index: vpd-2.6/include/linux/isapnp.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/isapnp.h,v
retrieving revision 1.1
diff -u -p -r1.1 isapnp.h
--- vpd-2.6/include/linux/isapnp.h	29 Jul 2003 17:02:13 -0000	1.1
+++ vpd-2.6/include/linux/isapnp.h	24 Aug 2004 18:59:55 -0000
@@ -91,6 +91,29 @@ struct isapnp_device_id {
 	unsigned long driver_data;	/* data private to the driver */
 };
 
+
+enum isapnp_tag {
+	ISA_TAG_PNPVERNO = 0x01,
+	ISA_TAG_LOGDEVID = 0x02,
+	ISA_TAG_COMPATDEVID = 0x03,
+	ISA_TAG_IRQ = 0x04,
+	ISA_TAG_DMA = 0x05,
+	ISA_TAG_STARTDEP = 0x06,
+	ISA_TAG_ENDDEP = 0x07,
+	ISA_TAG_IOPORT = 0x08,
+	ISA_TAG_FIXEDIO = 0x09,
+	ISA_TAG_VENDOR_S = 0x0e,
+	ISA_TAG_END = 0x0f,
+	ISA_TAG_MEMRANGE = 0x81,
+	ISA_TAG_ANSIIDSTR = 0x82,
+	ISA_TAG_UNICODEIDSTR = 0x83,
+	ISA_TAG_VENDOR_L = 0x84,
+	ISA_TAG_MEM32RANGE = 0x85,
+	ISA_TAG_FIXEDMEM32RANGE = 0x86,
+	ISA_TAG_VPD_R = 0x90,
+	ISA_TAG_VPD_W = 0x91,
+};
+
 #if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 
 #define __ISAPNP__
Index: vpd-2.6/include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pci.h,v
retrieving revision 1.17
diff -u -p -r1.17 pci.h
--- vpd-2.6/include/linux/pci.h	13 Aug 2004 14:30:23 -0000	1.17
+++ vpd-2.6/include/linux/pci.h	24 Aug 2004 18:59:55 -0000
@@ -784,6 +784,8 @@ int pci_restore_state(struct pci_dev *de
 int pci_set_power_state(struct pci_dev *dev, int state);
 int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
 
+int pci_setup_vpd(struct pci_dev *dev);
+
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 void pci_bus_assign_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
