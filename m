Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQJ3JHO>; Mon, 30 Oct 2000 04:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129217AbQJ3JHE>; Mon, 30 Oct 2000 04:07:04 -0500
Received: from [209.249.10.20] ([209.249.10.20]:60356 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129061AbQJ3JGp>; Mon, 30 Oct 2000 04:06:45 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 30 Oct 2000 01:06:43 -0800
Message-Id: <200010300906.BAA05478@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch: modularizing partition parsing in linux-2.4.0-test10-pre6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ages ago, I modularized the partition parsing code and
posted the patch to linux-kernel.  I received a few suggestions
for some small improvements, and I confess it took me a while
to get around to producing a new patch.  Anyhow, here is the
new partitioning modularization patch.  It now longer has any
"#ifdef MODULE" code in it.  It just has one module-centric
SMP-safe initialization scheme.

	I would appreciate it if people would try this patch
and make sure that it works for them.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

----------------------CUT HERE--------------------------------

diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/Config.in linux/fs/partitions/Config.in
--- linux-2.4.0-test10-pre6/fs/partitions/Config.in	Sun Jul  9 22:21:41 2000
+++ linux/fs/partitions/Config.in	Sat Oct 28 22:57:06 2000
@@ -3,7 +3,7 @@
 #
 bool 'Advanced partition selection' CONFIG_PARTITION_ADVANCED
 if [ "$CONFIG_PARTITION_ADVANCED" = "y" ]; then
-   bool '  Acorn partition support' CONFIG_ACORN_PARTITION
+   tristate '  Acorn partition support' CONFIG_ACORN_PARTITION
    if [ "$CONFIG_ACORN_PARTITION" != "n" ]; then
 #      bool '    Cumana partition support' CONFIG_ACORN_PARTITION_CUMANA
       bool '    ICS partition support' CONFIG_ACORN_PARTITION_ICS
@@ -11,22 +11,22 @@
       bool '    PowerTec partition support' CONFIG_ACORN_PARTITION_POWERTEC
       bool '    RISCiX partition support' CONFIG_ACORN_PARTITION_RISCIX
    fi
-   bool '  Alpha OSF partition support' CONFIG_OSF_PARTITION
-   bool '  Amiga partition table support' CONFIG_AMIGA_PARTITION
-   bool '  Atari partition table support' CONFIG_ATARI_PARTITION
+   tristate '  Alpha OSF partition support' CONFIG_OSF_PARTITION
+   tristate '  Amiga partition table support' CONFIG_AMIGA_PARTITION
+   tristate '  Atari partition table support' CONFIG_ATARI_PARTITION
    if [ "$CONFIG_ARCH_S390" = "y" ]; then
       bool '  IBM disk label and partition support' CONFIG_IBM_PARTITION
    fi
-   bool '  Macintosh partition map support' CONFIG_MAC_PARTITION
-   bool '  PC BIOS (MSDOS partition tables) support' CONFIG_MSDOS_PARTITION
-   if [ "$CONFIG_MSDOS_PARTITION" = "y" ]; then
+   tristate '  Macintosh partition map support' CONFIG_MAC_PARTITION
+   tristate '  PC BIOS (MSDOS partition tables) support' CONFIG_MSDOS_PARTITION
+   if [ "$CONFIG_MSDOS_PARTITION" != "n" ]; then
       bool '    BSD disklabel (FreeBSD partition tables) support' CONFIG_BSD_DISKLABEL
       bool '    Solaris (x86) partition table support' CONFIG_SOLARIS_X86_PARTITION
       bool '    Unixware slices support' CONFIG_UNIXWARE_DISKLABEL
    fi
-   bool '  SGI partition support' CONFIG_SGI_PARTITION
-   bool '  Ultrix partition table support' CONFIG_ULTRIX_PARTITION
-   bool '  Sun partition tables support' CONFIG_SUN_PARTITION
+   tristate '  SGI partition support' CONFIG_SGI_PARTITION
+   tristate '  Ultrix partition table support' CONFIG_ULTRIX_PARTITION
+   tristate '  Sun partition tables support' CONFIG_SUN_PARTITION
 else
    if [ "$ARCH" = "alpha" ]; then
       define_bool CONFIG_OSF_PARTITION y
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/Makefile linux/fs/partitions/Makefile
--- linux-2.4.0-test10-pre6/fs/partitions/Makefile	Tue Jul 18 22:49:47 2000
+++ linux/fs/partitions/Makefile	Fri Jul 14 09:59:40 2000
@@ -14,7 +14,7 @@
 obj-$(CONFIG_AMIGA_PARTITION) += amiga.o
 obj-$(CONFIG_ATARI_PARTITION) += atari.o
 obj-$(CONFIG_MAC_PARTITION) += mac.o
-obj-$(CONFIG_MSDOS_PARTITION) += msdos.o
+obj-$(CONFIG_MSDOS_PARTITION) += msdos_part.o
 obj-$(CONFIG_OSF_PARTITION) += osf.o
 obj-$(CONFIG_SGI_PARTITION) += sgi.o
 obj-$(CONFIG_SUN_PARTITION) += sun.o
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/acorn.c linux/fs/partitions/acorn.c
--- linux-2.4.0-test10-pre6/fs/partitions/acorn.c	Mon Sep 18 15:15:26 2000
+++ linux/fs/partitions/acorn.c	Sat Oct 28 22:54:04 2000
@@ -478,8 +478,9 @@
  *
  * Returns: -1 on error, 0 if not ADFS format, 1 if ok.
  */
-int acorn_partition(struct gendisk *hd, kdev_t dev,
-		    unsigned long first_sect, int first_minor)
+static int
+acorn_partition(struct gendisk *hd, kdev_t dev,
+		unsigned long first_sect, int first_minor)
 {
 	int r = 0, i;
 
@@ -492,3 +493,6 @@
 		printk("\n");
 	return r;
 }
+
+#define check_partition acorn_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/amiga.c linux/fs/partitions/amiga.c
--- linux-2.4.0-test10-pre6/fs/partitions/amiga.c	Wed Feb 16 15:42:06 2000
+++ linux/fs/partitions/amiga.c	Sat Oct 28 22:54:04 2000
@@ -30,8 +30,9 @@
 	return sum;
 }
 
-int
-amiga_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector, int first_part_minor)
+static int
+amiga_partition(struct gendisk *hd, kdev_t dev,
+		unsigned long first_sector, int first_part_minor)
 {
 	struct buffer_head	*bh;
 	struct RigidDiskBlock	*rdb;
@@ -118,3 +119,6 @@
 	set_blocksize(dev,old_blocksize);
 	return res;
 }
+
+#define check_partition amiga_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/atari.c linux/fs/partitions/atari.c
--- linux-2.4.0-test10-pre6/fs/partitions/atari.c	Sat Oct 28 22:45:50 2000
+++ linux/fs/partitions/atari.c	Sat Oct 28 22:54:04 2000
@@ -33,8 +33,9 @@
      be32_to_cpu((pi)->st) <= (hdsiz) &&				     \
      be32_to_cpu((pi)->st) + be32_to_cpu((pi)->siz) <= (hdsiz))
 
-int atari_partition (struct gendisk *hd, kdev_t dev,
-		     unsigned long first_sector, int minor)
+static int
+atari_partition (struct gendisk *hd, kdev_t dev,
+		 unsigned long first_sector, int minor)
 {
   int m_lim = minor + hd->max_p;
   struct buffer_head *bh;
@@ -62,7 +63,6 @@
       /* if there's no valid primary partition, assume that no Atari
 	 format partition table (there's no reliable magic or the like
 	 :-() */
-      brelse(bh);
       return 0;
   }
 
