Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWFVWGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWFVWGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVWGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:06:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40076 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751557AbWFVWGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:06:22 -0400
Date: Thu, 22 Jun 2006 17:06:19 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eCryptfs: Fix filesize on hard link creation
Message-ID: <20060622220619.GC2817@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The filesize for both the source and destination is getting set to the
lower filesize on hard link creation. This patch saves and restores
the filesize so it is correct after the link operation is complete. It
also removes some extraneous initialization in
ecryptfs_read_header_region().

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |    6 +++---
 fs/ecryptfs/inode.c  |    5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

6efbc9375f4bf6980336f2cb24c54269a631a002
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e25239f..626a4c7 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1129,10 +1129,10 @@ int ecryptfs_cipher_code_to_string(char 
 int ecryptfs_read_header_region(char *data, struct dentry *dentry,
 				struct nameidata *nd)
 {
-	int rc = 0;
-	struct vfsmount *mnt = NULL;
-	struct file *file = NULL;
+	struct vfsmount *mnt;
+	struct file *file;
 	mm_segment_t oldfs;
+	int rc;
 
 	mnt = mntget(nd->mnt);
 	file = dentry_open(dentry, mnt, O_RDONLY);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 342b0fa..2a245d9 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -461,11 +461,13 @@ out:
 static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
 {
-	int rc;
 	struct dentry *lower_old_dentry;
 	struct dentry *lower_new_dentry;
 	struct dentry *lower_dir_dentry;
+	u64 file_size_save;
+	int rc;
 
+	file_size_save = i_size_read(old_dentry->d_inode);
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
 	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
 	dget(lower_old_dentry);
@@ -481,6 +483,7 @@ static int ecryptfs_link(struct dentry *
 	ecryptfs_copy_attr_timesizes(dir, lower_new_dentry->d_inode);
 	old_dentry->d_inode->i_nlink =
 		ecryptfs_inode_to_lower(old_dentry->d_inode)->i_nlink;
+	i_size_write(new_dentry->d_inode, file_size_save);
 out_lock:
 	unlock_dir(lower_dir_dentry);
 	dput(lower_new_dentry);
-- 
1.3.3

