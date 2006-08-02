Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWHBDZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWHBDZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHBDZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:25:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:6030 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751106AbWHBDZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:25:13 -0400
Subject: Re: [PATCH 04/28] OCFS2 is screwy
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
In-Reply-To: <20060802021411.GG29686@ca-server1.us.oracle.com>
References: <20060801235240.82ADCA42@localhost.localdomain>
	 <20060801235243.EA4890B4@localhost.localdomain>
	 <20060802021411.GG29686@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 20:21:46 -0700
Message-Id: <1154488906.7232.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore that last one.  It didn't correctly handle directories'
with a remaining i_nlink of 2.

--- linux-2.6-patches/fs/ocfs2/namei.c.orig	2006-08-01 20:00:58.000000000 -0700
+++ linux-2.6-patches/fs/ocfs2/namei.c	2006-08-01 20:17:45.000000000 -0700
@@ -744,11 +744,23 @@
 	return err;
 }
 
+static inline inode_is_unlinkable(struct inode *inode)
+{
+	if (S_ISDIR(inode->i_mode)) {
+	       	if (inode->i_nlink == 2)
+			return 1;
+		return 0;
+	}
+	
+	if (inode->i_nlink == 1)
+		return 1;
+	return 0;
+}
+
 static int ocfs2_unlink(struct inode *dir,
 			struct dentry *dentry)
 {
 	int status;
-	unsigned int saved_nlink = 0;
 	struct inode *inode = dentry->d_inode;
 	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
 	u64 blkno;
@@ -823,16 +835,6 @@
 		}
 	}
 
-	/* There are still a few steps left until we can consider the
-	 * unlink to have succeeded. Save off nlink here before
-	 * modification so we can set it back in case we hit an issue
-	 * before commit. */
-	saved_nlink = inode->i_nlink;
-	if (S_ISDIR(inode->i_mode))
-		inode->i_nlink = 0;
-	else
-		inode->i_nlink--;
-
 	status = ocfs2_request_unlink_vote(inode, dentry,
 					   (unsigned int) inode->i_nlink);
 	if (status < 0) {
@@ -842,7 +844,7 @@
 		goto leave;
 	}
 
-	if (!inode->i_nlink) {
+	if (inode_is_unlinkable(inode)) {
 		status = ocfs2_prepare_orphan_dir(osb, handle, inode,
 						  orphan_name,
 						  &orphan_entry_bh);
@@ -869,7 +871,7 @@
 
 	fe = (struct ocfs2_dinode *) fe_bh->b_data;
 
-	if (!inode->i_nlink) {
+	if (inode_is_unlinkable(inode)) {
 		status = ocfs2_orphan_add(osb, handle, inode, fe, orphan_name,
 					  orphan_entry_bh);
 		if (status < 0) {
@@ -888,7 +890,9 @@
 	/* We can set nlink on the dinode now. clear the saved version
 	 * so that it doesn't get set later. */
 	fe->i_links_count = cpu_to_le16(inode->i_nlink);
-	saved_nlink = 0;
+	inode_drop_nlink(inode);
+	if (S_ISDIR(inode->i_mode))
+		inode_drop_nlink(inode);
 
 	status = ocfs2_journal_dirty(handle, fe_bh);
 	if (status < 0) {
@@ -897,19 +901,15 @@
 	}
 
 	if (S_ISDIR(inode->i_mode)) {
-		dir->i_nlink--;
 		status = ocfs2_mark_inode_dirty(handle, dir,
 						parent_node_bh);
-		if (status < 0) {
+		if (status < 0)
 			mlog_errno(status);
-			dir->i_nlink++;
-		}
+		else
+			inode_drop_nlink(dir);
 	}
 
 leave:
-	if (status < 0 && saved_nlink)
-		inode->i_nlink = saved_nlink;
-
 	if (handle)
 		ocfs2_commit_trans(handle);
 

-- Dave

