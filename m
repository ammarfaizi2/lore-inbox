Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162071AbWKOXjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162071AbWKOXjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162072AbWKOXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:39:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38849 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1162071AbWKOXjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:39:05 -0500
Date: Wed, 15 Nov 2006 17:39:00 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, "Steven M. French" <sfrench@us.ibm.com>
Subject: [PATCH] eCryptfs: CIFS nlink fixes
Message-ID: <20061115233859.GG3409@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CIFS is the lower filesystem, the old lower dentry needs to be
explicitly dropped from inside eCryptfs to force a revalidate. In
addition, when CIFS is the lower filesystem, the inode attributes need
to be copied back up from the lower inode to the eCryptfs inode on an
eCryptfs revalidate.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/dentry.c |    6 ++++++
 fs/ecryptfs/inode.c  |    3 ++-
 2 files changed, 8 insertions(+), 1 deletions(-)

ddef902c356e65e01e8ca3f2cc073613e8fffdec
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 0b9992a..52d1e36 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -57,6 +57,12 @@ static int ecryptfs_d_revalidate(struct 
 	rc = lower_dentry->d_op->d_revalidate(lower_dentry, nd);
 	nd->dentry = dentry_save;
 	nd->mnt = vfsmount_save;
+	if (dentry->d_inode) {
+		struct inode *lower_inode =
+			ecryptfs_inode_to_lower(dentry->d_inode);
+
+		ecryptfs_copy_attr_all(dentry->d_inode, lower_inode);
+	}
 out:
 	return rc;
 }
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index ff4865d..fc0f624 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -470,6 +470,7 @@ out_lock:
 	unlock_dir(lower_dir_dentry);
 	dput(lower_new_dentry);
 	dput(lower_old_dentry);
+	d_drop(lower_old_dentry);
 	d_drop(new_dentry);
 	d_drop(old_dentry);
 	return rc;
@@ -484,7 +485,7 @@ static int ecryptfs_unlink(struct inode 
 	lock_parent(lower_dentry);
 	rc = vfs_unlink(lower_dir_inode, lower_dentry);
 	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error in vfs_unlink\n");
+		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
 	}
 	ecryptfs_copy_attr_times(dir, lower_dir_inode);
-- 
1.3.3

