Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTLQQvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLQQvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:51:48 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:64902 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S264457AbTLQQvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:51:43 -0500
Date: Wed, 17 Dec 2003 17:50:26 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031217165025.GA15691@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, kernel@kolivas.org,
	chris@cvine.freeserve.co.uk, linux-kernel@vger.kernel.org,
	mbligh@aracnet.com
References: <20031216112307.GA5041@k3.hellgate.ch> <Pine.LNX.4.44.0312161126520.19925-100000@chimarrao.boston.redhat.com> <20031217110336.GA5615@k3.hellgate.ch> <20031217110648.GB31393@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217110648.GB31393@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 03:06:48 -0800, William Lee Irwin III wrote:
> to lkml. Hearing more about the various degradations you've identified
> would be helpful.

I'll use 2.6.0-test3 again as the example. That release brought a
slight improvement for qsbench and big slowdowns for kbuild and efax
(check the numbers I posted for details), due to two patches: "fix
kswapd throttling" (patch 1) and "decaying average of zone pressure/use
zone_pressure for page unmapping" (patch 2).

Even as late as test9 I found that reverting patches 1 and 2 changed
performance numbers for all benchmarks pretty much back to test2 level.
Reverting only patch 1 brought a partial improvement, reverting only
patch 2 none at all.

Patch 1 prevented those frequent calls to blk_congestion_wait in
balance_pgdat when enough pages were freed:

diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Jul 17 06:09:38 2003
+++ b/mm/vmscan.c	Fri Aug  1 03:02:09 2003
@@ -930,7 +930,8 @@
 		}
 		if (all_zones_ok)
 			break;
-		blk_congestion_wait(WRITE, HZ/10);
+		if (to_free > 0)
+			blk_congestion_wait(WRITE, HZ/10);
 	}
 	return nr_pages - to_free;
 }

Unconditional blk_congestion_wait breaks (as they have been in test2 and
earlier) reduce the speed at which kswapd can free pages, making it much
more likely that memory is reclaimed by the allocator (try_to_free_pages)
because kswapd fails to keep up with demand.

Patch 2 changed distress and thus reclaim_mapped in refill_inactive_zone.
distress became less volatile -- kernels before test3 tended to consider
mapped pages only after a few iterations in balance_pgdat (i.e. with
raising priority).

To get the benefits of reverting patch 2 in test3/test9 this small
patch should suffice:

diff -u ./mm/vmscan.c ./mm/vmscan.c
--- ./mm/vmscan.c	Wed Nov 19 11:02:51 2003
+++ ./mm/vmscan.c	Wed Nov 19 23:53:06 2003
@@ -632,7 +632,7 @@
 	 * `distress' is a measure of how much trouble we're having reclaiming
 	 * pages.  0 -> no problems.  100 -> great trouble.
 	 */
-	distress = 100 >> zone->prev_priority;
+	distress = 100 >> priority;
 
 	/*
 	 * The point of this algorithm is to decide when to start reclaiming

Without patch 2 (kernel test2 and earlier), kswapd freeing is frequently
interrupted by the allocator satisfying immediate needs. With the
patch, refill is dominated by long, undisturbed sequences driven by
kswapd.

All this has little impact on qsbench because unlike the other two
benchmarks qsbench hardly ever fails to convince refill_inactive_zone to
consider mapped pages as well (thanks to an extremely high mapped_ratio).

Roger