@@ -176,3 +176,5 @@
   return 1;
 }
 
+#define check_partition atari_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/check.c linux/fs/partitions/check.c
--- linux-2.4.0-test10-pre6/fs/partitions/check.c	Sat Oct 28 22:45:50 2000
+++ linux/fs/partitions/check.c	Tue Oct  3 16:36:39 2000
@@ -19,6 +19,7 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 #include <linux/raid/md.h>
+#include <linux/smp_lock.h>
 
 #include "check.h"
 
@@ -29,9 +30,9 @@
 #include "msdos.h"
 #include "osf.h"
 #include "sgi.h"
-#include "sun.h"
 #include "ibm.h"
 #include "ultrix.h"
+#include "sun.h"
 
 extern void device_init(void);
 extern int *blk_size[];
@@ -41,39 +42,13 @@
 struct gendisk *gendisk_head;
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
-static int (*check_part[])(struct gendisk *hd, kdev_t dev, unsigned long first_sect, int first_minor) = {
-#ifdef CONFIG_ACORN_PARTITION
-	acorn_partition,
-#endif
-#ifdef CONFIG_MSDOS_PARTITION
-	msdos_partition,
-#endif
-#ifdef CONFIG_OSF_PARTITION
-	osf_partition,
-#endif
-#ifdef CONFIG_SUN_PARTITION
-	sun_partition,
-#endif
-#ifdef CONFIG_AMIGA_PARTITION
-	amiga_partition,
-#endif
-#ifdef CONFIG_ATARI_PARTITION
-	atari_partition,
-#endif
-#ifdef CONFIG_MAC_PARTITION
-	mac_partition,
-#endif
-#ifdef CONFIG_SGI_PARTITION
-	sgi_partition,
-#endif
-#ifdef CONFIG_ULTRIX_PARTITION
-	ultrix_partition,
-#endif
-#ifdef CONFIG_IBM_PARTITION
-	ibm_partition,
+static DECLARE_MUTEX(part_ops_mutex);
+static struct partition_ops *part_ops = NULL;
+
+#if defined CONFIG_BLK_DEV_LVM || defined CONFIG_BLK_DEV_LVM_MODULE
+#include <linux/lvm.h>
+void (*lvm_hd_name_ptr) (char *, int) = NULL;
 #endif
-	NULL
-};
 
 /*
  * disk_name() is used by genhd.c and blkpg.c.
@@ -99,6 +74,13 @@
 	 * IDE devices use multiple major numbers, but the drives
 	 * are named as:  {hda,hdb}, {hdc,hdd}, {hde,hdf}, {hdg,hdh}..
 	 * This requires special handling here.
+#if defined CONFIG_BLK_DEV_LVM || defined CONFIG_BLK_DEV_LVM_MODULE
+		case LVM_BLK_MAJOR:
+			*buf = 0;
+			if ( lvm_hd_name_ptr != NULL)
+				(lvm_hd_name_ptr) ( buf, minor);
+			return buf;
+#endif
 	 */
 	switch (hd->major) {
 		case IDE9_MAJOR:
@@ -278,6 +260,7 @@
 	unsigned long first_sector;
 	char buf[64];
 	int i;
+	struct partition_ops *ops;
 
 	if (first_time)
 		printk(KERN_INFO "Partition check:\n");
@@ -300,12 +283,13 @@
 		printk(KERN_INFO " /dev/%s:", buf + i);
 	else
 		printk(KERN_INFO " %s:", disk_name(hd, MINOR(dev), buf));
-	for (i = 0; check_part[i]; i++)
-		if (check_part[i](hd, dev, first_sector, first_part_minor))
+	down(&part_ops_mutex);
+	for (ops = part_ops; ops != NULL; ops = ops->next)
+		if ((*ops->check)(hd, dev, first_sector, first_part_minor))
 			goto setup_devfs;
-
 	printk(" unknown partition table\n");
 setup_devfs:
+	up(&part_ops_mutex);
 	i = first_part_minor - 1;
 	devfs_register_partitions (hd, i, hd->sizes ? 0 : 1);
 }
@@ -338,8 +322,8 @@
 	devfs_handle_t dir, slave;
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char dirname[64], symlink[16];
-	static unsigned int disc_counter;
-	static devfs_handle_t devfs_handle;
+	static unsigned int disc_counter = 0;
+	static devfs_handle_t devfs_handle = NULL;
 
 	if (dev->part[minor].de) return;
 	if ( dev->flags && (dev->flags[devnum] & GENHD_FL_REMOVABLE) )
@@ -411,6 +395,29 @@
 		grok_partitions(gdev, MINOR(dev)>>gdev->minor_shift, minors, size);
 }
 
+void register_partition_ops(struct partition_ops *ops)
+{
+  	down(&part_ops_mutex);
+  	ops->next = part_ops;
+	part_ops = ops;
+  	up(&part_ops_mutex);
+}
+
+void unregister_partition_ops(struct partition_ops *ops)
+{
+  	struct partition_ops **tmp;
+	down(&part_ops_mutex);
+	for (tmp = &part_ops; *tmp != NULL; tmp = &(*tmp)->next) {
+		if (*tmp == ops) {
+		  	*tmp = ops->next;
+			break;
+		}
+	}
+	up(&part_ops_mutex);
+}
+
+
+
 void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size)
 {
 	int i;
@@ -439,6 +446,9 @@
 	}
 }
 
+/* Warning: partition_setup must be called before the initialization
+   routines in the individual modules, so it must be linked before
+   them. */
 int __init partition_setup(void)
 {
 	device_init();
@@ -454,3 +464,9 @@
 }
 
 __initcall(partition_setup);
+EXPORT_SYMBOL(get_ptable_blocksize);
+EXPORT_SYMBOL(add_gd_partition);
+EXPORT_SYMBOL(warn_no_part);
+EXPORT_SYMBOL(get_hardsect_size);
+EXPORT_SYMBOL(register_partition_ops);
+EXPORT_SYMBOL(unregister_partition_ops);
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/ibm.c linux/fs/partitions/ibm.c
--- linux-2.4.0-test10-pre6/fs/partitions/ibm.c	Wed Apr 12 09:47:30 2000
+++ linux/fs/partitions/ibm.c	Sat Oct 28 22:54:04 2000
@@ -43,7 +43,7 @@
   return ibm_partition_none;
 }
 
-void
+static void
 ibm_partition (struct gendisk *hd, kdev_t dev)
 {
 	struct buffer_head *bh;
@@ -120,3 +120,5 @@
 	bforget(bh);
 }
 
+#define check_partition ibm_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/mac.c linux/fs/partitions/mac.c
--- linux-2.4.0-test10-pre6/fs/partitions/mac.c	Sun Sep 17 09:51:57 2000
+++ linux/fs/partitions/mac.c	Sat Oct 28 22:54:04 2000
@@ -36,7 +36,9 @@
 		stg[i] = 0;
 }
 
-int mac_partition(struct gendisk *hd, kdev_t dev, unsigned long fsec, int first_part_minor)
+static int
+mac_partition(struct gendisk *hd, kdev_t dev, unsigned long fsec,
+	      int first_part_minor)
 {
 	struct buffer_head *bh;
 	int blk, blocks_in_map;
@@ -152,3 +154,5 @@
 	return 1;
 }
 
