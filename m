Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSILSoQ>; Thu, 12 Sep 2002 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSILSoQ>; Thu, 12 Sep 2002 14:44:16 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:45743 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S317005AbSILSnr>; Thu, 12 Sep 2002 14:43:47 -0400
Date: Thu, 12 Sep 2002 13:48:33 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Patrick Mochel <mochel@osdl.org>
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
In-Reply-To: <Pine.LNX.4.44.0209121022250.1057-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0209121323240.9156-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a perfect opportunity to unleash the concept of 
> device extensions on the world.

> If that's useful, and no one complains horribly about it, 
> I'll submit a patch to Linus.

I'd like to at least give it a shot, either before or after it's submitted 
to Linus.  Sounds like exactly what I want.

> > Then, one more request - giving back the ability to make a 
> > symlink given the device, not just a name.
>
> Yes, it's coming. :)

Cool, thanks.

To think briefly about submission plans for the EDD code.  Now
that it uses driverfs, and that code is in flux, I'd like to submit
what I've got now for inclusion in 2.5 (I haven't heard anyone object
to anything yet, though I doubt it's being used much either), and add
to it as time progresses.  Comments or objections?  Here's the current
patch against 2.5.x BK-current.

Patch: http://domsch.com/linux/edd30/edd-driverfs-2.patch
       http://domsch.com/linux/edd30/edd-driverfs-2.patch.sign
BK:    http://mdomsch.bkbits.net/linux-2.5-edd/

 Documentation/i386/zero-page.txt |    2
 arch/i386/Config.help            |   10
 arch/i386/boot/setup.S           |   46 +++
 arch/i386/config.in              |    4
 arch/i386/defconfig              |    1
 arch/i386/kernel/Makefile        |    1
 arch/i386/kernel/edd.c           |  527 +++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/i386_ksyms.c    |    6
 arch/i386/kernel/setup.c         |   20 +
 include/asm-i386/edd.h           |  162 +++++++++++
 include/asm-i386/setup.h         |    2
 11 files changed, 781 insertions

Of these, the bigger changes that touch files are:
 arch/i386/boot/setup.S   - Adding int13 calls
 arch/i386/kernel/setup.c - Copying data from empty_zero_page to
			     persistent structures
 arch/i386/kernel/edd.c   - The module which exports data to driverfs

Feedback welcome.

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/Documentation/i386/zero-page.txt linux-2.5-edd/Documentation/i386/zero-page.txt
--- linux-2.5/Documentation/i386/zero-page.txt	Tue Sep 10 11:41:37 2002
+++ linux-2.5-edd/Documentation/i386/zero-page.txt	Wed Sep 11 13:36:30 2002
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
--- linux-2.5/arch/i386/Config.help	Tue Sep 10 11:41:39 2002
+++ linux-2.5-edd/arch/i386/Config.help	Wed Sep 11 13:36:32 2002
@@ -967,3 +967,13 @@
   absence of features.
 
   For more information take a look at Documentation/swsusp.txt.
+
+CONFIG_EDD
+  Say Y or M here if you want to enable BIOS Enhanced Disk Device
+  Services real mode BIOS calls to determine which disk
+  BIOS tries boot from.  This feature creates a /proc/edd directory
+  and files for each BIOS device detected.
+
+  This option is experimental, and most disk controller BIOS
+  vendors do not yet implement this feature.
+
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/boot/setup.S linux-2.5-edd/arch/i386/boot/setup.S
--- linux-2.5/arch/i386/boot/setup.S	Tue Sep 10 11:41:39 2002
+++ linux-2.5-edd/arch/i386/boot/setup.S	Wed Sep 11 13:36:32 2002
@@ -44,6 +44,8 @@
  *
  * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
  * by Robert Schwebel, December 2001 <robert@schwebel.de>
+ *    
+ * BIOS EDD support September 2002 by Matt Domsch <Matt_Domsch@dell.com>
  *
  */
 
@@ -53,6 +55,7 @@
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
+#include <asm/edd.h>    
 #include <asm/page.h>
 	
 /* Signature words to ensure LILO loaded us right */
