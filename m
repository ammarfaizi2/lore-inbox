Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVKGUnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVKGUnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKGUnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:43:24 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:14220 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932330AbVKGUnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:43:21 -0500
X-ORBL: [69.149.117.103]
Date: Mon, 7 Nov 2005 14:39:33 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: linux-kernel@vger.kernel.org
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH: eCryptfs] Encrypt on writepage()
Message-ID: <20051107203933.GA23873@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035530.GJ3005@sshock.rn.byu.edu> <20051103053258.GA32733@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103053258.GA32733@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 11:32:58PM -0600, Michael Halcrow wrote:
> On Wed, Nov 02, 2005 at 08:55:30PM -0700, Phillip Hellewell wrote:
> > +static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
> > +{
> > ...
> > +	ecryptfs_printk(1, KERN_NOTICE, "Copying page\n");
> > +	memcpy(lower_kaddr, kaddr, crypt_stats->extent_size);
> 
> This part will, of course, need to be replaced with the same crypto
> operations being done in ecryptfs_commit_write() in order to encrypt
> the data on its way out via ecryptfs_writepage().

This patch encrypts on the writepage() execution path. It also removes
the initialization vector read/rotate/write code into its own
function, which simplifies commit_write().

I also took the opportunity to remove an unused macro from the
header.

This applies on top of the 12 original patches sent out, plus the
de-debug patch in the message with the subject ``Re: [PATCH: eCryptfs]
Remove debug wrappers''.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Thompson <mcthomps@us.ibm.com>
Signed-off-by: Kent Yoder <yoder1@us.ibm.com>

 ecryptfs_kernel.h |    3 
 mmap.c            |  344 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 202 insertions(+), 145 deletions(-)
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/mmap.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/mmap.c	2005-11-03 16:12:46.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/mmap.c	2005-11-07 13:44:54.000000000 -0600
@@ -30,6 +30,8 @@
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/mount.h>
+#include <linux/file.h>
 #include <linux/crypto.h>
 #include <asm/scatterlist.h>
 #include "ecryptfs_kernel.h"
@@ -318,90 +320,224 @@
 }
 
 /**
- * @param page	Page that is locked before this call is made
+ * @param lower_file Can be NULL
+ * @return Zero on success
+ */
+static int 
+ecryptfs_read_rotate_write_iv(char *iv, struct inode *inode,
+			      int lower_iv_idx, struct file *lower_file, 
+			      struct page *page)
+{
+	int rc = 0;
+	pgoff_t records_page_index;
+	struct ecryptfs_crypt_stats *crypt_stats;
+	struct page *records_page;
+	char *records_virt;
+	int lower_file_needs_fput = 0;
+	struct address_space_operations *lower_a_ops;
+	struct inode *lower_inode;
+
+	crypt_stats = &(INODE_TO_PRIVATE(inode)->crypt_stats);
+	lower_inode = INODE_TO_LOWER(inode);
+ 	lower_a_ops = lower_inode->i_mapping->a_ops;
+	records_page_index = LAST_RECORDS_PAGE_IDX(crypt_stats, page->index);
+	ecryptfs_printk(1, KERN_NOTICE, "records_page_index = [%lu]\n",
+			records_page_index);
+	records_page = grab_cache_page(lower_inode->i_mapping,
+				       records_page_index);
+	if (!records_page) {
+                        ecryptfs_printk(0, KERN_ERR, "records_page == NULL "
+                                        "after grab_cache_page at index [%lu]"
+                                        "\n", records_page_index);
+                        rc = -EIO;
+                        goto out;
+	}
+	/* TODO: Assume encrypted only for version 0.1 */
+	ecryptfs_printk(1, KERN_NOTICE, "lower_iv_idx = [%d]\n", lower_iv_idx);
+	records_virt = kmap(records_page);
+	if (!records_virt) {
+		rc = -ENOMEM;
+		ecryptfs_printk(1, KERN_NOTICE, "Error in kmap\n");
+		goto out_unlock_and_release;
+	}
+	if (!lower_file) {
+		struct dentry *lower_dentry;
+		struct vfsmount *lower_mnt;
+
+		if (!lower_inode->i_dentry.next) {
+			rc = -EINVAL;
+			ecryptfs_printk(1, KERN_NOTICE, "No dentry for "
+					"lower_inode\n");
+			goto out_unmap;
+		}
+		lower_dentry = list_entry(lower_inode->i_dentry.next, 
+					  struct dentry, d_alias);
+		mntget(SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt);
+		lower_mnt = SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt;
+		lower_file = dentry_open(lower_dentry, lower_mnt, FMODE_READ);
+		if (IS_ERR(lower_file)) {
+			rc = PTR_ERR(lower_file);
+			ecryptfs_printk(0, KERN_ERR,
+					"Error opening dentry; rc = [%i]\n",
+					rc);
+			mntput(SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt);
+			goto out_unmap;
+		}
+		lower_file_needs_fput = 1;
+	}
+	rc = lower_a_ops->prepare_write(lower_file, records_page, lower_iv_idx,
+					(lower_iv_idx + crypt_stats->iv_bytes));
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error in lower prepare_write() "
+				"call: rc = [%d]\n", rc);
+		goto out_unmap;
+	}
+	down(&crypt_stats->iv_sem);
+	ecryptfs_rotate_iv(crypt_stats->iv);
+	memcpy(iv, crypt_stats->iv, crypt_stats->iv_bytes);
+	up(&crypt_stats->iv_sem);
+	memcpy(records_virt + lower_iv_idx, crypt_stats->iv,
+	       crypt_stats->iv_bytes);
+	rc = lower_a_ops->commit_write(lower_file, records_page, lower_iv_idx, 
+				       (lower_iv_idx + crypt_stats->iv_bytes));
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error in lower commit_write() "
+				"call: rc = [%d]\n", rc);
+		goto out_unmap;
+	}
+	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
+	ecryptfs_printk(1, KERN_NOTICE, "Unlocking page with index = "
+			"[%lu]\n", records_page->index);
+out_unmap:
+	kunmap(records_page);
+out_unlock_and_release:
+	unlock_page(records_page);
+	page_cache_release(records_page);
+	ecryptfs_printk(1, KERN_NOTICE, "After committing IV write, "
+			"lower_inode->i_blocks = [%lu]\n",
+			lower_inode->i_blocks);	
+out:
+	if (lower_file_needs_fput)
+		fput(lower_file);
+	return rc;
+}
+
+/**
+ * @return Zero on success; negative on error
+ */
+static int encrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
+			struct page *page, struct page *lower_page, char *iv)
+{
+	int rc = 0;
+	ecryptfs_printk(1, KERN_NOTICE, "Calling do_encrypt_page()\n");
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypting page with iv:\n");
+	if (unlikely(ecryptfs_verbosity > 0)) {
+		ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes before "
+			"encryption:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex((char *)page_address(page), 8);
+	}
+	rc = do_encrypt_page_offset(crypt_stats, lower_page, 0,
+				    page, 0, crypt_stats->extent_size, iv);
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypted [%d] bytes\n", rc);
+	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes after " "encryption:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex((char *)page_address(lower_page), 8);
+	}
+	if (rc > 0)
+		rc = 0;
+	return rc;
+}
+
+/**
+ * @param page Page that is locked before this call is made
  */
 static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	int err = -EIO;