+#define check_partition mac_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/msdos.c linux/fs/partitions/msdos.c
--- linux-2.4.0-test10-pre6/fs/partitions/msdos.c	Tue Jul 18 23:29:16 2000
+++ linux/fs/partitions/msdos.c	Wed Dec 31 16:00:00 1969
@@ -1,515 +0,0 @@
-/*
- *  fs/partitions/msdos.c
- *
- *  Code extracted from drivers/block/genhd.c
- *  Copyright (C) 1991-1998  Linus Torvalds
- *
- *  Thanks to Branko Lankester, lankeste@fwi.uva.nl, who found a bug
- *  in the early extended-partition checks and added DM partitions
- *
- *  Support for DiskManager v6.0x added by Mark Lord,
- *  with information provided by OnTrack.  This now works for linux fdisk
- *  and LILO, as well as loadlin and bootln.  Note that disks other than
- *  /dev/hda *must* have a "DOS" type 0x51 partition in the first slot (hda1).
- *
- *  More flexible handling of extended partitions - aeb, 950831
- *
- *  Check partition table on IDE disks for common CHS translations
- *
- *  Re-organised Feb 1998 Russell King
- */
-
-#include <linux/config.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/kernel.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/blk.h>
-
-#ifdef CONFIG_BLK_DEV_IDE
-#include <linux/ide.h>	/* IDE xlate */
-#endif /* CONFIG_BLK_DEV_IDE */
-
-#include <asm/system.h>
-
-#include "check.h"
-#include "msdos.h"
-
-#if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
-extern void md_autodetect_dev(kdev_t dev);
-#endif
-
-static int current_minor;
-
-/*
- * Many architectures don't like unaligned accesses, which is
- * frequently the case with the nr_sects and start_sect partition
- * table entries.
- */
-#include <asm/unaligned.h>
-
-#define SYS_IND(p)	(get_unaligned(&p->sys_ind))
-#define NR_SECTS(p)	({ __typeof__(p->nr_sects) __a =	\
-				get_unaligned(&p->nr_sects);	\
-				le32_to_cpu(__a); \
-			})
-
-#define START_SECT(p)	({ __typeof__(p->start_sect) __a =	\
-				get_unaligned(&p->start_sect);	\
-				le32_to_cpu(__a); \
-			})
-
-static inline int is_extended_partition(struct partition *p)
-{
-	return (SYS_IND(p) == DOS_EXTENDED_PARTITION ||
-		SYS_IND(p) == WIN98_EXTENDED_PARTITION ||
-		SYS_IND(p) == LINUX_EXTENDED_PARTITION);
-}
-
-/*
- * Create devices for each logical partition in an extended partition.
- * The logical partitions form a linked list, with each entry being
- * a partition table with two entries.  The first entry
- * is the real data partition (with a start relative to the partition
- * table start).  The second is a pointer to the next logical partition
- * (with a start relative to the entire extended partition).
- * We do not create a Linux partition for the partition tables, but
- * only for the actual data partitions.
- */
-
-static void extended_partition(struct gendisk *hd, kdev_t dev)
-{
-	struct buffer_head *bh;
-	struct partition *p;
-	unsigned long first_sector, first_size, this_sector, this_size;
-	int mask = (1 << hd->minor_shift) - 1;
-	int sector_size = get_hardsect_size(dev) / 512;
-	int loopct = 0;		/* number of links followed
-				   without finding a data partition */
-	int i;
-
-	first_sector = hd->part[MINOR(dev)].start_sect;
-	first_size = hd->part[MINOR(dev)].nr_sects;
-	this_sector = first_sector;
-
-	while (1) {
-		if (++loopct > 100)
-			return;
-		if ((current_minor & mask) == 0)
-			return;
-		if (!(bh = bread(dev,0,get_ptable_blocksize(dev))))
-			return;
-
-		if ((*(__u16 *) (bh->b_data+510)) != cpu_to_le16(MSDOS_LABEL_MAGIC))
-			goto done;
-
-		p = (struct partition *) (0x1BE + bh->b_data);
-
-		this_size = hd->part[MINOR(dev)].nr_sects;
-
-		/*
-		 * Usually, the first entry is the real data partition,
-		 * the 2nd entry is the next extended partition, or empty,
-		 * and the 3rd and 4th entries are unused.
-		 * However, DRDOS sometimes has the extended partition as
-		 * the first entry (when the data partition is empty),
-		 * and OS/2 seems to use all four entries.
-		 */
-
-		/* 
-		 * First process the data partition(s)
-		 */
-		for (i=0; i<4; i++, p++) {
-			if (!NR_SECTS(p) || is_extended_partition(p))
-				continue;
-
-			/* Check the 3rd and 4th entries -
-			   these sometimes contain random garbage */
-			if (i >= 2
-				&& START_SECT(p) + NR_SECTS(p) > this_size
-				&& (this_sector + START_SECT(p) < first_sector ||
-				    this_sector + START_SECT(p) + NR_SECTS(p) >
-				     first_sector + first_size))
-				continue;
-
-			add_gd_partition(hd, current_minor,
-					 this_sector+START_SECT(p)*sector_size,
-					 NR_SECTS(p)*sector_size);
-#if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
-			if (SYS_IND(p) == LINUX_RAID_PARTITION) {
-			    md_autodetect_dev(MKDEV(hd->major,current_minor));
-			}
-#endif
-
-			current_minor++;
-			loopct = 0;
-			if ((current_minor & mask) == 0)
-				goto done;
-		}
-		/*
-		 * Next, process the (first) extended partition, if present.
-		 * (So far, there seems to be no reason to make
-		 *  extended_partition()  recursive and allow a tree
-		 *  of extended partitions.)
-		 * It should be a link to the next logical partition.
-		 * Create a minor for this just long enough to get the next
-		 * partition table.  The minor will be reused for the next
-		 * data partition.
-		 */
-		p -= 4;
-		for (i=0; i<4; i++, p++)
-			if(NR_SECTS(p) && is_extended_partition(p))
-				break;
-		if (i == 4)
-			goto done;	 /* nothing left to do */
-
-		hd->part[current_minor].nr_sects = NR_SECTS(p) * sector_size; /* JSt */
-		hd->part[current_minor].start_sect = first_sector + START_SECT(p) * sector_size;
-		this_sector = first_sector + START_SECT(p) * sector_size;
-		dev = MKDEV(hd->major, current_minor);
-
-		/* Use bforget(), as we have changed the disk geometry */
-		bforget(bh);
-	}
-done:
-	bforget(bh);
-}
-
-static inline struct buffer_head *
-get_partition_table_block(struct gendisk *hd, int minor, int blocknr) {
-	kdev_t dev = MKDEV(hd->major, minor);
-	return bread(dev, blocknr, get_ptable_blocksize(dev));
-}
-
-#ifdef CONFIG_SOLARIS_X86_PARTITION
-
-/* james@bpgc.com: Solaris has a nasty indicator: 0x82 which also
-   indicates linux swap.  Be careful before believing this is Solaris. */
-
-static void
-solaris_x86_partition(struct gendisk *hd, int minor) {
-	long offset = hd->part[minor].start_sect;
-
-	struct buffer_head *bh;
-	struct solaris_x86_vtoc *v;
-	struct solaris_x86_slice *s;
-	int i;
-	char buf[40];
-
-	if(!(bh = get_partition_table_block(hd, minor, 0)))
-		return;
-	v = (struct solaris_x86_vtoc *)(bh->b_data + 512);
-	if(v->v_sanity != SOLARIS_X86_VTOC_SANE) {
-		brelse(bh);
-		return;
-	}
-	printk(" %s: <solaris:", disk_name(hd, minor, buf));
-	if(v->v_version != 1) {
-		printk("  cannot handle version %ld vtoc>\n", v->v_version);
-		brelse(bh);
-		return;
-	}
-	for(i=0; i<SOLARIS_X86_NUMSLICE; i++) {
-		s = &v->v_slice[i];
-
-		if (s->s_size == 0)
-			continue;
-		printk(" [s%d]", i);
-		/* solaris partitions are relative to current MS-DOS
-		 * one but add_gd_partition starts relative to sector
-		 * zero of the disk.  Therefore, must add the offset
-		 * of the current partition */
-		add_gd_partition(hd, current_minor, s->s_start+offset, s->s_size);
-		current_minor++;
-	}
-	brelse(bh);
-	printk(" >\n");
-}
-#endif
-
-#ifdef CONFIG_BSD_DISKLABEL
-static void
-check_and_add_bsd_partition(struct gendisk *hd,
-			    struct bsd_partition *bsd_p, int minor) {
-	struct hd_struct *lin_p;
-		/* check relative position of partitions.  */
-	for (lin_p = hd->part + 1 + minor;
-	     lin_p - hd->part - minor < current_minor; lin_p++) {
-			/* no relationship -> try again */
-		if (lin_p->start_sect + lin_p->nr_sects <= bsd_p->p_offset ||
-		    lin_p->start_sect >= bsd_p->p_offset + bsd_p->p_size)
-			continue;	
-			/* equal -> no need to add */
-		if (lin_p->start_sect == bsd_p->p_offset && 
-			lin_p->nr_sects == bsd_p->p_size) 
-			return;
-			/* bsd living within dos partition */
-		if (lin_p->start_sect <= bsd_p->p_offset && lin_p->start_sect 
-			+ lin_p->nr_sects >= bsd_p->p_offset + bsd_p->p_size) {
-#ifdef DEBUG_BSD_DISKLABEL
-			printk("w: %d %ld+%ld,%d+%d", 
-				lin_p - hd->part, 
-				lin_p->start_sect, lin_p->nr_sects, 
-				bsd_p->p_offset, bsd_p->p_size);
-#endif
-			break;
-		}
-	 /* ouch: bsd and linux overlap. Don't even try for that partition */
-#ifdef DEBUG_BSD_DISKLABEL
-		printk("???: %d %ld+%ld,%d+%d",
-			lin_p - hd->part, lin_p->start_sect, lin_p->nr_sects,
-			bsd_p->p_offset, bsd_p->p_size);
-#endif
-		printk("???");
-		return;
-	} /* if the bsd partition is not currently known to linux, we end
-	   * up here 
-	   */
-	add_gd_partition(hd, current_minor, bsd_p->p_offset, bsd_p->p_size);
-	current_minor++;
-}
-
-/* 
- * Create devices for BSD partitions listed in a disklabel, under a
- * dos-like partition. See extended_partition() for more information.
- */
-static void bsd_disklabel_partition(struct gendisk *hd, int minor, int type) {
-	struct buffer_head *bh;
-	struct bsd_disklabel *l;
-	struct bsd_partition *p;
-	int max_partitions;
-	int mask = (1 << hd->minor_shift) - 1;
-	char buf[40];
-
-	if (!(bh = get_partition_table_block(hd, minor, 0)))
-		return;
-	l = (struct bsd_disklabel *) (bh->b_data+512);
-	if (l->d_magic != BSD_DISKMAGIC) {
-		brelse(bh);
-		return;
-	}
-	printk(" %s:", disk_name(hd, minor, buf));
-	printk((type == OPENBSD_PARTITION) ? " <openbsd:" :
-	       (type == NETBSD_PARTITION) ? " <netbsd:" : " <bsd:");
-
-	max_partitions = ((type == OPENBSD_PARTITION) ? OPENBSD_MAXPARTITIONS
-			                              : BSD_MAXPARTITIONS);
-	if (l->d_npartitions < max_partitions)
-		max_partitions = l->d_npartitions;
-	for (p = l->d_partitions; p - l->d_partitions <  max_partitions; p++) {
-		if ((current_minor & mask) >= (4 + hd->max_p))
-			break;
-
-		if (p->p_fstype != BSD_FS_UNUSED) 
-			check_and_add_bsd_partition(hd, p, minor);
-	}
-
-	/* Use bforget(), as we have changed the disk setup */
-	bforget(bh);
-
-	printk(" >\n");
-}
-#endif
-
-#ifdef CONFIG_UNIXWARE_DISKLABEL
-/*
- * Create devices for Unixware partitions listed in a disklabel, under a
- * dos-like partition. See extended_partition() for more information.
- */
-static void unixware_partition(struct gendisk *hd, int minor) {
-	struct buffer_head *bh;
-	struct unixware_disklabel *l;
-	struct unixware_slice *p;
-	int mask = (1 << hd->minor_shift) - 1;
-	char buf[40];
-
-	if (!(bh = get_partition_table_block(hd, minor, 14)))
-		return;
-	l = (struct unixware_disklabel *) (bh->b_data+512);
-	if (le32_to_cpu(l->d_magic) != UNIXWARE_DISKMAGIC ||
-	    le32_to_cpu(l->vtoc.v_magic) != UNIXWARE_DISKMAGIC2) {
-		brelse(bh);
-		return;
-	}
-	printk(" %s: <unixware:", disk_name(hd, minor, buf));
-	p = &l->vtoc.v_slice[1];
-	/* I omit the 0th slice as it is the same as whole disk. */
-	while (p - &l->vtoc.v_slice[0] < UNIXWARE_NUMSLICE) {
-		if ((current_minor & mask) == 0)
-			break;
-
-		if (p->s_label != UNIXWARE_FS_UNUSED) {
-			add_gd_partition(hd, current_minor, START_SECT(p),
-					 NR_SECTS(p));
-			current_minor++;
-		}
-		p++;
-	}
-	/* Use bforget, as we have changed the disk setup */
-	bforget(bh);
-	printk(" >\n");
-}
-#endif
-
-int msdos_partition(struct gendisk *hd, kdev_t dev,
-		    unsigned long first_sector, int first_part_minor) {
-	int i, minor = current_minor = first_part_minor;
-	struct buffer_head *bh;
-	struct partition *p;
-	unsigned char *data;
-	int mask = (1 << hd->minor_shift) - 1;
-	int sector_size = get_hardsect_size(dev) / 512;
-#ifdef CONFIG_BLK_DEV_IDE
-	int tested_for_xlate = 0;
-
-read_mbr:
-#endif /* CONFIG_BLK_DEV_IDE */
-	if (!(bh = bread(dev,0,get_ptable_blocksize(dev)))) {
-		if (warn_no_part) printk(" unable to read partition table\n");
-		return -1;
-	}
-	data = bh->b_data;
-#ifdef CONFIG_BLK_DEV_IDE
-check_table:
-#endif /* CONFIG_BLK_DEV_IDE */
-	/* Use bforget(), because we may have changed the disk geometry */
-	if (*(unsigned short *)  (0x1fe + data) != cpu_to_le16(MSDOS_LABEL_MAGIC)) {
-		bforget(bh);
-		return 0;
-	}
-	p = (struct partition *) (0x1be + data);
-
-#ifdef CONFIG_BLK_DEV_IDE
-	if (!tested_for_xlate++) {	/* Do this only once per disk */
-		/*
-		 * Look for various forms of IDE disk geometry translation
-		 */
-		unsigned int sig = le16_to_cpu(*(unsigned short *)(data + 2));
-		int heads = 0;
-		/*
-		 * The i386 partition handling programs very often
-		 * make partitions end on cylinder boundaries.
-		 * There is no need to do so, and Linux fdisk doesnt always
-		 * do this, and Windows NT on Alpha doesnt do this either,
-		 * but still, this helps to guess #heads.
-		 */
-		for (i = 0; i < 4; i++) {
-			struct partition *q = &p[i];
-			if (NR_SECTS(q)) {
-				if ((q->sector & 63) == 1 &&
-				    (q->end_sector & 63) == 63)
-					heads = q->end_head + 1;
-				break;
-			}
-		}
-		if (SYS_IND(p) == EZD_PARTITION) {
-			/*
-			 * Accesses to sector 0 must go to sector 1 instead.
-			 */
-			if (ide_xlate_1024(dev, -1, heads, " [EZD]")) {
-				data += 512;
-				goto check_table;
-			}
-		} else if (SYS_IND(p) == DM6_PARTITION) {
-
-			/*
-			 * Everything on the disk is offset by 63 sectors,
-			 * including a "new" MBR with its own partition table.
-			 */
-			if (ide_xlate_1024(dev, 1, heads, " [DM6:DDO]")) {
-				bforget(bh);
-				goto read_mbr;	/* start over with new MBR */
-			}
-		} else if (sig <= 0x1ae &&
-			   data[sig] == 0xAA && data[sig+1] == 0x55 &&
-			   (data[sig+2] & 1)) {
-			/* DM6 signature in MBR, courtesy of OnTrack */
-			(void) ide_xlate_1024 (dev, 0, heads, " [DM6:MBR]");
-		} else if (SYS_IND(p) == DM6_AUX1PARTITION ||
-			   SYS_IND(p) == DM6_AUX3PARTITION) {
-			/*
-			 * DM6 on other than the first (boot) drive
-			 */
-			(void) ide_xlate_1024(dev, 0, heads, " [DM6:AUX]");
-		} else {
-			(void) ide_xlate_1024(dev, 2, heads, " [PTBL]");
-		}
-	}
-#endif /* CONFIG_BLK_DEV_IDE */
-
-	/* Look for partitions in two passes:
-	   First find the primary partitions, and the DOS-type extended partitions.
-	   On the second pass look inside *BSD and Unixware and Solaris partitions. */
-
-	current_minor += 4;  /* first "extra" minor (for extended partitions) */
-	for (i=1 ; i<=4 ; minor++,i++,p++) {
-		if (!NR_SECTS(p))
-			continue;
-		add_gd_partition(hd, minor, first_sector+START_SECT(p)*sector_size,
-				 NR_SECTS(p)*sector_size);
-#if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
-		if (SYS_IND(p) == LINUX_RAID_PARTITION) {
-			md_autodetect_dev(MKDEV(hd->major,minor));
-		}
-#endif
-		if (is_extended_partition(p)) {
-			printk(" <");
-			/*
-			 * If we are rereading the partition table, we need
-			 * to set the size of the partition so that we will
-			 * be able to bread the block containing the extended
-			 * partition info.
-			 */
-			hd->sizes[minor] = hd->part[minor].nr_sects 
-			  	>> (BLOCK_SIZE_BITS - 9);
-			extended_partition(hd, MKDEV(hd->major, minor));
-			printk(" >");
-			/* prevent someone doing mkfs or mkswap on an
-			   extended partition, but leave room for LILO */
-			if (hd->part[minor].nr_sects > 2)
-				hd->part[minor].nr_sects = 2;
-		}
-	}
-
-	/*
-	 *  Check for old-style Disk Manager partition table
-	 */
-	if (*(unsigned short *) (data+0xfc) == cpu_to_le16(MSDOS_LABEL_MAGIC)) {
-		p = (struct partition *) (0x1be + data);
-		for (i = 4 ; i < 16 ; i++, current_minor++) {
-			p--;
-			if ((current_minor & mask) == 0)
-				break;
-			if (!(START_SECT(p) && NR_SECTS(p)))
-				continue;
-			add_gd_partition(hd, current_minor, START_SECT(p), NR_SECTS(p));
-		}
-	}
-	printk("\n");
-
-	/* second pass - output for each on a separate line */
-	minor -= 4;
-	p = (struct partition *) (0x1be + data);
-	for (i=1 ; i<=4 ; minor++,i++,p++) {
-		if (!NR_SECTS(p))
-			continue;
-#ifdef CONFIG_BSD_DISKLABEL
-		if (SYS_IND(p) == BSD_PARTITION ||
-		    SYS_IND(p) == NETBSD_PARTITION ||
-		    SYS_IND(p) == OPENBSD_PARTITION)
-			bsd_disklabel_partition(hd, minor, SYS_IND(p));
-#endif
-#ifdef CONFIG_UNIXWARE_DISKLABEL
-		if (SYS_IND(p) == UNIXWARE_PARTITION)
-			unixware_partition(hd, minor);
-#endif
-#ifdef CONFIG_SOLARIS_X86_PARTITION
-		if(SYS_IND(p) == SOLARIS_X86_PARTITION)
-			solaris_x86_partition(hd, minor);
-#endif
-	}
-
-	bforget(bh);
-	return 1;
-}
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/msdos_part.c linux/fs/partitions/msdos_part.c
--- linux-2.4.0-test10-pre6/fs/partitions/msdos_part.c	Wed Dec 31 16:00:00 1969
+++ linux/fs/partitions/msdos_part.c	Mon Oct 30 00:47:18 2000
@@ -0,0 +1,517 @@
+/*
+ *  fs/partitions/msdos.c
+ *
+ *  Code extracted from drivers/block/genhd.c
+ *  Copyright (C) 1991-1998  Linus Torvalds
+ *
+ *  Thanks to Branko Lankester, lankeste@fwi.uva.nl, who found a bug
+ *  in the early extended-partition checks and added DM partitions
+ *
+ *  Support for DiskManager v6.0x added by Mark Lord,
+ *  with information provided by OnTrack.  This now works for linux fdisk
+ *  and LILO, as well as loadlin and bootln.  Note that disks other than
+ *  /dev/hda *must* have a "DOS" type 0x51 partition in the first slot (hda1).
+ *
+ *  More flexible handling of extended partitions - aeb, 950831
+ *
+ *  Check partition table on IDE disks for common CHS translations
+ *
+ *  Re-organised Feb 1998 Russell King
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/blk.h>
+#include <linux/ide.h>	/* IDE xlate */
+
+#include <asm/system.h>
+
+#include "check.h"
+#include "msdos.h"
+
+#if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
+extern void md_autodetect_dev(kdev_t dev);
+#endif
+
+static int current_minor;
+
+/*
+ * Many architectures don't like unaligned accesses, which is
+ * frequently the case with the nr_sects and start_sect partition
+ * table entries.
+ */
+#include <asm/unaligned.h>
+
+#define SYS_IND(p)	(get_unaligned(&p->sys_ind))
+#define NR_SECTS(p)	({ __typeof__(p->nr_sects) __a =	\
+				get_unaligned(&p->nr_sects);	\
+				le32_to_cpu(__a); \
+			})
+
+#define START_SECT(p)	({ __typeof__(p->start_sect) __a =	\
+				get_unaligned(&p->start_sect);	\
+				le32_to_cpu(__a); \
+			})
+
+static inline int is_extended_partition(struct partition *p)
+{
+	return (SYS_IND(p) == DOS_EXTENDED_PARTITION ||
+		SYS_IND(p) == WIN98_EXTENDED_PARTITION ||
+		SYS_IND(p) == LINUX_EXTENDED_PARTITION);
+}
+
+/*
+ * Create devices for each logical partition in an extended partition.
+ * The logical partitions form a linked list, with each entry being
+ * a partition table with two entries.  The first entry
+ * is the real data partition (with a start relative to the partition
+ * table start).  The second is a pointer to the next logical partition
+ * (with a start relative to the entire extended partition).
+ * We do not create a Linux partition for the partition tables, but
+ * only for the actual data partitions.
+ */
+
+static void extended_partition(struct gendisk *hd, kdev_t dev)
+{
+	struct buffer_head *bh;
+	struct partition *p;
+	unsigned long first_sector, first_size, this_sector, this_size;
+	int mask = (1 << hd->minor_shift) - 1;
+	int sector_size = get_hardsect_size(dev) / 512;
+	int loopct = 0;		/* number of links followed
+				   without finding a data partition */
+	int i;
+
+	first_sector = hd->part[MINOR(dev)].start_sect;
+	first_size = hd->part[MINOR(dev)].nr_sects;
+	this_sector = first_sector;
+
+	while (1) {
+		if (++loopct > 100)
+			return;
+		if ((current_minor & mask) == 0)
+			return;
+		if (!(bh = bread(dev,0,get_ptable_blocksize(dev))))
+			return;
+
+		if ((*(__u16 *) (bh->b_data+510)) != cpu_to_le16(MSDOS_LABEL_MAGIC))
+			goto done;
+
+		p = (struct partition *) (0x1BE + bh->b_data);
+
+		this_size = hd->part[MINOR(dev)].nr_sects;
+
+		/*
+		 * Usually, the first entry is the real data partition,
+		 * the 2nd entry is the next extended partition, or empty,
+		 * and the 3rd and 4th entries are unused.
+		 * However, DRDOS sometimes has the extended partition as
+		 * the first entry (when the data partition is empty),
+		 * and OS/2 seems to use all four entries.
+		 */
+
+		/* 
+		 * First process the data partition(s)
+		 */
+		for (i=0; i<4; i++, p++) {
+			if (!NR_SECTS(p) || is_extended_partition(p))
+				continue;
+
+			/* Check the 3rd and 4th entries -
+			   these sometimes contain random garbage */
+			if (i >= 2
+				&& START_SECT(p) + NR_SECTS(p) > this_size
+				&& (this_sector + START_SECT(p) < first_sector ||
+				    this_sector + START_SECT(p) + NR_SECTS(p) >
+				     first_sector + first_size))
+				continue;
+
+			add_gd_partition(hd, current_minor,
+					 this_sector+START_SECT(p)*sector_size,
+					 NR_SECTS(p)*sector_size);
+#if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
+			if (SYS_IND(p) == LINUX_RAID_PARTITION) {
+			    md_autodetect_dev(MKDEV(hd->major,current_minor));
+			}
+#endif
+
+			current_minor++;
+			loopct = 0;
+			if ((current_minor & mask) == 0)
+				goto done;
+		}
+		/*
+		 * Next, process the (first) extended partition, if present.
+		 * (So far, there seems to be no reason to make
+		 *  extended_partition()  recursive and allow a tree
+		 *  of extended partitions.)
+		 * It should be a link to the next logical partition.
+		 * Create a minor for this just long enough to get the next
+		 * partition table.  The minor will be reused for the next
+		 * data partition.
+		 */
+		p -= 4;
+		for (i=0; i<4; i++, p++)
+			if(NR_SECTS(p) && is_extended_partition(p))
+				break;
+		if (i == 4)
+			goto done;	 /* nothing left to do */
+
+		hd->part[current_minor].nr_sects = NR_SECTS(p) * sector_size; /* JSt */
+		hd->part[current_minor].start_sect = first_sector + START_SECT(p) * sector_size;
+		this_sector = first_sector + START_SECT(p) * sector_size;
+		dev = MKDEV(hd->major, current_minor);
+
+		/* Use bforget(), as we have changed the disk geometry */
+		bforget(bh);
+	}
+done:
+	bforget(bh);
+}
+
+static inline struct buffer_head *
+get_partition_table_block(struct gendisk *hd, int minor, int blocknr) {
+	kdev_t dev = MKDEV(hd->major, minor);
+	return bread(dev, blocknr, get_ptable_blocksize(dev));
+}
+
+#ifdef CONFIG_SOLARIS_X86_PARTITION
+
+/* james@bpgc.com: Solaris has a nasty indicator: 0x82 which also
+   indicates linux swap.  Be careful before believing this is Solaris. */
+
+static void
+solaris_x86_partition(struct gendisk *hd, int minor) {
+	long offset = hd->part[minor].start_sect;
+
+	struct buffer_head *bh;
+	struct solaris_x86_vtoc *v;
+	struct solaris_x86_slice *s;
+	int i;
+	char buf[40];
+
+	if(!(bh = get_partition_table_block(hd, minor, 0)))
+		return;
+	v = (struct solaris_x86_vtoc *)(bh->b_data + 512);
+	if(v->v_sanity != SOLARIS_X86_VTOC_SANE) {
+		brelse(bh);
+		return;
+	}
+	printk(" %s: <solaris:", disk_name(hd, minor, buf));
+	if(v->v_version != 1) {
+		printk("  cannot handle version %ld vtoc>\n", v->v_version);
+		brelse(bh);
+		return;
+	}
+	for(i=0; i<SOLARIS_X86_NUMSLICE; i++) {
+		s = &v->v_slice[i];
+
+		if (s->s_size == 0)
+			continue;
+		printk(" [s%d]", i);
+		/* solaris partitions are relative to current MS-DOS
+		 * one but add_gd_partition starts relative to sector
+		 * zero of the disk.  Therefore, must add the offset
+		 * of the current partition */
+		add_gd_partition(hd, current_minor, s->s_start+offset, s->s_size);
+		current_minor++;
+	}
+	brelse(bh);
+	printk(" >\n");
+}
+#endif
+
+#ifdef CONFIG_BSD_DISKLABEL
+static void
+check_and_add_bsd_partition(struct gendisk *hd,
+			    struct bsd_partition *bsd_p, int minor) {
+	struct hd_struct *lin_p;
+		/* check relative position of partitions.  */
+	for (lin_p = hd->part + 1 + minor;
+	     lin_p - hd->part - minor < current_minor; lin_p++) {
+			/* no relationship -> try again */
+		if (lin_p->start_sect + lin_p->nr_sects <= bsd_p->p_offset ||
+		    lin_p->start_sect >= bsd_p->p_offset + bsd_p->p_size)
+			continue;	
+			/* equal -> no need to add */
+		if (lin_p->start_sect == bsd_p->p_offset && 
+			lin_p->nr_sects == bsd_p->p_size) 
+			return;
+			/* bsd living within dos partition */
+		if (lin_p->start_sect <= bsd_p->p_offset && lin_p->start_sect 
+			+ lin_p->nr_sects >= bsd_p->p_offset + bsd_p->p_size) {
+#ifdef DEBUG_BSD_DISKLABEL
+			printk("w: %d %ld+%ld,%d+%d", 
+				lin_p - hd->part, 
+				lin_p->start_sect, lin_p->nr_sects, 
+				bsd_p->p_offset, bsd_p->p_size);
+#endif
+			break;
+		}
+	 /* ouch: bsd and linux overlap. Don't even try for that partition */
+#ifdef DEBUG_BSD_DISKLABEL
+		printk("???: %d %ld+%ld,%d+%d",
+			lin_p - hd->part, lin_p->start_sect, lin_p->nr_sects,
+			bsd_p->p_offset, bsd_p->p_size);
+#endif
+		printk("???");
+		return;
+	} /* if the bsd partition is not currently known to linux, we end
+	   * up here 
+	   */
+	add_gd_partition(hd, current_minor, bsd_p->p_offset, bsd_p->p_size);
+	current_minor++;
+}
+
+/* 
+ * Create devices for BSD partitions listed in a disklabel, under a
+ * dos-like partition. See extended_partition() for more information.
+ */
+static void bsd_disklabel_partition(struct gendisk *hd, int minor, int type) {
+	struct buffer_head *bh;
+	struct bsd_disklabel *l;
+	struct bsd_partition *p;
+	int max_partitions;
+	int mask = (1 << hd->minor_shift) - 1;
+	char buf[40];
+
+	if (!(bh = get_partition_table_block(hd, minor, 0)))
+		return;
+	l = (struct bsd_disklabel *) (bh->b_data+512);
+	if (l->d_magic != BSD_DISKMAGIC) {
+		brelse(bh);
+		return;
+	}
+	printk(" %s:", disk_name(hd, minor, buf));
+	printk((type == OPENBSD_PARTITION) ? " <openbsd:" :
+	       (type == NETBSD_PARTITION) ? " <netbsd:" : " <bsd:");
+
+	max_partitions = ((type == OPENBSD_PARTITION) ? OPENBSD_MAXPARTITIONS
+			                              : BSD_MAXPARTITIONS);
+	if (l->d_npartitions < max_partitions)
+		max_partitions = l->d_npartitions;
+	for (p = l->d_partitions; p - l->d_partitions <  max_partitions; p++) {
+		if ((current_minor & mask) >= (4 + hd->max_p))
+			break;
+
+		if (p->p_fstype != BSD_FS_UNUSED) 
+			check_and_add_bsd_partition(hd, p, minor);
+	}
+
+	/* Use bforget(), as we have changed the disk setup */
+	bforget(bh);
+
+	printk(" >\n");
+}
+#endif
+
+#ifdef CONFIG_UNIXWARE_DISKLABEL
+/*
+ * Create devices for Unixware partitions listed in a disklabel, under a
+ * dos-like partition. See extended_partition() for more information.
+ */
+static void unixware_partition(struct gendisk *hd, int minor) {
+	struct buffer_head *bh;
+	struct unixware_disklabel *l;
+	struct unixware_slice *p;
+	int mask = (1 << hd->minor_shift) - 1;
+	char buf[40];
+
+	if (!(bh = get_partition_table_block(hd, minor, 14)))
+		return;
+	l = (struct unixware_disklabel *) (bh->b_data+512);
+	if (le32_to_cpu(l->d_magic) != UNIXWARE_DISKMAGIC ||
+	    le32_to_cpu(l->vtoc.v_magic) != UNIXWARE_DISKMAGIC2) {
+		brelse(bh);
+		return;
+	}
+	printk(" %s: <unixware:", disk_name(hd, minor, buf));
+	p = &l->vtoc.v_slice[1];
+	/* I omit the 0th slice as it is the same as whole disk. */
+	while (p - &l->vtoc.v_slice[0] < UNIXWARE_NUMSLICE) {
+		if ((current_minor & mask) == 0)
+			break;
+
+		if (p->s_label != UNIXWARE_FS_UNUSED) {
+			add_gd_partition(hd, current_minor, START_SECT(p),
+					 NR_SECTS(p));
+			current_minor++;
+		}
+		p++;
+	}
+	/* Use bforget, as we have changed the disk setup */
+	bforget(bh);
+	printk(" >\n");
+}
+#endif
+
+static int
+msdos_partition(struct gendisk *hd, kdev_t dev,
+		    unsigned long first_sector, int first_part_minor) {
+	int i, minor = current_minor = first_part_minor;
+	struct buffer_head *bh;
+	struct partition *p;
+	unsigned char *data;
+	int mask = (1 << hd->minor_shift) - 1;
+	int sector_size = get_hardsect_size(dev) / 512;
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+	int tested_for_xlate = 0;
+
+read_mbr:
+#endif /* (CONFIG_BLK_DEV_IDE) || (CONFIG_BLK_DEV_IDE_MODULE) */
+	if (!(bh = bread(dev,0,get_ptable_blocksize(dev)))) {
+		if (warn_no_part) printk(" unable to read partition table\n");
+		return -1;
+	}
+	data = bh->b_data;
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+check_table:
+#endif /* (CONFIG_BLK_DEV_IDE) || (CONFIG_BLK_DEV_IDE_MODULE) */
+	/* Use bforget(), because we may have changed the disk geometry */
+	if (*(unsigned short *)  (0x1fe + data) != cpu_to_le16(MSDOS_LABEL_MAGIC)) {
+		bforget(bh);
+		return 0;
+	}
+	p = (struct partition *) (0x1be + data);
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+	if (!tested_for_xlate++) {	/* Do this only once per disk */
+		/*
+		 * Look for various forms of IDE disk geometry translation
+		 */
+		unsigned int sig = le16_to_cpu(*(unsigned short *)(data + 2));
+		int heads = 0;
+		/*
+		 * The i386 partition handling programs very often
+		 * make partitions end on cylinder boundaries.
+		 * There is no need to do so, and Linux fdisk doesnt always
+		 * do this, and Windows NT on Alpha doesnt do this either,
+		 * but still, this helps to guess #heads.
+		 */
+		for (i = 0; i < 4; i++) {
+			struct partition *q = &p[i];
+			if (NR_SECTS(q)) {
+				if ((q->sector & 63) == 1 &&
+				    (q->end_sector & 63) == 63)
+					heads = q->end_head + 1;
+				break;
+			}
+		}
+		if (SYS_IND(p) == EZD_PARTITION) {
+			/*
+			 * Accesses to sector 0 must go to sector 1 instead.
+			 */
+			if (ide_xlate_1024(dev, -1, heads, " [EZD]")) {
+				data += 512;
+				goto check_table;
+			}
+		} else if (SYS_IND(p) == DM6_PARTITION) {
+
+			/*
+			 * Everything on the disk is offset by 63 sectors,
+			 * including a "new" MBR with its own partition table.
+			 */
+			if (ide_xlate_1024(dev, 1, heads, " [DM6:DDO]")) {
+				bforget(bh);
+				goto read_mbr;	/* start over with new MBR */
+			}
+		} else if (sig <= 0x1ae &&
+			   data[sig] == 0xAA && data[sig+1] == 0x55 &&
+			   (data[sig+2] & 1)) {
+			/* DM6 signature in MBR, courtesy of OnTrack */
+			(void) ide_xlate_1024 (dev, 0, heads, " [DM6:MBR]");
+		} else if (SYS_IND(p) == DM6_AUX1PARTITION ||
+			   SYS_IND(p) == DM6_AUX3PARTITION) {
+			/*
+			 * DM6 on other than the first (boot) drive
+			 */
+			(void) ide_xlate_1024(dev, 0, heads, " [DM6:AUX]");
+		} else {
+			(void) ide_xlate_1024(dev, 2, heads, " [PTBL]");
+		}
+	}
+#endif /* (CONFIG_BLK_DEV_IDE) || (CONFIG_BLK_DEV_IDE_MODULE) */
+
+	/* Look for partitions in two passes:
+	   First find the primary partitions, and the DOS-type extended partitions.
+	   On the second pass look inside *BSD and Unixware and Solaris partitions. */
+
+	current_minor += 4;  /* first "extra" minor (for extended partitions) */
+	for (i=1 ; i<=4 ; minor++,i++,p++) {
+		if (!NR_SECTS(p))
+			continue;
+		add_gd_partition(hd, minor, first_sector+START_SECT(p)*sector_size,
+				 NR_SECTS(p)*sector_size);
+#if CONFIG_BLK_DEV_MD && CONFIG_AUTODETECT_RAID
+		if (SYS_IND(p) == LINUX_RAID_PARTITION) {
+			md_autodetect_dev(MKDEV(hd->major,minor));
+		}
+#endif
+		if (is_extended_partition(p)) {
+			printk(" <");
+			/*
+			 * If we are rereading the partition table, we need
+			 * to set the size of the partition so that we will
+			 * be able to bread the block containing the extended
+			 * partition info.
+			 */
+			hd->sizes[minor] = hd->part[minor].nr_sects 
+			  	>> (BLOCK_SIZE_BITS - 9);
+			extended_partition(hd, MKDEV(hd->major, minor));
+			printk(" >");
+			/* prevent someone doing mkfs or mkswap on an
+			   extended partition, but leave room for LILO */
+			if (hd->part[minor].nr_sects > 2)
+				hd->part[minor].nr_sects = 2;
+		}
+	}
+
+	/*
+	 *  Check for old-style Disk Manager partition table
+	 */
+	if (*(unsigned short *) (data+0xfc) == cpu_to_le16(MSDOS_LABEL_MAGIC)) {
+		p = (struct partition *) (0x1be + data);
+		for (i = 4 ; i < 16 ; i++, current_minor++) {
+			p--;
+			if ((current_minor & mask) == 0)
+				break;
+			if (!(START_SECT(p) && NR_SECTS(p)))
+				continue;
+			add_gd_partition(hd, current_minor, START_SECT(p), NR_SECTS(p));
+		}
+	}
+	printk("\n");
+
+	/* second pass - output for each on a separate line */
+	minor -= 4;
+	p = (struct partition *) (0x1be + data);
+	for (i=1 ; i<=4 ; minor++,i++,p++) {
+		if (!NR_SECTS(p))
+			continue;
+#ifdef CONFIG_BSD_DISKLABEL
+		if (SYS_IND(p) == BSD_PARTITION ||
+		    SYS_IND(p) == NETBSD_PARTITION ||
+		    SYS_IND(p) == OPENBSD_PARTITION)
+			bsd_disklabel_partition(hd, minor, SYS_IND(p));
+#endif
+#ifdef CONFIG_UNIXWARE_DISKLABEL
+		if (SYS_IND(p) == UNIXWARE_PARTITION)
+			unixware_partition(hd, minor);
+#endif
+#ifdef CONFIG_SOLARIS_X86_PARTITION
+		if(SYS_IND(p) == SOLARIS_X86_PARTITION)
+			solaris_x86_partition(hd, minor);
+#endif
+	}
+
+	bforget(bh);
+	return 1;
+}
+
+#define check_partition msdos_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/osf.c linux/fs/partitions/osf.c
--- linux-2.4.0-test10-pre6/fs/partitions/osf.c	Wed Feb 16 15:42:06 2000
+++ linux/fs/partitions/osf.c	Sat Oct 28 22:54:04 2000
@@ -17,8 +17,9 @@
 #include "check.h"
 #include "osf.h"
 
