Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbUCZMJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUCZMJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:09:40 -0500
Received: from gprs214-227.eurotel.cz ([160.218.214.227]:2946 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264024AbUCZMJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:09:34 -0500
Date: Fri, 26 Mar 2004 13:08:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040326120857.GB3102@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <20040325100339.GN791@holomorphy.com> <20040325215919.GA301@elf.ucw.cz> <20040326120359.GW791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326120359.GW791@holomorphy.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At some point in the past, I wrote:
> >> I think this kind of thing should help stabilize swsusp in the presence
> >> of memory holes, which can be important for embedded devices which would
> >> in the future find swsusp useful for power-saving purposes.
> 
> On Thu, Mar 25, 2004 at 10:59:19PM +0100, Pavel Machek wrote:
> > I had to apply this to compile it, I have not ran it yet.
> 
> Looks like I had a gaffe or two in there. Let me know if there's any
> trouble running it. The thing was meant to be equivalent to the prior
> code on ia32, and to avoid some pfn <-> page conversion issues that
> matter on other systems.

Well, you forgot to dd chunk_size -1 to zone_pfn, too, and that took
me a while to find. Here's the final patch, and that one seems to work
okay.

								Pavel

--- tmp/linux/kernel/power/swsusp.c	2004-03-26 12:51:45.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-03-26 12:10:06.000000000 +0100
@@ -102,7 +102,7 @@
    allocated at time of resume, that travels through memory not to
    collide with anything.
 
-   Warning: this is even more evil than it seems. Pagedirs this files
+   Warning: this is even more evil than it seems. Pagedirs this file
    talks about are completely different from page directories used by
    MMU hardware.
  */
@@ -383,6 +383,9 @@
 		void *kaddr;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 		int chunk_size;
+
+		if (!(pfn%200))
+			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
 		page = pfn_to_page(pfn);
@@ -398,6 +401,7 @@
 		}
 		if ((chunk_size = is_head_of_free_region(page))) {
 			pfn += chunk_size - 1;
+			zone_pfn += chunk_size - 1;
 			continue;
 		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
@@ -405,7 +409,7 @@
 			panic("Not enough memory");
 		save->next = highmem_copy;
 		save->page = page;
-		save->data = get_zeroed_page(GFP_ATOMIC);
+		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
 		if (!save->data)
 			panic("Not enough memory");
 		kaddr = kmap_atomic(page, KM_USER0);
@@ -415,7 +419,6 @@
 	}
 }
 
-/* if pagedir_p != NULL it also copies the counted pages */
 static void save_highmem(void)
 {
 	struct zone *zone;
@@ -435,7 +438,7 @@
 		kaddr = kmap_atomic(save->page, KM_USER0);
 		memcpy(kaddr, save->data, PAGE_SIZE);
 		kunmap_atomic(kaddr, KM_USER0);
-		free_page(save->data);
+		free_page((long) save->data);
 		kfree(save);
 	}
 	return 0;
@@ -443,37 +446,41 @@
 
 static int pfn_is_nosave(unsigned long pfn)
 {
-	static const unsigned long nosave_begin_pfn
-				= __pa(&__nosave_begin) >> PAGE_SHIFT;
-	static const unsigned long nosave_end_pfn
-				= PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
-	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
+	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }
 
+/* if *pagedir_p != NULL it also copies the counted pages */
 static int count_and_copy_zone(struct zone *zone, struct pbe **pagedir_p)
 {
-	unsigned long zone_pfn, nr_copy_pages = 0;
+	unsigned long zone_pfn, chunk_size, nr_copy_pages = 0;
 	struct pbe *pbe = *pagedir_p;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 		struct page *page;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+		if (!(pfn%200))
+			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
 		page = pfn_to_page(pfn);
 		BUG_ON(PageReserved(page) && PageNosave(page));
 		if (PageNosave(page))
 			continue;
-		else if (PageReserved(page) && pfn_is_nosave(pfn)) {
+		if (PageReserved(page) && pfn_is_nosave(pfn)) {
 			PRINTK("[nosave pfn 0x%lx]", pfn);
 			continue;
-		} else if ((chunk_size = is_head_of_free_region(page))) {
+		}
+		if ((chunk_size = is_head_of_free_region(page))) {
 			pfn += chunk_size - 1;
+			zone_pfn += chunk_size - 1;
 			continue;
 		}
 		nr_copy_pages++;
 		if (!pbe)
-			continue
-		pbe->orig_address = page_address(page);
+			continue;
+		pbe->orig_address = (long) page_address(page);
 		copy_page((void *)pbe->address, (void *)pbe->orig_address);
 		pbe++;
 	}
@@ -495,7 +502,7 @@
 static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
 {
 	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
-	pagedir_end = pagedir + PAGE_SIZE << pagedir_order;
+	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
 	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
 	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
@@ -517,7 +524,7 @@
 	struct zone *zone;
 	for_each_zone(zone) {
 		if (!is_highmem(zone))
-			free_suspend_pagedir_zone(this_pagedir);
+			free_suspend_pagedir_zone(zone, this_pagedir);
 	}
 	free_pages(this_pagedir, pagedir_order);
 }


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
