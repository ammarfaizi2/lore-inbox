Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbTAPSFj>; Thu, 16 Jan 2003 13:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTAPSFj>; Thu, 16 Jan 2003 13:05:39 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:52098 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S267130AbTAPSFg>;
	Thu, 16 Jan 2003 13:05:36 -0500
Date: Thu, 16 Jan 2003 13:14:37 -0500
Message-Id: <200301161814.h0GIEbb02258@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] IDE OnTrack remap for 2.5.58
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I'm running a Seagate 80 GB disk in an old Pentium Pro dual processor.
I installed the current Redhat (phoebe) beta, and it works fine until
I try to boot a 2.5.58 kernel.  It fails to mount the root disk because
the disk has been setup with OnTrack remaping.  I didn't do anything
to ask for this remapping.  Perhaps Seagate is shipping with this pre-
installed?

I went back and looked through the patches and found that the remapping
support was removed in patch-2.5.30.  The comments in the mailing list
suggest that it belonged in user space.  I have not found code/instructions
on how to do this.  Since then, most of IDE code has been reverted to the
2.4 versions but not this bit.

The attached patch is just the bit of code which was removed in 2.5.30
with the obvious changes needed to make it work in a 2.5.58 kernel.
I have a dream of upgrading my test machine to something clean and modern
unpolluted by backwards compatible cruft.  Until then, this bit of code
doesn't seem too bad.

Jim Houston - Concurrent Computer Corp.


--- linux-2.5.58.orig/fs/partitions/msdos.c	Thu Jan 16 11:56:13 2003
+++ linux-2.5.58/fs/partitions/msdos.c	Wed Jan 15 17:32:22 2003
@@ -385,6 +385,87 @@
 	{SOLARIS_X86_PARTITION, parse_solaris_x86},
 	{0, NULL},
 };
+/*
+ * Look for various forms of IDE disk geometry translation
+ */
+static int handle_ide_mess(struct block_device *bdev)
+{
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+	Sector sect;
+	unsigned char *data;
+	kdev_t dev = to_kdev_t(bdev->bd_dev);
+	unsigned int sig;
+	int heads = 0;
+	struct partition *p;
+	int i;
+#ifdef CONFIG_BLK_DEV_IDE_MODULE
+	if (!ide_xlate_1024)
+		return 1;
+#endif
+	/*
+	 * The i386 partition handling programs very often
+	 * make partitions end on cylinder boundaries.
+	 * There is no need to do so, and Linux fdisk doesn't always
+	 * do this, and Windows NT on Alpha doesn't do this either,
+	 * but still, this helps to guess #heads.
+	 */
+	data = read_dev_sector(bdev, 0, &sect);
+	if (!data)
+		return -1;
+	if (!msdos_magic_present(data + 510)) {
+		put_dev_sector(sect);
+		return 0;
+	}
+	sig = le16_to_cpu(*(unsigned short *)(data + 2));
+	p = (struct partition *) (data + 0x1be);
+	for (i = 0; i < 4; i++) {
+		struct partition *q = &p[i];
+		if (NR_SECTS(q)) {
+			if ((q->sector & 63) == 1 &&
+			    (q->end_sector & 63) == 63)
+				heads = q->end_head + 1;
+			break;
+		}
+	}
+	if (SYS_IND(p) == EZD_PARTITION) {
+		/*
+		 * Accesses to sector 0 must go to sector 1 instead.
+		 */
+		if (ide_xlate_1024(bdev, -1, heads, " [EZD]"))
+			goto reread;
+	} else if (SYS_IND(p) == DM6_PARTITION) {
+
+		/*
+		 * Everything on the disk is offset by 63 sectors,
+		 * including a "new" MBR with its own partition table.
+		 */
+		if (ide_xlate_1024(bdev, 1, heads, " [DM6:DDO]"))
+			goto reread;
+	} else if (sig <= 0x1ae &&
+		   data[sig] == 0xAA && data[sig+1] == 0x55 &&
+		   (data[sig+2] & 1)) {
+		/* DM6 signature in MBR, courtesy of OnTrack */
+		(void) ide_xlate_1024 (bdev, 0, heads, " [DM6:MBR]");
+	} else if (SYS_IND(p) == DM6_AUX1PARTITION ||
+		   SYS_IND(p) == DM6_AUX3PARTITION) {
+		/*
+		 * DM6 on other than the first (boot) drive
+		 */
+		(void) ide_xlate_1024(bdev, 0, heads, " [DM6:AUX]");
+	} else {
+		(void) ide_xlate_1024(bdev, 2, heads, " [PTBL]");
+	}
+	put_dev_sector(sect);
+	return 1;
+
+reread:
+	put_dev_sector(sect);
+	/* Flush the cache */
+	invalidate_bdev(bdev, 1);
+	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
+#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
+	return 1;
+}
  
 int msdos_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
@@ -393,7 +474,11 @@
 	unsigned char *data;
 	struct partition *p;
 	int slot;
+	int err;
 
+	err = handle_ide_mess(bdev);
+	if (err <= 0)
+		return err;
 	data = read_dev_sector(bdev, 0, &sect);
 	if (!data)
 		return -1;
@@ -439,6 +524,21 @@
 			state->parts[slot].flags = 1;
 	}
 
+	/*
+	 *  Check for old-style Disk Manager partition table
+	 */
+	if (msdos_magic_present(data + 0xfc)) {
+		p = (struct partition *) (0x1be + data);
+		for (slot = 4 ; slot < 16 ; slot++, state->next++) {
+			p--;
+			if (state->next == state->limit)
+				break;
+			if (!(START_SECT(p) && NR_SECTS(p)))
+				continue;
+			put_partition(state, state->next,
+						START_SECT(p), NR_SECTS(p));
+		}
+	}
 	printk("\n");
 
 	/* second pass - output for each on a separate line */
@@ -456,7 +556,7 @@
 		if (!subtypes[n].parse)
 			continue;
 		subtypes[n].parse(state, bdev, START_SECT(p)*sector_size,
-						NR_SECTS(p)*sector_size, slot);
+						NR_SECTS(p)*sector_size, n);
 	}
 	put_dev_sector(sect);
 	return 1;
