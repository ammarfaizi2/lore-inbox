Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVJCRiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVJCRiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJCRiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:38:10 -0400
Received: from everest.sosdg.org ([66.93.203.161]:65511 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S932484AbVJCRiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:38:09 -0400
From: "Coywolf Qi Hunt" <coywolf@sosdg.org>
Date: Tue, 4 Oct 2005 01:41:31 +0800
To: nickpiggin@yahoo.com.au
Cc: kernel@kolivas.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] zone_watermark_ok() rework
Message-ID: <20051003174131.GA2865@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Scan-Signature: 44e89aee28cb3977aa72b7ef3649eedf
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In zone_watermark_ok(), the original algorithm seems not logical. This is a
rework. Comments?

		Coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@sosdg.org>
---

 page_alloc.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- 2.6.14-rc2-mm1/mm/page_alloc.c~orig	2005-09-29 20:37:07.000000000 +0800
+++ 2.6.14-rc2-mm1/mm/page_alloc.c	2005-10-04 01:19:31.000000000 +0800
@@ -772,7 +772,7 @@
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		      int classzone_idx, int can_try_harder, int gfp_high)
 {
-	/* free_pages my go negative - that's OK */
+	/* free_pages may go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
 	int o;
 
@@ -783,17 +783,12 @@
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		return 0;
-	for (o = 0; o < order; o++) {
-		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
 
-		/* Require fewer higher order pages to be free */
-		min >>= 1;
-
-		if (free_pages <= min)
-			return 0;
+	for (o = order; o < MAX_ORDER; o++) {
+		if (z->free_area[o].nr_free)
+			return 1;
 	}
-	return 1;
+	return 0;
 }
 
 static inline int
