Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSGQFWs>; Wed, 17 Jul 2002 01:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSGQFWF>; Wed, 17 Jul 2002 01:22:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18700 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318210AbSGQFTo>;
	Wed, 17 Jul 2002 01:19:44 -0400
Message-ID: <3D3500F7.E3748929@zip.com.au>
Date: Tue, 16 Jul 2002 22:30:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/13] readahead optimisations
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Been looking at a workload which involves several processes which seek
around and read from a large file.  There are a few problems:

c013a25c 301      0.259132    page_cache_readahead    
c012d09c 323      0.278072    generic_file_read       
c0105ea8 357      0.307343    __write_lock_failed     
c013dc98 367      0.315952    fput                    
c010c834 409      0.35211     timer_interrupt         
c0106fda 479      0.412373    restore_all             
c013cd50 499      0.429591    sys_llseek              
c0105ec8 531      0.45714     __read_lock_failed      
c011db1c 612      0.526873    sys_gettimeofday        
c013ddb0 1173     1.00984     fget                    
c0151314 1190     1.02448     update_atime            
c0205f74 1693     1.45751     blk_run_queues          
c013ce44 1742     1.49969     vfs_read                
c013a148 2387     2.05498     do_page_cache_readahead 
c0106f98 2688     2.31411     system_call             
c012cc30 2900     2.49662     do_generic_file_read    
c010c560 2976     2.56205     do_gettimeofday         
c01e467c 3447     2.96754     radix_tree_lookup       
c013ca40 3542     3.04932     generic_file_llseek     
c012cf34 85241    73.3843     file_read_actor         

generic_file_lseek is bouncing i_sem around like mad, and readahead is
doing lots of pointless pagecache probing.

This patch addresses readahead.  With this and the lseek patch applied,
the kernel gains about 8% throughput.

c013d108 175      0.14299     sys_read                
c0133e2c 212      0.173222    page_cache_release      
c012d09c 235      0.192015    generic_file_read       
c0115a04 252      0.205906    scheduler_tick          
c0106fcf 259      0.211626    syscall_exit            
c01126cc 284      0.232053    smp_apic_timer_interrupt 
c0105ec8 393      0.321115    __read_lock_failed      
c010c834 410      0.335006    timer_interrupt         
c0106fda 507      0.414263    restore_all             
c013cb00 605      0.494338    generic_file_llseek     
c011db1c 648      0.529472    sys_gettimeofday        
c013ce04 768      0.627523    sys_llseek              
c013de90 1204     0.983773    fget                    
c01513f4 1297     1.05976     update_atime            
c013dd78 1479     1.20847     fput                    
c01e476c 2181     1.78207     radix_tree_lookup       
c013cee8 2344     1.91525     vfs_read                
c0106f98 2768     2.2617      system_call             
c010c560 3409     2.78545     do_gettimeofday         
c012cc30 4686     3.82887     do_generic_file_read    
c012cf34 97064    79.3097     file_read_actor         


Presumably the change will be larger on machines which have higher
bandwidth memory than my test box, of which there are many.

This patch teaches readahead to detect the situation where no IO is
actually being performed as a result of its actions.  Now, we don't
want to sacrifice IO efficiency to save a bit of CPU, so the code is
very cautious.  But eventually, after some tens of consecutive
readahead attempts were found to perform no I/O at all, readahead will
turn itself off.

readahead will be turned on again when either generic_file_read() or
filemap_nopage() get a pagecache miss.  The function
handle_ra_thrashing() has been renamed to handle_ra_miss() to reflect
its widened role.

A performance bug in page_cache_readround() was fixed - if
ra->next_size is zero, that function needs to leave it well alone,
because next_size==0 is a magic value meaning that the file has just
been opened and that readahead needs to get aggressive.  This change
makes a `make dep' run at the same speed as in the 2.4 kernel.  It used
to take 4x as long...

`make dep' is an interesting test because it uses mmap to read the files.




 include/linux/mm.h |    4 -
 mm/filemap.c       |   25 +++++++--
 mm/readahead.c     |  144 ++++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 121 insertions(+), 52 deletions(-)

