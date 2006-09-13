Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWIMRqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWIMRqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIMRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:46:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:61881 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750836AbWIMRq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:46:29 -0400
Message-Id: <20060913174650.432175000@chello.nl>
References: <20060913174312.528491000@chello.nl>
User-Agent: quilt/0.45-1
Date: Wed, 13 Sep 2006 19:43:14 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Jason Baron <jbaron@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/2] new bd_mutex lockdep annotation
Content-Disposition: inline; filename=new_block_annotation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gendisk partition number to set a lock class.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Jason Baron <jbaron@redhat.com>
---
 fs/block_dev.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6-mm/fs/block_dev.c
===================================================================
--- linux-2.6-mm.orig/fs/block_dev.c
+++ linux-2.6-mm/fs/block_dev.c
@@ -357,10 +357,14 @@ static int bdev_set(struct inode *inode,
 
 static LIST_HEAD(all_bdevs);
 
+static struct lock_class_key bdev_part_lock_key;
+
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
+	struct gendisk *disk;
+	int part = 0;
 
 	inode = iget5_locked(bd_mnt->mnt_sb, hash(dev),
 			bdev_test, bdev_set, &dev);
@@ -386,6 +390,11 @@ struct block_device *bdget(dev_t dev)
 		list_add(&bdev->bd_list, &all_bdevs);
 		spin_unlock(&bdev_lock);
 		unlock_new_inode(inode);
+		mutex_init(&bdev->bd_mutex);
+		disk = get_gendisk(dev, &part);
+		if (part)
+			lockdep_set_class(&bdev->bd_mutex, &bdev_part_lock_key);
+		put_disk(disk);
 	}
 	return bdev;
 }

--

