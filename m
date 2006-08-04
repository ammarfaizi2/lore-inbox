Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161446AbWHDVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161446AbWHDVBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWHDVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:01:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50567 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161446AbWHDVBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:36 -0400
Subject: [PATCH] clean up OCFS2 nlink handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
In-Reply-To: <20060803002038.GI29686@ca-server1.us.oracle.com>
References: <20060801235240.82ADCA42@localhost.localdomain>
	 <20060801235243.EA4890B4@localhost.localdomain>
	 <20060802021411.GG29686@ca-server1.us.oracle.com>
	 <1154488906.7232.20.camel@localhost.localdomain>
	 <20060803002038.GI29686@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 14:01:32 -0700
Message-Id: <1154725292.10109.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 17:20 -0700, Mark Fasheh wrote:
> > -	saved_nlink = inode->i_nlink;
> > -	if (S_ISDIR(inode->i_mode))
> > -		inode->i_nlink = 0;
> > -	else
> > -		inode->i_nlink--;
> > -
> >  	status = ocfs2_request_unlink_vote(inode, dentry,
> >  					   (unsigned int) inode->i_nlink);
> The network request above needs to send what the new nlink will be set to.
> This is so that the other nodes which have an interest in the inode can
> determine whether the will need to do orphan processing on their last iput.
> 
> Really what they do is just compare against zero and mark the inode with a
> flag indicating that it may have been orphaned. So we could just pass the
> result of inode_is_unlinkable(), but I'd rather preserve the behavior that
> we have today.
> 
> The ugly method is:
> 
> -  	status = ocfs2_request_unlink_vote(inode, dentry,
> -  					   (unsigned int) inode->i_nlink);
> +   	status = ocfs2_request_unlink_vote(inode, dentry,
> +  		S_ISDIR(inode->i_mode) && inode->i_nlink == 2 ? 0 : inode->i_nlink - 1);
> 
> Better yet, we could store the result of the evaluation in a temporary
> variable and pass that through to the request function.

OK, I hope this does it.

-- Dave

OCFS2 does some operations on i_nlink, then reverts them if some
of its operations fail to complete.  This does not fit in well
with the inode_drop_nlink() logic where we expect i_nlink to stay
at zero once it gets there.

So, delay all of the nlink operations until we're sure that the
operations have completed.  Also, introduce a small helper to
check whether an inode has proper "unlinkable" i_nlink counts
no matter whether it is a directory or regular inode.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/ocfs2/namei.c      |   50 
 lxc-dave/fs/ocfs2/namei.c.orig | 2268 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 2294 insertions(+), 24 deletions(-)

diff -puN fs/ocfs2/namei.c~Re-_PATCH_04_28_OCFS2_is_screwy fs/ocfs2/namei.c
--- lxc/fs/ocfs2/namei.c~Re-_PATCH_04_28_OCFS2_is_screwy	2006-08-04 13:53:36.000000000 -0700
+++ lxc-dave/fs/ocfs2/namei.c	2006-08-04 13:59:15.000000000 -0700
@@ -744,11 +744,23 @@ bail:
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
+		inode_drop_nlink(inode);
+	inode_drop_nlink(inode);
 	fe->i_links_count = cpu_to_le16(inode->i_nlink);
-	saved_nlink = 0;
 
 	status = ocfs2_journal_dirty(handle, fe_bh);
 	if (status < 0) {
@@ -897,19 +903,15 @@ static int ocfs2_unlink(struct inode *di
 	}
 
 	if (S_ISDIR(inode->i_mode)) {
-		dir->i_nlink--;
 		status = ocfs2_mark_inode_dirty(handle, dir,
 						parent_node_bh);
-		if (status < 0) {
+		if (status < 0)
 			mlog_errno(status);
-			inc_nlink(dir);
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
 

