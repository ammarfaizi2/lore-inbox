Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWB0VVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWB0VVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWB0VVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:21:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:27338 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751761AbWB0VVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:21:19 -0500
Subject: [PATCH 1/4] change buffer_head.b_size to size_t
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-xAGiX9z8zdUmyPaUetvS"
Date: Mon, 27 Feb 2006 13:22:41 -0800
Message-Id: <1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xAGiX9z8zdUmyPaUetvS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Increase the size of the buffer_head b_size field (only) for
64 bit platforms.  Update some old and moldy comments in and
around the structure as well.

The b_size increase allows us to perform larger mappings and
allocations for large I/O requests from userspace, which tie
in with other changes allowing the get_block_t() interface to
map multiple blocks at once.



--=-xAGiX9z8zdUmyPaUetvS
Content-Disposition: attachment; filename=increase-bsize.patch
Content-Type: text/x-patch; name=increase-bsize.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Increase the size of the buffer_head b_size field (only) for 
64 bit platforms.  Update some old and moldy comments in and 
around the structure as well.

The b_size increase allows us to perform larger mappings and
allocations for large I/O requests from userspace, which tie
in with other changes allowing the get_block_t() interface to
map multiple blocks at once.

Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.16-rc5/include/linux/buffer_head.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/buffer_head.h	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/include/linux/buffer_head.h	2006-02-27 08:22:37.000000000 -0800
@@ -46,25 +46,28 @@ struct address_space;
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
 
 /*
- * Keep related fields in common cachelines.  The most commonly accessed
- * field (b_state) goes at the start so the compiler does not generate
- * indexed addressing for it.
+ * Historically, a buffer_head was used to map a single block
+ * within a page, and of course as the unit of I/O through the
+ * filesystem and block layers.  Nowadays the basic I/O unit
+ * is the bio, and buffer_heads are used for extracting block
+ * mappings (via a get_block_t call), for tracking state within
+ * a page (via a page_mapping) and for wrapping bio submission
+ * for backward compatibility reasons (e.g. submit_bh).
  */
 struct buffer_head {
-	/* First cache line: */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
 	struct page *b_page;		/* the page this bh is mapped to */
-	atomic_t b_count;		/* users using this block */
-	u32 b_size;			/* block size */
 
-	sector_t b_blocknr;		/* block number */
-	char *b_data;			/* pointer to data block */
+	sector_t b_blocknr;		/* start block number */
+	size_t b_size;			/* size of mapping */
+	char *b_data;			/* pointer to data within the page */
 
 	struct block_device *b_bdev;
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
+	atomic_t b_count;		/* users using this buffer_head */
 };
 
 /*
Index: linux-2.6.16-rc5/fs/buffer.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/buffer.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/buffer.c	2006-02-27 08:22:37.000000000 -0800
@@ -432,7 +432,8 @@ __find_get_block_slow(struct block_devic
 		printk("__find_get_block_slow() failed. "
 			"block=%llu, b_blocknr=%llu\n",
 			(unsigned long long)block, (unsigned long long)bh->b_blocknr);
-		printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
+		printk("b_state=0x%08lx, b_size=%lu\n", bh->b_state,
+				(unsigned long)bh->b_size);
 		printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
 	}
 out_unlock:
Index: linux-2.6.16-rc5/fs/reiserfs/prints.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/reiserfs/prints.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/reiserfs/prints.c	2006-02-27 08:22:37.000000000 -0800
@@ -143,8 +143,8 @@ static void sprintf_buffer_head(char *bu
 	char b[BDEVNAME_SIZE];
 
 	sprintf(buf,
-		"dev %s, size %d, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-		bdevname(bh->b_bdev, b), bh->b_size,
+		"dev %s, size %ld, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
+		bdevname(bh->b_bdev, b), (unsigned long)bh->b_size,
 		(unsigned long long)bh->b_blocknr, atomic_read(&(bh->b_count)),
 		bh->b_state, bh->b_page,
 		buffer_uptodate(bh) ? "UPTODATE" : "!UPTODATE",
Index: linux-2.6.16-rc5/fs/ocfs2/journal.c
===================================================================
--- linux-2.6.16-rc5.orig/fs/ocfs2/journal.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/fs/ocfs2/journal.c	2006-02-27 08:22:37.000000000 -0800
@@ -377,12 +377,12 @@ int ocfs2_journal_access(struct ocfs2_jo
 	BUG_ON(!bh);
 	BUG_ON(!(handle->flags & OCFS2_HANDLE_STARTED));
 
-	mlog_entry("bh->b_blocknr=%llu, type=%d (\"%s\"), bh->b_size = %hu\n",
+	mlog_entry("bh->b_blocknr=%llu, type=%d (\"%s\"), bh->b_size = %lu\n",
 		   (unsigned long long)bh->b_blocknr, type,
 		   (type == OCFS2_JOURNAL_ACCESS_CREATE) ?
 		   "OCFS2_JOURNAL_ACCESS_CREATE" :
 		   "OCFS2_JOURNAL_ACCESS_WRITE",
-		   bh->b_size);
+		   (unsigned long)bh->b_size);
 
 	/* we can safely remove this assertion after testing. */
 	if (!buffer_uptodate(bh)) {

--=-xAGiX9z8zdUmyPaUetvS--

