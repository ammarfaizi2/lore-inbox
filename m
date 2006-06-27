Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWF0MuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWF0MuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWF0MuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:50:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932484AbWF0MuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:50:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=eMs41bNcRmVz6T6sVpGGJ0VTKQZUZ/82SEkFHD+ODlvp5O/mB9sxlO7lFGuEcNuKRSLLG8kAapzP9e2w4L+PGRSYEZKBRlLeKNCk49cr9PAq3iR1ugZdOq3wvMnia2OoHprzkpIt9uWKcBtx/ovN94i/+2qb1i8Ggjs8RSQMIcw=
Message-ID: <44A12A85.50303@innova-card.com>
Date: Tue, 27 Jun 2006 14:54:29 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] bootmem: use pfn/page conversion macros
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It also creates get_mapsize() helper in order to make the code
more readable when it calculates the boot bitmap size.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 mm/bootmem.c |   82 ++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 86213da..3368a14 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -9,6 +9,7 @@
  *  system memory and memory holes as well.
  */
 #include <linux/init.h>
+#include <linux/pfn.h>
 #include <linux/bootmem.h>
 #include <linux/module.h>
 
@@ -70,6 +71,18 @@ static void __init link_bootmem(bootmem_
 	return;
 }
 
+/*
+ * Given an initialised bdata, it returns the size of the boot bitmap
+ */
+static unsigned long __init get_mapsize(bootmem_data_t *bdata)
+{
+	unsigned long mapsize;
+	unsigned long start = PFN_DOWN(bdata->node_boot_start);
+	unsigned long end = bdata->node_low_pfn;
+
+	mapsize = ((end - start) + 7) / 8;
+	return ALIGN(mapsize, sizeof(long));
+}
 
 /*
  * Called once to set up the allocator itself.
@@ -78,11 +91,10 @@ static unsigned long __init init_bootmem
 	unsigned long mapstart, unsigned long start, unsigned long end)
 {
 	bootmem_data_t *bdata = pgdat->bdata;
-	unsigned long mapsize = ((end - start)+7)/8;
+	unsigned long mapsize;
 
-	mapsize = ALIGN(mapsize, sizeof(long));
-	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
-	bdata->node_boot_start = (start << PAGE_SHIFT);
+	bdata->node_bootmem_map = phys_to_virt(PFN_PHYS(mapstart));
+	bdata->node_boot_start = PFN_PHYS(start);
 	bdata->node_low_pfn = end;
 	link_bootmem(bdata);
 
@@ -90,6 +102,7 @@ static unsigned long __init init_bootmem
 	 * Initially all pages are reserved - setup_arch() has to
 	 * register free RAM areas explicitly.
 	 */
+	mapsize = get_mapsize(bdata);
 	memset(bdata->node_bootmem_map, 0xff, mapsize);
 
 	return mapsize;
