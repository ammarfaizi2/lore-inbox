Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWE3TJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWE3TJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWE3TJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:09:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:48776 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932423AbWE3TJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:09:06 -0400
Date: Tue, 30 May 2006 14:08:53 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix premature release of file_info memory in eCryptfs
Message-ID: <20060530190853.GC3098@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file_info struct is being released, and then one of its members is
referenced from the released memory. This patch cleans up the function
and moves the release so that it occurs after the reference.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

1e22635a873a0b0179a8b033e75234dd83a3bb9f
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c4ea9f0..b9cdb85 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -304,18 +304,15 @@ static int ecryptfs_flush(struct file *f
 	return rc;
 }
 
-static int ecryptfs_release(struct inode *ecryptfs_inode, struct file *file)
+static int ecryptfs_release(struct inode *inode, struct file *file)
 {
-	struct file *lower_file;
-	struct ecryptfs_file_info *file_info;
-	struct inode *lower_inode;
+	struct file *lower_file = ecryptfs_file_to_lower(file);
+	struct ecryptfs_file_info *file_info = ecryptfs_file_to_private(file);
+	struct inode *lower_inode = ecryptfs_inode_to_lower(inode);
 
-	file_info = ecryptfs_file_to_private(file);
-	kmem_cache_free(ecryptfs_file_info_cache, file_info);
-	lower_file = ecryptfs_file_to_lower(file);
 	fput(lower_file);
-	lower_inode = ecryptfs_inode_to_lower(ecryptfs_inode);
-	ecryptfs_inode->i_blocks = lower_inode->i_blocks;
+	inode->i_blocks = lower_inode->i_blocks;
+	kmem_cache_free(ecryptfs_file_info_cache, file_info);
 	return 0;
 }
 
-- 
1.3.3

