Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUENC1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUENC1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUENC1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:27:18 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:41606 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264373AbUENC1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:27:04 -0400
Message-ID: <40A42892.5040802@yahoo.com.au>
Date: Fri, 14 May 2004 12:01:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] truncate vs add_to_page_cache race
Content-Type: multipart/mixed;
 boundary="------------050109030006010700070304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050109030006010700070304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I think there is a race between truncate and do_generic_mapping_read.

do_generic_mapping_read()
{
	check i_size -> ok
no_cached_page:
	allocate a page
	add_to_page_cache
	readpage
}

And what can happen is truncate gets to the file after i_size is
checked and before the page is added to the page cache.

I asked Hugh about this because a quick search showed he was the
last one to make a noise about this kind of thing. He wasn't up
to speed with the current code, but agreed it looks fishy.

OK, I made a debug patch to printk and schedule_timeout in this
race window so I can easily truncate the file. When this happens,
it turns out that the readpage thinks it is reading a hole and
fills the page with zeros -> invalid result?

I have attached a patch which uses i_lock to close this race
AFAIKS. Lightly tested only. I can't experimentally verify
that it closes the race because I have not been able to reproduce
it without changing the code.

Comments? Too ugly? Have I've missed something?

--------------050109030006010700070304
Content-Type: text/x-patch;
 name="truncate-vs-add_to_page_cache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="truncate-vs-add_to_page_cache.patch"

 linux-2.6-npiggin/mm/filemap.c |   39 +++++++++++++++++++++++++++------------
 linux-2.6-npiggin/mm/memory.c  |    9 +++++++++
 linux-2.6-npiggin/mm/nommu.c   |    8 ++++++++
 mm/readahead.c                 |    0 
 4 files changed, 44 insertions(+), 12 deletions(-)

diff -puN mm/filemap.c~truncate-vs-add_to_page_cache mm/filemap.c
--- linux-2.6/mm/filemap.c~truncate-vs-add_to_page_cache	2004-05-14 11:16:03.000000000 +1000
+++ linux-2.6-npiggin/mm/filemap.c	2004-05-14 11:55:46.000000000 +1000
@@ -78,6 +78,9 @@
  *  ->i_sem
  *    ->i_alloc_sem             (various)
  *
+ *  ->i_lock			(do_generic_mapping_read)
+ *    ->mapping->tree_lock	(add_to_page_cache)
+ *
  *  ->inode_lock
  *    ->sb_lock			(fs/fs-writeback.c)
  *    ->mapping->tree_lock	(__sync_single_inode)
@@ -649,8 +652,9 @@ void do_generic_mapping_read(struct addr
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, offset;
+	unsigned long index, end_index, offset;
 	struct page *cached_page;
+	loff_t isize;
 	int error;
 	struct file_ra_state ra = *_ra;
 
@@ -658,26 +662,28 @@ void do_generic_mapping_read(struct addr
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
+	isize = i_size_read(inode);
+	end_index = isize >> PAGE_CACHE_SHIFT;
+	if (index > end_index)
+		goto out;
+
 	for (;;) {
 		struct page *page;
-		unsigned long end_index, nr, ret;
-		loff_t isize = i_size_read(inode);
+		unsigned long nr, ret;
 
-		end_index = isize >> PAGE_CACHE_SHIFT;
-			
-		if (index > end_index)
-			break;
+		cond_resched();
+
+		/* Establish the number of bytes to read from this page */
 		nr = PAGE_CACHE_SIZE;
 		if (index == end_index) {
 			nr = isize & ~PAGE_CACHE_MASK;
 			if (nr <= offset)
 				break;
 		}
+		nr = nr - offset;
 
-		cond_resched();
 		page_cache_readahead(mapping, &ra, filp, index);
 
-		nr = nr - offset;
 find_page:
 		page = find_get_page(mapping, index);
 		if (unlikely(page == NULL)) {
@@ -721,9 +727,6 @@ page_ok:
 		break;
 
 page_not_up_to_date:
-		if (PageUptodate(page))
-			goto page_ok;
-
 		/* Get exclusive access to the page ... */
 		lock_page(page);
 
@@ -770,8 +773,19 @@ no_cached_page:
 				break;
 			}
 		}
+
+		/* Take the i_lock to protect against a concurrent truncate */
+		spin_lock(&inode->i_lock);
+		isize = i_size_read(inode);
+		end_index = isize >> PAGE_CACHE_SHIFT;
+		if (index > end_index) {
+			spin_unlock(&inode->i_lock);
+			goto out;
+		}
 		error = add_to_page_cache_lru(cached_page, mapping,
 						index, GFP_KERNEL);
+		spin_unlock(&inode->i_lock);
+
 		if (error) {
 			if (error == -EEXIST)
 				goto find_page;
@@ -783,6 +797,7 @@ no_cached_page:
 		goto readpage;
 	}
 
+out:
 	*_ra = ra;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
diff -puN mm/memory.c~truncate-vs-add_to_page_cache mm/memory.c
--- linux-2.6/mm/memory.c~truncate-vs-add_to_page_cache	2004-05-14 11:18:26.000000000 +1000
+++ linux-2.6-npiggin/mm/memory.c	2004-05-14 11:31:27.000000000 +1000
@@ -1222,7 +1222,16 @@ int vmtruncate(struct inode * inode, lof
 
 	if (inode->i_size < offset)
 		goto do_expand;
+	
+	/*
+	 * Need i_lock to serialise against a concurrent reader adding a new
+	 * page to the pagecache. See mm/filemap.c.
+	 *
+	 * This isn't needed if i_size is being expanded.
+	 */
+	spin_lock(&inode->i_lock);
 	i_size_write(inode, offset);
+	spin_unlock(&inode->i_lock);
 	unmap_mapping_range(mapping, offset + PAGE_SIZE - 1, 0, 1);
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
diff -puN mm/nommu.c~truncate-vs-add_to_page_cache mm/nommu.c
--- linux-2.6/mm/nommu.c~truncate-vs-add_to_page_cache	2004-05-14 11:18:29.000000000 +1000
+++ linux-2.6-npiggin/mm/nommu.c	2004-05-14 11:31:55.000000000 +1000
@@ -48,7 +48,15 @@ int vmtruncate(struct inode *inode, loff
 
 	if (inode->i_size < offset)
 		goto do_expand;
+	/*
+	 * Need i_lock to serialise against a concurrent reader adding a new
+	 * page to the pagecache. See mm/filemap.c.
+	 *
+	 * This isn't needed if i_size is being expanded.
+	 */
+	spin_lock(&inode->i_lock);
 	i_size_write(inode, offset);
+	spin_unlock(&inode->i_lock);
 
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
diff -puN mm/readahead.c~truncate-vs-add_to_page_cache mm/readahead.c

_

--------------050109030006010700070304--
