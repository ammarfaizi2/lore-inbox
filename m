Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUDBQqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUDBQqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:46:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22414
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264101AbUDBQqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:46:33 -0500
Date: Fri, 2 Apr 2004 18:46:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402164634.GF21341@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402104334.A871@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 10:43:34AM +0100, Christoph Hellwig wrote:
> I got lots of the following OOPSEs with 2.6.5-rc3aa2 on a powerpc running
> the xfs testsuite (with the truncate fix applied):
> 
> Apr  2 13:27:21 bird kernel: Bad page state at destroy_compound_page (in process 'swapper', page c08d9920)
> Apr  2 13:27:21 bird kernel: flags:0x00000008 mapping:00000000 mapped:0 count:0
> Apr  2 13:27:21 bird kernel: Backtrace:
> Apr  2 13:27:21 bird kernel: Call trace:
> Apr  2 13:27:21 bird kernel:  [c000b5c8] dump_stack+0x18/0x28
> Apr  2 13:27:21 bird kernel:  [c0048b60] bad_page+0x70/0xb0
> Apr  2 13:27:21 bird kernel:  [c0048c70] destroy_compound_page+0x80/0xb8

it's not clear why this triggered, bad_page only shows the "master"
compound page and not the contents of the slave page that triggered the
bad_page. Can you try again with this incremental patch applied?
Thanks!

--- x/mm/page_alloc.c.~1~	2004-04-02 05:24:50.000000000 +0200
+++ x/mm/page_alloc.c	2004-04-02 18:32:53.189244408 +0200
@@ -73,9 +73,9 @@ static void bad_page(const char *functio
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
 		function, current->comm, page);
-	printk(KERN_EMERG "flags:0x%08lx mapping:%p mapped:%d count:%d\n",
+	printk(KERN_EMERG "flags:0x%08lx mapping:%p mapped:%d count:%d private:0x%08lx\n",
 		(unsigned long)page->flags, page->mapping,
-		page_mapped(page), page_count(page));
+		page_mapped(page), page_count(page), page->private);
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
@@ -137,9 +137,9 @@ static void destroy_compound_page(struct
 		struct page *p = page + i;
 
 		if (!PageCompound(p))
-			bad_page(__FUNCTION__, page);
+			bad_page(__FUNCTION__, p);
 		if (p->private != (unsigned long)page)
-			bad_page(__FUNCTION__, page);
+			bad_page(__FUNCTION__, p);
 		ClearPageCompound(p);
 	}
 }
@@ -272,8 +272,12 @@ void __free_pages_ok(struct page *page, 
 	int i;
 
 	mod_page_state(pgfree, 1 << order);
-	for (i = 0 ; i < (1 << order) ; ++i)
-		free_pages_check(__FUNCTION__, page + i);
+	for (i = 0 ; i < (1 << order) ; ++i) {
+		struct page * _page = page + i;
+		if (unlikely(i))
+			 __put_page(_page);
+		free_pages_check(__FUNCTION__, _page);
+	}
 	list_add(&page->lru, &list);
 	kernel_map_pages(page, 1<<order, 0);
 	free_pages_bulk(page_zone(page), 1, &list, order);
@@ -316,19 +320,21 @@ static void prep_new_page(struct page * 
 		    (page->flags & (
 				    1 << PG_private	|
 				    1 << PG_locked	|
-				    1 << PG_lru	|
+				    1 << PG_lru	        |
 				    1 << PG_active	|
 				    1 << PG_dirty	|
 				    1 << PG_reclaim	|
 				    1 << PG_anon	|
 				    1 << PG_maplock	|
 				    1 << PG_swapcache	|
-				    1 << PG_writeback )))
+				    1 << PG_writeback   |
+				    1 << PG_compound )))
 			bad_page(__FUNCTION__, page);
 
 		page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
 				 1 << PG_referenced | 1 << PG_arch_1 |
-				 1 << PG_checked | 1 << PG_mappedtodisk);
+				 1 << PG_checked | 1 << PG_mappedtodisk |
+				 1 << PG_compound);
 		page->private = 0;
 		set_page_count(page, 1);
 	}


this incrmental bit made some harmless warning go away from swap resume,
but it didn't fix swap resume completely yet OTOH I'm not sure anymore
if there's any further VM issue or if it's a swap suspend issue. the
PageCompound bugcheck would already trap any compound page in
rw_swap_page_sync, so I'm sure nobody tried to swap compound pages in
swap resume, and I'm also sure that the page->count is now correct, or
free_pages_check would trigger. I cannot trigger any further bugcheck
here (and the above patch only shutdown some false positive that
couldn't hurt functionality, plus it adds further bugchecks).
