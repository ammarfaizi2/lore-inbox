Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWIMTMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWIMTMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWIMTMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:12:38 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:50399 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751132AbWIMTMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:12:37 -0400
Date: Wed, 13 Sep 2006 12:12:17 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
       mm-commits@vger.kernel.org, akpm@osdl.org
Subject: Re: - r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch removed from -mm tree
Message-ID: <20060913191217.GJ8792@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200609130506.k8D56U3m018878@shell0.pdx.osdl.net> <20060913182716.GI8792@ca-server1.us.oracle.com> <1158172596.9141.91.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158172596.9141.91.camel@localhost.localdomain>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 11:36:36AM -0700, Dave Hansen wrote:
> I was _just_ fighting with your git tree to see what was conflicting!
> You have impeccable timing.
Heh, glad that the timing worked out :)


> > -	/* There are still a few steps left until we can consider the
> > -	 * unlink to have succeeded. Save off nlink here before
> > -	 * modification so we can set it back in case we hit an issue
> > -	 * before commit. */
> > -	saved_nlink = inode->i_nlink;
> > -	if (S_ISDIR(inode->i_mode))
> > -		inode->i_nlink = 0;
> > +	if (S_ISDIR(inode->i_mode) && (inode->i_nlink == 2))
> > +		future_nlink = 0;
> >  	else
> > -		inode->i_nlink--;
> > +		future_nlink = inode->i_nlink - 1;
> 
> Now that the vote call is gone, I don't think we even use future_nlink.
> Can we just kill this entire section?
Yeah, good catch. Lets try this one again...


Subject: r/o bind mounts: clean up OCFS2 nlink handling
From: Dave Hansen <haveblue@us.ibm.com>

OCFS2 does some operations on i_nlink, then reverts them if some of its
operations fail to complete.  This does not fit in well with the
drop_nlink() logic where we expect i_nlink to stay at zero once it gets there.

So, delay all of the nlink operations until we're sure that the operations
have completed.  Also, introduce a small helper to check whether an inode
has proper "unlinkable" i_nlink counts no matter whether it is a directory or
regular inode.

This patch is broken out from the others because it does contain some
logical changes.

Cc: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 4cfc061..1c3d296 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -797,11 +797,23 @@ static int ocfs2_remote_dentry_delete(st
 	return ret;
 }
 
+static inline int inode_is_unlinkable(struct inode *inode)
+{
+	if (S_ISDIR(inode->i_mode)) {
+		if (inode->i_nlink == 2)
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
@@ -876,16 +888,6 @@ static int ocfs2_unlink(struct inode *di
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
 	status = ocfs2_remote_dentry_delete(dentry);
 	if (status < 0) {
 		/* This vote should succeed under all normal
@@ -894,7 +896,7 @@ static int ocfs2_unlink(struct inode *di
 		goto leave;
 	}
 
-	if (!inode->i_nlink) {
+	if (inode_is_unlinkable(inode)) {
 		status = ocfs2_prepare_orphan_dir(osb, handle, inode,
 						  orphan_name,
 						  &orphan_entry_bh);
@@ -921,7 +923,7 @@ static int ocfs2_unlink(struct inode *di
 
 	fe = (struct ocfs2_dinode *) fe_bh->b_data;
 
-	if (!inode->i_nlink) {
+	if (inode_is_unlinkable(inode)) {
 		status = ocfs2_orphan_add(osb, handle, inode, fe, orphan_name,
 					  orphan_entry_bh);
 		if (status < 0) {
@@ -937,10 +939,10 @@ static int ocfs2_unlink(struct inode *di
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
@@ -949,7 +951,7 @@ static int ocfs2_unlink(struct inode *di
 	}
 
 	if (S_ISDIR(inode->i_mode)) {
-		dir->i_nlink--;
+		drop_nlink(dir);
 		status = ocfs2_mark_inode_dirty(handle, dir,
 						parent_node_bh);
 		if (status < 0) {
@@ -959,9 +961,6 @@ static int ocfs2_unlink(struct inode *di
 	}
 
 leave:
-	if (status < 0 && saved_nlink)
-		inode->i_nlink = saved_nlink;
-
 	if (handle)
 		ocfs2_commit_trans(handle);
 
