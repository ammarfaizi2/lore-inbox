Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314981AbSESTeh>; Sun, 19 May 2002 15:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314984AbSESTeh>; Sun, 19 May 2002 15:34:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314981AbSESTec>;
	Sun, 19 May 2002 15:34:32 -0400
Message-ID: <3CE7FF21.30F63309@zip.com.au>
Date: Sun, 19 May 2002 12:38:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/15] fix dirty page management
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixes a bug in ext3 - when ext3 decides that it wants to fail its
writepage(), it is running SetPageDirty().  But ->writepage has just
put the page on ->clean_pages().  The page ends up dirty, on
->clean_pages and the normal writeback paths don't know about it any
more.

So run set_page_dirty() instead, to place the page back on the dirty
list.

And in move_from_swap_cache(), shuffle the page across to ->dirty_pages
so that it's eligible for writeout.  ___add_to_page_cache() forgets to
look at the page state when deciding which list to attach it to.

All SetPageDirty() callers otherwise look OK.


=====================================

--- 2.5.16/fs/ext3/inode.c~set_page_dirty	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/fs/ext3/inode.c	Sun May 19 11:49:46 2002
@@ -1325,7 +1325,7 @@ static int ext3_writepage(struct page *p
 out_fail:
 	
 	unlock_kernel();
-	SetPageDirty(page);
+	set_page_dirty(page);
 	unlock_page(page);
 	return ret;
 }
--- 2.5.16/mm/filemap.c~set_page_dirty	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/mm/filemap.c	Sun May 19 12:02:57 2002
@@ -425,6 +425,9 @@ void invalidate_inode_pages2(struct addr
  *  - activate the page so that the page stealer
  *    doesn't try to write it out over and over
  *    again.
+ *
+ * NOTE!  The livelock in fdatasync went away, due to io_pages.
+ * So this function can now call set_page_dirty().
  */
 int fail_writepage(struct page *page)
 {
--- 2.5.16/mm/swap_state.c~set_page_dirty	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/mm/swap_state.c	Sun May 19 12:02:57 2002
@@ -220,8 +220,16 @@ int move_from_swap_cache(struct page *pa
 		page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 				 1 << PG_referenced | 1 << PG_arch_1 |
 				 1 << PG_checked);
+		/*
+		 * ___add_to_page_cache puts the page on ->clean_pages,
+		 * but it's dirty.  If it's on ->clean_pages, it will basically
+		 * never get written out.
+		 */
 		SetPageDirty(page);
 		___add_to_page_cache(page, mapping, index);
+		/* fix that up */
+		list_del(&page->list);
+		list_add(&page->list, &mapping->dirty_pages);
 	}
 
 	write_unlock(&mapping->page_lock);
--- 2.5.16/mm/swapfile.c~set_page_dirty	Sun May 19 11:49:46 2002
+++ 2.5.16-akpm/mm/swapfile.c	Sun May 19 11:49:46 2002
@@ -311,6 +311,11 @@ int remove_exclusive_swap_page(struct pa
 		write_lock(&swapper_space.page_lock);
 		if (page_count(page) - !!PagePrivate(page) == 2) {
 			__delete_from_swap_cache(page);
+			/*
+			 * NOTE: if/when swap gets buffer/page coherency
+			 * like other mappings, we'll need to mark the buffers
+			 * dirty here too.  set_page_dirty().
+			 */
 			SetPageDirty(page);
 			retval = 1;
 		}


-
