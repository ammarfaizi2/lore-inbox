Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbTHKCgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTHKCgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:36:15 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61608 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270856AbTHKCgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:36:09 -0400
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 11 Aug 2003 12:35:57 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1 of 2 - When a partition is claimed, claim the whole device for partitioning.
Message-Id: <E19m2XN-0002BP-00@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

### Comments for ChangeSet

Current devices can be 'claimed' by filesystems (when mounting) or
md/raid (when being included in an array) or 'raw' or ....
This stop concurrent access by these systems.

However it is still possible for one system to claim the whole device
and a second system to claim one partition, which is not good.

With this patch, when a partition is claimed, the whole device is 
claimed for partitioning.  So you cannot have a partition and the
whole devices claimed at the same time (except if the whole device
is claimed for partitioning).

 ----------- Diffstat output ------------
 ./fs/block_dev.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff ./fs/block_dev.c~current~ ./fs/block_dev.c
--- ./fs/block_dev.c~current~	2003-08-11 09:01:38.000000000 +1000
+++ ./fs/block_dev.c	2003-08-11 09:01:38.000000000 +1000
@@ -419,12 +419,34 @@ void bd_forget(struct inode *inode)
 
 int bd_claim(struct block_device *bdev, void *holder)
 {
-	int res = -EBUSY;
+	int res;
 	spin_lock(&bdev_lock);
-	if (!bdev->bd_holder || bdev->bd_holder == holder) {
-		bdev->bd_holder = holder;
+
+	/* first decide result */
+	if (bdev->bd_holder == holder)
+		res = 0;	 /* already a holder */
+	else if (bdev->bd_holder != NULL)
+		res = -EBUSY; 	 /* held by someone else */
+	else if (bdev->bd_contains == bdev)
+		res = 0;  	 /* is a whole device which isn't held */
+
+	else if (bdev->bd_contains->bd_holder == bd_claim)
+		res = 0; 	 /* is a partition of a device that is being partitioned */
+	else if (bdev->bd_contains->bd_holder != NULL)
+		res = -EBUSY;	 /* is a partition of a held device */
+	else
+		res = 0;	 /* is a partition of an un-held device */
+
+	/* now impose change */
+	if (res==0) {
+		/* note that for a whole device bd_holders
+		 * will be incremented twice, and bd_holder will
+		 * be set to bd_claim before being set to holder
+		 */
+		bdev->bd_contains->bd_holders ++;
+		bdev->bd_contains->bd_holder = bd_claim;
 		bdev->bd_holders++;
-		res = 0;
+		bdev->bd_holder = holder;
 	}
 	spin_unlock(&bdev_lock);
 	return res;
@@ -433,6 +455,8 @@ int bd_claim(struct block_device *bdev, 
 void bd_release(struct block_device *bdev)
 {
 	spin_lock(&bdev_lock);
+	if (!--bdev->bd_contains->bd_holders)
+		bdev->bd_contains->bd_holder = NULL;
 	if (!--bdev->bd_holders)
 		bdev->bd_holder = NULL;
 	spin_unlock(&bdev_lock);
