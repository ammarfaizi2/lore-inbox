Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269926AbUJGXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269926AbUJGXlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJGXhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:37:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:30593 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269920AbUJGXgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:36:51 -0400
Date: Thu, 7 Oct 2004 16:40:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007164044.23bac609.akpm@osdl.org>
In-Reply-To: <20041007142019.D2441@build.pdx.osdl.net>
References: <20041007142019.D2441@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> Is this known?  Just came back from lunch, so I've no clue what kicked it
> off.  Profile below. (2.6.9-rc3-bk from yesterday, pending updates don't
> appear to touch vmscan or mm/ in general).
> 
> CPU: AMD64 processors, speed 1994.35 MHz (estimated)
> Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a
> unit mask
> of 0x00 (No unit mask) count 100000
> samples  %        symbol name
> 2410135  53.4092  balance_pgdat
> 1328186  29.4329  shrink_zone
> 555121   12.3016  shrink_slab
> 84942     1.8823  __read_page_state

Oh fanfuckingtastic.  Something in there is failing to reach its
termination condition.  The code has become a trainwreck, so heaven knows
what it was.

For starters, let's actually use that local variable for something.





We haven't been incrementing local variable total_scanned since the
scan_control stuff went in.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/vmscan.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN mm/vmscan.c~vmscan-total_scanned-fix mm/vmscan.c
--- 25/mm/vmscan.c~vmscan-total_scanned-fix	Thu Oct  7 16:31:55 2004
+++ 25-akpm/mm/vmscan.c	Thu Oct  7 16:31:55 2004
@@ -1054,6 +1054,7 @@ scan:
 			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
+			total_scanned += sc.nr_scanned;
 			if (zone->all_unreclaimable)
 				continue;
 			if (zone->pages_scanned > zone->present_pages * 2)
_



This probably won't fix it.

It looks like the code will lock up if all zones are out of unreclaimable
memory, but you won't be hitting that.

I also wonder if it'll lock up if just the first zone has ->all_unreclaimable.

I think a good starting point here will be to revert the most recent
change.
