Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWDULQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWDULQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWDULQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:16:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36283 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750877AbWDULQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:16:18 -0400
Date: Fri, 21 Apr 2006 13:20:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060421112049.GA5609@elte.hu>
References: <20060419112130.GA22648@elte.hu> <20060420091856.GB21660@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420091856.GB21660@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <npiggin@suse.de> wrote:

> On Wed, Apr 19, 2006 at 01:21:30PM +0200, Ingo Molnar wrote:
> > the 2.6.17-rc2 kernel built with the attached config crashes quite 
> > easily under minimal load. Disabling CONFIG_NUMA makes it robust again.  
> > Crashlog attached.
> 
> It would be interesting to know which assertion failed. I guess it 
> might be a zone alignment problem -- it would be interesting to turn 
> the 2 HOLES_IN_ZONE tests into BUG_ONs, and enable them (ie. move them 
> out of HOLES_IN_ZONE).

ok, i added a couple of printks (see the patch below), and got this:

 zone c1f0a600 (HighMem):
 pfn: 00037d00
 zone->zone_start_pfn: 00037e00
 zone->spanned_pages: 00007e00
 zone->zone_start_pfn + zone->spanned_pages: 0003fc00
 ------------[ cut here ]------------
 kernel BUG at mm/page_alloc.c:524!

so the pfn is 1MB below the zone's start address - not good. You can 
find the full bootup log at:

	http://redhat.com/~mingo/misc/crash.log

the log should also give an idea about how the zones are layed out, etc.  
Note that this is an ordinary desktop dual-core box with 1GB RAM booting 
an allyesconfig NUMA kernel. I suspect this could be some bootup-time 
zone sizing problem? The config is at:

	http://redhat.com/~mingo/misc/config

(the crash is easy to reproduce, so let me know if i can do anything 
else to debug this.)

	Ingo

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -100,17 +100,32 @@ static int page_outside_zone_boundaries(
 			ret = 1;
 	} while (zone_span_seqretry(zone, seq));
 
+#define P(x) printk("%s: %08lx\n", #x, x)
+
+	if (ret) {
+		printk("zone %p (%s):\n", zone, zone->name);
+		P(pfn);
+		P(zone->zone_start_pfn);
+		P(zone->spanned_pages);
+		P(zone->zone_start_pfn + zone->spanned_pages);
+	}
+
 	return ret;
 }
 
 static int page_is_consistent(struct zone *zone, struct page *page)
 {
-#ifdef CONFIG_HOLES_IN_ZONE
-	if (!pfn_valid(page_to_pfn(page)))
+	if (!pfn_valid(page_to_pfn(page))) {
+		printk("BUG: pfn: %08lx, page: %p\n",
+			page_to_pfn(page), page);
+		dump_stack();
 		return 0;
-#endif
-	if (zone != page_zone(page))
+	}
+	if (zone != page_zone(page)) {
+		printk("zone: %p != %p == page_zone(%p)\n",
+			zone, page_zone(page), page);
 		return 0;
+	}
 
 	return 1;
 }
@@ -292,10 +307,12 @@ __find_combined_index(unsigned long page
  */
 static inline int page_is_buddy(struct page *page, int order)
 {
-#ifdef CONFIG_HOLES_IN_ZONE
-	if (!pfn_valid(page_to_pfn(page)))
+	if (!pfn_valid(page_to_pfn(page))) {
+		printk("BUG: pfn: %08lx, page: %p, order: %d\n",
+			page_to_pfn(page), page, order);
+		dump_stack();
 		return 0;
-#endif
+	}
 
 	if (PageBuddy(page) && page_order(page) == order) {
 		BUG_ON(page_count(page) != 0);