+	int rc = -EIO;
+	int err = 0;
 	unsigned long lower_index;
 	struct inode *inode;
 	struct inode *lower_inode;
 	struct page *lower_page;
 	char *kaddr, *lower_kaddr;
 	struct ecryptfs_crypt_stats *crypt_stats;
+
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; page->index = [%ld]; "
 			"page->mapping->host = [%p]\n", page->index,
 			page->mapping->host);
-
-	/* Sanity checkers */
-	if (1) {
-		struct address_space *mapping = page->mapping;
-		loff_t offset = (loff_t) page->index << PAGE_CACHE_SHIFT;
-		if (wbc->sync_mode != WB_SYNC_NONE) {
-			ecryptfs_printk(1, KERN_NOTICE,
-					"wbc->sync_mode != WB_SYNC_NONE\n");
-		} else {
-			ecryptfs_printk(1, KERN_NOTICE,
-					"wbc->sync_mode == WB_SYNC_NONE\n");
-		}
-		/* racing with truncate? */
-		if (offset > mapping->host->i_size) {
-			ecryptfs_printk(1, KERN_NOTICE, "Racing truncate\n");
-		}
-		BUG_ON(PageWriteback(page));
-	}
-
-	/* End sanity */
-
 	inode = page->mapping->host;
 	crypt_stats = &(INODE_TO_PRIVATE(inode)->crypt_stats);
 	lower_inode = INODE_TO_LOWER(inode);
