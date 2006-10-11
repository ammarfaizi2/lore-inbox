Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbWJKGJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbWJKGJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWJKGJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:09:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6346 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030645AbWJKGJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:09:16 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 11 Oct 2006 16:09:08 +1000
Message-Id: <1061011060908.12435@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 001 of 4] Remove lock_key approach to managing nested bd_mutex locks.
References: <20061011155522.7915.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The extra call to get_gendisk is not good.  It causes a ->probe and possible
module load before it is really appropriate to do this.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/block_dev.c |    9 ---------
 1 file changed, 9 deletions(-)

diff .prev/fs/block_dev.c ./fs/block_dev.c
--- .prev/fs/block_dev.c	2006-10-11 15:37:05.000000000 +1000
+++ ./fs/block_dev.c	2006-10-11 15:37:10.000000000 +1000
@@ -357,14 +357,10 @@ static int bdev_set(struct inode *inode,
 
 static LIST_HEAD(all_bdevs);
 
-static struct lock_class_key bdev_part_lock_key;
-
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
-	struct gendisk *disk;
-	int part = 0;
 
 	inode = iget5_locked(bd_mnt->mnt_sb, hash(dev),
 			bdev_test, bdev_set, &dev);
@@ -390,11 +386,6 @@ struct block_device *bdget(dev_t dev)
 		list_add(&bdev->bd_list, &all_bdevs);
 		spin_unlock(&bdev_lock);
 		unlock_new_inode(inode);
-		mutex_init(&bdev->bd_mutex);
-		disk = get_gendisk(dev, &part);
-		if (part)
-			lockdep_set_class(&bdev->bd_mutex, &bdev_part_lock_key);
-		put_disk(disk);
 	}
 	return bdev;
 }