-int osf_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector,
-		  int current_minor)
+static int
+osf_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector,
+	      int current_minor)
 {
 	int i;
 	int mask = (1 << hd->minor_shift) - 1;
@@ -84,3 +85,5 @@
 	return 1;
 }
 
+#define check_partition osf_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/partition_module.h linux/fs/partitions/partition_module.h
--- linux-2.4.0-test10-pre6/fs/partitions/partition_module.h	Wed Dec 31 16:00:00 1969
+++ linux/fs/partitions/partition_module.h	Sat Oct 28 22:50:50 2000
@@ -0,0 +1,43 @@
+/* Copyright 2000 Yggdrasil Computing, Inc.
+   Written by Adam J. Richter
+
+   This file may be copied under the terms and conditions of version
+   2 of the GNU General Public License, as published by the Free
+   Software Foundation (Cambridge, Massachussetts, USA).
+
+*/
+
+/*
+  This file should be #include'ed by each partition handling module,
+  each of which #define check_partition to the name of its partition
+  checking routine, like so:
+
+  	#define check_partition msdos_partition
+	#include "partition_module.h"
+
+*/
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/init.h>
+
+static struct partition_ops ops = {
+  	check_partition,
+	NULL
+};
+
+static int __init
+init_partitioning(void)
+{
+	register_partition_ops(&ops);
+	return 0;
+}
+
+static void __exit
+cleanup_partitioning(void)
+{
+  	unregister_partition_ops(&ops);
+}
+
+module_init(init_partitioning);
+module_exit(cleanup_partitioning);
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/sgi.c linux/fs/partitions/sgi.c
--- linux-2.4.0-test10-pre6/fs/partitions/sgi.c	Sun Mar 12 19:39:39 2000
+++ linux/fs/partitions/sgi.c	Sat Oct 28 22:54:04 2000
@@ -17,7 +17,9 @@
 #include "check.h"
 #include "sgi.h"
 
