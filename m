Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268372AbTCFVSS>; Thu, 6 Mar 2003 16:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268384AbTCFVSS>; Thu, 6 Mar 2003 16:18:18 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:29884 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S268372AbTCFVSP>; Thu, 6 Mar 2003 16:18:15 -0500
Subject: Re: Linux 2.5.64-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200303061915.h26JFAP06033@devserv.devel.redhat.com>
References: <200303061915.h26JFAP06033@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Mar 2003 14:24:41 -0700
Message-Id: <1046985881.4992.99.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 12:15, Alan Cox wrote:
> 
> Linux 2.5.64-ac1

I had problems booting 2.5.62-ac1
http://marc.theaimsgroup.com/?l=linux-kernel&m=104578421426861&w=2
and Alan responded

On Thu, 2003-02-20 at 16:57, Alan Cox wrote:
> > ide_xlate_1024+0xf5
> > read_dev_sector+0x69
> > handle_ide_mess+0x179
>
> Ok I broke it with the change to the partiton stuff I put back. If you drop
> that partition tweak out it ought to boot.

Same problem with 2.5.64-ac1.

I backed out the same partitions stuff as before, and 2.5.64-ac1 boots
fine.  This is the resulting diff.

P.S.  This isn't a spelling fix this time.

Steven

--- linux-2.5.64-ac1-borken/fs/partitions/msdos.c	Thu Mar  6 13:05:16 2003
+++ linux-2.5.64-ac1/fs/partitions/msdos.c	Tue Mar  4 20:29:24 2003
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
-		if (ide_xlate_1024(bdev, -1, heads, " [EZD]"))
-			goto reread;
-	} else if (SYS_IND(p) == DM6_PARTITION) {
-
-		/*
-		 * Everything on the disk is offset by 63 sectors,
-		 * including a "new" MBR with its own partition table.
-		 */
-		if (ide_xlate_1024(bdev, 1, heads, " [DM6:DDO]"))
-			goto reread;
-	} else if (sig <= 0x1ae &&
-		   data[sig] == 0xAA && data[sig+1] == 0x55 &&
-		   (data[sig+2] & 1)) {
-		/* DM6 signature in MBR, courtesy of OnTrack */
-		(void) ide_xlate_1024 (bdev, 0, heads, " [DM6:MBR]");
-	} else if (SYS_IND(p) == DM6_AUX1PARTITION ||
-		   SYS_IND(p) == DM6_AUX3PARTITION) {
-		/*
-		 * DM6 on other than the first (boot) drive
-		 */
-		(void) ide_xlate_1024(bdev, 0, heads, " [DM6:AUX]");
-	} else {
-		(void) ide_xlate_1024(bdev, 2, heads, " [PTBL]");
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






