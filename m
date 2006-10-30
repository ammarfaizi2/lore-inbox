Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161554AbWJ3Xlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161554AbWJ3Xlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbWJ3Xlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:41:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:19864 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161554AbWJ3Xlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:41:50 -0500
Date: Mon, 30 Oct 2006 17:41:30 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com
Subject: [PATCH 6/6] eCryptfs: Fix handling of lower d_count
Message-ID: <20061030234129.GE21515@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233209.GC3458@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the use of dget/dput calls to balance out on the lower filesystem.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/dentry.c |    8 ++++++
 fs/ecryptfs/inode.c  |   62 ++++++++++++++++----------------------------------
 2 files changed, 27 insertions(+), 43 deletions(-)

0277a301b99c7a2270fcca1e2c2ada96037b6fa1
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index f0d2a43..0b9992a 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -24,6 +24,7 @@
 
 #include <linux/dcache.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 #include "ecryptfs_kernel.h"
 
 /**
@@ -76,8 +77,13 @@ static void ecryptfs_d_release(struct de
 	if (ecryptfs_dentry_to_private(dentry))
 		kmem_cache_free(ecryptfs_dentry_info_cache,
 				ecryptfs_dentry_to_private(dentry));
-	if (lower_dentry)
+	if (lower_dentry) {
+		struct vfsmount *lower_mnt =
+			ecryptfs_dentry_to_lower_mnt(dentry);
+
+		mntput(lower_mnt);
 		dput(lower_dentry);
+	}
 	return;
 }
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 2f2c6cf..ff4865d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -325,7 +325,6 @@ static struct dentry *ecryptfs_lookup(st
 	struct dentry *lower_dir_dentry;
 	struct dentry *lower_dentry;
 	struct vfsmount *lower_mnt;
-	struct dentry *tlower_dentry = NULL;
 	char *encoded_name;
 	unsigned int encoded_namelen;
 	struct ecryptfs_crypt_stat *crypt_stat = NULL;
@@ -336,27 +335,32 @@ static struct dentry *ecryptfs_lookup(st
 	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
 	dentry->d_op = &ecryptfs_dops;
 	if ((dentry->d_name.len == 1 && !strcmp(dentry->d_name.name, "."))
-	    || (dentry->d_name.len == 2 && !strcmp(dentry->d_name.name, "..")))
-		goto out_drop;
+	    || (dentry->d_name.len == 2
+		&& !strcmp(dentry->d_name.name, ".."))) {
+		d_drop(dentry);
+		goto out;
+	}
 	encoded_namelen = ecryptfs_encode_filename(crypt_stat,
 						   dentry->d_name.name,
 						   dentry->d_name.len,
 						   &encoded_name);
 	if (encoded_namelen < 0) {
 		rc = encoded_namelen;
-		goto out_drop;
+		d_drop(dentry);
+		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "encoded_name = [%s]; encoded_namelen "
 			"= [%d]\n", encoded_name, encoded_namelen);
 	lower_dentry = lookup_one_len(encoded_name, lower_dir_dentry,
 				      encoded_namelen - 1);
 	kfree(encoded_name);
-	lower_mnt = mntget(ecryptfs_dentry_to_lower_mnt(dentry->d_parent));
 	if (IS_ERR(lower_dentry)) {
 		ecryptfs_printk(KERN_ERR, "ERR from lower_dentry\n");
 		rc = PTR_ERR(lower_dentry);
-		goto out_drop;
+		d_drop(dentry);
+		goto out;
 	}
+	lower_mnt = mntget(ecryptfs_dentry_to_lower_mnt(dentry->d_parent));
 	ecryptfs_printk(KERN_DEBUG, "lower_dentry = [%p]; lower_dentry->"
        		"d_name.name = [%s]\n", lower_dentry,
 		lower_dentry->d_name.name);
@@ -397,12 +401,6 @@ static struct dentry *ecryptfs_lookup(st
 				"as we *think* we are about to unlink\n");
 		goto out;
 	}
-	tlower_dentry = dget(lower_dentry);
-	if (!tlower_dentry || IS_ERR(tlower_dentry)) {
-		rc = -ENOMEM;
-		ecryptfs_printk(KERN_ERR, "Cannot dget lower_dentry\n");
-		goto out_dput;
-	}
 	/* Released in this function */
 	page_virt =
 	    (char *)kmem_cache_alloc(ecryptfs_header_cache_2,
@@ -414,7 +412,7 @@ static struct dentry *ecryptfs_lookup(st
 		goto out_dput;
 	}
 	memset(page_virt, 0, PAGE_CACHE_SIZE);
-	rc = ecryptfs_read_header_region(page_virt, tlower_dentry, nd->mnt);
+	rc = ecryptfs_read_header_region(page_virt, lower_dentry, nd->mnt);
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED))
 		ecryptfs_set_default_sizes(crypt_stat);
@@ -437,9 +435,6 @@ static struct dentry *ecryptfs_lookup(st
 
 out_dput:
 	dput(lower_dentry);
-	if (tlower_dentry)
-		dput(tlower_dentry);
-out_drop:
 	d_drop(dentry);
 out:
 	return ERR_PTR(rc);
@@ -475,8 +470,8 @@ out_lock:
 	unlock_dir(lower_dir_dentry);
 	dput(lower_new_dentry);
 	dput(lower_old_dentry);
-	if (!new_dentry->d_inode)
-		d_drop(new_dentry);
+	d_drop(new_dentry);
+	d_drop(old_dentry);
 	return rc;
 }
 
@@ -565,41 +560,24 @@ out:
 
 static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int rc = 0;
-	struct dentry *tdentry = NULL;
 	struct dentry *lower_dentry;
-	struct dentry *tlower_dentry = NULL;
 	struct dentry *lower_dir_dentry;
+	int rc;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	if (!(tdentry = dget(dentry))) {
-		rc = -EINVAL;
-		ecryptfs_printk(KERN_ERR, "Error dget'ing dentry [%p]\n",
-				dentry);
-		goto out;
-	}
+	dget(dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
-	if (!(tlower_dentry = dget(lower_dentry))) {
-		rc = -EINVAL;
-		ecryptfs_printk(KERN_ERR, "Error dget'ing lower_dentry "
-				"[%p]\n", lower_dentry);
-		goto out;
-	}
+	dget(lower_dentry);
 	rc = vfs_rmdir(lower_dir_dentry->d_inode, lower_dentry);
-	if (!rc) {
-		d_delete(tlower_dentry);
-		tlower_dentry = NULL;
-	}
+	dput(lower_dentry);
+	if (!rc)
+		d_delete(lower_dentry);
 	ecryptfs_copy_attr_times(dir, lower_dir_dentry->d_inode);
 	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
 	unlock_dir(lower_dir_dentry);
 	if (!rc)
 		d_drop(dentry);
-out:
-	if (tdentry)
-		dput(tdentry);
-	if (tlower_dentry)
-		dput(tlower_dentry);
+	dput(dentry);
 	return rc;
 }
 
-- 
1.3.3

