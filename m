Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUHFTYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUHFTYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUHFTYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:24:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29635 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268235AbUHFTX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:23:58 -0400
Message-ID: <4113DB63.9020706@sgi.com>
Date: Fri, 06 Aug 2004 14:26:27 -0500
From: Josh Aas <josha@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH] improve speed of freeing bootmem
Content-Type: multipart/mixed;
 boundary="------------010806030609030806020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010806030609030806020404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch that greatly improves the speed of freeing boot 
memory. On ia64 machines with 2GB or more memory (I didn't test with 
less, but I can't imagine there being a problem), the speed improvement 
is about 75% for the function free_all_bootmem_core. This translates to 
savings on the order of 1 minute / TB of memory during boot time. That 
number comes from testing on a machine with 512GB, and extrapolating 
based on profiling of an unpatched 4TB machine. For 4 and 8 TB machines, 
the time spent in this function is about 1 minutes/TB, which is painful 
especially given that there is no indication of what is going on put to 
the console (this issue to possibly be addressed later).

The basic idea is to free higher order pages instead of going through 
every single one. Also, some unnecessary atomic operations are done away 
with and replaced with non-atomic equivalents, and prefetching is done 
where it helps the most. For a more in-depth discusion of this patch, 
please see the linux-ia64 archives (topic is "free bootmem feedback patch").

The patch is originally Tony Luck's, and I added some further 
optimizations (non-atomic ops improvements and prefetching).

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Josh Aas <josha@sgi.com>

-- 
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068

--------------010806030609030806020404
Content-Type: text/x-patch;
 name="bootmem4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmem4.patch"

--- a/mm/bootmem.c	2004-08-05 15:33:39.000000000 -0500
+++ b/mm/bootmem.c	2004-08-06 13:42:33.000000000 -0500
@@ -259,6 +259,7 @@ static unsigned long __init free_all_boo
 	unsigned long i, count, total = 0;
 	unsigned long idx;
 	unsigned long *map; 
+	int gofast = 0;
 
 	BUG_ON(!bdata->node_bootmem_map);
 
@@ -267,14 +268,32 @@ static unsigned long __init free_all_boo
 	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
+	if (bdata->node_boot_start == 0 ||
+	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
+		gofast = 1;
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
-		if (v) {
+		if (gofast && v == ~0UL) {
+			int j;
+
+			count += BITS_PER_LONG;
+			ClearPageReservedNoAtomic(page);
+			set_page_count(page, 1);
+			for (j = 1; j < BITS_PER_LONG; j++) {
+				if (j + 16 < BITS_PER_LONG) {
+                      			prefetchw(page + j + 16);
+                                }
+				ClearPageReservedNoAtomic(page + j);
+			}	
+			__free_pages(page, ffs(BITS_PER_LONG)-1);
+			i += BITS_PER_LONG;
+			page += BITS_PER_LONG;
+		} else if (v) {
 			unsigned long m;
 			for (m = 1; m && i < idx; m<<=1, page++, i++) {
 				if (v & m) {
 					count++;
-					ClearPageReserved(page);
+					ClearPageReservedNoAtomic(page);
 					set_page_count(page, 1);
 					__free_page(page);
 				}
@@ -294,7 +313,7 @@ static unsigned long __init free_all_boo
 	count = 0;
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
-		ClearPageReserved(page);
+		ClearPageReservedNoAtomic(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}
--- a/include/linux/page-flags.h	2004-08-06 13:43:36.000000000 -0500
+++ b/include/linux/page-flags.h	2004-08-06 13:43:27.000000000 -0500
@@ -236,6 +236,7 @@ extern unsigned long __read_page_state(u
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
+#define ClearPageReservedNoAtomic(page)	(page)->flags &= ~(1UL << PG_reserved)
 
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)

--------------010806030609030806020404--
