Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318941AbSICWBk>; Tue, 3 Sep 2002 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSICWBj>; Tue, 3 Sep 2002 18:01:39 -0400
Received: from smtp3.us.dell.com ([143.166.148.134]:56843 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S318941AbSICWAo>; Tue, 3 Sep 2002 18:00:44 -0400
Date: Tue, 3 Sep 2002 17:05:16 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Message-ID: <Pine.LNX.4.44.0209031616580.30474-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86 systems suffer from a disconnect between what BIOS believes is the
boot disk, and what Linux thinks BIOS thinks is the boot disk.  BIOS
Enhanced Disk Device Services (EDD) 3.0 provides the ability for disk
adapter BIOSs to tell the OS what it believes is the boot disk.  While
this isn't widely implemented in BIOSs yet (thus shouldn't be
completely trusted), it's time that Linux received support to be
ready as BIOSs with this feature do become available.

EDD works by providing the bus (PCI, PCI-X, ISA, InfiniBand, PCI
Express, or HyperTransport) location (e.g. PCI 02:01.0) and interface
(ATAPI, ATA, SCSI, USB, 1394, FibreChannel, I2O, RAID, SATA) location
(e.g. SCSI ID 5 LUN 0) information for each BIOS int13 device.  The
patch below creates CONFIG_EDD, that when defined, makes the calls to
retrieve and store this information.  It then exports it (yes, another
/proc, glad to change it to driverfs or whatever else when that makes
sense) in /proc/edd/{bios-device-number}, as such:

# ls /proc/edd/
80  81  82  83  84  85

# cat /proc/edd/80
host_bus_type: PCI 	02:01.0  channel: 0
interface_type: SCSI    	id: 0  lun: 0

Warning: Spec violation.  Key should be 0xBEDD, is 0xDDBE
Warning: Spec violation.  Padding should be 0x20, is 0x00

# cat /proc/edd/81
host_bus_type: PCI 	04:00.0  channel: 0
interface_type: SCSI    	id: 0  lun: 0

Warning: Spec violation.  Device Path checksum invalid (0x4b should be 0x00).

In the above case, BIOS int13 device 80 (the boot disk) believes it is
on PCI 02:01.0, SCSI bus 0, ID 0 LUN 0 (in this case it's an Adaptec
39160 add-in card).  Likewise, device 81 believes it's at PCI 04:00.0,
channel 0, ID 0, LUN 0 (a Dell PERC3/QC card).  In both cases the BIOS
vendors have some cleanup work to do, so I warn when they don't adhere
to the spec.

