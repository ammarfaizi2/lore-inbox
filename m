Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVKGC7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVKGC7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 21:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVKGC7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 21:59:45 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:42126 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932413AbVKGC7o (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 21:59:44 -0500
Date: Sun, 6 Nov 2005 22:00:05 -0500
From: Bob Picco <bob.picco@hp.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Bob Picco <bob.picco@hp.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 7/14] mm: remove bad_range
Message-ID: <20051107030005.GM28839@localhost.localdomain>
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <20051106173732.GI28839@localhost.localdomain> <436EA6B2.3070807@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436EA6B2.3070807@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:	[Sun Nov 06 2005, 07:58:26PM EST]
> Bob Picco wrote:
> >Nick Piggin wrote:	[Sun Nov 06 2005, 03:24:40AM EST]
> >
> >>7/14
> >>
> >>-- 
> >>SUSE Labs, Novell Inc.
> >>
> >
> >
> >>bad_range is supposed to be a temporary check. It would be a pity to throw
> >>it out. Make it depend on CONFIG_DEBUG_VM instead.
> >>
> >>Index: linux-2.6/mm/page_alloc.c
> >>===================================================================
> >>--- linux-2.6.orig/mm/page_alloc.c
> >>+++ linux-2.6/mm/page_alloc.c
> >>@@ -78,6 +78,7 @@ int min_free_kbytes = 1024;
> >>unsigned long __initdata nr_kernel_pages;
> >>unsigned long __initdata nr_all_pages;
> >>
> >>+#ifdef CONFIG_DEBUG_VM
> >>static int page_outside_zone_boundaries(struct zone *zone, struct page 
> >>*page)
> >>{
> >>	int ret = 0;
> >>@@ -119,6 +120,13 @@ static int bad_range(struct zone *zone, 
> >>	return 0;
> >>}
> >>
> >>+#else
> >>+static inline int bad_range(struct zone *zone, struct page *page)
> >>+{
> >>+	return 0;
> >>+}
> >>+#endif
> >>+
> >>static void bad_page(const char *function, struct page *page)
> >>{
> >>	printk(KERN_EMERG "Bad page state at %s (in process '%s', page 
> >>	%p)\n",
> >>Index: linux-2.6/lib/Kconfig.debug
> >>===================================================================
> >>--- linux-2.6.orig/lib/Kconfig.debug
> >>+++ linux-2.6/lib/Kconfig.debug
> >>@@ -172,7 +172,8 @@ config DEBUG_VM
> >>	bool "Debug VM"
> >>	depends on DEBUG_KERNEL
> >>	help
> >>-	  Enable this to debug the virtual-memory system.
> >>+	  Enable this to turn on extended checks in the virtual-memory system
> >>+          that may impact performance.
> >>
> >>	  If unsure, say N.
> >>
> >
> >Nick,
> >
> >I don't think you can do it this way. On ia64 VIRTUAL_MEM_MAP depends on 
> >CONFIG_HOLES_IN_ZONE and the check within bad_range for pfn_valid. Holes in
> >memory (MMIO and etc.) won't have a page structure.
> >
> 
> Hmm, right - in __free_pages_bulk.
> 
> Could we make a different call here, or is the full array of bad_range
> checks required?
Not the full array. Just the pfn_valid call. Seems CONFIG_HOLES_IN_ZONE is
already in page_alloc.c, perhaps just in __free_pages_bulk as a replacement
for the bad_range call which isn't within a  BUG_ON check. It's somewhat of a 
wart but already there. Otherwise we might want arch_holes_in_zone inline 
which is only required by ia64 and noop for other arches.

The only place I didn't look closely is the BUG_ON in expand. I'll do that
tomorrow.
> 
> Thanks,
> Nick
> 
> -- 
your welcome,

bob
