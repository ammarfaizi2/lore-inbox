Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUIWQDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUIWQDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUIWQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:03:47 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:22202 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266316AbUIWQDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:03:10 -0400
Message-ID: <4152F46D.1060200@austin.ibm.com>
Date: Thu, 23 Sep 2004 11:06:05 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fs-devel@vger.kernel.org
Subject: [PATCH/RFC] Simplified Readahead
Content-Type: multipart/mixed;
 boundary="------------030509010308080004080000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030509010308080004080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The readahead code has undergone many changes in the 2.6 kernel and the 
current implementation is in my opinion obtuse and hard to maintain.  We 
would like to offer up an alternative simplified design which will not 
only make the code easier to maintain, but as performance tests have 
shown, results in better performance in many cases.

We are very interested in having others review and try out the code and 
run whatever performance tests they see fit.

Quick overview of the new design:

The key design point of the new design is to make the readahead code 
aware of the size of the I/O request.  This change eliminates the need 
for treating large random I/O as sequential and all of the averaging 
code that exists just to support this.  In addition to this change, the 
new design ramps up quicker, and shuts off faster.  This, combined with 
the request size awareness eliminates the so called "slow read path" 
that we try so hard to avoid in the current code.  For complete details 
on the design of the new readahead logic, please refer to 
http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/read-ahead-design.pdf

There are a few exception cases which still concern me. 

1. pages already in cache
2. I/O queue congestion.
3. page stealing

The first of these is a file already residing in page cache.  If we do 
not code for this case we will end up doing multiple page lookups for 
each page.  The current code tries to handle this using the 
check_ra_success function, but this code does not work.  
check_ra_success will subtract 1 page each time an I/O is completely 
contained in page cache, however on the main path we will increment the 
window size by 2 for each page in the request (up to max_readahead) thus 
negating the reduction.  My question is what is the right behavior.  
Reducing the size of the ahead window doesn't help.  You must turn off 
readahead to have any effect.  Once you believe all pages to be in page 
cache we should just immediately turn off readahead.  What is this 
trigger point?  4 I/Os in a row? 400?  My concern is that the savings 
for skipping the double lookup appears to be on the order of .5% CPU in 
my tests, but the penalty for small I/O in sequential read case can be 
substantial.  Currently the new code does not handle this case, but it 
could be enhanced to do so. 

The second case is on queue congestion.  Current code does not submit 
the I/O if the queue is congested. This will result in each page being 
read serially on the cache miss path.  Does submitting 32 4k I/Os 
instead of 1 128k I/O help queue congestion?  Here is one place where 
the current cod gets real confusing.  We reduce the window by 1 page for 
queue congestion(treated the same as page cache hit), but we leave the 
information about the current and ahead windows alone even though we did 
not issue the I/O to populate it and so we will never issue the I/O from 
the readahead code.  Eventually we will start taking cache misses since 
no one read the pages.  That code decrements the window size by 3, but 
as in the cache hit case since we are still reading sequentially we keep 
incrementing by 2 for each page; net effect -1 for each page not in 
cache.    Again, the new code ignores the congestion case and still 
tries to do readahead, thus minimizing/optimizing the I/O requests sent 
to the device.  Is this right?  If not what should we do?

The third exception case is page stealing where the page into which 
readahead was done is reclaimed before the data is copied to user 
space.  This would seem to be a somewhat rare case only happening under 
sever memory pressure, but my tests have shown that it can occur quite 
frequently with as little as 4 threads doing 1M readahead or 16 threads 
doing 128k readahead on a machine with 1GB memory of which 950MB is page 
cache.  Here it would seem the right thing to do is shrink the window 
size and reduce the  chance for page stealing, this however kill I/O 
performance if done to aggressively.  Again the current code may not 
perform as expected. As in the 2 previous cases, the -3 is offset by a 
+2 and so unless > 2/3 of pages in a given window are stolen the net 
effect is to ignore the page stealing.  New code will slowly shrink the 
window as long as stealing occurs, but will quickly regrow once it stops.