-	/* The 2nd argument here should be the index of the lower file, which
-	 * should be the calculated result of our index interpolation */
 	lower_index = PG_IDX_TO_LWR_PG_IDX(crypt_stats, page->index);
 	ecryptfs_printk(1, KERN_NOTICE, "Grab lower_idx = [%ld]\n",
 			lower_index);
 	lower_page = grab_cache_page(lower_inode->i_mapping, lower_index);
 	if (!lower_page) {
-		err = -ENOMEM;
+		rc = -ENOMEM;
 		goto out;
 	}
-	if (PageWriteback(lower_page)) {
-		ecryptfs_printk(1, KERN_NOTICE,
-				"lower_page is under writeback\n");
-	} else {
-		ecryptfs_printk(1, KERN_NOTICE,
-				"lower_page is avail for writeback\n");
-	}
-	if (!PageLocked(page)) {
-		ecryptfs_printk(1, KERN_NOTICE, "Page not locked\n");
-	} else {
-		ecryptfs_printk(1, KERN_NOTICE, "Page is already locked\n");
-	}
 	kaddr = (char *)kmap(page);
+	if (!kaddr) {
+		rc = -ENOMEM;
+		goto out;
+	}
 	lower_kaddr = (char *)kmap(lower_page);
-	ecryptfs_printk(1, KERN_NOTICE, "Copying page\n");
-	memcpy(lower_kaddr, kaddr, crypt_stats->extent_size);
+	if (!lower_kaddr) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	if (crypt_stats->encrypted) {
+		char iv[ECRYPTFS_MAX_IV_BYTES];
+		int record_byte_offset;
+		/* TODO: HMAC: Include HMAC bytes in the record size */
+		record_byte_offset = (RECORD_IDX(crypt_stats, page->index)
+				      * crypt_stats->iv_bytes);
+		rc = ecryptfs_read_rotate_write_iv(iv, inode,
+						   record_byte_offset, NULL,
+						   page);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR, "Error rotating "
+					"IV; write failure. Assuming "
+					"IV page corruption; writing "
+					"0's to associated data extent"
+					".\n");
+			memset(lower_kaddr, 0, crypt_stats->extent_size);
+			err = -EIO;
+			goto do_lower_write;
+		}
+		ecryptfs_printk(1, KERN_NOTICE, "Encrypting page with iv:\n");
+		if (unlikely(ecryptfs_verbosity > 0))
+			ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
+		err = encrypt_page(crypt_stats, page, lower_page, iv);
+		if (err)
+			ecryptfs_printk(0, KERN_WARNING, "Error encrypting "
+					"page (upper index [%llu])\n", 
+					page->index);
+	} else
+		memcpy(lower_kaddr, kaddr, crypt_stats->extent_size);
+do_lower_write:
 	kunmap(page);
 	kunmap(lower_page);
-	if (PageWriteback(lower_page)) {
-		ecryptfs_printk(1, KERN_NOTICE,
-				"lower_page is under writeback\n");
-	} else {
-		ecryptfs_printk(1, KERN_NOTICE,
-				"lower_page is avail for writeback\n");
+	rc = lower_inode->i_mapping->a_ops->writepage(lower_page, wbc);
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error calling lower writepage(); "
+				"rc = [%d]\n", rc);
 	}
