Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWEZOWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWEZOWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWEZOWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36524 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750800AbWEZOWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:22:04 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 9/10] Rewrite ecryptfs_fsync()
Message-Id: <E1FjdCG-00033q-PJ@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite ecryptfs_fsync() to be more concise. Note that i_fop is always
valid.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

fb9079aa454161fdbdc53021b987eec7513fec06
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 3a9cd15..c984ea6 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -322,29 +322,16 @@ static int ecryptfs_release(struct inode
 static int
 ecryptfs_fsync(struct file *file, struct dentry *dentry, int datasync)
 {
+	struct file *lower_file = ecryptfs_file_to_lower(file);
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	struct inode *lower_inode = lower_dentry->d_inode;
 	int rc = -EINVAL;
-	struct file *lower_file = NULL;
-	struct dentry *lower_dentry;
 
-	if (!file) {
-		lower_dentry = ecryptfs_dentry_to_lower(dentry);
-		if (lower_dentry->d_inode->i_fop
-		    && lower_dentry->d_inode->i_fop->fsync) {
-			mutex_lock(&lower_dentry->d_inode->i_mutex);
-			rc = lower_dentry->d_inode->i_fop->fsync(lower_file,
-								 lower_dentry,
-								 datasync);
-			mutex_unlock(&lower_dentry->d_inode->i_mutex);
-		}
-	} else {
-		lower_file = ecryptfs_file_to_lower(file);
-		lower_dentry = ecryptfs_dentry_to_lower(dentry);
-		if (lower_file->f_op && lower_file->f_op->fsync) {
-			mutex_lock(&lower_dentry->d_inode->i_mutex);
-			rc = lower_file->f_op->fsync(lower_file, lower_dentry,
-						     datasync);
-			mutex_unlock(&lower_dentry->d_inode->i_mutex);
-		}
+	if (lower_inode->i_fop->fsync) {
+		mutex_lock(&lower_inode->i_mutex);
+		rc = lower_inode->i_fop->fsync(lower_file, lower_dentry,
+					       datasync);
+		mutex_unlock(&lower_inode->i_mutex);
 	}
 	return rc;
 }
-- 
1.3.3

