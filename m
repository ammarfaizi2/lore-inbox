Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277851AbRJIRPZ>; Tue, 9 Oct 2001 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277852AbRJIRPM>; Tue, 9 Oct 2001 13:15:12 -0400
Received: from smtp3.us.dell.com ([143.166.224.253]:6149 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S277851AbRJIROu>; Tue, 9 Oct 2001 13:14:50 -0400
Date: Tue, 9 Oct 2001 12:15:20 -0500 (CDT)
From: Matt Domsch <mdomsch@Dell.com>
X-X-Sender: <mdomsch@tux.us.dell.com>
To: <torvalds@transmeta.com>, <alan@redhat.com>
cc: "'Martin.Wilck@Fujitsu-Siemens.com'" 
	<Martin.Wilck@Fujitsu-Siemens.com>,
        "'viro@math.psu.edu'" <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] EFI GUID Partition Tables
Message-ID: <Pine.LNX.4.33.0110091210080.6027-100000@tux.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.33.0110091210082.6027@tux.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prompted by Al Viro's work to move the partition table handling code
from using block device access to using the page cache, I've pulled the
EFI GUID Partition Table (GPT) code from the IA-64 port patch and
updated it.  I would like to see it included in the Linus and -ac trees,
as it barely needs the IA-64 tree, and even then, only asm-ia64/efi.h
which is already merged.  David Mosberger is happy to have it dropped
from the IA-64 port.  This code has been in use on IA-64 for quite a
while now, so I feel confident that it works.  I've also used it quite a
bit on x86.  The devfs GUID support is by Martin Wilck.

Two patches are provided:
http://domsch.com/linux/patches/linux-2.4.10-ac10-gpt-20011009.patch
http://domsch.com/linux/patches/linux-2.4.11-pre5-gpt-20011009.patch

Aside from minor merge differences, the only code difference between the
two is that the -ac patch doesn't use the page cache, while the the
-pre5 patch does.  (the definition of struct Sector in
fs/partitions/check.h changed.)

 Documentation/Configure.help        |   12
 Documentation/kernel-parameters.txt |    4
 fs/devfs/base.c                     |   24 +
 fs/partitions/Config.in             |    2
 fs/partitions/Makefile              |    1
 fs/partitions/check.c               |  152 ++++++
 fs/partitions/efi.c                 |  788 ++++++++++++++++++++++++++++++++++
 fs/partitions/efi.h                 |  156 +++++++
 fs/partitions/msdos.c               |   14
 include/linux/crc32.h               |   17
 include/linux/devfs_fs_kernel.h     |    3
 include/linux/genhd.h               |    7
 lib/Makefile                        |    2
 lib/crc32.c                         |  125 +++++
 14 files changed, 1304 insertions, 3 deletions

To use this, enable CONFIG_PARTITION_ADVANCED and
CONFIG_EFI_PARTITION, and optionally (depending on your system setup),
CONFIG_DEVFS_GUID.  GNU Parted, 1.4.20-pre2 and above, includes the
ability to 'mklabel gpt' on a disk, and make partitions and file
systems.  Since GRUB is not (yet, volunteers?) GPT-aware, you
shouldn't partition your boot disk with GPT if you're using GRUB.
LILO should be just fine.

GPT allows for a virtually unlimited number of partitions (minimum
number of table entries is 128, with max based only on the size of your
disk), no extended or logical partitions are necessary, and each
partition is addressed by 64-bit logical block address of the device in
use.  There's a Protective MBR in the place of the normal MSDOS MBR at
block 0 on the disk, showing one partition of type 0xEE consuming the
whole disk, so that legacy partitioning tools can be aware that the disk
is partitioned using GPT.

Linus and Alan, please apply.  I'm appending the patch against
2.4.10-pre5, with hopes that my mailer won't mangle it too badly.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!


diff -burNp linux-2.4.11-pre5/Documentation/Configure.help linux-2.4.11-pre5.gpt/Documentation/Configure.help
--- linux-2.4.11-pre5/Documentation/Configure.help	Mon Oct  8 15:23:00 2001
+++ linux-2.4.11-pre5.gpt/Documentation/Configure.help	Mon Oct  8 15:17:57 2001
@@ -12701,6 +12701,18 @@ CONFIG_SGI_PARTITION
   Say Y here if you would like to be able to read the hard disk
   partition table format used by SGI machines.

+Intel EFI GUID partition support
+CONFIG_EFI_PARTITION
+  Say Y here if you would like to use hard disks under Linux which
+  were partitioned using EFI GPT.  Presently only useful on the
+  IA-64 platform.
+
+/dev/guid support (EXPERIMENTAL)
+CONFIG_DEVFS_GUID
+  Say Y here if you would like to access disks and partitions by
+  their Globally Unique Identifiers (GUIDs) which will appear as
+  symbolic links in /dev/guid.
+
 Ultrix partition support
 CONFIG_ULTRIX_PARTITION
   Say Y here if you would like to be able to read the hard disk
diff -burNp linux-2.4.11-pre5/Documentation/kernel-parameters.txt linux-2.4.11-pre5.gpt/Documentation/kernel-parameters.txt
--- linux-2.4.11-pre5/Documentation/kernel-parameters.txt	Wed Jun 20 13:21:33 2001
+++ linux-2.4.11-pre5.gpt/Documentation/kernel-parameters.txt	Mon Oct  8 15:17:57 2001
@@ -17,6 +17,7 @@ restrictions referred to are that the re
 	CD	Appropriate CD support is enabled.
 	DEVFS   devfs support is enabled.
 	DRM	Direct Rendering Management support is enabled.
+	EFI	EFI Partitioning (GPT) is enabled
 	EIDE	EIDE/ATAPI support is enabled.
 	FB	The frame buffer device is enabled.
 	HW	Appropriate hardware is enabled.
@@ -212,6 +213,9 @@ running once the system is up.

 	gdth=		[HW,SCSI]

+	gpt             [EFI] Forces disk with valid GPT signature but
+			invalid Protective MBR to be treated as GPT.
+
 	gscd=		[HW,CD]

 	gus=		[HW,SOUND]
diff -burNp linux-2.4.11-pre5/fs/devfs/base.c linux-2.4.11-pre5.gpt/fs/devfs/base.c
--- linux-2.4.11-pre5/fs/devfs/base.c	Sat Sep 22 22:35:43 2001
+++ linux-2.4.11-pre5.gpt/fs/devfs/base.c	Mon Oct  8 15:51:23 2001
@@ -1941,6 +1941,27 @@ devfs_handle_t devfs_get_unregister_slav
     return master->slave;
 }   /*  End Function devfs_get_unregister_slave  */

