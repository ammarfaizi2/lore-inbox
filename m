Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUCYV7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUCYV7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:59:39 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:8577 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263633AbUCYV7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:59:34 -0500
Date: Thu, 25 Mar 2004 22:59:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040325215919.GA301@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <20040325100339.GN791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325100339.GN791@holomorphy.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think this kind of thing should help stabilize swsusp in the presence
> of memory holes, which can be important for embedded devices which would
> in the future find swsusp useful for power-saving purposes.

I had to apply this to compile it, I have not ran it yet.

								Pavel

--- tmp/linux/kernel/power/swsusp.c	2004-03-25 14:42:07.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-03-25 14:41:12.000000000 +0100
@@ -443,16 +443,16 @@
 
 static int pfn_is_nosave(unsigned long pfn)
 {
-	static const unsigned long nosave_begin_pfn
+	unsigned long nosave_begin_pfn
 				= __pa(&__nosave_begin) >> PAGE_SHIFT;
-	static const unsigned long nosave_end_pfn
+	unsigned long nosave_end_pfn
 				= PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
 	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
 }
 
 static int count_and_copy_zone(struct zone *zone, struct pbe **pagedir_p)
 {
-	unsigned long zone_pfn, nr_copy_pages = 0;
+	unsigned long zone_pfn, chunk_size, nr_copy_pages = 0;
 	struct pbe *pbe = *pagedir_p;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 		struct page *page;
@@ -472,7 +472,7 @@
 		}
 		nr_copy_pages++;
 		if (!pbe)
-			continue
+			continue;
 		pbe->orig_address = page_address(page);
 		copy_page((void *)pbe->address, (void *)pbe->orig_address);
 		pbe++;
@@ -495,7 +495,7 @@
 static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
 {
 	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
-	pagedir_end = pagedir + PAGE_SIZE << pagedir_order;
+	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
 	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
 	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
@@ -517,7 +517,7 @@
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
