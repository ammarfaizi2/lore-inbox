Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVCQBfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVCQBfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVCQBfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:35:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64191 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262940AbVCQBes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:34:48 -0500
Date: Wed, 16 Mar 2005 17:33:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <1110490683.24355.17.camel@localhost> <Pine.LNX.4.58.0503101702120.15940@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Denis Vlasenko wrote:

> Andi Kleen (iirc) says that non-temporal stores seem to be
> big win in microbenchmarks (and I second that), but they are
> a net loss when we are going to use zeroed page just after
> zeroing. He recommends avoid using non-temporal stores
>
> With this new page prezeroing infrastructure, that argument
> most likely is not right anymore. Especially clearing of
> high-order pages definitely will benefit from NT stores
> because they do not kill L1 data cache in the process.
>
> I don't have K8 and therefore cannot be 100% sure, but
> I really doubt that K8 optimize "rep stosq" into _NT_ stores.

Hmm. That would be interesting to know and may be necessary to justify
the continued existence of this patch. I tried to get some numbers on
the performance wins for zeroing larger pages with the patch as is (no
NT stores) and came up with:

Processor				Performance Increase
----------------------------------------------------------------
Itanium 2 1.3Ghz M1/R5			1.5%
AMD Athlon 64 3200+ i386 mode		3%
AMD Athlon 64 3200+ x86_64 mode		3.3%

(this is if the zeroing engine is the cpu of course. Prezeroing
may be done through some DMA gizmo independent of the cpu)

Itanium has more extensive optimization capabilities and
seems to be able to better cope with the loop logic for regular
clear_page. Thus the improvement is even less on Itanium.

Numbers obtained with the following patch that allows to get performance
data from /proc/meminfo on zeroing performance (just divide Cycles by
Pages for clear_page and clear_pages):

Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-16 17:12:51.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-16 17:17:28.000000000 -0800
@@ -633,13 +633,33 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }

-static inline void prep_zero_page(struct page *page, int order, int gfp_flags)
+void prep_zero_page(struct page *page, unsigned int order, unsigned int gfp_flags)
 {
 	int i;
+	unsigned long t1;

 	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+
+#ifdef CONFIG_CLEAR_PAGES
+	if (!PageHighMem(page) && order>4) {
+		unsigned long t;
+
+		t1=get_cycles();
+		clear_pages(page_address(page), order);
+		t = get_cycles() - t1;
+		add_page_state(clear_pages_cycles, t);
+		add_page_state(clear_pages_order, 1 << order);
+		inc_page_state(clear_pages_nr);
+		return;
+	}
+#endif
+
+	t1=get_cycles();
 	for(i = 0; i < (1 << order); i++)
 		clear_highpage(page + i);
+	add_page_state(clear_page_cycles, get_cycles() - t1);
+	add_page_state(clear_page_order, 1 << order);
+	inc_page_state(clear_page_nr);
 }

 /*
Index: linux-2.6.11/include/linux/page-flags.h
===================================================================
--- linux-2.6.11.orig/include/linux/page-flags.h	2005-03-16 17:12:51.000000000 -0800
+++ linux-2.6.11/include/linux/page-flags.h	2005-03-16 17:13:02.000000000 -0800
@@ -131,6 +131,13 @@ struct page_state {
 	unsigned long allocstall;	/* direct reclaim calls */

 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
+
+	unsigned long clear_page_nr;	/* Nr of clear_page request */
+	unsigned long clear_page_cycles; /* Cycles spent in clear_page */
+	unsigned long clear_page_order;	/* Sum of orders */
+	unsigned long clear_pages_nr;	/* Nr of clear_pages requests */
+	unsigned long clear_pages_cycles;	/* Nr of cycles in clear_pages */
+	unsigned long clear_pages_order;	/* Sum of orders */
 };

 extern void get_page_state(struct page_state *ret);
Index: linux-2.6.11/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.11.orig/fs/proc/proc_misc.c	2005-03-16 17:12:50.000000000 -0800
+++ linux-2.6.11/fs/proc/proc_misc.c	2005-03-16 17:22:18.000000000 -0800
@@ -127,7 +127,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long allowed;
 	struct vmalloc_info vmi;

-	get_page_state(&ps);
+	get_full_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);

 /*
@@ -168,7 +168,13 @@ static int meminfo_read_proc(char *page,
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
-		"VmallocChunk: %8lu kB\n",
+		"VmallocChunk: %8lu kB\n"
+		"ClearPage #   %8lu\n"
+		"ClearPage Pgs %8lu\n"
+		"ClearPage Cyc %8lu\n"
+		"ClearPages #  %8lu\n"
+		"ClearPages Pg %8lu\n"
+		"ClearPages Cy %8lu\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.bufferram),
@@ -191,7 +197,13 @@ static int meminfo_read_proc(char *page,
 		K(ps.nr_page_table_pages),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
-		vmi.largest_chunk >> 10
+		vmi.largest_chunk >> 10,
+		ps.clear_page_nr,
+		ps.clear_page_order,
+		ps.clear_page_cycles,
+		ps.clear_pages_nr,
+		ps.clear_pages_order,
+		ps.clear_pages_cycles
 		);

 		len += hugetlb_report_meminfo(page + len);

