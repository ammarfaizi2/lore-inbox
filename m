Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265903AbRFYTuH>; Mon, 25 Jun 2001 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265906AbRFYTt6>; Mon, 25 Jun 2001 15:49:58 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:59919 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S265903AbRFYTtu>;
	Mon, 25 Jun 2001 15:49:50 -0400
Date: Mon, 25 Jun 2001 21:52:52 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [suggested PATCH]: /dev/guid support
Message-ID: <Pine.LNX.4.30.0106252146450.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

This is a patch I sent to the Linux-IA64 mailing list some time ago.
David Mosberger has suggested that I send it to linux-kernel to get
broader feedback.

Given support for GUID (UUID) entries in the partition table (as
in the EFI partition table on IA-64 systems), and given devfs support in
the kernel, the patch creates  devfs links /dev/guid/[GUID] which allow
to mount, fsck, partition, ... disks and partitions by their unique GUID.
This wiull be quite helpful on large servers where the GUID, unlike
disk and controller numbers, will stay constat even if disks or
controllers are exchanged.

If partitions are destroyed and created, the links in /dev/guid
(dis)appear as well (thanks to devfs magic).

The patch is against 2.4.5 + David Mosbergers IA64 patch (30/05/2001)
from the "ports" directory.

Feedback very welcome
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113

diff -ru linux-2.4.5/Documentation/Configure.help linux-2.4.5mw/Documentation/Configure.help
--- linux-2.4.5/Documentation/Configure.help	Mon Jun 25 14:45:01 2001
+++ linux-2.4.5mw/Documentation/Configure.help	Mon Jun 25 15:48:11 2001
@@ -12036,6 +12036,12 @@
   were partitioned using EFI GPT.  Presently only useful on the
   IA-64 platform.

+/dev/guid support (EXPERIMENTAL)
+CONFIG_DEVFS_GUID
+  Say Y here if you would like to access disks and partitions by
+  their Globally Unique Identifiers (GUIDs) which will appear as
+  symbolic links in /dev/guid.
+
 Ultrix partition support
 CONFIG_ULTRIX_PARTITION
   Say Y here if you would like to be able to read the hard disk
diff -ru linux-2.4.5/fs/devfs/base.c linux-2.4.5mw/fs/devfs/base.c
--- linux-2.4.5/fs/devfs/base.c	Mon Jun 25 13:46:26 2001
+++ linux-2.4.5mw/fs/devfs/base.c	Mon Jun 25 15:45:32 2001
@@ -1903,6 +1903,27 @@
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
@@ -2103,6 +2124,9 @@
 EXPORT_SYMBOL(devfs_get_next_sibling);
 EXPORT_SYMBOL(devfs_auto_unregister);
 EXPORT_SYMBOL(devfs_get_unregister_slave);
+#ifdef CONFIG_DEVFS_GUID
+EXPORT_SYMBOL(devfs_unregister_slave);
+#endif
 EXPORT_SYMBOL(devfs_register_chrdev);
 EXPORT_SYMBOL(devfs_register_blkdev);
 EXPORT_SYMBOL(devfs_unregister_chrdev);
diff -ru linux-2.4.5/fs/partitions/Config.in linux-2.4.5mw/fs/partitions/Config.in
--- linux-2.4.5/fs/partitions/Config.in	Mon Jun 25 14:45:01 2001
+++ linux-2.4.5mw/fs/partitions/Config.in	Mon Jun 25 15:45:32 2001
@@ -25,6 +25,7 @@
       bool '    Solaris (x86) partition table support' CONFIG_SOLARIS_X86_PARTITION
       bool '    Unixware slices support' CONFIG_UNIXWARE_DISKLABEL
       bool '    EFI GUID Partition support' CONFIG_EFI_PARTITION
+      dep_bool '    /dev/guid support (EXPERIMENTAL)' CONFIG_DEVFS_GUID $CONFIG_DEVFS_FS $CONFIG_EFI_PARTITION
    fi
    bool '  SGI partition support' CONFIG_SGI_PARTITION
    bool '  Ultrix partition table support' CONFIG_ULTRIX_PARTITION
diff -ru linux-2.4.5/fs/partitions/check.c linux-2.4.5mw/fs/partitions/check.c
--- linux-2.4.5/fs/partitions/check.c	Mon Jun 25 14:45:01 2001
+++ linux-2.4.5mw/fs/partitions/check.c	Mon Jun 25 15:45:32 2001
@@ -79,6 +79,20 @@
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
  * disk_name() is used by partition check code and the md driver.
  * It formats the devicename of the indicated disk into
@@ -314,6 +328,101 @@
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
+
+#endif /* CONFIG_DEVFS_GUID */
+
 #ifdef CONFIG_DEVFS_FS
 static void devfs_register_partition (struct gendisk *dev, int minor, int part)
 {
@@ -322,7 +431,11 @@
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
@@ -333,6 +446,11 @@
 			    dev->major, minor + part,
 			    S_IFBLK | S_IRUSR | S_IWUSR,
 			    dev->fops, NULL);
+ do_guid:
+#ifdef CONFIG_DEVFS_GUID
+	devfs_register_guid (dev, minor + part);
+#endif
+	return;
 }

 static void devfs_register_disc (struct gendisk *dev, int minor)
@@ -345,7 +463,9 @@
 	static unsigned int disc_counter;
 	static devfs_handle_t devfs_handle;