Performance:

A large number of tests have been run to test the performance of the new 
code, but it is in no way comprehensive.  Primarily I ran tiobench to 
ensure that the major code paths were hit.  I also ran sysbench in the 
mode which has been reported to cause problems on the current/recent 
readahead code.  I used multiple machines and disk types to test on.  
The small system is a 1 way pentium III 866MHz with 256MB memory and a 
dedicated IDE test disk.  The second machine is an 8way pentium IV 
2.0GHz with 1GB memory and test were on on both a dedicated 10k-rpm SCSI 
disk on on-board adaptec adapter and on 2GBit QLA2300 Fiber attached 
FAStT700 7 disk RAID0 array.

In summary, the new code was always equal to or better than the current 
code on all variation and all test configurations.  Tests were run 
multiple time on freshly formatted JFS file systems on both 2.6.8.1 and 
2.6.9-rc2-mm1.  Results for the 2 kernel versions were similar so I am 
including only the 2.6.9-rc2-mm1 results.

Tiobench results:

Summary:
    For single threaded tests sequential reads the code is equal on IDE 
and single SCSI disks, but the new code is 10-20% fasted on RAID.  For 
Multi threaded sequential reads the new code is always faster(20-50%).  
For random reads the new code is equal to the old for all cases where 
the request size is less than or equal to the max_readahead size.   For 
request sizes larger than max_readahead the new code is as much as 50% 
faster.

tiobench --block n --size 4000 --numruns 2 --threads m 
	(where m is one of 4096,16384,524288 and n is one of 1,4,16,64)


Graph lines with "new7" are the new readahead code, all others are the 
stock kernel.

Single CPU IDE
http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/128k-ide.html

8way Single SCSI
http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/mm1-128k-new7.html

8way RAID0
http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/mm1-128kRAID-new7.html


Sysbench results:

sysbench --num-threads=254 --test=fileio --file-total-size=4G --file-test-mode=rndrw'


IDE Disk
   Current:  1.303 MB/sec average
    New:      1.314 MB/sec average

SCSI Disk
    Currnent: 2.713 MB/sec average
    New:         2.746 MB/sec average

For full results see:
http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/sysbench.results


Thanks,
Steve Pratt and Dom Heger

--------------030509010308080004080000
Content-Type: text/plain;
 name="2.6.9-rc2-mm1-newra.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.9-rc2-mm1-newra.patch"

--- linux-2.6.9-rc2/include/linux/mm.h.org	2004-09-17 14:05:27.000000000 -0500
+++ linux-2.6.9-rc2/include/linux/mm.h	2004-09-22 12:42:59.000000000 -0500
@@ -727,10 +727,11 @@
 			unsigned long offset, unsigned long nr_to_read);
 int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			unsigned long offset, unsigned long nr_to_read);
-void page_cache_readahead(struct address_space *mapping, 
+unsigned long  page_cache_readahead(struct address_space *mapping, 
 			  struct file_ra_state *ra,
 			  struct file *filp,
-			  unsigned long offset);
+			  unsigned long offset,
+			  unsigned long size);
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
--- linux-2.6.9-rc2/include/linux/fs.h.org	2004-09-17 14:05:47.000000000 -0500
+++ linux-2.6.9-rc2/include/linux/fs.h	2004-09-21 13:47:10.000000000 -0500
@@ -557,16 +557,15 @@
 struct file_ra_state {
 	unsigned long start;		/* Current window */
 	unsigned long size;
-	unsigned long next_size;	/* Next window size */
+	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
 	unsigned long prev_page;	/* Cache last read() position */
 	unsigned long ahead_start;	/* Ahead window */
 	unsigned long ahead_size;
-	unsigned long currnt_wnd_hit;	/* locality in the current window */
-	unsigned long average;		/* size of next current window */
 	unsigned long ra_pages;		/* Maximum readahead window */
 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
 };