@@ -541,6 +544,49 @@
 no_32_apm_bios:
 	andw	$0xfffd, (76)			# remove 32 bit support bit
 done_apm_bios:
+#endif
+
+#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+# Do the BIOS EDD calls
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
--- linux-2.5/arch/i386/config.in	Wed Sep 11 10:55:34 2002
+++ linux-2.5-edd/arch/i386/config.in	Wed Sep 11 13:36:32 2002
@@ -196,6 +196,10 @@
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
 tristate '/dev/cpu/*/cpuid - CPU information support' CONFIG_X86_CPUID
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   tristate 'BIOS Enhanced Disk Device calls determine boot disk (EXPERIMENTAL)' CONFIG_EDD
+fi
+
 choice 'High Memory Support' \
 	"off           CONFIG_NOHIGHMEM \
 	 4GB           CONFIG_HIGHMEM4G \
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/defconfig linux-2.5-edd/arch/i386/defconfig
--- linux-2.5/arch/i386/defconfig	Tue Sep 10 11:41:39 2002
+++ linux-2.5-edd/arch/i386/defconfig	Wed Sep 11 13:36:32 2002
@@ -69,6 +69,7 @@
 # CONFIG_MICROCODE is not set
 # CONFIG_X86_MSR is not set
 # CONFIG_X86_CPUID is not set
+# CONFIG_EDD is not set
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/Makefile linux-2.5-edd/arch/i386/kernel/Makefile
--- linux-2.5/arch/i386/kernel/Makefile	Tue Sep 10 11:41:39 2002
+++ linux-2.5-edd/arch/i386/kernel/Makefile	Wed Sep 11 13:36:32 2002
@@ -26,6 +26,7 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
+obj-$(CONFIG_EDD)             	+= edd.o
 ifdef CONFIG_VISWS
 obj-y += setup-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/edd.c linux-2.5-edd/arch/i386/kernel/edd.c
