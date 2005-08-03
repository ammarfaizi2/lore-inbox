Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVHCOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVHCOnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVHCOnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:43:10 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:46804 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262291AbVHCOmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:42:43 -0400
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
From: Alex Williamson <alex.williamson@hp.com>
To: tony.luck@intel.com
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
References: <1122911571.5243.23.camel@tdi>
	 <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 03 Aug 2005 08:42:35 -0600
Message-Id: <1123080155.5193.15.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 11:37 -0700, tony.luck@intel.com wrote:

> Sadly, running my test case (running 1-4 tasks, each bound to a cpu, each pounding
> on gettimeofday(2)) I'm still seeing significant time spent spinning in this loop.
> Things are better: worst case time was down to just over 2ms from 34ms ... which
> is a significant improvement ... but 2ms still sounds ugly.

   I'll settle for an order of magnitude improvement for a first pass :)

> I'm still seeing the asymmetric behavior where cpu3 sees the really high times,
> while cpu0,1,2 are seeing peaks of 170us, which is still not pretty.

   How does cpu3's ITC synchronization compare to the others?  I suspect
there's some reasonable way that we could do a backoff w/i the do {}
while() loop, but I'm not sure what it is.  For a while, I was toying
around with the idea of how to convert:

	if (lcycle && time_after(lcycle, now))
		return lcycle;

into:

	if (lcycle && time_after(lcycle + min_delta, now))
		return lcycle;

But I don't know how that min_delta would be determined.  A "close
enough" factor like this would still prevent jitter, but would introduce
a minimum granularity increment of gettimeofday().  I think this might
be a reasonable performance vs absolute accuracy trade-off.  What
happens to your worst case time if you (just for a test) hard code a
min_delta of something around 20-50?  There could be some kind of
boot/run time tunable to set this min_delta if there's no good way to
calculate it.  It should be trivial to add something like this to the
fsys path as well and shouldn't disrupt the nojitter path at all.
Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

