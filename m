Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278824AbRJ1Wvz>; Sun, 28 Oct 2001 17:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278845AbRJ1Wvq>; Sun, 28 Oct 2001 17:51:46 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:59643 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278824AbRJ1Wvd>; Sun, 28 Oct 2001 17:51:33 -0500
Subject: [PATCH] 2.4.13-ac4 LDM update 
To: alan@lxorguk.ukuu.org.uk
Date: Sun, 28 Oct 2001 22:52:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15xymn-0004st-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Please apply below patch for the next -ac release. It updates the LDM
driver and introduces sorting of the LDM partitions by on-disk position.

This means that the partition minors in linux will be constant across
reboots into Windows 2k/XP.

Thanks go to FlatCap (Richard Russon) for testing the patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.4.13-ac4-ldm.patch ---
diff -u -urN linux-2.4.13-ac4-vanilla/fs/partitions/ldm.c linux-2.4.13-ac4-ldm/fs/partitions/ldm.c
--- linux-2.4.13-ac4-vanilla/fs/partitions/ldm.c	Sun Oct 28 20:44:28 2001
+++ linux-2.4.13-ac4-ldm/fs/partitions/ldm.c	Sun Oct 28 20:45:35 2001
@@ -1,10 +1,8 @@
 /*
- * $Id: ldm.c,v 1.25 2001/07/25 23:32:02 flatcap Exp $
- *
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001 Richard Russon <ntfs@flatcap.org>
- * Copyright (C) 2001 Anton Altaparmakov <antona@users.sf.net>
+ * Copyright (C) 2001 Anton Altaparmakov <antona@users.sf.net> (AIA)
  *
  * Documentation is available at http://linux-ntfs.sf.net/ldm
  *
@@ -22,6 +20,8 @@
  * along with this program (in the main directory of the Linux-NTFS source
  * in the file COPYING); if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * 28/10/2001 - Added sorting of ldm partitions. (AIA)
  */
 #include <linux/types.h>
 #include <asm/unaligned.h>
@@ -158,6 +158,60 @@
 }
 
 /**
+ * add_partition_to_list - insert partition into a partition list
+ * @pl:		sorted list of partitions
+ * @hd:		gendisk structure to which the data partition belongs
+ * @disk_minor:	minor number of the disk device
+ * @start:	first sector within the disk device
+ * @size:	number of sectors on the partition device
+ *
+ * This sanity checks the partition specified by @start and @size against the
+ * device specified by @hd and inserts the partition into the sorted partition
+ * list @pl if the checks pass.
+ *
+ * On success return 1, otherwise return -1.
+ *
+ * TODO: Add sanity check for overlapping partitions. (AIA)
+ */ 
+static int add_partition_to_list(struct list_head *pl, const struct gendisk *hd,
+		const int disk_minor, const unsigned long start,
+		const unsigned long size)
+{
+	struct ldm_part *lp, *lptmp;
+	struct list_head *tmp;
+
+	if (!hd->part)
+		return -1;
+	if ((start < 1) || ((start + size) > hd->part[disk_minor].nr_sects)) {
+		printk(LDM_CRIT "LDM partition exceeds physical disk. "
+				"Skipping.\n");
+		return -1;
+	}
+	lp = (struct ldm_part*)kmalloc(sizeof(struct ldm_part), GFP_KERNEL);
+	if (!lp) {
+		printk(LDM_CRIT "Not enough memory! Aborting LDM partition "
+				"parsing.\n");
+		return -2;
+	}
+	INIT_LIST_HEAD(&lp->part_list);
+	lp->start = start;
+	lp->size = size;
+	list_for_each(tmp, pl) {
+		lptmp = list_entry(tmp, struct ldm_part, part_list);
+		if (start > lptmp->start)
+			continue;
+		if (start < lptmp->start)
+			break;
+		printk(LDM_CRIT "Duplicate LDM partition entry! Skipping.\n");
+		kfree(lp);
+		return -1;
+	}
+	list_add_tail(&lp->part_list, tmp);
+	ldm_debug("Added LDM partition successfully.\n");
+	return 1;
+}
+
+/**
  * create_data_partitions - create the data partition devices
  * @hd:			gendisk structure in which to create the data partitions
  * @first_sector:	first sector within the disk device
@@ -172,7 +226,10 @@
  * the partitions in the database that belong to this disk.
  *
  * For each found partition, we create a corresponding partition device starting
- * with minor number @first_part_minor.
+ * with minor number @first_part_minor. But we do this in such a way that we
+ * actually sort the partitions in order of on-disk position. Any invalid
+ * partitions are completely ignored/skipped (an error is output but that's
+ * all).
  *
  * Return 1 on success and -1 on error.
  */
