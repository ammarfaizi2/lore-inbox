Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJ1Ran>; Mon, 28 Oct 2002 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSJ1Ran>; Mon, 28 Oct 2002 12:30:43 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:60687 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261395AbSJ1RXq>; Mon, 28 Oct 2002 12:23:46 -0500
Date: Tue, 29 Oct 2002 02:30:06 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 8/23] add support for PC-9800 architecture (fs)
Message-ID: <20021029023006.A2265@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 8/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 file system modules
  - add support PC-9800 partition table.
  - small hack for access FAT partition made by PC-9800 DOS.

diffstat:
 fs/fat/inode.c          |    9 +
 fs/partitions/Config.in |    8 +
 fs/partitions/Makefile  |    1 
 fs/partitions/check.c   |    4 
 fs/partitions/msdos.c   |   15 ++
 fs/partitions/nec98.c   |  281 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/nec98.h   |   10 +
 7 files changed, 327 insertions(+), 1 deletion(-)

patch:
diff -urN linux/fs/fat/inode.c linux98/fs/fat/inode.c
--- linux/fs/fat/inode.c	Wed Oct 16 13:20:44 2002
+++ linux98/fs/fat/inode.c	Wed Oct 16 15:01:51 2002
@@ -10,6 +10,7 @@
  *  	Max Cohan: Fixed invalid FSINFO offset when info_sector is 0
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/time.h>
 #include <linux/slab.h>
@@ -979,7 +980,13 @@
 		error = first;
 		goto out_fail;
 	}
