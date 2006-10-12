Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWJLXvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWJLXvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWJLXvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:51:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:2751 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751338AbWJLXvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:51:02 -0400
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org
Date: Fri, 13 Oct 2006 09:50:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17710.54489.486265.487078@cse.unsw.edu.au>
Cc: aeb@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
Subject: Why aren't partitions limited to fit within the device?
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I was looking into an issue that someone was having with raid5.
They made an md/raid5 out of 5 whole devices and by luck the data
that was written to the first block of the 5th device looked
slightly like a partition table.  fdisk output below for the curious.
However some partitions were beyond the end of the device.

This resulted in annoying error messages popping up when various
programs such as mount (mounting by label) looked at various
partitions.
The messages were like:
Buffer I/O error on device sde3, logical block 1794
This logical block is way beyond the end of sde.

What is happening is that the partition is found to be beyond the end
of the device, a message is printed about this
   sde: p3 exceeds device capacity
but nothing is done about it.

So IO requests in the partition can go beyond the end of the device -
and the code that is supposed  to protect devices from this doesn't.
In ll_rw_blk.c, in generic_make_request,  the max bi_sector is checked
against maxsector and an error is reported if bi_sector is too large.
However this only happens before blk_partition_remap is called to map
the partition-sector to the device-sector.  The result of
blk_partition_remap is clearly expected to still be in range
	 *
	 * NOTE: we don't repeat the blk_size check for each new device.
	 * Stacking drivers are expected to know what they are doing.

Partitioning isn't exactly a 'stacking driver', but it doesn't seem
to know what it is doing :-)

So:  Is there any good reason to not clip the partitions to fit
within the device - and discard those that are completely beyond
the end of the device??

The patch at the end of the mail does that.  Is it OK to submit this
to mainline?

NeilBrown



# fdisk /dev/sde
Command (m for help): p

Disk /dev/sde: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sde1               1           1         995+  c7  Syrinx
Partition 1 does not end on cylinder boundary.
/dev/sde2               1           1           0    0  Empty
Partition 2 does not end on cylinder boundary.
/dev/sde3          133675      133675         995+  c7  Syrinx
Partition 3 does not end on cylinder boundary.
/dev/sde4               1           1           0    0  Empty
Partition 4 does not end on cylinder boundary.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./block/ioctl.c         |    6 ++++++
 ./fs/partitions/check.c |   12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff .prev/block/ioctl.c ./block/ioctl.c
--- .prev/block/ioctl.c	2006-10-09 14:25:11.000000000 +1000
+++ ./block/ioctl.c	2006-10-13 09:45:52.000000000 +1000
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
--- .prev/fs/partitions/check.c	2006-10-13 09:28:21.000000000 +1000
+++ ./fs/partitions/check.c	2006-10-13 09:46:12.000000000 +1000
@@ -466,8 +466,16 @@ int rescan_partitions(struct gendisk *di
 		if (!size)
 			continue;
 		if (from + size > get_capacity(disk)) {
-			printk(" %s: p%d exceeds device capacity\n",
-				disk->disk_name, p);
+			if (from >= get_capacity(disk)) {
+				printk(KERN_INFO
+				       " %s: p%d starts beyond end of device\n",
+				       disk->disk_name, p);
+				continue;
+			}
+			printk(KERN_INFO
+			       " %s: p%d exceeds device capacity - clipping\n",
+			       disk->disk_name, p);
+			size = get_capacity(disk) - from;
 		}
 		add_partition(disk, p, from, size);
 #ifdef CONFIG_BLK_DEV_MD
