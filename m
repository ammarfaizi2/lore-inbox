Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283780AbSAAT4h>; Tue, 1 Jan 2002 14:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283758AbSAAT41>; Tue, 1 Jan 2002 14:56:27 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:7161 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283265AbSAAT4K>; Tue, 1 Jan 2002 14:56:10 -0500
Date: Tue, 1 Jan 2002 14:56:05 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ed Tomlinson <tomlins@cam.org>, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] in 2.4.17 after 10 days uptime
Message-ID: <20020101145605.B3283@redhat.com>
In-Reply-To: <20020101071802.6E8533F2B6@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020101071802.6E8533F2B6@oscar.casa.dyndns.org>; from tomlins@cam.org on Tue, Jan 01, 2002 at 02:18:01AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 02:18:01AM -0500, Ed Tomlinson wrote:
> I started getting these bugs after about 10 days uptime.  There is a patch 
> set for reiserfs applied along with a few minor patches (ide-tape, disk 
> stats for up to hdg).  The kernel is tainted by:

Expected BUG.  Here's the fix.  Marcelo, this is what we discussed previously: 
parts of the kernel that grab a temporary reference to a page will frequently 
not use page_cache_release as the page may never have been part of the page 
cache.  This shows up with the network stack in sendpage() as well as many 
other paths.  Please apply.

:r ~/patches/v2.4.17-pglru.diff
diff -urN v2.4.17/include/linux/pagemap.h v2.4.17-pglru/include/linux/pagemap.h
--- v2.4.17/include/linux/pagemap.h	Thu Dec 20 19:30:25 2001
+++ v2.4.17-pglru/include/linux/pagemap.h	Tue Jan  1 14:46:04 2002
@@ -29,7 +29,7 @@
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
 #define page_cache_get(x)	get_page(x)
-extern void FASTCALL(page_cache_release(struct page *));
+#define page_cache_release(x)	__free_page(x)
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
diff -urN v2.4.17/kernel/ksyms.c v2.4.17-pglru/kernel/ksyms.c
--- v2.4.17/kernel/ksyms.c	Tue Jan  1 14:09:35 2002
+++ v2.4.17-pglru/kernel/ksyms.c	Tue Jan  1 14:46:55 2002
@@ -95,7 +95,6 @@
 EXPORT_SYMBOL(alloc_pages_node);
 EXPORT_SYMBOL(__get_free_pages);
 EXPORT_SYMBOL(get_zeroed_page);
-EXPORT_SYMBOL(page_cache_release);
 EXPORT_SYMBOL(__free_pages);
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);
diff -urN v2.4.17/mm/page_alloc.c v2.4.17-pglru/mm/page_alloc.c
--- v2.4.17/mm/page_alloc.c	Mon Nov 26 23:43:08 2001
+++ v2.4.17-pglru/mm/page_alloc.c	Tue Jan  1 14:44:59 2002
@@ -70,6 +70,12 @@
 	struct page *base;
 	zone_t *zone;
 
+	/* Yes, think what happens when other parts of the kernel take 
+	 * a reference to a page in order to pin it for io. -ben
+	 */
+	if (PageLRU(page))
+		lru_cache_del(page);
+
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -426,15 +432,6 @@
 	return 0;
 }
 
-void page_cache_release(struct page *page)
-{
-	if (!PageReserved(page) && put_page_testzero(page)) {
-		if (PageLRU(page))
-			lru_cache_del(page);
-		__free_pages_ok(page, 0);
-	}
-}
-
 void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page))
