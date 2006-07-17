Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWGQQmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWGQQmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWGQQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:20155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750966AbWGQQcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:42 -0400
Date: Mon, 17 Jul 2006 09:25:50 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/45] BLOCK: Fix bounce limit address check
Message-ID: <20060717162550.GE4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="block-fix-bounce-limit-address-check.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

This fixes some OOMs on 64bit systems with <4GB of RAM when accessing
the cdrom. 

Do a safer check for when to enable DMA. Currently we enable ISA DMA
for cases that do not need it, resulting in OOM conditions when ZONE_DMA
runs out of space.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 block/ll_rw_blk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.2.orig/block/ll_rw_blk.c
+++ linux-2.6.17.2/block/ll_rw_blk.c
@@ -638,7 +638,7 @@ void blk_queue_bounce_limit(request_queu
 	/* Assume anything <= 4GB can be handled by IOMMU.
 	   Actually some IOMMUs can handle everything, but I don't
 	   know of a way to test this here. */
-	if (bounce_pfn < (0xffffffff>>PAGE_SHIFT))
+	if (bounce_pfn < (min_t(u64,0xffffffff,BLK_BOUNCE_HIGH) >> PAGE_SHIFT))
 		dma = 1;
 	q->bounce_pfn = max_low_pfn;
 #else

--
