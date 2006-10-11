Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030651AbWJKGJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030651AbWJKGJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWJKGJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:09:31 -0400
Received: from ns.suse.de ([195.135.220.2]:37330 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030648AbWJKGJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:09:26 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 11 Oct 2006 16:09:21 +1000
Message-Id: <1061011060921.12489@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 003 of 4] Use mutex_lock_nested for bd_mutex to avoid  lockdep warning.
References: <20061011155522.7915.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that the nesting in blkdev_{get,put} is simpler, adding
mutex_lock_nested is trivial.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/block_dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff .prev/fs/block_dev.c ./fs/block_dev.c
--- .prev/fs/block_dev.c	2006-10-11 15:38:31.000000000 +1000
+++ ./fs/block_dev.c	2006-10-11 15:41:55.000000000 +1000
@@ -909,7 +909,7 @@ static int do_open(struct block_device *
 	}
 	owner = disk->fops->owner;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
 		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
@@ -1049,7 +1049,7 @@ static int __blkdev_put(struct block_dev
 	struct gendisk *disk = bdev->bd_disk;
 	struct block_device *victim = NULL;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	lock_kernel();
 	if (for_part)
 		bdev->bd_part_count--;
