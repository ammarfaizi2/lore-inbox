Return-Path: <linux-kernel-owner+w=401wt.eu-S1751453AbXARV0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXARV0b (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXARV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:26:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46405 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXARV0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:26:30 -0500
Date: Thu, 18 Jan 2007 15:26:27 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mike Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH 1/5] eCryptfs: convert f_op->write() to vfs_write()
Message-ID: <20070118212627.GC3643@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 9 Jan 2007 16:22:55 -0600
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
>
> > + lower_file->f_op->write(lower_file, (char __user *)page_virt,
> > + PAGE_CACHE_SIZE, &lower_file->f_pos);
>
> hm.  sys_write() takes a local copy of f_pos and writes that back
> into the struct file.It does this so that two concurrent write()
> callers don't make a mess of f_pos, and of the file contents.
>
> Perhaps ecryptfs should be calling vfs_write()?
>
> That way we'd also get the fsnotify notifications, which ecryptfs
> presently appears to have subverted.

Convert direct calls to f_op->write() into calls to vfs_write().

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |   27 ++++++++++++++++++++++-----
 fs/ecryptfs/inode.c  |    2 +-
 2 files changed, 23 insertions(+), 6 deletions(-)

b91d05b02335e38e18ffb87de6127b80bfe66dd7
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 8fbc38c..fbb62c8 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1346,24 +1346,41 @@ int ecryptfs_write_metadata_to_contents(
 	mm_segment_t oldfs;
 	int current_header_page;
 	int header_pages;
+	ssize_t size;
+	int rc = 0;
 
 	lower_file->f_pos = 0;
 	oldfs = get_fs();
 	set_fs(get_ds());
-	lower_file->f_op->write(lower_file, (char __user *)page_virt,
-				PAGE_CACHE_SIZE, &lower_file->f_pos);
+	size = vfs_write(lower_file, (char __user *)page_virt, PAGE_CACHE_SIZE,
+			 &lower_file->f_pos);
+	if (size < 0) {
+		rc = (int)size;
+		printk(KERN_ERR "Error attempting to write lower page; "
+		       "rc = [%d]\n", rc);
+		set_fs(oldfs);
+		goto out;
+	}
 	header_pages = ((crypt_stat->header_extent_size
 			 * crypt_stat->num_header_extents_at_front)
 			/ PAGE_CACHE_SIZE);
 	memset(page_virt, 0, PAGE_CACHE_SIZE);
 	current_header_page = 1;
 	while (current_header_page < header_pages) {
-		lower_file->f_op->write(lower_file, (char __user *)page_virt,
-					PAGE_CACHE_SIZE, &lower_file->f_pos);
+		size = vfs_write(lower_file, (char __user *)page_virt,
+				 PAGE_CACHE_SIZE, &lower_file->f_pos);
+		if (size < 0) {
+			rc = (int)size;
+			printk(KERN_ERR "Error attempting to write lower page; "
+			       "rc = [%d]\n", rc);
+			set_fs(oldfs);
+			goto out;
+		}
 		current_header_page++;
 	}
 	set_fs(oldfs);
-	return 0;
+out:
+	return rc;
 }
 
 int ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index bbc1b4f..7d33917 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -201,7 +201,7 @@ static int ecryptfs_initialize_file(stru
 			lower_dentry->d_name.name);
 	inode = ecryptfs_dentry->d_inode;
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
-	lower_flags = ((O_CREAT | O_WRONLY | O_TRUNC) & O_ACCMODE) | O_RDWR;
+	lower_flags = ((O_CREAT | O_TRUNC) & O_ACCMODE) | O_RDWR;
 #if BITS_PER_LONG != 32
 	lower_flags |= O_LARGEFILE;
 #endif
-- 
1.3.3

