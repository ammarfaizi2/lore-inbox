Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWASTtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWASTtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWASTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:49:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25987 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161393AbWASTtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:49:15 -0500
Date: Thu, 19 Jan 2006 14:48:36 -0500
From: Dave Jones <davej@redhat.com>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060119194836.GM21663@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andy Chittenden <AChittenden@bluearc.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	lwoodman@redhat.com
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 03:11:45PM -0000, Andy Chittenden wrote:
 > DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
 > present:12740kB pages_scanned:4 all_unreclaimable? yes

Note we only scanned 4 pages before we gave up.
Larry Woodman came up with this patch below that clears all_unreclaimable
when in two places where we've made progress at freeing up some pages
which has helped oom situations for some of our users.

From: Larry Woodman <lwoodman@redhat.com>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/mm/filemap.c~	2005-12-10 01:47:15.000000000 -0500
+++ linux-2.6/mm/filemap.c	2005-12-10 01:47:46.000000000 -0500
@@ -471,11 +471,18 @@ EXPORT_SYMBOL(unlock_page);
  */
 void end_page_writeback(struct page *page)
 {
+	struct zone *zone = page_zone(page);
 	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
 		if (!test_clear_page_writeback(page))
 			BUG();
 	}
 	smp_mb__after_clear_bit();
+	if (zone->all_unreclaimable) {
+		spin_lock(&zone->lock);
+		zone->all_unreclaimable = 0;
+		zone->pages_scanned = 0;
+		spin_unlock(&zone->lock);
+	}
 	wake_up_page(page, PG_writeback);
 }
 EXPORT_SYMBOL(end_page_writeback);
--- linux-2.6.15/mm/page_alloc.c~	2006-01-09 13:40:03.000000000 -0500
+++ linux-2.6.15/mm/page_alloc.c	2006-01-09 13:40:50.000000000 -0500
@@ -722,6 +722,11 @@ static void fastcall free_hot_cold_page(
 	if (pcp->count >= pcp->high) {
 		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
 		pcp->count -= pcp->batch;
+	} else if (zone->all_unreclaimable) {
+		spin_lock(&zone->lock);
+		zone->all_unreclaimable = 0;
+		zone->pages_scanned = 0;
+		spin_unlock(&zone->lock);
 	}
 	local_irq_restore(flags);
 	put_cpu();
