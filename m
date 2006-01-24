Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWAXD7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWAXD7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWAXD6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:58:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:17590 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964989AbWAXD6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:58:38 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Jan 2006 14:58:32 +1100
Message-Id: <1060124035832.28836@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 5] md: Don't remove bitmap from md array when switching to read-only
References: <20060124145516.28734.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While a read-only array doesn't not really need a bitmap, we should
not remove the bitmap when switching an array to read-only because
 a/ There is no code to re-add the bitmap which switching to read-write,
 b/ There is insufficient locking - the bitmap could be accessed while it is
    being removed.

cc: Reuben Farrelly <reuben-lkml@reub.net>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-24 13:42:29.000000000 +1100
+++ ./drivers/md/md.c	2006-01-24 14:47:17.000000000 +1100
@@ -2690,14 +2690,6 @@ static int do_md_stop(mddev_t * mddev, i
 			set_disk_ro(disk, 1);
 	}
 
-	bitmap_destroy(mddev);
-	if (mddev->bitmap_file) {
-		atomic_set(&mddev->bitmap_file->f_dentry->d_inode->i_writecount, 1);
-		fput(mddev->bitmap_file);
-		mddev->bitmap_file = NULL;
-	}
-	mddev->bitmap_offset = 0;
-
 	/*
 	 * Free resources if final stop
 	 */
@@ -2707,6 +2699,14 @@ static int do_md_stop(mddev_t * mddev, i
 		struct gendisk *disk;
 		printk(KERN_INFO "md: %s stopped.\n", mdname(mddev));
 
+		bitmap_destroy(mddev);
+		if (mddev->bitmap_file) {
+			atomic_set(&mddev->bitmap_file->f_dentry->d_inode->i_writecount, 1);
+			fput(mddev->bitmap_file);
+			mddev->bitmap_file = NULL;
+		}
+		mddev->bitmap_offset = 0;
+
 		ITERATE_RDEV(mddev,rdev,tmp)
 			if (rdev->raid_disk >= 0) {
 				char nm[20];
