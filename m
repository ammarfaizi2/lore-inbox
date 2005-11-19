Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVKSEWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVKSEWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKSEWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:22:35 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:24054
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751345AbVKSEWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:22:33 -0500
Date: Fri, 18 Nov 2005 21:22:29 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 10/12: eCryptfs] Mmap operations
Message-ID: <20051119042229.GJ15747@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs mmap operations. The bulk encryption and decryption takes
place here.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Michael Thompson <mcthomps@us.ibm.com>

---

 mmap.c | 1153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1153 insertions(+)
--- linux-2.6.15-rc1-mm1/fs/ecryptfs/mmap.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/fs/ecryptfs/mmap.c	2005-11-18 11:20:09.000000000 -0600
@@ -0,0 +1,1153 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ * This is where eCryptfs handles the bulk encryption and decryption,
+ * with upper-lower file index interpolations.
+ *
+ * Copyright (c) 1997-2003 Erez Zadok
+ * Copyright (c) 2001-2003 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
+#include <linux/page-flags.h>
+#include <linux/mount.h>
+#include <linux/file.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#include "ecryptfs_kernel.h"
+
+static int ecryptfs_commit_write(struct file *file, struct page *page,
+				 unsigned from, unsigned to);
+static int ecryptfs_prepare_write(struct file *file, struct page *page,
+				  unsigned from, unsigned to);
+
+kmem_cache_t *ecryptfs_lower_page_cache;
+
+static inline pgoff_t
+record_idx(struct ecryptfs_crypt_stats *crypt_stats, pgoff_t idx)
+{
+	return (idx % crypt_stats->records_per_page);
+}
+
+static inline pgoff_t
+last_records_page_idx(struct ecryptfs_crypt_stats *crypt_stats, pgoff_t idx)
+{
+	pgoff_t lower_data_idx;
+	pgoff_t lower_record_idx;
+
+	lower_data_idx = ecryptfs_pg_idx_to_lwr_pg_idx(crypt_stats, idx);
+	lower_record_idx = record_idx(crypt_stats, idx);
+	return (lower_data_idx - lower_record_idx - 1);
+}
+
+/**
+ * Get one page from cache or lower f/s, return error otherwise.
+ *
+ * @return Unlocked and up-to-date page (if ok), with increased
+ *         refcnt.
+ */
+static struct page *ecryptfs_get1page(struct file *file, int index)
+{
+	struct page *page;
+	struct dentry *dentry;
+	struct inode *inode;
+	struct address_space *mapping;
+	int rc;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	dentry = file->f_dentry;
+	inode = dentry->d_inode;
+	mapping = inode->i_mapping;
+	if (index < 0) {
+		ecryptfs_printk(1, KERN_ERR, "BUG: index=%d\n", index);
+		page = ERR_PTR(-EIO);
+		goto out;
+	}
+	page = read_cache_page(mapping, index,
+			       (filler_t *) mapping->a_ops->readpage,
+			       (void *)file);
+	if (IS_ERR(page))
+		goto out;
+	wait_on_page_locked(page);
+	if (!PageUptodate(page)) {
+		lock_page(page);
+		rc = mapping->a_ops->readpage(file, page);
+		if (rc) {
+			page = ERR_PTR(rc);
+			goto out;
+		}
+		wait_on_page_locked(page);
+		if (!PageUptodate(page)) {
+			page = ERR_PTR(-EIO);
+			goto out;
+		}
+	}
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return page;
+}
+
+/**
+ * Write a specified number of zero's to a page.
+ * 
+ * N.B. (start + num_zeros) _must_ be less than or equal to PAGE_CACHE_SIZE
+ *
+ * @param file		The ecryptfs file
+ * @param index		The index in which we are writing
+ * @param start		The position after the last block of data
+ * @param num_zeros	The number of zeros to write
+ */
+static
+int write_zeros(struct file *file, pgoff_t index, int start, int num_zeros)
+{
+	int rc = 0;
+	struct page *tmp_page;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; index = [%lu], start offset = "
+			"[%d] num_zeros = [%d]\n", index, start, num_zeros);
+	tmp_page = ecryptfs_get1page(file, index);
+	if (IS_ERR(tmp_page)) {
+		ecryptfs_printk(0, KERN_ERR, "Error getting page at index "
+				"[%lu]\n", index);
+		rc = PTR_ERR(tmp_page);
+		goto out;
+	}
+	kmap(tmp_page);
+	memset(((char *)page_address(tmp_page) + start), 0, num_zeros);
+	rc = ecryptfs_prepare_write(file, tmp_page, start, start + num_zeros);
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error preparing to write zero's "
+				"to remainder of page at index [%lu]\n", index);
+		kunmap(tmp_page);
+		page_cache_release(tmp_page);
+		goto out;
+	}
+	rc = ecryptfs_commit_write(file, tmp_page, start, start + num_zeros);
+	if (rc < 0) {
+		ecryptfs_printk(0, KERN_ERR, "Error attempting to write zero's "
+				"to remainder of page at index [%lu]\n", index);
+		kunmap(tmp_page);
+		page_cache_release(tmp_page);
+		goto out;
+	}
+	rc = 0;
+	kunmap(tmp_page);
+	page_cache_release(tmp_page);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return rc;
+}
+
+/**
+ * Function for handling creation of holes when lseek-ing past the end
+ * of the file and then writing some data.
+ *
+ * N.B.
+ * This function does NOT support shrinking, only growing a file.
+ * The code _will_ BUG() if this requirement is not met.
+ * The new_length _myust_ be greater than the current length.
+ *
+ * @param file	     The ecryptfs file
+ * @param new_length The new length of the data in the underlying file;
+ * 		     everything between the prior end of the file and the new
+ * 		     end of the file will be filled with zero's.
+ * 		     N.B. new_length must be greater than current length
+ * @return	     Zero on success; non-zero otherwise 
+ */
+int ecryptfs_fill_zeros(struct file *file, loff_t new_length)
+{
+	int rc = 0;
+	struct dentry *dentry = file->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	pgoff_t old_end_page_index = 0;
+	pgoff_t index = old_end_page_index;
+	int old_end_pos_in_page = -1;
+	pgoff_t new_end_page_index;
+	int new_end_pos_in_page;
+	loff_t cur_length = i_size_read(inode);
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode->i_size = [%llu]; "
+			"new_length = [%llu]\n", cur_length, new_length);
+	/* Sanity check */
+	if (cur_length >= new_length) {
+		ecryptfs_printk(0, KERN_ERR, "Called with new_length less than "
+				"or equal to the current length, this is "
+				"against function restrictions!\n");
+		BUG();
+	}
+	/* N.B. Notes on index calculations
+	 * It is important to note that the size of the file will always be 1
+	 * greater than the last block of data's position added to the data's
+	 * index shifted by the page cache size.
+	 *      size = index * PAGE_CACHE_SIZE + pos + 1
+	 *
+	 * Example, a file with 1 block of data in the 0th index at the 0th
+	 * position will be a file of size 1. Likewise, a file of 100 blocks
+	 * of data will have it's last block in the 99th position.
+	 *
+	 * Therefore, a file of size page with PAGE_CACHE_SIZE blocks of data
+	 * will have its last block of data in the (PAGE_CACHE_SIZE-1)th 
+	 * position, in the 0th index. A file with (PAGE_CACHE_SIZE + 1) blocks
+	 * of data will have its last block of data in the 0th position of the
+	 * 1st index. This calculation can be shown as:
+	 *      position = (size - 1) & ~PAGE_CACHE_MASK 
+	 *      index    =  (size - 1) >> PAGE_CACHE_SHIFT
+	 * 
+	 * Example:
+	 * PAGE_CACHE_SHIFT = 12
+	 * PAGE_CACHE_SIZE = (1UL << PAGE_CACHE_SHIFT) [or 4096]
+	 * PAGE_CACHE_MASK = (~(PAGE_CACHE_SIZE-1)) [or ~(4096-1)]
+	 *
+	 * A size of 4095 yields:
+	 *      position = (4095 - 1) & ~PAGE_CACHE_MASK => 4094
+	 *      index    = (4095 - 1) >> 12              => 0
+	 *
+	 * A size of 4096 yields:
+	 *      position = (4096 - 1) & ~PAGE_CACHE_MASK => 4095
+	 *      index    = (4096 - 1) >> 12              => 0
+	 *
+	 * A size of 4097 yields:
+	 *      position = (4097 - 1) & ~PAGE_CACHE_MASK => 0
+	 *      index    = (4097 - 1) >> 12              => 1
+	 *      
+	 * From these examples, you can see that the logic that a
+	 * file's last block of data is at the (size - 1)th position
+	 * follows.
+	 *
+	 * A 0-length file is by this logic, undefined if positions
+	 * and indicies are required to be positive integers. However,
+	 * this is intuative, as a 0-length file has no data which to
+	 * give a position and index to.  However, to make our
+	 * calculations work, we will use the default value of -1 if
+	 * the size is 0. The following will apply:
+	 *      old size = 0
+	 *      old position = -1
+	 *      old index = 0
+	 *      new size = 1
+	 *      new position = 0
+	 *      new index = 0
+	 *
+	 *      write_zeros(file,0,(-1+1) => 0, ((size-1) - (-1)) => size)
+	 *
+	 * Therefore, if the current size of the file is 0, then
+	 * setting our index and position to -1 will result in valid
+	 * calculations for the new index and position for the new
+	 * size.
+	 */
+	if (cur_length != 0) {
+		index = old_end_page_index =
+		    ((cur_length - 1) >> PAGE_CACHE_SHIFT);
+		old_end_pos_in_page = ((cur_length - 1) & ~PAGE_CACHE_MASK);
+	}
+	new_end_page_index = ((new_length - 1) >> PAGE_CACHE_SHIFT);
+	new_end_pos_in_page = ((new_length - 1) & ~PAGE_CACHE_MASK);
+
+	ecryptfs_printk(1, KERN_NOTICE, "old_end_page_index = [%lu]; "
+			"old_end_pos_in_page = [%d]; "
+			"new_end_page_index = [%lu]; "
+			"new_end_pos_in_page = [%d]\n",
+			old_end_page_index, old_end_pos_in_page,
+			new_end_page_index, new_end_pos_in_page);
+	if (old_end_page_index == new_end_page_index) {
+		/* Start and end are in the same page; we just need to
+		 * set a portion of the existing page to zero's */
+		rc = write_zeros(file, index, (old_end_pos_in_page + 1),
+				 (new_end_pos_in_page - old_end_pos_in_page));
+		if (rc)
+			ecryptfs_printk(0, KERN_ERR, "write_zeros(file=[%p], "
+					"index=[%lu], old_end_pos_in_page=[d], "
+					"(PAGE_CACHE_SIZE - new_end_pos_in_page"
+					"=[%d]"
+					")=[d]) returned [%d]\n", file, index,
+					old_end_pos_in_page,
+					new_end_pos_in_page,
+					(PAGE_CACHE_SIZE - new_end_pos_in_page),
+					rc);
+		goto out;
+	}
+	/* Else, new position is outside of the current index.
+	 * Fill remainder of current page with zeros.
+	 * For each page after that page, will entire page with zeros.
+	 * Upon reaching new last page, write as many zeros as required
+	 * to fullfil the new size. */
+	/* Fill the remainder of the previous last page with zeros */
+	rc = write_zeros(file, index, (old_end_pos_in_page + 1),
+			 ((PAGE_CACHE_SIZE - 1) - old_end_pos_in_page));
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "write_zeros(file=[%p], "
+				"index=[%lu], old_end_pos_in_page=[d], "
+				"(PAGE_CACHE_SIZE - old_end_pos_in_page)=[d]) "
+				"returned [%d]\n", file, index,
+				old_end_pos_in_page,
+				(PAGE_CACHE_SIZE - old_end_pos_in_page), rc);
+		goto out;
+	}
+	index++;
+	while (index < new_end_page_index) {
+		/* Fill all intermediate pages with zeros */
+		rc = write_zeros(file, index, 0, PAGE_CACHE_SIZE);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR, "write_zeros(file=[%p], "
+					"index=[%lu], old_end_pos_in_page=[d], "
+					"(PAGE_CACHE_SIZE - new_end_pos_in_page"
+					"=[%d]"
+					")=[d]) returned [%d]\n", file, index,
+					old_end_pos_in_page,
+					new_end_pos_in_page,
+					(PAGE_CACHE_SIZE - new_end_pos_in_page),
+					rc);
+			goto out;
+		}
+		index++;
+	}
+	/* Fill the portion at the beginning of the last new page with
+	 * zero's */
+	rc = write_zeros(file, index, 0, (new_end_pos_in_page + 1));
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "write_zeros(file="
+				"[%p], index=[%lu], 0, "
+				"new_end_pos_in_page=[%d]"
+				"returned [%d]\n", file, index,
+				new_end_pos_in_page, rc);
+		goto out;
+	}
+out:
+	ecryptfs_printk((rc == 0 ? 1 : 0), KERN_NOTICE, "Exit; rc = [%d]\n",
+			rc);
+	return rc;
+}
+
+/**
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
+	crypt_stats = &(ECRYPTFS_INODE_TO_PRIVATE(inode)->crypt_stats);
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+ 	lower_a_ops = lower_inode->i_mapping->a_ops;
+	records_page_index = last_records_page_idx(crypt_stats, page->index);
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
+		mntget(ECRYPTFS_SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt);
+		lower_mnt =
+			ECRYPTFS_SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt;
+		lower_file = dentry_open(lower_dentry, lower_mnt, FMODE_READ);
+		if (IS_ERR(lower_file)) {
+			rc = PTR_ERR(lower_file);
+			ecryptfs_printk(0, KERN_ERR,
+					"Error opening dentry; rc = [%i]\n",
+					rc);
+			mntput(ECRYPTFS_SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt);
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
+
+	ecryptfs_printk(1, KERN_NOTICE, "Calling do_encrypt_page()\n");
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypting page with iv:\n");
+	if (unlikely(ecryptfs_verbosity > 0))
+		ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
+	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes before "
+			"encryption:\n");
+	if (ecryptfs_verbosity > 0)
+		ecryptfs_dump_hex((char *)page_address(page), 8);
+	rc = do_encrypt_page_offset(crypt_stats, lower_page, 0,
+				    page, 0, crypt_stats->extent_size, iv);
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypted [%d] bytes\n", rc);
+	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes after " "encryption:\n");
+	if (ecryptfs_verbosity > 0)
+		ecryptfs_dump_hex((char *)page_address(lower_page), 8);
+	if (rc > 0)
+		rc = 0;
+	return rc;
+}
+
+/**
+ * @param page Page that is locked before this call is made
+ */
+static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
+{
+	int rc = -EIO;
+	int err = 0;
+	unsigned long lower_index;
+	struct inode *inode;
+	struct inode *lower_inode;
+	struct page *lower_page;
+	char *kaddr, *lower_kaddr;
+	struct ecryptfs_crypt_stats *crypt_stats;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; page->index = [%ld]; "
+			"page->mapping->host = [%p]\n", page->index,
+			page->mapping->host);
+	inode = page->mapping->host;
+	crypt_stats = &(ECRYPTFS_INODE_TO_PRIVATE(inode)->crypt_stats);
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	lower_index = ecryptfs_pg_idx_to_lwr_pg_idx(crypt_stats, page->index);
+	ecryptfs_printk(1, KERN_NOTICE, "Grab lower_idx = [%ld]\n",
+			lower_index);
+	lower_page = grab_cache_page(lower_inode->i_mapping, lower_index);
+	if (!lower_page) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	kaddr = (char *)kmap(page);
+	if (!kaddr) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	lower_kaddr = (char *)kmap(lower_page);
+	if (!lower_kaddr) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	if (crypt_stats->encrypted) {
+		char iv[ECRYPTFS_MAX_IV_BYTES];
+		int record_byte_offset;
+		/* TODO: HMAC: Include HMAC bytes in the record size */
+		record_byte_offset = (record_idx(crypt_stats, page->index)
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
+	kunmap(page);
+	kunmap(lower_page);
+	rc = lower_inode->i_mapping->a_ops->writepage(lower_page, wbc);
+	if (rc)
+		ecryptfs_printk(0, KERN_ERR, "Error calling lower writepage(); "
+				"rc = [%d]\n", rc);
+	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
+	page_cache_release(lower_page);
+	if (rc)
+		ClearPageUptodate(page);
+	else
+		SetPageUptodate(page);
+	unlock_page(page);
+out:
+	if (err)
+		rc = err;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Reads the data from the lower file file at index lower_page_index
+ * and copies that data into page.
+ *
+ * @param page	Page to fill
+ * @param lower_page_index Index of the page in the lower file to get
+ */
+static int ecryptfs_do_readpage(struct file *file, struct page *page,
+				pgoff_t lower_page_index)
+{
+	int rc = -EIO;
+	struct dentry *dentry;
+	struct file *lower_file;
+	struct dentry *lower_dentry;
+	struct inode *inode;
+	struct inode *lower_inode;
+	char *page_data;
+	struct page *lower_page = NULL;
+	char *lower_page_data;
+	struct address_space_operations *lower_a_ops;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; lower_page_index = [%lu]\n",
+			lower_page_index);
+	dentry = file->f_dentry;
+	if (NULL == ECRYPTFS_FILE_TO_PRIVATE_SM(file)) {
+		rc = -ENOENT;
+		ecryptfs_printk(0, KERN_ERR, "No lower file info\n");
+		goto out;
+	}
+	lower_file = ECRYPTFS_FILE_TO_LOWER(file);
+	lower_dentry = ECRYPTFS_DENTRY_TO_LOWER(dentry);
+	inode = dentry->d_inode;
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	lower_a_ops = lower_inode->i_mapping->a_ops;
+	lower_page = read_cache_page(lower_inode->i_mapping, lower_page_index,
+				     (filler_t *) lower_a_ops->readpage,
+				     (void *)lower_file);
+	if (IS_ERR(lower_page)) {
+		rc = PTR_ERR(lower_page);
+		lower_page = NULL;
+		ecryptfs_printk(0, KERN_ERR, "Error reading from page cache\n");
+		goto out;
+	}
+	wait_on_page_locked(lower_page);
+	if (!PageUptodate(lower_page)) {
+		lock_page(lower_page);
+		rc = lower_a_ops->readpage(lower_file, lower_page);
+		if (rc) {
+			lower_page = NULL;
+			rc = -EIO;
+			ecryptfs_printk(0, KERN_ERR, "Error reading lower "
+					"page at index=[%lu]\n",
+					lower_page_index);
+			goto out;
+		}
+		wait_on_page_locked(lower_page);
+		if (!PageUptodate(lower_page)) {
+			rc = -EIO;
+			ecryptfs_printk(0, KERN_ERR, "Error reading lower "
+					"page at index=[%lu]\n",
+					lower_page_index);
+			goto out;
+		}
+	}
+	page_data = (char *)kmap(page);
+	if (!page_data) {
+		rc = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Error mapping page\n");
+		goto out;
+	}
+	lower_page_data = (char *)kmap(lower_page);
+	if (!lower_page_data) {
+		rc = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Error mapping page\n");
+		kunmap(page);
+		goto out;
+	}
+	/* TODO: Copy sub-page amount of data? */
+	memcpy(page_data, lower_page_data, PAGE_CACHE_SIZE);
+	kunmap(lower_page);
+	kunmap(page);
+	rc = 0;
+      out:
+	if (likely(lower_page))
+		page_cache_release(lower_page);
+	if (rc == 0)
+		SetPageUptodate(page);
+	else
+		ClearPageUptodate(page);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/* Action descriptor for decrypt_page() */
+#define ECRYPTFS_ACTION_COPY 0
+#define ECRYPTFS_ACTION_DECRYPT 1
+
+/**
+ * Decrypt a page of data
+ *
+ * @return Zero on success
+ */
+static int decrypt_page(struct ecryptfs_crypt_stats *crypt_stats,
+			struct file *file, char *iv, struct page *page,
+			pgoff_t lower_page_index, int decrypt)
+{
+	int rc = 0;
+	char *lower_page_encrypted_virt;
+	struct page *lower_page_encrypted;
+	int decrypt_to;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; lower_page_index = [%d]\n",
+			lower_page_index);
+	lower_page_encrypted_virt =
+	    kmem_cache_alloc(ecryptfs_lower_page_cache, SLAB_KERNEL);
+	if (!lower_page_encrypted_virt) {
+		rc = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Error getting page for "
+				"encrypted lower page\n");
+		ClearPageUptodate(page);
+		goto out;
+	}
+	lower_page_encrypted = virt_to_page(lower_page_encrypted_virt);
+	rc = ecryptfs_do_readpage(file, lower_page_encrypted, lower_page_index);
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error reading lower encrypted "
+				"page\n");
+		ClearPageUptodate(page);
+		goto out;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Decrypting page with iv:\n");
+	if (ecryptfs_verbosity > 0)
+		ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
+	ecryptfs_printk(1, KERN_NOTICE, "Using session key encryption key:\n");
+	if (ecryptfs_verbosity > 0)
+		ecryptfs_dump_hex(crypt_stats->key,
+				  crypt_stats->key_size_bits / 8);
+	decrypt_to = crypt_stats->extent_size;
+	ecryptfs_printk(1, KERN_NOTICE, "Decrypting to: [%d]\n", decrypt_to);
+	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes before decryption:\n");
+	if (ecryptfs_verbosity > 0)
+		ecryptfs_dump_hex((char *)page_address(lower_page_encrypted),
+				  8);
+	if (decrypt)
+		do_decrypt_page_offset(crypt_stats, page,
+				       0, lower_page_encrypted,
+				       0, decrypt_to, iv);
+	else
+		memcpy(page, lower_page_encrypted_virt, decrypt_to);
+	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes after decryption:\n");
+	if (ecryptfs_verbosity > 0)
+		ecryptfs_dump_hex((char *)page_address(page), 8);
+	kmem_cache_free(ecryptfs_lower_page_cache, lower_page_encrypted_virt);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Read in a page
+ *
+ * @param file	This is an ecryptfs file
+ * @param page	ecryptfs associated page to stick the read data into
+ * @return Zero on success; non-zero on error
+ */
+static int ecryptfs_readpage(struct file *file, struct page *page)
+{
+	int rc = 0;
+	struct ecryptfs_crypt_stats *crypt_stats = NULL;
+	char iv[ECRYPTFS_MAX_IV_BYTES];
+	int iv_is_nonzero = 0;
+	char *records_virt;
+	struct page *records_page;
+	int record_byte_offset;
+	int iv_byte_offset;
+	int i;
+	pgoff_t records_page_index;
+	pgoff_t lower_page_index;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; page->index = [%ld]\n",
+			page->index);
+	ASSERT(file && file->f_dentry && file->f_dentry->d_inode);
+	crypt_stats = 
+		&ECRYPTFS_INODE_TO_PRIVATE(file->f_dentry->d_inode)->crypt_stats;
+	/* If the file is neither encrypted nor HMAC-verified, then we
+	 * have passthrough mode. */
+	if (!crypt_stats || !crypt_stats->encrypted) {
+		ecryptfs_printk(1, KERN_NOTICE,
+				"Passing through unencrypted page\n");
+		rc = ecryptfs_do_readpage(file, page, page->index);
+		goto out;
+	}
+	/* The file is encrypted, hmac verified, or both. */
+	ecryptfs_printk(1, KERN_NOTICE,
+			"crypt_stats->iv_bytes = [%d]\n",
+			crypt_stats->iv_bytes);
+	ecryptfs_printk(1, KERN_NOTICE,
+			"crypt_stats->records_per_page = [%d]\n",
+			crypt_stats->records_per_page);
+
+	/* Get the relevant IV/HMAC page */
+	records_page_index = last_records_page_idx(crypt_stats, page->index);
+	ecryptfs_printk(1, KERN_NOTICE, "records_page_index = [%lu]\n",
+			records_page_index);
+	records_virt = (char *)__get_free_page(GFP_KERNEL);
+	if (!records_virt) {
+		ecryptfs_printk(0, KERN_ERR, "Error getting free page");
+		rc = -ENOMEM;
+		ClearPageUptodate(page);
+		goto out;
+	}
+	records_page = virt_to_page(records_virt);
+	rc = ecryptfs_do_readpage(file, records_page, records_page_index);
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error reading IV/HMAC page");
+		ClearPageUptodate(page);
+		goto out;
+	}
+	/* TODO: HMAC: Include HMAC bytes in the record size */
+	record_byte_offset = (record_idx(crypt_stats, page->index) 
+			      * crypt_stats->iv_bytes);
+	iv_byte_offset = -1;
+	if (crypt_stats->encrypted) {
+		iv_byte_offset = record_byte_offset;
+		iv_is_nonzero = 0;
+		for (i = 0; i < crypt_stats->iv_bytes; i++)
+			iv_is_nonzero |= (records_virt + iv_byte_offset)[i];
+		memcpy(iv, (records_virt + iv_byte_offset),
+		       crypt_stats->iv_bytes);
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "record_byte_offset = [%d]\n",
+			record_byte_offset);
+	ecryptfs_printk(1, KERN_NOTICE, "iv_byte_offset = [%d]\n",
+			iv_byte_offset);
+	free_page((unsigned long)records_virt);
+	lower_page_index = ecryptfs_pg_idx_to_lwr_pg_idx(crypt_stats,
+							 page->index);
+	ecryptfs_printk(1, KERN_NOTICE, "lower_page_index = [%lu]\n",
+			lower_page_index);
+	ecryptfs_printk(1, KERN_NOTICE, "iv_is_nonzero = [%d]\n",
+			iv_is_nonzero);
+	if (crypt_stats->encrypted && iv_is_nonzero) {
+		rc = decrypt_page(crypt_stats, file, iv, page,
+				  lower_page_index, ECRYPTFS_ACTION_DECRYPT);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR, "Error decrypting "
+					"page; rc = [%d]\n", rc);
+			goto out;
+		}
+	} else {
+		ecryptfs_printk(1, KERN_NOTICE,
+				"Passing through unencrypted page\n");
+		rc = ecryptfs_do_readpage(file, page, lower_page_index);
+	}
+	SetPageUptodate(page);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Unlocking page with index = [%lu]\n",
+			page->index);
+	unlock_page(page);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static void fill_zeros_to_end_of_page(struct page *page, unsigned to)
+{
+	struct inode *inode = page->mapping->host;
+	int end_byte_in_page;
+	char *page_virt;
+
+	if ((i_size_read(inode) / PAGE_CACHE_SIZE) == page->index) {
+		end_byte_in_page = i_size_read(inode) % PAGE_CACHE_SIZE;
+		if (to > end_byte_in_page)
+			end_byte_in_page = to;
+		page_virt = kmap(page);
+		if (!page_virt) {
+			goto out;
+		}
+		memset((page_virt + end_byte_in_page), 0,
+		       (PAGE_CACHE_SIZE - end_byte_in_page));
+		kunmap(page);
+	}
+out:
+	return;
+}
+
+static int ecryptfs_prepare_write(struct file *file, struct page *page,
+				  unsigned from, unsigned to)
+{
+	int err = 0;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; page->index = [%lu]; from = "
+			"[%d]; to = [%d]\n", page->index, from, to);
+	kmap(page);
+	if (from == 0 && to == PAGE_CACHE_SIZE)
+		goto out;	/* If we are writing a full page, it will be
+				   up to date. */
+	if (!PageUptodate(page))
+		err = ecryptfs_do_readpage(file, page, page->index);
+out:
+	return err;
+}
+
+/**
+ * @return Zero on success
+ */
+int
+ecryptfs_write_inode_size_to_header(struct file *lower_file,
+				    struct inode *lower_inode,
+				    struct inode *inode)
+{
+	int rc = 0;
+	struct page *header_page;
+	char *header_virt;
+	struct address_space_operations *lower_a_ops;
+	unsigned long long file_size;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	header_page = grab_cache_page(lower_inode->i_mapping, 0);
+	if (!header_page) {
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_ERR, "grab_cache_page for header page "
+				"failed\n");
+		goto out;
+	}
+	header_virt = kmap(header_page);
+	lower_a_ops = lower_inode->i_mapping->a_ops;
+	rc = lower_a_ops->prepare_write(lower_file, header_page, 0, 8);
+	file_size = (unsigned long long)i_size_read(inode);
+	memcpy(header_virt, &file_size, 8);
+	rc = lower_a_ops->commit_write(lower_file, header_page, 0, 8);
+	if (rc < 0)
+		ecryptfs_printk(0, KERN_ERR, "Error commiting header page "
+				"write\n");
+	kunmap(header_page);
+	ecryptfs_printk(1, KERN_NOTICE, "Unlocking page with index = [%lu]\n",
+			header_page->index);
+	unlock_page(header_page);
+	page_cache_release(header_page);
+	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
+	mark_inode_dirty_sync(inode);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * This is where we encrypt the data and pass the encrypted data to
+ * the lower filesystem.  In OpenPGP-compatible mode, we operate on
+ * entire underlying packets.
+ *
+ * @param file The eCryptfs file object
+ * @param page The eCryptfs page
+ * @param from Ignored (we rotate the page IV on each write)
+ * @param to Ignored
+ * @return 
+ */
+static int ecryptfs_commit_write(struct file *file, struct page *page,
+				 unsigned from, unsigned to)
+{
+	int rc = -ENOMEM;
+	struct inode *inode;
+	struct inode *lower_inode;
+	struct page *lower_page = NULL;
+	struct file *lower_file = NULL;
+	loff_t pos;
+	unsigned bytes = to - from;
+	struct ecryptfs_crypt_stats *crypt_stats;
+	pgoff_t lower_page_index;
+	struct address_space_operations *lower_a_ops;
+	struct dentry *ecryptfs_dentry;
+
+	ecryptfs_printk(1, KERN_NOTICE,
+			"Enter; page->index = [%lu]; from = [%d]; to = [%d]\n",
+			page->index, from, to);
+	ecryptfs_dentry = file->f_dentry;
+	inode = page->mapping->host;
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	down(&lower_inode->i_sem);
+	if (!(lower_inode->i_mapping
+	      && lower_inode->i_mapping->a_ops
+	      && lower_inode->i_mapping->a_ops->prepare_write
+	      && lower_inode->i_mapping->a_ops->commit_write)) {
+		ecryptfs_printk(0, KERN_ERR,
+				"a_ops of lower inode not valid\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	lower_a_ops = lower_inode->i_mapping->a_ops;
+	ASSERT(file && file->f_dentry && file->f_dentry->d_inode);
+	crypt_stats = 
+		&ECRYPTFS_INODE_TO_PRIVATE(file->f_dentry->d_inode)->crypt_stats;
+	if (NULL != ECRYPTFS_FILE_TO_PRIVATE(file))
+		lower_file = ECRYPTFS_FILE_TO_LOWER(file);
+	if (!crypt_stats) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = ecryptfs_init_crypt_ctx(crypt_stats);
+	if (rc)
+		ecryptfs_printk(1, KERN_NOTICE, "Problem with "
+				"initializing crypto context\n");
+	if (crypt_stats->new_file) {
+		struct page *header_page;
+		char *header_virt;
+
+		crypt_stats->new_file = 0;
+		header_page = grab_cache_page(lower_inode->i_mapping, 0);
+		if (!header_page) {
+			rc = -EINVAL;
+			ecryptfs_printk(0, KERN_ERR, "grab_cache_page for "
+					"header page failed\n");
+			goto out;
+		}
+		header_virt = kmap(header_page);
+		rc = lower_a_ops->prepare_write(lower_file, header_page,
+						0, crypt_stats->extent_size);
+		rc = ecryptfs_write_headers_virt(header_virt, crypt_stats,
+						 ecryptfs_dentry, 
+						 ECRYPTFS_FILE_VERSION);
+		if (rc) {
+			ecryptfs_printk(0, KERN_WARNING, "Error generating "
+					"header; rc = [%d]\n", rc);
+			rc = -EIO;
+			goto out;
+		}
+		memset(header_virt, 0, 8);
+		rc = lower_a_ops->commit_write(lower_file, header_page,
+					       0, crypt_stats->extent_size);
+		if (rc < 0)
+			ecryptfs_printk(0, KERN_ERR, "Error commiting header "
+					"page write\n");
+		kunmap(header_page);
+		ecryptfs_printk(1, KERN_NOTICE,
+				"Unlocking header page with index = " "[%lu]\n",
+				header_page->index);
+		unlock_page(header_page);
+		page_cache_release(header_page);
+		if (rc < 0)
+			goto out;
+		rc = 0;
+		ecryptfs_printk(1, KERN_NOTICE, "lower_inode->i_blocks = "
+				"[%lu]\n", lower_inode->i_blocks);
+		i_size_write(inode, 0);
+		lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
+		mark_inode_dirty_sync(inode);
+	} else
+		ecryptfs_printk(1, KERN_NOTICE, "Not a new file\n");
+	/* Translate the page index */
+	lower_page_index = ecryptfs_pg_idx_to_lwr_pg_idx(crypt_stats,
+							 page->index);
+	ecryptfs_printk(1, KERN_NOTICE, "lower_page_index = [%lu]\n",
+			lower_page_index);
+	lower_page = grab_cache_page(lower_inode->i_mapping, lower_page_index);
+	if (!lower_page) {
+		ecryptfs_printk(0, KERN_ERR, "grab_cache_page for "
+				"lower_page_index=[%lu] failed\n",
+				lower_page_index);
+		goto out;
+	}
+	kmap(lower_page);
+	rc = lower_a_ops->prepare_write(lower_file, lower_page,
+					0, crypt_stats->extent_size);
+	if (rc)
+		goto out_unlock_lower;
+	fill_zeros_to_end_of_page(page, to);
+	if (!crypt_stats->encrypted) {
+		/* TODO: aops */
+		memcpy((char *)page_address(lower_page),
+		       (char *)page_address(page), crypt_stats->extent_size);
+	} else {
+		/* The file is either encrypted or HMAC'd */
+		char iv[ECRYPTFS_MAX_IV_BYTES];
+		int record_byte_offset;
+		ecryptfs_printk(1, KERN_NOTICE,
+				"crypt_stats->iv_bytes = [%d]\n",
+				crypt_stats->iv_bytes);
+		/* TODO: HMAC: Include HMAC bytes in the record size */	
+		record_byte_offset = (record_idx(crypt_stats, page->index) 
+				      * crypt_stats->iv_bytes);
+		rc = ecryptfs_read_rotate_write_iv(iv, inode, 
+						   record_byte_offset, 
+						   lower_file, page);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR, "Error rotating IV\n");
+			goto out_unlock_lower;
+		}
+		ecryptfs_printk(1, KERN_NOTICE, "Encrypting page with iv:\n");
+		if (unlikely(ecryptfs_verbosity > 0))
+			ecryptfs_dump_hex(iv, crypt_stats->iv_bytes);
+		rc = encrypt_page(crypt_stats, page, lower_page, iv);
+		if (rc) {
+			ecryptfs_printk(0, KERN_WARNING, "Error encrypting "
+					"page (upper index [%llu])\n", 
+					page->index);
+			goto out;
+		}
+	}
+	rc = lower_a_ops->commit_write(lower_file, lower_page, 0,
+				       crypt_stats->extent_size);
+	if (rc < 0) {
+		ecryptfs_printk(0, KERN_ERR,
+				"Error committing write; rc = [%d]\n", rc);
+		goto out_unlock_lower;
+	}
+	rc = bytes;
+	inode->i_blocks = lower_inode->i_blocks;
+	pos = (page->index << PAGE_CACHE_SHIFT) + to;
+	if (pos > i_size_read(inode)) {
+		i_size_write(inode, pos);
+		ecryptfs_printk(1, KERN_NOTICE, "Expanded file size to "
+				"[%lld]\n", i_size_read(inode));
+	}
+	ecryptfs_write_inode_size_to_header(lower_file, lower_inode, inode);
+	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
+	mark_inode_dirty_sync(inode);
+	
+out_unlock_lower:
+	kunmap(lower_page);
+	ecryptfs_printk(1, KERN_NOTICE,
+			"Unlocking lower page with index = [%lu]\n",
+			lower_page->index);
+	unlock_page(lower_page);
+	page_cache_release(lower_page);
+	kunmap(page);		/* mapped in prepare_write */
+out:
+	if (rc < 0)
+		ClearPageUptodate(page);
+	else
+		SetPageUptodate(page);
+	up(&lower_inode->i_sem);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static sector_t ecryptfs_bmap(struct address_space *mapping, sector_t block)
+{
+	int rc = 0;
+	struct inode *inode;
+	struct inode *lower_inode;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	inode = (struct inode *)mapping->host;
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	if (lower_inode->i_mapping->a_ops->bmap)
+		rc = lower_inode->i_mapping->a_ops->bmap(lower_inode->i_mapping,
+							 block);
+	return rc;
+}
+
+/**
+ * This function is copied verbatim from mm/filemap.c.  It should be
+ * simply moved to some header file instead.
+ */
+static int sync_page(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
+		return mapping->a_ops->sync_page(page);
+	return 0;
+}
+
+static int ecryptfs_sync_page(struct page *page)
+{
+	int rc = 0;
+	struct inode *inode;
+	struct inode *lower_inode;
+	struct page *lower_page;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	inode = page->mapping->host;
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	lower_page = grab_cache_page(lower_inode->i_mapping, page->index);
+	if (!lower_page) {
+		rc = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Error from grab_cache_page "
+				"(no mem?)\n");
+		goto out;
+	}
+	rc = sync_page(lower_page);
+	ecryptfs_printk(1, KERN_NOTICE, "Unlocking page with index = [%lu]\n",
+			lower_page->index);
+	unlock_page(lower_page);
+	page_cache_release(lower_page);
+out:
+	return rc;
+}
+
+struct address_space_operations ecryptfs_aops = {
+	.writepage = ecryptfs_writepage,
+	.readpage = ecryptfs_readpage,
+	.prepare_write = ecryptfs_prepare_write,
+	.commit_write = ecryptfs_commit_write,
+	.bmap = ecryptfs_bmap,
+	.sync_page = ecryptfs_sync_page,
+};
