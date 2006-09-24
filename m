Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWIXWLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWIXWLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWIXWLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:11:42 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:13937 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751217AbWIXWLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:11:41 -0400
Date: Sun, 24 Sep 2006 15:11:15 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: [git patches] ocfs2 post 2.6.18 features
Message-ID: <20060924221115.GF32106@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
	This series completes the final set of ocfs2 patches which I wanted
to merge upstream before 2.6.18-rc1.

These patches build on top of each other to improve ocfs2 cluster
messaging/locking.

The patch is too large for e-mail, changes are broken up in git and
can also be found at:

http://www.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-upstream-linus-20060924/


The first set removes an expensive clusterwide message sent during
unlink/rename (we call this the "dentry vote"). It gets replaced with a
cluster lock which covers a set of dentries. This gives us an improvement in
average-case unlink performance and reduces the file systems reliance on
direct cluster messaging. A patch to the VFS and NFS was required to get
this going. It's the final version of a patch which was initially mailed to
linux-kernel and linux-fsdevel on August 29:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115689222430028&w=2

The relevant parties are CC'd here, and the patch is attached to this e-mail
for any last-minute review.

Essentially, ocfs2 wanted to manually d_move() inside of rename. NFS already
does this for file renames, but ocfs2 wants to do it for all rename types,
which required also making NFS handle the d_move() for all types and fixing
up the VFS to check for the "FS_RENAME_DOES_D_MOVE" flag (which used to be
FS_ODD_RENAME) in vfs_rename_dir().


The second set revamps the way inode meta data locks are named, removing
i_generation from them. This way, a meta data lock can be acquired in
ocfs2_read_locked_inode() before reading the inode block off disk. Since the
read is covered by a lock, it can remain cached and won't have to be re-read
at a later date when the lock is acquired. My tests of cold-cache stat
timings have shown this to give a performance improvement of up to 20%.


The third set is a cleanup of dlmglue.c. No actual algorithms were changed,
some duplicated code was removed and all the different lock type specific
DLM callbacks were collapsed into a generic set that all locks can share.


And finally, my apologies for sending you multiple git pull requests so
closely spaced together. I mostly just wanted to see this patch set pushed
upstream as a logical unit.

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

to receive the following updates:

 fs/namei.c                      |    6 
 fs/nfs/dir.c                    |    3 
 fs/nfs/super.c                  |   10 
 fs/ocfs2/cluster/tcp_internal.h |    8 
 fs/ocfs2/dcache.c               |  359 ++++++++++++-
 fs/ocfs2/dcache.h               |   27 
 fs/ocfs2/dlm/dlmapi.h           |    1 
 fs/ocfs2/dlm/dlmast.c           |    6 
 fs/ocfs2/dlm/dlmcommon.h        |    1 
 fs/ocfs2/dlm/dlmlock.c          |   10 
 fs/ocfs2/dlm/dlmmaster.c        |    4 
 fs/ocfs2/dlm/dlmrecovery.c      |    3 
 fs/ocfs2/dlm/userdlm.c          |   81 +-
 fs/ocfs2/dlm/userdlm.h          |    1 
 fs/ocfs2/dlmglue.c              | 1094 ++++++++++++++++++++--------------------
 fs/ocfs2/dlmglue.h              |   21 
 fs/ocfs2/export.c               |    8 
 fs/ocfs2/inode.c                |  156 ++++-
 fs/ocfs2/inode.h                |    8 
 fs/ocfs2/journal.c              |    3 
 fs/ocfs2/namei.c                |  116 ++--
 fs/ocfs2/ocfs2_lockid.h         |   25 
 fs/ocfs2/super.c                |    6 
 fs/ocfs2/sysfile.c              |    6 
 fs/ocfs2/vote.c                 |  180 ------
 fs/ocfs2/vote.h                 |    5 
 include/linux/fs.h              |    7 
 27 files changed, 1245 insertions(+), 910 deletions(-)

