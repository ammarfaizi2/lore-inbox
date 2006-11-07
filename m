Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752593AbWKGVuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbWKGVuD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbWKGVuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:50:02 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39401 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753196AbWKGVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:50:00 -0500
Date: Tue, 7 Nov 2006 13:49:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: RE: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <000001c702b4$9895c730$e734030a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0611071339001.5893@schroedinger.engr.sgi.com>
References: <000001c702b4$9895c730$e734030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Chen, Kenneth W wrote:

> > What broke the system was the disabling of interrupts over long time 
> > periods during load balancing.
> The previous global load balancing tasket could be an interesting data point.

Yup seems also very interesting to me. We could drop the staggering code 
f.e. if we would leave the patch as is. Maybe there are other ways to 
optimize the code because we know that there are no concurrent 
balance_tick() functions running.

> Do you see a lot of imbalance in the system with the global tasket?  Does it
> take prolonged interval to reach balanced system from imbalance?

I am rather surprised that I did not see any problems but I think we would 
need some more testing. It seems that having only one load balance 
running at one time speeds up load balacing in general since there is 
less lock contention.

Timer interrupts are staggered already. If the tasklet finishes soon then 
we will not have a problem and load balancing runs as before. If the 
tasklet performance gets throttled by something then it is good to 
serialize load balancing since we already have memory contention.  
Performing concurrent scans of runqueues (as is now) would increase the 
problem.

Before we saw multiple load balance actions ongoing at the same time which 
caused node overload because multiple cache line refetches from remote 
nodes occurred. I think it was mostly node 0 that got overloaded so that 
load balancing performance dropped significantly.

> Conceptually, it doesn't make a lot of sense to serialize load balance in the
> System.  But in practice, maybe it is good enough to cycle through each cpu
> (I suppose it all depends on the user environment).  This exercise certainly
> make me to think in regards to what is the best algorithm in terms of efficiency
> and minimal latency to achieve maximum system throughput.  Does kernel really
> have to do load balancing so aggressively in polling mode? Perhaps an event
> driven mechanism is a better solution.

There is no other way to do load balancing since we have to calculate the 
load over many processors and then figure out the one with the most load.
