Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWIYUtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWIYUtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIYUtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:49:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:10660 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751163AbWIYUtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:49:16 -0400
Date: Mon, 25 Sep 2006 15:48:47 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eCryptfs: readdir fix for seeking in directory streams
Message-ID: <20060925204846.GA3356@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lower file's f_pos needs to be set to the f_pos of the eCryptfs
file passed into readdir() in order to correctly handle seeks on
directory streams.

This patch also properly initializes the file_info struct to all
0's. This initialization is not strictly necessary for the code as it
is currently in the kernel, but without this patch, nasty bugs can
show up when anyone makes changes to the file_info struct (one such
future change may include a pointer to persistent directory read state
info).

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

1824c175c78c15138a900aa4e05fd29af21d4de1
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 53dd53d..1cc2cc0 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -144,7 +144,6 @@ ecryptfs_filldir(void *dirent, const cha
 	int decoded_length;
 	char *decoded_name;
 
-
 	crypt_stat = ecryptfs_dentry_to_private(buf->dentry)->crypt_stat;
 	buf->filldir_called++;
 	decoded_length = ecryptfs_decode_filename(crypt_stat, name, namelen,
@@ -176,6 +175,7 @@ static int ecryptfs_readdir(struct file 
 	struct ecryptfs_getdents_callback buf;
 
 	lower_file = ecryptfs_file_to_lower(file);
+	lower_file->f_pos = file->f_pos;
 	inode = file->f_dentry->d_inode;
 	memset(&buf, 0, sizeof(buf));
 	buf.dirent = dirent;
@@ -218,18 +218,19 @@ static int ecryptfs_open(struct inode *i
 	struct inode *lower_inode = NULL;
 	struct file *lower_file = NULL;
 	struct vfsmount *lower_mnt;
+	struct ecryptfs_file_info *file_info;
 	int lower_flags;
 
 	/* Released in ecryptfs_release or end of function if failure */
-	ecryptfs_set_file_private(file,
-				  kmem_cache_alloc(ecryptfs_file_info_cache,
-						   SLAB_KERNEL));
-	if (!ecryptfs_file_to_private(file)) {
+	file_info = kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
+	ecryptfs_set_file_private(file, file_info);
+	if (!file_info) {
 		ecryptfs_printk(KERN_ERR,
 				"Error attempting to allocate memory\n");
 		rc = -ENOMEM;
 		goto out;
 	}
+	memset(file_info, 0, sizeof(*file_info));
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	mutex_lock(&crypt_stat->cs_mutex);
-- 
1.3.3

