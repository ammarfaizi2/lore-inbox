Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSGHRpC>; Mon, 8 Jul 2002 13:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSGHRpB>; Mon, 8 Jul 2002 13:45:01 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:31141 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316499AbSGHRov>; Mon, 8 Jul 2002 13:44:51 -0400
Subject: NTFS: 2.0.15 - Fake inodes based attribute i/o via the page cache, fixes, cleanups
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 8 Jul 2002 18:47:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks!

Fake inode based i/o is now fully implemented. Only cleanups left to do
but the patch was getting big so I stopped here...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    5 
 fs/ntfs/ChangeLog                  |   29 +++
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/aops.c                     |  135 +++++----------
 fs/ntfs/attrib.c                   |   55 +-----
 fs/ntfs/compress.c                 |    5 
 fs/ntfs/inode.c                    |  321 ++++++++++++++++++++++++++++++++++++-
 fs/ntfs/mft.c                      |   18 +-
 fs/ntfs/ntfs.h                     |   19 +-
 fs/ntfs/super.c                    |   13 -
 fs/ntfs/volume.h                   |   58 +++---
 11 files changed, 481 insertions(+), 179 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/08 1.617)
   NTFS: 2.0.15 - Fake inodes based attribute i/o via the pagecache, fixes, cleanups.
   - Fix silly bug in fs/ntfs/super.c::parse_options() which was causing
     remounts to fail when the partition had an entry in /etc/fstab and
     the entry specified the nls= option.
   - Apply same macro magic used in fs/ntfs/inode.h to fs/ntfs/volume.h to
     expand all the helper functions NVolFoo(), NVolSetFoo(), and
     NVolClearFoo().
   - Move copyright statement from driver initialisation message to
     module description (fs/super.c). This makes the initialisation
     message fit on one line and fits in better with rest of kernel.
   - Update fs/ntfs/attrib.c::map_run_list() to work on both real and
     attribute inodes, and both for files and directories.
   - Implement fake attribute inodes allowing all attribute i/o to go via
     the page cache and to use all the normal vfs/mm functionality:
     - Add ntfs_attr_iget() and its helper ntfs_read_locked_attr_inode()
       to fs/ntfs/inode.c.
     - Add needed cleanup code to ntfs_clear_big_inode().
   - Merge address space operations for files and directories (aops.c),
     now just have ntfs_aops:
     - Rename:
           end_buffer_read_attr_async() -> ntfs_end_buffer_read_async(),
           ntfs_attr_read_block()       -> ntfs_read_block(),
           ntfs_file_read_page()        -> ntfs_readpage().
     - Rewrite fs/ntfs/aops.c::ntfs_readpage() to work on both real and
       attribute inodes, and both for files and directories.
     - Remove obsolete fs/ntfs/aops.c::ntfs_mst_readpage().


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Mon Jul  8 18:41:18 2002
+++ b/Documentation/filesystems/ntfs.txt	Mon Jul  8 18:41:18 2002
@@ -247,6 +247,11 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.15:
+	- Bug fix in parsing of remount options.
+	- Internal changes implementing attribute (fake) inodes allowing all
+	  attribute i/o to go via the page cache and to use all the normal
+	  vfs/mm functionality.
 2.0.14:
 	- Internal changes improving run list merging code and minor locking
 	  change to not rely on BKL in ntfs_statfs().
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/ChangeLog	Mon Jul  8 18:41:18 2002
@@ -26,7 +26,34 @@
 	  callers, i.e. ntfs_iget(), to pass that error code up instead of just
 	  using -EIO.
 	- Enable NFS exporting of NTFS.
-	- Use fake inodes for address space i/o.
+
+2.0.15 - Fake inodes based attribute i/o via the pagecache, fixes and cleanups.
+
+	- Fix silly bug in fs/ntfs/super.c::parse_options() which was causing
+	  remounts to fail when the partition had an entry in /etc/fstab and
+	  the entry specified the nls= option.
+	- Apply same macro magic used in fs/ntfs/inode.h to fs/ntfs/volume.h to
+	  expand all the helper functions NVolFoo(), NVolSetFoo(), and
+	  NVolClearFoo().
+	- Move copyright statement from driver initialisation message to
+	  module description (fs/super.c). This makes the initialisation
+	  message fit on one line and fits in better with rest of kernel.
+	- Update fs/ntfs/attrib.c::map_run_list() to work on both real and
+	  attribute inodes, and both for files and directories.
+	- Implement fake attribute inodes allowing all attribute i/o to go via
+	  the page cache and to use all the normal vfs/mm functionality:
+	  - Add ntfs_attr_iget() and its helper ntfs_read_locked_attr_inode()
+	    to fs/ntfs/inode.c.
+	  - Add needed cleanup code to ntfs_clear_big_inode().
+	- Merge address space operations for files and directories (aops.c),
+	  now just have ntfs_aops:
+	  - Rename:
+		end_buffer_read_attr_async() ->	ntfs_end_buffer_read_async(),
+		ntfs_attr_read_block()	     ->	ntfs_read_block(),
+		ntfs_file_read_page()	     ->	ntfs_readpage().
+	  - Rewrite fs/ntfs/aops.c::ntfs_readpage() to work on both real and
+	    attribute inodes, and both for files and directories.
+	  - Remove obsolete fs/ntfs/aops.c::ntfs_mst_readpage().
 
 2.0.14 - Run list merging code cleanup, minor locking changes, typo fixes.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/Makefile	Mon Jul  8 18:41:18 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.14\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.15\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/aops.c	Mon Jul  8 18:41:18 2002
@@ -30,7 +30,7 @@
 #include "ntfs.h"
 
 /**
- * end_buffer_read_attr_async - async io completion for reading attributes
+ * ntfs_end_buffer_read_async - async io completion for reading attributes
  * @bh:		buffer head on which io is completed
  * @uptodate:	whether @bh is now uptodate or not
  *
@@ -45,7 +45,7 @@
  * record size, and index_block_size_bits, to the log(base 2) of the ntfs
  * record size.
  */
-static void end_buffer_read_attr_async(struct buffer_head *bh, int uptodate)
+static void ntfs_end_buffer_read_async(struct buffer_head *bh, int uptodate)
 {
 	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
@@ -143,12 +143,12 @@
 }
 
 /**
- * ntfs_attr_read_block - fill a @page of an address space with data
+ * ntfs_read_block - fill a @page of an address space with data
  * @page:	page cache page to fill with data
  *
  * Fill the page @page of the address space belonging to the @page->host inode.
  * We read each buffer asynchronously and when all buffers are read in, our io
- * completion handler end_buffer_read_attr_async(), if required, automatically
+ * completion handler ntfs_end_buffer_read_async(), if required, automatically
  * applies the mst fixups to the page before finally marking it uptodate and
  * unlocking it.
  *
@@ -156,7 +156,7 @@
  *
  * Contains an adapted version of fs/buffer.c::block_read_full_page().
  */
-static int ntfs_attr_read_block(struct page *page)
+static int ntfs_read_block(struct page *page)
 {
 	VCN vcn;
 	LCN lcn;
@@ -267,7 +267,7 @@
 		for (i = 0; i < nr; i++) {
 			struct buffer_head *tbh = arr[i];
 			lock_buffer(tbh);
-			tbh->b_end_io = end_buffer_read_attr_async;
+			tbh->b_end_io = ntfs_end_buffer_read_async;
 			set_buffer_async_read(tbh);
 		}
 		/* Finally, start i/o on the buffers. */
@@ -285,27 +285,27 @@
 }
 
 /**
- * ntfs_file_readpage - fill a @page of a @file with data from the device
+ * ntfs_readpage - fill a @page of a @file with data from the device
  * @file:	open file to which the page @page belongs or NULL
  * @page:	page cache page to fill with data
  *
- * For non-resident attributes, ntfs_file_readpage() fills the @page of the open
+ * For non-resident attributes, ntfs_readpage() fills the @page of the open
  * file @file by calling the ntfs version of the generic block_read_full_page()
- * function provided by the kernel, ntfs_attr_read_block(), which in turn
- * creates and reads in the buffers associated with the page asynchronously.
+ * function, ntfs_read_block(), which in turn creates and reads in the buffers
+ * associated with the page asynchronously.
  *
- * For resident attributes, OTOH, ntfs_file_readpage() fills @page by copying
- * the data from the mft record (which at this stage is most likely in memory)
- * and fills the remainder with zeroes. Thus, in this case, I/O is synchronous,
- * as even if the mft record is not cached at this point in time, we need to
- * wait for it to be read in before we can do the copy.
+ * For resident attributes, OTOH, ntfs_readpage() fills @page by copying the
+ * data from the mft record (which at this stage is most likely in memory) and
+ * fills the remainder with zeroes. Thus, in this case, I/O is synchronous, as
+ * even if the mft record is not cached at this point in time, we need to wait
+ * for it to be read in before we can do the copy.
  *
- * Return 0 on success or -errno on error.
+ * Return 0 on success and -errno on error.
  */
