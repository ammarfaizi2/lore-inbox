Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTDOF7e (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTDOF7e (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:59:34 -0400
Received: from holomorphy.com ([66.224.33.161]:8069 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264311AbTDOF7b (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:59:31 -0400
Date: Mon, 14 Apr 2003 23:10:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-ID: <20030415061058.GG706@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030415020057.GC706@holomorphy.com> <20030415041759.GA12487@holomorphy.com> <20030414213114.37dc7879.akpm@digeo.com> <20030415043947.GD706@holomorphy.com> <20030414215541.0aff47bc.akpm@digeo.com> <20030415060907.GB12487@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415060907.GB12487@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:09:07PM -0700, William Lee Irwin III wrote:
> Okay, these don't get us all the way there, but at least it gets us
> closer: there are "FIXME" things associated with intrusions of the
> old buffer_cache (as opposed to the new buffer cache a.k.a. pagecache)
> into the core VM.
> The first is simply:
> Move __set_page_dirty_buffers() to fs/buffer.c, as per the FIXME.

On top of the __set_page_dirty_buffers() patch:


Remove page_has_buffers() from various functions, document the
dependencies on buffer_head.h from other files besides filemap.c,
and s/this file/core VM/ in filemap.c


diff -urpN mm3-2.5.67-2B/mm/filemap.c mm3-2.5.67-3B/mm/filemap.c
--- mm3-2.5.67-2B/mm/filemap.c	2003-04-14 18:08:15.000000000 -0700
+++ mm3-2.5.67-3B/mm/filemap.c	2003-04-14 22:43:08.000000000 -0700
@@ -31,12 +31,11 @@
  * This is needed for the following functions:
  *  - try_to_release_page
  *  - block_invalidatepage
- *  - page_has_buffers
  *  - generic_osync_inode
  *
- * FIXME: remove all knowledge of the buffer layer from this file
+ * FIXME: remove all knowledge of the buffer layer from the core VM
  */
-#include <linux/buffer_head.h>
+#include <linux/buffer_head.h> /* for generic_osync_inode */
 
 #include <asm/uaccess.h>
 #include <asm/mman.h>
diff -urpN mm3-2.5.67-2B/mm/swap.c mm3-2.5.67-3B/mm/swap.c
--- mm3-2.5.67-2B/mm/swap.c	2003-04-07 10:31:05.000000000 -0700
+++ mm3-2.5.67-3B/mm/swap.c	2003-04-14 22:43:49.000000000 -0700
@@ -21,7 +21,7 @@
 #include <linux/pagevec.h>
 #include <linux/init.h>
 #include <linux/mm_inline.h>
-#include <linux/buffer_head.h>
+#include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/percpu.h>
 
 /* How many pages do we try to swap or page in/out together? */
diff -urpN mm3-2.5.67-2B/mm/swap_state.c mm3-2.5.67-3B/mm/swap_state.c
--- mm3-2.5.67-2B/mm/swap_state.c	2003-04-14 18:08:15.000000000 -0700
+++ mm3-2.5.67-3B/mm/swap_state.c	2003-04-14 22:28:20.000000000 -0700
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
-#include <linux/buffer_head.h>	/* block_sync_page() */
 
 #include <asm/pgtable.h>
 
@@ -187,7 +186,7 @@ void delete_from_swap_cache(struct page 
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-	BUG_ON(page_has_buffers(page));
+	BUG_ON(PagePrivate(page));
   
 	entry.val = page->index;
 
@@ -236,7 +235,7 @@ int move_from_swap_cache(struct page *pa
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-	BUG_ON(page_has_buffers(page));
+	BUG_ON(PagePrivate(page));
 
 	entry.val = page->index;
 
diff -urpN mm3-2.5.67-2B/mm/swapfile.c mm3-2.5.67-3B/mm/swapfile.c
--- mm3-2.5.67-2B/mm/swapfile.c	2003-04-14 18:08:15.000000000 -0700
+++ mm3-2.5.67-3B/mm/swapfile.c	2003-04-14 22:27:57.000000000 -0700
@@ -15,7 +15,6 @@
 #include <linux/namei.h>
 #include <linux/shm.h>
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -300,7 +299,7 @@ int remove_exclusive_swap_page(struct pa
 	struct swap_info_struct * p;
 	swp_entry_t entry;
 
-	BUG_ON(page_has_buffers(page));
+	BUG_ON(PagePrivate(page));
 	BUG_ON(!PageLocked(page));
 
 	if (!PageSwapCache(page))
@@ -355,7 +354,7 @@ void free_swap_and_cache(swp_entry_t ent
 	if (page) {
 		int one_user;
 
-		BUG_ON(page_has_buffers(page));
+		BUG_ON(PagePrivate(page));
 		page_cache_get(page);
 		one_user = (page_count(page) == 2);
 		/* Only cache user (+us), or swap space full? Free it! */
diff -urpN mm3-2.5.67-2B/mm/vmscan.c mm3-2.5.67-3B/mm/vmscan.c
--- mm3-2.5.67-2B/mm/vmscan.c	2003-04-14 18:08:15.000000000 -0700
+++ mm3-2.5.67-3B/mm/vmscan.c	2003-04-14 22:45:19.000000000 -0700
@@ -22,7 +22,8 @@
 #include <linux/writeback.h>
 #include <linux/suspend.h>
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>		/* for try_to_release_page() */
+#include <linux/buffer_head.h>	/* for try_to_release_page(),
+					buffer_heads_over_limit */
 #include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
