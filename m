Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWGGIiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWGGIiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 04:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWGGIiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 04:38:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43442 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750934AbWGGIiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 04:38:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][Fix] swsusp: do not use memcpy for snapshotting memory
Date: Fri, 7 Jul 2006 10:38:42 +0200
User-Agent: KMail/1.9.3
Cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607071038.42792.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp should not use memcpy for snapshotting memory, because on some
architectures memcpy may increase preempt_count.  Then, as a result, wrong
value of preempt_count is stored in the image.

Replace memcpy in copy_data_pages with an open-coded loop.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/snapshot.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.17-mm6.orig/kernel/power/snapshot.c
+++ linux-2.6.17-mm6/kernel/power/snapshot.c
@@ -227,11 +227,17 @@ static void copy_data_pages(struct pbe *
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page *page;
+				long *src, *dst;
+				int n;
+
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address = (unsigned long)page_address(page);
-				/* copy_page is not usable for copying task structs. */
-				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				/* copy_page and memcpy are not usable for copying task structs. */
+				dst = (long *)pbe->address;
+				src = (long *)pbe->orig_address;
+				for (n = PAGE_SIZE / sizeof(long); n; n--)
+					*dst++ = *src++;
 				pbe = pbe->next;
 			}
 		}