-static int ntfs_file_readpage(struct file *file, struct page *page)
+int ntfs_readpage(struct file *file, struct page *page)
 {
 	s64 attr_pos;
-	ntfs_inode *ni;
+	ntfs_inode *ni, *base_ni;
 	char *addr;
 	attr_search_context *ctx;
 	MFT_RECORD *mrec;
@@ -317,40 +317,45 @@
 
 	ni = NTFS_I(page->mapping->host);
 
-	/* Is the unnamed $DATA attribute resident? */
 	if (NInoNonResident(ni)) {
-		/* Attribute is not resident. */
-
-		/* If the file is encrypted, we deny access, just like NT4. */
-		if (NInoEncrypted(ni)) {
-			err = -EACCES;
-			goto unl_err_out;
-		}
-		/* Compressed data stream. Handled in compress.c. */
-		if (NInoCompressed(ni))
-			return ntfs_file_read_compressed_block(page);
+		/*
+		 * Only unnamed $DATA attributes can be compressed or
+		 * encrypted.
+		 */
+		if (ni->type == AT_DATA && !ni->name_len) {
+			/* If file is encrypted, deny access, just like NT4. */
+			if (NInoEncrypted(ni)) {
+				err = -EACCES;
+				goto err_out;
+			}
+			/* Compressed data streams are handled in compress.c. */
+			if (NInoCompressed(ni))
+				return ntfs_file_read_compressed_block(page);
+		}
 		/* Normal data stream. */
-		return ntfs_attr_read_block(page);
+		return ntfs_read_block(page);
 	}
 	/* Attribute is resident, implying it is not compressed or encrypted. */
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->_INE(base_ntfs_ino);
 
 	/* Map, pin and lock the mft record for reading. */
-	mrec = map_mft_record(READ, ni);
+	mrec = map_mft_record(READ, base_ni);
 	if (unlikely(IS_ERR(mrec))) {
 		err = PTR_ERR(mrec);
-		goto unl_err_out;
+		goto err_out;
 	}
-
-	ctx = get_attr_search_ctx(ni, mrec);
+	ctx = get_attr_search_ctx(base_ni, mrec);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
-		goto unm_unl_err_out;
+		goto unm_err_out;
 	}
-
-	/* Find the data attribute in the mft record. */
-	if (unlikely(!lookup_attr(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx))) {
+	if (unlikely(!lookup_attr(ni->type, ni->name, ni->name_len,
+			IGNORE_CASE, 0, NULL, 0, ctx))) {
 		err = -ENOENT;
-		goto put_unm_unl_err_out;
+		goto put_unm_err_out;
 	}
 
 	/* Starting position of the page within the attribute value. */
@@ -377,35 +382,16 @@
 	kunmap(page);
 
 	SetPageUptodate(page);
-put_unm_unl_err_out:
+put_unm_err_out:
 	put_attr_search_ctx(ctx);
-unm_unl_err_out:
-	unmap_mft_record(READ, ni);
-unl_err_out:
+unm_err_out:
+	unmap_mft_record(READ, base_ni);
+err_out:
 	unlock_page(page);
 	return err;
 }
 
 /**
- * ntfs_mst_readpage - fill a @page of the mft or a directory with data
- * @file:	open file/directory to which the @page belongs or NULL
- * @page:	page cache page to fill with data
- *
- * Readpage method for the VFS address space operations of directory inodes
- * and the $MFT/$DATA attribute.
- *
- * We just call ntfs_attr_read_block() here, in fact we only need this wrapper
- * because of the difference in function parameters.
- */
-int ntfs_mst_readpage(struct file *file, struct page *page)
-{
-	if (unlikely(!PageLocked(page)))
-		PAGE_BUG(page);
-
-	return ntfs_attr_read_block(page);
-}
-
-/**
  * end_buffer_read_mftbmp_async -
  *
  * Async io completion handler for accessing mft bitmap. Adapted from
@@ -473,7 +459,7 @@
 /**
  * ntfs_mftbmp_readpage -
  *
- * Readpage for accessing mft bitmap. Adapted from ntfs_mst_readpage().
+ * Readpage for accessing mft bitmap.
  */
 static int ntfs_mftbmp_readpage(ntfs_volume *vol, struct page *page)
 {
@@ -587,11 +573,11 @@
 }
 
 /**
- * ntfs_file_aops - address space operations for accessing normal file data
+ * ntfs_aops - general address space operations for inodes and attributes
  */
