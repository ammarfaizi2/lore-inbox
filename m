Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbSJJD0T>; Wed, 9 Oct 2002 23:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbSJJD0T>; Wed, 9 Oct 2002 23:26:19 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:35243 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S263106AbSJJDZy>; Wed, 9 Oct 2002 23:25:54 -0400
Date: Wed, 9 Oct 2002 22:31:35 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@tux.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
cc: davej@suse.de, <alan@redhat.com>
Subject: Re: [PATCH] x86 BIOS Enhanced Disk Drive services
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68BC0284@AUSXMPC122.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0210092229070.9033-100000@tux.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch appended, and at:
 http://domsch.com/linux/edd30/edd-driverfs-6.patch
 http://domsch.com/linux/edd30/edd-driverfs-6.patch.sign

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/Documentation/i386/zero-page.txt linux-2.5-edd/Documentation/i386/zero-page.txt
--- linux-2.5/Documentation/i386/zero-page.txt	Wed Oct  9 15:01:16 2002
+++ linux-2.5-edd/Documentation/i386/zero-page.txt	Wed Oct  9 14:54:57 2002
@@ -31,6 +31,7 @@
 
 0x1e0	unsigned long	ALT_MEM_K, alternative mem check, in Kb
 0x1e8	char		number of entries in E820MAP (below)
+0x1e9	unsigned char	number of entries in EDDBUF (below)
 0x1f1	char		size of setup.S, number of sectors
 0x1f2	unsigned short	MOUNT_ROOT_RDONLY (if !=0)
 0x1f4	unsigned short	size of compressed kernel-part in the
@@ -66,6 +67,7 @@
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
 0x2d0 - 0x600		E820MAP
+0x600 - 0x7D4		EDDBUF (setup.S)
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/Config.help linux-2.5-edd/arch/i386/Config.help
--- linux-2.5/arch/i386/Config.help	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/Config.help	Wed Oct  9 14:54:59 2002
@@ -1075,3 +1075,11 @@
 
   This support is also available as a module.  If compiled as a
   module, it will be called scx200.o.
+
+CONFIG_EDD
+  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
+  Services real mode BIOS calls to determine which disk
+  BIOS tries boot from.  This information is then exported via driverfs.
+
+  This option is experimental, but believed to be safe,
+  and most disk controller BIOS vendors do not yet implement this feature.
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/boot/setup.S linux-2.5-edd/arch/i386/boot/setup.S
--- linux-2.5/arch/i386/boot/setup.S	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/boot/setup.S	Wed Oct  9 14:54:59 2002
@@ -44,6 +44,9 @@
  *
  * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
  * by Robert Schwebel, December 2001 <robert@schwebel.de>
+ *    
+ * BIOS Enhanced Disk Drive support
+ * by Matt Domsch <Matt_Domsch@dell.com> September 2002 
  *
  */
 
@@ -53,6 +56,7 @@
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
+#include <asm/edd.h>    
 #include <asm/page.h>
 	
 /* Signature words to ensure LILO loaded us right */
@@ -541,6 +545,49 @@
 no_32_apm_bios:
 	andw	$0xfffd, (76)			# remove 32 bit support bit
 done_apm_bios:
+#endif
+
+#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+# Do the BIOS Enhanced Disk Drive calls
+# This code is sensitive to the size of the structs in edd.h
+edd_start:  
+						# %ds points to the bootsector
+       						# result buffer for fn48
+    	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
+						# kept just before that    
+	movb	$0, (EDDNR)			# zero value at EDDNR
+    	movb	$0x80, %dl			# BIOS device 0x80
+
+edd_check_ext:
+	movb	$0x41, %ah			# Function 41
+	movw	$0x55aa, %bx			# magic
+	int	$0x13				# make the call
+	jc	edd_done			# no more BIOS devices
+
+    	cmpw	$0xAA55, %bx			# is magic right?
+	jne	edd_next			# nope, next...
+
+    	movb	%dl, %ds:-4(%si)		# store device number
+    	movb	%ah, %ds:-3(%si)		# store version
+	movw	%cx, %ds:-2(%si)		# store extensions
+	incb	(EDDNR)				# note that we stored something
+        
+edd_get_device_params:  
+	movw	$EDDPARMSIZE, %ds:(%si)		# put size
+    	movb	$0x48, %ah			# Function 48
+	int	$0x13				# make the call
+						# Don't check for fail return
+						# it doesn't matter.
+	movw	%si, %ax			# increment si
+	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
+	movw	%ax, %si
+
+edd_next:
+        incb	%dl				# increment to next device
+       	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
+	jb	edd_check_ext			# keep looping
+    
+edd_done:   
 #endif
 
 # Now we want to move to protected mode ...
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/config.in linux-2.5-edd/arch/i386/config.in
--- linux-2.5/arch/i386/config.in	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/config.in	Wed Oct  9 14:54:59 2002
@@ -215,6 +215,10 @@
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
 tristate '/dev/cpu/*/cpuid - CPU information support' CONFIG_X86_CPUID
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   tristate 'BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTAL)' CONFIG_EDD
+fi
+
 choice 'High Memory Support' \
 	"off           CONFIG_NOHIGHMEM \
 	 4GB           CONFIG_HIGHMEM4G \
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/defconfig linux-2.5-edd/arch/i386/defconfig
--- linux-2.5/arch/i386/defconfig	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/defconfig	Wed Oct  9 14:54:59 2002
@@ -70,6 +70,7 @@
 # CONFIG_MICROCODE is not set
 # CONFIG_X86_MSR is not set
 # CONFIG_X86_CPUID is not set
