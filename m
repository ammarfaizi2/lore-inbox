Return-Path: <linux-kernel-owner+w=401wt.eu-S1752062AbWLOATJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWLOATJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWLOATJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:19:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2534 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752062AbWLOATI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:19:08 -0500
Date: Fri, 15 Dec 2006 01:19:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Doug Ledford <dledford@redhat.com>, Neil Brown <neilb@suse.de>
Cc: mingo@redhat.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] simplify drivers/md/md.c:update_size()
Message-ID: <20061215001902.GR3388@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at commit 8ddeeae51f2f197b4fafcba117ee8191b49d843e,
I got the impression that this commit couldn't fix anything, since the 
"size" variable can't be changed before "fit" gets used.

Is there any big thinko, or is the patch below that slightly simplifies 
update_size() semantically equivalent to the current code?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/md/md.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.19-mm1/drivers/md/md.c.old	2006-12-15 00:57:05.000000000 +0100
+++ linux-2.6.19-mm1/drivers/md/md.c	2006-12-15 00:57:42.000000000 +0100
@@ -4039,57 +4039,56 @@
 	 * Generate a 128 bit UUID
 	 */
 	get_random_bytes(mddev->uuid, 16);
 
 	mddev->new_level = mddev->level;
 	mddev->new_chunk = mddev->chunk_size;
 	mddev->new_layout = mddev->layout;
 	mddev->delta_disks = 0;
 
 	mddev->dead = 0;
 	return 0;
 }
 
 static int update_size(mddev_t *mddev, unsigned long size)
 {
 	mdk_rdev_t * rdev;
 	int rv;
 	struct list_head *tmp;
-	int fit = (size == 0);
 
 	if (mddev->pers->resize == NULL)
 		return -EINVAL;
 	/* The "size" is the amount of each device that is used.
 	 * This can only make sense for arrays with redundancy.
 	 * linear and raid0 always use whatever space is available
 	 * We can only consider changing the size if no resync
 	 * or reconstruction is happening, and if the new size
 	 * is acceptable. It must fit before the sb_offset or,
 	 * if that is <data_offset, it must fit before the
 	 * size of each device.
 	 * If size is zero, we find the largest size that fits.
 	 */
 	if (mddev->sync_thread)
 		return -EBUSY;
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		sector_t avail;
 		avail = rdev->size * 2;
 
-		if (fit && (size == 0 || size > avail/2))
+		if (size == 0)
 			size = avail/2;
 		if (avail < ((sector_t)size << 1))
 			return -ENOSPC;
 	}
 	rv = mddev->pers->resize(mddev, (sector_t)size *2);
 	if (!rv) {
 		struct block_device *bdev;
 
 		bdev = bdget_disk(mddev->gendisk, 0);
 		if (bdev) {
 			mutex_lock(&bdev->bd_inode->i_mutex);
 			i_size_write(bdev->bd_inode, (loff_t)mddev->array_size << 10);
 			mutex_unlock(&bdev->bd_inode->i_mutex);
 			bdput(bdev);
 		}
 	}
 	return rv;
 }
