Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757420AbWKWQtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbWKWQtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757422AbWKWQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:49:36 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:35465
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1757420AbWKWQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:49:35 -0500
Date: Thu, 23 Nov 2006 16:48:39 +0000
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Lumpy Reclaim V3
Message-ID: <exportbomb.1164300519@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some weeks back I posted a linear reclaim patch series.  Discussions
on that led Peter Zijlstra to propose new simpler block based reclaim
algorithm called 'lumpy'.  We have been testing variants of this to
try and improve its effectivness to close to that of the heavier
weight linear algorithm.  The stack below both remains simple but
gives us pretty useful reclaim rates.

I have left the changes broken out for the time being so as to make
it clear what is the original and what is my fault.  I would expect
to roll this up before acceptance.

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

This patch set (against 2.6.19-rc5-mm2) is based on Peter Zijlstra's
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
