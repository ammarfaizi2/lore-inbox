Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVCEW7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVCEW7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVCEW4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:56:01 -0500
Received: from coderock.org ([193.77.147.115]:56741 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261317AbVCEWne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:34 -0500
Subject: [patch 07/15] block/swim3: replace schedule_timeout() with msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:02 +0100
Message-Id: <20050305224303.557841F202@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Change the delay logic to use time_before() and
msleep_interruptible(). Rather than depend on the number of
iterations of the loop for timing accuracy, I rely on the current value of
jiffies relative to a static timeout (end_jiffies).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/swim3.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff -puN drivers/block/swim3.c~msleep_interruptible-drivers_block_swim3 drivers/block/swim3.c
--- kj/drivers/block/swim3.c~msleep_interruptible-drivers_block_swim3	2005-03-05 16:11:00.000000000 +0100
+++ kj-domen/drivers/block/swim3.c	2005-03-05 16:11:00.000000000 +0100
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
-		set_current_state(TASK_INTERRUPTIBLE);
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
-			set_current_state(TASK_INTERRUPTIBLE);
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
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		msleep_interruptible(10);
 	}
 	ret = swim3_readbit(fs, SEEK_COMPLETE) == 0
 		|| swim3_readbit(fs, DISK_IN) == 0;
_
