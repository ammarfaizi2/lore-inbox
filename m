Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275251AbTHGJzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275256AbTHGJzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:55:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2726 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S275251AbTHGJzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:55:45 -0400
Date: Thu, 7 Aug 2003 15:31:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Message-ID: <20030807100120.GA5170@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a problem with the way do_generic_mapping_read
and readahead works for the case of large reads, especially
random reads. This was leading to very inefficient behaviour
for a stream for AIO reads. (See the results a little later 
in this note)

1) We should be reading ahead at least the pages that are
   required by the current read request (even if the ra window
   is maximally shrunk). I think I've seen this in 2.4 - we 
   seem to have lost that in 2.5. 
   The result is that sometimes (large random reads) we end
   up doing reads one page at a time waiting for it to complete
   being reading the next page and so on, even for a large read.
   (until we buildup a readahead window again)

2) Once the ra window is maximally shrunk, the responsibility
   for reading the pages and re-building the window is shifted 
   to the slow path in read, which breaks down in the case of
   a stream of AIO reads where multiple iocbs submit reads
   to the same file rather than serialise the wait for i/o
   completion.

So here is a patch that fixes this by making sure we do
(1) and pushing up the handle_ra_miss calls for the maximally
shrunk case before the loop that waits for I/O completion.

Does it make a difference ? A lot, actually.

Here's a summary of 64 KB random read throughput results 
running aio-stress for a 1GB file on 2.6.0-test2, 
2.6.0-test2-mm4 and 2.6.0-test-mm4 on a 4way test 
system with this patch:

./aio-stress -o3 testdir/rwfile5
file size 1024MB, record size 64KB, depth 64, ios per iteration 8
max io_submit 8, buffer alignment set to 4KB

2.6.0-test2: 
-----------
random read on testdir/rwfile5 (8.54 MB/s) 1024.00 MB in 119.91s
(not true aio btw - here aio_read is actually fully synchronous 
since buffered fs aio support isn't in)

2.6.0-test2-mm4:
---------------
random read on testdir/rwfile5 (2.40 MB/s) 1024.00 MB in 426.10s
(and this is with buffered fs aio support i.e. true aio  
which demonstrates just how bad the problem is)

And with
2.6.0-test2-mm4 + the attached patch (read-speedup.patch)
-------------------------------------
random read on testdir/rwfile5 (21.45 MB/s) 1024.00 MB in 47.74s
(Throughput is now 2.5x that in vanilla 2.6.0-test2)

Just as a reference, here are the throughput results for
O_DIRECT aio ( ./aio-stress -O -o3 testdir/rwfile5) on the
same kernel:
random read on testdir/rwfile5 (17.71 MB/s) 1024.00 MB in 57.81s

Note: aio-stress is available at Chris Mason's ftp site
ftp.suse.com/pub/people/mason/utils/aio-stress.c 

Now, another way to solve the problem would be to
modify page_cache_readahead to let it know about the
size of the request, and to make it handle re-enablement
of readahead, and have handle_ra_miss only deal with
misses due to VM eviction. Perhaps this is what we should
do in the long run ?

Comments/feedback welcome.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--- pure-mm4/mm/filemap.c	Wed Aug  6 22:54:24 2003
+++ linux-2.6.0-test2/mm/filemap.c	Wed Aug  6 22:56:11 2003
@@ -608,13 +608,13 @@
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, offset, last, end_index;
+	unsigned long index, offset, first, last, end_index;
 	struct page *cached_page;
 	loff_t isize = i_size_read(inode);
 	int error;
 
 	cached_page = NULL;
-	index = *ppos >> PAGE_CACHE_SHIFT;
+	first = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
@@ -632,11 +632,19 @@
 	 * Let the readahead logic know upfront about all
 	 * the pages we'll need to satisfy this request
 	 */
-	for (; index < last; index++)
+	for (index = first ; index < last; index++)
 		page_cache_readahead(mapping, ra, filp, index);
-	index = *ppos >> PAGE_CACHE_SHIFT;
+
+	if (ra->next_size == -1UL) {
+		/* the readahead window was maximally shrunk */
+		/* explicitly readahead at least what is needed now */
+		for (index = first; index < last; index++)
+			handle_ra_miss(mapping, ra, index);
+		do_page_cache_readahead(mapping, filp, first, last - first);
+	}
 
 done_readahead:
+	index = first;
 	for (;;) {
 		struct page *page;
 		unsigned long nr, ret;
