Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288232AbSACHVw>; Thu, 3 Jan 2002 02:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288231AbSACHVn>; Thu, 3 Jan 2002 02:21:43 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:31492 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288225AbSACHV3>; Thu, 3 Jan 2002 02:21:29 -0500
Date: Thu, 3 Jan 2002 10:21:28 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] expanding truncate
Message-ID: <20020103102128.A2625@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This patch makes sure that indirect pointers for holes are correctly filled in by zeroes at
    hole-creation time. (Author is Chris Mason. fs/buffer.c part (generic_cont_expand) were written by
    Alexander Viro)

    Please apply.

Bye,
    Oleg

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="expanding-truncate-4-2.4.18pre1.diff"

--- linux-2.4.18-pre1/fs/reiserfs/file.c.orig	Thu Jan  3 10:02:03 2002
+++ linux-2.4.18-pre1/fs/reiserfs/file.c	Thu Jan  3 10:09:24 2002
@@ -100,6 +100,20 @@
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
--- linux-2.4.18-pre1/fs/reiserfs/inode.c.orig	Thu Jan  3 10:07:52 2002
+++ linux-2.4.18-pre1/fs/reiserfs/inode.c	Thu Jan  3 10:09:24 2002
@@ -2042,7 +2042,7 @@
     /* we test for O_SYNC here so we can commit the transaction
     ** for any packed tails the file might have had
     */
-    if (f->f_flags & O_SYNC) {
+    if (f && f->f_flags & O_SYNC) {
 	lock_kernel() ;
  	reiserfs_commit_for_inode(inode) ;
 	unlock_kernel();
--- linux-2.4.18-pre1/fs/buffer.c.orig	Thu Jan  3 10:02:03 2002
+++ linux-2.4.18-pre1/fs/buffer.c	Thu Jan  3 10:09:24 2002
@@ -1760,6 +1760,46 @@
 	return 0;
 }
 
+int generic_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	unsigned long index, offset, limit;
+	int err;
+
+	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	if (limit != RLIM_INFINITY) {
+		if (size > limit) {
+			send_sig(SIGXFSZ, current, 0);
+			size = limit;
+		}
+	}
+	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
+
+	/* ugh.  in prepare/commit_write, if from==to==start of block, we 
+	** skip the prepare.  make sure we never send an offset for the start
+	** of a block
+	*/
+	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
+	    offset++ ;
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
--- linux-2.4.18-pre1/kernel/ksyms.c.orig	Thu Jan  3 10:02:20 2002
+++ linux-2.4.18-pre1/kernel/ksyms.c	Thu Jan  3 10:09:24 2002
@@ -205,6 +205,7 @@
 EXPORT_SYMBOL(block_read_full_page);
 EXPORT_SYMBOL(block_prepare_write);
 EXPORT_SYMBOL(block_sync_page);
+EXPORT_SYMBOL(generic_cont_expand);
 EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
--- linux-2.4.18-pre1/include/linux/fs.h.orig	Thu Jan  3 10:02:03 2002
+++ linux-2.4.18-pre1/include/linux/fs.h	Thu Jan  3 10:09:24 2002
@@ -1384,6 +1384,7 @@
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				unsigned long *);
+extern int generic_cont_expand(struct inode *inode, loff_t size) ;
 extern int block_commit_write(struct page *page, unsigned from, unsigned to);
 extern int block_sync_page(struct page *);
 

--AhhlLboLdkugWU4S--
