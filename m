Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUFBMzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUFBMzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUFBMzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:55:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24742 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262451AbUFBMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:55:07 -0400
Date: Wed, 2 Jun 2004 14:55:06 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix writing of quota info
Message-ID: <20040602125506.GA2028@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch fixes a problem with some quota operations not writing
the quota info they changed which could later cause that some
transaction needed more buffers than it had reserved or it could cause
corrupted quota files when the system was rebooted at the right time.
Please apply.

								Honza

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.7-rc2-5-credfix.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.7-rc2/fs/dquot.c linux-2.6.7-rc2-5-credfix/fs/dquot.c
--- linux-2.6.7-rc2/fs/dquot.c	2004-05-31 18:49:26.000000000 +0200
+++ linux-2.6.7-rc2-5-credfix/fs/dquot.c	2004-05-31 18:51:21.000000000 +0200
@@ -306,7 +306,7 @@
 
 int dquot_acquire(struct dquot *dquot)
 {
-	int ret = 0;
+	int ret = 0, ret2 = 0;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	down(&dquot->dq_lock);
@@ -319,8 +319,15 @@
 	/* Instantiate dquot if needed */
 	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && !dquot->dq_off) {
 		ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot);
+		/* Write the info if needed */
+		if (info_dirty(&dqopt->info[dquot->dq_type]))
+			ret2 = dqopt->ops[dquot->dq_type]->write_file_info(dquot->dq_sb, dquot->dq_type);
 		if (ret < 0)
 			goto out_iolock;
+		if (ret2 < 0) {
+			ret = ret2;
+			goto out_iolock;
+		}
 	}
 	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 out_iolock:
@@ -334,7 +341,7 @@
  */
 int dquot_commit(struct dquot *dquot)
 {
-	int ret = 0;
+	int ret = 0, ret2 = 0;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	down(&dqopt->dqio_sem);
@@ -346,12 +353,15 @@
 	spin_unlock(&dq_list_lock);
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
 		ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot);
+		if (info_dirty(&dqopt->info[dquot->dq_type]))
+			ret2 = dqopt->ops[dquot->dq_type]->write_file_info(dquot->dq_sb, dquot->dq_type);
+		if (ret >= 0)
+			ret = ret2;
+	}
 out_sem:
 	up(&dqopt->dqio_sem);
-	if (info_dirty(&dqopt->info[dquot->dq_type]))
-		dquot->dq_sb->dq_op->write_info(dquot->dq_sb, dquot->dq_type);
 	return ret;
 }
 
@@ -360,7 +370,7 @@
  */
 int dquot_release(struct dquot *dquot)
 {
-	int ret = 0;
+	int ret = 0, ret2 = 0;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	down(&dquot->dq_lock);
@@ -368,8 +378,14 @@
 	if (atomic_read(&dquot->dq_count) > 1)
 		goto out_dqlock;
 	down(&dqopt->dqio_sem);
-	if (dqopt->ops[dquot->dq_type]->release_dqblk)
+	if (dqopt->ops[dquot->dq_type]->release_dqblk) {
 		ret = dqopt->ops[dquot->dq_type]->release_dqblk(dquot);
+		/* Write the info */
+		if (info_dirty(&dqopt->info[dquot->dq_type]))
+			ret2 = dqopt->ops[dquot->dq_type]->write_file_info(dquot->dq_sb, dquot->dq_type);
+		if (ret >= 0)
+			ret = ret2;
+	}
 	clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 	up(&dqopt->dqio_sem);
 out_dqlock:

--xHFwDpU9dbj6ez1V--
