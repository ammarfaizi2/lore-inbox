Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTDURqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTDURqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:46:46 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:9695 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261801AbTDURqo (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 21 Apr 2003 13:46:44 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16036.12627.477016.967042@laputa.namesys.com>
Date: Mon, 21 Apr 2003 21:58:43 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Digeo.COM>
Subject: zone->nr_inactive race?
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Windows: dissatisfaction guaranteed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am observing on 2.5.67 that sometimes shrink_slab() is called with
insanely huge total_scanned. In kgdb I see

(gdb) f
#1  0xc013734c in shrink_caches (classzone=0xc04ad680, priority=12, 
    total_scanned=0xddf15b60, gfp_mask=210, nr_pages=32, ps=0xddf15b64)
    at mm/vmscan.c:794
(gdb) p/x max_scan
$20 = 0xfffff # which looks suspiciously similar to ((unsigned)-1) >> 12
(gdb) p priority
$21 = 12
(gdb) p zone->nr_inactive
$22 = 0
(gdb) info threads
....
  16 Thread 17  0xc012e37c in unlock_page (page=0xc14d12c8)
    at include/asm/bitops.h:175
...
(gdb) thread 16 # this is the only other thread doing something page cache related at the moment
(gdb) bt
#0  0xc012e37c in unlock_page (page=0xc14d12c8) at include/asm/bitops.h:175
#1  0xc01369d9 in shrink_list (page_list=0xdfd27e54, gfp_mask=208, 
    max_scan=0xdfd27eb8, nr_mapped=0xdfd27f0c, priority=7) at mm/vmscan.c:434
#2  0xc0136c56 in shrink_cache (nr_pages=513, zone=0xc04ad680, gfp_mask=208, 
    max_scan=637, nr_mapped=0xdfd27f0c, priority=7) at mm/vmscan.c:517
#3  0xc01372bd in shrink_zone (zone=0xc04ad680, max_scan=1026, gfp_mask=208, 
    nr_pages=513, nr_mapped=0xdfd27f0c, ps=0xdfd27f44, priority=7)
    at mm/vmscan.c:746
#4  0xc0137527 in balance_pgdat (pgdat=0xc04ac280, nr_pages=0, ps=0xdfd27f44)
    at mm/vmscan.c:909
#5  0xc01376a7 in kswapd (p=0xc04ac280) at mm/vmscan.c:969

Looks like zone->nr_inactive was negative.

After some more debugging I managed to break into kgbd when
zone->nr_inactive is 0xffffffc0 (again in shrink_caches()). On the
another processor a thread is running inside refill_inactive_zone():

	while (!list_empty(&l_inactive)) {
		page = list_entry(l_inactive.prev, struct page, lru);
		prefetchw_prev_lru_page(page, &l_inactive, flags);
		if (TestSetPageLRU(page))
			BUG();

(somewhere near to TestSetPageLRU(page)).

(gdb) bt
#0  0xc0137008 in refill_inactive_zone (zone=0xc04ad680, nr_pages_in=128, 
    ps=0xdd921a24, priority=9) at include/asm/bitops.h:136
#1  0xc01372a6 in shrink_zone (zone=0xc04ad680, max_scan=64, gfp_mask=210, 
    nr_pages=32, nr_mapped=0xdd9219e4, ps=0xdd921a24, priority=9)
    at mm/vmscan.c:744
#2  0xc0137349 in shrink_caches (classzone=0xc04ad680, priority=9, 
    total_scanned=0xdd921a20, gfp_mask=210, nr_pages=32, ps=0xdd921a24)
    at mm/vmscan.c:794
#3  0xc0137417 in try_to_free_pages (classzone=0xc04ad680, gfp_mask=210, 
    order=0) at mm/vmscan.c:836
#4  0xc0131848 in __alloc_pages (gfp_mask=210, order=0, zonelist=0xc04afea0)
    at mm/page_alloc.c:610
...

This fragment of refill_inactive_zone() looks strange:

		list_move(&page->lru, &zone->inactive_list);
		if (!pagevec_add(&pvec, page)) {
			spin_unlock_irq(&zone->lru_lock);
			if (buffer_heads_over_limit)
				pagevec_strip(&pvec);
			__pagevec_release(&pvec);
			spin_lock_irq(&zone->lru_lock);
		}

page is already on the inactive list (but not accounted for in
zone->nr_inactive). Zone spin lock is released. If at this moment other
thread would call del_page_from_lru(page), zone->nr_inactive can go
negative.

Let me know if more info is necessary, I can reproduce this.

Nikita.