+#define RA_FLAG_MISS 0x01       /* a cache miss occured against this file */
 
 struct file {
 	struct list_head	f_list;
--- linux-2.6.9-rc2/mm/readahead.org.c	2004-09-16 16:02:05.000000000 -0500
+++ linux-2.6.9-rc2/mm/readahead.c	2004-09-22 13:18:46.000000000 -0500
@@ -35,7 +35,6 @@
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
 	ra->ra_pages = mapping->backing_dev_info->ra_pages;
-	ra->average = ra->ra_pages / 2;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
@@ -52,6 +51,62 @@
 	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 }
 
+static inline void ra_off(struct file_ra_state *ra)
+{
+	ra->start=0;
+	ra->flags=0;
+	ra->size=-1UL;
+	ra->ahead_start=0;
+	ra->ahead_size=0;
+    return;
+}
+
+/*
+ * Set the initial window size, round to next power of 2 and square
+ * for small size, x 4 for medium, and x 2 for large
+ * for 128k (32 page) max ra
+ * 1-8 page = 32k initial, > 8 page = 128k initial
+ */
+unsigned long get_init_ra_size(unsigned long size, unsigned long max,
+							   unsigned long min)
+{
+	unsigned long s_size=1, newsize;
+	do { 
+		s_size = s_size << 1;
+	} while ((size = size >> 1));
+    if (s_size <= max / 64) {
+        newsize = s_size * s_size;
+    } else if (s_size <= max/4) {
+        newsize = max / 4;
+    } else {
+        newsize = max;
+    }
+	return newsize;
+}
+
+/*
+ * Set the new window size, this is called only when 
+ * I/O is to be submitted, not for each call to readahead
+ * If cache miss occered, reduce next I/O size, else
+ * increase depending on how close to max we are.
+ */
+unsigned long get_next_ra_size(unsigned long cur, unsigned long max, 
+							   unsigned long min, unsigned long * flags)
+{
+	unsigned long newsize;
+	if (*flags & RA_FLAG_MISS) {
+		newsize = max((cur - 2),min);
+		*flags &= ~RA_FLAG_MISS;
+	} else if ( cur < max/16 ) {
+		newsize = 4 * cur;
+	} else {
+		newsize = 2 * cur;
+	}            
+	newsize = min(newsize, max_sane_readahead(max));
+	return newsize;
+}
+
+
 #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
 
 /**
@@ -152,19 +207,17 @@
  * ahead_size:  Together, these form the "ahead window".
  * ra_pages:	The externally controlled max readahead for this fd.
  *
- * When readahead is in the "maximally shrunk" state (next_size == -1UL),
- * readahead is disabled.  In this state, prev_page and size are used, inside
- * handle_ra_miss(), to detect the resumption of sequential I/O.  Once there
- * has been a decent run of sequential I/O (defined by get_min_readahead),
- * readahead is reenabled.
+ * When readahead is in the off state (size == -1UL),
+ * readahead is disabled.  In this state, prev_page is used
+ * to detect the resumption of sequential I/O.  
  *
  * The readahead code manages two windows - the "current" and the "ahead"
  * windows.  The intent is that while the application is walking the pages
  * in the current window, I/O is underway on the ahead window.  When the
  * current window is fully traversed, it is replaced by the ahead window
  * and the ahead window is invalidated.  When this copying happens, the
- * new current window's pages are probably still locked.  When I/O has
- * completed, we submit a new batch of I/O, creating a new ahead window.
+ * new current window's pages are probably still locked.  So 
+ * we submit a new batch of I/O immediately, creating a new ahead window.
  *
  * So:
  *
@@ -176,34 +229,25 @@
  *           ahead window.
  *
  * A `readahead hit' occurs when a read request is made against a page which is
- * inside the current window.  Hits are good, and the window size (next_size)
- * is grown aggressively when hits occur.  Two pages are added to the next
- * window size on each hit, which will end up doubling the next window size by
- * the time I/O is submitted for it.
- *
- * If readahead hits are more sparse (say, the application is only reading
- * every second page) then the window will build more slowly.
- *
- * On a readahead miss (the application seeked away) the readahead window is
- * shrunk by 25%.  We don't want to drop it too aggressively, because it is a
- * good assumption that an application which has built a good readahead window
- * will continue to perform linear reads.  Either at the new file position, or
- * at the old one after another seek.
+ * the next sequential page. Ahead windowe calculations are done only when it
+ * is time to submit a new IO.  The code ramps up the size agressively at first,
+ * but slow down as it approaches max_readhead.
  *
- * After enough misses, readahead is fully disabled. (next_size = -1UL).
+ * Any seek/ramdom IO will result in readahead being turned off.  It will resume
+ * at the first sequential access.
  *
  * There is a special-case: if the first page which the application tries to
  * read happens to be the first page of the file, it is assumed that a linear
- * read is about to happen and the window is immediately set to half of the
- * device maximum.
+ * read is about to happen and the window is immediately set to the initial size
+ * based on I/O request size and the max_readahead.
  * 
  * A page request at (start + size) is not a miss at all - it's just a part of
  * sequential file reading.
  *
- * This function is to be called for every page which is read, rather than when
- * it is time to perform readahead.  This is so the readahead algorithm can
- * centrally work out the access patterns.  This could be costly with many tiny
- * read()s, so we specifically optimise for that case with prev_page.
+ * This function is to be called for every read request, rather than when
+ * it is time to perform readahead.  It is called only oce for the entire I/O
+ * regardless of size unless readahead is unable to start enough I/O to satisfy 
+ * the request (I/O request > max_readahead).
  */
 
 /*
@@ -212,7 +256,7 @@
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  *
- * Returns the number of pages which actually had IO started against them.
+ * Returns the number of pages requested, or the maximum amount of I/O allowed.
  */
 static inline int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
