Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWBWBnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBWBnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWBWBnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:43:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2470 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750705AbWBWBnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:43:31 -0500
Date: Thu, 23 Feb 2006 12:40:04 +1100
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060223014004.GA900@frodo>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com> <20060222165942.GA25167@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222165942.GA25167@lst.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 05:59:42PM +0100, christoph wrote:
> On Wed, Feb 22, 2006 at 08:58:30AM -0800, Badari Pulavarty wrote:
> > Thanks. Only current issue Nathan raised is, he wants to see
> > b_size change to u64 [size_t] (instead of u32) to support
> > really-huge-IO requests.

And also to not go backwards on what the current DIO mapping
interface provides us.

> Does this sound reasonable to you ?
> 
> I know that we didn't want to increase b_size at some point because
> of concerns about the number of objects fitting into a page in the

There's four extra bytes on an 88 byte structure (with sector_t
CONFIG'd at 64 bits) - so, yes, there'll be a small decrease in
the number that fit in a page on 64 bit platforms.  Perhaps its
not worth it, but it would be good to sort out these pesky size
mismatches cos they introduce very subtle bugs.

> slab allocator.  If the same number of bigger heads fit into the
> same page I see no problems with the increase.

Heh, bigger heads.  Well, the same number fit in the page for 32
bit platforms, does that count?

Taking a quick look at the struct definition, theres some oddities
crept in since the 2.4 version - looks like sct had arranged the
fields in nice 32-bit-platform-cache-aligned groups, with several
cache-alignment related comments, some of which now remain and make
very little sense on their own (& with the now-incorrect grouping).

Anyway, here's a patch Badari - I reckon its worth it, but then I
am a bit biased (as its likely only XFS is going to be seeing this
size of I/O for some time, and as someone who has hunted down some
of these size mismatch bugs...)

cheers.

-- 
Nathan


Increase the size of the buffer_head b_size field for 64 bit
platforms.  Update some old and moldy comments in and around
the structure as well.

The b_size increase allows us to perform larger mappings and
allocations for large I/O requests from userspace, which tie
in with other changes allowing the get_block_t() interface to
map multiple blocks at once.

Signed-off-by: Nathan Scott <nathans@sgi.com>

--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -46,20 +46,25 @@ struct address_space;
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
+ * for backward compatibility reasons (e.g. submit_bh).  There
+ * may be one or two other uses too (I used it for drying the
+ * dishes the other night when I couldn't find a tea towel...).
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
