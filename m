Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUHFWBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUHFWBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUHFWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:01:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34976 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268229AbUHFWAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:00:09 -0400
Message-ID: <4113FFF9.3010609@sgi.com>
Date: Fri, 06 Aug 2004 17:02:33 -0500
From: Josh Aas <josha@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] improve speed of freeing bootmem
References: <4113DB63.9020706@sgi.com> <20040806125216.30405230.akpm@osdl.org>
In-Reply-To: <20040806125216.30405230.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050603030907020403010400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603030907020403010400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

New patch is attached.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Josh Aas <josha@sgi.com>

-- 
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068

Andrew Morton wrote:
> Josh Aas <josha@sgi.com> wrote:
> 
>>Attached is a patch that greatly improves the speed of freeing boot 
>>memory.
> 
> 
> hm, OK.  I have a vague feeling that Bill Irwin had patches to fix this up
> ages ago.
> 
> 
> A few nits:
> 
> 
>>--- a/mm/bootmem.c	2004-08-05 15:33:39.000000000 -0500
>>+++ b/mm/bootmem.c	2004-08-06 13:42:33.000000000 -0500
>>@@ -259,6 +259,7 @@ static unsigned long __init free_all_boo
>> 	unsigned long i, count, total = 0;
>> 	unsigned long idx;
>> 	unsigned long *map; 
>>+	int gofast = 0;
>> 
>> 	BUG_ON(!bdata->node_bootmem_map);
>> 
>>@@ -267,14 +268,32 @@ static unsigned long __init free_all_boo
>> 	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
>> 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
>> 	map = bdata->node_bootmem_map;
>>+	if (bdata->node_boot_start == 0 ||
>>+	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
>>+		gofast = 1;
> 
> 
> A comment describing the above reasoning would be nice.
> 
> 
>> 	for (i = 0; i < idx; ) {
>> 		unsigned long v = ~map[i / BITS_PER_LONG];
>>-		if (v) {
>>+		if (gofast && v == ~0UL) {
>>+			int j;
>>+
>>+			count += BITS_PER_LONG;
>>+			ClearPageReservedNoAtomic(page);
>>+			set_page_count(page, 1);
>>+			for (j = 1; j < BITS_PER_LONG; j++) {
>>+				if (j + 16 < BITS_PER_LONG) {
>>+                      			prefetchw(page + j + 16);
>>+                                }
> 
> 
> The whitespace/tabbing has gone funny here.
> 
> 
>>+#define ClearPageReservedNoAtomic(page)	(page)->flags &= ~(1UL << PG_reserved)
> 
> 
> The naming convention we used in 2.4 for the nonatomic operation was
> __ClearPageReserved(), so can we please stick with that?
> 
> And this macro can use __clear_bit() rather than open-coding it.

--------------050603030907020403010400
Content-Type: text/x-patch;
 name="bootmem5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmem5.patch"

--- mm/bootmem.c.orig	2004-08-05 15:33:39.000000000 -0500
+++ mm/bootmem.c	2004-08-06 16:52:41.000000000 -0500
@@ -259,6 +259,7 @@ static unsigned long __init free_all_boo
 	unsigned long i, count, total = 0;
 	unsigned long idx;
 	unsigned long *map; 
+	int gofast = 0;
 
 	BUG_ON(!bdata->node_bootmem_map);
 
@@ -267,14 +268,33 @@ static unsigned long __init free_all_boo
 	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
+	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
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
+			__ClearPageReserved(page);
+			set_page_count(page, 1);
+			for (j = 1; j < BITS_PER_LONG; j++) {
+				if (j + 16 < BITS_PER_LONG) {
+					prefetchw(page + j + 16);
+				}
+				__ClearPageReserved(page + j);
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
+					__ClearPageReserved(page);
 					set_page_count(page, 1);
 					__free_page(page);
 				}
@@ -294,7 +314,7 @@ static unsigned long __init free_all_boo
 	count = 0;
 	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
 		count++;
-		ClearPageReserved(page);
+		__ClearPageReserved(page);
 		set_page_count(page, 1);
 		__free_page(page);
 	}
--- include/linux/page-flags.h.orig	2004-08-06 13:43:36.000000000 -0500
+++ include/linux/page-flags.h	2004-08-06 15:16:29.000000000 -0500
@@ -236,6 +236,7 @@ extern unsigned long __read_page_state(u
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
+#define __ClearPageReserved(page)	__clear_bit(PG_reserved, &(page)->flags)
 
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)

--------------050603030907020403010400--
