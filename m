Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUDWThW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUDWThW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUDWThW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:37:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27609 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261162AbUDWThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:37:05 -0400
Date: Fri, 23 Apr 2004 21:37:04 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Minor fixes in journalled quota
Message-ID: <20040423193704.GA18423@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus!

  I'm sending you a few minor fixes to the quota code - it fixes one
memory leak when turning journalled quotas off and does a trivial code
cleanup. Please apply.

								Honza

PS: Andrew, this patch is needed for the dirty-list patch I sent
yesterday to apply cleanly. Somehow I forgot to send you it :(. Should
I resend you it?

diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-2-jquota/fs/ext3/super.c linux-2.6.5-3-jquota2/fs/ext3/super.c
--- linux-2.6.5-2-jquota/fs/ext3/super.c	2004-03-22 21:29:49.000000000 +0100
+++ linux-2.6.5-3-jquota2/fs/ext3/super.c	2004-03-30 16:06:18.000000000 +0200
@@ -405,6 +405,12 @@
 	kfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 	brelse(sbi->s_sbh);
+#ifdef CONFIG_QUOTA
+	for (i = 0; i < MAXQUOTAS; i++) {
+		if (sbi->s_qf_names[i])
+			kfree(sbi->s_qf_names[i]);
+	}
+#endif
 
 	/* Debugging code just in case the in-memory inode orphan list
 	 * isn't empty.  The on-disk one can be non-empty if we've
@@ -893,7 +899,8 @@
 		}
 	}
 #ifdef CONFIG_QUOTA
-	if (!sbi->s_jquota_fmt && (sbi->s_qf_names[0] || sbi->s_qf_names[1])) {
+	if (!sbi->s_jquota_fmt && (sbi->s_qf_names[USRQUOTA] ||
+	    sbi->s_qf_names[GRPQUOTA])) {
 		printk(KERN_ERR
 			"EXT3-fs: journalled quota format not specified.\n");
 		return 0;
@@ -2170,8 +2177,8 @@
 static int ext3_mark_dquot_dirty(struct dquot * dquot)
 {
 	/* Are we journalling quotas? */
-	if (EXT3_SB(dquot->dq_sb)->s_qf_names[0] ||
-	    EXT3_SB(dquot->dq_sb)->s_qf_names[1])
+	if (EXT3_SB(dquot->dq_sb)->s_qf_names[USRQUOTA] ||
+	    EXT3_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA])
 		return ext3_write_dquot(dquot);
 	else
 		return dquot_mark_dquot_dirty(dquot);
@@ -2240,7 +2247,8 @@
 	struct nameidata nd;
 
 	/* Not journalling quota? */
-	if (!EXT3_SB(sb)->s_qf_names[0] && !EXT3_SB(sb)->s_qf_names[1])
+	if (!EXT3_SB(sb)->s_qf_names[USRQUOTA] &&
+	    !EXT3_SB(sb)->s_qf_names[GRPQUOTA])
 		return vfs_quota_on(sb, type, format_id, path);
 	err = path_lookup(path, LOOKUP_FOLLOW, &nd);
 	if (err)