+#ifdef CONFIG_DEVFS_GUID
+/**
+ *	devfs_unregister_slave - remove the slave that is unregistered when @master is unregistered.
+ *      Destroys the connection established by devfs_auto_unregister.
+ *
+ *	@master: The master devfs entry.
+ */
+
+void devfs_unregister_slave (devfs_handle_t master)
+{
+	devfs_handle_t slave;
+
+	if (master == NULL) return;
+
+	slave = master->slave;
+	if (slave) {
+		master->slave = NULL;
+		unregister (slave);
+	};
+}
+#endif /* CONFIG_DEVFS_GUID */

 /**
  *	devfs_get_name - Get the name for a device entry in its parent directory.
@@ -2118,6 +2139,9 @@ EXPORT_SYMBOL(devfs_register_chrdev);
 EXPORT_SYMBOL(devfs_register_blkdev);
 EXPORT_SYMBOL(devfs_unregister_chrdev);
 EXPORT_SYMBOL(devfs_unregister_blkdev);
+#ifdef CONFIG_DEVFS_GUID
+EXPORT_SYMBOL(devfs_unregister_slave);
+#endif


 /**
diff -burNp linux-2.4.11-pre5/fs/partitions/Config.in linux-2.4.11-pre5.gpt/fs/partitions/Config.in
--- linux-2.4.11-pre5/fs/partitions/Config.in	Sun Aug 12 13:13:59 2001
+++ linux-2.4.11-pre5.gpt/fs/partitions/Config.in	Mon Oct  8 15:17:57 2001
@@ -24,6 +24,8 @@ if [ "$CONFIG_PARTITION_ADVANCED" = "y"
       bool '    Minix subpartition support' CONFIG_MINIX_SUBPARTITION
       bool '    Solaris (x86) partition table support' CONFIG_SOLARIS_X86_PARTITION
       bool '    Unixware slices support' CONFIG_UNIXWARE_DISKLABEL
+      bool '    EFI GUID Partition support' CONFIG_EFI_PARTITION
+      dep_bool '    /dev/guid support (EXPERIMENTAL)' CONFIG_DEVFS_GUID $CONFIG_DEVFS_FS $CONFIG_EFI_PARTITION
    fi
    dep_bool '  Windows Logical Disk Manager (Dynamic Disk) support' CONFIG_LDM_PARTITION $CONFIG_EXPERIMENTAL
    if [ "$CONFIG_LDM_PARTITION" = "y" ]; then
diff -burNp linux-2.4.11-pre5/fs/partitions/Makefile linux-2.4.11-pre5.gpt/fs/partitions/Makefile
--- linux-2.4.11-pre5/fs/partitions/Makefile	Thu Jul 26 18:30:04 2001
+++ linux-2.4.11-pre5.gpt/fs/partitions/Makefile	Mon Oct  8 15:17:57 2001
@@ -24,6 +24,7 @@ obj-$(CONFIG_SGI_PARTITION) += sgi.o
 obj-$(CONFIG_SUN_PARTITION) += sun.o
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
+obj-$(CONFIG_EFI_PARTITION) += efi.o

 include $(TOPDIR)/Rules.make

diff -burNp linux-2.4.11-pre5/fs/partitions/check.c linux-2.4.11-pre5.gpt/fs/partitions/check.c
--- linux-2.4.11-pre5/fs/partitions/check.c	Mon Oct  8 15:23:02 2001
+++ linux-2.4.11-pre5.gpt/fs/partitions/check.c	Tue Oct  9 11:00:19 2001
@@ -33,6 +33,7 @@
 #include "sun.h"
 #include "ibm.h"
 #include "ultrix.h"
+#include "efi.h"

 extern int *blk_size[];

@@ -42,6 +43,9 @@ static int (*check_part[])(struct gendis
 #ifdef CONFIG_ACORN_PARTITION
 	acorn_partition,
 #endif
+#ifdef CONFIG_EFI_PARTITION
+	efi_partition,		/* this must come before msdos */
+#endif
 #ifdef CONFIG_LDM_PARTITION
 	ldm_partition,		/* this must come before msdos */
 #endif
@@ -75,6 +79,20 @@ static int (*check_part[])(struct gendis
 	NULL
 };

