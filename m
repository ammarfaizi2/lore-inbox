Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWHSKPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWHSKPx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWHSKPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:15:53 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:39834 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751688AbWHSKPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:15:52 -0400
Date: Sat, 19 Aug 2006 06:11:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] block: fix queue bounce limit calculation
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>
Message-ID: <200608190612_MC3-1-C895-98A8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Queue bounce should start after the max page, not on it.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---

Could this explain reported slowdown on x86_64 after limit was
changed in 2.6.16.7?

--- 2.6.17.9-64.orig/block/ll_rw_blk.c
+++ 2.6.17.9-64/block/ll_rw_blk.c
@@ -638,11 +638,11 @@ void blk_queue_bounce_limit(request_queu
 	/* Assume anything <= 4GB can be handled by IOMMU.
 	   Actually some IOMMUs can handle everything, but I don't
 	   know of a way to test this here. */
-	if (bounce_pfn < (min_t(u64,0xffffffff,BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
+	if (bounce_pfn <= (min_t(u64,0xffffffff,BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
 		dma = 1;
 	q->bounce_pfn = max_low_pfn;
 #else
-	if (bounce_pfn < blk_max_low_pfn)
+	if (bounce_pfn <= blk_max_low_pfn)
 		dma = 1;
 	q->bounce_pfn = bounce_pfn;
 #endif
-- 
Chuck