-struct address_space_operations ntfs_file_aops = {
+struct address_space_operations ntfs_aops = {
 	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	ntfs_file_readpage,	/* Fill page with data. */
+	readpage:	ntfs_readpage,		/* Fill page with data. */
 	sync_page:	block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
 	prepare_write:	NULL,			/* . */
@@ -607,23 +593,6 @@
 	writepage:	NULL,			/* Write dirty page to disk. */
 	readpage:	(readpage_t*)ntfs_mftbmp_readpage, /* Fill page with
 							      data. */
-	sync_page:	block_sync_page,	/* Currently, just unplugs the
-						   disk request queue. */
-	prepare_write:	NULL,			/* . */
-	commit_write:	NULL,			/* . */
-};
-
-/**
- * ntfs_dir_aops -
- *
- * Address space operations for accessing normal directory data (i.e. index
- * allocation attribute). We can't just use the same operations as for files
- * because 1) the attribute is different and even more importantly 2) the index
- * records have to be multi sector transfer deprotected (i.e. fixed-up).
- */
-struct address_space_operations ntfs_dir_aops = {
-	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	ntfs_mst_readpage,	/* Fill page with data. */
 	sync_page:	block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
 	prepare_write:	NULL,			/* . */
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/attrib.c	Mon Jul  8 18:41:18 2002
@@ -935,78 +935,51 @@
  */
 int map_run_list(ntfs_inode *ni, VCN vcn)
 {
+	ntfs_inode *base_ni;
 	attr_search_context *ctx;
 	MFT_RECORD *mrec;
-	const uchar_t *name;
-	u32 name_len;
-	ATTR_TYPES at;
 	int err = 0;
 	
 	ntfs_debug("Mapping run list part containing vcn 0x%Lx.",
 			(long long)vcn);
 
-	/* Map, pin and lock the mft record for reading. */
-	mrec = map_mft_record(READ, ni);
+	if (!NInoAttr(ni))
+		base_ni = ni;
+	else
+		base_ni = ni->_INE(base_ntfs_ino);
+
+	mrec = map_mft_record(READ, base_ni);
 	if (IS_ERR(mrec))
 		return PTR_ERR(mrec);
-
-	ctx = get_attr_search_ctx(ni, mrec);
+	ctx = get_attr_search_ctx(base_ni, mrec);
 	if (!ctx) {
 		err = -ENOMEM;
-		goto unm_err_out;
-	}
-
-	/* The attribute type is determined from the inode type. */
-	if (S_ISDIR(VFS_I(ni)->i_mode)) {
-		at = AT_INDEX_ALLOCATION;
-		name = I30;
-		name_len = 4;
-	} else {
-		at = AT_DATA;
-		name = NULL;
-		name_len = 0;
+		goto err_out;
 	}
-
-	/* Find the attribute in the mft record. */
-	if (!lookup_attr(at, name, name_len, CASE_SENSITIVE, vcn, NULL, 0,
-			ctx)) {
+	if (!lookup_attr(ni->type, ni->name, ni->name_len, IGNORE_CASE, vcn,
+			NULL, 0, ctx)) {
 		put_attr_search_ctx(ctx);
 		err = -ENOENT;
-		goto unm_err_out;
+		goto err_out;
 	}
 
-	/* Lock the run list. */
 	down_write(&ni->run_list.lock);
-
 	/* Make sure someone else didn't do the work while we were spinning. */
 	if (likely(vcn_to_lcn(ni->run_list.rl, vcn) <= LCN_RL_NOT_MAPPED)) {
 		run_list_element *rl;
 
-		/* Decode the run list. */
 		rl = decompress_mapping_pairs(ni->vol, ctx->attr,
 				ni->run_list.rl);
-
-		/* Flag any errors or set the run list if successful. */
 		if (unlikely(IS_ERR(rl)))
 			err = PTR_ERR(rl);
 		else
 			ni->run_list.rl = rl;
 	}
-
-	/* Unlock the run list. */
 	up_write(&ni->run_list.lock);
 	
 	put_attr_search_ctx(ctx);
-
-	/* Unlock, unpin and release the mft record. */
-	unmap_mft_record(READ, ni);
-
-	/* If an error occured, return it. */
-	ntfs_debug("Done.");
-	return err;
-
-unm_err_out:
-	unmap_mft_record(READ, ni);
+err_out:
+	unmap_mft_record(READ, base_ni);
 	return err;
 }
 
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/compress.c	Mon Jul  8 18:41:18 2002
@@ -462,6 +462,11 @@
 
 	ntfs_debug("Entering, page->index = 0x%lx, cb_size = 0x%x, nr_pages = "
 			"%i.", index, cb_size, nr_pages);
+	/*
+	 * Bad things happen if we get here for anything that is not an
+	 * unnamed $DATA attribute.
+	 */
+	BUG_ON(ni->type != AT_DATA || ni->name_len);
 
 	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_NOFS);
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/inode.c	Mon Jul  8 18:41:18 2002
@@ -35,7 +35,7 @@
  * @type:	attribute type (see layout.h)
  *
  * This structure exists only to provide a small structure for the
- * ntfs_iget()/ntfs_test_inode()/ntfs_init_locked_inode() mechanism.
+ * ntfs_{attr_}iget()/ntfs_test_inode()/ntfs_init_locked_inode() mechanism.
  *
  * NOTE: Elements are ordered by size to make the structure as compact as
  * possible on all architectures.
@@ -112,14 +112,21 @@
 	ntfs_inode *ni = NTFS_I(vi);
 
 	vi->i_ino = na->mft_no;
+
 	ni->type = na->type;
+	if (na->type == AT_INDEX_ALLOCATION)
+		NInoSetMstProtected(ni);
+
 	ni->name = na->name;
 	ni->name_len = na->name_len;
+
 	/* If initializing a normal inode, we are done. */
 	if (likely(na->type == AT_UNUSED))
 		return 0;
+
 	/* It is a fake inode. */
 	NInoSetAttr(ni);
+
 	/*
 	 * We have I30 global constant as an optimization as it is the name
 	 * in >99.9% of named attributes! The other <0.1% incur a GFP_ATOMIC
@@ -143,6 +150,7 @@
 typedef int (*test_t)(struct inode *, void *);
 typedef int (*set_t)(struct inode *, void *);
 static void ntfs_read_locked_inode(struct inode *vi);
+static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
 
 /**
  * ntfs_iget - obtain a struct inode corresponding to a specific normal inode
@@ -197,6 +205,62 @@
 	return vi;
 }
 
+/**
+ * ntfs_attr_iget - obtain a struct inode corresponding to an attribute
+ * @base_vi:	vfs base inode containing the attribute
+ * @type:	attribute type
+ * @name:	Unicode name of the attribute (NULL if unnamed)
+ * @name_len:	length of @name in Unicode characters (0 if unnamed)
+ *
+ * Obtain the (fake) struct inode corresponding to the attribute specified by
+ * @type, @name, and @name_len, which is present in the base mft record
+ * specified by the vfs inode @base_vi.
+ *
+ * If the attribute inode is in the cache, it is just returned with an
+ * increased reference count. Otherwise, a new struct inode is allocated and
+ * initialized, and finally ntfs_read_locked_attr_inode() is called to read the
+ * attribute and fill in the inode structure.
+ *
+ * Return the struct inode of the attribute inode on success. Check the return
+ * value with IS_ERR() and if true, the function failed and the error code is
+ * obtained from PTR_ERR().
+ */
+struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPES type,
+		uchar_t *name, u32 name_len)
+{
+	struct inode *vi;
+	ntfs_attr na;
+	int err;
+
+	na.mft_no = base_vi->i_ino;
+	na.type = type;
+	na.name = name;
+	na.name_len = name_len;
+
+	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
+			(set_t)ntfs_init_locked_inode, &na);
+	if (!vi)
+		return ERR_PTR(-ENOMEM);
+
+	err = 0;
+
+	/* If this is a freshly allocated inode, need to read it now. */
+	if (vi->i_state & I_NEW) {
+		err = ntfs_read_locked_attr_inode(base_vi, vi);
+		unlock_new_inode(vi);
+	}
+	/*
+	 * There is no point in keeping bad attribute inodes around. This also
+	 * simplifies things in that we never need to check for bad attribute
+	 * inodes elsewhere.
+	 */
+	if (err) {
+		iput(vi);
+		vi = ERR_PTR(-EIO);
+	}
+	return vi;
+}
+
 struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 {
 	ntfs_inode *ni;
@@ -685,9 +749,8 @@
 			goto put_unm_err_out;
 		}
 		if (ir->type != AT_FILE_NAME) {
-			ntfs_error(vi->i_sb, __FUNCTION__ "(): Indexed "
-					"attribute is not $FILE_NAME. Not "
-					"allowed.");
+			ntfs_error(vi->i_sb, "Indexed attribute is not "
+					"$FILE_NAME. Not allowed.");
 			goto put_unm_err_out;
 		}
 		if (ir->collation_rule != COLLATION_FILE_NAME) {
@@ -856,7 +919,7 @@
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_dir_inode_ops;
 		vi->i_fop = &ntfs_dir_ops;
-		vi->i_mapping->a_ops = &ntfs_dir_aops;
+		vi->i_mapping->a_ops = &ntfs_aops;
 	} else {
 		/* It is a file. */
 		reinit_attr_search_ctx(ctx);
@@ -995,7 +1058,7 @@
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_file_inode_ops;
 		vi->i_fop = &ntfs_file_ops;
-		vi->i_mapping->a_ops = &ntfs_file_aops;
+		vi->i_mapping->a_ops = &ntfs_aops;
 	}
 	/*
 	 * The number of 512-byte blocks used on disk (for stat). This is in so
@@ -1034,6 +1097,245 @@
 }
 
 /**
+ * ntfs_read_locked_attr_inode - read an attribute inode from its base inode
+ * @base_vi:	base inode
+ * @vi:		attribute inode to read
+ *
+ * ntfs_read_locked_attr_inode() is called from the ntfs_attr_iget() to read
+ * the attribute inode described by @vi into memory from the base mft record
+ * described by @base_ni.
+ *
+ * ntfs_read_locked_attr_inode() maps, pins and locks the base inode for
+ * reading and looks up the attribute described by @vi before setting up the
+ * necessary fields in @vi as well as initializing the ntfs inode.
+ *
+ * Q: What locks are held when the function is called?
+ * A: i_state has I_LOCK set, hence the inode is locked, also
+ *    i_count is set to 1, so it is not going to go away
+ */
+static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
+{
+	ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	ntfs_inode *ni, *base_ni;
+	MFT_RECORD *m;
+	attr_search_context *ctx;
+	int err = 0;
+
+	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
+
+	ntfs_init_big_inode(vi);
+
+	ni	= NTFS_I(vi);
+	base_ni = NTFS_I(base_vi);
+
+	/* Just mirror the values from the base inode. */
+	vi->i_blksize	= base_vi->i_blksize;
+	vi->i_version	= base_vi->i_version;
+	vi->i_uid	= base_vi->i_uid;
+	vi->i_gid	= base_vi->i_gid;
+	vi->i_nlink	= base_vi->i_nlink;
+	vi->i_mtime	= base_vi->i_mtime;
+	vi->i_ctime	= base_vi->i_ctime;
+	vi->i_atime	= base_vi->i_atime;
+	ni->seq_no	= base_ni->seq_no;
+
+	/* Set inode type to zero but preserve permissions. */
+	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
+
+	m = map_mft_record(READ, base_ni);
+	if (IS_ERR(m)) {
+		err = PTR_ERR(m);
+		goto err_out;
+	}
+	ctx = get_attr_search_ctx(base_ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
+
+	/* Find the attribute. */
+	if (!lookup_attr(ni->type, ni->name, ni->name_len, IGNORE_CASE, 0,
+			NULL, 0, ctx))
+		goto unm_err_out;
+
+	if (!ctx->attr->non_resident) {
+		if (NInoMstProtected(ni) || ctx->attr->flags) {
+			ntfs_error(vi->i_sb, "Found mst protected attribute "
+					"or attribute with non-zero flags but "
+					"the attribute is resident (mft_no "
+					"0x%lx, type 0x%x, name_len %i). "
+					"Please report you saw this message "
+					"to linux-ntfs-dev@lists.sf.net",
+					vi->i_ino, ni->type, ni->name_len);
+			goto unm_err_out;
+		}
+		/*
+		 * Resident attribute. Make all sizes equal for simplicity in
+		 * read code paths.
+		 */
+		vi->i_size = ni->initialized_size = ni->allocated_size =
+			le32_to_cpu(ctx->attr->_ARA(value_length));
+	} else {
+		NInoSetNonResident(ni);
+		if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
+			if (NInoMstProtected(ni)) {
+				ntfs_error(vi->i_sb, "Found mst protected "
+						"attribute but the attribute "
+						"is compressed (mft_no 0x%lx, "
+						"type 0x%x, name_len %i). "
+						"Please report you saw this "
+						"message to linux-ntfs-dev@"
+						"lists.sf.net", vi->i_ino,
+						ni->type, ni->name_len);
+				goto unm_err_out;
+			}
+			NInoSetCompressed(ni);
+			if ((ni->type != AT_DATA) || (ni->type == AT_DATA &&
+					ni->name_len)) {
+				ntfs_error(vi->i_sb, "Found compressed non-"
+						"data or named data attribute "
+						"(mft_no 0x%lx, type 0x%x, "
+						"name_len %i). Please report "
+						"you saw this message to "
+						"linux-ntfs-dev@lists.sf.net",
+						vi->i_ino, ni->type,
+						ni->name_len);
+				goto unm_err_out;
+			}
+			if (vol->cluster_size > 4096) {
+				ntfs_error(vi->i_sb, "Found "
+					"compressed attribute but "
+					"compression is disabled due "
+					"to cluster size (%i) > 4kiB.",
+					vol->cluster_size);
+				goto unm_err_out;
+			}
+			if ((ctx->attr->flags & ATTR_COMPRESSION_MASK)
+					!= ATTR_IS_COMPRESSED) {
+				ntfs_error(vi->i_sb, "Found unknown "
+						"compression method or "
+						"corrupt file.");
+				goto unm_err_out;
+			}
+			ni->_ICF(compression_block_clusters) = 1U <<
+					ctx->attr->_ANR(compression_unit);
+			if (ctx->attr->_ANR(compression_unit) != 4) {
+				ntfs_error(vi->i_sb, "Found "
+					"nonstandard compression unit "
+					"(%u instead of 4). Cannot "
+					"handle this. This might "
+					"indicate corruption so you "
+					"should run chkdsk.",
+				     ctx->attr->_ANR(compression_unit));
+				err = -EOPNOTSUPP;
+				goto unm_err_out;
+			}
+			ni->_ICF(compression_block_size) = 1U << (
+					ctx->attr->_ANR(
+					compression_unit) +
+					vol->cluster_size_bits);
+			ni->_ICF(compression_block_size_bits) = ffs(
+				ni->_ICF(compression_block_size)) - 1;
+		}
+		if (ctx->attr->flags & ATTR_IS_ENCRYPTED) {
+			if (ctx->attr->flags & ATTR_COMPRESSION_MASK) {
+				ntfs_error(vi->i_sb, "Found encrypted "
+						"and compressed data.");
+				goto unm_err_out;
+			}
+			if (NInoMstProtected(ni)) {
+				ntfs_error(vi->i_sb, "Found mst protected "
+						"attribute but the attribute "
+						"is encrypted (mft_no 0x%lx, "
+						"type 0x%x, name_len %i). "
+						"Please report you saw this "
+						"message to linux-ntfs-dev@"
+						"lists.sf.net", vi->i_ino,
+						ni->type, ni->name_len);
+				goto unm_err_out;
+			}
+			NInoSetEncrypted(ni);
+		}
+		if (ctx->attr->flags & ATTR_IS_SPARSE) {
+			if (NInoMstProtected(ni)) {
+				ntfs_error(vi->i_sb, "Found mst protected "
+						"attribute but the attribute "
+						"is sparse (mft_no 0x%lx, "
+						"type 0x%x, name_len %i). "
+						"Please report you saw this "
+						"message to linux-ntfs-dev@"
+						"lists.sf.net", vi->i_ino,
+						ni->type, ni->name_len);
+				goto unm_err_out;
+			}
+			NInoSetSparse(ni);
+		}
+		if (ctx->attr->_ANR(lowest_vcn)) {
+			ntfs_error(vi->i_sb, "First extent of attribute has "
+					"non-zero lowest_vcn. Inode is "
+					"corrupt. You should run chkdsk.");
+			goto unm_err_out;
+		}
+		/* Setup all the sizes. */
+		vi->i_size = sle64_to_cpu(ctx->attr->_ANR(data_size));
+		ni->initialized_size = sle64_to_cpu(
+				ctx->attr->_ANR(initialized_size));
+		ni->allocated_size = sle64_to_cpu(
+				ctx->attr->_ANR(allocated_size));
+		if (NInoCompressed(ni)) {
+			ni->_ICF(compressed_size) = sle64_to_cpu(
+				ctx->attr->_ANR(compressed_size));
+			if (vi->i_size != ni->initialized_size)
+				ntfs_warning(vi->i_sb, "Compressed attribute "
+						"with data_size unequal to "
+						"initialized size found. This "
+						"will probably cause problems "
+						"when trying to access the "
+						"file. Please notify "
+						"linux-ntfs-dev@ lists.sf.net "
+						"that you saw this message.");
+		}
+	}
+
+	/* Setup the operations for this attribute inode. */
+	vi->i_op = NULL;
+	vi->i_fop = NULL;
+	vi->i_mapping->a_ops = &ntfs_aops;
+
+	if (!NInoCompressed(ni))
+		vi->i_blocks = ni->allocated_size >> 9;
+	else
+		vi->i_blocks = ni->_ICF(compressed_size) >> 9;
+
+	/*
+	 * Make sure the base inode doesn't go away and attach it to the
+	 * attribute inode.
+	 */
+	igrab(base_vi);
+	ni->_INE(base_ntfs_ino) = base_ni;
+	ni->nr_extents = -1;
+
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(READ, ni);
+
+	ntfs_debug("Done.");
+	return 0;
+
+unm_err_out:
+	if (!err)
+		err = -EIO;
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	unmap_mft_record(READ, base_ni);
+err_out:
+	ntfs_error(vi->i_sb, "Failed with error code %i while reading "
+			"attribute inode (mft_no 0x%lx, type 0x%x, name_len "
+			"%i.", -err, vi->i_ino, ni->type, ni->name_len);
+	make_bad_inode(vi);
+	return err;
+}
+
+/**
  * ntfs_read_inode_mount - special read_inode for mount time use only
  * @vi:		inode to read
  *
@@ -1590,6 +1892,13 @@
 		if (ni->_IDM(bmp_rl).rl)
 			ntfs_free(ni->_IDM(bmp_rl).rl);
 		up_write(&ni->_IDM(bmp_rl).lock);
+	} else if (NInoAttr(ni)) {
+		/* Release the base inode if we are holding it. */
+		if (ni->nr_extents == -1) {
+			iput(VFS_I(ni->_INE(base_ntfs_ino)));
+			ni->nr_extents = 0;
+			ni->_INE(base_ntfs_ino) = NULL;
+		}
 	}
 	return;
 }
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/mft.c	Mon Jul  8 18:41:18 2002
@@ -95,8 +95,10 @@
 	return 0;
 }
 