It's possible to query device drivers from user-space (either via a
SCSI ioctl, or IDE /proc/ide/*/config), to compare results to
determine which disk is the boot disk.

At most 6 BIOS devices are reported, as that fills the space that's
left in the empty_zero_page.  In general you only care about device
80h, though for software RAID1 knowing what 81h is might be useful also.

The major changes implemented in this patch:
arch/i386/boot/setup.S - int13 real mode calls store results in empty_zero_page
arch/i386/kernel/setup.c - copy results from empty_zero_page to local
storage
arch/i386/kernel/edd.c - export results via /proc/edd/

If you use this, please send reports of success/failure, and the
adapter types and BIOS versions, to edd30@domsch.com.  I'm keeping a
tally at http://domsch.com/linux/edd30/results.html.  If built as
CONFIG_EDD=m, please 'modprobe edd debug=1' and send those results -
it's more verbose.

Patch below applies to BK-current 2.5.x.  Also available in BitKeeper
at http://mdomsch.bkbits.net/linux-2.5-edd

Feedback appreciated.


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1-2/2002! (IDC Aug 2002)

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.582, 2002-09-03 15:05:38-05:00, Matt_Domsch@dell.com
  Initial release of x86 BIOS Enhanced Disk Device (EDD) polling


 Documentation/i386/zero-page.txt |    2 
 arch/i386/Config.help            |   10 
 arch/i386/boot/setup.S           |   46 +++
 arch/i386/config.in              |    4 
 arch/i386/defconfig              |    1 
 arch/i386/kernel/Makefile        |    1 
 arch/i386/kernel/edd.c           |  455 +++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/i386_ksyms.c    |    6 
 arch/i386/kernel/setup.c         |   23 +
 include/asm-i386/edd.h           |  162 +++++++++++++
 10 files changed, 710 insertions


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Tue Sep  3 15:06:13 2002
+++ b/Documentation/i386/zero-page.txt	Tue Sep  3 15:06:13 2002
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
diff -Nru a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/Config.help	Tue Sep  3 15:06:13 2002
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
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/boot/setup.S	Tue Sep  3 15:06:13 2002
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
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/config.in	Tue Sep  3 15:06:13 2002
@@ -181,6 +181,10 @@
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
 tristate '/dev/cpu/*/cpuid - CPU information support' CONFIG_X86_CPUID
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   tristate 'BIOS Enhanced Disk Device calls determine boot disk (EXPERIMENTAL)' CONFIG_EDD
+fi
+
 choice 'High Memory Support' \
 	"off           CONFIG_NOHIGHMEM \
 	 4GB           CONFIG_HIGHMEM4G \
diff -Nru a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/defconfig	Tue Sep  3 15:06:13 2002
@@ -69,6 +69,7 @@
 # CONFIG_MICROCODE is not set
 # CONFIG_X86_MSR is not set
 # CONFIG_X86_CPUID is not set
+# CONFIG_EDD is not set
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/kernel/Makefile	Tue Sep  3 15:06:13 2002
@@ -25,6 +25,7 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_EDD)             	+= edd.o
 ifdef CONFIG_VISWS
 obj-y += setup-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/edd.c	Tue Sep  3 15:06:13 2002
