Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUASOux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUASOux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:50:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61841 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265071AbUASOuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:50:50 -0500
Date: Mon, 19 Jan 2004 15:50:49 +0100
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix i_blocks bug in 2.6.1
Message-ID: <20040119145049.GI653@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  I'm sending you a patch which fixes a problem that i_blocks are not
updated for quota files (when quota turned on) in 2.6.1. The patch
also fixes possible unlock of not locked spin_lock. Please apply.

								Honza

diff -ruX ../kerndiffexclude linux-2.6.0-test11-um/fs/dquot.c linux-2.6.0-test11-um-1-noqfix/fs/dquot.c
--- linux-2.6.0/fs/dquot.c	Mon Dec  1 12:31:28 2003
+++ linux-2.6.0-1-noqfix/fs/dquot.c	Fri Jan 16 10:10:25 2004
@@ -884,11 +884,9 @@
 		warntype[cnt] = NOWARN;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	if (IS_NOQUOTA(inode)) {
-		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
-		return QUOTA_OK;
-	}
 	spin_lock(&dq_data_lock);
+	if (IS_NOQUOTA(inode))
+		goto add_bytes;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
@@ -900,6 +898,7 @@
 			continue;
 		dquot_incr_space(inode->i_dquot[cnt], number);
 	}
+add_bytes:
 	inode_add_bytes(inode, number);
 	ret = QUOTA_OK;
 warn_put_all:
@@ -953,16 +952,15 @@
 	unsigned int cnt;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	if (IS_NOQUOTA(inode)) {
-		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
-		return;
-	}
 	spin_lock(&dq_data_lock);
+	if (IS_NOQUOTA(inode))
+		goto sub_bytes;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
 		dquot_decr_space(inode->i_dquot[cnt], number);
 	}
+sub_bytes:
 	inode_sub_bytes(inode, number);
 	spin_unlock(&dq_data_lock);
 	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
@@ -1010,8 +1008,10 @@
 		warntype[cnt] = NOWARN;
 	}
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	if (IS_NOQUOTA(inode))	/* File without quota accounting? */
-		goto warn_put_all;
+	if (IS_NOQUOTA(inode)) {	/* File without quota accounting? */
+		up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		return QUOTA_OK;
+	}
 	/* First build the transfer_to list - here we can block on reading of dquots... */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		switch (cnt) {
