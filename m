Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422991AbWBBGCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422991AbWBBGCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWBBGCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:02:34 -0500
Received: from mx1.suse.de ([195.135.220.2]:42210 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422991AbWBBGCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:02:25 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 2 Feb 2006 17:02:15 +1100
Message-Id: <1060202060215.15984@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 3] md: Make sure rdev->size gets set for version-1 superblocks.
References: <20060202165638.15890.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sometimes it doesn't so make the code more like the version-0 code
which works.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-02-02 16:51:46.000000000 +1100
+++ ./drivers/md/md.c	2006-02-02 16:56:12.000000000 +1100
@@ -1025,7 +1025,7 @@ static int super_1_load(mdk_rdev_t *rdev
 		rdev-> sb_size = (rdev->sb_size | bmask)+1;
 
 	if (refdev == 0)
-		return 1;
+		ret = 1;
 	else {
 		__u64 ev1, ev2;
 		struct mdp_superblock_1 *refsb = 
@@ -1045,7 +1045,9 @@ static int super_1_load(mdk_rdev_t *rdev
 		ev2 = le64_to_cpu(refsb->events);
 
 		if (ev1 > ev2)
-			return 1;
+			ret = 1;
+		else
+			ret = 0;
 	}
 	if (minor_version) 
 		rdev->size = ((rdev->bdev->bd_inode->i_size>>9) - le64_to_cpu(sb->data_offset)) / 2;
@@ -1059,7 +1061,7 @@ static int super_1_load(mdk_rdev_t *rdev
 
 	if (le32_to_cpu(sb->size) > rdev->size*2)
 		return -EINVAL;
-	return 0;
+	return ret;
 }
 
 static int super_1_validate(mddev_t *mddev, mdk_rdev_t *rdev)
