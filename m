Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTFXIAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTFXIAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:00:47 -0400
Received: from holomorphy.com ([66.224.33.161]:36301 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264231AbTFXIAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:00:44 -0400
Date: Tue, 24 Jun 2003 01:14:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm1
Message-ID: <20030624081445.GN26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030623232908.036a1bd2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623232908.036a1bd2.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 11:29:08PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm1/
> . PCI and PCMCIA updates
> . Make sysrq-T print the right thing.
> . Hopefully fix most of the time-goes-too-slowly problems.
> . Various other fixes.

This trivial patch allows architectures to micro-optimize
lowmem_page_address() at their whims. Roman Zippel originally wrote
and/or suggested this back when dependencies on page->virtual existing
were being shaken out. That's long-settled, so it's fine to do this now.

It's not much, but hopefully it'll start the flow of my various new
patches back to mainline.


-- wli


diff -prauN wli-2.5.73-1/include/linux/mm.h wli-2.5.73-2/include/linux/mm.h
--- wli-2.5.73-1/include/linux/mm.h	2003-06-22 11:32:31.000000000 -0700
+++ wli-2.5.73-2/include/linux/mm.h	2003-06-23 10:30:37.000000000 -0700
@@ -339,9 +339,14 @@ static inline void set_page_zone(struct 
 	page->flags |= zone_num << ZONE_SHIFT;
 }
 
-static inline void * lowmem_page_address(struct page *page)
+#ifndef CONFIG_DISCONTIGMEM
+/* The array of struct pages - for discontigmem use pgdat->lmem_map */
+extern struct page *mem_map;
+#endif 
+
+static inline void *lowmem_page_address(struct page *page)
 {
-	return __va( ( (page - page_zone(page)->zone_mem_map)	+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT);
+	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
 
 #if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
@@ -395,11 +400,6 @@ static inline int page_mapped(struct pag
 #define VM_FAULT_MINOR	1
 #define VM_FAULT_MAJOR	2
 
-#ifndef CONFIG_DISCONTIGMEM
-/* The array of struct pages - for discontigmem use pgdat->lmem_map */
-extern struct page *mem_map;
-#endif 
-
 extern void show_free_areas(void);
 
 struct page *shmem_nopage(struct vm_area_struct * vma,