+# CONFIG_EDD is not set
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/Makefile linux-2.5-edd/arch/i386/kernel/Makefile
--- linux-2.5/arch/i386/kernel/Makefile	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/kernel/Makefile	Wed Oct  9 14:54:59 2002
@@ -26,6 +26,7 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
+obj-$(CONFIG_EDD)             	+= edd.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/edd.c linux-2.5-edd/arch/i386/kernel/edd.c
--- linux-2.5/arch/i386/kernel/edd.c	Wed Dec 31 18:00:00 1969
+++ linux-2.5-edd/arch/i386/kernel/edd.c	Wed Oct  9 14:54:59 2002
@@ -0,0 +1,984 @@
+/*
+ * linux/arch/i386/kernel/edd.c
+ *  Copyright (C) 2002 Dell Computer Corporation
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *
+ * BIOS Enhanced Disk Drive Services (EDD)
+ * conformant to T13 Committee www.t13.org
+ *   projects 1572D, 1484D, 1386D, 1226DT
+ *
+ * This code takes information provided by BIOS EDD calls
+ * fn41 - Check Extensions Present and
+ * fn48 - Get Device Parametes with EDD extensions
+ * made in setup.S, copied to safe structures in setup.c,
+ * and presents it in driverfs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Known issues:
+ * - module unload leaves a directory around.  Seems related to
+ *   creating symlinks in that directory.  Seen on kernel 2.5.41.
+ * - refcounting of struct device objects could be improved.
+ *
+ * TODO:
+ * - Add IDE and USB disk device support
+ * - when driverfs model of discs and partitions changes,
+ *   update symlink accordingly.
+ * - Get symlink creator helper functions exported from
+ *   drivers/base instead of duplicating them here.
+ * - move edd.[ch] to better locations if/when one is decided
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/driverfs_fs.h>
+#include <linux/pci.h>
+#include <asm/edd.h>
+#include <linux/device.h>
+#include <linux/blkdev.h>
+/* FIXME - this really belongs in include/scsi/scsi.h */
+#include <../drivers/scsi/scsi.h>
+#include <../drivers/scsi/hosts.h>
+
+MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
+MODULE_DESCRIPTION("driverfs interface to BIOS EDD information");
+MODULE_LICENSE("GPL");
+
+#define EDD_VERSION "0.06 2002-Oct-09"
+#define EDD_DEVICE_NAME_SIZE 16
+#define REPORT_URL "http://domsch.com/linux/edd30/results.html"
+
+/*
+ * bios_dir may go away completely,
+ * and it definitely won't be at the root
+ * of driverfs forever.
+ */
+static struct driver_dir_entry bios_dir = {
+	.name = "bios",
+	.mode = (S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO),
+};
+
+struct edd_device {
+	char name[EDD_DEVICE_NAME_SIZE];
+	struct edd_info *info;
+	struct list_head node;
+	struct driver_dir_entry dir;
+};
+
+struct edd_attribute {
+	struct attribute attr;
+	ssize_t(*show) (struct edd_device * edev, char *buf, size_t count,
+			loff_t off);
+};
+
+/* forward declarations */
+static int edd_dev_is_type(struct edd_device *edev, const char *type);
+static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
+static struct scsi_device *edd_find_matching_scsi_device(struct edd_device *edev);
+
+static struct edd_device *edd_devices[EDDMAXNR];
+
+#define EDD_DEVICE_ATTR(_name,_mode,_show) \
+struct edd_attribute edd_attr_##_name = { 	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,				\
+};
+
+static inline struct edd_info *
+edd_dev_get_info(struct edd_device *edev)
+{
+	return edev->info;
+}
+static inline void
+edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
+{
+	edev->info = info;
+}
+
+#define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
+#define to_edd_device(_dir) container_of(_dir,struct edd_device,dir)
+
+static ssize_t
+edd_attr_show(struct driver_dir_entry *dir, struct attribute *attr,
+	      char *buf, size_t count, loff_t off)
+{
+	struct edd_device *dev = to_edd_device(dir);
+	struct edd_attribute *edd_attr = to_edd_attr(attr);
+	ssize_t ret = 0;
+
+	if (edd_attr->show)
+		ret = edd_attr->show(dev, buf, count, off);
+	return ret;
+}
+
+static struct driverfs_ops edd_attr_ops = {
+	.show = edd_attr_show,
+};
+
+static int
+edd_dump_raw_data(char *b, void *data, int length)
+{
+	char *orig_b = b;
+	char buffer1[80], buffer2[80], *b1, *b2, c;
+	unsigned char *p = data;
+	unsigned long column = 0;
+	int length_printed = 0;
+	const char maxcolumn = 16;
+	while (length_printed < length) {
+		b1 = buffer1;
+		b2 = buffer2;
+		for (column = 0;
+		     column < maxcolumn && length_printed < length; column++) {
+			b1 += sprintf(b1, "%02x ", (unsigned char) *p);
+			if (*p < 32 || *p > 126)
+				c = '.';
+			else
+				c = *p;
+			b2 += sprintf(b2, "%c", c);
+			p++;
+			length_printed++;
+		}
+		/* pad out the line */
+		for (; column < maxcolumn; column++) {
+			b1 += sprintf(b1, "   ");
+			b2 += sprintf(b2, " ");
+		}
+
+		b += sprintf(b, "%s\t%s\n", buffer1, buffer2);
+	}
+	return (b - orig_b);
+}
+
+static ssize_t
+edd_show_host_bus(struct edd_device *edev, char *buf, size_t count, loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	int i;
+
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (isprint(info->params.host_bus_type[i])) {
+			p += sprintf(p, "%c", info->params.host_bus_type[i]);
+		} else {
+			p += sprintf(p, " ");
+		}
+	}
+
+	if (!strncmp(info->params.host_bus_type, "ISA", 3)) {
+		p += sprintf(p, "\tbase_address: %x\n",
+			     info->params.interface_path.isa.base_address);
+	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
+		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
+		p += sprintf(p,
+			     "\t%02x:%02x.%01x  channel: %u\n",
+			     info->params.interface_path.pci.bus,
+			     info->params.interface_path.pci.slot,
+			     info->params.interface_path.pci.function,
+			     info->params.interface_path.pci.channel);
+	} else if (!strncmp(info->params.host_bus_type, "IBND", 4) ||
+		   !strncmp(info->params.host_bus_type, "XPRS", 4) ||
+		   !strncmp(info->params.host_bus_type, "HTPT", 4)) {
+		p += sprintf(p,
+			     "\tTBD: %llx\n",
+			     info->params.interface_path.ibnd.reserved);
+
+	} else {
+		p += sprintf(p, "\tunknown: %llx\n",
+			     info->params.interface_path.unknown.reserved);
+	}
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_interface(struct edd_device *edev, char *buf, size_t count, loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	int i;
+
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	for (i = 0; i < 8; i++) {
+		if (isprint(info->params.interface_type[i])) {
+			p += sprintf(p, "%c", info->params.interface_type[i]);
+		} else {
+			p += sprintf(p, " ");
+		}
+	}
+	if (!strncmp(info->params.interface_type, "ATAPI", 5)) {
+		p += sprintf(p, "\tdevice: %u  lun: %u\n",
+			     info->params.device_path.atapi.device,
+			     info->params.device_path.atapi.lun);
+	} else if (!strncmp(info->params.interface_type, "ATA", 3)) {
+		p += sprintf(p, "\tdevice: %u\n",
+			     info->params.device_path.ata.device);
+	} else if (!strncmp(info->params.interface_type, "SCSI", 4)) {
+		p += sprintf(p, "\tid: %u  lun: %llu\n",
+			     info->params.device_path.scsi.id,
+			     info->params.device_path.scsi.lun);
+	} else if (!strncmp(info->params.interface_type, "USB", 3)) {
+		p += sprintf(p, "\tserial_number: %llx\n",
+			     info->params.device_path.usb.serial_number);
+	} else if (!strncmp(info->params.interface_type, "1394", 4)) {
+		p += sprintf(p, "\teui: %llx\n",
+			     info->params.device_path.i1394.eui);
+	} else if (!strncmp(info->params.interface_type, "FIBRE", 5)) {
+		p += sprintf(p, "\twwid: %llx lun: %llx\n",
+			     info->params.device_path.fibre.wwid,
+			     info->params.device_path.fibre.lun);
+	} else if (!strncmp(info->params.interface_type, "I2O", 3)) {
+		p += sprintf(p, "\tidentity_tag: %llx\n",
+			     info->params.device_path.i2o.identity_tag);
+	} else if (!strncmp(info->params.interface_type, "RAID", 4)) {
+		p += sprintf(p, "\tidentity_tag: %x\n",
+			     info->params.device_path.raid.array_number);
+	} else if (!strncmp(info->params.interface_type, "SATA", 4)) {
+		p += sprintf(p, "\tdevice: %u\n",
+			     info->params.device_path.sata.device);
+	} else {
+		p += sprintf(p, "\tunknown: %llx %llx\n",
+			     info->params.device_path.unknown.reserved1,
+			     info->params.device_path.unknown.reserved2);
+	}
+
+	return (p - buf);
+}
+
+/**
+ * edd_show_raw_data() - unparses EDD information, returned to user-space
+ *
+ * Returns: number of bytes written, or 0 on failure
+ */
+static ssize_t
+edd_show_raw_data(struct edd_device *edev, char *buf, size_t count, loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	int i, rc, warn_padding = 0, email = 0, nonzero_path = 0,
+		len = sizeof (*edd) - 4, found_pci=0;
+	uint8_t checksum = 0, c = 0;
+	char *p = buf;
+	struct pci_dev *pci_dev=NULL;
+	struct scsi_device *sd;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE))
+		len = info->params.length;
+
+	p += sprintf(p, "int13 fn48 returned data:\n\n");
+	p += edd_dump_raw_data(p, ((char *) edd) + 4, len);
+
+	/* Spec violation.  Adaptec AIC7899 returns 0xDDBE
+	   here, when it should be 0xBEDD.
+	 */
+	p += sprintf(p, "\n");
+	if (info->params.key == 0xDDBE) {
+		p += sprintf(p,
+			     "Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE\n");
+		email++;
+	}
+
+	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE)) {
+		goto out;
+	}
+
+	for (i = 30; i <= 73; i++) {
+		c = *(((uint8_t *) edd) + i + 4);
+		if (c)
+			nonzero_path++;
+		checksum += c;
+	}
+
+	if (checksum) {
+		p += sprintf(p,
+			     "Warning: Spec violation.  Device Path checksum invalid.\n");
+		email++;
+	}
+
+	if (!nonzero_path) {
+		p += sprintf(p, "Error: Spec violation.  Empty device path.\n");
+		email++;
+		goto out;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (!isprint(info->params.host_bus_type[i])) {
+			warn_padding++;
+		}
+	}
+	for (i = 0; i < 8; i++) {
+		if (!isprint(info->params.interface_type[i])) {
+			warn_padding++;
+		}
+	}
+
+	if (warn_padding) {
+		p += sprintf(p,
+			     "Warning: Spec violation.  Padding should be 0x20.\n");
+		email++;
+	}
+
+	rc = edd_dev_is_type(edev, "PCI");
+	if (!rc) {
+		pci_dev = pci_find_slot(info->params.interface_path.pci.bus,
+					PCI_DEVFN(info->params.interface_path.
+						  pci.slot,
+						  info->params.interface_path.
+						  pci.function));
+		if (!pci_dev) {
+			p += sprintf(p, "Error: BIOS says this is a PCI device, but the OS doesn't know\n");
+			p += sprintf(p, "  about a PCI device at %02x:%02x.%01x\n",
+				     info->params.interface_path.pci.bus,
+				     info->params.interface_path.pci.slot,
+				     info->params.interface_path.pci.function);
+			email++;
+		}
+		else {
+			found_pci++;
+		}
+	}
+
+	if (found_pci) {
+		sd = edd_find_matching_scsi_device(edev);
+		if (!sd) {
+			p += sprintf(p, "Error: BIOS says this is a SCSI device, but\n");
+			p += sprintf(p, "  the OS doesn't know about this SCSI device.\n");
+			p += sprintf(p, "  Do you have it's driver module loaded?\n");
+			email++;
+		}
+	}
+
+out:
+	if (email) {
+		p += sprintf(p, "\nPlease check %s\n", REPORT_URL);
+		p += sprintf(p, "to see if this has been reported.  If not,\n");
+		p += sprintf(p, "please send the information requested there.\n");
+	}
+
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_version(struct edd_device *edev, char *buf, size_t count, loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	p += sprintf(p, "0x%02x\n", info->version);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_extensions(struct edd_device *edev, char *buf, size_t count,
+		    loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
+		p += sprintf(p, "Fixed disk access\n");
+	}
+	if (info->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
+		p += sprintf(p, "Device locking and ejecting\n");
+	}
+	if (info->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
+		p += sprintf(p, "Enhanced Disk Drive support\n");
+	}
+	if (info->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
+		p += sprintf(p, "64-bit extensions\n");
+	}
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_info_flags(struct edd_device *edev, char *buf, size_t count,
+		    loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	if (info->params.info_flags & EDD_INFO_DMA_BOUNDRY_ERROR_TRANSPARENT)
+		p += sprintf(p, "DMA boundry error transparent\n");
+	if (info->params.info_flags & EDD_INFO_GEOMETRY_VALID)
+		p += sprintf(p, "geometry valid\n");
+	if (info->params.info_flags & EDD_INFO_REMOVABLE)
+		p += sprintf(p, "removable\n");
+	if (info->params.info_flags & EDD_INFO_WRITE_VERIFY)
+		p += sprintf(p, "write verify\n");
+	if (info->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
+		p += sprintf(p, "media change notification\n");
+	if (info->params.info_flags & EDD_INFO_LOCKABLE)
+		p += sprintf(p, "lockable\n");
+	if (info->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
+		p += sprintf(p, "no media present\n");
+	if (info->params.info_flags & EDD_INFO_USE_INT13_FN50)
+		p += sprintf(p, "use int13 fn50\n");
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_cylinders(struct edd_device *edev, char *buf, size_t count,
+			   loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	p += sprintf(p, "0x%x\n", info->params.num_default_cylinders);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_heads(struct edd_device *edev, char *buf, size_t count,
+		       loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	p += sprintf(p, "0x%x\n", info->params.num_default_heads);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_sectors_per_track(struct edd_device *edev, char *buf,
+				   size_t count, loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	p += sprintf(p, "0x%x\n", info->params.sectors_per_track);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_sectors(struct edd_device *edev, char *buf, size_t count, loff_t off)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	char *p = buf;
+	if (!edev || !info || !buf || off) {
+		return 0;
+	}
+
+	p += sprintf(p, "0x%llx\n", info->params.number_of_sectors);
+	return (p - buf);
+}
+
+static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data);
+static EDD_DEVICE_ATTR(version, 0444, edd_show_version);
+static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions);
+static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags);
+static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders);
+static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads);
+static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
+		       edd_show_default_sectors_per_track);
+static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors);
+static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface);
+static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus);
+
+/*
+ * Some device instances may not have all the above attributes,
+ * or the attribute values may be meaningless (i.e. if
+ * the device is < EDD 3.0, it won't have host_bus and interface
+ * information), so don't bother making files for them.  Likewise
+ * if the default_{cylinders,heads,sectors_per_track} values
+ * are zero, the BIOS doesn't provide sane values, don't bother
+ * creating files for them either.
+ *
+ * struct attr_test pairs an attribute and a test,
+ * (the default NULL test being true - the attribute exists)
+ * and individual existence tests may be written for each
+ * attribute.
+ */
+struct attr_test {
+	struct edd_attribute *attr;
+	int (*test) (struct edd_device * edev);
+};
+
+static int
+edd_has_default_cylinders(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 1;
+	return !info->params.num_default_cylinders;
+}
+
+static int
+edd_has_default_heads(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 1;
+	return !info->params.num_default_heads;
+}
+
+static int
+edd_has_default_sectors_per_track(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 1;
+	return !info->params.sectors_per_track;
+}
+
+static int
+edd_has_edd30(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	int i, nonzero_path = 0;
+	char c;
+
+	if (!edev || !info)
+		return 1;
+
+	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE)) {
+		return 1;
+	}
+
+	for (i = 30; i <= 73; i++) {
+		c = *(((uint8_t *) edd) + i + 4);
+		if (c) {
+			nonzero_path++;
+			break;
+		}
+	}
+	if (!nonzero_path) {
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct attr_test def_attrs[] = {
+	{.attr = &edd_attr_raw_data},
+	{.attr = &edd_attr_version},
+	{.attr = &edd_attr_extensions},
+	{.attr = &edd_attr_info_flags},
+	{.attr = &edd_attr_sectors},
+	{.attr = &edd_attr_default_cylinders,
+	 .test = &edd_has_default_cylinders},
+	{.attr = &edd_attr_default_heads,
+	 .test = &edd_has_default_heads},
+	{.attr = &edd_attr_default_sectors_per_track,
+	 .test = &edd_has_default_sectors_per_track},
+	{.attr = &edd_attr_interface,
+	 .test = &edd_has_edd30},
+	{.attr = &edd_attr_host_bus,
+	 .test = &edd_has_edd30},
+	{.attr = NULL,.test = NULL},
+};
+
+/* edd_get_devpath_length(), edd_fill_devpath(), and edd_device_link()
+   were taken from linux/drivers/base/fs/device.c.  When these
+   or similar are exported to generic code, remove these.
+*/
+
+static int
+edd_get_devpath_length(struct device *dev)
+{
+	int length = 1;
+	struct device *parent = dev;
+
+	/* walk up the ancestors until we hit the root.
+	 * Add 1 to strlen for leading '/' of each level.
+	 */
+	do {
+		length += strlen(parent->bus_id) + 1;
+		parent = parent->parent;
+	} while (parent);
+	return length;
+}
+
+static void
+edd_fill_devpath(struct device *dev, char *path, int length)
+{
+	struct device *parent;
+	--length;
+	for (parent = dev; parent; parent = parent->parent) {
+		int cur = strlen(parent->bus_id);
+
+		/* back up enough to print this bus id with '/' */
+		length -= cur;
+		strncpy(path + length, parent->bus_id, cur);
+		*(path + --length) = '/';
+	}
+}
+
+static int
+edd_device_symlink(struct edd_device *edev, struct device *dev, char *name)
+{
+	char *path;
+	int length;
+	int error = 0;
+
+	if (!dev->bus || !name)
+		return 0;
+
+	length = edd_get_devpath_length(dev);
+
+	/* now add the path from the edd_device directory
+	 * It should be '../..' (one to get to the 'bios' directory,
+	 * and one to get to the root of the fs.)
+	 */
+	length += strlen("../../root");
+
+	if (length > PATH_MAX)
+		return -ENAMETOOLONG;
+
+	if (!(path = kmalloc(length, GFP_KERNEL)))
+		return -ENOMEM;
+	memset(path, 0, length);
+
+	/* our relative position */
+	strcpy(path, "../../root");
+
+	edd_fill_devpath(dev, path, length);
+	error = driverfs_create_symlink(&edev->dir, name, path);
+	kfree(path);
+	return error;
+}
+
+/**
+ * edd_dev_is_type() - is this EDD device a 'type' device?
+ * @edev
+ * @type - a host bus or interface identifier string per the EDD spec
+ *
+ * Returns 0 if it is a 'type' device, nonzero otherwise.
+ */
+static int
+edd_dev_is_type(struct edd_device *edev, const char *type)
+{
+	int rc;
+	struct edd_info *info = edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 1;
+
+	rc = strncmp(info->params.host_bus_type, type, strlen(type));
+	if (!rc)
+		return 0;
+
+	return strncmp(info->params.interface_type, type, strlen(type));
+}
+
+/**
+ * edd_get_pci_dev() - finds pci_dev that matches edev
+ * @edev - edd_device
+ *
+ * Returns pci_dev if found, or NULL
+ */
+static struct pci_dev *
+edd_get_pci_dev(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	int rc;
+
+	rc = edd_dev_is_type(edev, "PCI");
+	if (rc)
+		return NULL;
+
+	return pci_find_slot(info->params.interface_path.pci.bus,
+			     PCI_DEVFN(info->params.interface_path.pci.slot,
+				       info->params.interface_path.pci.
+				       function));
+}
+
+static int
+edd_create_symlink_to_pcidev(struct edd_device *edev)
+{
+
+	struct pci_dev *pci_dev = edd_get_pci_dev(edev);
+	if (!pci_dev)
+		return 1;
+	return edd_device_symlink(edev, &pci_dev->dev, "pci_dev");
+}
+
+/**
+ * edd_match_scsidev()
+ * @edev - EDD device is a known SCSI device
+ * @sd - scsi_device with host who's parent is a PCI controller
+ * 
+ * returns 0 on success, 1 on failure
+ */
+static int
+edd_match_scsidev(struct edd_device *edev, struct scsi_device *sd)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+
+	if (!edev || !sd || !info)
+		return 1;
+
+	if ((sd->channel == info->params.interface_path.pci.channel) &&
+	    (sd->id == info->params.device_path.scsi.id) &&
+	    (sd->lun == info->params.device_path.scsi.lun)) {
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * edd_find_matching_device()
+ * @edev - edd_device to match
+ *
+ * Returns struct scsi_device * on success,
+ * or NULL on failure.
+ * This assumes that all children of the PCI controller
+ * are scsi_hosts, and that all children of scsi_hosts
+ * are scsi_devices.
+ * The reference counting probably isn't the best it could be.
+ */
+
+#define	to_scsi_host(d)	\
+	container_of(d, struct Scsi_Host, host_driverfs_dev)
+#define children_to_dev(n) container_of(n,struct device,node)
+static struct scsi_device *
+edd_find_matching_scsi_device(struct edd_device *edev)
+{
+	struct list_head *shost_node, *sdev_node;
+	int rc = 1;
+	struct scsi_device *sd = NULL;
+	struct device *shost_dev, *sdev_dev;
+	struct pci_dev *pci_dev;
+	struct Scsi_Host *sh;
+
+	rc = edd_dev_is_type(edev, "SCSI");
+	if (rc)
+		return NULL;
+
+	pci_dev = edd_get_pci_dev(edev);
+	if (!pci_dev)
+		return NULL;
+
+	get_device(&pci_dev->dev);
+
+	list_for_each(shost_node, &pci_dev->dev.children) {
+		shost_dev = children_to_dev(shost_node);
+		get_device(shost_dev);
+		sh = to_scsi_host(shost_dev);
+
+		list_for_each(sdev_node, &shost_dev->children) {
+			sdev_dev = children_to_dev(sdev_node);
+			get_device(sdev_dev);
+			sd = to_scsi_device(sdev_dev);
+			rc = edd_match_scsidev(edev, sd);
+			put_device(sdev_dev);
+			if (!rc)
+				break;
+		}
+		put_device(shost_dev);
+		if (!rc)
+			break;
+	}
+
+	put_device(&pci_dev->dev);
+	if (!rc)
+		return sd;
+	return NULL;
+}
+
+static int
+edd_create_symlink_to_scsidev(struct edd_device *edev)
+{
+
+	struct scsi_device *sdev;
+	struct pci_dev *pci_dev;
+	struct edd_info *info = edd_dev_get_info(edev);
+	int rc;
+
+	rc = edd_dev_is_type(edev, "PCI");
+	if (rc)
+		return rc;
+
+	pci_dev = pci_find_slot(info->params.interface_path.pci.bus,
+				PCI_DEVFN(info->params.interface_path.pci.slot,
+					  info->params.interface_path.pci.
+					  function));
+	if (!pci_dev)
+		return 1;
+
+	sdev = edd_find_matching_scsi_device(edev);
+	if (!sdev)
+		return 1;
+
+	get_device(&sdev->sdev_driverfs_dev);
+	rc = edd_device_symlink(edev, &sdev->sdev_driverfs_dev, "disc");
+	put_device(&sdev->sdev_driverfs_dev);
+
+	return rc;
+}
+
+static inline int
+edd_create_file(struct edd_device *edev, struct edd_attribute *attr)
+{
+	return driverfs_create_file(&attr->attr, &edev->dir);
+}
+
+static inline void
+edd_device_unregister(struct edd_device *edev)
+{
+	driverfs_remove_file(&edev->dir, "pci_dev");
+	driverfs_remove_file(&edev->dir, "disc");
+	driverfs_remove_dir(&edev->dir);
+	list_del_init(&edev->node);
+}
+
+static int
+edd_populate_dir(struct edd_device *edev)
+{
+	struct attr_test *s;
+	int i;
+	int error = 0;
+
+	for (i = 0; def_attrs[i].attr; i++) {
+		s = &def_attrs[i];
+		if (!s->test || (s->test && !s->test(edev))) {
+			if ((error = edd_create_file(edev, s->attr))) {
+				break;
+			}
+		}
+	}
+
+	if (error)
+		return error;
+
+	edd_create_symlink_to_pcidev(edev);
+	edd_create_symlink_to_scsidev(edev);
+
+	return 0;
+}
+
+static int
+edd_make_dir(struct edd_device *edev)
+{
+	int error;
+
+	edev->dir.name = edev->name;
+	edev->dir.mode = (S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+	edev->dir.ops = &edd_attr_ops;
+
+	error = driverfs_create_dir(&edev->dir, &bios_dir);
+	if (!error)
+		error = edd_populate_dir(edev);
+	return error;
+}
+
+static int
+edd_device_register(struct edd_device *edev, int i)
+{
+	int error;
+
+	if (!edev)
+		return 1;
+	memset(edev, 0, sizeof (*edev));
+	edd_dev_set_info(edev, &edd[i]);
+	snprintf(edev->name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x",
+		 edd[i].device);
+	error = edd_make_dir(edev);
+	return error;
+}
+
+/**
+ * edd_init() - creates driverfs tree of EDD data
+ *
+ * This assumes that eddnr and edd were
+ * assigned in setup.c already.
+ */
+static int __init
+edd_init(void)
+{
+	unsigned int i;
+	int rc;
+	struct edd_device *edev;
+
+	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
+	       EDD_VERSION, eddnr);
+
+	if (!eddnr) {
+		printk(KERN_INFO "EDD information not available.\n");
+		return 1;
+	}
+
+	rc = driverfs_create_dir(&bios_dir, NULL);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < eddnr && i < EDDMAXNR && !rc; i++) {
+		edev = kmalloc(sizeof (*edev), GFP_KERNEL);
+		if (!edev)
+			return -ENOMEM;
+
+		rc = edd_device_register(edev, i);
+		if (rc) {
+			kfree(edev);
+			break;
+		}
+		edd_devices[i] = edev;
+	}
+
+	if (rc) {
+		driverfs_remove_dir(&bios_dir);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void __exit
+edd_exit(void)
+{
+	int i;
+	struct edd_device *edev;
+
+	for (i = 0; i < eddnr && i < EDDMAXNR; i++) {
+		if ((edev = edd_devices[i])) {
+			edd_device_unregister(edev);
+			kfree(edev);
+		}
+	}
+
+	driverfs_remove_dir(&bios_dir);
+}
+
+late_initcall(edd_init);
+module_exit(edd_exit);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/i386_ksyms.c linux-2.5-edd/arch/i386/kernel/i386_ksyms.c
--- linux-2.5/arch/i386/kernel/i386_ksyms.c	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/kernel/i386_ksyms.c	Wed Oct  9 14:54:59 2002
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/edd.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -182,3 +183,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_EDD_MODULE
+EXPORT_SYMBOL(edd);
+EXPORT_SYMBOL(eddnr);
+#endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/setup.c linux-2.5-edd/arch/i386/kernel/setup.c
--- linux-2.5/arch/i386/kernel/setup.c	Wed Oct  9 15:01:18 2002
+++ linux-2.5-edd/arch/i386/kernel/setup.c	Wed Oct  9 14:54:59 2002
@@ -36,6 +36,7 @@
 #include <linux/highmem.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
+#include <asm/edd.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include "setup_arch_pre.h"
@@ -466,6 +467,22 @@
 	return 0;
 }
 
+#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+unsigned char eddnr;
+struct edd_info edd[EDDNR];
+/**
+ * copy_edd() - Copy the BIOS EDD information into a safe place.
+ *
+ */
+static inline void copy_edd(void)
+{
+     eddnr = EDD_NR;
+     memcpy(edd, EDD_BUF, sizeof(edd));
+}
+#else
+#define copy_edd() do {} while (0)
+#endif
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
@@ -843,6 +860,7 @@
 #endif
 	ARCH_SETUP
 	setup_memory_region();
+	copy_edd();
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/asm-i386/edd.h linux-2.5-edd/include/asm-i386/edd.h
--- linux-2.5/include/asm-i386/edd.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5-edd/include/asm-i386/edd.h	Wed Oct  9 14:55:28 2002
@@ -0,0 +1,168 @@
+/*
+ * linux/include/asm-i386/edd.h
+ *  Copyright (C) 2002 Dell Computer Corporation
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *
+ * structures and definitions for the int 13h, ax={41,48}h
+ * BIOS Enhanced Disk Drive Services
+ * This is based on the T13 group document D1572 Revision 0 (August 14 2002)
+ * available at http://www.t13.org/docs2002/d1572r0.pdf.  It is
+ * very similar to D1484 Revision 3 http://www.t13.org/docs2002/d1484r3.pdf
+ *
+ * In a nutshell, arch/i386/boot/setup.S populates a scratch table
+ * in the empty_zero_block that contains a list of BIOS-enumerated
+ * boot devices.
+ * In arch/i386/kernel/setup.c, this information is
+ * transferred into the edd structure, and in arch/i386/kernel/edd.c, that
+ * information is used to identify BIOS boot disk.  The code in setup.S
+ * is very sensitive to the size of these structures.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef _ASM_I386_EDD_H
+#define _ASM_I386_EDD_H
+
+#define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
+				   in empty_zero_block - treat this as 1 byte  */
+#define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
+#define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
+#define EDDEXTSIZE 4		/* change these if you muck with the structures */
+#define EDDPARMSIZE 74
+
+#ifndef __ASSEMBLY__
+
+#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
+#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
+#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
+#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
+
+#define EDD_INFO_DMA_BOUNDRY_ERROR_TRANSPARENT (1 << 0)
+#define EDD_INFO_GEOMETRY_VALID                (1 << 1)
+#define EDD_INFO_REMOVABLE                     (1 << 2)
+#define EDD_INFO_WRITE_VERIFY                  (1 << 3)
+#define EDD_INFO_MEDIA_CHANGE_NOTIFICATION     (1 << 4)
+#define EDD_INFO_LOCKABLE                      (1 << 5)
+#define EDD_INFO_NO_MEDIA_PRESENT              (1 << 6)
+#define EDD_INFO_USE_INT13_FN50                (1 << 7)
+
+struct edd_device_params {
+	u16 length;
+	u16 info_flags;
+	u32 num_default_cylinders;
+	u32 num_default_heads;
+	u32 sectors_per_track;
+	u64 number_of_sectors;
+	u16 bytes_per_sector;
+	u32 dpte_ptr;		/* 0xFFFFFFFF for our purposes */
+	u16 key;		/* = 0xBEDD */
+	u8 device_path_info_length;	/* = 44 */
+	u8 reserved2;
+	u16 reserved3;
+	u8 host_bus_type[4];
+	u8 interface_type[8];
+	union {
+		struct {
+			u16 base_address;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__ ((packed)) isa;
+		struct {
+			u8 bus;
+			u8 slot;
+			u8 function;
+			u8 channel;
+			u32 reserved;
+		} __attribute__ ((packed)) pci;
+		/* pcix is same as pci */
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) ibnd;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) xprs;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) htpt;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) unknown;
+	} interface_path;
+	union {
+		struct {
+			u8 device;
+			u8 reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) ata;
+		struct {
+			u8 device;
+			u8 lun;
+			u8 reserved1;
+			u8 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) atapi;
+		struct {
+			u16 id;
+			u64 lun;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__ ((packed)) scsi;
+		struct {
+			u64 serial_number;
+			u64 reserved;
+		} __attribute__ ((packed)) usb;
+		struct {
+			u64 eui;
+			u64 reserved;
+		} __attribute__ ((packed)) i1394;
+		struct {
+			u64 wwid;
+			u64 lun;
+		} __attribute__ ((packed)) fibre;
+		struct {
+			u64 identity_tag;
+			u64 reserved;
+		} __attribute__ ((packed)) i2o;
+		struct {
+			u32 array_number;
+			u32 reserved1;
+			u64 reserved2;
+		} __attribute((packed)) raid;
+		struct {
+			u8 device;
+			u8 reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) sata;
+		struct {
+			u64 reserved1;
+			u64 reserved2;
+		} __attribute__ ((packed)) unknown;
+	} device_path;
+	u8 reserved4;
+	u8 checksum;
+} __attribute__ ((packed));
+
+struct edd_info {
+	u8 device;
+	u8 version;
+	u16 interface_support;
+	struct edd_device_params params;
+} __attribute__ ((packed));
+
+extern struct edd_info edd[EDDNR];
+extern unsigned char eddnr;
+#endif				/*!__ASSEMBLY__ */
+
+#endif				/* _ASM_I386_EDD_H */
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/asm-i386/setup.h linux-2.5-edd/include/asm-i386/setup.h
--- linux-2.5/include/asm-i386/setup.h	Wed Oct  9 15:01:54 2002
+++ linux-2.5-edd/include/asm-i386/setup.h	Wed Oct  9 14:55:28 2002
@@ -37,6 +37,8 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
 #define COMMAND_LINE_SIZE 256
 

