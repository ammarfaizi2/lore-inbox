Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318820AbSG0Unu>; Sat, 27 Jul 2002 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318821AbSG0Unu>; Sat, 27 Jul 2002 16:43:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11720 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318820AbSG0Unt>;
	Sat, 27 Jul 2002 16:43:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 27 Jul 2002 22:47:04 +0200 (MEST)
Message-Id: <UTC200207272047.g6RKl4q00901.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] partition fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does two things:

(i) fixes a small bug in the new partition code
This is the final chunk s/n/slot/. I'll refrain from giving a vi script.
This is uncontroversial.

(ii) removes ancient garbage concerning disk managers
This may well be controversial.

(Long ago, when disks became larger than 500 MB, lots of tricks were
invented to keep DOS happy. Both hardware tricks and software tricks.
One of the software tricks was the invention of boot managers.
There have been many of those. The Linux kernel has had support
for two of them: OnTrack Disk Manager and EZdrive.
More precisely: there have been many versions of both OnTrack Disk Manager
and EZdrive, and the kernel had support for a few of these versions.

I think the time has come to remove the automatic support - every now
and then it bites some innocent user, and the support is not really
needed any longer, and the support is for outdated versions of these
boot managers.

No doubt it will turn out that users still exist that use some form
of this stuff, but I would prefer to support them by explicit
kernel boot parameters, rather than by code that guesses what
might be the right thing to do.

The patch below just rips out the old stuff. Depending on the screams
this might provoke I expect to add some boot parameters.)

Andries


--- ../linux-2.5.29/linux/fs/partitions/msdos.c	Sat Jul 27 19:03:25 2002
+++ linux/fs/partitions/msdos.c	Sat Jul 27 22:21:22 2002
@@ -385,87 +385,6 @@
 	{SOLARIS_X86_PARTITION, parse_solaris_x86},
 	{0, NULL},
 };
-/*
- * Look for various forms of IDE disk geometry translation
- */
-static int handle_ide_mess(struct block_device *bdev)
-{
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-	Sector sect;
-	unsigned char *data;
-	kdev_t dev = to_kdev_t(bdev->bd_dev);
-	unsigned int sig;
-	int heads = 0;
-	struct partition *p;
-	int i;
-#ifdef CONFIG_BLK_DEV_IDE_MODULE
-	if (!ide_xlate_1024)
-		return 1;
-#endif
-	/*
-	 * The i386 partition handling programs very often
-	 * make partitions end on cylinder boundaries.
-	 * There is no need to do so, and Linux fdisk doesn't always
-	 * do this, and Windows NT on Alpha doesn't do this either,
-	 * but still, this helps to guess #heads.
-	 */
-	data = read_dev_sector(bdev, 0, &sect);
-	if (!data)
-		return -1;
-	if (!msdos_magic_present(data + 510)) {
-		put_dev_sector(sect);
-		return 0;
-	}
-	sig = le16_to_cpu(*(unsigned short *)(data + 2));
-	p = (struct partition *) (data + 0x1be);
-	for (i = 0; i < 4; i++) {
-		struct partition *q = &p[i];
-		if (NR_SECTS(q)) {
-			if ((q->sector & 63) == 1 &&
-			    (q->end_sector & 63) == 63)
-				heads = q->end_head + 1;
-			break;
-		}
-	}
-	if (SYS_IND(p) == EZD_PARTITION) {
-		/*
-		 * Accesses to sector 0 must go to sector 1 instead.
-		 */
-		if (ide_xlate_1024(dev, -1, heads, " [EZD]"))
-			goto reread;
-	} else if (SYS_IND(p) == DM6_PARTITION) {
-
-		/*
-		 * Everything on the disk is offset by 63 sectors,
-		 * including a "new" MBR with its own partition table.
-		 */
-		if (ide_xlate_1024(dev, 1, heads, " [DM6:DDO]"))
-			goto reread;
-	} else if (sig <= 0x1ae &&
-		   data[sig] == 0xAA && data[sig+1] == 0x55 &&
-		   (data[sig+2] & 1)) {
-		/* DM6 signature in MBR, courtesy of OnTrack */
-		(void) ide_xlate_1024 (dev, 0, heads, " [DM6:MBR]");
-	} else if (SYS_IND(p) == DM6_AUX1PARTITION ||
-		   SYS_IND(p) == DM6_AUX3PARTITION) {
-		/*
-		 * DM6 on other than the first (boot) drive
-		 */
-		(void) ide_xlate_1024(dev, 0, heads, " [DM6:AUX]");
-	} else {
-		(void) ide_xlate_1024(dev, 2, heads, " [PTBL]");
-	}
-	put_dev_sector(sect);
-	return 1;
-
-reread:
-	put_dev_sector(sect);
-	/* Flush the cache */
-	invalidate_bdev(bdev, 1);
-	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
-#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
-	return 1;
-}
  
 int msdos_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
@@ -474,11 +393,7 @@
 	unsigned char *data;
 	struct partition *p;
 	int slot;
-	int err;
 
-	err = handle_ide_mess(bdev);
-	if (err <= 0)
-		return err;
 	data = read_dev_sector(bdev, 0, &sect);
 	if (!data)
 		return -1;
@@ -524,21 +439,6 @@
 			state->parts[slot].flags = 1;
 	}
 
-	/*
-	 *  Check for old-style Disk Manager partition table
-	 */
-	if (msdos_magic_present(data + 0xfc)) {
-		p = (struct partition *) (0x1be + data);
-		for (slot = 4 ; slot < 16 ; slot++, state->next++) {
-			p--;
-			if (state->next == state->limit)
-				break;
-			if (!(START_SECT(p) && NR_SECTS(p)))
-				continue;
-			put_partition(state, state->next,
-						START_SECT(p), NR_SECTS(p));
-		}
-	}
 	printk("\n");
 
 	/* second pass - output for each on a separate line */
@@ -556,7 +456,7 @@
 		if (!subtypes[n].parse)
 			continue;
 		subtypes[n].parse(state, bdev, START_SECT(p)*sector_size,
-						NR_SECTS(p)*sector_size, n);
+						NR_SECTS(p)*sector_size, slot);
 	}
 	put_dev_sector(sect);
 	return 1;
