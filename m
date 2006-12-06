Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936685AbWLFQ7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936685AbWLFQ7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936692AbWLFQ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:59:43 -0500
Received: from 40.150.104.212.access.eclipse.net.uk ([212.104.150.40]:53740
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S936685AbWLFQ7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:59:42 -0500
Date: Wed, 6 Dec 2006 16:59:04 +0000
To: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Mel Gorman <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Lumpy Reclaim V3
Message-ID: <exportbomb.1165424343@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of the lumpy reclaim patch set.  This is
basically unchanged from the last post, other than being rebased
to 2.6.19-rc2-mm2.  This has passed basic stress testing on a range
of machines here.

[Sorry for the delay reposting, I had a test failure and needed
to confirm it was not due to lumpy before posting.]

As before, I have left the changes broken out for the time being
so as to make it clear what is the original and what is my fault.
I would expect to roll this up before acceptance.

-apw

=== 8< ===
Lumpy Reclaim (V3)

When we are out of memory of a suitable size we enter reclaim.
The current reclaim algorithm targets pages in LRU order, which
is great for fairness but highly unsuitable if you desire pages at
higher orders.  To get pages of higher order we must shoot down a
very high proportion of memory; >95% in a lot of cases.

This patch set adds a lumpy reclaim algorithm to the allocator.
It targets groups of pages at the specified order anchored at the
end of the active and inactive lists.  This encourages groups of
pages at the requested orders to move from active to inactive,
and active to free lists.  This behaviour is only triggered out of
direct reclaim when higher order pages have been requested.

This patch set is particularly effective when utilised with
an anti-fragmentation scheme which groups pages of similar
reclaimability together.

This patch set (against 2.6.19-rc6-mm2) is based on Peter Zijlstra's
lumpy reclaim V2 patch which forms the foundation.  It comprises
the following patches:

lumpy-reclaim-v2 -- Peter Zijlstra's lumpy reclaim prototype,

lumpy-cleanup-a-missplaced-comment-and-simplify-some-code --
  cleanups to move a comment back to where it came from, to make
  the area edge selection more comprehensible and also cleans up
  the switch coding style to match the concensus in mm/*.c,

lumpy-ensure-we-respect-zone-boundaries -- bug fix to ensure we do
  not attempt to take pages from adjacent zones, and

lumpy-take-the-other-active-inactive-pages-in-the-area -- patch to
  increase aggression over the targetted order.

Testing of this patch set under high fragmentation high allocation
load conditions shows significantly improved high order reclaim
rates than a standard kernel.  The stack here it is now within 5%
of the best case linear-reclaim figures.

It would be interesting to see if this setup is also successful in
reducing order-2 allocation failures that you have been seeing with
jumbo frames.

Please consider for -mm.

-apw
(lumpy-v3r7)
