Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVHBVWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVHBVWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVHBVWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:22:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26507 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261837AbVHBVUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:20:18 -0400
Date: Tue, 2 Aug 2005 14:19:54 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: tony.luck@intel.com
cc: Alex Williamson <alex.williamson@hp.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
In-Reply-To: <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0508021416250.18301@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi> <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 tony.luck@intel.com wrote:

> Sadly, running my test case (running 1-4 tasks, each bound to a cpu, each pounding
> on gettimeofday(2)) I'm still seeing significant time spent spinning in this loop.
> Things are better: worst case time was down to just over 2ms from 34ms ... which
> is a significant improvement ... but 2ms still sounds ugly.

I think we should be happy about this. Sounds ok for the problematic 
hardware.

> I'm still seeing the asymmetric behavior where cpu3 sees the really high times,
> while cpu0,1,2 are seeing peaks of 170us, which is still not pretty.

Is this an SMP system? Updates are performed by cpu0 and therefore the 
cacheline is mostly exclusively owned by that processor and then later 
forced to become shared by processors 1,2,3.

> So this is a very half-hearted ACK for the patch.  It does improve things, but I
> still think that code that does:
> 
> 	do {
> 		val = xxx;
> 
> 		// execute some stuff here
> 	} while (cmpxchg(&xxx, val, newval) != val);
> 
> is badly flawed.  If this were in some rare code path that was only likely to see
> collisions when more than three planets were aligned, then it might be OK, but this
> is a common path and it is easy for (malicious) users to force multiple cpus into
> running this code ... making it likely that the cmpxchg will fail repeatedly.

cmpxchg is the best that one can do in this case. If you would take a 
spinlock then we would even need more processing.

We can still switch on the nojitter by default if the ITC's are guaranteed 
to be properly synchronized which will make all this ugliness go away. 