-/* From fs/ntfs/aops.c */
-extern int ntfs_mst_readpage(struct file *, struct page *);
+/**
+ * From fs/ntfs/aops.c
+ */
+extern int ntfs_readpage(struct file *, struct page *);
 
 /**
  * ntfs_mft_aops - address space operations for access to $MFT
@@ -106,7 +108,7 @@
  */
 struct address_space_operations ntfs_mft_aops = {
 	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	ntfs_mst_readpage,	/* Fill page with data. */
+	readpage:	ntfs_readpage,		/* Fill page with data. */
 	sync_page:	block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
 	prepare_write:	NULL,			/* . */
@@ -214,11 +216,11 @@
  * necessary, increments the use count on the page so that it cannot disappear
  * under us and returns a reference to the page cache page).
  *
- * If read_cache_page() invokes ntfs_mst_readpage() to load the page from disk,
- * it sets PG_locked and clears PG_uptodate on the page. Once I/O has
- * completed and the post-read mst fixups on each mft record in the page have
- * been performed, the page gets PG_uptodate set and PG_locked cleared (this is
- * done in our asynchronous I/O completion handler end_buffer_read_mft_async()).
+ * If read_cache_page() invokes ntfs_readpage() to load the page from disk, it
+ * sets PG_locked and clears PG_uptodate on the page. Once I/O has completed
+ * and the post-read mst fixups on each mft record in the page have been
+ * performed, the page gets PG_uptodate set and PG_locked cleared (this is done
+ * in our asynchronous I/O completion handler end_buffer_read_mft_async()).
  * ntfs_map_page() waits for PG_locked to become clear and checks if
  * PG_uptodate is set and returns an error code if not. This provides
  * sufficient protection against races when reading/using the page.
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/ntfs.h	Mon Jul  8 18:41:18 2002
@@ -62,18 +62,21 @@
 extern kmem_cache_t *ntfs_attr_ctx_cache;
 
 /* The various operations structs defined throughout the driver files. */