-	err = lower_inode->i_mapping->a_ops->writepage(lower_page, wbc);
 	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
 	page_cache_release(lower_page);
-	if (err)
+	if (rc)
 		ClearPageUptodate(page);
 	else
 		SetPageUptodate(page);
 	unlock_page(page);
 out:
-	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
-	return err;
+	if (err)
+		rc = err;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
 }
 
 /**
@@ -574,7 +710,6 @@
 	int record_byte_offset;
 	int iv_byte_offset;
 	int i;
-	int record_size;
 	pgoff_t records_page_index;
 	pgoff_t lower_page_index;
 
@@ -590,7 +725,6 @@
 		rc = ecryptfs_do_readpage(file, page, page->index);
 		goto out;
 	}
-	record_size = crypt_stats->iv_bytes;
 	/* The file is encrypted, hmac verified, or both. */
 	ecryptfs_printk(1, KERN_NOTICE,
 			"crypt_stats->iv_bytes = [%d]\n",
@@ -617,8 +751,9 @@
 		ClearPageUptodate(page);
 		goto out;
 	}
-
-	record_byte_offset = RECORD_IDX(crypt_stats, page->index) * record_size;
+	/* TODO: HMAC: Include HMAC bytes in the record size */
+	record_byte_offset = (RECORD_IDX(crypt_stats, page->index) 
+			      * crypt_stats->iv_bytes);
 	iv_byte_offset = -1;
 	if (crypt_stats->encrypted) {
 		iv_byte_offset = record_byte_offset;
@@ -721,37 +856,6 @@
 }
 
 /**
- * @return Zero on success; negative on error
- */
-static int encrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
-			struct page *page, struct page *lower_page, char *iv)
-{
-	int rc = 0;
-	ecryptfs_printk(1, KERN_NOTICE, "Calling do_encrypt_page()\n");
-	if (iv) {
-		ecryptfs_printk(1, KERN_NOTICE, "Encrypting page with iv:\n");
-		if (ecryptfs_verbosity > 0) {
-			ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
-		}
-	}
-	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes before "
-			"encryption:\n");
-	if (ecryptfs_verbosity > 0) {
-		ecryptfs_dump_hex((char *)page_address(page), 8);
-	}
-	rc = do_encrypt_page_offset(crypt_stats, lower_page, 0,
-				    page, 0, crypt_stats->extent_size, iv);
-	ecryptfs_printk(1, KERN_NOTICE, "Encrypted [%d] bytes\n", rc);
-	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes after " "encryption:\n");
-	if (ecryptfs_verbosity > 0) {
-		ecryptfs_dump_hex((char *)page_address(lower_page), 8);
-	}
-	if (rc > 0)
-		rc = 0;
-	return rc;
-}
-
-/**
  * This is where we encrypt the data and pass the encrypted data to
  * the lower filesystem.  In OpenPGP-compatible mode, we operate on
  * entire underlying packets.
@@ -774,9 +878,9 @@
 	unsigned bytes = to - from;
 	struct ecryptfs_crypt_stats *crypt_stats;
 	pgoff_t lower_page_index;
-	struct page *records_page;
 	struct address_space_operations *lower_a_ops;
 	struct dentry *ecryptfs_dentry;
+
 	ecryptfs_printk(1, KERN_NOTICE,
 			"Enter; page->index = [%lu]; from = [%d]; to = [%d]\n",
 			page->index, from, to);
@@ -875,73 +979,29 @@
 		       (char *)page_address(page), crypt_stats->extent_size);
 	} else {
 		/* The file is either encrypted or HMAC'd */
-		pgoff_t records_page_index;
-		int record_byte_offset = -1;
-		int iv_byte_offset = -1;
-		char *records_virt;
 		char iv[ECRYPTFS_MAX_IV_BYTES];
-		int record_size;
+		int record_byte_offset;
 		ecryptfs_printk(1, KERN_NOTICE,
 				"crypt_stats->iv_bytes = [%d]\n",
 				crypt_stats->iv_bytes);
