Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbTJSTIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTJSTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:08:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7588 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262053AbTJSTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:07:56 -0400
Date: Sun, 19 Oct 2003 21:07:55 +0200
From: Jan Kara <jack@ucw.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Quota locking fix
Message-ID: <20031019190755.GB8169@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

  I'm resending patch which fixes a quota locking problem causing deadlock
(when inode was being released from icache and it caused newly created
quota structure to be written). The patch against 2.6.0-test7 and should
apply at test8 too. Please apply.

								Honza

------------- cut here ---------------

diff -ruNX /home/jack/.kerndiffexclude linux-2.6.0-test7/fs/dquot.c linux-2.6.0-test7-1-lockfix/fs/dquot.c
--- linux-2.6.0-test7/fs/dquot.c	Tue Oct 14 15:52:08 2003
+++ linux-2.6.0-test7-1-lockfix/fs/dquot.c	Tue Oct 14 16:26:28 2003
@@ -826,28 +826,49 @@
 }
 
 /*
- * Release all quota for the specified inode.
- *
- * Note: this is a blocking operation.
+ *	Remove references to quota from inode
+ *	This function needs dqptr_sem for writing
  */
-static void dquot_drop_nolock(struct inode *inode)
+static void dquot_drop_iupdate(struct inode *inode, struct dquot **to_drop)
 {
 	int cnt;
 
 	inode->i_flags &= ~S_QUOTA;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (inode->i_dquot[cnt] == NODQUOT)
-			continue;
-		dqput(inode->i_dquot[cnt]);
+		to_drop[cnt] = inode->i_dquot[cnt];
 		inode->i_dquot[cnt] = NODQUOT;
 	}
 }
 
+/*
+ * 	Release all quotas referenced by inode
+ */
 void dquot_drop(struct inode *inode)
 {
+	struct dquot *to_drop[MAXQUOTAS];
+	int cnt;
+	
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	dquot_drop_nolock(inode);
+	dquot_drop_iupdate(inode, to_drop);
 	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if (to_drop[cnt] != NODQUOT)
+			dqput(to_drop[cnt]);
+}
+
+/*
+ *	Release all quotas referenced by inode.
+ *	This function assumes dqptr_sem for writing
+ */
+void dquot_drop_nolock(struct inode *inode)
+{
+	struct dquot *to_drop[MAXQUOTAS];
+	int cnt;
+
+	dquot_drop_iupdate(inode, to_drop);
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if (to_drop[cnt] != NODQUOT)
+			dqput(to_drop[cnt]);
 }
 
 /*
@@ -862,6 +883,10 @@
 		warntype[cnt] = NOWARN;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	if (IS_NOQUOTA(inode)) {
+		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		return QUOTA_OK;
+	}
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -894,6 +919,10 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	if (IS_NOQUOTA(inode)) {
+		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		return QUOTA_OK;
+	}
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -923,6 +952,10 @@
 	unsigned int cnt;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	if (IS_NOQUOTA(inode)) {
+		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		return;
+	}
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -942,6 +975,10 @@
 	unsigned int cnt;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	if (IS_NOQUOTA(inode)) {
+		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		return;
+	}
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
