Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTCUSkr>; Fri, 21 Mar 2003 13:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263763AbTCUSkE>; Fri, 21 Mar 2003 13:40:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11140
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263743AbTCUSig>; Fri, 21 Mar 2003 13:38:36 -0500
Date: Fri, 21 Mar 2003 19:53:51 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211953.h2LJrpEC026103@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Add NEC PC9800 partition tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/partitions/check.c linux-2.5.65-ac2/fs/partitions/check.c
--- linux-2.5.65/fs/partitions/check.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/partitions/check.c	2003-03-18 17:09:18.000000000 +0000
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/partitions/Kconfig linux-2.5.65-ac2/fs/partitions/Kconfig
--- linux-2.5.65/fs/partitions/Kconfig	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/fs/partitions/Kconfig	2003-03-06 23:43:48.000000000 +0000
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/partitions/Makefile linux-2.5.65-ac2/fs/partitions/Makefile
--- linux-2.5.65/fs/partitions/Makefile	2003-02-10 18:38:28.000000000 +0000
+++ linux-2.5.65-ac2/fs/partitions/Makefile	2003-03-06 23:43:48.000000000 +0000
@@ -16,3 +16,4 @@
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
+obj-$(CONFIG_NEC98_PARTITION) += nec98.o msdos.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/partitions/nec98.c linux-2.5.65-ac2/fs/partitions/nec98.c
--- linux-2.5.65/fs/partitions/nec98.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/fs/partitions/nec98.c	2003-03-06 23:43:48.000000000 +0000
@@ -0,0 +1,197 @@
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
+#include <linux/hdreg.h>
+
+#include "check.h"
+#include "nec98.h"
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
+extern int pc98_bios_param(struct block_device *bdev, int *ip);
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
+int nec98_partition(struct parsed_partitions *state, struct block_device *bdev)
+{
+	unsigned int nr;
+	struct hd_geometry geo;
+	Sector sect;
+	const struct nec98_partition *part;
+	unsigned char *data;
+	int sector_size = bdev_hardsect_size(bdev);
+	int major = MAJOR(bdev->bd_dev);
+
+	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)&geo) != 0) {
+		printk(" unsupported disk (major = %u)\n", major);
+		return 0;
+	}
+
+#ifdef NEC98_PARTITION_DEBUG
+	printk("ioctl_by_bdev head=%d sect=%d\n", geo.heads, geo.sectors);
+#endif
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
+					     geo.sectors, geo.heads)) {
+#ifdef NEC98_PARTITION_DEBUG
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
+		start_sect = (part->cyl * geo.heads + part->head) * geo.sectors
+			+ part->sector;
+		end_sect = (part->end_cyl + 1) * geo.heads * geo.sectors;
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/partitions/nec98.h linux-2.5.65-ac2/fs/partitions/nec98.h
--- linux-2.5.65/fs/partitions/nec98.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/fs/partitions/nec98.h	2003-03-06 23:43:48.000000000 +0000
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