-int sgi_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector, int current_minor)
+static int
+sgi_partition(struct gendisk *hd, kdev_t dev,
+	      unsigned long first_sector, int current_minor)
 {
 	int i, csum, magic;
 	unsigned int *ui, start, blocks, cs;
@@ -84,3 +86,6 @@
 	brelse(bh);
 	return 1;
 }
+
+#define check_partition sgi_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/sun.c linux/fs/partitions/sun.c
--- linux-2.4.0-test10-pre6/fs/partitions/sun.c	Wed Feb 16 15:42:06 2000
+++ linux/fs/partitions/sun.c	Sat Oct 28 22:54:04 2000
@@ -19,7 +19,8 @@
 #include "check.h"
 #include "sun.h"
 
-int sun_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector, int first_part_minor)
+static int
+sun_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector, int first_part_minor)
 {
 	int i, csum;
 	unsigned short *ush;
@@ -87,3 +88,5 @@
 	return 1;
 }
 
+#define check_partition sun_partition
+#include "partition_module.h"
diff --new-file -u -r linux-2.4.0-test10-pre6/fs/partitions/ultrix.c linux/fs/partitions/ultrix.c
--- linux-2.4.0-test10-pre6/fs/partitions/ultrix.c	Sun Jul  9 22:21:41 2000
+++ linux/fs/partitions/ultrix.c	Sat Oct 28 22:54:04 2000
@@ -14,8 +14,9 @@
 
 #include "check.h"
 
-int ultrix_partition(struct gendisk *hd, kdev_t dev,
-                            unsigned long first_sector, int first_part_minor)
+static int
+ultrix_partition(struct gendisk *hd, kdev_t dev,
+		 unsigned long first_sector, int first_part_minor)
 {
 	int i;
 	struct buffer_head *bh;
@@ -58,3 +59,6 @@
 		return 0;
 	}
 }
+
+#define check_partition ultrix_partition
+#include "partition_module.h"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
