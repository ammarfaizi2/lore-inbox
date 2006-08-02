Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWHBDZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWHBDZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWHBDZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:25:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:50874 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751105AbWHBDZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:25:02 -0400
Subject: Re: [PATCH 04/28] OCFS2 is (not) screwy
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
In-Reply-To: <20060802021411.GG29686@ca-server1.us.oracle.com>
References: <20060801235240.82ADCA42@localhost.localdomain>
	 <20060801235243.EA4890B4@localhost.localdomain>
	 <20060802021411.GG29686@ca-server1.us.oracle.com>
Content-Type: multipart/mixed; boundary="=-yYgg0ZWCMFfvHuXfxIfF"
Date: Tue, 01 Aug 2006 20:19:55 -0700
Message-Id: <1154488795.7232.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yYgg0ZWCMFfvHuXfxIfF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-08-01 at 19:14 -0700, Mark Fasheh wrote:
> On Tue, Aug 01, 2006 at 04:52:43PM -0700, Dave Hansen wrote:
> > OCFS2 plays some games with i_nlink.  It modifies it a bunch in
> > its unlink function, but rolls back the changes if an error
> > occurs.  So, we can't just assume that iput_final() will happen
> > whenever i_nlink hits 0 in ocfs's unlink().
> Huh? Did you read the code? Or is it just easier to call things "screwy" and
> start hacking away?
> 
> i_nlink only gets rolled back in the case that the file system wasn't able to
> actually complete the unlink / orphan operation. The idea is to keep it in
> sync with what's actually on disk. So when we call iput() in the unlink
> path, disk and struct inode should be accurate.

BTW, some gunk appears to have migrated into this patch that should have
been earlier in the series.  I'll fix that up.

What do you think about the attached patch?  It delays actually touching
i_nlink until the place where saved_nlink used to be zero'd.  I assume
that is the point when we're sure that the inode is going to go away.

Also, instead of just clearing i_nlink for the directory case, I just do
two decrements.  I did that for a few other filesystems as well.  I
guess it can be collapsed to a single operation, but I'm not sure it is
worth the trouble.

Completely and utterly untested, uncompiled patch attached.  Please
consider its filename a formal apology for calling your filesystem
screwy. :)

It might also be worth putting the 'double decrement i_nlink if it is a
directory' behavior in libfs.c.  It appears to be pretty common logic
around the different filesystems.

Thanks for the thorough review!

-- Dave

--=-yYgg0ZWCMFfvHuXfxIfF
Content-Disposition: attachment; filename=ocfs-is-not-screwy.patch
Content-Type: text/x-patch; name=ocfs-is-not-screwy.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux-2.6-patches/fs/ocfs2/namei.c.orig	2006-08-01 20:00:58.000000000 -0700
+++ linux-2.6-patches/fs/ocfs2/namei.c	2006-08-01 20:08:14.000000000 -0700
@@ -748,7 +748,6 @@
 			struct dentry *dentry)
 {
 	int status;
-	unsigned int saved_nlink = 0;
 	struct inode *inode = dentry->d_inode;
 	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
 	u64 blkno;
@@ -823,16 +822,6 @@
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
@@ -842,7 +831,7 @@
 		goto leave;
 	}
 
-	if (!inode->i_nlink) {
+	if (inode->i_nlink == 1) {
 		status = ocfs2_prepare_orphan_dir(osb, handle, inode,
 						  orphan_name,
 						  &orphan_entry_bh);
@@ -869,7 +858,7 @@
 
 	fe = (struct ocfs2_dinode *) fe_bh->b_data;
 
-	if (!inode->i_nlink) {
+	if (inode->i_nlink == 1) {
 		status = ocfs2_orphan_add(osb, handle, inode, fe, orphan_name,
 					  orphan_entry_bh);
 		if (status < 0) {
@@ -888,7 +877,9 @@
 	/* We can set nlink on the dinode now. clear the saved version
 	 * so that it doesn't get set later. */
 	fe->i_links_count = cpu_to_le16(inode->i_nlink);
-	saved_nlink = 0;
+	inode_drop_nlink(inode);
+	if (S_ISDIR(inode->i_mode))
+		inode_drop_nlink(inode);
 
 	status = ocfs2_journal_dirty(handle, fe_bh);
 	if (status < 0) {
@@ -897,19 +888,15 @@
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
 

--=-yYgg0ZWCMFfvHuXfxIfF--

