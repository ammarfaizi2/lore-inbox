Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264545AbRFKNfm>; Mon, 11 Jun 2001 09:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264546AbRFKNfc>; Mon, 11 Jun 2001 09:35:32 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:42399 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264545AbRFKNfR>; Mon, 11 Jun 2001 09:35:17 -0400
Message-ID: <3B24C763.16E8E360@uow.edu.au>
Date: Mon, 11 Jun 2001 23:28:03 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate_inode_pages
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu> <01061018402300.05248@starship> <3B24BD57.E1D6D1D0@uow.edu.au>,
		<3B24BD57.E1D6D1D0@uow.edu.au> <01061115131301.05248@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 11 June 2001 14:45, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > On Sunday 10 June 2001 03:31, Andrew Morton wrote:
> > > > Daniel Phillips wrote:
> > > > > This is easy, just set the list head to the page about to be
> > > > > truncated.
> > > >
> > > > Works for me.
> > >
> > > It looks good, but it's black magic
> >
> > No, it's wrong.  I'm getting BUG()s in clear_inode():
> > [...]
> > The lists are mangled.
> 
> curr is being advanced in the wrong place.

Yes.

> /me makes note to self: never resist the temptation to clean things up the
> rest of the way
> 
> I'll actually apply the patch and try it this time ;-)

The bug is surprisingly hard to trigger.


Take three:


--- linux-2.4.5/mm/filemap.c	Mon May 28 13:31:49 2001
+++ linux-akpm/mm/filemap.c	Mon Jun 11 23:31:08 2001
@@ -230,17 +230,17 @@
 		unsigned long offset;
 
 		page = list_entry(curr, struct page, list);
-		curr = curr->next;
 		offset = page->index;
 
 		/* Is one of the pages to truncate? */
 		if ((offset >= start) || (*partial && (offset + 1) == start)) {
+			list_del(head);
+			list_add(head, curr);
 			if (TryLockPage(page)) {
 				page_cache_get(page);
 				spin_unlock(&pagecache_lock);
 				wait_on_page(page);
-				page_cache_release(page);
-				return 1;
+				goto out_restart;
 			}
 			page_cache_get(page);
 			spin_unlock(&pagecache_lock);
@@ -252,11 +252,15 @@
 				truncate_complete_page(page);
 
 			UnlockPage(page);
-			page_cache_release(page);
-			return 1;
+			goto out_restart;
 		}
+		curr = curr->next;
 	}
 	return 0;
+out_restart:
+	page_cache_release(page);
+	spin_lock(&pagecache_lock);
+	return 1;
 }
 
 
@@ -273,15 +277,19 @@
 {
 	unsigned long start = (lstart + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
+	int complete;
 
-repeat:
 	spin_lock(&pagecache_lock);
-	if (truncate_list_pages(&mapping->clean_pages, start, &partial))
-		goto repeat;
-	if (truncate_list_pages(&mapping->dirty_pages, start, &partial))
-		goto repeat;
-	if (truncate_list_pages(&mapping->locked_pages, start, &partial))
-		goto repeat;
+	do {
+		complete = 1;
+		while (truncate_list_pages(&mapping->clean_pages, start, &partial))
+			complete = 0;
+		while (truncate_list_pages(&mapping->dirty_pages, start, &partial))
+			complete = 0;
+		while (truncate_list_pages(&mapping->locked_pages, start, &partial))
+			complete = 0;
+	} while (!complete);
+	/* Traversed all three lists without dropping the lock */
 	spin_unlock(&pagecache_lock);
 }