@@ -103,20 +116,19 @@ static unsigned long __init init_bootmem
 static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
 					unsigned long size)
 {
+	unsigned long sidx, eidx;
 	unsigned long i;
+
 	/*
 	 * round up, partially reserved pages are considered
 	 * fully reserved.
 	 */
-	unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long eidx = (addr + size - bdata->node_boot_start + 
-							PAGE_SIZE-1)/PAGE_SIZE;
-	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
-
 	BUG_ON(!size);
-	BUG_ON(sidx >= eidx);
-	BUG_ON((addr >> PAGE_SHIFT) >= bdata->node_low_pfn);
-	BUG_ON(end > bdata->node_low_pfn);
+	BUG_ON(PFN_DOWN(addr) >= bdata->node_low_pfn);
+	BUG_ON(PFN_UP(addr + size) > bdata->node_low_pfn);
+
+	sidx = PFN_DOWN(addr - bdata->node_boot_start);
+	eidx = PFN_UP(addr + size - bdata->node_boot_start);
 
 	for (i = sidx; i < eidx; i++)
 		if (test_and_set_bit(i, bdata->node_bootmem_map)) {
@@ -129,18 +141,15 @@ #endif
 static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
 				     unsigned long size)
 {
+	unsigned long sidx, eidx;
 	unsigned long i;
-	unsigned long start;
+
 	/*
 	 * round down end of usable mem, partially free pages are
 	 * considered reserved.
 	 */
-	unsigned long sidx;
-	unsigned long eidx = (addr + size - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long end = (addr + size)/PAGE_SIZE;
-
 	BUG_ON(!size);
-	BUG_ON(end > bdata->node_low_pfn);
+	BUG_ON(PFN_DOWN(addr + size) > bdata->node_low_pfn);
 
 	if (addr < bdata->last_success)
 		bdata->last_success = addr;
@@ -148,8 +157,8 @@ static void __init free_bootmem_core(boo
 	/*
 	 * Round up the beginning of the address.
 	 */
-	start = (addr + PAGE_SIZE-1) / PAGE_SIZE;
-	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
+	sidx = PFN_UP(addr) - PFN_DOWN(bdata->node_boot_start);
+	eidx = PFN_DOWN(addr + size - bdata->node_boot_start);
 
 	for (i = sidx; i < eidx; i++) {
 		if (unlikely(!test_and_clear_bit(i, bdata->node_bootmem_map)))
@@ -175,7 +184,7 @@ __alloc_bootmem_core(struct bootmem_data
 	      unsigned long align, unsigned long goal, unsigned long limit)
 {
 	unsigned long offset, remaining_size, areasize, preferred;
-	unsigned long i, start = 0, incr, eidx, end_pfn = bdata->node_low_pfn;
+	unsigned long i, start = 0, incr, eidx, end_pfn;
 	void *ret;
 
 	if(!size) {
@@ -187,23 +196,22 @@ __alloc_bootmem_core(struct bootmem_data
 	if (limit && bdata->node_boot_start >= limit)
 		return NULL;
 
-        limit >>=PAGE_SHIFT;
+	end_pfn = bdata->node_low_pfn;
+	limit = PFN_DOWN(limit);
 	if (limit && end_pfn > limit)
 		end_pfn = limit;
 
-	eidx = end_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	eidx = end_pfn - PFN_DOWN(bdata->node_boot_start);
 	offset = 0;
-	if (align &&
-	    (bdata->node_boot_start & (align - 1UL)) != 0)
-		offset = (align - (bdata->node_boot_start & (align - 1UL)));
-	offset >>= PAGE_SHIFT;
+	if (align && (bdata->node_boot_start & (align - 1UL)) != 0)
+		offset = align - (bdata->node_boot_start & (align - 1UL));
+	offset = PFN_DOWN(offset);
 
 	/*
 	 * We try to allocate bootmem pages above 'goal'
 	 * first, then we try to allocate lower pages.
 	 */
-	if (goal && (goal >= bdata->node_boot_start) && 
-	    ((goal >> PAGE_SHIFT) < end_pfn)) {
+	if (goal && goal >= bdata->node_boot_start && PFN_DOWN(goal) < end_pfn) {
 		preferred = goal - bdata->node_boot_start;
 
 		if (bdata->last_success >= preferred)
@@ -212,9 +220,8 @@ __alloc_bootmem_core(struct bootmem_data
 	} else
 		preferred = 0;
 
-	preferred = ALIGN(preferred, align) >> PAGE_SHIFT;
-	preferred += offset;
-	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
+	preferred = PFN_DOWN(ALIGN(preferred, align)) + offset;
+	areasize = (size + PAGE_SIZE-1) / PAGE_SIZE;
 	incr = align >> PAGE_SHIFT ? : 1;
 
 restart_scan:
@@ -245,7 +252,7 @@ restart_scan:
 	return NULL;
 
 found:
-	bdata->last_success = start << PAGE_SHIFT;
+	bdata->last_success = PFN_PHYS(start);
 	BUG_ON(start >= eidx);
 
 	/*
@@ -303,8 +310,8 @@ static unsigned long __init free_all_boo
 
 	count = 0;
 	/* first extant page of the node */
-	pfn = bdata->node_boot_start >> PAGE_SHIFT;
-	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	pfn = PFN_DOWN(bdata->node_boot_start);
+	idx = bdata->node_low_pfn - pfn;
 	map = bdata->node_bootmem_map;
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
 	if (bdata->node_boot_start == 0 ||
@@ -345,9 +352,10 @@ static unsigned long __init free_all_boo
 	 */
 	page = virt_to_page(bdata->node_bootmem_map);
 	count = 0;
-	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
-		count++;
+	idx = (get_mapsize(bdata) + PAGE_SIZE-1) >> PAGE_SHIFT;
+	for (i = 0; i < idx; i++, page++) {
 		__free_pages_bootmem(page, 0);
+		count++;
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
-- 
1.4.0.g64e8



