Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbULTUz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbULTUz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbULTUz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:55:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:52401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261637AbULTUzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:55:21 -0500
Date: Mon, 20 Dec 2004 12:54:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-Id: <20041220125443.091a911b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
>  result in OOM kills, with the dirty pagecache completely filling up
>  lowmem.

That surely used to work - I have a feeling that it got broken somehow. 
The below might fix it, but probably not.

The intended behaviour is that the page-allocating process will throttle
and will then pick up those pages from the tail of the LRU which
rotate_reclaimable_page() put there.



We haven't been incrementing local variable total_scanned since the
scan_control stuff went in.  That broke kswapd throttling.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/vmscan.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN mm/vmscan.c~vmscan-total_scanned-fix mm/vmscan.c
--- 25/mm/vmscan.c~vmscan-total_scanned-fix	2004-12-20 12:47:25.855643408 -0800
+++ 25-akpm/mm/vmscan.c	2004-12-20 12:47:25.860642648 -0800
@@ -1063,6 +1063,7 @@ scan:
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
+			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned >= (zone->nr_active +
_

