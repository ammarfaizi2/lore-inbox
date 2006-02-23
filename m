Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWBWQ1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWBWQ1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWBWQ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:27:09 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:10163 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751714AbWBWQ1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:27:06 -0500
Subject: [PATCH] change b_size to size_t
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Scott <nathans@sgi.com>, christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060222175923.784ce5de.akpm@osdl.org>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo>
	 <20060222175923.784ce5de.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-O5AAs48L06ZsqKVG5bv9"
Date: Thu, 23 Feb 2006 08:28:12 -0800
Message-Id: <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O5AAs48L06ZsqKVG5bv9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-02-22 at 17:59 -0800, Andrew Morton wrote:
> Nathan Scott <nathans@sgi.com> wrote:
> >
> > There's four extra bytes on an 88 byte structure (with sector_t
> >  CONFIG'd at 64 bits)
> 
> oy, buffer_heads are 48 bytes - took a few months out of my life, that did.
> That's where it most counts - memory-constrained non-LBD 32-bit platforms.
> 
> Making b_size size_t doesn't affect that, so..

Here is the updated version of the patch, which changes
buffer_head.b_size to size_t to support mapping large
amount of disk blocks (for large IOs).

Thanks,
Badari



--=-O5AAs48L06ZsqKVG5bv9
Content-Disposition: attachment; filename=increase-bsize.patch
Content-Type: text/x-patch; name=increase-bsize.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Increase the size of the buffer_head b_size field for 64 bit
platforms.  Update some old and moldy comments in and around
the structure as well.

The b_size increase allows us to perform larger mappings and
allocations for large I/O requests from userspace, which tie
in with other changes allowing the get_block_t() interface to
map multiple blocks at once.

Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Badari Pulavary <pbadari@us.ibm.com>

Index: linux-2.6.16-rc4/include/linux/buffer_head.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/buffer_head.h	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/buffer_head.h	2006-02-23 08:33:29.000000000 -0800
@@ -46,20 +46,23 @@ struct address_space;
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
+	atomic_t b_count;		/* users using this buffer_head */
 
-	sector_t b_blocknr;		/* block number */
-	char *b_data;			/* pointer to data block */
+	size_t b_size;			/* size of mapping */
+	sector_t b_blocknr;		/* start block number */
+	char *b_data;			/* pointer to data within the page */
 
 	struct block_device *b_bdev;
 	bh_end_io_t *b_end_io;		/* I/O completion */
Index: linux-2.6.16-rc4/fs/buffer.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/buffer.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/buffer.c	2006-02-23 08:19:15.000000000 -0800
@@ -432,7 +432,7 @@ __find_get_block_slow(struct block_devic
 		printk("__find_get_block_slow() failed. "
 			"block=%llu, b_blocknr=%llu\n",
 			(unsigned long long)block, (unsigned long long)bh->b_blocknr);
-		printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
+		printk("b_state=0x%08lx, b_size=%llu\n", bh->b_state, 					(unsigned long long)bh->b_size);
 		printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
 	}
 out_unlock:
Index: linux-2.6.16-rc4/fs/reiserfs/prints.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/reiserfs/prints.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/reiserfs/prints.c	2006-02-23 08:20:01.000000000 -0800
@@ -143,8 +143,8 @@ static void sprintf_buffer_head(char *bu
 	char b[BDEVNAME_SIZE];
 
 	sprintf(buf,
-		"dev %s, size %d, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-		bdevname(bh->b_bdev, b), bh->b_size,
+		"dev %s, size %lld, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
+		bdevname(bh->b_bdev, b), (unsigned long long)bh->b_size,
 		(unsigned long long)bh->b_blocknr, atomic_read(&(bh->b_count)),
 		bh->b_state, bh->b_page,
 		buffer_uptodate(bh) ? "UPTODATE" : "!UPTODATE",
Index: linux-2.6.16-rc4/fs/ocfs2/journal.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/ocfs2/journal.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/ocfs2/journal.c	2006-02-23 08:23:34.000000000 -0800
@@ -377,12 +377,12 @@ int ocfs2_journal_access(struct ocfs2_jo
 	BUG_ON(!bh);
 	BUG_ON(!(handle->flags & OCFS2_HANDLE_STARTED));
 
-	mlog_entry("bh->b_blocknr=%llu, type=%d (\"%s\"), bh->b_size = %hu\n",
+	mlog_entry("bh->b_blocknr=%llu, type=%d (\"%s\"), bh->b_size = %llu\n",
 		   (unsigned long long)bh->b_blocknr, type,
 		   (type == OCFS2_JOURNAL_ACCESS_CREATE) ?
 		   "OCFS2_JOURNAL_ACCESS_CREATE" :
 		   "OCFS2_JOURNAL_ACCESS_WRITE",
-		   bh->b_size);
+		   (unsigned long long)bh->b_size);
 
 	/* we can safely remove this assertion after testing. */
 	if (!buffer_uptodate(bh)) {

--=-O5AAs48L06ZsqKVG5bv9--

