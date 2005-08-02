Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVHBSmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVHBSmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVHBSjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:39:55 -0400
Received: from fmr22.intel.com ([143.183.121.14]:50852 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261699AbVHBShS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:37:18 -0400
Date: Tue, 2 Aug 2005 11:37:07 -0700
Message-Id: <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
From: tony.luck@intel.com
To: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
In-Reply-To: <Pine.LNX.4.62.0508010906250.6397@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+			/* When holding the xtime write lock, there's no need
+			 * to add the overhead of the cmpxchg.  Readers are
+			 * force to retry until the write lock is released.
+			 */
+			if (writelock) {
+				time_interpolator->last_cycle = now;
+				return now;
+			}

This is lots prettier that my first suggestion (no surprise, even _I_ didn't like
my suggested patch :-)

In theory it looks like it should help a lot as it ought to prevent the worst case
spinning when one cpu has the xtime write lock.

Sadly, running my test case (running 1-4 tasks, each bound to a cpu, each pounding
on gettimeofday(2)) I'm still seeing significant time spent spinning in this loop.
Things are better: worst case time was down to just over 2ms from 34ms ... which
is a significant improvement ... but 2ms still sounds ugly.

I'm still seeing the asymmetric behavior where cpu3 sees the really high times,
while cpu0,1,2 are seeing peaks of 170us, which is still not pretty.

So this is a very half-hearted ACK for the patch.  It does improve things, but I
still think that code that does:

	do {
		val = xxx;

		// execute some stuff here
	} while (cmpxchg(&xxx, val, newval) != val);

is badly flawed.  If this were in some rare code path that was only likely to see
collisions when more than three planets were aligned, then it might be OK, but this
is a common path and it is easy for (malicious) users to force multiple cpus into
running this code ... making it likely that the cmpxchg will fail repeatedly.

-Tony

P.S. My ugly patch does even less to fix this problem ... times are worse than this.