-	if (dev->part[minor].de) return;
+	if (dev->part[minor].de)
+		goto do_guid;
+
 	if ( dev->flags && (dev->flags[devnum] & GENHD_FL_REMOVABLE) )
 		devfs_flags |= DEVFS_FL_REMOVABLE;
 	if (dev->de_arr) {
@@ -372,6 +492,12 @@
 	devfs_auto_unregister (dev->part[minor].de, slave);
 	if (!dev->de_arr)
 		devfs_auto_unregister (slave, dir);
+
+ do_guid:
+#ifdef CONFIG_DEVFS_GUID
+	devfs_register_guid (dev, minor);
+#endif
+	return;
 }
 #endif  /*  CONFIG_DEVFS_FS  */

@@ -393,6 +519,7 @@
 	if (unregister) {
 		devfs_unregister (dev->part[minor].de);
 		dev->part[minor].de = NULL;
+		free_disk_guids (dev, minor);
 	}
 #endif  /*  CONFIG_DEVFS_FS  */
 }
@@ -410,8 +537,21 @@
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

@@ -429,6 +569,13 @@
 	if (!size || minors == 1)
 		return;

+#ifdef CONFIG_DEVFS_GUID
+	/* In case this is a revalidation, free GUID memory.
+	   On the first call for this device,
+	   register_disk has set all entries to NULL,
+	   and nothing will happen. */
+	free_disk_guids (dev, first_minor);
+#endif
 	blk_size[dev->major] = NULL;
 	check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);

diff -ru linux-2.4.5/fs/partitions/efi.c linux-2.4.5mw/fs/partitions/efi.c
--- linux-2.4.5/fs/partitions/efi.c	Mon Jun 25 14:45:01 2001
+++ linux-2.4.5mw/fs/partitions/efi.c	Mon Jun 25 15:46:10 2001
@@ -479,7 +479,30 @@
 	return 0;
 }

+#ifdef CONFIG_DEVFS_GUID
+/* set_partition_guid */
+/* Fill in the GUID field of the partition.
+   It is set to NULL by register_disk before. */
+static void set_partition_guid (struct gendisk *hd,
+				const int minor,
+				const efi_guid_t *guid)
+{
+	efi_guid_t *part_guid = hd->part[minor].guid;

+	if (!guid || !hd) return;
+
+	part_guid = kmalloc (sizeof (efi_guid_t), GFP_KERNEL);
+
+        if (part_guid) {
+		memcpy (part_guid, guid, sizeof (efi_guid_t));
+	} else {
+		printk (KERN_WARNING
+                        "add_gpt_partitions: cannot allocate GUID memory!\n");
+	};
+
+	hd->part[minor].guid = part_guid;
+}
+#endif /* CONFIG_DEVFS_GUID */

 /*
  * Create devices for each entry in the GUID Partition Table Entries.
@@ -516,6 +539,11 @@
 	}

 	debug_printk(efi_printk_level "GUID Partition Table is valid!  Yea!\n");
+
+#ifdef CONFIG_DEVFS_GUID
+	set_partition_guid (hd, nextminor - 1, &(gpt->DiskGUID));
+#endif
+
 	for (i = 0; i < gpt->NumberOfPartitionEntries &&
 		     nummade < (hd->max_p - 1); i++) {
 		if (!efi_guidcmp(unusedGuid, ptes[i].PartitionTypeGuid))
@@ -523,6 +551,10 @@

 		add_gd_partition(hd, nextminor, ptes[i].StartingLBA,
 				 (ptes[i].EndingLBA-ptes[i].StartingLBA + 1));
+
+#ifdef CONFIG_DEVFS_GUID
+		set_partition_guid (hd, nextminor, &(ptes[i].UniquePartitionGuid));
+#endif

 		/* If there's this is a RAID volume, tell md */
 #if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
diff -ru linux-2.4.5/include/linux/devfs_fs_kernel.h linux-2.4.5mw/include/linux/devfs_fs_kernel.h
--- linux-2.4.5/include/linux/devfs_fs_kernel.h	Mon Jun 25 13:46:20 2001
+++ linux-2.4.5mw/include/linux/devfs_fs_kernel.h	Mon Jun 25 15:45:32 2001
@@ -81,6 +81,9 @@
 extern devfs_handle_t devfs_get_next_sibling (devfs_handle_t de);
 extern void devfs_auto_unregister (devfs_handle_t master,devfs_handle_t slave);
 extern devfs_handle_t devfs_get_unregister_slave (devfs_handle_t master);
+#ifdef CONFIG_DEVFS_GUID
+extern void devfs_unregister_slave (devfs_handle_t master);
+#endif
 extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
 extern int devfs_register_chrdev (unsigned int major, const char *name,
 				  struct file_operations *fops);
diff -ru linux-2.4.5/include/linux/genhd.h linux-2.4.5mw/include/linux/genhd.h
--- linux-2.4.5/include/linux/genhd.h	Tue Mar 27 01:48:11 2001
+++ linux-2.4.5mw/include/linux/genhd.h	Mon Jun 25 15:45:32 2001
@@ -13,6 +13,10 @@
 #include <linux/types.h>
 #include <linux/major.h>

+#ifdef CONFIG_DEVFS_GUID
+#include <asm/efi.h>
+#endif
+
 /* These three have identical behaviour; use the second one if DOS fdisk gets
    confused about extended/logical partitions starting past cylinder 1023. */
 #define DOS_EXTENDED_PARTITION 5
@@ -51,6 +55,9 @@
 	long start_sect;
 	long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
+#ifdef CONFIG_DEVFS_GUID
+	efi_guid_t *guid;
+#endif
 };

 #define GENHD_FL_REMOVABLE  1


