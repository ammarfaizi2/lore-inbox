Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTBLNkt>; Wed, 12 Feb 2003 08:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBLNjk>; Wed, 12 Feb 2003 08:39:40 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:33664 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267157AbTBLNjG>; Wed, 12 Feb 2003 08:39:06 -0500
Date: Wed, 12 Feb 2003 22:47:45 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (15/34) FS
Message-ID: <20030212134745.GP1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (15/34).

FAT fs and partition table support.

- Osamu Tomita

diff -Nru linux/fs/fat/inode.c linux98/fs/fat/inode.c
--- linux/fs/fat/inode.c	2003-01-02 12:21:53.000000000 +0900
+++ linux98/fs/fat/inode.c	2003-01-04 20:02:52.000000000 +0900
@@ -939,7 +939,9 @@
 		error = first;
 		goto out_fail;
 	}
-	if (FAT_FIRST_ENT(sb, media) != first) {
+	if (FAT_FIRST_ENT(sb, media) != first
+	    && (!pc98 || media != 0xf8 || (first & 0xff) != 0xfe))
+	{
 		if (!silent) {
 			printk(KERN_ERR "FAT: invalid first entry of FAT "
 			       "(0x%x != 0x%x)\n",
diff -Nru linux/fs/partitions/Kconfig linux98/fs/partitions/Kconfig
--- linux/fs/partitions/Kconfig	2002-11-28 07:36:18.000000000 +0900
+++ linux98/fs/partitions/Kconfig	2002-12-12 14:27:58.000000000 +0900
@@ -177,6 +177,13 @@
 
 	  If unsure, say N.
 
+config NEC98_PARTITION
+	bool "NEC PC-9800 partition table support" if PARTITION_ADVANCED
+	default y if !PARTITION_ADVANCED && X86_PC9800
+	help
+	  Say Y here if you would like to be able to read the hard disk
+	  partition table format used by NEC PC-9800 machines.
+
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
 	default y if !PARTITION_ADVANCED && (SGI_IP22 || SGI_IP27)
diff -Nru linux-2.5.60/fs/partitions/Makefile linux98-2.5.60/fs/partitions/Makefile
--- linux-2.5.60/fs/partitions/Makefile	2003-02-11 03:38:28.000000000 +0900
+++ linux98-2.5.60/fs/partitions/Makefile	2003-02-11 12:50:18.000000000 +0900
@@ -16,3 +16,4 @@
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
+obj-$(CONFIG_NEC98_PARTITION) += nec98.o msdos.o
diff -Nru linux/fs/partitions/check.c linux98/fs/partitions/check.c
--- linux/fs/partitions/check.c	2003-01-09 13:04:25.000000000 +0900
+++ linux98/fs/partitions/check.c	2003-01-10 10:19:55.000000000 +0900
@@ -28,6 +28,7 @@
 #include "ldm.h"
 #include "mac.h"
 #include "msdos.h"
+#include "nec98.h"
 #include "osf.h"
 #include "sgi.h"
 #include "sun.h"
@@ -51,6 +52,9 @@
 #ifdef CONFIG_LDM_PARTITION
 	ldm_partition,		/* this must come before msdos */
 #endif
+#ifdef CONFIG_NEC98_PARTITION
+	nec98_partition,	/* must be come before `msdos_partition' */
+#endif
 #ifdef CONFIG_MSDOS_PARTITION
 	msdos_partition,
 #endif
diff -Nru linux/fs/partitions/msdos.c linux98/fs/partitions/msdos.c
--- linux/fs/partitions/msdos.c	2002-11-28 07:36:05.000000000 +0900
+++ linux98/fs/partitions/msdos.c	2002-12-12 14:36:18.000000000 +0900
@@ -219,7 +219,7 @@
  * Create devices for BSD partitions listed in a disklabel, under a
  * dos-like partition. See parse_extended() for more information.
  */
-static void
+void
 parse_bsd(struct parsed_partitions *state, struct block_device *bdev,
 		u32 offset, u32 size, int origin, char *flavour,
 		int max_partitions)
diff -Nru linux/fs/partitions/nec98.c linux98/fs/partitions/nec98.c
--- linux/fs/partitions/nec98.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98/fs/partitions/nec98.c	2002-12-12 14:22:11.000000000 +0900
@@ -0,0 +1,272 @@
+/*
+ *  NEC PC-9800 series partition supports
+ *
+ *  Copyright (C) 1999	Kyoto University Microcomputer Club
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/blk.h>
+#include <linux/major.h>
+
+#include "check.h"
+#include "nec98.h"
+
+/* #ifdef CONFIG_BLK_DEV_IDEDISK */
+#include <linux/ide.h>
+/* #endif */
+
+/* #ifdef CONFIG_BLK_DEV_SD */
+#include "../../drivers/scsi/scsi.h"
+#include "../../drivers/scsi/hosts.h"
+#include <scsi/scsicam.h>
+/* #endif */
+
+struct nec98_partition {
+	__u8	mid;		/* 0x80 - active */
+	__u8	sid;		/* 0x80 - bootable */
+	__u16	pad1;		/* dummy for padding */
+	__u8	ipl_sector;	/* IPL sector	*/
+	__u8	ipl_head;	/* IPL head	*/
+	__u16	ipl_cyl;	/* IPL cylinder	*/
+	__u8	sector;		/* starting sector	*/
+	__u8	head;		/* starting head	*/
+	__u16	cyl;		/* starting cylinder	*/
+	__u8	end_sector;	/* end sector	*/
+	__u8	end_head;	/* end head	*/
+	__u16	end_cyl;	/* end cylinder	*/
+	unsigned char name[16];
+} __attribute__((__packed__));
+
+#define NEC98_BSD_PARTITION_MID 0x14
+#define NEC98_BSD_PARTITION_SID 0x44
+#define MID_SID_16(mid, sid)	(((mid) & 0xFF) | (((sid) & 0xFF) << 8))
+#define NEC98_BSD_PARTITION_MID_SID	\
+	MID_SID_16(NEC98_BSD_PARTITION_MID, NEC98_BSD_PARTITION_SID)
+#define NEC98_VALID_PTABLE_ENTRY(P) \
+	(!(P)->pad1 && (P)->cyl <= (P)->end_cyl)
+
+static inline int
+is_valid_nec98_partition_table(const struct nec98_partition *ptable,
+				__u8 nsectors, __u8 nheads)
+{
+	int i;
+	int valid = 0;
+
+	for (i = 0; i < 16; i++) {
+		if (!*(__u16 *)&ptable[i])
+			continue;	/* empty slot */
+		if (ptable[i].pad1	/* `pad1' contains junk */
+		    || ptable[i].ipl_sector	>= nsectors
+		    || ptable[i].sector		>= nsectors
+		    || ptable[i].end_sector	>= nsectors
+		    || ptable[i].ipl_head	>= nheads
+		    || ptable[i].head		>= nheads
+		    || ptable[i].end_head	>= nheads
+		    || ptable[i].cyl > ptable[i].end_cyl)
+			return 0;
+		valid = 1;	/* We have a valid partition.  */
+	}
+	/* If no valid PC-9800-style partitions found,
+	   the disk may have other type of partition table.  */
+	return valid;
+}
+
+#ifdef CONFIG_BSD_DISKLABEL
+extern void parse_bsd(struct parsed_partitions *state,
+			struct block_device *bdev,
+			u32 offset, u32 size, int origin, char *flavour,
+			int max_partitions);
+#endif
+
+extern struct scsi_device *sd_find_params_by_bdev(struct block_device *, char **, sector_t *);
+
+int nec98_partition(struct parsed_partitions *state, struct block_device *bdev)
+{
+	unsigned int nr;
+	int g_head, g_sect;
+	Sector sect;
+	const struct nec98_partition *part;
+	unsigned char *data;
+	int sector_size = bdev_hardsect_size(bdev);
+	int major = major(to_kdev_t(bdev->bd_dev));
+	int minor = minor(to_kdev_t(bdev->bd_dev));
+
+	switch (major) {
+#if defined CONFIG_BLK_DEV_HD_ONLY
+	case HD_MAJOR:
+	{
+		extern struct hd_i_struct hd_info[2];
+
+		g_head = hd_info[minor >> 6].head;
+		g_sect = hd_info[minor >> 6].sect;
+		break;
+	}
+#endif /* CONFIG_BLK_DEV_HD_ONLY */
+#if defined CONFIG_BLK_DEV_SD || defined CONFIG_BLK_DEV_SD_MODULE
+	case SCSI_DISK0_MAJOR:
+	case SCSI_DISK1_MAJOR:
+	case SCSI_DISK2_MAJOR:
+	case SCSI_DISK3_MAJOR:
+	case SCSI_DISK4_MAJOR:
+	case SCSI_DISK5_MAJOR:
+	case SCSI_DISK6_MAJOR:
+	case SCSI_DISK7_MAJOR:
+	{
+		int diskinfo[3] = { 0, 0, 0 };
+		sector_t capacity;
+
+		(void)sd_find_params_by_bdev(bdev, NULL, &capacity);
+		scsicam_bios_param(bdev, capacity, diskinfo);
+
+		if ((g_head = diskinfo[0]) <= 0)
+			g_head = 8;
+		if ((g_sect = diskinfo[1]) <= 0)
+			g_sect = 17;
+		break;
+	}
+#endif /* CONFIG_BLK_DEV_SD(_MODULE) */
+#if defined CONFIG_BLK_DEV_IDEDISK || defined CONFIG_BLK_DEV_IDEDISK_MODULE
+	case IDE0_MAJOR:
+	case IDE1_MAJOR:
+	case IDE2_MAJOR:
+	case IDE3_MAJOR:
+	case IDE4_MAJOR:
+	case IDE5_MAJOR:
+	case IDE6_MAJOR:
+	case IDE7_MAJOR:
+	case IDE8_MAJOR:
+	case IDE9_MAJOR:
+	{
+		ide_drive_t *drive;
+		unsigned int	h;
+
+		for (h = 0; h < MAX_HWIFS; ++h) {
+			ide_hwif_t  *hwif = &ide_hwifs[h];
+			if (hwif->present && major == hwif->major) {
+				unsigned unit = minor >> PARTN_BITS;
+				if (unit < MAX_DRIVES) {
+					drive = &hwif->drives[unit];
+					if (drive->present) {
+						g_head = drive->head;
+						g_sect = drive->sect;
+						goto found;
+					}
+				}
+				break;
+			}
+		}
+	}
+#endif /* CONFIG_BLK_DEV_IDEDISK(_MODULE) */
+	default:
+		printk(" unsupported disk (major = %u)\n", major);
+		return 0;
+	}
+
+	found:
+	data = read_dev_sector(bdev, 0, &sect);
+	if (!data) {
+		if (warn_no_part)
+			printk(" unable to read partition table\n");
+		return -1;
+	}
+
+	/* magic(?) check */
+	if (*(__u16 *)(data + sector_size - 2) != NEC98_PTABLE_MAGIC) {
+		put_dev_sector(sect);
+		return 0;
+	}
+
+	put_dev_sector(sect);
+	data = read_dev_sector(bdev, 1, &sect);
+	if (!data) {
+		if (warn_no_part)
+			printk(" unable to read partition table\n");
+		return -1;
+	}
+
+	if (!is_valid_nec98_partition_table((struct nec98_partition *)data,
+					     g_sect, g_head)) {
+#if 0
+		if (warn_no_part)
+			printk(" partition table consistency check failed"
+				" (not PC-9800 disk?)\n");
+#endif
+		put_dev_sector(sect);
+		return 0;
+	}
+
+	part = (const struct nec98_partition *)data;
+	for (nr = 0; nr < 16; nr++, part++) {
+		unsigned int start_sect, end_sect;
+
+		if (part->mid == 0 || part->sid == 0)
+			continue;
+
+		if (nr)
+			printk("     ");
+
+		{	/* Print partition name. Fdisk98 might put NUL
+			   characters in partition name... */
+
+			int j;
+			unsigned char *p;
+			unsigned char buf[sizeof (part->name) * 2 + 1];
+
+			for (p = buf, j = 0; j < sizeof (part->name); j++, p++)
+				if ((*p = part->name[j]) < ' ') {
+					*p++ = '^';
+					*p = part->name[j] + '@';
+				}
+
+			*p = 0;
+			printk(" <%s>", buf);
+		}
+		start_sect = (part->cyl * g_head + part->head) * g_sect
+			+ part->sector;
+		end_sect = (part->end_cyl + 1) * g_head * g_sect;
+		if (end_sect <= start_sect) {
+			printk(" (invalid partition info)\n");
+			continue;
+		}
+
+		put_partition(state, nr + 1, start_sect, end_sect - start_sect);
+#ifdef CONFIG_BSD_DISKLABEL
+		if ((*(__u16 *)&part->mid & 0x7F7F)
+		    == NEC98_BSD_PARTITION_MID_SID) {
+			printk("!");
+			/* NEC98_BSD_PARTITION_MID_SID is not valid SYSIND for
+			   IBM PC's MS-DOS partition table, so we simply pass
+			   it to bsd_disklabel_partition;
+			   it will just print `<bsd: ... >'. */
+			parse_bsd(state, bdev, start_sect,
+					end_sect - start_sect, nr + 1,
+					"bsd98", BSD_MAXPARTITIONS);
+		}
+#endif
+		{	/* Pretty size printing. */
+			/* XXX sector size? */
+			unsigned int psize = (end_sect - start_sect) / 2;
+			int unit_char = 'K';
+
+			if (psize > 99999) {
+				psize >>= 10;
+				unit_char = 'M';
+			}
+			printk(" %5d%cB (%5d-%5d)\n", 
+			       psize, unit_char, part->cyl, part->end_cyl);
+		}
+	}
+
+	put_dev_sector(sect);
+
+	return nr ? 1 : 0;
+}
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -Nru linux/fs/partitions/nec98.h linux98/fs/partitions/nec98.h
--- linux/fs/partitions/nec98.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/fs/partitions/nec98.h	2002-07-26 11:10:08.000000000 +0900
@@ -0,0 +1,10 @@
+/*
+ *  NEC PC-9800 series partition supports
+ *
+ *  Copyright (C) 1998-2000	Kyoto University Microcomputer Club
+ */
+
+#define NEC98_PTABLE_MAGIC	0xAA55
+
+extern int nec98_partition(struct parsed_partitions *state,
+				struct block_device *bdev);