-extern struct super_operations ntfs_mount_sops;
 extern struct super_operations ntfs_sops;
-extern struct file_operations ntfs_file_ops;
+extern struct super_operations ntfs_mount_sops;
+
+extern struct address_space_operations ntfs_aops;
+extern struct address_space_operations ntfs_mft_aops;
+extern struct address_space_operations ntfs_mftbmp_aops;
+
+extern struct  file_operations ntfs_file_ops;
 extern struct inode_operations ntfs_file_inode_ops;
-extern struct address_space_operations ntfs_file_aops;
-extern struct file_operations ntfs_dir_ops;
+
+extern struct  file_operations ntfs_dir_ops;
 extern struct inode_operations ntfs_dir_inode_ops;
-extern struct address_space_operations ntfs_dir_aops;
-extern struct file_operations ntfs_empty_file_ops;
+
+extern struct  file_operations ntfs_empty_file_ops;
 extern struct inode_operations ntfs_empty_inode_ops;
-extern struct address_space_operations ntfs_mft_aops;
-extern struct address_space_operations ntfs_mftbmp_aops;
 
 /* Generic macro to convert pointers to values for comparison purposes. */
 #ifndef p2n
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/super.c	Mon Jul  8 18:41:18 2002
@@ -135,6 +135,7 @@
 	}
 	if (!opt || !*opt)
 		goto no_mount_options;
+	ntfs_debug("Entering with mount options string: %s", opt);
 	while ((p = strsep(&opt, ","))) {
 		if ((v = strchr(p, '=')))
 			*v++ = '\0';
@@ -217,7 +218,7 @@
 		}
 	}
 	if (nls_map) {
-		if (vol->nls_map) {
+		if (vol->nls_map && vol->nls_map != nls_map) {
 			ntfs_error(vol->sb, "Cannot change NLS character set "
 					"on remount.");
 			return FALSE;
@@ -249,8 +250,8 @@
 			mft_zone_multiplier = 1;
 		}
 		vol->mft_zone_multiplier = mft_zone_multiplier;
-	} if (!vol->mft_zone_multiplier)
-		/* Not specified and it is the first mount, so set default. */
+	}
+	if (!vol->mft_zone_multiplier)
 		vol->mft_zone_multiplier = 1;
 	if (on_errors != -1)
 		vol->on_errors = on_errors;
@@ -304,7 +305,7 @@
 {
 	ntfs_volume *vol = NTFS_SB(sb);
 
-	ntfs_debug("Entering.");
+	ntfs_debug("Entering with remount options string: %s", opt);
 
 	// FIXME/TODO: If left like this we will have problems with rw->ro and
 	// ro->rw, as well as with sync->async and vice versa remounts.
@@ -1799,7 +1800,7 @@
 #ifdef MODULE
 			" MODULE"
 #endif
-			"]. Copyright (c) 2001,2002 Anton Altaparmakov.\n");
+			"].\n");
 
 	ntfs_debug("Debug messages are enabled.");
 
@@ -1899,7 +1900,7 @@
 }
 
 MODULE_AUTHOR("Anton Altaparmakov <aia21@cantab.net>");
-MODULE_DESCRIPTION("NTFS 1.2/3.x driver");
+MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2002 Anton Altaparmakov");
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
 MODULE_PARM(debug_msgs, "i");
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Mon Jul  8 18:41:18 2002
+++ b/fs/ntfs/volume.h	Mon Jul  8 18:41:18 2002
@@ -27,31 +27,6 @@
 #include "types.h"
 
 /*
- * Defined bits for the flags field in the ntfs_volume structure.
- */
-typedef enum {
-	NV_ShowSystemFiles,	/* 1: Return system files in ntfs_readdir(). */
-	NV_CaseSensitive,	/* 1: Treat file names as case sensitive and
-				      create filenames in the POSIX namespace.
-				      Otherwise be case insensitive and create
-				      file names in WIN32 namespace. */
-} ntfs_volume_flags;
-
-#define NVolShowSystemFiles(n_vol)	test_bit(NV_ShowSystemFiles,	\
-							&(n_vol)->flags)
-#define NVolSetShowSystemFiles(n_vol)	set_bit(NV_ShowSystemFiles,	\
-							&(n_vol)->flags)
-#define NVolClearShowSystemFiles(n_vol)	clear_bit(NV_ShowSystemFiles,	\
-							&(n_vol)->flags)
-
-#define NVolCaseSensitive(n_vol)	test_bit(NV_CaseSensitive,	\
-							&(n_vol)->flags)
-#define NVolSetCaseSensitive(n_vol)	set_bit(NV_CaseSensitive,	\
-							&(n_vol)->flags)
-#define NVolClearCaseSensitive(n_vol)	clear_bit(NV_CaseSensitive,	\
-							&(n_vol)->flags)
-
-/*
  * The NTFS in memory super block structure.
  */
 typedef struct {
@@ -123,6 +98,39 @@
 					   only, otherwise NULL). */
 	struct nls_table *nls_map;
 } ntfs_volume;
