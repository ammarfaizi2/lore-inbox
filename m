Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVAIVbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVAIVbv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 16:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVAIVbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 16:31:51 -0500
Received: from fsmlabs.com ([168.103.115.128]:53930 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261812AbVAIVbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 16:31:49 -0500
Date: Sun, 9 Jan 2005 14:32:00 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Chris Wright <chrisw@osdl.org>, clameter@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for prep_zero_page
In-Reply-To: <20050109125212.330c34c1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org>
 <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
 <20050109125212.330c34c1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Andrew Morton wrote:

> This won't work right if someone tries to allocate memory while holding a
> KM_IRQ0 atomic kmap.
> 
> It would be quite bizarre for anyone to be allocating highmem pages from
> IRQ context anyway, but as a generic mechanism this really should work as
> expected in all contexts.  That means a new kmap slot.

I was trying to find users of nested KM_IRQ to verify against so i just 
went with the first slot. The problem with sharing a slot with irq context 
is that you have to exclude interrupts whilst doing the zeroing too, 
unless we maybe create two slots.

> Can't we simply move the page zeroing to the very end of __alloc_pages()?

Ok, i've changed that bit to something like;

Index: linux-2.6.10-mm2/mm/page_alloc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm2/mm/page_alloc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 page_alloc.c
--- linux-2.6.10-mm2/mm/page_alloc.c	9 Jan 2005 04:52:40 -0000	1.1.1.1
+++ linux-2.6.10-mm2/mm/page_alloc.c	9 Jan 2005 21:23:31 -0000
@@ -732,9 +740,6 @@ buffered_rmqueue(struct zone *zone, int 
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
 
-		if (gfp_flags & __GFP_ZERO)
-			prep_zero_page(page, order);
-
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -935,6 +940,8 @@ nopage:
 got_pg:
 	zone_statistics(zonelist, z);
 	kernel_map_pages(page, 1 << order, 1);
+	if (gfp_mask & __GFP_ZERO)
+		prep_zero_page(page, order);
 	return page;
 }
 