--- 2.5.26/mm/readahead.c~readahead-speedup	Tue Jul 16 21:47:19 2002
+++ 2.5.26-akpm/mm/readahead.c	Tue Jul 16 21:47:19 2002
@@ -61,6 +61,7 @@ read_pages(struct file *file, struct add
  *              Together, these form the "current window".
  *              Together, start and size represent the `readahead window'.
  * next_size:   The number of pages to read on the next readahead miss.
+ *              Has the magical value -1UL if readahead has been disabled.
  * prev_page:   The page which the readahead algorithm most-recently inspected.
  *              prev_page is mainly an optimisation: if page_cache_readahead
  *		sees that it is again being called for a page which it just
@@ -68,6 +69,7 @@ read_pages(struct file *file, struct add
  *		changes.
  * ahead_start,
  * ahead_size:  Together, these form the "ahead window".
+ * ra_pages:	The externally controlled max readahead for this fd.
  *
  * The readahead code manages two windows - the "current" and the "ahead"
  * windows.  The intent is that while the application is walking the pages
@@ -120,8 +122,10 @@ read_pages(struct file *file, struct add
  * the pages first, then submits them all for I/O. This avoids the very bad
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
+ *
+ * Returns the number of pages which actually had IO started against them.
  */
-void do_page_cache_readahead(struct file *file,
+int do_page_cache_readahead(struct file *file,
 			unsigned long offset, unsigned long nr_to_read)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
@@ -130,10 +134,10 @@ void do_page_cache_readahead(struct file
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
-	int nr_to_really_read = 0;
+	int ret = 0;
 
 	if (inode->i_size == 0)
-		return;
+		goto out;
 
  	end_index = ((inode->i_size - 1) >> PAGE_CACHE_SHIFT);
 
@@ -158,7 +162,7 @@ void do_page_cache_readahead(struct file
 			break;
 		page->index = page_offset;
 		list_add(&page->list, &page_pool);
-		nr_to_really_read++;
+		ret++;
 	}
 	read_unlock(&mapping->page_lock);
 
@@ -167,10 +171,36 @@ void do_page_cache_readahead(struct file
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(file, mapping, &page_pool, nr_to_really_read);
-	blk_run_queues();
+	if (ret) {
+		read_pages(file, mapping, &page_pool, ret);
+		blk_run_queues();
+	}
 	BUG_ON(!list_empty(&page_pool));
-	return;
+out:
+	return ret;
+}
+
+/*
+ * Check how effective readahead is being.  If the amount of started IO is
+ * less than expected then the file is partly or fully in pagecache and
+ * readahead isn't helping.  Shrink the window.
+ *
+ * But don't shrink it too much - the application may read the same page
+ * occasionally.
+ */
+static inline void
+check_ra_success(struct file_ra_state *ra, pgoff_t attempt,
+			pgoff_t actual, pgoff_t orig_next_size)
+{
+	if (actual == 0) {
+		if (orig_next_size > 1) {
+			ra->next_size = orig_next_size - 1;
+			if (ra->ahead_size)
+				ra->ahead_size = ra->next_size;
+		} else {
+			ra->next_size = -1UL;
+		}
+	}
 }
 
 /*
@@ -180,25 +210,32 @@ void do_page_cache_readahead(struct file
 void page_cache_readahead(struct file *file, unsigned long offset)
 {
 	struct file_ra_state *ra = &file->f_ra;
-	unsigned long max;
-	unsigned long min;
+	unsigned max;
+	unsigned min;
+	unsigned orig_next_size;
+	unsigned actual;
 
 	/*
 	 * Here we detect the case where the application is performing
 	 * sub-page sized reads.  We avoid doing extra work and bogusly
 	 * perturbing the readahead window expansion logic.
 	 * If next_size is zero, this is the very first read for this
-	 * file handle.
+	 * file handle, or the window is maximally shrunk.
 	 */
 	if (offset == ra->prev_page) {
 		if (ra->next_size != 0)
 			goto out;
 	}
 
+	if (ra->next_size == -1UL)
+		goto out;	/* Maximally shrunk */
+
 	max = get_max_readahead(file);
 	if (max == 0)
 		goto out;	/* No readahead */
+
 	min = get_min_readahead(file);
+	orig_next_size = ra->next_size;
 
 	if (ra->next_size == 0 && offset == 0) {
 		/*
@@ -224,8 +261,6 @@ void page_cache_readahead(struct file *f
 		 * window by 25%.
 		 */
 		ra->next_size -= ra->next_size / 4;
-		if (ra->next_size < min)
-			ra->next_size = min;
 	}
 
 	if (ra->next_size > max)
@@ -272,19 +307,21 @@ do_io:
 		ra->ahead_start = 0;		/* Invalidate these */
 		ra->ahead_size = 0;
 
-		do_page_cache_readahead(file, offset, ra->size);
+		actual = do_page_cache_readahead(file, offset, ra->size);
+		check_ra_success(ra, ra->size, actual, orig_next_size);
 	} else {
 		/*
-		 * This read request is within the current window.  It
-		 * is time to submit I/O for the ahead window while
-		 * the application is crunching through the current
-		 * window.
+		 * This read request is within the current window.  It is time
+		 * to submit I/O for the ahead window while the application is
+		 * crunching through the current window.
 		 */
 		if (ra->ahead_start == 0) {
 			ra->ahead_start = ra->start + ra->size;
 			ra->ahead_size = ra->next_size;
-			do_page_cache_readahead(file,
+			actual = do_page_cache_readahead(file,
 					ra->ahead_start, ra->ahead_size);
+			check_ra_success(ra, ra->ahead_size,
+					actual, orig_next_size);
 		}
 	}
 out:
@@ -298,38 +335,55 @@ out:
  */
 void page_cache_readaround(struct file *file, unsigned long offset)
 {
-	const unsigned long min = get_min_readahead(file) * 2;
-	unsigned long target;
-	unsigned long backward;
-
-	if (file->f_ra.next_size < min)
-		file->f_ra.next_size = min;
-
-	target = offset;
-	backward = file->f_ra.next_size / 4;
-
-	if (backward > target)
-		target = 0;
-	else
-		target -= backward;
-	page_cache_readahead(file, target);
+	struct file_ra_state *ra = &file->f_ra;
+
+	if (ra->next_size != -1UL) {
+		const unsigned long min = get_min_readahead(file) * 2;
+		unsigned long target;
+		unsigned long backward;
+
+		/*
+		 * If next_size is zero then leave it alone, because that's a
+		 * readahead startup state.
+		 */
+		if (ra->next_size && ra->next_size < min)
+			ra->next_size = min;
+
+		target = offset;
+		backward = ra->next_size / 4;
+
+		if (backward > target)
+			target = 0;
+		else
+			target -= backward;
+		page_cache_readahead(file, target);
+	}
 }
 
 /*
- * handle_ra_thrashing() is called when it is known that a page which should
- * have been present (it's inside the readahead window) was in fact evicted by
- * the VM.
- *
- * We shrink the readahead window by three pages.  This is because we grow it
- * by two pages on a readahead hit.  Theory being that the readahead window
- * size will stabilise around the maximum level at which there isn't any
- * thrashing.
+ * handle_ra_miss() is called when it is known that a page which should have
+ * been present in the pagecache (we just did some readahead there) was in fact
+ * not found.  This will happen if it was evicted by the VM (readahead
+ * thrashing) or if the readahead window is maximally shrunk.
+ *
+ * If the window has been maximally shrunk (next_size == 0) then bump it up
+ * again to resume readahead.
+ *
+ * Otherwise we're thrashing, so shrink the readahead window by three pages.
+ * This is because it is grown by two pages on a readahead hit.  Theory being
+ * that the readahead window size will stabilise around the maximum level at
+ * which there is no thrashing.
  */
-void handle_ra_thrashing(struct file *file)
+void handle_ra_miss(struct file *file)
 {
+	struct file_ra_state *ra = &file->f_ra;
 	const unsigned long min = get_min_readahead(file);
 
-	file->f_ra.next_size -= 3;
-	if (file->f_ra.next_size < min)
-		file->f_ra.next_size = min;
+	if (ra->next_size == -1UL) {
+		ra->next_size = min;
+	} else {
+		ra->next_size -= 3;
+		if (ra->next_size < min)
+			ra->next_size = min;
+	}
 }
--- 2.5.26/mm/filemap.c~readahead-speedup	Tue Jul 16 21:47:19 2002
+++ 2.5.26-akpm/mm/filemap.c	Tue Jul 16 21:47:19 2002
@@ -910,7 +910,7 @@ find_page:
 		page = radix_tree_lookup(&mapping->page_tree, index);
 		if (!page) {
 			read_unlock(&mapping->page_lock);
-			handle_ra_thrashing(filp);
+			handle_ra_miss(filp);
 			goto no_cached_page;
 		}
 		page_cache_get(page);
@@ -1289,6 +1289,7 @@ struct page * filemap_nopage(struct vm_a
 	struct inode *inode = mapping->host;
 	struct page *page;
 	unsigned long size, pgoff, endoff;
+	int did_readahead;
 
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
@@ -1302,31 +1303,45 @@ retry_all:
 	if ((pgoff >= size) && (area->vm_mm == current->mm))
 		return NULL;
 
-	/* The "size" of the file, as far as mmap is concerned, isn't bigger than the mapping */
+	/*
+	 * The "size" of the file, as far as mmap is concerned, isn't bigger
+	 * than the mapping
+	 */
 	if (size > endoff)
 		size = endoff;
 
+	did_readahead = 0;
+
 	/*
 	 * The readahead code wants to be told about each and every page
 	 * so it can build and shrink its windows appropriately
 	 */
-	if (VM_SequentialReadHint(area))
+	if (VM_SequentialReadHint(area)) {
+		did_readahead = 1;
 		page_cache_readahead(area->vm_file, pgoff);
+	}
 
 	/*
 	 * If the offset is outside the mapping size we're off the end
 	 * of a privately mapped file, so we need to map a zero page.
 	 */
-	if ((pgoff < size) && !VM_RandomReadHint(area))
+	if ((pgoff < size) && !VM_RandomReadHint(area)) {
+		did_readahead = 1;
 		page_cache_readaround(file, pgoff);
+	}
 
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
-	if (!page)
+	if (!page) {
+		if (did_readahead) {
+			handle_ra_miss(file);
+			did_readahead = 0;
+		}
 		goto no_cached_page;
+	}
 
 	/*
 	 * Ok, found a page in the page cache, now we need to check
--- 2.5.26/include/linux/mm.h~readahead-speedup	Tue Jul 16 21:47:19 2002
+++ 2.5.26-akpm/include/linux/mm.h	Tue Jul 16 21:47:19 2002
@@ -466,11 +466,11 @@ int write_one_page(struct page *page, in
 /* readahead.c */
 #define VM_MAX_READAHEAD	128	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
-void do_page_cache_readahead(struct file *file,
+int do_page_cache_readahead(struct file *file,
 			unsigned long offset, unsigned long nr_to_read);
 void page_cache_readahead(struct file *file, unsigned long offset);
 void page_cache_readaround(struct file *file, unsigned long offset);
-void handle_ra_thrashing(struct file *file);
+void handle_ra_miss(struct file *file);
 
 /* vma is the first one with  address < vma->vm_end,
  * and even  address < vma->vm_start. Have to extend vma. */

.
