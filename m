Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWJPAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWJPAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWJPAJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:09:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:3053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751234AbWJPAJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:09:07 -0400
From: Neil Brown <neilb@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 16 Oct 2006 10:08:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17714.52626.667835.228747@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
In-Reply-To: message from Alan Cox on Friday October 13
References: <17710.54489.486265.487078@cse.unsw.edu.au>
	<1160752047.25218.50.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 13, alan@lxorguk.ukuu.org.uk wrote:
> Ar Gwe, 2006-10-13 am 09:50 +1000, ysgrifennodd Neil Brown:
> > So:  Is there any good reason to not clip the partitions to fit
> > within the device - and discard those that are completely beyond
> > the end of the device??
> 
> Its close but not quite the right approach
> 
> > The patch at the end of the mail does that.  Is it OK to submit this
> > to mainline?
> 
> No I think not. Any partition which is partly outside the disk should be
> ignored entirely, that ensures it doesn't accidentally get mounted and
> trashed by an HPA or similar mixup.

Hmmm.. So Alan things a partially-outside-this-disk partition
shouldn't show up at all, and Andries thinks it should.
And both give reasonably believable justifications.

Maybe we need a kernel parameter?  How about this?

NeilBrown


-----------------------------
Don't allow partitions to start or end beyond the end of the device.

Corrupt partitions tables can cause wierd partitions that confuse
programs.  This is confusion that can be avoided.

If a partition appears to start at or beyond the end of a device, we
don't enable it.
If it starts within the device but ends after the end, we clip it to 
fit within the device.

Not enabling partitions does not affect partition numbering of
subsequent partitions.

This change applies to partitions found by fs/partitions/check.c
and to partitions explicitly created via an ioctl.

There is no uniform agreement on whether partitions that extend
beyond the end of the device should be clipped or discarded.
Discarding is safer as it makes corruption less likely.
Clipping is more flexable and gives continued access to the partition.
So provide a kernel-parameter which a 'safe' default.

   partitions=strict
is the default
   partitions=relaxed
means that partitions are clipped rather than rejected.
This kernel parameters only applies to auto-detected partitions,
not those set by ioctl.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/kernel-parameters.txt |    8 ++++++++
 ./block/ioctl.c                       |    6 ++++++
 ./fs/partitions/check.c               |   28 ++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff .prev/Documentation/kernel-parameters.txt ./Documentation/kernel-parameters.txt
--- .prev/Documentation/kernel-parameters.txt	2006-10-16 10:03:40.000000000 +1000
+++ ./Documentation/kernel-parameters.txt	2006-10-16 10:06:42.000000000 +1000
@@ -1148,6 +1148,14 @@ and is between 256 and 4096 characters. 
 			Currently this function knows 686a and 8231 chips.
 			Format: [spp|ps2|epp|ecp|ecpepp]
 
+	partitions=	How to interpret partition information that
+			could be corrupt.
+			'strict' is the default.  Partitions that
+			don't fit in the device are rejected.
+			'relaxed' is an option.  Partitions that start
+			within the device be end beyond the end are
+			clipped.
+
 	pas2=		[HW,OSS] Format:
 			<io>,<irq>,<dma>,<dma16>,<sb_io>,<sb_irq>,<sb_dma>,<sb_dma16>
 

diff .prev/block/ioctl.c ./block/ioctl.c
--- .prev/block/ioctl.c	2006-10-13 14:30:56.000000000 +1000
+++ ./block/ioctl.c	2006-10-16 09:54:40.000000000 +1000
@@ -42,6 +42,12 @@ static int blkpg_ioctl(struct block_devi
 				    || pstart < 0 || plength < 0)
 					return -EINVAL;
 			}
+			/* Does partition fit within device */
+			if (start + length > get_capacity(disk)) {
+				if (start >= get_capacity(disk))
+					return -EINVAL;
+				length = get_capacity(disk) - start;
+			}
 			/* partition number in use? */
 			mutex_lock(&bdev->bd_mutex);
 			if (disk->part[part - 1]) {

diff .prev/fs/partitions/check.c ./fs/partitions/check.c
--- .prev/fs/partitions/check.c	2006-10-13 14:30:56.000000000 +1000
+++ ./fs/partitions/check.c	2006-10-16 10:07:53.000000000 +1000
@@ -443,6 +443,8 @@ exit:
 	}
 }
 
+static int strict_partitions = 1;
+
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
@@ -466,8 +468,22 @@ int rescan_partitions(struct gendisk *di
 		if (!size)
 			continue;
 		if (from + size > get_capacity(disk)) {
-			printk(" %s: p%d exceeds device capacity\n",
-				disk->disk_name, p);
+			if (strict_partitions) {
+				printk(KERN_INFO
+				       " %s: p%d ends beyond end of device"
+				       " - ignoring\n", disk->disk_name, p);
+				continue;
+			}
+			if (from >= get_capacity(disk)) {
+				printk(KERN_INFO
+				       " %s: p%d starts beyond end of device"
+				       " - ignoring\n", disk->disk_name, p);
+				continue;
+			}
+			printk(KERN_INFO
+			       " %s: p%d exceeds device capacity - clipping\n",
+			       disk->disk_name, p);
+			size = get_capacity(disk) - from;
 		}
 		add_partition(disk, p, from, size);
 #ifdef CONFIG_BLK_DEV_MD
@@ -479,6 +495,14 @@ int rescan_partitions(struct gendisk *di
 	return 0;
 }
 
+static int __init part_setup(char *str)
+{
+	strict_partitions = strcmp(str, "relaxed");
+	return 1;
+}
+
+__setup("partitions=", part_setup);
+
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;