+#ifdef CONFIG_DEVFS_GUID
+static devfs_handle_t guid_top_handle;
+
+#define GUID_UNPARSED_LEN 36
+static void
+uuid_unparse_1(efi_guid_t *guid, char *out)
+{
+	sprintf(out, "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
+		guid->data1, guid->data2, guid->data3,
+ 		guid->data4[0], guid->data4[1], guid->data4[2], guid->data4[3],
+		guid->data4[4], guid->data4[5], guid->data4[6], guid->data4[7]);
+}
+#endif
+
 /*
  *	This is ucking fugly but its probably the best thing for 2.4.x
  *	Take it as a clear reminder than we should put the device name
@@ -266,6 +284,103 @@ setup_devfs:
 	devfs_register_partitions (hd, i, hd->sizes ? 0 : 1);
 }

+#ifdef CONFIG_DEVFS_GUID
+/*
+  devfs_register_guid: create a /dev/guid entry for a disk or partition
+                       if it has a GUID.
+
+  The /dev/guid entry will be a symlink to the "real" devfs device.
+  It is marked as "slave" of the real device,
+  to be automatically unregistered by devfs if that device is unregistered.
+
+  If the partition already had a /dev/guid entry, delete (unregister) it.
+  (If the disk was repartitioned, it's likely the old GUID entry will be wrong).
+
+  dev, minor:  Device for which an entry is to be created.
+
+  Prerequisites: dev->part[minor].guid must be either NULL or point
+                 to a valid kmalloc'ed GUID.
+*/
+
+static void devfs_register_guid (struct gendisk *dev, int minor)
+{
+	efi_guid_t *guid = dev->part[minor].guid;
+	devfs_handle_t guid_handle, slave,
+		real_master = dev->part[minor].de;
+	devfs_handle_t master = real_master;
+	char guid_link[GUID_UNPARSED_LEN + 1];
+	char dirname[128];
+	int pos, st;
+
+	if (!guid_top_handle)
+		guid_top_handle = devfs_mk_dir (NULL, "guid", NULL);
+
+	if (!guid || !master) return;
+
+	do {
+		slave = devfs_get_unregister_slave (master);
+		if (slave) {
+			if (slave == master || slave == real_master) {
+				printk (KERN_WARNING
+					"devfs_register_guid: infinite slave loop!\n");
+				return;
+			} else if (devfs_get_parent (slave) == guid_top_handle) {
+				printk (KERN_INFO
+					"devfs_register_guid: unregistering %s\n",
+					devfs_get_name (slave, NULL));
+				devfs_unregister_slave (master);
+				slave = NULL;
+			} else
+				master = slave;
+		};
+	} while (slave);
+
+	uuid_unparse_1 (guid, guid_link);
+	pos = devfs_generate_path (real_master, dirname + 3,
+				   sizeof (dirname) - 3);
+	if (pos < 0) {
+		printk (KERN_WARNING
+			"devfs_register_guid: error generating path: %d\n",
+			pos);
+		return;
+	};
+
+	strncpy (dirname + pos, "../", 3);
+
+	st = devfs_mk_symlink (guid_top_handle, guid_link,
+			       DEVFS_FL_DEFAULT,
+			       dirname + pos, &guid_handle, NULL);
+
+	if (st < 0) {
+		printk ("Error %d creating symlink\n", st);
+	} else {
+		devfs_auto_unregister (master, guid_handle);
+	};
+};
+
+/*
+  free_disk_guids: kfree all guid data structures alloced for
+  the disk device specified by (dev, minor) and all its partitions.
+
+  This function does not remove symlinks in /dev/guid.
+*/
+static void free_disk_guids (struct gendisk *dev, int minor)
+{
+	int i;
+	efi_guid_t *guid;
+
+	for (i = 0; i < dev->max_p; i++) {
+		guid = dev->part[minor + i].guid;
+		if (!guid) continue;
+		kfree (guid);
+		dev->part[minor + i].guid = NULL;
+	};
+}
+#else
+#define devfs_register_guid(dev, minor)
+#define free_disk_guids(dev, minor)
+#endif /* CONFIG_DEVFS_GUID */
+
 #ifdef CONFIG_DEVFS_FS
 static void devfs_register_partition (struct gendisk *dev, int minor, int part)
 {
@@ -274,7 +389,11 @@ static void devfs_register_partition (st
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char devname[16];

-	if (dev->part[minor + part].de) return;
+	/* Even if the devfs handle is still up-to-date,
+	   the GUID entry probably isn't */
+	if (dev->part[minor + part].de)
+		goto do_guid;
+
 	dir = devfs_get_parent (dev->part[minor].de);
 	if (!dir) return;
 	if ( dev->flags && (dev->flags[devnum] & GENHD_FL_REMOVABLE) )
@@ -285,6 +404,9 @@ static void devfs_register_partition (st
 			    dev->major, minor + part,
 			    S_IFBLK | S_IRUSR | S_IWUSR,
 			    dev->fops, NULL);
+ do_guid:
+	devfs_register_guid (dev, minor + part);
+	return;
 }

 static struct unique_numspace disc_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
@@ -298,7 +420,9 @@ static void devfs_register_disc (struct
 	char dirname[64], symlink[16];
 	static devfs_handle_t devfs_handle;

-	if (dev->part[minor].de) return;
+	if (dev->part[minor].de)
+		goto do_guid;
+
 	if ( dev->flags && (dev->flags[devnum] & GENHD_FL_REMOVABLE) )
 		devfs_flags |= DEVFS_FL_REMOVABLE;
 	if (dev->de_arr) {
@@ -326,6 +450,10 @@ static void devfs_register_disc (struct
 	devfs_auto_unregister (dev->part[minor].de, slave);
 	if (!dev->de_arr)
 		devfs_auto_unregister (slave, dir);
+
+ do_guid:
+	devfs_register_guid (dev, minor);
+	return;
 }
 #endif  /*  CONFIG_DEVFS_FS  */

@@ -349,6 +477,7 @@ void devfs_register_partitions (struct g
 		dev->part[minor].de = NULL;
 		devfs_dealloc_unique_number (&disc_numspace,
 					     dev->part[minor].number);
+		free_disk_guids (dev, minor);
 	}
 #endif  /*  CONFIG_DEVFS_FS  */
 }
@@ -366,8 +495,21 @@ void devfs_register_partitions (struct g
 void register_disk(struct gendisk *gdev, kdev_t dev, unsigned minors,
 	struct block_device_operations *ops, long size)
 {
+	int i;
+
 	if (!gdev)
 		return;
+
+#ifdef CONFIG_DEVFS_GUID
+	/* Initialize all guid fields to NULL (=^ not kmalloc'ed).
+	   It is assumed that drivers call register_disk after
+	   allocating the gen_hd structure, and call grok_partitions
+	   directly for a revalidate event, as those drives I've inspected
+	   (among which hd and sd) do. */
+	for (i = 0; i < gdev->max_p; i++)
+		gdev->part[MINOR(dev) + i].guid = NULL;
+#endif
+
 	grok_partitions(gdev, MINOR(dev)>>gdev->minor_shift, minors, size);
 }

@@ -385,6 +527,12 @@ void grok_partitions(struct gendisk *dev
 	if (!size || minors == 1)
 		return;

+	/* In case this is a revalidation, free GUID memory.
+	   On the first call for this device,
+	   register_disk has set all entries to NULL,
+	   and nothing will happen. */
+	free_disk_guids (dev, first_minor);
+
 	check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);

  	/*
diff -burNp linux-2.4.11-pre5/fs/partitions/efi.c linux-2.4.11-pre5.gpt/fs/partitions/efi.c
--- linux-2.4.11-pre5/fs/partitions/efi.c	Wed Dec 31 18:00:00 1969
+++ linux-2.4.11-pre5.gpt/fs/partitions/efi.c	Mon Oct  8 15:17:57 2001
@@ -0,0 +1,789 @@
+/************************************************************
+ * EFI GUID Partition Table handling
+ * Per Intel EFI Specification v1.02
+ * http://developer.intel.com/technology/efi/efi.htm
+ * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>
+ *   Copyright 2000,2001 Dell Computer Corporation
+ *
+ * Note, the EFI Specification, v1.02, has a reference to
+ * Dr. Dobbs Journal, May 1994 (actually it's in May 1992)
+ * but that isn't the CRC function being used by EFI.  Intel's
+ * EFI Sample Implementation shows that they use the same function
+ * as was COPYRIGHT (C) 1986 Gary S. Brown.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ * TODO:
+ *
+ * Changelog:
+ * Mon Oct 08 2001 Matt Domsch <Matt_Domsch@dell.com>
+ * - Change read_lba() to use the page cache per Al Viro's work.
+ * - print u64s properly on all architectures
+ * - fixed debug_printk(), now Dprintk()
+ *
+ * Mon Oct 01 2001 Matt Domsch <Matt_Domsch@dell.com>
+ * - Style cleanups
+ * - made most functions static
+ * - Endianness addition
+ * - remove test for second alternate header, as it's not per spec,
+ *   and is unnecessary.  There's now a method to read/write the last
+ *   sector of an odd-sized disk from user space.  No tools have ever
+ *   been released which used this code, so it's effectively dead.
+ * - Per Asit Mallick of Intel, added a test for a valid PMBR.
+ * - Added kernel command line option 'gpt' to override valid PMBR test.
+ *
+ * Wed Jun  6 2001 Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
+ * - added devfs GUID support (/dev/guid) for mounting file systems
+ *   by the partition GUID.
+ *
+ * Tue Dec  5 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * - Moved crc32() to linux/lib, added efi_crc32().
+ *
+ * Thu Nov 30 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * - Replaced Intel's CRC32 function with an equivalent
+ *   non-license-restricted version.
+ *
+ * Wed Oct 25 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * - Fixed the last_lba() call to return the proper last block
+ *
+ * Thu Oct 12 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * - Thanks to Andries Brouwer for his debugging assistance.
+ * - Code works, detects all the partitions.
+ *
+ ************************************************************/
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/crc32.h>
+#include <linux/init.h>
+#include <asm/system.h>
+#include <asm/byteorder.h>
+#include "check.h"
+#include "efi.h"
+
+#if CONFIG_BLK_DEV_MD
+extern void md_autodetect_dev(kdev_t dev);
+#endif
+
+/* Handle printing of 64-bit values */
+#if BITS_PER_LONG == 64
+#define PU64X "%lx"
+#else
+#define PU64X "%llx"
+#endif
+
+
+#undef EFI_DEBUG
+#ifdef EFI_DEBUG
+#define Dprintk(x...) printk(KERN_DEBUG x)
+#else
+#define Dprintk(x...)
+#endif
+
+/* This allows a kernel command line option 'gpt' to override
+ * the test for invalid PMBR.  Not __initdata because reloading
+ * the partition tables happens after init too.
+ */
+static int forcegpt;
+static int __init force_gpt(char *str)
+{
+	forcegpt = 1;
+	return 1;
+}
+
+__setup("gpt", force_gpt);
+
+
+
+
+/************************************************************
+ * efi_crc32()
+ * Requires:
+ *  - a buffer of length len
+ * Modifies: nothing
+ * Returns:
+ *  EFI-style CRC32 value for buf
+ *
+ * This function uses the crc32 function by Gary S. Brown,
+ * but seeds the function with ~0, and xor's with ~0 at the end.
+ ************************************************************/
+
+static inline u32 efi_crc32(const void *buf, unsigned long len)
+{
+	return (crc32(buf, len, ~0L) ^ ~0L);
+}
+
+
+/************************************************************
+ * le_guid_to_cpus()
+ * Requires: guid
+ * Modifies: guid in situ
+ * Returns: nothing
+ *
+ * This function converts a little endian efi_guid_t to the
+ * native cpu representation.  The EFI Spec. declares that all
+ * on-disk structures are stored in little endian format.
+ *
+ ************************************************************/
+
+static void le_guid_to_cpus(efi_guid_t * guid)
+{
+	le32_to_cpus(guid->data1);
+	le16_to_cpus(guid->data2);
+	le16_to_cpus(guid->data3);
+	/* no need to change data4. It's already an array of chars */
+	return;
+}
+
+/************************************************************
+ * le_part_attributes_to_cpus()
+ * Requires: attributes
+ * Modifies: attributes in situ
+ * Returns: nothing
+ *
+ * This function converts a little endian partition attributes
+ * struct to the native cpu representation.
+ *
+ ************************************************************/
+
+static void le_part_attributes_to_cpus(GuidPartitionEntryAttributes_t * a)
+{
+	u64 *b = (u64 *) a;
+	*b = le64_to_cpu(*b);
+}
+
+/************************************************************
+ * is_pmbr_valid()
+ * Requires:
+ *  - mbr is a pointer to a legacy mbr structure
+ * Modifies: nothing
+ * Returns:
+ *  1 on true
+ *  0 on false
+ ************************************************************/
+static int is_pmbr_valid(LegacyMBR_t * mbr)
+{
+	int i, found = 0, signature = 0;
+	if (!mbr)
+		return 0;
+	signature = (le16_to_cpu(mbr->Signature) == MSDOS_MBR_SIGNATURE);
+	for (i = 0; signature && i < 4; i++) {
+		if (mbr->PartitionRecord[i].OSType ==
+		    EFI_PMBR_OSTYPE_EFI_GPT) {
+			found = 1;
+			break;
+		}
+	}
+	return (signature && found);
+}
+
+
+/************************************************************
+ * last_lba()
+ * Requires:
+ *  - struct gendisk hd
+ *  - struct block_device *bdev
+ * Modifies: nothing
+ * Returns:
+ *  Last LBA value on success.  This is stored (by sd and
+ *  ide-geometry) in
+ *  the part[0] entry for this disk, and is the number of
+ *  physical sectors available on the disk.
+ *  0 on error
+ ************************************************************/
+static u64 last_lba(struct gendisk *hd, struct block_device *bdev)
+{
+	if (!hd || !hd->part || !bdev)
+		return 0;
+	return hd->part[MINOR(to_kdev_t(bdev->bd_dev))].nr_sects - 1;
+}
+
+
+/************************************************************
+ * read_lba()
+ * Requires:
+ *  - hd is our disk device.
+ *  - bdev is our device major number
+ *  - lba is the logical block address desired (disk hardsector number)
+ *  - buffer is a buffer of size size into which data copied
+ *  - size_t count is size of the read (in bytes)
+ * Modifies:
+ *  - buffer
+ * Returns:
+ *  - count of bytes read
+ *  - 0 on error
+ ************************************************************/
+
+static size_t
+read_lba(struct gendisk *hd, struct block_device *bdev, u64 lba,
+	 u8 * buffer, size_t count)
+{
+
+	size_t totalreadcount = 0, bytesread = 0;
+	unsigned long blocksize;
+	int i;
+	Sector sect;
+	unsigned char *data = NULL;
+
+	if (!hd || !bdev || !buffer || !count)
+		return 0;
+
+	blocksize = get_hardsect_size(to_kdev_t(bdev->bd_dev));
+	if (!blocksize)
+		blocksize = 512;
+
+	for (i = 0; count > 0; i++) {
+		data = read_dev_sector(bdev, lba, &sect);
+		if (!data)
+			return totalreadcount;
+
+		bytesread =
+		    PAGE_CACHE_SIZE - (data -
+				       (unsigned char *) page_address(sect.
+								      v));
+		bytesread = min(bytesread, count);
+		memcpy(buffer, data, bytesread);
+		put_dev_sector(sect);
+
+		buffer += bytesread;
+		totalreadcount += bytesread;
+		count -= bytesread;
+		lba += (bytesread / blocksize);
+	}
+	return totalreadcount;
+}
+
+
+
+static void print_gpt_header(GuidPartitionTableHeader_t * gpt)
+{
+	Dprintk("GUID Partition Table Header\n");
+	if (!gpt)
+		return;
+	Dprintk("Signature      : " PU64X "\n", gpt->Signature);
+	Dprintk("Revision       : %x\n", gpt->Revision);
+	Dprintk("HeaderSize     : %x\n", gpt->HeaderSize);
+	Dprintk("HeaderCRC32    : %x\n", gpt->HeaderCRC32);
+	Dprintk("MyLBA          : " PU64X "\n", gpt->MyLBA);
+	Dprintk("AlternateLBA   : " PU64X "\n", gpt->AlternateLBA);
+	Dprintk("FirstUsableLBA : " PU64X "\n", gpt->FirstUsableLBA);
+	Dprintk("LastUsableLBA  : " PU64X "\n", gpt->LastUsableLBA);
+
+	Dprintk("PartitionEntryLBA : " PU64X "\n", gpt->PartitionEntryLBA);
+	Dprintk("NumberOfPartitionEntries : %x\n",
+		gpt->NumberOfPartitionEntries);
+	Dprintk("SizeOfPartitionEntry : %x\n", gpt->SizeOfPartitionEntry);
+	Dprintk("PartitionEntryArrayCRC32 : %x\n",
+		gpt->PartitionEntryArrayCRC32);
+
+	return;
+}
+
+
+
+/************************************************************
+ * alloc_read_gpt_entries()
+ * Requires:
+ *  - hd, bdev, gpt
+ * Modifies:
+ *  - nothing
+ * Returns:
+ *   ptes on success
+ *   NULL on error
+ * Notes: remember to free pte when you're done!
+ ************************************************************/
+static GuidPartitionEntry_t *
+alloc_read_gpt_entries(struct gendisk *hd,
+                       struct block_device *bdev,
+                       GuidPartitionTableHeader_t *gpt)
+{
+	u32 i, j;
+	size_t count;
+	GuidPartitionEntry_t *pte;
+	if (!hd || !bdev || !gpt)
+		return NULL;
+
+	count = gpt->NumberOfPartitionEntries * gpt->SizeOfPartitionEntry;
+	Dprintk("ReadGPTEs() kmallocing %x bytes\n", count);
+	if (!count)
+		return NULL;
+	pte = kmalloc(count, GFP_KERNEL);
+	if (!pte)
+		return NULL;
+	memset(pte, 0, count);
+
+	if (read_lba(hd, bdev, gpt->PartitionEntryLBA, (u8 *) pte,
+		     count) < count) {
+		kfree(pte);
+		return NULL;
+	}
+	/* Fixup endianness */
+	for (i = 0; i < gpt->NumberOfPartitionEntries; i++) {
+		le_guid_to_cpus(&pte[i].PartitionTypeGuid);
+		le_guid_to_cpus(&pte[i].UniquePartitionGuid);
+		le64_to_cpus(pte[i].StartingLBA);
+		le64_to_cpus(pte[i].EndingLBA);
+		le_part_attributes_to_cpus(&pte[i].Attributes);
+		for (j = 0; j < (72 / sizeof(efi_char16_t)); j++) {
+			le16_to_cpus((u16) (pte[i].PartitionName[j]));
+		}
+	}
+
+	return pte;
+}
+
+
+
+/************************************************************
+ * alloc_read_gpt_header()
+ * Requires:
+ *  - hd is our struct gendisk
+ *  - dev is our device major number
+ *  - lba is the Logical Block Address of the partition table
+ *  - gpt is a buffer into which the GPT will be put
+ *  - pte is a buffer into which the PTEs will be put
+ * Modifies:
+ *  - gpt and pte
+ * Returns:
+ *   1 on success
+ *   0 on error
+ ************************************************************/
+
+static GuidPartitionTableHeader_t *alloc_read_gpt_header(struct gendisk
+							 *hd,
+							 struct
+							 block_device
+							 *bdev, u64 lba)
+{
+	GuidPartitionTableHeader_t *gpt;
+	if (!hd || !bdev)
+		return NULL;
+
+	gpt = kmalloc(sizeof(GuidPartitionTableHeader_t), GFP_KERNEL);
+	if (!gpt)
+		return NULL;
+	memset(gpt, 0, sizeof(GuidPartitionTableHeader_t));
+
+	Dprintk("GPTH() calling read_lba().\n");
+	if (read_lba(hd, bdev, lba, (u8 *) gpt,
+		     sizeof(GuidPartitionTableHeader_t)) <
+	    sizeof(GuidPartitionTableHeader_t)) {
+		Dprintk("ReadGPTH(" PU64X ") read failed.\n", lba);
+		kfree(gpt);
+		return NULL;
+	}
+
+	/* Fixup endianness */
+	le64_to_cpus(gpt->Signature);
+	le32_to_cpus(gpt->Revision);
+	le32_to_cpus(gpt->HeaderSize);
+	le32_to_cpus(gpt->HeaderCRC32);
+	le32_to_cpus(gpt->Reserved1);
+	le64_to_cpus(gpt->MyLBA);
+	le64_to_cpus(gpt->AlternateLBA);
+	le64_to_cpus(gpt->FirstUsableLBA);
+	le64_to_cpus(gpt->LastUsableLBA);
+	le_guid_to_cpus(&gpt->DiskGUID);
+	le64_to_cpus(gpt->PartitionEntryLBA);
+	le32_to_cpus(gpt->NumberOfPartitionEntries);
+	le32_to_cpus(gpt->SizeOfPartitionEntry);
+	le32_to_cpus(gpt->PartitionEntryArrayCRC32);
+
+	print_gpt_header(gpt);
+
+	return gpt;
+}
+
+
+
+/************************************************************
+ * is_gpt_valid()
+ * Requires:
+ *  - gd points to our struct gendisk
+ *  - dev is our device major number
+ *  - lba is the logical block address of the GPTH to test
+ *  - gpt is a GPTH if it's valid
+ *  - ptes is a PTEs if it's valid
+ * Modifies:
+ *  - gpt and ptes
+ * Returns:
+ *   1 if valid
+ *   0 on error
+ ************************************************************/
+static int
+is_gpt_valid(struct gendisk *hd, struct block_device *bdev, u64 lba,
+	     GuidPartitionTableHeader_t ** gpt,
+	     GuidPartitionEntry_t ** ptes)
+{
+	u32 crc, origcrc;
+
+	if (!hd || !bdev || !gpt || !ptes)
+		return 0;
+	if (!(*gpt = alloc_read_gpt_header(hd, bdev, lba)))
+		return 0;
+
+	/* Check the GUID Partition Table Signature */
+	if ((*gpt)->Signature != GPT_HEADER_SIGNATURE) {
+		Dprintk("GUID Partition Table Header Signature is wrong: "
+			PU64X " != " PU64X "\n", (*gpt)->Signature,
+			GPT_HEADER_SIGNATURE);
+		kfree(*gpt);
+		*gpt = NULL;
+		return 0;
+	}
+
+	/* Check the GUID Partition Table CRC */
+	origcrc = (*gpt)->HeaderCRC32;
+	(*gpt)->HeaderCRC32 = 0;
+	crc =
+	    efi_crc32((const unsigned char *) (*gpt), (*gpt)->HeaderSize);
+
+
+	if (crc != origcrc) {
+		Dprintk
+		    ("GUID Partition Table Header CRC is wrong: %x != %x\n",
+		     (*gpt)->HeaderCRC32, origcrc);
+		kfree(*gpt);
+		*gpt = NULL;
+		return 0;
+	}
+	(*gpt)->HeaderCRC32 = origcrc;
+
+	/* Check that the MyLBA entry points to the LBA that contains
+	 * the GUID Partition Table */
+	if ((*gpt)->MyLBA != lba) {
+		Dprintk("GPT MyLBA incorrect: " PU64X " != " PU64X "\n",
+			(*gpt)->MyLBA, lba);
+		kfree(*gpt);
+		*gpt = NULL;
+		return 0;
+	}
+
+	if (!(*ptes = alloc_read_gpt_entries(hd, bdev, *gpt))) {
+		Dprintk("read PTEs failed.\n");
+		kfree(*gpt);
+		*gpt = NULL;
+		return 0;
+	}
+
+	/* Check the GUID Partition Entry Array CRC */
+	crc = efi_crc32((const unsigned char *) (*ptes),
+			(*gpt)->NumberOfPartitionEntries *
+			(*gpt)->SizeOfPartitionEntry);
+
+	if (crc != (*gpt)->PartitionEntryArrayCRC32) {
+		Dprintk
+		    ("GUID Partitition Entry Array CRC check failed.\n");
+		kfree(*gpt);
+		*gpt = NULL;
+		kfree(*ptes);
+		*ptes = NULL;
+		return 0;
+	}
+
+
+	/* We're done, all's well */
+	return 1;
+}
+
+
+
+/************************************************************
+ * find_valid_gpt()
+ * Requires:
+ *  - gd points to our struct gendisk
+ *  - dev is our device major number
+ *  - gpt is a GPTH if it's valid
+ *  - ptes is a PTE
+ * Modifies:
+ *  - gpt & ptes
+ * Returns:
+ *   1 if valid
+ *   0 on error
+ ************************************************************/
+static int
+find_valid_gpt(struct gendisk *hd, struct block_device *bdev,
+	       GuidPartitionTableHeader_t ** gpt,
+	       GuidPartitionEntry_t ** ptes)
+{
+	int good_pgpt = 0, good_agpt = 0, good_pmbr = 0;
+	GuidPartitionTableHeader_t *pgpt = NULL, *agpt = NULL;
+	GuidPartitionEntry_t *pptes = NULL, *aptes = NULL;
+	LegacyMBR_t *legacyMbr = NULL;
+	u64 lastlba;
+	if (!hd || !bdev || !gpt || !ptes)
+		return 0;
+
+	lastlba = last_lba(hd, bdev);
+	/* Check the Primary GPT */
+	good_pgpt = is_gpt_valid(hd, bdev, GPT_PRIMARY_PARTITION_TABLE_LBA,
+				 &pgpt, &pptes);
+	if (good_pgpt) {
+		/* Primary GPT is OK, check the alternate and warn if bad */
+		good_agpt = is_gpt_valid(hd, bdev, pgpt->AlternateLBA,
+					 &agpt, &aptes);
+		if (!good_agpt) {
+			printk(KERN_WARNING
+			       "Alternate GPT is invalid, using primary GPT.\n");
+		}
+
+		*gpt = pgpt;
+		*ptes = pptes;
+		if (agpt)
+			kfree(agpt);
+		if (aptes)
+			kfree(aptes);
+	} /* if primary is valid */
+	else {
+		/* Primary GPT is bad, check the Alternate GPT */
+		good_agpt = is_gpt_valid(hd, bdev, lastlba, &agpt, &aptes);
+		if (good_agpt) {
+			/* Primary is bad, alternate is good.
+			   Return values from the alternate and warn.
+			 */
+			printk(KERN_WARNING
+			       "Primary GPT is invalid, using alternate GPT.\n");
+			*gpt = agpt;
+			*ptes = aptes;
+		}
+	}
+
+	/* Now test for valid PMBR */
+	/* This will be added to the EFI Spec. per Intel after v1.02. */
+	if (good_pgpt || good_agpt) {
+		legacyMbr = kmalloc(sizeof(*legacyMbr), GFP_KERNEL);
+		if (legacyMbr) {
+			memset(legacyMbr, 0, sizeof(*legacyMbr));
+			read_lba(hd, bdev, 0, (u8 *) legacyMbr,
+				 sizeof(*legacyMbr));
+			good_pmbr = is_pmbr_valid(legacyMbr);
+			kfree(legacyMbr);
+		}
+		if (good_pmbr)
+			return 1;
+		if (!forcegpt) {
+			printk
+			    (" Warning: Disk has a valid GPT signature but invalid PMBR.\n");
+			printk(KERN_WARNING
+			       "  Assuming this disk is *not* a GPT disk anymore.\n");
+			printk(KERN_WARNING
+			       "  Use gpt kernel option to override.  Use GNU Parted to correct disk.\n");
+		} else {
+			printk(KERN_WARNING
+			       "  Warning: Disk has a valid GPT signature but invalid PMBR.\n");
+			printk(KERN_WARNING
+			       "  Use GNU Parted to correct disk.\n");
+			printk(KERN_WARNING
+			       "  gpt option taken, disk treated as GPT.\n");
+			return 1;
+		}
+	}
+
+	/* Both primary and alternate GPTs are bad, and/or PMBR is invalid.
+	 * This isn't our disk, return 0.
+	 */
+	if (pgpt) {
+		kfree(pgpt);
+		pgpt = NULL;
+	}
+	if (agpt) {
+		kfree(agpt);
+		agpt = NULL;
+	}
+	if (pptes) {
+		kfree(pptes);
+		pptes = NULL;
+	}
+	if (aptes) {
+		kfree(aptes);
+		aptes = NULL;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_DEVFS_GUID
+/* set_partition_guid */
+/* Fill in the GUID field of the partition.
+   It is set to NULL by register_disk before. */
+static void
+set_partition_guid(struct gendisk *hd,
+		   const int minor, const efi_guid_t * guid)
+{
+	efi_guid_t *part_guid = hd->part[minor].guid;
+
+	if (!guid || !hd)
+		return;
+
+	part_guid = kmalloc(sizeof(efi_guid_t), GFP_KERNEL);
+
+	if (part_guid) {
+		memcpy(part_guid, guid, sizeof(efi_guid_t));
+	} else {
+		printk(KERN_WARNING
+		       "add_gpt_partitions: cannot allocate GUID memory!\n");
+	};
+
+	hd->part[minor].guid = part_guid;
+}
+#else
+#define set_partition_guid(hd, minor, guid)
+#endif				/* CONFIG_DEVFS_GUID */
+
+/*
+ * Create devices for each entry in the GUID Partition Table Entries.
+ * The first block of each partition is a Legacy MBR.
+ *
+ * We do not create a Linux partition for GPT, but
+ * only for the actual data partitions.
+ * Returns:
+ * -1 if unable to read the partition table
+ *  0 if this isn't our partition table
+ *  1 if successful
+ *
+ */
+
+static int
+add_gpt_partitions(struct gendisk *hd, struct block_device *bdev,
+		   int nextminor)
+{
+	GuidPartitionTableHeader_t *gpt = NULL;
+	GuidPartitionEntry_t *ptes = NULL;
+	u32 i, nummade = 0;
+
+	efi_guid_t unusedGuid = UNUSED_ENTRY_GUID;
+#if CONFIG_BLK_DEV_MD
+	efi_guid_t raidGuid = PARTITION_LINUX_RAID_GUID;
+#endif
+
+	if (!hd || !bdev)
+		return -1;
+
+	if (!find_valid_gpt(hd, bdev, &gpt, &ptes) || !gpt || !ptes) {
+		if (gpt)
+			kfree(gpt);
+		if (ptes)
+			kfree(ptes);
+		return 0;
+	}
+
+	Dprintk("GUID Partition Table is valid!  Yea!\n");
+
+	set_partition_guid(hd, nextminor - 1, &(gpt->DiskGUID));
+
+	for (i = 0; i < gpt->NumberOfPartitionEntries &&
+	     nummade < (hd->max_p - 1); i++) {
+		if (!efi_guidcmp(unusedGuid, ptes[i].PartitionTypeGuid))
+			continue;
+
+		add_gd_partition(hd, nextminor, ptes[i].StartingLBA,
+				 (ptes[i].EndingLBA - ptes[i].StartingLBA +
+				  1));
+
+		set_partition_guid(hd, nextminor,
+				   &(ptes[i].UniquePartitionGuid));
+
+		/* If there's this is a RAID volume, tell md */
+#if CONFIG_BLK_DEV_MD
+		if (!efi_guidcmp(raidGuid, ptes[i].PartitionTypeGuid)) {
+			md_autodetect_dev(MKDEV
+					  (MAJOR(to_kdev_t(bdev->bd_dev)),
+					   nextminor));
+		}
+#endif
+		nummade++;
+		nextminor++;
+
+	}
+	kfree(ptes);
+	kfree(gpt);
+	printk("\n");
+	return 1;
+
+}
+
+
+/*
+ * efi_partition()
+ *
+ * If the first block on the disk is a legacy MBR,
+ * it will get handled by msdos_partition().
+ * If it's a Protective MBR, we'll handle it here.
+ *
+ * set_blocksize() calls are necessary to be able to read
+ * a disk with an odd number of 512-byte sectors, as the
+ * default BLOCK_SIZE of 1024 bytes won't let that last
+ * sector be read otherwise.
+ *
+ * Returns:
+ * -1 if unable to read the partition table
+ *  0 if this isn't our partitoin table
+ *  1 if successful
+ *
+ */
+
+int
+efi_partition(struct gendisk *hd, struct block_device *bdev,
+	      unsigned long first_sector, int first_part_minor)
+{
+
+	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	int hardblocksize = get_hardsect_size(dev);
+	int orig_blksize_size = BLOCK_SIZE;
+	int rc = 0;
+
+	/* Need to change the block size that the block layer uses */
+	if (blksize_size[MAJOR(dev)]) {
+		orig_blksize_size = blksize_size[MAJOR(dev)][MINOR(dev)];
+	}
+
+	if (orig_blksize_size != hardblocksize)
+		set_blocksize(dev, hardblocksize);
+
+	rc = add_gpt_partitions(hd, bdev, first_part_minor);
+
+	/* change back */
+	if (orig_blksize_size != hardblocksize)
+		set_blocksize(dev, orig_blksize_size);
+
+	return rc;
+}
+
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-indent-level: 4
+ * c-brace-imaginary-offset: 0
+ * c-brace-offset: -4
+ * c-argdecl-indent: 4
+ * c-label-offset: -4
+ * c-continued-statement-offset: 4
+ * c-continued-brace-offset: 0
+ * indent-tabs-mode: nil
+ * tab-width: 8
+ * End:
+ */
diff -burNp linux-2.4.11-pre5/fs/partitions/efi.h linux-2.4.11-pre5.gpt/fs/partitions/efi.h
--- linux-2.4.11-pre5/fs/partitions/efi.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.11-pre5.gpt/fs/partitions/efi.h	Mon Oct  8 16:40:32 2001
@@ -0,0 +1,156 @@
+/************************************************************
+ * EFI GUID Partition Table
+ * Per Intel EFI Specification v1.02
+ * http://developer.intel.com/technology/efi/efi.htm
+ *
+ * By Matt Domsch <Matt_Domsch@dell.com>  Fri Sep 22 22:15:56 CDT 2000
+ *   Copyright 2000,2001 Dell Computer Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ ************************************************************/
+
+#ifndef FS_PART_EFI_H_INCLUDED
+#define FS_PART_EFI_H_INCLUDED
+
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/blk.h>
+/*
+ * Yes, specifying asm-ia64 is ugly, but this lets it build on
+ * other platforms too, until efi.h moves to include/linux.
+ */
+#include <asm-ia64/efi.h>
+
+
+#define MSDOS_MBR_SIGNATURE 0xaa55
+#define EFI_PMBR_OSTYPE_EFI 0xEF
+#define EFI_PMBR_OSTYPE_EFI_GPT 0xEE
+
+#define GPT_BLOCK_SIZE 512
+#define GPT_HEADER_SIGNATURE 0x5452415020494645L
+#define GPT_HEADER_REVISION_V1 0x00010000
+#define GPT_PRIMARY_PARTITION_TABLE_LBA 1
+
+#define UNUSED_ENTRY_GUID    \
+    ((efi_guid_t) { 0x00000000, 0x0000, 0x0000, { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }})
+#define PARTITION_SYSTEM_GUID \
+((efi_guid_t) { 0xC12A7328, 0xF81F, 0x11d2, { 0xBA, 0x4B, 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B }})
+#define LEGACY_MBR_PARTITION_GUID \
+    ((efi_guid_t) { 0x024DEE41, 0x33E7, 0x11d3, { 0x9D, 0x69, 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F }})
+#define PARTITION_MSFT_RESERVED_GUID \
+    ((efi_guid_t) { 0xE3C9E316, 0x0B5C, 0x4DB8, { 0x81, 0x7D, 0xF9, 0x2D, 0xF0, 0x02, 0x15, 0xAE }})
+#define PARTITION_BASIC_DATA_GUID \
+    ((efi_guid_t) { 0xEBD0A0A2, 0xB9E5, 0x4433, { 0x87, 0xC0, 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7 }})
+#define PARTITION_LINUX_RAID_GUID \
+    ((efi_guid_t) { 0xa19d880f, 0x05fc, 0x4d3b, { 0xa0, 0x06, 0x74, 0x3f, 0x0f, 0x84, 0x91, 0x1e  }})
+#define PARTITION_LINUX_SWAP_GUID \
+    ((efi_guid_t) { 0x0657fd6d, 0xa4ab, 0x43c4, { 0x84, 0xe5, 0x09, 0x33, 0xc8, 0x4b, 0x4f, 0x4f  }})
+#define PARTITION_LINUX_LVM_GUID \
+    ((efi_guid_t) { 0xe6d6d379, 0xf507, 0x44c2, { 0xa2, 0x3c, 0x23, 0x8f, 0x2a, 0x3d, 0xf9, 0x28 }})
+
+typedef struct _GuidPartitionTableHeader_t {
+	u64 Signature;
+	u32 Revision;
+	u32 HeaderSize;
+	u32 HeaderCRC32;
+	u32 Reserved1;
+	u64 MyLBA;
+	u64 AlternateLBA;
+	u64 FirstUsableLBA;
+	u64 LastUsableLBA;
+	efi_guid_t DiskGUID;
+	u64 PartitionEntryLBA;
+	u32 NumberOfPartitionEntries;
+	u32 SizeOfPartitionEntry;
+	u32 PartitionEntryArrayCRC32;
+	u8 Reserved2[GPT_BLOCK_SIZE - 92];
+} __attribute__ ((packed)) GuidPartitionTableHeader_t;
+
+typedef struct _GuidPartitionEntryAttributes_t {
+	u64 RequiredToFunction:1;
+	u64 Reserved:63;
+} __attribute__ ((packed)) GuidPartitionEntryAttributes_t;
+
+typedef struct _GuidPartitionEntry_t {
+	efi_guid_t PartitionTypeGuid;
+	efi_guid_t UniquePartitionGuid;
+	u64 StartingLBA;
+	u64 EndingLBA;
+	GuidPartitionEntryAttributes_t Attributes;
+	efi_char16_t PartitionName[72 / sizeof(efi_char16_t)];
+} __attribute__ ((packed)) GuidPartitionEntry_t;
+
+typedef struct _PartitionRecord_t {
+	u8 BootIndicator;	/* Not used by EFI firmware. Set to 0x80 to indicate that this
+				   is the bootable legacy partition. */
+	u8 StartHead;		/* Start of partition in CHS address, not used by EFI firmware. */
+	u8 StartSector;		/* Start of partition in CHS address, not used by EFI firmware. */
+	u8 StartTrack;		/* Start of partition in CHS address, not used by EFI firmware. */
+	u8 OSType;		/* OS type. A value of 0xEF defines an EFI system partition.
+				   Other values are reserved for legacy operating systems, and
+				   allocated independently of the EFI specification. */
+	u8 EndHead;		/* End of partition in CHS address, not used by EFI firmware. */
+	u8 EndSector;		/* End of partition in CHS address, not used by EFI firmware. */
+	u8 EndTrack;		/* End of partition in CHS address, not used by EFI firmware. */
+	u32 StartingLBA;	/* Starting LBA address of the partition on the disk. Used by
+				   EFI firmware to define the start of the partition. */
+	u32 SizeInLBA;		/* Size of partition in LBA. Used by EFI firmware to determine
+				   the size of the partition. */
+} PartitionRecord_t;
+
+typedef struct _LegacyMBR_t {
+	u8 BootCode[440];
+	u32 UniqueMBRSignature;
+	u16 Unknown;
+	PartitionRecord_t PartitionRecord[4];
+	u16 Signature;
+} __attribute__ ((packed)) LegacyMBR_t;
+
+
+
+/* Functions */
+extern int
+efi_partition(struct gendisk *hd, struct block_device *bdev,
+	      unsigned long first_sector, int first_part_minor);
+
+
+
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * --------------------------------------------------------------------------
+ * Local variables:
+ * c-indent-level: 4
+ * c-brace-imaginary-offset: 0
+ * c-brace-offset: -4
+ * c-argdecl-indent: 4
+ * c-label-offset: -4
+ * c-continued-statement-offset: 4
+ * c-continued-brace-offset: 0
+ * indent-tabs-mode: nil
+ * tab-width: 8
+ * End:
+ */
diff -burNp linux-2.4.11-pre5/fs/partitions/msdos.c linux-2.4.11-pre5.gpt/fs/partitions/msdos.c
--- linux-2.4.11-pre5/fs/partitions/msdos.c	Mon Oct  8 15:23:02 2001
+++ linux-2.4.11-pre5.gpt/fs/partitions/msdos.c	Mon Oct  8 15:17:57 2001
@@ -36,6 +36,10 @@
 #include "check.h"
 #include "msdos.h"

+#ifdef CONFIG_EFI_PARTITION
+#include "efi.h"
+#endif
+
 #if CONFIG_BLK_DEV_MD
 extern void md_autodetect_dev(kdev_t dev);
 #endif
@@ -566,6 +570,16 @@ int msdos_partition(struct gendisk *hd,
 		return 0;
 	}
 	p = (struct partition *) (data + 0x1be);
+#ifdef CONFIG_EFI_PARTITION
+	for (i=1 ; i<=4 ; i++,p++) {
+		/* If this is an EFI GPT disk, msdos should ignore it. */
+		if (SYS_IND(p) == EFI_PMBR_OSTYPE_EFI_GPT) {
+			put_dev_sector(sect);
+			return 0;
+		}
+	}
+	p = (struct partition *) (data + 0x1be);
+#endif

 	/*
 	 * Look for partitions in two passes:
diff -burNp linux-2.4.11-pre5/include/linux/crc32.h linux-2.4.11-pre5.gpt/include/linux/crc32.h
--- linux-2.4.11-pre5/include/linux/crc32.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.11-pre5.gpt/include/linux/crc32.h	Mon Oct  8 16:40:34 2001
@@ -0,0 +1,17 @@
+/*
+ * crc32.h
+ * See linux/lib/crc32.c for license and changes
+ */
+#ifndef _LINUX_CRC32_H
+#define _LINUX_CRC32_H
+
+#include <linux/types.h>
+
+/*
+ * This computes a 32 bit CRC of the data in the buffer, and returns the CRC.
+ * The polynomial used is 0xedb88320.
+ */
+
+extern u32 crc32 (const void *buf, unsigned long len, u32 seed);
+
+#endif /* _LINUX_CRC32_H */
diff -burNp linux-2.4.11-pre5/include/linux/devfs_fs_kernel.h linux-2.4.11-pre5.gpt/include/linux/devfs_fs_kernel.h
--- linux-2.4.11-pre5/include/linux/devfs_fs_kernel.h	Sun Sep 23 12:32:28 2001
+++ linux-2.4.11-pre5.gpt/include/linux/devfs_fs_kernel.h	Mon Oct  8 16:39:49 2001
@@ -97,6 +97,9 @@ extern devfs_handle_t devfs_get_first_ch
 extern devfs_handle_t devfs_get_next_sibling (devfs_handle_t de);
 extern void devfs_auto_unregister (devfs_handle_t master,devfs_handle_t slave);
 extern devfs_handle_t devfs_get_unregister_slave (devfs_handle_t master);
+#ifdef CONFIG_DEVFS_GUID
+extern void devfs_unregister_slave (devfs_handle_t master);
+#endif
 extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
 extern int devfs_register_chrdev (unsigned int major, const char *name,
 				  struct file_operations *fops);
diff -burNp linux-2.4.11-pre5/include/linux/genhd.h linux-2.4.11-pre5.gpt/include/linux/genhd.h
--- linux-2.4.11-pre5/include/linux/genhd.h	Mon Oct  8 15:23:02 2001
+++ linux-2.4.11-pre5.gpt/include/linux/genhd.h	Mon Oct  8 16:39:52 2001
@@ -13,6 +13,10 @@
 #include <linux/types.h>
 #include <linux/major.h>

+#ifdef CONFIG_DEVFS_GUID
+#include <asm-ia64/efi.h>
+#endif
+
 enum {
 /* These three have identical behaviour; use the second one if DOS fdisk gets
    confused about extended/logical partitions starting past cylinder 1023. */
@@ -62,6 +66,9 @@ struct hd_struct {
 	long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	int number;                     /* stupid old code wastes space  */
+#ifdef CONFIG_DEVFS_GUID
+	efi_guid_t *guid;
+#endif
 };

 #define GENHD_FL_REMOVABLE  1
diff -burNp linux-2.4.11-pre5/lib/Makefile linux-2.4.11-pre5.gpt/lib/Makefile
--- linux-2.4.11-pre5/lib/Makefile	Mon Sep 17 17:31:15 2001
+++ linux-2.4.11-pre5.gpt/lib/Makefile	Mon Oct  8 15:17:57 2001
@@ -10,7 +10,7 @@ L_TARGET := lib.a

 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o

-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o crc32.o

 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -burNp linux-2.4.11-pre5/lib/crc32.c linux-2.4.11-pre5.gpt/lib/crc32.c
--- linux-2.4.11-pre5/lib/crc32.c	Wed Dec 31 18:00:00 1969
+++ linux-2.4.11-pre5.gpt/lib/crc32.c	Mon Oct  8 15:17:57 2001
@@ -0,0 +1,125 @@
+/*
+ * Dec 5, 2000 Matt Domsch <Matt_Domsch@dell.com>
+ * - Copied crc32.c from the linux/drivers/net/cipe directory.
+ * - Now pass seed as an arg
+ * - changed unsigned long to u32, added #include<linux/types.h>
+ * - changed len to be an unsigned long
+ * - changed crc32val to be a register
+ * - License remains unchanged!  It's still GPL-compatable!
+ */
+
+  /* ============================================================= */
+  /*  COPYRIGHT (C) 1986 Gary S. Brown.  You may use this program, or       */
+  /*  code or tables extracted from it, as desired without restriction.     */
+  /*                                                                        */
+  /*  First, the polynomial itself and its table of feedback terms.  The    */
+  /*  polynomial is                                                         */
+  /*  X^32+X^26+X^23+X^22+X^16+X^12+X^11+X^10+X^8+X^7+X^5+X^4+X^2+X^1+X^0   */
+  /*                                                                        */
+  /*  Note that we take it "backwards" and put the highest-order term in    */
+  /*  the lowest-order bit.  The X^32 term is "implied"; the LSB is the     */
+  /*  X^31 term, etc.  The X^0 term (usually shown as "+1") results in      */
+  /*  the MSB being 1.                                                      */
+  /*                                                                        */
+  /*  Note that the usual hardware shift register implementation, which     */
+  /*  is what we're using (we're merely optimizing it by doing eight-bit    */
+  /*  chunks at a time) shifts bits into the lowest-order term.  In our     */
+  /*  implementation, that means shifting towards the right.  Why do we     */
+  /*  do it this way?  Because the calculated CRC must be transmitted in    */
+  /*  order from highest-order term to lowest-order term.  UARTs transmit   */
+  /*  characters in order from LSB to MSB.  By storing the CRC this way,    */
+  /*  we hand it to the UART in the order low-byte to high-byte; the UART   */
+  /*  sends each low-bit to hight-bit; and the result is transmission bit   */
+  /*  by bit from highest- to lowest-order term without requiring any bit   */
+  /*  shuffling on our part.  Reception works similarly.                    */
+  /*                                                                        */
+  /*  The feedback terms table consists of 256, 32-bit entries.  Notes:     */
+  /*                                                                        */
+  /*      The table can be generated at runtime if desired; code to do so   */
+  /*      is shown later.  It might not be obvious, but the feedback        */
+  /*      terms simply represent the results of eight shift/xor opera-      */
+  /*      tions for all combinations of data and CRC register values.       */
+  /*                                                                        */
+  /*      The values must be right-shifted by eight bits by the "updcrc"    */
+  /*      logic; the shift must be unsigned (bring in zeroes).  On some     */
+  /*      hardware you could probably optimize the shift in assembler by    */
+  /*      using byte-swap instructions.                                     */
+  /*      polynomial $edb88320                                              */
+  /*                                                                        */
+  /*  --------------------------------------------------------------------  */
+
+#include <linux/crc32.h>
+
+static u32 crc32_tab[] = {
+      0x00000000L, 0x77073096L, 0xee0e612cL, 0x990951baL, 0x076dc419L,
+      0x706af48fL, 0xe963a535L, 0x9e6495a3L, 0x0edb8832L, 0x79dcb8a4L,
+      0xe0d5e91eL, 0x97d2d988L, 0x09b64c2bL, 0x7eb17cbdL, 0xe7b82d07L,
+      0x90bf1d91L, 0x1db71064L, 0x6ab020f2L, 0xf3b97148L, 0x84be41deL,
+      0x1adad47dL, 0x6ddde4ebL, 0xf4d4b551L, 0x83d385c7L, 0x136c9856L,
+      0x646ba8c0L, 0xfd62f97aL, 0x8a65c9ecL, 0x14015c4fL, 0x63066cd9L,
+      0xfa0f3d63L, 0x8d080df5L, 0x3b6e20c8L, 0x4c69105eL, 0xd56041e4L,
+      0xa2677172L, 0x3c03e4d1L, 0x4b04d447L, 0xd20d85fdL, 0xa50ab56bL,
+      0x35b5a8faL, 0x42b2986cL, 0xdbbbc9d6L, 0xacbcf940L, 0x32d86ce3L,
+      0x45df5c75L, 0xdcd60dcfL, 0xabd13d59L, 0x26d930acL, 0x51de003aL,
+      0xc8d75180L, 0xbfd06116L, 0x21b4f4b5L, 0x56b3c423L, 0xcfba9599L,
+      0xb8bda50fL, 0x2802b89eL, 0x5f058808L, 0xc60cd9b2L, 0xb10be924L,
+      0x2f6f7c87L, 0x58684c11L, 0xc1611dabL, 0xb6662d3dL, 0x76dc4190L,
+      0x01db7106L, 0x98d220bcL, 0xefd5102aL, 0x71b18589L, 0x06b6b51fL,
+      0x9fbfe4a5L, 0xe8b8d433L, 0x7807c9a2L, 0x0f00f934L, 0x9609a88eL,
+      0xe10e9818L, 0x7f6a0dbbL, 0x086d3d2dL, 0x91646c97L, 0xe6635c01L,
+      0x6b6b51f4L, 0x1c6c6162L, 0x856530d8L, 0xf262004eL, 0x6c0695edL,
+      0x1b01a57bL, 0x8208f4c1L, 0xf50fc457L, 0x65b0d9c6L, 0x12b7e950L,
+      0x8bbeb8eaL, 0xfcb9887cL, 0x62dd1ddfL, 0x15da2d49L, 0x8cd37cf3L,
+      0xfbd44c65L, 0x4db26158L, 0x3ab551ceL, 0xa3bc0074L, 0xd4bb30e2L,
+      0x4adfa541L, 0x3dd895d7L, 0xa4d1c46dL, 0xd3d6f4fbL, 0x4369e96aL,
+      0x346ed9fcL, 0xad678846L, 0xda60b8d0L, 0x44042d73L, 0x33031de5L,
+      0xaa0a4c5fL, 0xdd0d7cc9L, 0x5005713cL, 0x270241aaL, 0xbe0b1010L,
+      0xc90c2086L, 0x5768b525L, 0x206f85b3L, 0xb966d409L, 0xce61e49fL,
+      0x5edef90eL, 0x29d9c998L, 0xb0d09822L, 0xc7d7a8b4L, 0x59b33d17L,
+      0x2eb40d81L, 0xb7bd5c3bL, 0xc0ba6cadL, 0xedb88320L, 0x9abfb3b6L,
+      0x03b6e20cL, 0x74b1d29aL, 0xead54739L, 0x9dd277afL, 0x04db2615L,
+      0x73dc1683L, 0xe3630b12L, 0x94643b84L, 0x0d6d6a3eL, 0x7a6a5aa8L,
+      0xe40ecf0bL, 0x9309ff9dL, 0x0a00ae27L, 0x7d079eb1L, 0xf00f9344L,
+      0x8708a3d2L, 0x1e01f268L, 0x6906c2feL, 0xf762575dL, 0x806567cbL,
+      0x196c3671L, 0x6e6b06e7L, 0xfed41b76L, 0x89d32be0L, 0x10da7a5aL,
+      0x67dd4accL, 0xf9b9df6fL, 0x8ebeeff9L, 0x17b7be43L, 0x60b08ed5L,
+      0xd6d6a3e8L, 0xa1d1937eL, 0x38d8c2c4L, 0x4fdff252L, 0xd1bb67f1L,
+      0xa6bc5767L, 0x3fb506ddL, 0x48b2364bL, 0xd80d2bdaL, 0xaf0a1b4cL,
+      0x36034af6L, 0x41047a60L, 0xdf60efc3L, 0xa867df55L, 0x316e8eefL,
+      0x4669be79L, 0xcb61b38cL, 0xbc66831aL, 0x256fd2a0L, 0x5268e236L,
+      0xcc0c7795L, 0xbb0b4703L, 0x220216b9L, 0x5505262fL, 0xc5ba3bbeL,
+      0xb2bd0b28L, 0x2bb45a92L, 0x5cb36a04L, 0xc2d7ffa7L, 0xb5d0cf31L,
+      0x2cd99e8bL, 0x5bdeae1dL, 0x9b64c2b0L, 0xec63f226L, 0x756aa39cL,
+      0x026d930aL, 0x9c0906a9L, 0xeb0e363fL, 0x72076785L, 0x05005713L,
+      0x95bf4a82L, 0xe2b87a14L, 0x7bb12baeL, 0x0cb61b38L, 0x92d28e9bL,
+      0xe5d5be0dL, 0x7cdcefb7L, 0x0bdbdf21L, 0x86d3d2d4L, 0xf1d4e242L,
+      0x68ddb3f8L, 0x1fda836eL, 0x81be16cdL, 0xf6b9265bL, 0x6fb077e1L,
+      0x18b74777L, 0x88085ae6L, 0xff0f6a70L, 0x66063bcaL, 0x11010b5cL,
+      0x8f659effL, 0xf862ae69L, 0x616bffd3L, 0x166ccf45L, 0xa00ae278L,
+      0xd70dd2eeL, 0x4e048354L, 0x3903b3c2L, 0xa7672661L, 0xd06016f7L,
+      0x4969474dL, 0x3e6e77dbL, 0xaed16a4aL, 0xd9d65adcL, 0x40df0b66L,
+      0x37d83bf0L, 0xa9bcae53L, 0xdebb9ec5L, 0x47b2cf7fL, 0x30b5ffe9L,
+      0xbdbdf21cL, 0xcabac28aL, 0x53b39330L, 0x24b4a3a6L, 0xbad03605L,
+      0xcdd70693L, 0x54de5729L, 0x23d967bfL, 0xb3667a2eL, 0xc4614ab8L,
+      0x5d681b02L, 0x2a6f2b94L, 0xb40bbe37L, 0xc30c8ea1L, 0x5a05df1bL,
+      0x2d02ef8dL
+   };
+
+/* Return a 32-bit CRC of the contents of the buffer. */
+
+u32
+crc32(const void *buf, unsigned long len, u32 seed)
+{
+  unsigned long i;
+  register u32 crc32val;
+  const unsigned char *s = buf;
+
+  crc32val = seed;
+  for (i = 0;  i < len;  i ++)
+    {
+      crc32val =
+	crc32_tab[(crc32val ^ s[i]) & 0xff] ^
+	  (crc32val >> 8);
+    }
+  return crc32val;
+}

