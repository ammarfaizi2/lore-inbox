Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290133AbSAKUxU>; Fri, 11 Jan 2002 15:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290110AbSAKUxL>; Fri, 11 Jan 2002 15:53:11 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:54661 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S290111AbSAKUwx>; Fri, 11 Jan 2002 15:52:53 -0500
Date: Fri, 11 Jan 2002 15:52:28 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] expanding truncate
Message-ID: <205500000.1010782348@tiny>
In-Reply-To: <18370000.1010165612@tiny>
In-Reply-To: <Pine.GSO.4.21.0201031111130.23312-100000@weyl.math.psu.edu> <18370000.1010165612@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 04, 2002 12:33:32 PM -0500 Chris Mason <mason@suse.com> wrote:

[ expanding truncate patch ]

>> 	Seriously, it looks like a half-arsed and very old attempt to do common
>> expanding truncate() for no-holes filesystems.  BTW, these days rlimit
>> checks are done by vmtruncate().

Ok, the rlimit checks where still there because generic_cont_expand is called before vmtruncate.  I changed it around to match vmtruncate better though.

Does anyone still object to the patch below?

-chris

--- 0.22/fs/reiserfs/file.c Fri, 11 Jan 2002 14:17:09 -0500 
+++ 0.22(w)/fs/reiserfs/file.c Fri, 11 Jan 2002 15:28:35 -0500 
@@ -103,6 +103,20 @@
 	if (get_inode_item_key_version(inode) == KEY_FORMAT_3_5 &&
 	    attr->ia_size > MAX_NON_LFS)
             return -EFBIG ;
+
+	/* fill in hole pointers in the expanding truncate case. */
+        if (attr->ia_size > inode->i_size) {
+	    error = generic_cont_expand(inode, attr->ia_size) ;
+	    if (inode->u.reiserfs_i.i_prealloc_count > 0) {
+		struct reiserfs_transaction_handle th ;
+		/* we're changing at most 2 bitmaps, inode + super */
+		journal_begin(&th, inode->i_sb, 4) ;
+		reiserfs_discard_prealloc (&th, inode);
+		journal_end(&th, inode->i_sb, 4) ;
+	    }
+	    if (error)
+	        return error ;
+	}
     }
 
     if ((((attr->ia_valid & ATTR_UID) && (attr->ia_uid & ~0xffff)) ||
--- 0.22/fs/reiserfs/inode.c Fri, 11 Jan 2002 14:17:09 -0500 
+++ 0.22(w)/fs/reiserfs/inode.c Fri, 11 Jan 2002 14:43:42 -0500 
@@ -2125,7 +2125,7 @@
     /* we test for O_SYNC here so we can commit the transaction
     ** for any packed tails the file might have had
     */
-    if (f->f_flags & O_SYNC) {
+    if (f && f->f_flags & O_SYNC) {
 	lock_kernel() ;
  	reiserfs_commit_for_inode(inode) ;
 	unlock_kernel();
--- 0.22/fs/buffer.c Fri, 11 Jan 2002 11:53:37 -0500 
+++ 0.22(w)/fs/buffer.c Fri, 11 Jan 2002 15:28:08 -0500 
@@ -1760,6 +1760,52 @@
 	return 0;
 }
 
+/* utility function for filesystems that need to do work on expanding
+ * truncates.  Uses prepare/commit_write to allow the filesystem to
+ * deal with the hole.  
+ */
+int generic_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	unsigned long index, offset, limit;
+	int err;
+
+	err = -EFBIG;
+        limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
+		send_sig(SIGXFSZ, current, 0);
+		goto out;
+	}
+	if (size > inode->i_sb->s_maxbytes)
+		goto out;
+
+	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
+
+	/* ugh.  in prepare/commit_write, if from==to==start of block, we 
+	** skip the prepare.  make sure we never send an offset for the start
+	** of a block
+	*/
+	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
+		offset++;
+	}
+	index = size >> PAGE_CACHE_SHIFT;
+	err = -ENOMEM;
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		goto out;
+	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
+	if (!err) {
+		err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+	}
+	UnlockPage(page);
+	page_cache_release(page);
+	if (err > 0)
+		err = 0;
+out:
+	return err;
+}
+
 /*
  * For moronic filesystems that do not allow holes in file.
  * We may have to extend the file.
--- 0.22/kernel/ksyms.c Fri, 11 Jan 2002 11:54:05 -0500 
+++ 0.22(w)/kernel/ksyms.c Fri, 11 Jan 2002 14:17:35 -0500 
@@ -204,6 +204,7 @@
 EXPORT_SYMBOL(block_read_full_page);
 EXPORT_SYMBOL(block_prepare_write);
 EXPORT_SYMBOL(block_sync_page);
+EXPORT_SYMBOL(generic_cont_expand);
 EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
--- 0.22/include/linux/fs.h Fri, 11 Jan 2002 14:17:09 -0500 
+++ 0.22(w)/include/linux/fs.h Fri, 11 Jan 2002 14:17:35 -0500 
@@ -1416,6 +1416,7 @@
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				unsigned long *);
+extern int generic_cont_expand(struct inode *inode, loff_t size) ;
 extern int block_commit_write(struct page *page, unsigned from, unsigned to);
 extern int block_sync_page(struct page *);
 


