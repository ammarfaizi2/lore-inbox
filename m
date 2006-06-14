Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWFNPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWFNPTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWFNPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:19:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60380 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965004AbWFNPTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:19:40 -0400
Date: Wed, 14 Jun 2006 10:18:40 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060614151840.GB12648@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060610102211.GE20526@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610102211.GE20526@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 11:22:11AM +0100, Christoph Hellwig wrote:
> > ecryptfs-crypto-functions.patch
> > ecryptfs-debug-functions.patch
> > ecryptfs-alpha-build-fix.patch
> > ecryptfs-convert-assert-to-bug_on.patch
> > ecryptfs-remove-unnecessary-null-checks.patch
> > ecryptfs-rewrite-ecryptfs_fsync.patch
> > ecryptfs-overhaul-file-locking.patch
> > 
> >  Christoph has half-reviewed this and all the issues arising from
> >  that have, I believe, been addressed.  With the exception of the
> >  "we should have a generic stacking layer" issue.  Which is true.
> >  Michael's take is "yes, but that's not my job".  Which also is
> >  true.

We are looking into how this can be best accomplished, given the
requirements of the various stackable filesystems out there.

> It's far from ready.  There's various things that simply can't be
> done properly in a lowlevel fs or abosulutely shouldn't.  And I
> think a few uniqueue gems in there.

We will work on fixes for any such issues brought to our attention. Up
to this point, we have provided fixes for all but two of the items
Christoph brought up in his initial analysis of eCryptfs. The
setlk/getlk code is redundant with the existing VFS implementations,
and so we are working on a fix for that.

> Most urgent thing of course is that we somehow need to deal with the
> idiocy of the nameidata passed into most namespace methods.

We would appreciate any suggestions folks in the community could give
on this.

Until then, is this patch a reasonable approach to address the problem
of just replacing the vfsmount and dentry in the existing nameidata
struct?

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

Don't muck with the existing nameidata structures.

---

 fs/ecryptfs/dentry.c |   18 +++++++-----------
 fs/ecryptfs/inode.c  |   14 +++++---------
 2 files changed, 12 insertions(+), 20 deletions(-)

5f0a8c57f8b51ba87cc950d1d2bac6873f73a8b3
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 7b1018a..6f19fc4 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -41,23 +41,19 @@ #include "ecryptfs_kernel.h"
  */
 static int ecryptfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	int err = 1;
+	int rc = 1;
 	struct dentry *lower_dentry;
-	struct dentry *saved_dentry;
-	struct vfsmount *saved_vfsmount;
+	struct nameidata lower_nd;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	if (!lower_dentry->d_op || !lower_dentry->d_op->d_revalidate)
 		goto out;
-	saved_dentry = nd->dentry;
-	saved_vfsmount = nd->mnt;
-	nd->dentry = lower_dentry;
-	nd->mnt = ecryptfs_superblock_to_private(dentry->d_sb)->lower_mnt;
-	err = lower_dentry->d_op->d_revalidate(lower_dentry, nd);
-	nd->dentry = saved_dentry;
-	nd->mnt = saved_vfsmount;
+	memcpy(&lower_nd, nd, sizeof(struct nameidata));
+	lower_nd.dentry = lower_dentry;
+	lower_nd.mnt = ecryptfs_superblock_to_private(dentry->d_sb)->lower_mnt;
+	rc = lower_dentry->d_op->d_revalidate(lower_dentry, &lower_nd);
 out:
-	return err;
+	return rc;
 }
 
 struct kmem_cache *ecryptfs_dentry_info_cache;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 47e4202..342b0fa 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -122,17 +122,13 @@ ecryptfs_create_underlying_file(struct i
 				struct nameidata *nd)
 {
 	int rc;
-	struct dentry *saved_dentry = NULL;
-	struct vfsmount *saved_vfsmount = NULL;
+	struct nameidata lower_nd;
 
-	saved_dentry = nd->dentry;
-	saved_vfsmount = nd->mnt;
-	nd->dentry = lower_dentry;
-	nd->mnt = ecryptfs_superblock_to_private(
+	memcpy(&lower_nd, nd, sizeof(struct nameidata));
+	lower_nd.dentry = lower_dentry;
+	lower_nd.mnt = ecryptfs_superblock_to_private(
 		ecryptfs_dentry->d_sb)->lower_mnt;
-	rc = vfs_create(lower_dir_inode, lower_dentry, mode, nd);
-	nd->dentry = saved_dentry;
-	nd->mnt = saved_vfsmount;
+	rc = vfs_create(lower_dir_inode, lower_dentry, mode, &lower_nd);
 	return rc;
 }
 
-- 
1.3.3

