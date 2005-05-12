Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVELVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVELVYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVELVY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:24:28 -0400
Received: from mail.suse.de ([195.135.220.2]:45215 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262130AbVELVXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:23:35 -0400
Date: Thu, 12 May 2005 23:23:19 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       Christopher Warner <chris@servertogo.com>,
       Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050512212319.GE15965@wotan.suse.de>
References: <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <1115717814.7679.2.camel@jasmine> <20050510163851.GA1128@redhat.com> <20050510164649.GL25612@wotan.suse.de> <20050510165938.GA11835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510165938.GA11835@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 12:59:38PM -0400, Dave Jones wrote:
> On Tue, May 10, 2005 at 06:46:49PM +0200, Andi Kleen wrote:
>  > On Tue, May 10, 2005 at 12:38:51PM -0400, Dave Jones wrote:
>  > > On Tue, May 10, 2005 at 05:36:54AM -0400, Christopher Warner wrote:
>  > >  > 2.6.11.5 kernel,
>  > >  > Tyan S2882/dual AMD 246 opterons
>  > >  > sh:18983: mm/memory.c:99: bad pmd ffff810005974cc8(00007ffffffffe46). 
>  > >  > sh:18983: mm/memory.c:99: bad pmd ffff810005974cd0(00007ffffffffe47).
>  > > 
>  > > That's the 3rd or 4th time I've seen this reported on this hardware.
>  > > It's not exclusive to it, but it does seem more susceptible
>  > > for some reason. Spooky.
>  > 
>  > It seems to be clear now that it is hardware independent.
>  > 
>  > I actually got it once now too, but only after 24+h stress test :/
>  > 
>  > I have a better debugging patch now that I will be testing soon,
>  > hopefully that turns something up.
> 
> Ok, I'm respinning the Fedora update kernel today for other
> reasons, if you have that patch in time, I'll toss it in too.
> 
> Though as yet, no further reports from our users.

Here's the new patch. However it costs some memory bloat because
I added a new field to struct page 

-Andi


Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -912,6 +912,7 @@ nopage:
 	return NULL;
 got_pg:
 	zone_statistics(zonelist, z);
+	page->freer = (void *)-1ULL; 
 	return page;
 }
 
@@ -962,13 +963,16 @@ void __pagevec_free(struct pagevec *pvec
 {
 	int i = pagevec_count(pvec);
 
-	while (--i >= 0)
+	while (--i >= 0) {
+		pvec->pages[i]->freer = (void *)__builtin_return_address(0);
 		free_hot_cold_page(pvec->pages[i], pvec->cold);
+	}
 }
 
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page)) {
+		page->freer = (void *)__builtin_return_address(0);
 		if (order == 0)
 			free_hot_page(page);
 		else
@@ -1595,6 +1599,7 @@ void __init memmap_init_zone(unsigned lo
 	struct page *page;
 
 	for (page = start; page < (start + size); page++) {
+		page->freer = NULL;
 		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -261,6 +261,7 @@ struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+	void *freer;
 };
 
 /*
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c
+++ linux/mm/memory.c
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kallsyms.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -108,6 +109,14 @@ static inline void clear_pmd_range(struc
 
 	pmd = pmd_offset(pud, addr);
 
+	{
+	struct page *p = virt_to_page(pmd); 
+	if (page_count(p) < 1) {
+		printk("%s:%d free pmd %lx ", current->comm, current->pid, addr); 
+		print_symbol("freed by %s\n", (unsigned long)p->freer); 
+	}
+	}
+
 	/* Only free fully aligned ranges */
 	if (!((addr | end) & ~PUD_MASK))
 		empty_pmd = pmd;
