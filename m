Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUGLNwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUGLNwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGLNwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:52:38 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:12501
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S266018AbUGLNwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:52:35 -0400
Date: Mon, 12 Jul 2004 14:51:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200407121351.i6CDplLM031827@voidhawk.shadowen.org>
To: akpm@osdl.org, apw@shadowen.org, geert@linux-m68k.org, torvalds@osdl.org
Subject: Re: is_highmem() and WANT_PAGE_VIRTUAL (was: Re: Linux 2.6.8-rc1)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.58.0407121326410.17199@waterleaf.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Geert wrote:
> | --- reference/mm/page_alloc.c	2004-07-07 18:08:56.000000000 +0100
> | +++ current/mm/page_alloc.c	2004-07-07 18:10:15.000000000 +0100
> | @@ -1421,7 +1421,7 @@ void __init memmap_init_zone(struct page
> |  		INIT_LIST_HEAD(&page->lru);
> |  #ifdef WANT_PAGE_VIRTUAL
> |  		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
> | -		if (zone != ZONE_HIGHMEM)
> | +		if (!is_highmem(zone))
> |  			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
> |  #endif
> |  		start_pfn++;
> 
> The above change is incorrect, since zone is an unsigned long, while
> is_highmem() takes a struct zone *.

My bad.  I was stupidly assuming that this was used then ZONE_HIGHMEM was
not enabled.  This should apply on top of 2.6.8-rc1 and repair the damage.

-apw

=== 8< ===
Should be applying is_highmem() to a zone.

Revision: $Rev: 386 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c	2004-07-12 13:15:57.000000000 +0100
+++ current/mm/page_alloc.c	2004-07-12 14:37:19.000000000 +0100
@@ -1402,7 +1402,7 @@ void __init memmap_init_zone(struct page
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-		if (!is_highmem(zone))
+		if (!is_highmem(page_zone(page)))
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
 #endif
 		start_pfn++;
