Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWJ0IeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWJ0IeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWJ0IeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:34:11 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:19371 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S965239AbWJ0IeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:34:10 -0400
Date: Fri, 27 Oct 2006 09:34:06 +0100
To: akpm@osdl.org
Cc: kmannth@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Calculation fix for memory holes beyong the end of physical memory
Message-ID: <20061027083405.GA18899@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

absent_pages_in_range() made the assumption that users of the arch-independent
zone-sizing API would not care about holes beyound the end of physical memory.
This was not the case and was "fixed" in a patch called "Account for holes
that are outside the range of physical memory". However, when given a range
that started before a hole in "real" memory and ended beyond the end of memory,
it would get the result wrong. The bug is in mainline but a patch is below.

It has been tested successfully on a number of machines and
architectures. Additional credit to Keith Mannthey for discovering the problem,
helping identify the correct fix and confirming it Worked For Him.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc2-mm2-clean/mm/page_alloc.c linux-2.6.19-rc2-mm2-fix_hole_pages/mm/page_alloc.c
--- linux-2.6.19-rc2-mm2-clean/mm/page_alloc.c	2006-10-23 09:53:24.000000000 +0100
+++ linux-2.6.19-rc2-mm2-fix_hole_pages/mm/page_alloc.c	2006-10-26 10:33:30.000000000 +0100
@@ -2511,7 +2511,7 @@ unsigned long __init __absent_pages_in_r
 
 	/* Account for ranges past physical memory on this node */
 	if (range_end_pfn > prev_end_pfn)
-		hole_pages = range_end_pfn -
+		hole_pages += range_end_pfn -
 				max(range_start_pfn, prev_end_pfn);
 
 	return hole_pages;
