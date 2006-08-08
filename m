Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWHHTSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWHHTSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWHHTSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:18:01 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6053 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030222AbWHHTSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:18:00 -0400
Date: Tue, 8 Aug 2006 14:17:57 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eCryptfs: Graceful handling of mount error
Message-ID: <20060808191757.GA21091@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the error path for when eCryptfs has trouble mounting.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/main.c |   40 ++++++++++++++--------------------------
 1 files changed, 14 insertions(+), 26 deletions(-)

75540fc7a82eedde5adc20176f58cee8596fa5d2
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index dd34089..9cb7a72 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -369,18 +369,6 @@ out:
 struct kmem_cache *ecryptfs_sb_info_cache;
 
 /**
- * ecryptfs_cleanup_read_super
- * @sb: The ecryptfs super block
- *
- * Preform the cleanup for ecryptfs_read_super()
- */
-static void ecryptfs_cleanup_read_super(struct super_block *sb)
-{
-	up_write(&sb->s_umount);
-	deactivate_super(sb);
-}
-
-/**
  * ecryptfs_fill_super
  * @sb: The ecryptfs super block
  * @raw_data: The options passed to mount
@@ -433,7 +421,7 @@ ecryptfs_fill_super(struct super_block *
 	       sizeof(struct ecryptfs_dentry_info));
 	rc = 0;
 out:
-	/* Should be able to rely on deactive_super called from
+	/* Should be able to rely on deactivate_super called from
 	 * get_sb_nodev */
 	return rc;
 }
@@ -478,7 +466,6 @@ static int ecryptfs_read_super(struct su
 	goto out;
 out_free:
 	path_release(&nd);
-	ecryptfs_cleanup_read_super(sb);
 out:
 	return rc;
 }
@@ -504,30 +491,31 @@ static int ecryptfs_get_sb(struct file_s
 			struct vfsmount *mnt)
 {
 	int rc;
-	int ret;
 	struct super_block *sb;
 
-	ret = get_sb_nodev(fs_type, flags, raw_data, ecryptfs_fill_super, mnt);
-	if (ret < 0) {
-		ecryptfs_printk(KERN_ERR, "Getting sb failed: %d\n", ret);
+	rc = get_sb_nodev(fs_type, flags, raw_data, ecryptfs_fill_super, mnt);
+	if (rc < 0) {
+		printk(KERN_ERR "Getting sb failed; rc = [%d]\n", rc);
 		goto out;
 	}
 	sb = mnt->mnt_sb;
 	rc = ecryptfs_parse_options(sb, raw_data);
 	if (rc) {
-		deactivate_super(sb);
-		ret = rc;
-		goto out;
+		printk(KERN_ERR "Error parsing options; rc = [%d]\n", rc);
+		goto out_abort;
 	}
 	rc = ecryptfs_read_super(sb, dev_name);
 	if (rc) {
-		up_write(&sb->s_umount);
-		deactivate_super(sb);
-		ret = rc;
-		ecryptfs_printk(KERN_ERR, "Reading sb failed: %d\n", ret);
+		printk(KERN_ERR "Reading sb failed; rc = [%d]\n", rc);
+		goto out_abort;
 	}
+	goto out;
+out_abort:
+	dput(sb->s_root);
+	up_write(&sb->s_umount);
+	deactivate_super(sb);
 out:
-	return ret;
+	return rc;
 }
 
 /**
-- 
1.3.3

