Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUEQQKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUEQQKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEQQKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:10:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50136 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261764AbUEQQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:10:28 -0400
Date: Mon, 17 May 2004 18:10:28 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org, torvalds@osdl.org
Cc: mark.williamson@imperial.ac.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] Quota fix 3 - quota file corruption
Message-ID: <20040517161028.GB23294@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  tha last (at least for now :) quota fix. This patch fixes possible
quota files corruption which could happen when root did not have any
inodes&space allocated. Originally this could not happen as structure
would not be written to disk in that case but with journalled quota we
need to write even all-zero structure. The fix is not very nice but
change of the format on disk is probably worse (I made a mistake with
not including the usage-bitmaps into format :(). The patch is against
2.6.6 with previous quota fixes. Please apply.

						Honza



--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.6-4-v2rootfix.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.6-3-slabfix/fs/dquot.c linux-2.6.6-4-v2rootfix/fs/dquot.c
--- linux-2.6.6-3-slabfix/fs/dquot.c	2004-05-14 15:19:38.000000000 +0200
+++ linux-2.6.6-4-v2rootfix/fs/dquot.c	2004-05-14 15:37:17.000000000 +0200
@@ -1205,8 +1205,11 @@
 		if (transfer_to[cnt] == NODQUOT)
 			continue;
 
-		dquot_decr_inodes(transfer_from[cnt], 1);
-		dquot_decr_space(transfer_from[cnt], space);
+		/* Due to IO error we might not have transfer_from[] structure */
+		if (transfer_from[cnt]) {
+			dquot_decr_inodes(transfer_from[cnt], 1);
+			dquot_decr_space(transfer_from[cnt], space);
+		}
 
 		dquot_incr_inodes(transfer_to[cnt], 1);
 		dquot_incr_space(transfer_to[cnt], space);
diff -ruX /home/jack/.kerndiffexclude linux-2.6.6-3-slabfix/fs/quota_v2.c linux-2.6.6-4-v2rootfix/fs/quota_v2.c
--- linux-2.6.6-3-slabfix/fs/quota_v2.c	2004-05-14 15:14:28.000000000 +0200
+++ linux-2.6.6-4-v2rootfix/fs/quota_v2.c	2004-05-16 20:27:38.000000000 +0200
@@ -420,7 +420,7 @@
 	mm_segment_t fs;
 	loff_t offset;
 	ssize_t ret;
-	struct v2_disk_dqblk ddquot;
+	struct v2_disk_dqblk ddquot, empty;
 
 	/* dq_off is guarded by dqio_sem */
 	if (!dquot->dq_off)
@@ -432,6 +432,12 @@
 	offset = dquot->dq_off;
 	spin_lock(&dq_data_lock);
 	mem2diskdqb(&ddquot, &dquot->dq_dqb, dquot->dq_id);
+	/* Argh... We may need to write structure full of zeroes but that would be
+	 * threated as an empty place by the rest of the code. Format change would
+	 * be definitely cleaner but the problems probably are not worth it */
+	memset(&empty, 0, sizeof(struct v2_disk_dqblk));
+	if (!memcmp(&empty, &ddquot, sizeof(struct v2_disk_dqblk)))
+		ddquot.dqb_itime = cpu_to_le64(1);
 	spin_unlock(&dq_data_lock);
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -622,7 +628,7 @@
 	struct file *filp;
 	mm_segment_t fs;
 	loff_t offset;
-	struct v2_disk_dqblk ddquot;
+	struct v2_disk_dqblk ddquot, empty;
 	int ret = 0;
 
 	filp = sb_dqopt(dquot->dq_sb)->files[type];
@@ -652,8 +658,14 @@
 			printk(KERN_ERR "VFS: Error while reading quota structure for id %u.\n", dquot->dq_id);
 			memset(&ddquot, 0, sizeof(struct v2_disk_dqblk));
 		}
-		else
+		else {
 			ret = 0;
+			/* We need to escape back all-zero structure */
+			memset(&empty, 0, sizeof(struct v2_disk_dqblk));
+			empty.dqb_itime = cpu_to_le64(1);
+			if (!memcmp(&empty, &ddquot, sizeof(struct v2_disk_dqblk)))
+				ddquot.dqb_itime = 0;
+		}
 		set_fs(fs);
 		disk2memdqb(&dquot->dq_dqb, &ddquot);
 		if (!dquot->dq_dqb.dqb_bhardlimit &&
diff -ruX /home/jack/.kerndiffexclude linux-2.6.6-3-slabfix/include/linux/quotaio_v2.h linux-2.6.6-4-v2rootfix/include/linux/quotaio_v2.h
--- linux-2.6.6-3-slabfix/include/linux/quotaio_v2.h	2003-11-26 21:44:21.000000000 +0100
+++ linux-2.6.6-4-v2rootfix/include/linux/quotaio_v2.h	2004-05-14 15:37:17.000000000 +0200
@@ -59,7 +59,7 @@
 
 /*
  *  Structure of header of block with quota structures. It is padded to 16 bytes so
- *  there will be space for exactly 18 quota-entries in a block
+ *  there will be space for exactly 21 quota-entries in a block
  */
 struct v2_disk_dqdbheader {
 	__u32 dqdh_next_free;	/* Number of next block with free entry */

--UugvWAfsgieZRqgk--
