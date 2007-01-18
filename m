Return-Path: <linux-kernel-owner+w=401wt.eu-S1751528AbXARV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXARV13 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXARV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:27:29 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:59407 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbXARV11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:27:27 -0500
Date: Thu, 18 Jan 2007 15:27:25 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] eCryptfs: convert kmap() to kmap_atomic()
Message-ID: <20070118212725.GD3643@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070118212627.GC3643@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118212627.GC3643@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 02:42:03PM -0800, Andrew Morton wrote:
> On Tue, 9 Jan 2007 16:23:37 -0600
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
>
> > +                           page_virt = (char *)kmap(page);
>
> Do we _have_ to use kmap here?  It's slow and theoretically
> deadlocky.  kmap_atomic() is much preferred.
>
> Can the other kmap() calls in ecryptfs be converted?

Replace kmap() with kmap_atomic(). Reduce the number of kmaps and the
amount of time that kmaps are held.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Trevor Highland <tshighla@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |    8 +--
 fs/ecryptfs/ecryptfs_kernel.h |    4 -
 fs/ecryptfs/mmap.c            |  121 ++++++++++++-----------------------------
 3 files changed, 39 insertions(+), 94 deletions(-)

fd04da707b2164272acc05a56ff4b71786aad011
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index fbb62c8..ac4ea8d 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -429,10 +429,10 @@ static int ecryptfs_read_in_page(struct 
 			goto out;
 		}
 	} else {
-		rc = ecryptfs_grab_and_map_lower_page(lower_page, NULL,
-						      lower_inode,
-						      lower_page_idx);
-		if (rc) {
+		*lower_page = grab_cache_page(lower_inode->i_mapping,
+					      lower_page_idx);
+		if (!(*lower_page)) {
+			rc = -EINVAL;
 			ecryptfs_printk(
 				KERN_ERR, "Error attempting to grab and map "
 				"lower page with index [0x%.16x]; rc = [%d]\n",
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 859d31b..0e38d0d 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -527,10 +527,6 @@ int ecryptfs_copy_page_to_lower(struct p
 				struct file *lower_file);
 int ecryptfs_do_readpage(struct file *file, struct page *page,
 			 pgoff_t lower_page_index);
-int ecryptfs_grab_and_map_lower_page(struct page **lower_page,
-				     char **lower_virt,
-				     struct inode *lower_inode,
-				     unsigned long lower_page_index);
 int ecryptfs_writepage_and_release_lower_page(struct page *lower_page,
 					      struct inode *lower_inode,
 					      struct writeback_control *wbc);
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 94bcabf..6f167f1 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -234,22 +234,11 @@ int ecryptfs_do_readpage(struct file *fi
 		goto out;
 	}
 	wait_on_page_locked(lower_page);
-	page_data = (char *)kmap(page);
-	if (!page_data) {
-		rc = -ENOMEM;
-		ecryptfs_printk(KERN_ERR, "Error mapping page\n");
-		goto out;
-	}
-	lower_page_data = (char *)kmap(lower_page);
-	if (!lower_page_data) {
-		rc = -ENOMEM;
-		ecryptfs_printk(KERN_ERR, "Error mapping page\n");
-		kunmap(page);
-		goto out;
-	}
+	page_data = (char *)kmap_atomic(page, KM_USER0);
+	lower_page_data = (char *)kmap_atomic(lower_page, KM_USER1);
 	memcpy(page_data, lower_page_data, PAGE_CACHE_SIZE);
-	kunmap(lower_page);
-	kunmap(page);
+	kunmap_atomic(lower_page_data, KM_USER1);
+	kunmap_atomic(page_data, KM_USER0);
 	rc = 0;
 out:
 	if (likely(lower_page))
@@ -325,19 +314,14 @@ static int ecryptfs_readpage(struct file
 			if (page->index < num_pages_in_header_region) {
 				char *page_virt;
 
-				page_virt = (char *)kmap(page);
-				if (!page_virt) {
-					rc = -ENOMEM;
-					printk(KERN_ERR "Error mapping page\n");
-					goto out;
-				}
+				page_virt = (char *)kmap_atomic(page, KM_USER0);
 				memset(page_virt, 0, PAGE_CACHE_SIZE);
 				if (page->index == 0) {
 					rc = ecryptfs_read_xattr_region(
 						page_virt, file->f_path.dentry);
 					set_header_info(page_virt, crypt_stat);
 				}
-				kunmap(page);
+				kunmap_atomic(page_virt, KM_USER0);
 				if (rc) {
 					printk(KERN_ERR "Error reading xattr "
 					       "region\n");
@@ -387,26 +371,19 @@ static int fill_zeros_to_end_of_page(str
 {
 	struct inode *inode = page->mapping->host;
 	int end_byte_in_page;
-	int rc = 0;
 	char *page_virt;
 
-	if ((i_size_read(inode) / PAGE_CACHE_SIZE) == page->index) {
-		end_byte_in_page = i_size_read(inode) % PAGE_CACHE_SIZE;
-		if (to > end_byte_in_page)
-			end_byte_in_page = to;
-		page_virt = kmap(page);
-		if (!page_virt) {
-			rc = -ENOMEM;
-			ecryptfs_printk(KERN_WARNING,
-					"Could not map page\n");
-			goto out;
-		}
-		memset((page_virt + end_byte_in_page), 0,
-		       (PAGE_CACHE_SIZE - end_byte_in_page));
-		kunmap(page);
-	}
+	if ((i_size_read(inode) / PAGE_CACHE_SIZE) != page->index)
+		goto out;
+	end_byte_in_page = i_size_read(inode) % PAGE_CACHE_SIZE;
+	if (to > end_byte_in_page)
+		end_byte_in_page = to;
+	page_virt = kmap_atomic(page, KM_USER0);
+	memset((page_virt + end_byte_in_page), 0,
+	       (PAGE_CACHE_SIZE - end_byte_in_page));
+	kunmap_atomic(page_virt, KM_USER0);
 out:
-	return rc;
+	return 0;
 }
 
 static int ecryptfs_prepare_write(struct file *file, struct page *page,
@@ -414,7 +391,6 @@ static int ecryptfs_prepare_write(struct
 {
 	int rc = 0;
 
-	kmap(page);
 	if (from == 0 && to == PAGE_CACHE_SIZE)
 		goto out;	/* If we are writing a full page, it will be
 				   up to date. */
@@ -424,30 +400,6 @@ out:
 	return rc;
 }
 
-int ecryptfs_grab_and_map_lower_page(struct page **lower_page,
-				     char **lower_virt,
-				     struct inode *lower_inode,
-				     unsigned long lower_page_index)
-{
-	int rc = 0;
-
-	(*lower_page) = grab_cache_page(lower_inode->i_mapping,
-					lower_page_index);
-	if (!(*lower_page)) {
-		ecryptfs_printk(KERN_ERR, "grab_cache_page for "
-				"lower_page_index = [0x%.16x] failed\n",
-				lower_page_index);
-		rc = -EINVAL;
-		goto out;
-	}
-	if (lower_virt)
-		(*lower_virt) = kmap((*lower_page));
-	else
-		kmap((*lower_page));
-out:
-	return rc;
-}
-
 int ecryptfs_writepage_and_release_lower_page(struct page *lower_page,
 					      struct inode *lower_inode,
 					      struct writeback_control *wbc)
@@ -466,11 +418,8 @@ out:
 	return rc;
 }
 
-static void ecryptfs_unmap_and_release_lower_page(struct page *lower_page)
+static void ecryptfs_release_lower_page(struct page *lower_page)
 {
-	kunmap(lower_page);
-	ecryptfs_printk(KERN_DEBUG, "Unlocking lower page with index = "
-			"[0x%.16x]\n", lower_page->index);
 	unlock_page(lower_page);
 	page_cache_release(lower_page);
 }
@@ -492,11 +441,11 @@ static int ecryptfs_write_inode_size_to_
 	const struct address_space_operations *lower_a_ops;
 	u64 file_size;
 
-	rc = ecryptfs_grab_and_map_lower_page(&header_page, &header_virt,
-					      lower_inode, 0);
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "grab_cache_page for header page "
-				"failed\n");
+	header_page = grab_cache_page(lower_inode->i_mapping, 0);
+	if (!header_page) {
+		ecryptfs_printk(KERN_ERR, "grab_cache_page for "
+				"lower_page_index 0 failed\n");
+		rc = -EINVAL;
 		goto out;
 	}
 	lower_a_ops = lower_inode->i_mapping->a_ops;
@@ -504,12 +453,14 @@ static int ecryptfs_write_inode_size_to_
 	file_size = (u64)i_size_read(inode);
 	ecryptfs_printk(KERN_DEBUG, "Writing size: [0x%.16x]\n", file_size);
 	file_size = cpu_to_be64(file_size);
+	header_virt = kmap_atomic(header_page, KM_USER0);
 	memcpy(header_virt, &file_size, sizeof(u64));
+	kunmap_atomic(header_virt, KM_USER0);
 	rc = lower_a_ops->commit_write(lower_file, header_page, 0, 8);
 	if (rc < 0)
 		ecryptfs_printk(KERN_ERR, "Error commiting header page "
 				"write\n");
-	ecryptfs_unmap_and_release_lower_page(header_page);
+	ecryptfs_release_lower_page(header_page);
 	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
 out:
@@ -597,10 +548,10 @@ int ecryptfs_get_lower_page(struct page 
 {
 	int rc = 0;
 
-	rc = ecryptfs_grab_and_map_lower_page(lower_page, NULL, lower_inode,
-					      lower_page_index);
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error attempting to grab and map "
+	*lower_page = grab_cache_page(lower_inode->i_mapping, lower_page_index);
+	if (!(*lower_page)) {
+		rc = -EINVAL;
+		ecryptfs_printk(KERN_ERR, "Error attempting to grab "
 				"lower page with index [0x%.16x]\n",
 				lower_page_index);
 		goto out;
@@ -616,7 +567,7 @@ int ecryptfs_get_lower_page(struct page 
 	}
 out:
 	if (rc && (*lower_page)) {
-		ecryptfs_unmap_and_release_lower_page(*lower_page);
+		ecryptfs_release_lower_page(*lower_page);
 		(*lower_page) = NULL;
 	}
 	return rc;
@@ -641,7 +592,7 @@ ecryptfs_commit_lower_page(struct page *
 				"Error committing write; rc = [%d]\n", rc);
 	} else
 		rc = 0;
-	ecryptfs_unmap_and_release_lower_page(lower_page);
+	ecryptfs_release_lower_page(lower_page);
 	return rc;
 }
 
@@ -747,7 +698,6 @@ static int ecryptfs_commit_write(struct 
 	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
 out:
-	kunmap(page); /* mapped in prior call (prepare_write) */
 	if (rc < 0)
 		ClearPageUptodate(page);
 	else
@@ -772,6 +722,7 @@ int write_zeros(struct file *file, pgoff
 {
 	int rc = 0;
 	struct page *tmp_page;
+	char *tmp_page_virt;
 
 	tmp_page = ecryptfs_get1page(file, index);
 	if (IS_ERR(tmp_page)) {
@@ -780,28 +731,26 @@ int write_zeros(struct file *file, pgoff
 		rc = PTR_ERR(tmp_page);
 		goto out;
 	}
-	kmap(tmp_page);
 	rc = ecryptfs_prepare_write(file, tmp_page, start, start + num_zeros);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error preparing to write zero's "
 				"to remainder of page at index [0x%.16x]\n",
 				index);
-		kunmap(tmp_page);
 		page_cache_release(tmp_page);
 		goto out;
 	}
-	memset(((char *)page_address(tmp_page) + start), 0, num_zeros);
+	tmp_page_virt = kmap_atomic(tmp_page, KM_USER0);
+	memset(((char *)tmp_page_virt + start), 0, num_zeros);
+	kunmap_atomic(tmp_page_virt, KM_USER0);
 	rc = ecryptfs_commit_write(file, tmp_page, start, start + num_zeros);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR, "Error attempting to write zero's "
 				"to remainder of page at index [0x%.16x]\n",
 				index);
-		kunmap(tmp_page);
 		page_cache_release(tmp_page);
 		goto out;
 	}
 	rc = 0;
-	kunmap(tmp_page);
 	page_cache_release(tmp_page);
 out:
 	return rc;
-- 
1.3.3

