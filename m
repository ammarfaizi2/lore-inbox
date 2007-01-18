Return-Path: <linux-kernel-owner+w=401wt.eu-S1751582AbXARV3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbXARV3h (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXARV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:29:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47836 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbXARV3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:29:35 -0500
Date: Thu, 18 Jan 2007 15:29:33 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] eCryptfs: convert lookup_one_len() to lookup_one_len_nd()
Message-ID: <20070118212933.GG3643@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070118212627.GC3643@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118212627.GC3643@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call the new lookup_one_len_nd() rather than lookup_one_len(). This
fixes an oops when stacked on NFS.

Note that there are still some issues with eCryptfs on NFS having to
do with directory deletion (I'm not getting an oops, just an -EBUSY).

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---
 fs/ecryptfs/inode.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 9135718..cf02a66 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -283,7 +283,9 @@ static struct dentry *ecryptfs_lookup(st
 	int rc = 0;
 	struct dentry *lower_dir_dentry;
 	struct dentry *lower_dentry;
+	struct dentry *dentry_save;
 	struct vfsmount *lower_mnt;
+	struct vfsmount *mnt_save;
 	char *encoded_name;
 	unsigned int encoded_namelen;
 	struct ecryptfs_crypt_stat *crypt_stat = NULL;
@@ -311,9 +313,13 @@ static struct dentry *ecryptfs_lookup(st
 	}
 	ecryptfs_printk(KERN_DEBUG, "encoded_name = [%s]; encoded_namelen "
 			"= [%d]\n", encoded_name, encoded_namelen);
-	lower_dentry = lookup_one_len(encoded_name, lower_dir_dentry,
-				      encoded_namelen - 1);
+	dentry_save = nd->dentry;
+	mnt_save = nd->mnt;
+	lower_dentry = lookup_one_len_nd(encoded_name, lower_dir_dentry,
+					 (encoded_namelen - 1), nd);
 	kfree(encoded_name);
+	nd->mnt = mnt_save;
+	nd->dentry = dentry_save;
 	if (IS_ERR(lower_dentry)) {
 		ecryptfs_printk(KERN_ERR, "ERR from lower_dentry\n");
 		rc = PTR_ERR(lower_dentry);
-- 
1.4.2.4