-	if (FAT_FIRST_ENT(sb, media) != first) {
+#ifndef CONFIG_PC9800
+	if (FAT_FIRST_ENT(sb, media) != first)
+#else
+	if (FAT_FIRST_ENT(sb, media) != first
+	    && (media != 0xf8 || (first & 0xff) != 0xfe))
+#endif
+	{
 		if (!silent) {
 			printk("FAT: invalid first entry of FAT "
 			       "(0x%x != 0x%x)\n",
diff -urN linux/fs/partitions/Config.in linux98/fs/partitions/Config.in
--- linux/fs/partitions/Config.in	Sat Oct 19 13:02:28 2002
+++ linux98/fs/partitions/Config.in	Sat Oct 19 16:58:53 2002
@@ -29,6 +29,10 @@
    if [ "$CONFIG_LDM_PARTITION" = "y" ]; then
       bool '    Windows LDM extra logging' CONFIG_LDM_DEBUG
    fi
+   bool '  NEC PC-9800 partition table support' CONFIG_NEC98_PARTITION
+   if [ "$CONFIG_NEC98_PARTITION" = "y" ]; then
+      bool '    BSD disklabel support for NEC PC-9800 type partitions' CONFIG_NEC98_BSD_DISKLABEL
+   fi
    bool '  SGI partition support' CONFIG_SGI_PARTITION
    bool '  Ultrix partition table support' CONFIG_ULTRIX_PARTITION
    bool '  Sun partition tables support' CONFIG_SUN_PARTITION
@@ -37,11 +41,15 @@
    if [ "$CONFIG_ALPHA" = "y" ]; then
       define_bool CONFIG_OSF_PARTITION y
    fi
+   if [ "$CONFIG_PC9800" = "y" ]; then
+      define_bool CONFIG_NEC98_PARTITION y
+   else
    if [ "$CONFIG_AMIGA" != "y" -a "$CONFIG_ATARI" != "y" -a \
         "$CONFIG_MAC" != "y" -a "$CONFIG_SGI_IP22" != "y" -a \
 	"$CONFIG_ARM" != "y" -a "$CONFIG_SGI_IP27" != "y" ]; then
       define_bool CONFIG_MSDOS_PARTITION y
    fi
+   fi
    if [ "$CONFIG_AMIGA" = "y" -o "$CONFIG_AFFS_FS" = "y" ]; then
       define_bool CONFIG_AMIGA_PARTITION y
    fi
diff -urN linux/fs/partitions/Makefile linux98/fs/partitions/Makefile
--- linux/fs/partitions/Makefile	Sat Oct 19 13:01:50 2002
+++ linux98/fs/partitions/Makefile	Sat Oct 19 17:00:39 2002
@@ -18,6 +18,7 @@
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
+obj-$(CONFIG_NEC98_PARTITION) += nec98.o msdos.o
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux/fs/partitions/check.c linux98/fs/partitions/check.c
--- linux/fs/partitions/check.c	Sat Oct 19 13:02:30 2002
+++ linux98/fs/partitions/check.c	Sat Oct 19 17:02:58 2002
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
diff -urN linux/fs/partitions/msdos.c linux98/fs/partitions/msdos.c
--- linux/fs/partitions/msdos.c	Sat Oct 12 13:22:10 2002
+++ linux98/fs/partitions/msdos.c	Sun Oct 13 22:23:58 2002
@@ -20,6 +20,11 @@
  */
 
 #include <linux/config.h>
+
+#ifdef CONFIG_NEC98_BSD_DISKLABEL
+# define CONFIG_BSD_DISKLABEL
+#endif
+
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #ifdef CONFIG_BLK_DEV_IDE
@@ -37,6 +42,7 @@
 #include "msdos.h"
 #include "efi.h"
 
+#if !defined(CONFIG_PC9800) || defined(CONFIG_MSDOS_PARTITION)
 /*
  * Many architectures don't like unaligned accesses, which is
  * frequently the case with the nr_sects and start_sect partition
@@ -171,6 +177,7 @@
 done:
 	put_dev_sector(sect);
 }
+#endif /* !defined(CONFIG_PC9800) || defined(CONFIG_MSDOS_PARTITION) */
 
 /* james@bpgc.com: Solaris has a nasty indicator: 0x82 which also
    indicates linux swap.  Be careful before believing this is Solaris. */
@@ -179,6 +186,7 @@
 parse_solaris_x86(struct parsed_partitions *state, struct block_device *bdev,
 			u32 offset, u32 size, int origin)
 {
+#if !defined(CONFIG_PC9800) || defined(CONFIG_MSDOS_PARTITION)
 #ifdef CONFIG_SOLARIS_X86_PARTITION
 	Sector sect;
 	struct solaris_x86_vtoc *v;
@@ -212,6 +220,7 @@
 	put_dev_sector(sect);
 	printk(" >\n");
 #endif
+#endif /* !defined(CONFIG_PC9800) || defined(CONFIG_MSDOS_PARTITION) */
 }
 
 #ifdef CONFIG_BSD_DISKLABEL
@@ -219,7 +228,11 @@
  * Create devices for BSD partitions listed in a disklabel, under a
  * dos-like partition. See parse_extended() for more information.
  */
+#ifndef CONFIG_NEC98_BSD_DISKLABEL
 static void
+#else
+void
+#endif
 parse_bsd(struct parsed_partitions *state, struct block_device *bdev,
 		u32 offset, u32 size, int origin, char *flavour,
 		int max_partitions)
@@ -292,6 +305,7 @@
 #endif
 }
 
+#if !defined(CONFIG_PC9800) || defined(CONFIG_MSDOS_PARTITION)
 /*
  * Create devices for Unixware partitions listed in a disklabel, under a
  * dos-like partition. See parse_extended() for more information.
@@ -461,3 +475,4 @@
 	put_dev_sector(sect);
 	return 1;
 }
+#endif /* !defined(CONFIG_PC9800) || defined(CONFIG_MSDOS_PARTITION) */
diff -urN linux/fs/partitions/nec98.c linux98/fs/partitions/nec98.c
--- linux/fs/partitions/nec98.c	Thu Jan  1 09:00:00 1970
+++ linux98/fs/partitions/nec98.c	Sat Oct 19 21:13:20 2002
@@ -0,0 +1,281 @@
+/*
+ *  NEC PC-9800 series partition supports
+ *
+ *  Copyright (C) 1999	Kyoto University Microcomputer Club
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_NEC98_BSD_DISKLABEL
+#define CONFIG_BSD_DISKLABEL
+#endif
+
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
+#include "../../drivers/scsi/sd.h"
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
+#ifdef CONFIG_NEC98_BSD_DISKLABEL
+extern void parse_bsd(struct parsed_partitions *state,
+			struct block_device *bdev,
+			u32 offset, u32 size, int origin, char *flavour,
+			int max_partitions);
+#endif
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
+		extern Scsi_Disk * sd_get_sdisk(int);
+#define SCSI_DEVICE_NR(device) (((major(device) & SD_MAJOR_MASK) << (8 - 4)) + (minor(device) >> 4))
+		Scsi_Disk *disk	= sd_get_sdisk(SCSI_DEVICE_NR(to_kdev_t(bdev->bd_dev)));
+		struct Scsi_Host *host = disk->device->host;
+		int diskinfo[3] = { 0, 0, 0 };
+
+		if(host->hostt->bios_param)
+			host->hostt->bios_param(disk, bdev, diskinfo);
+		else
+			scsicam_bios_param(disk, bdev, diskinfo);
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
+#ifdef CONFIG_NEC98_BSD_DISKLABEL
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
diff -urN linux/fs/partitions/nec98.h linux98/fs/partitions/nec98.h
--- linux/fs/partitions/nec98.h	Thu Jan  1 09:00:00 1970
+++ linux98/fs/partitions/nec98.h	Fri Jul 26 11:10:08 2002
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
