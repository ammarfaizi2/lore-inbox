Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVFUG2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVFUG2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVFUGWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:22:04 -0400
Received: from coderock.org ([193.77.147.115]:10393 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261733AbVFTVy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:56 -0400
Message-Id: <20050620215134.433393000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:35 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 05/12] block/swim3: replace schedule_timeout() with msleep_interruptible()
Content-Disposition: inline; filename=msleep_interruptible-drivers_block_swim3.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Change the delay logic to use time_before() and
msleep_interruptible(). Rather than depend on the number of
iterations of the loop for timing accuracy, I rely on the current value of
jiffies relative to a static timeout (end_jiffies).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 swim3.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

Index: quilt/drivers/block/swim3.c
===================================================================
--- quilt.orig/drivers/block/swim3.c
+++ quilt/drivers/block/swim3.c
@@ -820,20 +820,21 @@ static void release_drive(struct floppy_
 
 static int fd_eject(struct floppy_state *fs)
 {
-	int err, n;
+	int err;
+	unsigned long end_jiffies;
 
 	err = grab_drive(fs, ejecting, 1);
 	if (err)
 		return err;
 	swim3_action(fs, EJECT);
-	for (n = 20; n > 0; --n) {
+	end_jiffies = jiffies + 20;
+	while (time_before(jiffies, end_jiffies)) {
 		if (signal_pending(current)) {
 			err = -EINTR;
 			break;
 		}
 		swim3_select(fs, RELAX);
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(1);
+		msleep_interruptible(10);
 		if (swim3_readbit(fs, DISK_IN) == 0)
 			break;
 	}
@@ -878,7 +879,8 @@ static int floppy_open(struct inode *ino
 {
 	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
 	struct swim3 __iomem *sw = fs->swim3;
-	int n, err = 0;
+	int err = 0;
+	unsigned long end_jiffies, check_jiffies;
 
 	if (fs->ref_count == 0) {
 		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
@@ -892,16 +894,17 @@ static int floppy_open(struct inode *ino
 		swim3_action(fs, MOTOR_ON);
 		fs->write_prot = -1;
 		fs->cur_cyl = -1;
-		for (n = 0; n < 2 * HZ; ++n) {
-			if (n >= HZ/30 && swim3_readbit(fs, SEEK_COMPLETE))
+		end_jiffies = jiffies + 2 * HZ;
+		check_jiffies = jiffies + HZ/30;
+		while (time_before(jiffies,end_jiffies)) {
+			if (time_after(jiffies,check_jiffies) && swim3_readbit(fs, SEEK_COMPLETE))
 				break;
 			if (signal_pending(current)) {
 				err = -EINTR;
 				break;
 			}
 			swim3_select(fs, RELAX);
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(1);
+			msleep_interruptible(10);
 		}
 		if (err == 0 && (swim3_readbit(fs, SEEK_COMPLETE) == 0
 				 || swim3_readbit(fs, DISK_IN) == 0))
@@ -965,7 +968,8 @@ static int floppy_revalidate(struct gend
 {
 	struct floppy_state *fs = disk->private_data;
 	struct swim3 __iomem *sw;
-	int ret, n;
+	int ret;
+	unsigned long end_jiffies;
 
 	if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
 		return -ENXIO;
@@ -978,14 +982,14 @@ static int floppy_revalidate(struct gend
 	fs->write_prot = -1;
 	fs->cur_cyl = -1;
 	mdelay(1);
-	for (n = HZ; n > 0; --n) {
+	end_jiffies = jiffies + HZ;
+	while (time_before(jiffies,end_jiffies)) {
 		if (swim3_readbit(fs, SEEK_COMPLETE))
 			break;
 		if (signal_pending(current))
 			break;
 		swim3_select(fs, RELAX);
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(1);
+		msleep_interruptible(10);
 	}
 	ret = swim3_readbit(fs, SEEK_COMPLETE) == 0
 		|| swim3_readbit(fs, DISK_IN) == 0;

--