--- linux-2.5/arch/i386/kernel/edd.c	Wed Dec 31 18:00:00 1969
+++ linux-2.5-edd/arch/i386/kernel/edd.c	Wed Sep 11 13:42:42 2002
@@ -0,0 +1,527 @@
+/*
+ * BIOS Enhanced Disk Device Services
+ *
+ * Copyright (C) 2002 Dell Computer Corporation <Matt_Domsch@dell.com>
+ *
+ * This code takes information provided by BIOS EDD calls
+ * made in setup.S, copied to safe structures in setup.c,
+ * and presents it in driverfs edd/{bios_device_number}/.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License v2.0 as published by
+ *  the Free Software Foundation
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
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
+#include <asm/edd.h>
+
+MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
+MODULE_DESCRIPTION("driverfs interface to BIOS EDD information");
+MODULE_LICENSE("GPL");
+
+static int debug;
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Enable additional verbose debug output.");
+
+#define EDD_VERSION "0.02 2002-Sep-10"
+
+struct edd_device {
+	char name[4];
+	char symlink_name[NAME_MAX];
+	char symlink_path[PATH_MAX];
+	struct edd_info          *info;
+	struct list_head          list;
+	struct driver_dir_entry   dir;
+};
+
+struct edd_attribute {
+	struct attribute  attr;
+	ssize_t (*show)(struct edd_device * device, char * buf, size_t count, loff_t off);
+};
+
+#define edd_entry(n) list_entry(n, struct edd_device, list)
+
+
+#define EDD_DEVICE_ATTR(_name,_mode,_show) \
+struct edd_attribute edd_attr_##_name = { 	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,				\
+};
+
+#define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
+
+#define to_edd_device(_dir) container_of(_dir,struct edd_device,dir)
+	
+
+static LIST_HEAD(edd_list);
+
+
+static struct driver_dir_entry edd_dir = {
+	.name	= "edd",
+	.mode	= (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO),
+};
+
+
+static ssize_t
+edd_attr_show(struct driver_dir_entry * dir, struct attribute * attr,
+	      char * buf, size_t count, loff_t off)
+{
+	struct edd_device * edd_dev = to_edd_device(dir);
+	struct edd_attribute * edd_attr = to_edd_attr(attr);
+	ssize_t ret = 0;
+
+	if (edd_attr->show)
+		ret = edd_attr->show(edd_dev,buf,count,off);
+	return ret;
+}
+
+static struct driverfs_ops edd_attr_ops = {
+	.show =	edd_attr_show,
+};
+
+
+
+static int
+edd_dump_raw_data(char *b, void *data, int length)
+{
+        char *orig_b = b;
+	char buffer1[80], buffer2[80], *b1, *b2, c;
+	unsigned char *p = data;
+	unsigned long column=0;
+	int length_printed = 0;
+	const char maxcolumn = 16;
+	while (length_printed < length) {
+		b1 = buffer1;
+		b2 = buffer2;
+		for (column = 0;
+		     column < maxcolumn && length_printed < length; 
+		     column ++) {
+			b1 += sprintf(b1, "%02x ",(unsigned char) *p);
+			if (*p < 32 || *p > 126) c = '.';
+			else c = *p;
+			b2 += sprintf(b2, "%c", c);
+			p++;
+			length_printed++;
+		}
+		/* pad out the line */
+		for (; column < maxcolumn; column++)
+		{
+			b1 += sprintf(b1, "   ");
+			b2 += sprintf(b2, " ");
+		}
+
+		b += sprintf(b, "%s\t%s\n", buffer1, buffer2);
+	}
+        return (b - orig_b);
+}
+
+
+
+
+
+/**
+ * edd_info_show() - unparses EDD information, returned to user-space
+ *
+ * Returns: number of bytes written, or 0 on failure
+ */
+static ssize_t
+edd_info_show(struct edd_device *dev, char *buf, size_t count, loff_t off)
+{
+	struct edd_info *edd=dev->info;
+        int i, warn_padding=0, nonzero_path=0, warn_key=0, warn_checksum=0;
+        uint8_t checksum=0, c=0;
+        char *p = buf;
+        enum _bus_type {bus_type_unknown,
+                        isa, pci, pcix,
+			ibnd, xprs, htpt} bus_type = bus_type_unknown;
+        enum _interface_type {interface_type_unknown,
+                              ata, atapi, scsi, usb,
+                              i1394, fibre, i2o, raid, sata}
+        interface_type = interface_type_unknown; 
+
+	if (!dev || !edd || !buf || off) {
+		return 0;
+	}
+        
+	if (debug) {
+		p += edd_dump_raw_data(p, edd, 4);
+		p += edd_dump_raw_data(p, ((char *)edd)+4, sizeof(*edd)-4);
+		
+		p += sprintf(p, "version: ");
+		switch (edd->version) {
+		case 0x0:
+			p += sprintf(p, "unsupported\n");
+		case 0x21: 
+			p += sprintf(p, "1.1\n");
+			break;
+		case 0x30:
+			p += sprintf(p, "3.0\n");
+			break;
+                default:
+                        p += sprintf(p, "(unknown version %xh)\n",
+                                     edd->version);
+                        break;
+		}
+		
+		p += sprintf(p, "Extensions:\n");
+		if (edd->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
+			p += sprintf(p, "\tFixed disk access\n");
+		}
+		if (edd->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
+			p += sprintf(p, "\tDevice locking and ejecting\n");
+		}
+		if (edd->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
+			p += sprintf(p, "\tEnhanced Disk Drive support\n");
+		}
+		if (edd->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
+			p += sprintf(p, "\t64-bit extensions\n");
+		}
+		
+		p += sprintf(p, "Info Flags:\n");
+		if (edd->params.info_flags & EDD_INFO_DMA_BOUNDRY_ERROR_TRANSPARENT)
+			p += sprintf(p, "\tdma_boundry_error_transparent\n");
+		if (edd->params.info_flags & EDD_INFO_GEOMETRY_VALID)
+			p += sprintf(p, "\tgeometry_valid\n");
+		if (edd->params.info_flags & EDD_INFO_REMOVABLE)
+			p += sprintf(p, "\tremovable\n");
+		if (edd->params.info_flags & EDD_INFO_WRITE_VERIFY)
+			p += sprintf(p, "\twrite_verify\n");
+		if (edd->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
+			p += sprintf(p, "\tmedia_change_notification\n"); 
+		if (edd->params.info_flags & EDD_INFO_LOCKABLE)
+			p += sprintf(p, "\tlockable\n");
+		if (edd->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
+			p += sprintf(p, "\tno_media_present\n");
+		if (edd->params.info_flags & EDD_INFO_USE_INT13_FN50)
+			p += sprintf(p, "\tuse_int13_fn50\n");
+		
+		p += sprintf(p, "num_default_cylinders: %x\n",
+			     edd->params.num_default_cylinders);
+		p += sprintf(p, "num_default_heads: %x\n", edd->params.num_default_heads);
+		p += sprintf(p, "sectors_per_track: %x\n", edd->params.sectors_per_track);
+		p += sprintf(p, "number_of_sectors: %llx\n",
+			     edd->params.number_of_sectors);
+	} /* if (debug) */
+
+        /* Spec violation here.  Adaptec AIC7899 returns 0xDDBE
+           here, when it should be (per spec) 0xBEDD.
+        */
+        if (edd->params.key == 0xDDBE) {
+		warn_key=1;
+        }
+
+        if (! (edd->params.key == 0xBEDD || edd->params.key == 0xDDBE)) {
+		return (p + 1 - buf);
+	}
+        
+        for (i=30; i<=73; i++) {
+		c = *(((uint8_t *)edd)+i+4);
+		if (c) nonzero_path++;
+                checksum += c;
+        }
+        if (checksum) {
+		warn_checksum=1;
+                if (!nonzero_path) {
+			p += sprintf(p, "Warning: Spec violation.  Device Path checksum invalid (0x%02x should be 0x00).\n", checksum);
+			
+			return (p + 1 - buf);
+		}
+        }
+        
+
+        /* Spec violation here.  Adaptec AIC7899 has 0x00 (NULL) bytes for 
+           padding instead of 0x20 (space) bytes. */
+
+        p += sprintf(p, "host_bus: ");
+        for (i=0; i<4; i++) {
+                if (isprint(edd->params.host_bus_type[i])) {
+                        p += sprintf(p, "%c", edd->params.host_bus_type[i]);
+                } else {
+                        p += sprintf(p, " ");
+                        warn_padding++;
+                }
+
+                
+        }
+
+        /* Print interface path information */
+        if (!strncmp(edd->params.host_bus_type, "ISA", 3)) {
+                bus_type = isa;
+        } else if (!strncmp(edd->params.host_bus_type, "PCIX", 4)) {
+                bus_type = pcix;
+        } else if (!strncmp(edd->params.host_bus_type, "PCI", 3)) {
+                bus_type = pci;
+        } else if (!strncmp(edd->params.host_bus_type, "IBND", 4)) {
+                bus_type = ibnd;
+        } else if (!strncmp(edd->params.host_bus_type, "XPRS", 4)) {
+                bus_type = xprs;
+        } else if (!strncmp(edd->params.host_bus_type, "HTPT", 4)) {
+                bus_type = htpt;
+        }
+        switch (bus_type) {
+        case isa:
+                p += sprintf(p, "\tbase_address: %x\n",
+                             edd->params.interface_path.isa.base_address);
+                break;
+        case pci:
+	case pcix:
+                p += sprintf(p,
+                             "\t%02x:%02x.%01x  channel: %x\n",
+                             edd->params.interface_path.pci.bus,
+                             edd->params.interface_path.pci.slot,
+                             edd->params.interface_path.pci.function,
+                             edd->params.interface_path.pci.channel);
+                break;
+	case ibnd:
+	case xprs:
+	case htpt:
+                p += sprintf(p,
+                             "\tTBD: %llx\n",
+                             edd->params.interface_path.ibnd.reserved);
+                break;
+        default:
+                p += sprintf(p, "\tunknown: %llx\n",
+                             edd->params.interface_path.unknown.reserved);
+                break;
+        }
+
+        /* Spec violation here.  Adaptec AIC7899 has 0x00 (NULL) bytes for 
+           padding instead of 0x20 (space) bytes. */
+        /* Print device path information */
+        p += sprintf(p, "interface: ");
+        for (i=0; i<8; i++) {
+                if (isprint(edd->params.interface_type[i])) {
+                        p += sprintf(p, "%c", edd->params.interface_type[i]);
+                } else {
+                        p += sprintf(p, " ");
+                        warn_padding++;
+                }
+        }
+        if (!strncmp(edd->params.interface_type, "ATAPI", 5)) {
+                interface_type = atapi;
+        } else if (!strncmp(edd->params.interface_type, "ATA", 3)) {
+                interface_type = ata;
+        } else if (!strncmp(edd->params.interface_type, "SCSI", 4)) {
+                interface_type = scsi;
+        } else if (!strncmp(edd->params.interface_type, "USB", 3)) {
+                interface_type = usb;
+        } else if (!strncmp(edd->params.interface_type, "1394", 4)) {
+                interface_type = i1394;
+        } else if (!strncmp(edd->params.interface_type, "FIBRE", 5)) {
+                interface_type = fibre;
+        } else if (!strncmp(edd->params.interface_type, "I2O", 3)) {
+                interface_type = i2o;
+        } else if (!strncmp(edd->params.interface_type, "RAID", 4)) {
+                interface_type = raid;
+        } else if (!strncmp(edd->params.interface_type, "SATA", 4)) {
+                interface_type = sata;
+        }
+
+
+        switch (interface_type) {
+        case ata:
+                p += sprintf(p, "\tdevice: %x\n",
+                             edd->params.device_path.ata.device);
+                break;
+        case atapi:
+                p += sprintf(p, "\tdevice: %x  lun: %x\n",
+                             edd->params.device_path.atapi.device,
+                             edd->params.device_path.atapi.lun);
+                break;
+        case scsi:
+                p += sprintf(p, "\tid: %x  lun: %llx\n",
+                             edd->params.device_path.scsi.id,
+                             edd->params.device_path.scsi.lun);
+                break;
+        case usb:
+                p += sprintf(p, "\tserial_number: %llx\n", 
+                             edd->params.device_path.usb.serial_number);
+                break;
+        case i1394:
+                p += sprintf(p, "\teui: %llx\n", 
+                             edd->params.device_path.i1394.eui);
+                break;
+        case fibre:
+                p += sprintf(p, "\twwid: %llx lun: %llx\n",
+                             edd->params.device_path.fibre.wwid,
+                             edd->params.device_path.fibre.lun);
+                break;
+        case i2o:
+                p += sprintf(p, "\tidentity_tag: %llx\n", 
+                             edd->params.device_path.i2o.identity_tag);
+                break;
+        case raid:
+                p += sprintf(p, "\tidentity_tag: %x\n", 
+                             edd->params.device_path.raid.array_number);
+                break;
+        case sata:
+                p += sprintf(p, "\tdevice: %x\n", 
+                             edd->params.device_path.sata.device);
+                break;
+        default:
+                p += sprintf(p, "\tunknown: %llx %llx\n",
+			     edd->params.device_path.unknown.reserved1,
+			     edd->params.device_path.unknown.reserved2);
+                             
+        }
+
+	p += sprintf(p, "\n");
+	if (warn_key) {
+                p += sprintf(p, "Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE\n");
+	}
+        if (warn_padding) {
+                p += sprintf(p, "Warning: Spec violation.  Padding should be 0x20, is 0x00\n");
+        }
+	if (warn_checksum) {
+                p += sprintf(p, "Warning: Spec violation.  Device Path checksum invalid (0x%02x should be 0x00).\n", checksum);
+	}
+
+	return (p + 1 - buf);
+}
+
+static EDD_DEVICE_ATTR(info,0444,edd_info_show);
+
+static struct edd_attribute * def_attrs[] = {
+	&edd_attr_info,
+	NULL,
+};
+
+static int
+edd_create_file(struct edd_device *dev, struct edd_attribute * attr)
+{
+	int error = -EINVAL;
+	if (dev)
+		error = driverfs_create_file(&attr->attr,&dev->dir);
+	return error;
+}
+
+static void
+edd_remove_file(struct edd_device *dev, struct edd_attribute * attr)
+{
+	if (dev)
+		driverfs_remove_file(&dev->dir,attr->attr.name);
+}
+
+static void edd_remove_dir(struct edd_device * dev)
+{
+	driverfs_remove_dir(&dev->dir);
+}
+
+
+static int edd_populate_dir(struct edd_device * dev)
+{
+	struct edd_attribute * attr;
+	int i;
+	int error = 0;
+	
+	for (i = 0; (attr = def_attrs[i]); i++) {
+		if ((error = edd_create_file(dev,attr))) {
+			edd_remove_dir(dev);
+			break;
+		}
+	}
+	return error;
+}
+
+static int edd_make_dir(struct edd_device * dev)
+{
+	int error;
+	
+	if (!dev) return 1;
+	dev->dir.name = dev->name;
+	dev->dir.ops = &edd_attr_ops;
+
+	error = driverfs_create_dir(&dev->dir,&edd_dir);
+	if (!error)
+		error = edd_populate_dir(dev);
+	return error;
+}
+
+static int edd_device_register(int i)
+{
+	int error;
+	struct edd_device *dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	
+	if (!dev) return 1;
+	memset(dev, 0, sizeof(*dev));
+	dev->info = &edd[i];
+	snprintf(dev->name, 4, "%02x", dev->info->device);
+
+	error = edd_make_dir(dev);
+	if (!error)
+		list_add_tail(&dev->list,&edd_list);
+	return error;
+}
+
+static void edd_device_unregister(struct edd_device * dev)
+{
+	struct edd_attribute * attr;
+	int i;
+	
+	for (i = 0; (attr = def_attrs[i]); i++) {
+		edd_remove_file(dev,attr);
+	}
+	edd_remove_dir(dev);
+	list_del_init(&dev->list);
+	kfree(dev);
+}
+
+/**
+ * edd_init() - creates driverfs edd/{device num}/ tree
+ *
+ * This assumes that eddnr and edd were
+ * assigned in setup.c already.
+ */
+static int __init
+edd_init(void)
+{
+
+	unsigned int i;
+
+	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
+	       EDD_VERSION, eddnr);
+	
+	if (!eddnr) {
+		printk(KERN_INFO "EDD information not available.\n");
+		return 1;
+	}
+
+	init_driverfs_fs();
+	driverfs_create_dir(&edd_dir,NULL);
+	for (i=0; i<eddnr && i<EDDMAXNR; i++) {
+		edd_device_register(i);
+	}
+	
+	return 0;
+}
+
+static void __exit
+edd_exit(void)
+{
+	struct list_head *pos, *n;
+	struct edd_device *dev;
+
+	list_for_each_safe(pos, n, &edd_list) {
+		dev = edd_entry(pos);
+		edd_device_unregister(dev);
+	}
+	driverfs_remove_dir(&edd_dir);
+}
+
+late_initcall(edd_init);
+module_exit(edd_exit);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/i386_ksyms.c linux-2.5-edd/arch/i386/kernel/i386_ksyms.c
--- linux-2.5/arch/i386/kernel/i386_ksyms.c	Tue Sep 10 11:41:39 2002
+++ linux-2.5-edd/arch/i386/kernel/i386_ksyms.c	Wed Sep 11 13:36:32 2002
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/edd.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -172,3 +173,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_EDD_MODULE
+EXPORT_SYMBOL(edd);
+EXPORT_SYMBOL(eddnr);
+#endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/kernel/setup.c linux-2.5-edd/arch/i386/kernel/setup.c
--- linux-2.5/arch/i386/kernel/setup.c	Tue Sep 10 11:41:39 2002
+++ linux-2.5-edd/arch/i386/kernel/setup.c	Wed Sep 11 13:36:32 2002
@@ -36,6 +36,7 @@
 #include <linux/highmem.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
+#include <asm/edd.h>
 #include <asm/setup.h>
 
 /*
@@ -462,6 +463,24 @@
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
+static inline void copy_edd(void)
+{
+}
+#endif
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
@@ -864,6 +883,7 @@
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
 	setup_memory_region();
+	copy_edd();
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/asm-i386/edd.h linux-2.5-edd/include/asm-i386/edd.h
--- linux-2.5/include/asm-i386/edd.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5-edd/include/asm-i386/edd.h	Wed Sep 11 13:36:56 2002
@@ -0,0 +1,162 @@
+/*
+ * linux/include/asm-i386/edd.h
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  Copyright 2002 Dell Computer Corporation
+ *
+ * structures and definitions for the int 13, ax={41,48}h
+ * BIOS Enhanced Disk Device Services
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
+ */
+#ifndef _ASM_I386_EDD_H
+#define _ASM_I386_EDD_H
+
+#define EDDNR 0x1e9	/* addr of number of edd_info structs at EDDBUF
+			   in empty_zero_block - treat this as 1 byte  */
+#define EDDBUF	0x600	/* addr of edd_info structs in empty_zero_block */
+#define EDDMAXNR 6	/* number of edd_info structs starting at EDDBUF  */
+#define EDDEXTSIZE 4    /* change these if you muck with the structures */   
+#define EDDPARMSIZE 74
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
+
+
+#ifndef __ASSEMBLY__
+
+struct edd_device_params {
+	u16 length;
+        u16 info_flags;
+	u32 num_default_cylinders;
+	u32 num_default_heads;
+	u32 sectors_per_track;
+	u64 number_of_sectors;
+	u16 bytes_per_sector;
+	u32 dpte_ptr;                /* 0xFFFFFFFF for our purposes */
+	u16 key;                     /* = 0xBEDD */
+	u8  device_path_info_length; /* = 44 */
+	u8  reserved2;
+	u16 reserved3;
+	u8 host_bus_type[4];
+	u8 interface_type[8];
+	union {
+		struct {
+			u16 base_address;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__((packed)) isa;
+		struct {
+			u8 bus;
+			u8 slot;
+			u8 function;
+			u8 channel;
+			u32 reserved;
+		} __attribute__((packed)) pci;
+		/* pcix is same as pci */
+		struct {
+			u64 reserved;
+		} __attribute__((packed)) ibnd;
+		struct {
+			u64 reserved;
+		} __attribute__((packed)) xprs;
+		struct {
+			u64 reserved;
+		} __attribute__((packed)) htpt;
+		struct {
+			u64 reserved;
+		} __attribute__((packed)) unknown;
+	} interface_path;
+	union {
+		struct {
+			u8  device;
+			u8  reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__((packed)) ata;
+		struct {
+			u8  device;
+			u8  lun;
+			u8  reserved1;
+			u8  reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__((packed)) atapi;
+		struct {
+			u16 id;
+			u64 lun;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__((packed)) scsi;
+		struct {
+			u64 serial_number;
+			u64 reserved;
+		} __attribute__((packed)) usb;
+		struct {
+			u64 eui;
+			u64 reserved;
+		} __attribute__((packed)) i1394;
+		struct {
+			u64 wwid;
+			u64 lun;
+		} __attribute__((packed)) fibre;
+		struct {
+			u64 identity_tag;
+			u64 reserved;
+		} __attribute__((packed)) i2o;
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
+		} __attribute__((packed)) sata;
+		struct {
+			u64 reserved1;
+			u64 reserved2;
+		} __attribute__((packed)) unknown;
+	} device_path;
+	u8 reserved4;
+	u8 checksum;
+} __attribute__((packed));
+
+struct edd_info {
+	u8 device;
+	u8 version;
+	u16 interface_support;
+	struct edd_device_params params;
+} __attribute__((packed));
+
+extern struct edd_info edd[EDDNR];
+extern unsigned char eddnr;
+#endif/*!__ASSEMBLY__*/
+
+#endif /* _ASM_I386_EDD_H */
+
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/asm-i386/setup.h linux-2.5-edd/include/asm-i386/setup.h
--- linux-2.5/include/asm-i386/setup.h	Tue Sep 10 11:42:10 2002
+++ linux-2.5-edd/include/asm-i386/setup.h	Wed Sep 11 13:36:56 2002
@@ -37,6 +37,8 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
 #define COMMAND_LINE_SIZE 256
 