@@ -182,13 +239,16 @@
 		const struct privhead *ph, const struct ldmdisk *dk,
 		unsigned long base)
 {
-	Sector  sect;
+	Sector sect;
 	unsigned char *data;
 	struct vblk *vb;
+	LIST_HEAD(pl);		/* Sorted list of partitions. */
+	struct ldm_part *lp;
+	struct list_head *tmp;
 	int vblk;
 	int vsize;		/* VBLK size. */
 	int perbuf;		/* VBLKs per buffer. */
-	int buffer, lastbuf, lastofs, err;
+	int buffer, lastbuf, lastofs, err, disk_minor;
 
 	vb = (struct vblk*)kmalloc(sizeof(struct vblk), GFP_KERNEL);
 	if (!vb)
@@ -207,7 +267,11 @@
 	if (OFF_VBLK * LDM_BLOCKSIZE + vm->last_vblk_seq * vsize >
 			ph->config_size * 512)
 		goto err_out;
-	printk(" <");
+	/*
+	 * Get the minor number of the parent device so we can check we don't
+	 * go beyond the end of the device.
+	 */
+	disk_minor = (first_part_minor >> hd->minor_shift) << hd->minor_shift;
 	for (buffer = 0; buffer < lastbuf; buffer++) {
 		data = read_dev_sector(bdev, base + 2*OFF_VBLK + buffer, &sect);
 		if (!data)
@@ -226,17 +290,34 @@
 				continue;
 			if (dk->obj_id != vb->disk_id)
 				continue;
-			if (create_partition(hd, first_part_minor,
+			/* Ignore invalid partition errors. */
+			if (add_partition_to_list(&pl, hd, disk_minor,
 					first_sector + vb->start_sector +
 					ph->logical_disk_start,
-					vb->num_sectors) == 1)
-				first_part_minor++;
+					vb->num_sectors) < -1)
+				goto brelse_out;
 		}
 		put_dev_sector(sect);
 	}
-	printk(" >\n");
 	err = 1;
 out:
+	/* Finally create the nicely sorted data partitions. */
+	printk(" <");
+	list_for_each(tmp, &pl) {
+		lp = list_entry(tmp, struct ldm_part, part_list);
+		add_gd_partition(hd, first_part_minor++, lp->start, lp->size);
+	}
+	printk(" >\n");
+	if (!list_empty(&pl)) {
+		struct list_head *tmp2;
+
+		/* Cleanup the partition list which is now superfluous. */
+		list_for_each_safe(tmp, tmp2, &pl) {
+			lp = list_entry(tmp, struct ldm_part, part_list);
+			list_del(tmp);
+			kfree(lp);
+		}
+	}
 	kfree(vb);
 	return err;
 brelse_out:
diff -u -urN linux-2.4.13-ac4-vanilla/fs/partitions/ldm.h linux-2.4.13-ac4-ldm/fs/partitions/ldm.h
--- linux-2.4.13-ac4-vanilla/fs/partitions/ldm.h	Wed Oct 24 06:01:26 2001
+++ linux-2.4.13-ac4-ldm/fs/partitions/ldm.h	Sun Oct 28 20:45:35 2001
@@ -144,6 +144,12 @@
 	u64	num_sectors;
 };
 
+struct ldm_part {
+	struct list_head part_list;
+	unsigned long start;
+	unsigned long size;
+};
+
 int ldm_partition(struct gendisk *hd, struct block_device *bdev,
 		unsigned long first_sector, int first_part_minor);
 
