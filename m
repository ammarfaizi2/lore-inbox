Return-Path: <linux-kernel-owner+w=401wt.eu-S1945934AbWLVEzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934AbWLVEzn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 23:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945935AbWLVEzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 23:55:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43851 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945934AbWLVEzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 23:55:42 -0500
Date: Thu, 21 Dec 2006 20:54:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <20061220170323.GA12989@deprecation.cyrius.com>  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
  <20061220175309.GT30106@deprecation.cyrius.com> 
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> 
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> 
 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> 
 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> 
 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2006, Gordon Farquharson wrote:
> 
> I tested 2.6.19 with a version of Linus's patch that applies cleanly
> to 2.6.19 (patch appended to the end of this email) on ARM and apt-get
> failed. It did not segfault this time, but instead got stuck for about
> 20 to 30 minutes and was accessing the hard drive frequently.

Ok, there's definitely something screwy going on.

Andrew located at least one bug: we run cancel_dirty_page() too late in 
"truncate_complete_page()", which means that do_invalidatepage() ends up 
not clearing the page cache.

His patch is appended.

But it sounds like I probably misunderstood something, because I thought 
that Martin had acknowledged that this patch actually worked for him. 
Which sounded very similar to your setup (he has a 32M ARM box too, no?)

And your failure sounds a lot like one that David Miller is reporting. At 
the same time, my own shared file mmap tests on my own machines obviously 
work fine (I lower the dirty-writeback tresholds to force writeback more 
easily, and then mmap a file and write and rewrite to it in memory, and 
truncate it).

Maybe it's mount option issue? I've got data=ordered on my machine, are 
you perhaps runnign with something else?

		Linus

---
commit 3e67c0987d7567ad666641164a153dca9a43b11d
Author: Andrew Morton <akpm@osdl.org>
Date:   Thu Dec 21 11:00:33 2006 -0800

    [PATCH] truncate: clear page dirtiness before running try_to_free_buffers()
    
    truncate presently invalidates the dirty page's buffer_heads then shoots down
    the page.  But try_to_free_buffers() will now bale out because the page is
    dirty.
    
    Net effect: the LRU gets filled with dirty pages which have invalidated
    buffer_heads attached.  They have no ->mapping and hence cannot be cleaned.
    The machine leaks memory at an enormous rate.
    
    Fix this by cleaning the page before running try_to_free_buffers(), so
    try_to_free_buffers() can do its work.
    
    Also, remember to do dirty-page-acoounting in cancel_dirty_page() so the
    machine won't wedge up trying to write non-existent dirty pages.
    
    Probably still wrong, but now less so.
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/mm/truncate.c b/mm/truncate.c
index bf9e296..89a5c35 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -60,11 +60,12 @@ void cancel_dirty_page(struct page *page, unsigned int account_size)
 		WARN_ON(++warncount < 5);
 	}
 		
-	if (TestClearPageDirty(page) && account_size)
+	if (TestClearPageDirty(page) && account_size) {
+		dec_zone_page_state(page, NR_FILE_DIRTY);
 		task_io_account_cancelled_write(account_size);
+	}
 }
 
-
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
  * becomes anonymous.  It will be left on the LRU and may even be mapped into
@@ -81,11 +82,11 @@ truncate_complete_page(struct address_space *mapping, struct page *page)
 	if (page->mapping != mapping)
 		return;
 
+	cancel_dirty_page(page, PAGE_CACHE_SIZE);
+
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	cancel_dirty_page(page, PAGE_CACHE_SIZE);
-
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
 	remove_from_page_cache(page);
