Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWHIQ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWHIQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWHIQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:59:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:59022 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750878AbWHIQ5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:57:36 -0400
Subject: [PATCH 5/6] clean up OCFS2 nlink handling
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 09 Aug 2006 09:57:33 -0700
References: <20060809165729.FE36B262@localhost.localdomain>
In-Reply-To: <20060809165729.FE36B262@localhost.localdomain>
Message-Id: <20060809165733.704AD0F5@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OCFS2 does some operations on i_nlink, then reverts them if some
of its operations fail to complete.  This does not fit in well
with the drop_nlink() logic where we expect i_nlink to stay at
zero once it gets there.

So, delay all of the nlink operations until we're sure that the
operations have completed.  Also, introduce a small helper to
check whether an inode has proper "unlinkable" i_nlink counts
no matter whether it is a directory or regular inode.

This patch is broken out from the others because it does contain
some logical changes.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>
---

 arch/i386/kernel/setup.c  |    0 
 lxc-dave/fs/ocfs2/namei.c |   45 ++++++++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff -puN fs/ocfs2/namei.c~B5-clean_up_OCFS2_nlink_handling fs/ocfs2/namei.c
--- lxc/fs/ocfs2/namei.c~B5-clean_up_OCFS2_nlink_handling	2006-08-08 09:18:54.000000000 -0700
+++ lxc-dave/fs/ocfs2/namei.c	2006-08-08 09:18:56.000000000 -0700
@@ -744,11 +744,23 @@ bail:
 	return err;
 }
 
+static inline int inode_is_unlinkable(struct inode *inode)
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
@@ -760,6 +772,7 @@ static int ocfs2_unlink(struct inode *di
 	struct buffer_head *dirent_bh = NULL;
 	char orphan_name[OCFS2_ORPHAN_NAMELEN + 1];
 	struct buffer_head *orphan_entry_bh = NULL;
+	unsigned int future_nlink;
 
 	mlog_entry("(0x%p, 0x%p, '%.*s')\n", dir, dentry,
 		   dentry->d_name.len, dentry->d_name.name);
@@ -823,18 +836,11 @@ static int ocfs2_unlink(struct inode *di
 		}
 	}
 
-	/* There are still a few steps left until we can consider the
-	 * unlink to have succeeded. Save off nlink here before
-	 * modification so we can set it back in case we hit an issue
-	 * before commit. */
-	saved_nlink = inode->i_nlink;
-	if (S_ISDIR(inode->i_mode))
-		inode->i_nlink = 0;
+	if (S_ISDIR(inode->i_mode) && (inode->i_nlink == 2))
+		future_nlink = 0;
 	else
-		inode->i_nlink--;
-
-	status = ocfs2_request_unlink_vote(inode, dentry,
-					   (unsigned int) inode->i_nlink);
+		future_nlink = inode->i_nlink - 1;
+	status = ocfs2_request_unlink_vote(inode, dentry, future_nlink);
 	if (status < 0) {
 		/* This vote should succeed under all normal
 		 * circumstances. */
@@ -842,7 +848,7 @@ static int ocfs2_unlink(struct inode *di
 		goto leave;
 	}
 
-	if (!inode->i_nlink) {
+	if (inode_is_unlinkable(inode)) {
 		status = ocfs2_prepare_orphan_dir(osb, handle, inode,
 						  orphan_name,
 						  &orphan_entry_bh);
@@ -869,7 +875,7 @@ static int ocfs2_unlink(struct inode *di
 
 	fe = (struct ocfs2_dinode *) fe_bh->b_data;
 
-	if (!inode->i_nlink) {
+	if (inode_is_unlinkable(inode)) {
 		status = ocfs2_orphan_add(osb, handle, inode, fe, orphan_name,
 					  orphan_entry_bh);
 		if (status < 0) {
@@ -885,10 +891,10 @@ static int ocfs2_unlink(struct inode *di
 		goto leave;
 	}
 
-	/* We can set nlink on the dinode now. clear the saved version
-	 * so that it doesn't get set later. */
+	if (S_ISDIR(inode->i_mode))
+		drop_nlink(inode);
+	drop_nlink(inode);
 	fe->i_links_count = cpu_to_le16(inode->i_nlink);
-	saved_nlink = 0;
 
 	status = ocfs2_journal_dirty(handle, fe_bh);
 	if (status < 0) {
@@ -897,7 +903,7 @@ static int ocfs2_unlink(struct inode *di
 	}
 
 	if (S_ISDIR(inode->i_mode)) {
-		dir->i_nlink--;
+		drop_nlink(dir);
 		status = ocfs2_mark_inode_dirty(handle, dir,
 						parent_node_bh);
 		if (status < 0) {
@@ -907,9 +913,6 @@ static int ocfs2_unlink(struct inode *di
 	}
 
 leave:
-	if (status < 0 && saved_nlink)
-		inode->i_nlink = saved_nlink;
-
 	if (handle)
 		ocfs2_commit_trans(handle);
 
diff -puN arch/i386/kernel/setup.c~B5-clean_up_OCFS2_nlink_handling arch/i386/kernel/setup.c
_