Mark Fasheh:
      ocfs2: Silence dlm error print
      ocfs2: Allow binary names in the DLM
      ocfs2: Update dlmfs for new dlmlock() API
      ocfs2: Update dlmglue for new dlmlock() API
      ocfs2: Add new cluster lock type
      ocfs2: Add dentry tracking API
      ocfs2: Hook rest of the file system into dentry locking API
      ocfs2: Remove the dentry vote
      Allow file systems to manually d_move() inside of ->rename()
      ocfs2: manually d_move() during ocfs2_rename()
      ocfs2: Remove special casing for inode creation in ocfs2_dentry_attach_lock()
      ocfs2: Free up some space in the lvb
      ocfs2: Encode i_generation in the meta data lvb
      ocfs2: Remove i_generation from inode lock names
      ocfs2: Clean up lock resource refresh flags
      ocfs2: combine inode and generic AST functions
      ocfs2: remove ->unlock_ast() callback from ocfs2_lock_res_ops
      ocfs2: Add ->get_osb() dlmglue locking operation
      ocfs2: combine inode and generic blocking AST functions
      ocfs2: don't unconditionally pass LVB flags
      ocfs2: Check for refreshing locks in generic unblock function
      ocfs2: Add ->check_downconvert callback in dlmglue
      ocfs2: Add ->set_lvb callback in dlmglue
      ocfs2: Have the metadata lock use generic dlmglue functions
      ocfs2: Remove unused dlmglue functions
      ocfs2: move downconvert worker to lockres ops
      ocfs2: Remove ->unblock lockres operation
      ocfs2: Teach ocfs2_drop_lock() to use ->set_lvb() callback



>From 349457ccf2592c14bdf13b6706170ae2e94931b1 Mon Sep 17 00:00:00 2001
From: Mark Fasheh <mark.fasheh@oracle.com>
Date: Fri, 8 Sep 2006 14:22:21 -0700
Subject: [PATCH] Allow file systems to manually d_move() inside of ->rename()

Some file systems want to manually d_move() the dentries involved in a
rename.  We can do this by making use of the FS_ODD_RENAME flag if we just
have nfs_rename() unconditionally do the d_move().  While there, we rename
the flag to be more descriptive.

OCFS2 uses this to protect that part of the rename operation with a cluster
lock.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 fs/namei.c         |    6 +++---
 fs/nfs/dir.c       |    3 +--
 fs/nfs/super.c     |   10 +++++-----
 include/linux/fs.h |    7 ++++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 432d6bc..6b591c0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2370,7 +2370,8 @@ static int vfs_rename_dir(struct inode *
 		dput(new_dentry);
 	}
 	if (!error)
-		d_move(old_dentry,new_dentry);
+		if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE))
+			d_move(old_dentry,new_dentry);
 	return error;
 }
 
@@ -2393,8 +2394,7 @@ static int vfs_rename_other(struct inode
 	else
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (!error) {
-		/* The following d_move() should become unconditional */
-		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
+		if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE))
 			d_move(old_dentry, new_dentry);
 	}
 	if (target)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3419c2d..7432f1a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1669,8 +1669,7 @@ out:
 	if (rehash)
 		d_rehash(rehash);
 	if (!error) {
-		if (!S_ISDIR(old_inode->i_mode))
-			d_move(old_dentry, new_dentry);
+		d_move(old_dentry, new_dentry);
 		nfs_renew_times(new_dentry);
 		nfs_set_verifier(new_dentry, nfs_save_change_attribute(new_dir));
 	}
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index b99113b..e8d4003 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -71,7 +71,7 @@ static struct file_system_type nfs_fs_ty
 	.name		= "nfs",
 	.get_sb		= nfs_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 struct file_system_type nfs_xdev_fs_type = {
@@ -79,7 +79,7 @@ struct file_system_type nfs_xdev_fs_type
 	.name		= "nfs",
 	.get_sb		= nfs_xdev_get_sb,
 	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 static struct super_operations nfs_sops = {
@@ -107,7 +107,7 @@ static struct file_system_type nfs4_fs_t
 	.name		= "nfs4",
 	.get_sb		= nfs4_get_sb,
 	.kill_sb	= nfs4_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 struct file_system_type nfs4_xdev_fs_type = {
@@ -115,7 +115,7 @@ struct file_system_type nfs4_xdev_fs_typ
 	.name		= "nfs4",
 	.get_sb		= nfs4_xdev_get_sb,
 	.kill_sb	= nfs4_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 struct file_system_type nfs4_referral_fs_type = {
@@ -123,7 +123,7 @@ struct file_system_type nfs4_referral_fs
 	.name		= "nfs4",
 	.get_sb		= nfs4_referral_get_sb,
 	.kill_sb	= nfs4_kill_super,
-	.fs_flags	= FS_ODD_RENAME|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_REVAL_DOT|FS_BINARY_MOUNTDATA,
 };
 
 static struct super_operations nfs4_sops = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 555bc19..1d3e601 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -92,9 +92,10 @@ #define SEL_EX		4
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
-#define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
-				  * as nfs_rename() will be cleaned up
-				  */
+#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move()
+					 * during rename() internally.
+					 */
+
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  */
-- 
1.4.2.1