@@ -310,257 +354,123 @@
 int do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 			unsigned long offset, unsigned long nr_to_read)
 {
-	if (!bdi_read_congested(mapping->backing_dev_info))
-		return __do_page_cache_readahead(mapping, filp,
-						offset, nr_to_read);
-	return 0;
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
 }
 
-/*
- * Check how effective readahead is being.  If the amount of started IO is
- * less than expected then the file is partly or fully in pagecache and
- * readahead isn't helping.  Shrink the window.
- *
- * But don't shrink it too much - the application may read the same page
- * occasionally.
- */
-static inline void
-check_ra_success(struct file_ra_state *ra, pgoff_t attempt,
-			pgoff_t actual, pgoff_t orig_next_size)
-{
-	if (actual == 0) {
-		if (orig_next_size > 1) {
-			ra->next_size = orig_next_size - 1;
-			if (ra->ahead_size)
-				ra->ahead_size = ra->next_size;
-		} else {
-			ra->next_size = -1UL;
-			ra->size = 0;
-		}
-	}
-}
+
+
 
 /*
  * page_cache_readahead is the main function.  If performs the adaptive
  * readahead window size management and submits the readahead I/O.
  */
-void
+unsigned long 
 page_cache_readahead(struct address_space *mapping, struct file_ra_state *ra,
-			struct file *filp, unsigned long offset)
+	struct file *filp, unsigned long offset, unsigned long req_size)
 {
-	unsigned max;
-	unsigned orig_next_size;
-	unsigned actual;
-	int first_access=0;
-	unsigned long average;
-
+	unsigned long max, min, maxsane, newsize=req_size;
+	unsigned long actual=0;
+	
 	/*
 	 * Here we detect the case where the application is performing
 	 * sub-page sized reads.  We avoid doing extra work and bogusly
 	 * perturbing the readahead window expansion logic.
-	 * If next_size is zero, this is the very first read for this
-	 * file handle, or the window is maximally shrunk.
+	 * If size is zero, there is no read ahead window so we need one
 	 */
-	if (offset == ra->prev_page) {
-		if (ra->next_size != 0)
-			goto out;
+	if (offset == ra->prev_page && req_size == 1 && ra->size != 0) {
+		goto out;
 	}
-
-	if (ra->next_size == -1UL)
-		goto out;	/* Maximally shrunk */
-
+	
 	max = get_max_readahead(ra);
-	if (max == 0)
+	min = get_min_readahead(ra);
+	maxsane = max_sane_readahead(max); 
+	newsize = min(req_size, maxsane);
+	
+	if (newsize == 0)
 		goto out;	/* No readahead */
 
-	orig_next_size = ra->next_size;
-
-	if (ra->next_size == 0) {
-		/*
-		 * Special case - first read.
-		 * We'll assume it's a whole-file read, and
-		 * grow the window fast.
-		 */
-		first_access=1;
-		ra->next_size = max / 2;
-		ra->prev_page = offset;
-		ra->currnt_wnd_hit++;
-		goto do_io;
-	}
-
-	ra->prev_page = offset;
-
-	if (offset >= ra->start && offset <= (ra->start + ra->size)) {
-		/*
-		 * A readahead hit.  Either inside the window, or one
-		 * page beyond the end.  Expand the next readahead size.
+   	/*
+   	 * Special case - first read.
+   	 * We'll assume it's a whole-file read if at start of file, and
+   	 * grow the window fast.
+     * or detect first sequential access
+   	 */
+	if ((ra->size == 0 && offset == 0)   // first io	and start of file
+        || (ra->size == -1UL && ra->prev_page == offset-1)) { //1st seq access
+		ra->prev_page  = offset + newsize-1;
+        ra->size = get_init_ra_size(newsize, max, min);
+        ra->start = offset;
+        actual = do_page_cache_readahead(mapping, filp, offset, ra->size);
+		/* if the request size is larger than our max readahead, we 
+		 * at least want to be sure that we get 2 IOs if flight and 
+		 * we know that we will definitly need the new I/O.
+		 * once we do this, subsequent calls should be able to overlap IOs,
+		 * thus preventing stalls. so Issue the ahead window immediately.
 		 */
-		ra->next_size += 2;
-
-		if (ra->currnt_wnd_hit <= (max * 2))
-			ra->currnt_wnd_hit++;
-	} else {
-		/*
-		 * A miss - lseek, pagefault, pread, etc.  Shrink the readahead
-		 * window.
-		 */
-		ra->next_size -= 2;
-
-		average = ra->average;
-		if (average < ra->currnt_wnd_hit) {
-			average++;
+		if (req_size >= max) {
+			ra->ahead_size = get_next_ra_size(ra->size, max, min, &ra->flags);
+			ra->ahead_start = ra->start + ra->size;
+			actual = do_page_cache_readahead(mapping, filp,
+					ra->ahead_start, ra->ahead_size);
 		}
-		ra->average = (average + ra->currnt_wnd_hit) / 2;
-		ra->currnt_wnd_hit = 1;
+		goto out;
 	}
 
-	if ((long)ra->next_size > (long)max)
-		ra->next_size = max;
-	if ((long)ra->next_size <= 0L) {
-		ra->next_size = -1UL;
-		ra->size = 0;
-		goto out;		/* Readahead is off */
-	}
+    /* now handle the random case:
+     * partial page reads and first access were handled above, 
+	 * so this must be the next page otherwise it is random
+     */
+      if ((offset != (ra->prev_page+1) || (ra->size == 0))) {
+		ra_off(ra);
+		ra->prev_page  = offset + newsize-1;
+        actual = do_page_cache_readahead(mapping, filp, offset, newsize);
+        goto out;
+    }
 
-	/*
-	 * Is this request outside the current window?
+	/* If we get here we are doing sequential IO and this was 
+	 * not the first occurence (ie we have an existing window)
 	 */
-	if (offset < ra->start || offset >= (ra->start + ra->size)) {
-		/*
-		 * A miss against the current window.  Have we merely
-		 * advanced into the ahead window?
-		 */
-		if (offset == ra->ahead_start) {
-			/*
-			 * Yes, we have.  The ahead window now becomes
-			 * the current window.
-			 */
+
+	if (ra->ahead_start == 0) {	 /* no ahead window yet */
+		ra->ahead_size = get_next_ra_size(ra->size, max, min, &ra->flags);
+		ra->ahead_start = ra->start + ra->size;
+		ra->prev_page = offset + newsize - 1;
+        actual = do_page_cache_readahead(mapping, filp,
+				ra->ahead_start, ra->ahead_size);
+	}else { 
+		/* already have an ahead window, check if we crossed into it */
+		if ((offset + newsize -1) >= ra->ahead_start) {
 			ra->start = ra->ahead_start;
 			ra->size = ra->ahead_size;
-			ra->prev_page = ra->start;
-			ra->ahead_start = 0;
-			ra->ahead_size = 0;
-
-			/*
-			 * Control now returns, probably to sleep until I/O
-			 * completes against the first ahead page.
-			 * When the second page in the old ahead window is
-			 * requested, control will return here and more I/O
-			 * will be submitted to build the new ahead window.
-			 */
-			goto out;
-		}
-do_io:
-		/*
-		 * This is the "unusual" path.  We come here during
-		 * startup or after an lseek.  We invalidate the
-		 * ahead window and get some I/O underway for the new
-		 * current window.
-		 */
-		if (!first_access) {
-			 /* Heuristic: there is a high probability
-			  * that around  ra->average number of
-			  * pages shall be accessed in the next
-			  * current window.
-			  */
-			average = ra->average;
-			if (ra->currnt_wnd_hit > average)
-				average = (ra->currnt_wnd_hit + ra->average + 1) / 2;
-
-			ra->next_size = min(average , (unsigned long)max);
-		}
-		ra->start = offset;
-		ra->size = ra->next_size;
-		ra->ahead_start = 0;		/* Invalidate these */
-		ra->ahead_size = 0;
-		actual = do_page_cache_readahead(mapping, filp, offset,
-						 ra->size);
-		if(!first_access) {
-			/*
-			 * do not adjust the readahead window size the first
-			 * time, the ahead window might get closed if all
-			 * the pages are already in the cache.
-			 */
-			check_ra_success(ra, ra->size, actual, orig_next_size);
-		}
-	} else {
-		/*
-		 * This read request is within the current window.  It may be
-		 * time to submit I/O for the ahead window while the
-		 * application is about to step into the ahead window.
-		 */
-		if (ra->ahead_start == 0) {
-			/*
-			 * If the average io-size is more than maximum
-			 * readahead size of the file the io pattern is
-			 * sequential. Hence  bring in the readahead window
-			 * immediately.
-			 * If the average io-size is less than maximum
-			 * readahead size of the file the io pattern is
-			 * random. Hence don't bother to readahead.
-			 */
-			average = ra->average;
-			if (ra->currnt_wnd_hit > average)
-				average = (ra->currnt_wnd_hit + ra->average + 1) / 2;
-
-			if (average > max) {
-				ra->ahead_start = ra->start + ra->size;
-				ra->ahead_size = ra->next_size;
-				actual = do_page_cache_readahead(mapping, filp,
+			ra->ahead_start = ra->ahead_start + ra->ahead_size;
+			ra->ahead_size = get_next_ra_size(ra->ahead_size, max, min, &ra->flags);
+			ra->prev_page = offset + newsize - 1;
+			actual = do_page_cache_readahead(mapping, filp,
 					ra->ahead_start, ra->ahead_size);
-				check_ra_success(ra, ra->ahead_size,
-						actual, orig_next_size);
-			}
+		}else {
+			/* do nothing, read contained in current window and ahead 
+			 * window populated  just update the prev_page pointer.
+			 */
+			ra->prev_page = offset + newsize -1;
 		}
 	}
 out:
-	return;
+    return (newsize);
 }
-EXPORT_SYMBOL(page_cache_readahead);
-
 
 /*
  * handle_ra_miss() is called when it is known that a page which should have
  * been present in the pagecache (we just did some readahead there) was in fact
  * not found.  This will happen if it was evicted by the VM (readahead
- * thrashing) or if the readahead window is maximally shrunk.
+ * thrashing) 
  *
- * If the window has been maximally shrunk (next_size == -1UL) then look to see
- * if we are getting misses against sequential file offsets.  If so, and this
- * persists then resume readahead.
- *
- * Otherwise we're thrashing, so shrink the readahead window by three pages.
- * This is because it is grown by two pages on a readahead hit.  Theory being
- * that the readahead window size will stabilise around the maximum level at
- * which there is no thrashing.
+ * turn on the cache miss flag in the RA struct, this will cause the RA code
+ * to reduce the RA size on the next read.
  */
 void handle_ra_miss(struct address_space *mapping,
 		struct file_ra_state *ra, pgoff_t offset)
 {
-	if (ra->next_size == -1UL) {
-		const unsigned long max = get_max_readahead(ra);
-
-		if (offset != ra->prev_page + 1) {
-			ra->size = ra->size?ra->size-1:0; /* Not sequential */
-		} else {
-			ra->size++;			/* A sequential read */
-			if (ra->size >= max) {		/* Resume readahead */
-				ra->start = offset - max;
-				ra->next_size = max;
-				ra->size = max;
-				ra->ahead_start = 0;
-				ra->ahead_size = 0;
-				ra->average = max / 2;
-			}
-		}
-		ra->prev_page = offset;
-	} else {
-		const unsigned long min = get_min_readahead(ra);
-
-		ra->next_size -= 3;
-		if (ra->next_size < min)
-			ra->next_size = min;
-	}
+	ra->flags |= RA_FLAG_MISS;	
 }
 
 /*
--- linux-2.6.9-rc2/mm/filemap.org.c	2004-09-17 16:11:21.000000000 -0500
+++ linux-2.6.9-rc2/mm/filemap.c	2004-09-21 13:45:25.000000000 -0500
@@ -717,14 +717,15 @@
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, end_index, offset;
+	unsigned long index, end_index, offset, req_size, next_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
-	index = *ppos >> PAGE_CACHE_SHIFT;
+	next_index = index = *ppos >> PAGE_CACHE_SHIFT;
+	req_size = (desc->count + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	isize = i_size_read(inode);
@@ -734,7 +735,7 @@
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
-		unsigned long nr, ret;
+		unsigned long ret_size, nr, ret;
 
 		/* nr is the maximum number of bytes to copy from this page */
 		nr = PAGE_CACHE_SIZE;
@@ -749,7 +750,12 @@
 		nr = nr - offset;
 
 		cond_resched();
-		page_cache_readahead(mapping, &ra, filp, index);
+		if(index == next_index && req_size) {
+			ret_size = page_cache_readahead(mapping, &ra, 
+					filp, index, req_size);
+			next_index += ret_size;
+			req_size -= ret_size;
+		}
 
 find_page:
 		page = find_get_page(mapping, index);
@@ -1195,7 +1201,7 @@
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
 	if (VM_SequentialReadHint(area))
-		page_cache_readahead(mapping, ra, file, pgoff);
+		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
 	/*
 	 * Do we have something in the page cache already?

--------------030509010308080004080000--