-		ecryptfs_printk(1, KERN_NOTICE,
-				"crypt_stats->records_per_page = [%d]\n",
-				crypt_stats->records_per_page);
-		record_size = crypt_stats->iv_bytes;
-		records_page_index =
-			LAST_RECORDS_PAGE_IDX(crypt_stats, page->index);
-		ecryptfs_printk(1, KERN_NOTICE, "records_page_index = [%lu]\n",
-				records_page_index);
-		records_page = grab_cache_page(lower_inode->i_mapping,
-					       records_page_index);
-		if (!records_page) {
-			ecryptfs_printk(0, KERN_ERR, "records_page == NULL "
-					"after grab_cache_page at index [%lu]"
-					"\n", records_page_index);
-			rc = -EIO;
+		/* TODO: HMAC: Include HMAC bytes in the record size */	
+		record_byte_offset = (RECORD_IDX(crypt_stats, page->index) 
+				      * crypt_stats->iv_bytes);
+		rc = ecryptfs_read_rotate_write_iv(iv, inode, 
+						   record_byte_offset, 
+						   lower_file, page);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR, "Error rotating IV\n");
 			goto out_unlock_lower;
 		}
-		iv_byte_offset = -1;
-		record_byte_offset =
-		    RECORD_IDX(crypt_stats, page->index) * record_size;
-		if (crypt_stats->encrypted) {
-			iv_byte_offset = record_byte_offset;
-		}
-		ecryptfs_printk(1, KERN_NOTICE, "iv_byte_offset = [%d]\n",
-				iv_byte_offset);
-		records_virt = kmap(records_page);
-		rc = lower_a_ops->prepare_write(lower_file, records_page,
-						iv_byte_offset,
-						iv_byte_offset
-						+ crypt_stats->iv_bytes);
-		down(&crypt_stats->iv_sem);
-		ecryptfs_rotate_iv(crypt_stats->iv);
-		memcpy(iv, crypt_stats->iv, crypt_stats->iv_bytes);
-		up(&crypt_stats->iv_sem);
-		memcpy(records_virt + iv_byte_offset, crypt_stats->iv,
-		       crypt_stats->iv_bytes);
-		rc = lower_a_ops->commit_write(lower_file, records_page,
-					       iv_byte_offset,
-					       iv_byte_offset +
-					       crypt_stats->iv_bytes);
-		kunmap(records_page);
-		lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty_sync(inode);
-		ecryptfs_printk(1, KERN_NOTICE, "Unlocking page with index = "
-				"[%lu]\n", records_page->index);
-		unlock_page(records_page);
-		page_cache_release(records_page);
-		ecryptfs_printk(1, KERN_NOTICE, "After committing IV write, "
-				"lower_inode->i_blocks = [%lu]\n",
-				lower_inode->i_blocks);
 		ecryptfs_printk(1, KERN_NOTICE, "Encrypting page with iv:\n");
-		if (ecryptfs_verbosity > 0) {
+		if (unlikely(ecryptfs_verbosity > 0))
 			ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
-		}
 		rc = encrypt_page(crypt_stats, page, lower_page, iv);
 		if (rc) {
 			ecryptfs_printk(0, KERN_WARNING, "Error encrypting "
-					"page\n");
+					"page (upper index [%llu])\n", 
+					page->index);
 			goto out;
 		}
 	}
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/ecryptfs_kernel.h	2005-11-03 15:36:39.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2005-11-07 13:37:31.000000000 -0600
@@ -173,9 +173,6 @@
         ((idx / crypt_stats->records_per_page) + idx \
          + crypt_stats->num_header_pages + 1)
 #define RECORD_IDX(crypt_stats, idx) (idx % crypt_stats->records_per_page)
-#define RECORD_OFFSET(crypt_stats, idx) \
-        (RECORD_IDX(crypt_stats, idx) * (crypt_stats->iv_bytes \
-                                         + crypt_stats->hmac_bytes))
 #define LAST_RECORDS_PAGE_IDX(crypt_stats, idx) \
         (PG_IDX_TO_LWR_PG_IDX(crypt_stats, idx) \
          - RECORD_IDX(crypt_stats,idx) - 1)
