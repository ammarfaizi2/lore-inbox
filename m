Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWDBCGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWDBCGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 21:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWDBCGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 21:06:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932370AbWDBCGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 21:06:40 -0500
Date: Sat, 1 Apr 2006 18:05:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't pass offset == 0 && endbyte == 0 to
 do_sync_file_range()
Message-Id: <20060401180559.450f20b2.akpm@osdl.org>
In-Reply-To: <87fykx0z5n.fsf@duaron.myhome.or.jp>
References: <87fykx0z5n.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> If user is specifying offset == 0 and nbytes == 1, current code uses
>  wbc->start == 0 && wbc->end == 0 to flush the range.
> 
>  However, wbc->start == 0 && wbc->end == 0 is special range, not 0th page.
>  [If wbc->sync_mode == WB_SYNC_NODE, it uses prev offset.  Otherwise it
>  uses whole of file.]

Good point.

>  ---
> 
>   fs/sync.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
>  diff -puN fs/sync.c~sync_file_range-fix fs/sync.c
>  --- linux-2.6/fs/sync.c~sync_file_range-fix	2006-04-02 06:20:52.000000000 +0900
>  +++ linux-2.6-hirofumi/fs/sync.c	2006-04-02 06:20:52.000000000 +0900
>  @@ -101,8 +101,14 @@ asmlinkage long sys_sync_file_range(int 
>   
>   	if (nbytes == 0)
>   		endbyte = -1;
>  -	else
>  -		endbyte--;		/* inclusive */
>  +	else {
>  +		/*
>  +		 * wbc->start == 0 && wbc->end == 0 is a special range,
>  +		 * so this avoids using it.
>  +		 */
>  +		if (endbyte > 1)
>  +			endbyte--;		/* inclusive */
>  +	}

Yes, the problem is that the interface is busted - start=0,end=0 is
ambiguous and ->writepages() will get it wrong.

So I think it's better to fix the interface...


From: Andrew Morton <akpm@osdl.org>

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> points out that when a
writeback_control's `start' and `end' fields are used to indicate a
one-byte-range starting at file offset zero, the required values of
.start=0,.end=0 mean that the ->writepages() implementation has no way of
telling that it is being asked to perform a range request.  Because we're
currently overloading (start == 0 && end == 0) to mean "this is not a
write-a-range request".

So the patch adds a new field to writeback_control to explicitly indicate that
the ->writepages implementation is to write out the byte range specified by
range_start and range_end.

The patch also renames `start' to `range_start' and `end' to `range_end' to
trigger a compile error in unconverted code.

(The root cause here is that the value of `end' is inclusive.  But that was
done so we could conveniently represent "the whole thing" by setting `end' to
-1).


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/mpage.c                |   12 +++++-------
 include/linux/writeback.h |    5 +++--
 mm/filemap.c              |    5 +++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff -puN fs/mpage.c~writeback-fix-range-handling fs/mpage.c
--- devel/fs/mpage.c~writeback-fix-range-handling	2006-04-01 17:57:11.000000000 -0800
+++ devel-akpm/fs/mpage.c	2006-04-01 18:01:56.000000000 -0800
@@ -709,7 +709,6 @@ mpage_writepages(struct address_space *m
 	pgoff_t index;
 	pgoff_t end = -1;		/* Inclusive */
 	int scanned = 0;
-	int is_range = 0;
 
 	if (wbc->nonblocking && bdi_write_congested(bdi)) {
 		wbc->encountered_congestion = 1;
@@ -727,10 +726,9 @@ mpage_writepages(struct address_space *m
 		index = 0;			  /* whole-file sweep */
 		scanned = 1;
 	}
-	if (wbc->start || wbc->end) {
-		index = wbc->start >> PAGE_CACHE_SHIFT;
-		end = wbc->end >> PAGE_CACHE_SHIFT;
-		is_range = 1;
+	if (wbc->is_range) {
+		index = wbc->range_start >> PAGE_CACHE_SHIFT;
+		end = wbc->range_end >> PAGE_CACHE_SHIFT;
 		scanned = 1;
 	}
 retry:
@@ -759,7 +757,7 @@ retry:
 				continue;
 			}
 
-			if (unlikely(is_range) && page->index > end) {
+			if (unlikely(wbc->is_range) && page->index > end) {
 				done = 1;
 				unlock_page(page);
 				continue;
@@ -810,7 +808,7 @@ retry:
 		index = 0;
 		goto retry;
 	}
-	if (!is_range)
+	if (!wbc->is_range)
 		mapping->writeback_index = index;
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
diff -puN include/linux/writeback.h~writeback-fix-range-handling include/linux/writeback.h
--- devel/include/linux/writeback.h~writeback-fix-range-handling	2006-04-01 17:57:11.000000000 -0800
+++ devel-akpm/include/linux/writeback.h	2006-04-01 17:57:11.000000000 -0800
@@ -50,14 +50,15 @@ struct writeback_control {
 	 * a hint that the filesystem need only write out the pages inside that
 	 * byterange.  The byte at `end' is included in the writeout request.
 	 */
-	loff_t start;
-	loff_t end;
+	loff_t range_start;
+	loff_t range_end;
 
 	unsigned nonblocking:1;		/* Don't get stuck on request queues */
 	unsigned encountered_congestion:1; /* An output: a queue is full */
 	unsigned for_kupdate:1;		/* A kupdate writeback */
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned for_writepages:1;	/* This is a writepages() call */
+	unsigned is_range:1;		/* Use range_start and range_end */
 };
 
 /*
diff -puN mm/filemap.c~writeback-fix-range-handling mm/filemap.c
--- devel/mm/filemap.c~writeback-fix-range-handling	2006-04-01 17:57:11.000000000 -0800
+++ devel-akpm/mm/filemap.c	2006-04-01 17:57:11.000000000 -0800
@@ -190,8 +190,9 @@ int __filemap_fdatawrite_range(struct ad
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
-		.start = start,
-		.end = end,
+		.range_start = start,
+		.range_end = end,
+		.is_range = 1,
 	};
 
 	if (!mapping_cap_writeback_dirty(mapping))
_

