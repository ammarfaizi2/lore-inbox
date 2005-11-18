Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVKRTQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVKRTQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVKRTQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:16:59 -0500
Received: from gold.veritas.com ([143.127.12.110]:49511 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750799AbVKRTQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:16:58 -0500
Date: Fri, 18 Nov 2005 19:15:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Krufky <mkrufky@m1k.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1-mm2 0x414 Bad page states
Message-ID: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2005 19:16:55.0346 (UTC) FILETIME=[A3817920:01C5EC74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for your PageReserved "Bad page state" reports.

Sorry for being so slow to respond.  I've not worked it out yet.

Would each of you please apply the slightly-more-debug-info patch
below, and mail me the first batch of reports that you get when
you try to reproduce the problem (it does assume only one CPU,
which happens to be the case for each of you).

Thanks,
Hugh

--- 2.6.15-rc1-mm2/mm/memory.c	2005-11-18 15:23:09.000000000 +0000
+++ linux/mm/memory.c	2005-11-18 17:56:23.000000000 +0000
@@ -569,6 +569,7 @@ static unsigned long zap_pte_range(struc
 				unsigned long addr, unsigned long end,
 				long *zap_work, struct zap_details *details)
 {
+	extern struct vm_area_struct *zap_vma;
 	struct mm_struct *mm = tlb->mm;
 	pte_t *pte;
 	spinlock_t *ptl;
@@ -576,6 +577,7 @@ static unsigned long zap_pte_range(struc
 	int anon_rss = 0;
 
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	zap_vma = vma;
 	do {
 		pte_t ptent = *pte;
 		if (pte_none(ptent)) {
@@ -649,6 +651,7 @@ static unsigned long zap_pte_range(struc
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
 	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
 
+	zap_vma = NULL;
 	add_mm_rss(mm, file_rss, anon_rss);
 	pte_unmap_unlock(pte - 1, ptl);
 
--- 2.6.15-rc1-mm2/mm/page_alloc.c	2005-11-18 15:23:09.000000000 +0000
+++ linux/mm/page_alloc.c	2005-11-18 18:16:28.000000000 +0000
@@ -36,6 +36,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
+#include <linux/kallsyms.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -122,6 +123,7 @@ static int bad_range(struct zone *zone, 
 	return 0;
 }
 
+struct vm_area_struct *zap_vma;
 static void bad_page(const char *function, struct page *page)
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
@@ -129,6 +131,13 @@ static void bad_page(const char *functio
 	printk(KERN_EMERG "flags:0x%0*lx mapping:%p mapcount:%d count:%d\n",
 		(int)(2*sizeof(unsigned long)), (unsigned long)page->flags,
 		page->mapping, page_mapcount(page), page_count(page));
+	if (zap_vma) {
+		printk(KERN_EMERG "vm_flags:0x%lx", zap_vma->vm_flags);
+		print_symbol(" %s", (unsigned long)
+			(zap_vma->vm_ops? zap_vma->vm_ops->open: NULL));
+		print_symbol(" %s\n", (unsigned long)
+			(zap_vma->vm_ops? zap_vma->vm_ops->nopage: NULL));
+	}
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
 	{
