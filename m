Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbUEPGKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUEPGKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 02:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUEPGK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 02:10:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:4763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263138AbUEPGK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 02:10:26 -0400
Date: Sat, 15 May 2004 23:09:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: torvalds@osdl.org, adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040515230947.641685ca.akpm@osdl.org>
In-Reply-To: <200405152354.26083.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<200405152231.15099.elenstev@mesatop.com>
	<Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org>
	<200405152354.26083.elenstev@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
>  > Hmm.. Th ecurrent BK tree contains much of the anonvma stuff, so this 
>  > might actually be a serious VM performance regression. That could 
>  > effectively be hiding whatever problem you saw.
> 
>  [steven@spc steven]$ vmstat -n 1 15

I have a feeling that the pageout performance got broken again, even more. 
It was OK for a while and we need to backtrack and see where it went wrong.

The below might improve things, but I doubt it.




From: Nick Piggin <nickpiggin@yahoo.com.au>

If the zone has a very small number of inactive pages, local variable
`ratio' can be huge and we do way too much scanning.  So much so that Ingo
hit an NMI watchdog expiry, although that was because the zone would have a
had a single refcount-zero page in it, and that logic recently got fixed up
via get_page_testone().

Nick's patch simply puts a sane-looking upper bound on the number of pages
which we'll scan in this round.  It hasn't had a lot of thought or testing
yet.  


---

 25-akpm/mm/vmscan.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff -puN mm/vmscan.c~vm-shrink-zone mm/vmscan.c
--- 25/mm/vmscan.c~vm-shrink-zone	2004-05-15 23:08:36.471571816 -0700
+++ 25-akpm/mm/vmscan.c	2004-05-15 23:08:36.476571056 -0700
@@ -745,23 +745,29 @@ static int
 shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
 		int *total_scanned, struct page_state *ps, int do_writepage)
 {
-	unsigned long ratio;
+	unsigned long scan_active;
 	int count;
 
 	/*
 	 * Try to keep the active list 2/3 of the size of the cache.  And
 	 * make sure that refill_inactive is given a decent number of pages.
 	 *
-	 * The "ratio+1" here is important.  With pagecache-intensive workloads
-	 * the inactive list is huge, and `ratio' evaluates to zero all the
-	 * time.  Which pins the active list memory.  So we add one to `ratio'
-	 * just to make sure that the kernel will slowly sift through the
-	 * active list.
+	 * The "scan_active + 1" here is important.  With pagecache-intensive
+	 * workloads the inactive list is huge, and `ratio' evaluates to zero
+	 * all the time.  Which pins the active list memory.  So we add one to
+	 * `scan_active' just to make sure that the kernel will slowly sift
+	 * through the active list.
 	 */
-	ratio = (unsigned long)SWAP_CLUSTER_MAX * zone->nr_active /
-				((zone->nr_inactive | 1) * 2);
+	if (zone->nr_active >= 4*(zone->nr_inactive*2 + 1)) {
+		/* Don't scan more than 4 times the inactive list scan size */
+		scan_active = 4*max_scan;
+	} else {
+		/* Cast to long long so the multiply doesn't overflow */
+		scan_active = (unsigned long long)max_scan * zone->nr_active
+					/ (zone->nr_inactive*2 + 1);
+	}
 
-	atomic_add(ratio+1, &zone->nr_scan_active);
+	atomic_add(scan_active + 1, &zone->nr_scan_active);
 	count = atomic_read(&zone->nr_scan_active);
 	if (count >= SWAP_CLUSTER_MAX) {
 		atomic_set(&zone->nr_scan_active, 0);

_

