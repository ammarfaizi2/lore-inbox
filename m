Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275029AbTHGAi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275054AbTHGAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:38:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:45960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275029AbTHGAiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:38:55 -0400
Date: Wed, 6 Aug 2003 17:40:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Themel <themel@iwoars.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device-backed loop broken in 2.6.0-test2?
Message-Id: <20030806174043.27fd674a.akpm@osdl.org>
In-Reply-To: <20030806224022.GA3741@iwoars.net>
References: <20030806224022.GA3741@iwoars.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Themel <themel@iwoars.net> wrote:
>
> it seems that device backed loopback is broken in the 2.6.0-test2 series.

doh.



We're currently setting PF_READAHEAD across a call into the page allocator. 
We end up calling writepage() with PF_READAHEAD set and the block layer
aborts the writes, resulting in corrupted data.

It only seems to bite with loop-on-blockdev for some reason.

And add a warning in ll_rw_block() to catch any more occurrences.




 drivers/block/ll_rw_blk.c |    8 +++++++-
 mm/readahead.c            |   22 +++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff -puN mm/readahead.c~PF_READAHEAD-loop-fix mm/readahead.c
--- 25/mm/readahead.c~PF_READAHEAD-loop-fix	2003-08-06 16:59:29.000000000 -0700
+++ 25-akpm/mm/readahead.c	2003-08-06 16:59:29.000000000 -0700
@@ -202,9 +202,9 @@ out:
  *
  * Returns the number of pages which actually had IO started against them.
  */
-static inline int
+static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			unsigned long offset, unsigned long nr_to_read)
+	unsigned long offset, unsigned long nr_to_read, int pf_readahead)
 {
 	struct inode *inode = mapping->host;
 	struct page *page;
@@ -249,8 +249,11 @@ __do_page_cache_readahead(struct address
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	if (ret)
+	if (ret) {
+		current->flags |= pf_readahead;
 		read_pages(mapping, filp, &page_pool, ret);
+		current->flags &= ~pf_readahead;
+	}
 	BUG_ON(!list_empty(&page_pool));
 out:
 	return ret;
@@ -275,8 +278,8 @@ int force_page_cache_readahead(struct ad
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+		err = __do_page_cache_readahead(mapping, filp, offset,
+						this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -300,12 +303,9 @@ int do_page_cache_readahead(struct addre
 {
 	int ret = 0;
 
-	if (!bdi_read_congested(mapping->backing_dev_info)) {
-		current->flags |= PF_READAHEAD;
-		ret = __do_page_cache_readahead(mapping, filp,
-						offset, nr_to_read);
-		current->flags &= ~PF_READAHEAD;
-	}
+	if (!bdi_read_congested(mapping->backing_dev_info))
+		ret = __do_page_cache_readahead(mapping, filp, offset,
+						nr_to_read, PF_READAHEAD);
 	return ret;
 }
 
diff -puN drivers/block/ll_rw_blk.c~PF_READAHEAD-loop-fix drivers/block/ll_rw_blk.c
--- 25/drivers/block/ll_rw_blk.c~PF_READAHEAD-loop-fix	2003-08-06 16:59:29.000000000 -0700
+++ 25-akpm/drivers/block/ll_rw_blk.c	2003-08-06 17:40:27.000000000 -0700
@@ -1847,7 +1847,13 @@ static int __make_request(request_queue_
 
 	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
 
-	ra = bio_flagged(bio, BIO_RW_AHEAD) || current->flags & PF_READAHEAD;
+	ra = bio_flagged(bio, BIO_RW_AHEAD);
+	if (current->flags & PF_READAHEAD) {
+		if (rw == WRITE)
+			WARN_ON(1);
+		else
+			ra = 1;
+	}
 
 again:
 	insert_here = NULL;

_

