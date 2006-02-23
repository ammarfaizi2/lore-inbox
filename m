Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWBWSpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWBWSpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWBWSpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:45:17 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:13538 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751265AbWBWSpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:45:13 -0500
Subject: Re: [PATCH] change b_size to size_t
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060223172925.GD27682@kvack.org>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo>
	 <20060222175923.784ce5de.akpm@osdl.org>
	 <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
	 <20060223163204.GA27682@kvack.org>
	 <1140715738.22756.125.camel@dyn9047017100.beaverton.ibm.com>
	 <20060223172925.GD27682@kvack.org>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 10:46:27 -0800
Message-Id: <1140720387.22756.137.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 12:29 -0500, Benjamin LaHaise wrote:
> On Thu, Feb 23, 2006 at 09:28:58AM -0800, Badari Pulavarty wrote:
> > How about doing this ? Change b_state to u32 and change b_size
> > to "size_t". This way, we don't increase the overall size of
> > the structure on 64-bit machines. Isn't it ?
> 
> I was thinking of that too, but that doesn't work with the bit operations 
> on big endian machines (which require unsigned long).  Oh well, I guess 
> that even with adding an extra 8 bytes on x86-64 we're still at the 96 
> bytes, or 92 bytes if the atomic_t is put at the end of the struct.
> 
> 		-ben

Okay. Here is the final version (hopefully). I moved atomic_t to
end of the structure. I still see 96-bytes for x86-64 also :(


buffer_head        40425  40760     96   40    1 : tunables  120   60
8 : slabdata   1019   1019      0

Thanks,
Badari

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
--- linux-2.6.16-rc4.orig/include/linux/buffer_head.h	2006-02-17
14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/buffer_head.h	2006-02-23
10:15:33.000000000 -0800
@@ -46,25 +46,28 @@ struct address_space;
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
 
 /*
- * Keep related fields in common cachelines.  The most commonly
accessed
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
 	struct list_head b_assoc_buffers; /* associated with another mapping
*/
+	atomic_t b_count;		/* users using this buffer_head */
 };
 
 /*
Index: linux-2.6.16-rc4/fs/buffer.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/buffer.c	2006-02-17 14:23:45.000000000
-0800
+++ linux-2.6.16-rc4/fs/buffer.c	2006-02-23 08:55:18.000000000 -0800
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
Index: linux-2.6.16-rc4/fs/reiserfs/prints.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/reiserfs/prints.c	2006-02-17
14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/reiserfs/prints.c	2006-02-23 08:56:17.000000000
-0800
@@ -143,8 +143,8 @@ static void sprintf_buffer_head(char *bu
 	char b[BDEVNAME_SIZE];
 
 	sprintf(buf,
-		"dev %s, size %d, blocknr %llu, count %d, state 0x%lx, page %p, (%s,
%s, %s)",
-		bdevname(bh->b_bdev, b), bh->b_size,
+		"dev %s, size %ld, blocknr %llu, count %d, state 0x%lx, page %p, (%s,
%s, %s)",
+		bdevname(bh->b_bdev, b), (unsigned long)bh->b_size,
 		(unsigned long long)bh->b_blocknr, atomic_read(&(bh->b_count)),
 		bh->b_state, bh->b_page,
 		buffer_uptodate(bh) ? "UPTODATE" : "!UPTODATE",
Index: linux-2.6.16-rc4/fs/ocfs2/journal.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/ocfs2/journal.c	2006-02-17
14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/ocfs2/journal.c	2006-02-23 08:56:55.000000000
-0800
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