+
+/*
+ * Defined bits for the flags field in the ntfs_volume structure.
+ */
+typedef enum {
+	NV_ShowSystemFiles,	/* 1: Return system files in ntfs_readdir(). */
+	NV_CaseSensitive,	/* 1: Treat file names as case sensitive and
+				      create filenames in the POSIX namespace.
+				      Otherwise be case insensitive and create
+				      file names in WIN32 namespace. */
+} ntfs_volume_flags;
+
+/*
+ * Macro tricks to expand the NVolFoo(), NVolSetFoo(), and NVolClearFoo()
+ * functions.
+ */
+#define NVOL_FNS(flag)					\
+static inline int NVol##flag(ntfs_volume *vol)		\
+{							\
+	return test_bit(NV_##flag, &(vol)->flags);	\
+}							\
+static inline void NVolSet##flag(ntfs_volume *vol)	\
+{							\
+	set_bit(NV_##flag, &(vol)->flags);		\
+}							\
+static inline void NVolClear##flag(ntfs_volume *vol)	\
+{							\
+	clear_bit(NV_##flag, &(vol)->flags);		\
+}
+
+/* Emit the ntfs volume bitops functions. */
+NVOL_FNS(ShowSystemFiles)
+NVOL_FNS(CaseSensitive)
 
 #endif /* _LINUX_NTFS_VOLUME_H */
 

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020708174011|11655
aia21@cantab.net|ChangeSet|20020706233736|11639
aia21@cantab.net|ChangeSet|20020705235849|62477
aia21@cantab.net|ChangeSet|20020705200106|53559
aia21@cantab.net|ChangeSet|20020705120813|47863
aia21@cantab.net|ChangeSet|20020704223115|00790
## Wrapped with gzip_uu ##


begin 664 bkpatch634
M'XL(`+[.*3T``]0\:7/;1I:?P5_1\<RX)`]%X09!E[V2=60XMB2O+,_,5KF*
M!0)-$B,28'#H2.C][?O>ZP9`@*0B2O+41DD19*/[];NO[N1/K'_<4[(XN?&F
M07K@99-I''6RQ(O2&<^\CA_/%D<3+QKS+SQ;Z*JJPS^6YABJ92\T6S6=A:\%
MFN:9&@]4W>S:9NM/[&O*DY[BA9ZNP:^_Q6G64WPORKQA)^(9#%W&,0SMYVFR
MGR;^?A:-6S#ZV<O\";OA2=I3M(Y1CF3W<]Y3+D]^_OKI\++5>O>.E2BQ=^]:
M+XO]W[T93SL?XBR+9U-^?Y!FG,.3KP/FJ*;FFJKF+E355NW6,=,Z`+6C=_0N
M4_5]U=E73:8;/4/K:=9?5:VGJHS8<E"Q@_U597MJZP-[63J.6CX[X\F8LVJK
M7LGQX?4TC/*[/;UCL3#*XK634"SA"KZK3#!TS;)T8P%X`!,^,L=56V=;K_M<
M2;6UM^5?J]7Z_>U,73<TS0)9(8)+LG(+65E,,WIJMZ<9?U!9E6A-XAE_&"E'
MM53+,/3NPK)-W7G"8LLTU87IV(X+,C>=KFV`U)\!Y)D*L-W.6E>SD';#LERA
M"YI9J8$.TH=_[3^H&FQK"X]986FZVM6,A1#T1R8X]Q@SKZ_\X69NP5-3[9IH
MK4*T-E/5GM7MF>X?5+3CA(\/KI/8FVQ0;%W5NI8&1JUUG4?-UPR(8J`(&@CG
M<?,UPUG8IFOKCYQO:#!?TVT+YL?)O[VH,TK"(7#CP+L+T\WKNIJ]L'65UFUG
MW:#<NF["8D?M/F6Q85I`H>:8L/B:9QF/PO1@'.6=.!FO70'$`8V@`<CS&R\*
MDOB&']SX'?\FSSK^K^L7.9H&.&J.]@0<===R8;'I.&",XKFM]ZT!^0_8I6%U
MS6([89=V89<.VJ7A](P_JLO=BO-@FX9+^FEVT?L.)UX"2X?A>!Y'`8+O>/G:
M9::.MJ?9MKW-,E?5P93`*9JHT+?A='I_$/!A"):X5J%IA67""M-UMR?.-;JJ
ML=#`H6!F()Y;ZF8=R`_735LW#,>PY79"-YU"-[M,@X"A]C1MHVYJVH]2SO.K
MTR\]IG?4#@2Q/7;J77-0Q3C@*1MZ*0^8EV7@3/,,AO=C=A-Z+)MP-O?&W/?\
M"6^S47C'TS;SI]R+\GG:`:``)[QC*>H!&^9C`,A&Z7Z4P4>:SWG2\7N]N9>D
M?!#/LS".TIU==CL)H12[]5(P@CP-0>E]QEC"9W$>92E0SD9>.(5I/)(8)%F(
MB]G$`RPCQJ,LN<>M]GGF[X]28!X,!P0&%XCWZ9S[X2@$PG`LFJ;OF,!!X'TX
MGP/.*=1H;.;Y20R?X]!G.7)BB0KB4&="6,FAFWB:S\08;<GOYK`[\Z93VFG"
MIT`X&^613Q2S\W_$T],XWMEMTU>0FOQ5X(RC1\#4A,8%>F?@]9D?S^^3<#S)
M&-"8\1D0QD9)/&-!$D)Q"W@"7[QIF'K$'B@W4Y!6@=<L#O(I9R!@/PF)<K93
MR66WPZXF80ID7X,&(.)U:`*$A#@*,P;+XX@S\&,<,<>Q%#DUQ*B6@"_()B#$
M%":.(-(E$9\*2K[.`\"]Y)[0,M2+F3<?)'DT@!TS4`O@\&V<7.,^PYA@>=.2
M14NZ22I+S!/S1C$P.YP"$3@4A`GWP7A"+O6S/YM/)>=0XYN`4&SQ+2@AR:]N
M`H#1F`RAU"PT!D;60)O!!-"74O)1G,P`YQN@<C8K%0`XFMWW"`1H71`P9,,`
M=QJ$8XZ4(RADIM0<>@_4!X-I[%_S0,Y%='=V"0Y;5D>AH7YG>0?.`U!C::B@
M1@$JA0",@\D`/'T!4>H;A2XO"$"$*=B.YW,P%YYX0H<W,IGM>#&X`G^W3?M'
M\2W[=PY*,/%`?P6E\+X@_Y)'8'`]203^\2@8#//1B">"9*+52^\C'QBS]UZ`
M6)DDWK>7X%1,I1E#9!U`$'\%G.57*XN1/#$#I5RNK2T6;SHE-;=)N*S:Q(E>
MKS']8<U^NFX+%&;H*.)A&D_Y)E1F:5;#GB*I93TS&*J>VGK//GQ<-"U[H;D.
M%DZ::JB8%:KP!QG*T-,"U7;]KMGU_<!:+?=6X,B0VM4<*$6,A6$ZNE/?$F+A
M'!5V_:9=R&],;>0[7<\)'-/3[<V;+D%:V=:&U+^V+7YT)FNVU(U%=Q1T3</G
M]DC5K)$UW+REA-+8SH:<5FYW'/LY>BZRP7W2@_L4PH!<FMUEZZC6%HZEVMQ1
M1SJWA\'06(/"(R!7:)FJZBXL%ZAJR)MT;!T*.@YZ("XMX+;A`1\>D+:`TN""
MU=7UAGI)/[=F/\U<#/W`&'5MW^X&JN\Z^N;]"C!+&[HJ5J&JV=A0&,>G>+R.
M1'L1C.R1ZVG`;#XRG)&Y><L*4(.IIN$:>GW3,PA2*(]U9#J+$?>UH:59FAFH
MQG`U?UP%4V;!AFY!6JK;KJK5=YR-LO5<=1<&'ZF^-M)&H-3.@U(40)JJK)E&
M@Z=%[K1F/T-;C`S;XB-3`V%ZAM-]@*4EG`9]%M3:=GU+F>^LLU9SX7&;J^I0
M-;BGZMVNNWG'`DQC0PUJ?)-.$G[?IO"(X07->K4:>;Q98\/<-+H+4]/!VV"9
MHNO-*D7=W-FR?E214B2+$/=DI9)P2%A2CE%+^*`+MI?<TK\0A3X_@NU/B&U]
MW729U1(H]%K*'OL`Q0W4/YCP8CV#"2/DN;)HD84%1&68V8\@'8:LC_E$/^3(
M109*6689['<P']U=EX:V%+8I$WUT%HHPUB6B'=+5%<\D5?.)KF]5$S>ZOE+Q
M'%<7O1M-M;;0/+W+]K3_O.H)3]U0O14BGZ!IQ[K+--`WE^G=UK?6L\MSTHBJ
M0O^&&OD2);KR(A6Z\L@"77FI^EQY9GFNK%;GRK.+<^79M;GR_-)<>8'*7'EJ
M\:*\4%VN/+LL5UZF*E<V%>7*$VMRY45*<N6!BEQ9+L@5Y7<*<>7A0EQ1UA?@
MBBRAE37UMUS3K+M7EQ1UJ_(B1;?R])I;>7+)O1QTB]R\$7.WROPW1]QFYE\$
M7,S\Q5T%RZG.,#6SIUL/G95H/SC<XAT=<OD?F:A--L38@JRGA-@N1EC\./G7
MU>7AX.CTT^'/7]@[MG>,/?'!/TXNO_0OSM]]>R6B[[=7-7$)N3:$M4WMNUE6
MR[6OK=N:IKJ&L3`<J'Y)4DX],]+5A^Z36#K;ZQH_1%:%+T)ONKT_PD[;!B_4
MV;8C6'C,YW8$"S@UC\0>VQ)<7EVU!"O?]%A?M.J&1+/[D:WMIB=:XWG:@NL8
M#IM(@4BHJ*).RP:K$PKZ%)LS##0Z^F1O'I`9D"&>8<RP!P>$8#*$E..D6LF4
MMHY-LF7ZQ*P+$L*;.`P>THDT2W(_8_+%!%ZP-\-)&T]A63[/8O1"NZUCS;01
MLG@4&%?:`6B"($!H[("2#4BD(,VMVP*E60#.`VB61M#H`="6*`/S"Z9%/K%)
MC5F(M>4O.4@\@-"49_$,B86,YAZ!NP*X6W$!J6DJM*2<\'V#GT"F[JA4;M!#
M491L.-E[/R0\0`#O'L#J+2SN$O?%8YE'M,4:#K$#BG,E8T1^C%XDX#>AS['Z
MT47YHPN0IR#W*([V@*UA@,EA)?SVB@;C?B(]+K?$'^"3(H1L,ATA6_``R$7>
MUUYG^*+>@8PYRY.(^?`RDT:'\RB71LB"*2F"\](T]D.8%@CRRC24F#5)XBC.
MTRF4VX"(PRPP!56#AR1Q+7D75Q=_VT2D('!X3U4'&@7LA\#J7)V-,@#MQTG`
M=@1)7@8OH)(`-8'U6%+$X`ZFX36?4GTV`Q>2W%.R2TPJ.0K%GA=&05$]_,J3
M&-P.E"5YVA;L"+$X3*'N[.]?(.0END%EB4G\!@K$<-3$#29'<282]J!$<1ZC
M$B/H<`90;SFES.0[O3`C[(!S4.W`R)"38$2-`\,<IT,P9$%,FR&7@/6&*KR0
M*MW0)2?YJNB(T]SWT791R'L\2:(81^%+G-!*2ZS$1\VX2"S2M$B[W^!GFZVS
M-D/M"BCX$/DL^7GV)@K;X(:`?8,H!,LR=+1'>(`9J.@VP6^88)_[;^`#$+^(
M0%QYA*$R8'\^/KPZ7-(<(GS(67&$`5/B1*SCD9_<ST%)._1['SY!'#M1N/<>
MKT)#4L,.KP8$[_5K]A..XQZ#*8]VV6_H(/;?L/Y($`HR*N&UP8*C>^81#V60
M0:UBYU=F1VQ$.YWWH_BD6`3[[DJP"C`:,["3PZ.CDR]O:6@<@V1A?!#G&8U\
MEP@<5821O@.KN3<#T8'<A3LE3:B.<)H85``(!=HM$;K0B/,5#Z5S($DB-M\Q
MILF@9I#S7(:PY$[D"IAF,9`AXO`3(G$(`BNVEY)'APOB5_@TY8W1O?>#_OG)
MCAB2BK.+FF((E:*',@.+@NE8KX-]#81][5R>'!ZWF81&BTP*1^+19#2\-=!3
M&J:);_WL#B!""2QRIQ0J4W\R@%&)"R@N[BK`.@*L4X'-H]E@&;3+#)@!<5`7
MK,@CX7QV?IK&\74^IUU*A6RS0@6K;ZB,6"PJ_9_/+RY/!D>'7T[:3&VS\Z^?
M/M$70&Z7%.O8L(2$+*/":)YG@P9670J"XM%XW</7.B'=->%1>Z7`KX=9O03%
M!>@N9"P.)1;B03Y(QDOT9L)^T)^C>QR&&8`'[V.YA*!X%($6<S$(LF,>0<H]
M?3@/+WHHRREFBG!U`5>GS($<EH0S(#B#)3C5IN^0M99KBK6D)84G[-6K]#;9
MZRGF`41C&?G)(H]M#0ARZM65;#HUZZNMSI(?J+`:9\E0#9MXB533=%/66.X6
M-99FLCWSA];#CVR]K50.F,J+`_)-J;SDQ%-.0US#:0:P*G:YI@IV`H\N>A$7
M+-Y^::_W[=&>SH4J&+$0#F`+7^9:8)^XTG;6^4C7=L&9]_%D63JR[?P7JSFO
M&U]XM+H'0RMS'<H[Q&,5"P>]_K%+C@L>EG@@XX]=2G2/-3`0RB'@BPL#6_BN
M9;.L8FG#,+>]<;'9-)LW+FS-A:=IJ`M==S6-C-.TMVF`_*A#26S?>G1V`@DK
MU(*8:P#7,.><>9%HZJ.6R9N]DBXL]JC+2XX^NH<DEZXZ9A/(>&4*[)5)'24V
MI5$+:\9[)QNLN6+>4^S9M$VH12B[A.CRP<,3&$`NA6QJ/A<I.]"&%$UX4B>@
MCGY$`#8DIM@OQ3SLP]>?!Q?G5=+Y4Y5T+A8U,VDHH6RB-S1PJWL@F]6O=@_$
MQ@OTNJ-K"],U7(MTK]NMZY[;4YV-NF?@H9W]@YIO_S^N,,IKL\\]*JG`@*XE
M\3S!(OK1QR(?F;BHL\$LI%"?U+`2>?5R:^,WPON[()(V&$`:E178[,L(%68%
MG?(%5-5X]A^FLP[X80T3IF_XQ8(X*>HOKU9_]<^/3_XU./STZ>+H\*I_<8ZQ
M$F,GZ,E9FGU.XHS[LGQZ*R`Y$B25C?1%EU],:U-3:%46,@-<CN@W85G)RN$;
MW+2ON2ZS[-;^FS=5/EHH`(@S'F8>>$6OOA:B#/@H_"\*R''$U#(KU!/A',@]
M>PHH'$6B<F6$`&6CH[%(_$>\E9[C;WI!G63E:Q22%N&OHB6T=.L"8RXZ..FT
M=LN5Z(!Z"GR,(<^"=32(OKX`"#)-/!!$DK(=M0$"H5P()N!^\F['P]RH(U:=
MA@_O2S+;`@MQ.G5091.R7Y4R#`)<MDVP084LK#HM"&<9+LU!5@N,"O9W)`']
M)K/$M+#L?\F+!B$%`*KY10U<-,$@'@"8,,(&&E;K"1]!_(A\)#Z/L@Z[`"C)
M;8A=(X]%_+;.H5"X,I^Z:K(C51Q\_TJ-4#K;CK`-^K"38=2<FDY%_XA:1;)A
M5A$G@('?D\0)'`1"><(+ILB>$<ZH(;NB67*X["QUV!%E"Z*;AD`0'`2'7-9%
M_2^#D\O+PGT"N"0'ON#TPN_2-0O!"W%O`KM3PD>&U&`3=@<SJ`7X^>I20$3<
M]UMU.VXX[0VV?W@%,*[^Y_/)%S(KS%)SU/M!!A!($W-#9V6\;OW64IKNXFVK
M.@N&F?`3_1"@3GE\Y'4P!8VPV2QWW7L?HMS>TDOA%FES,4!6^(ZVK`9P<SF(
M7PGR#9802)LE-6)G"7XZA(2\V+K-=LB/9[L-GTY)^4[*RU<KSKW-7D<>]H.H
M!`#?6/6!@/,#D,#.WLGYQ=G)F2A;1)M+I>_[TL+0GD#3068\G8`F5SHOMRCZ
MGJ+%F=%)#652N*FD!Z^<L->L/S@_^:?HJ8FM'C*+4LKDTT&R$<X9@!W*"6+\
M>YD97E'Z1\E>U9Z]YGR.'FSHK5:AS$O`T`-Y?<6;IC'!2?$*'#JAM$@TR>8@
MD:0N+]Z6*6@6&39FG#7X!$;N@77C+6)6))C(%J!>L"&<YYDD1*A$)9?^A21/
M2@QU]3M(YMB&7,]H]6U7Q>I.WDL@8]NIU.=5/PKX7?TBEDB#7U%#47GUY]/^
MIY/!^>'928>=8WJ,>1D/.J^PP.R*4QOQ0-00+E1DR,N]]]Y`-%I>EUT7+/=<
MRDG$XU%+H.HS;*8;;OT(:T45(&23<BT'9&G!Y$DPF:O"<3U4-\9Q2&D"D<HK
M7>AC775YCK&28%;PUCI=<8UJ*&(<8"0*,7&V44%=$QSK"V4IW'D4VB"'M,U`
M%*+-AE/2:AO)RSA!0.5!)LV+81YDNG4Z5BB0QQK@B^C:J%A`6'$,+AX2%O*I
M.)O"!5X*QH3Y?UK%S")_0DH$2@5M_]UC_T3[$VA3(QV`53?ZR@A42N>_<-EA
MCQ6^9P(;]0>0LGY$)-NP'N-\%4AAH6!;6_@!6`U_X8`R`3HOXG24HT'"&<N4
M`HUI',OT".H6[]:[EZ'L11-:#%L$1UP5A+%X"I9$MT&^?"AM?O?M0X<VRMGI
MU>#RY.CB\IB]F<'O6H\)$EA^!T'3S^ZJ"%B&`H(:\&$^WGEU@O>%D69JW.)>
M3+W[R_2N\PH=M0R.N]4RBDE54703RG>A(BGH2_=7-=;DL&3(;A&-_HX9W"RD
MI((R0\Q-TH;!"+4A/RNP&4ZO4TC'E%K\EH-OBTGR6D]]DAPL)^5A4)\``^7+
M<?/E>.EE-`VCZ_IK&BHGS/`0L3Z!ALH)_NH$OS;!6YW@R0G8LDCY+Y!)%.^K
MD8*W7WBA<)31@#[C$2H#8Q<Y>W(#I3A/9B$UBM)E!L]@50-UA/.:_2\(\?3L
M2O1#?[\92G%1)IFSW>4DH4@49Q0E&^=NWQ_7-RV3(.Q=+L&6Z<_;M0="RG?)
MGM-0IK15MZ@,Y<_IK*IK^JIK,?E680^A%'8"D'$T*`[F92XASP^;53CVK986
MCJ;>.)4'F^M3AU/,BM@L1>%+.$O.O\@?L,U6#E*)@%<A2&]H"]*>8G(C#J;5
MG8(=F6`7,\F;M(4>PO>[=IDWL[^$NYURWF>Z[0YPYG&2L?LX9ZEW*_+5XK)Q
MN7G,Q/_/`,G="_C-`9Y7I)UTA.VP5VTQK?1>0F1U,<I^G[)63>CHMSC\OERY
M+-%A9]0(@W"'7@=2PE]R;TH.5*2:?ICA]0:QGC(=*IKF7C9)JZ-P*2"`(`\?
MEHK-Y>$R0?^_[J[UIVTDB'^&OV*/BKM$UX0X`5)*B\0%.$4%$I'2NTJ<K(0X
MQ2*Q(S]XW+7_^^W,[*YW'3MV4J%*_5)*LN^=F9W';P;Q(2QZZK2:=N3;M_.X
MHI&"?7QU7$$Y:I,GH8HJ)^JL2"#"KW/I>W);Y-8A8DL3%6=ZM,@ZO8O^U>D`
M8(KVQ?'@@R"V//J40?;RQ"@N=F,K(2D@-I/(5"-0"I*8O*0W06>J51'!+:4X
MU2;!S:=)3C4Q:2]Y-`49;BPCODSJ(^2!N"H3/'`HSSW+GXV"(0==L:F6HA90
MYIJT<P9AH/:,\0(`2V5$#Y+#2UV-=B.JB7DUYHVH1IG"(/*9=@6%TB!3'&@W
M5/I>T`KVI[6CVRE78)R`N/*([38.]LL<J11BVM&:5)]N(/3@L1L.1V"GC&-#
M$HIEH"AB%7Z,L)9[]X^ZDH/IQ9;:8GEA0+,@&?*O^8LO6YR>E#F/V+OW_$<O
MN4Q]WS,GNO,!4*1_'03QG-!/:-LNWPM%=3MG%6U8@LK8XDSXV_F>6=?LW3N:
MPI"GEU=&QYB+Z(0)"UL"<^ZN0A2<R;BQX8V'P=B(Y,%HJE%E.^:O"U\Z?UC\
M"9^@SCI#3W<%$"P)^47F\F"JD/R>JS_N+08^Z#!A"FX&`9_))N&='W.3+(@]
M=GMW/P[O)3TA!+EPY^)>I%+6ZU_V/@ZN^_WON"XD77E5K))]6>+3A8OX/8<7
MN"D3A;38@JFI)9]_,@EIFJ*U5EF-65*=6/:^@I9\V;GZW/^H6&:-YW@I@2GH
MG/;6FO(=<3+%_/0#'_UD#S_YFV]`%DL2T*!_?#4X_?&:68C)G#_[#0UPETNN
M!X41^%_#R'ZX5<I6SL&[`3]TYRD",P.0Z^IDP<VEO0UDC27#UEE7>KL2K0$E
M>IU]AI-;%.)%1@^X#N*YBLBC@5//,%C"J;._FVF"\(V#+!$R$$;.,6Z,(3:S
MI'FZ4S)<VB@J,9C9I:JLG@R(KKBLM'R774M-E^Z4J`W:.?Z2;?E5$RY]'`80
MB-;)I9.E.2K"5Z!'FB'VR#K5U65M.E(;)UK81!L(<)2!/^)JYS-F8COXZ]29
MZ:W09QL\RQ@[P=J!=%03U-2D;L_5%'?RG*NZ,YUO-;$!WN(L,T`0]+?$MT/T
M*S(Q=%0J=DOY[G7'ES\'7^7U^;ERPDT6/UH:_[C1D(>+H&_IJD2?=Z9I?W3$
M#A)D8D;[;&JD;C<J;H;>B3`.G'1`8.P[H?=;)'W;$LDYA&!^)#`!.$+ZE&2D
MZTLP'&E^W(T<R"13?DG1Q@MLDFZPD9J%BP7D<]J_!PZSPURLH.=6%]S7)[XG
M:$!$U=##;<*F\4X@0K>9**3=GG`@PI3\\]57DX&ZSA/O%$9'QM1BZ-LN`"FF
MC@K0(+5OI<X^_9)F/:#4<=L%GSTDD^C/W1+?%^3WVZ/AV`B_BF/$@#FP%&!N
M(-FKR=K*DR2EID+7HKS<`5\9,7F*[@C0AV$>?XI;=:.ZF0^B4PB0B%1D()SZ
M"<,'.;16391W@\H:FDZ?1:""J[G8T#%_6$@HA?A;H4)1/MY/JU`DT7Z-K_O-
M/5G`?7<5&'B#U=Z\)`H<$'#.(](7(KNIDE(.Z`UWM@[D[8`0VX!L%L"N,PC]
MI)(_@4S@5CE-%B1"I9*@(.IM-2A7$7^LF370M#"!KMD4"73=":-<'4`CR<Q<
MUWOPH5A&1NKMU"?X#PU.)3K<\!YP3`B0<CBY]O\4X415/R7`#V6&*.!ZY!!U
MUH-0)Z2]@78H<CL=#"A+I,[<#Z,:.IY!FY^X3S%_JR"_#$2]G@J7#$NIT2/'
M09P0?SGYDSF#\*EJ\$6L5"T*0J@P8[)Z7#G89Q)F,N;BF7!4S(\#(SL1=Y"1
MF9I._P3Q)Q)34Y4,X)_Z78I;Z<-RQ?'RV56,(OBU8;4M0)=#G7_ZXQB[UBK\
M:KTPOSI/8"N1EI.7F$/@52CNE\/'M.5U&'D?$P$P<Z'+_VU+?A7LB%5E%E)[
ML)B/'0J]R>Q1G!1TN%(/)*%U>HUF<Z7:F5U1YBQT$1\">F8?TA^Z;8#TE.L[
M=@/1%;,\NNU6Z:[.;!X]ZY.W(1E#9Q51V2?%*RO5ILMGEE1M.IGDU-AO6U3<
MC3]W*]3\:+\<E'VA%%5AY:F%LE.(9%^Y]%16W2F%B5\H#OU]!9Y$=2<<7JOP
M5%#4*:^BDRH)4::JTP=&!0ES1(P@E'5R1BPM!RR-7,&E&)7P@%WX-V_9=LA5
M8OXA*`/-)A4?:%+Q`17'X<</9AVD(!N_@VU._\7<J";E=C7W@"_!X"0,)O0`
M^?(O/S![%D\C=SYUG0#3KRD_M5&P\E05O\RU6V\:F#LI?H*Z_T_]QD-H']2X
MQ^_HYT7OY/K\U#XY'72NNGT`]%>V`($#119W6O4G23\UUE$45KFM,OAK(S5@
M)G;L19P`CJ?1D),WIQ?_82N5&J-JG)GR9+7RFOD"Q2RO":5IH*KGP=>]-WLM
MRLRR6BL(E%:+U9I[+R125B\49U:$0_Y:J2K<0DFX#XSJCN9PG3S-M=)2^/NU
M!PD>>ZS50FL0M+D39X*P;XB("->*(S`BB`J4>J4.<C.0[3N;8)&.G0F7B?$,
M3+W+3_;@SG\<8/',,R@Z\QJT<NNM1,!364U1C\;5\M[YN\D/`:U)/DB'VWD#
MQPNY:'MPY!`?H:(&60EHT[`A%8_@&JQH2:6Y-D1T2Y3@P![406RHWQMT_Z8Q
M0&6H:UU4;@'60B#;UQA>#*IUT1;$Q_^K>RFP[30V[.B;?H0VGO"ANH4+)#<N
M+!#ZJ>@*UKD"^>C%24*ZFU=CO%_>L'=NGUT.*C!Q%1UQ-PD6$LO]@4D&X[UZ
M!6TJ:51C%7K\1SX\_C_I7$#(.R>>"K\PZOF:_0K"N"K13(>\]3?5SYP32^Z(
M;>7.:TP+D/J"Z<K,AX=6;D:9.U8X)]XF.YVY40*5%</RWN!B3"X'[D;=28I;
AJLDW!@M4D[]'B-CV,)Z];XX.1K<'0VOS?]87H6TU<0``
`
end
