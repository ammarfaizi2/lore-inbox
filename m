Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUENDoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUENDoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 23:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUENDog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 23:44:36 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:53356 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263827AbUENDoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 23:44:32 -0400
Message-ID: <40A438AC.9020506@yahoo.com.au>
Date: Fri, 14 May 2004 13:10:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, hugh@veritas.com
CC: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
References: <40A42892.5040802@yahoo.com.au> <20040513193328.11479d3e.akpm@osdl.org> <40A43152.4090400@yahoo.com.au>
In-Reply-To: <40A43152.4090400@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040608070701080406080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040608070701080406080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>> OK, I made a debug patch to printk and schedule_timeout in this
>>> race window so I can easily truncate the file. When this happens,
>>> it turns out that the readpage thinks it is reading a hole and
>>> fills the page with zeros -> invalid result?
>>
>>
>>
>> A zero-filled pagecache page outside i_size is OK.
>>
> 
> Yes. But in this case the zero filled page actually gets
> read by read(2).
> 
> In any case, I think my patch won't close the race completely.
> 

This following patch should be right.

It causes the zeros to not get copied back unless i_size
gets extended again.

--------------040608070701080406080902
Content-Type: text/x-patch;
 name="truncate-vs-add_to_page_cache2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="truncate-vs-add_to_page_cache2.patch"

 linux-2.6-npiggin/mm/filemap.c |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff -puN mm/filemap.c~truncate-vs-add_to_page_cache2 mm/filemap.c
--- linux-2.6/mm/filemap.c~truncate-vs-add_to_page_cache2	2004-05-14 12:54:42.000000000 +1000
+++ linux-2.6-npiggin/mm/filemap.c	2004-05-14 13:09:16.000000000 +1000
@@ -661,23 +661,11 @@ void do_generic_mapping_read(struct addr
 	for (;;) {
 		struct page *page;
 		unsigned long end_index, nr, ret;
-		loff_t isize = i_size_read(inode);
-
-		end_index = isize >> PAGE_CACHE_SHIFT;
-			
-		if (index > end_index)
-			break;
-		nr = PAGE_CACHE_SIZE;
-		if (index == end_index) {
-			nr = isize & ~PAGE_CACHE_MASK;
-			if (nr <= offset)
-				break;
-		}
+		loff_t isize;
 
 		cond_resched();
 		page_cache_readahead(mapping, &ra, filp, index);
 
-		nr = nr - offset;
 find_page:
 		page = find_get_page(mapping, index);
 		if (unlikely(page == NULL)) {
@@ -687,6 +675,30 @@ find_page:
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
+		/*
+		 * i_size must be checked after we have a reference
+		 * to the uptodate page. Checking i_size before readpage
+		 * can cause a racing truncate to cause readpage to see
+		 * the truncated i_size and zero-fill the page.
+		 *
+		 * Checking i_size after the readpage allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file, this is not a problem).
+		 */
+		isize = i_size_read(inode);
+		end_index = isize >> PAGE_CACHE_SHIFT;
+		if (index > end_index)
+			break;
+
+		nr = PAGE_CACHE_SIZE;
+		if (index == end_index) {
+			nr = isize & ~PAGE_CACHE_MASK;
+			if (nr <= offset)
+				break;
+		}
+		nr = nr - offset;
+
 		/* If users can be writing to this page using arbitrary
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
@@ -721,9 +733,6 @@ page_ok:
 		break;
 
 page_not_up_to_date:
-		if (PageUptodate(page))
-			goto page_ok;
-
 		/* Get exclusive access to the page ... */
 		lock_page(page);
 

_

--------------040608070701080406080902--
