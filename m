Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283481AbRLTSz7>; Thu, 20 Dec 2001 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286328AbRLTSzu>; Thu, 20 Dec 2001 13:55:50 -0500
Received: from mailbox.egenera.com ([208.51.147.22]:37393 "EHLO
	mailbox.egenera.com") by vger.kernel.org with ESMTP
	id <S283481AbRLTSzd>; Thu, 20 Dec 2001 13:55:33 -0500
Message-ID: <3C2233D2.853EC05C@egenera.com>
Date: Thu, 20 Dec 2001 13:54:10 -0500
From: "Philip R. Auld" <prauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP race in munmap/ftruncate paths
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	
	It looks like there is an SMP locking problem and race
the munmap and truncate paths.  I've hit this problem using a tree
based on the redhat 2.4.7-10 kernel, which in turn is 2.4.7-ac3 plus
some other patches. It looks like 2.4.16 still has these issues although 
this code has changed a bit.


The problem seems to be here:

filemap.c

311 static inline void set_page_dirty(struct page * page)
312 {
313         if (!test_and_set_bit(PG_dirty, &page->flags))
314                 __set_page_dirty(page);
315 }


and here

333 
334 static inline void truncate_complete_page(struct page *page)
335 {
336         int (*flushpage) (struct page *, unsigned long);
337         
338         flushpage = page->mapping->a_ops->flushpage;
339         if (!flushpage)
340                 flushpage = block_flushpage;
341         
342         /* Leave it on the LRU if it gets converted into anonymous buffers
*/
343         if (!page->buffers || flushpage(page, 0))
344                 lru_cache_del(page);
345 
346         /*
347          * We remove the page from the page cache _after_ we have
348          * destroyed all buffer-cache references to it. Otherwise some
349          * other process might think this inode page is not in the
350          * page cache and creates a buffer-cache alias to it causing
351          * all sorts of fun problems ...  
352          */
353         ClearPageDirty(page);
354         remove_inode_page(page);
355         page_cache_release(page);
356 }

The page->flags dirty bit is manipulated while the pagecache lock is not 
held. In the second case later assume the page is not marked dirty.


We get here like from munmap via the pte code:

           0xc0246cbb stext_lock+0x164f
0xdb4f3efc 0xc012ca72 __set_page_dirty+0x32 (0xc203e944)
0xdb4f3f5c 0xc01299c5 zap_page_range+0x2ed (0xf303fb40, 0x4021f000, 0x40183000)
0xdb4f3f98 0xc012c093 do_munmap+0x1d7 (0xf303fb40, 0x4021f000, 0x40182fa1,... 
0xdb4f3fbc 0xc012c13f sys_munmap+0x37 (0x4021f000, 0x40182fa1, 0x401ea094, ...
           0xc01070af system_call+0x33

In this back trace the process is now waiting on the PAGECACHE_LOCK(page) lock. 


The other process in this race hits BUG in __remove_inode_pages:


0xf7d21ef8 0xc012c7f3 __remove_inode_page+0xf (0xc203e944)
0xd36ede28 0xc012c894 remove_inode_page+0x54 (0xc203e944, 0x0)
0xd36ede6c 0xc012ce11 truncate_list_pages+0x231 (0xd36ede94)
0xd36ede98 0xc012cf23 truncate_inode_pages+0x8b (0xf2c80ef8, 0x24, 0x0)
0xd36eded4 0xc012a8c4 vmtruncate+0xb8 (0xf2c80e40, 0x24, 0x0)
0xd36edef8 0xc0152c37 inode_setattr+0x2b (0xf2c80e40, 0xd36edf64)
0xd36edf14 0xc016e652 reiserfs_setattr+0x76 (0xf2dd68c0, 0xd36edf64)
0xd36edf3c 0xc0152dbd notify_change+0x79 (0xf2dd68c0, 0xd36edf64)
0xd36edf8c 0xc013ae29 do_truncate+0x61 (0xf2dd68c0, 0x24, 0x0)
0xd36edfbc 0xc013b12b sys_ftruncate+0x12f (0x3, 0x24, 0x401ea094, 0xbffff778...
           0xc01070af system_call+0x33


Basically what happens is:

cpu0 doing truncate			cpu1 doing munmap
...					...	
truncate_inode_pages ->
->truncate_list_pages(dirty-list)
clear page dirty bit			
					->set_page_dirty
					test_and_set_bit(PG_dirty, &page->flags)
->remove_inode_page			->__set_page_dirty
lock (pg_cache_lock)			
lock (mapping->page_lock)
->__remove_inode_pages			lock (pg_cache_lock)->spin
	if (pageDirty) BUG



Below is a patch against the 2.4.7-ac3+ tree that fixes the set_page_dirty
half. This will fix this instance, but there may be others because of the 
space between the clear bit and lock in the other path. The BKL _is_ held
on the truncate path, but not on the munmap path. Maybe this is the real
problem?




Cheers,


Phil


Index: include/linux/mm.h
===================================================================
RCS file: /build/vault/linux2.4/include/linux/mm.h,v
retrieving revision 1.6
diff -u -r1.6 mm.h
--- include/linux/mm.h	2001/12/10 17:27:34	1.6
+++ include/linux/mm.h	2001/12/20 17:25:14
@@ -310,8 +310,7 @@
 
 static inline void set_page_dirty(struct page * page)
 {
-	if (!test_and_set_bit(PG_dirty, &page->flags))
-		__set_page_dirty(page);
+	__set_page_dirty(page);
 }
 
 /*
Index: mm/filemap.c
===================================================================
RCS file: /build/vault/linux2.4/mm/filemap.c,v
retrieving revision 1.5
diff -u -r1.5 filemap.c
--- mm/filemap.c	2001/10/19 03:48:00	1.5
+++ mm/filemap.c	2001/12/20 18:08:45
@@ -241,17 +241,22 @@
 	pg_lock = PAGECACHE_LOCK(page);
 	spin_lock(pg_lock);
 
-	mapping = page->mapping;
-	spin_lock(&mapping->page_lock);
+	if (!test_and_set_bit(PG_dirty, &page->flags)){
+		mapping = page->mapping;
+		spin_lock(&mapping->page_lock);
+		
+		list_del(&page->list);
+		list_add(&page->list, &mapping->dirty_pages);
 
-	list_del(&page->list);
-	list_add(&page->list, &mapping->dirty_pages);
+		spin_unlock(&mapping->page_lock);
+       	spin_unlock(pg_lock);
 
-	spin_unlock(&mapping->page_lock);
+		if (mapping->host)
+			mark_inode_dirty_pages(mapping->host);
+		return;
+	}
+		
 	spin_unlock(pg_lock);
-
-	if (mapping->host)
-		mark_inode_dirty_pages(mapping->host);
 }
 
 /**


------------------------------------------------------
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