@@ -0,0 +1,455 @@
+/*
+ * BIOS Enhanced Disk Device Services
+ *
+ * Copyright (C) 2002 Dell Computer Corporation <Matt_Domsch@dell.com>
+ *
+ * This code takes information provided by BIOS EDD calls
+ * made in setup.S, copied to safe structures in setup.c,
+ * and presents it in /proc/edd/{bios_device_number}.
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
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <asm/edd.h>
+
+MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
+MODULE_DESCRIPTION("/proc interface to BIOS EDD information");
+MODULE_LICENSE("GPL");
+
+static int debug;
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Enable additional verbose debug output.");
+
+#define EDD_VERSION "0.01 2002-Sep-03"
+
+/* Don't need to keep a pointer to edd_info here because
+   it will get passed in to edd_read for us.
+*/
+struct edd_proc_info {
+	struct proc_dir_entry   *entry;
+	struct list_head        list;
+};
+
+static LIST_HEAD(edd_list);
+static spinlock_t edd_lock = SPIN_LOCK_UNLOCKED; /* protects edd_list */
+static struct proc_dir_entry *edd_dir;
+
+#define edd_entry(n) list_entry(n, struct edd_proc_info, list)
+
+
+
+static int
+proc_calc_metrics(char *page, char **start, off_t off,
+		  int count, int *eof, int len)
+{
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
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
+/***
+ * edd_read() - exports EDD information to /proc/edd/{device_number}
+ *
+ * Returns: number of bytes written, or -EINVAL on failure
+ */
+static int
+edd_read(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	int len = 0;
+	struct edd_info *edd=(struct edd_info *)data;
+        int i, warn_padding=0, nonzero_path=0, warn_key=0, warn_checksum=0;
+        uint8_t checksum=0, c=0;
+        char *p = page;
+        enum _bus_type {bus_type_unknown,
+                        isa, pci, pcix,
+			ibnd, xprs, htpt} bus_type = bus_type_unknown;
+        enum _interface_type {interface_type_unknown,
+                              ata, atapi, scsi, usb,
+                              i1394, fibre, i2o, raid, sata}
+        interface_type = interface_type_unknown; 
+
+	if (!data) {
+		*eof=1;
+		return 0;
+	}
+        
+	MOD_INC_USE_COUNT;
+
+	if (debug) {
+		p += edd_dump_raw_data(p, edd, sizeof(*edd));
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
+		len = (p + 1 - page);
+		MOD_DEC_USE_COUNT;
+		return proc_calc_metrics(page, start, off, count, eof, len);
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
+			len = (p + 1 - page);
+			MOD_DEC_USE_COUNT;
+			return proc_calc_metrics(page, start, off, count, eof, len);
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
+        len = (p + 1 - page);
+
+	MOD_DEC_USE_COUNT;
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+/**
+ * edd_create_proc_entry()
+ *
+ * Returns 1 on failure, 0 on success
+ */
+static int
+edd_create_proc_entry(struct edd_info *info)
+{
+
+	char name[4];
+	struct edd_proc_info *new_proc_info;
+
+	if (!info || !info->device) return 1;
+	new_proc_info = kmalloc(sizeof(*new_proc_info),
+				GFP_KERNEL);
+
+	if (!new_proc_info) return 1;
+	memset(new_proc_info, 0, sizeof(*new_proc_info));
+
+	snprintf(name, 4, "%02x", info->device);
+
+	/* Create the entry in proc */
+	new_proc_info->entry = create_proc_read_entry(name, 0444, edd_dir, edd_read, info);
+	if (!new_proc_info->entry) {
+		kfree(new_proc_info);
+		return 1;
+	}
+	spin_lock(&edd_lock);
+	list_add(&new_proc_info->list, &edd_list);
+	spin_unlock(&edd_lock);
+
+	return 0;
+}
+
+
+
+/**
+ * edd_init() - creates /proc/edd/{device} tree.
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
+	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n", EDD_VERSION, eddnr);
+	
+	if (!eddnr) {
+		printk(KERN_INFO "EDD information not available.\n");
+		return 1;
+	}
+
+	edd_dir = proc_mkdir("edd", edd_dir);
+	if (!edd_dir) return 1;
+
+	for (i=0; i<eddnr && i<EDDMAXNR; i++) {
+		edd_create_proc_entry(&edd[i]);
+	}
+	
+	return 0;
+}
+
+static void __exit
+edd_exit(void)
+{
+	struct list_head *pos, *n;
+	struct edd_proc_info *proc_info;
+
+	spin_lock(&edd_lock);
+	list_for_each_safe(pos, n, &edd_list) {
+		proc_info = edd_entry(pos);
+		remove_proc_entry(proc_info->entry->name, edd_dir);
+		list_del(&proc_info->list);
+		kfree(proc_info);
+	}
+	spin_unlock(&edd_lock);
+	remove_proc_entry(edd_dir->name, NULL);
+}
+
+late_initcall(edd_init);
+module_exit(edd_exit);
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Tue Sep  3 15:06:13 2002
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
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Sep  3 15:06:13 2002
+++ b/arch/i386/kernel/setup.c	Tue Sep  3 15:06:13 2002
@@ -36,6 +36,7 @@
 #include <linux/highmem.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
+#include <asm/edd.h>
 
 /*
  * Machine setup..
@@ -106,6 +107,8 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
 #define COMMAND_LINE_SIZE 256
 
@@ -486,6 +489,25 @@
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
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
@@ -631,6 +653,7 @@
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
 	setup_memory_region();
+	copy_edd();
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/edd.h	Tue Sep  3 15:06:13 2002
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

===================================================================


This BitKeeper patch contains the following changesets:
1.582
## Wrapped with gzip_uu ##


begin 664 bkpatch29651
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
@-D[;%`BLS5^S-[^O,`="LX-F*QA8`^,_5\L8?Q=Q````
`
end

