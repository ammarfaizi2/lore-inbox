Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVI0Wlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVI0Wlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVI0Wlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:41:51 -0400
Received: from fmr13.intel.com ([192.55.52.67]:38633 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S965218AbVI0Wlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:41:50 -0400
Subject: Re: 2.6.14-rc2-mm1
From: Rohit Seth <rohit.seth@intel.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
In-Reply-To: <985130000.1127858385@flay>
References: <922980000.1127847470@flay>
	 <1127851502.6144.10.camel@akash.sc.intel.com>  <970900000.1127855894@flay>
	 <1127857919.7258.13.camel@akash.sc.intel.com>  <985130000.1127858385@flay>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 27 Sep 2005 15:49:06 -0700
Message-Id: <1127861347.7258.47.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 22:41:37.0693 (UTC) FILETIME=[9EDFE4D0:01C5C3B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 14:59 -0700, Martin J. Bligh wrote:


> pcp->batch = max(1UL, batch/2);
> pcp->high = pcp->batch;
> 
> would be more appropriate? Tradeoff is more frequent dump / fill against
> better frag, I suppose (at least if we don't refill using higher order
> allocs ;-)) which seems fair enough.
> 

There are couple of small changes including this one that I will be
sending out in this initialization routine.

> > 
> > Not every time there is a request for higher order pages.  That surely
> > will defeat the purpose of pcps.  But my suggestion is only to drain
> > when the the global pool is not able to service the request.  In the
> > pathological case where the higher order and zero order requests are
> > alternating you could have thrashing in terms of pages moving to pcp for
> > them to move back to global list.
> 
> OK, seems fair enough. But there's multiple "harder and harder" attempts
> within __alloc_pages to do that ... which one are you going for? just 
> before we OOM / fail the alloc? That'd be hard to argue with, though I'm
> unsure what the locking is to dump out other CPUs queues - you going to
> global IPI and ask them to do it - that'd seem to cause it to race to
> refill (as you mention).
>  

Thinking of initiating this drain operation after the swapper daemon is
woken up.  hopefully that will allow other possible pages to be put back
on freelist and reduce the possible thrash of pages between freemem pool
and pcps.

As a first step, I will be draining the local cpu's pcp.  IPI or lazy
purging of pcps could be used as a a very last resort to drain other
CPUs pcps for the scnearios where nothing else has worked to get more
pages.  For these extreme low memory conditions I'm not sure if we
should worry about thrashing any more than having free pages lying
around and not getting used. 

> >> Could you elaborate on what the benefits were from this change in the
> >> first place? Some page colouring thing on ia64? It seems to have way more
> >> downside than upside to me.
> > 
> > The original change was to try to allocate a higher order page to
> > service a batch size bulk request.  This was with the hope that better
> > physical contiguity will spread the data better across big caches.
> 
> OK ... but it has an impact on fragmentation. How much benefit are you
> getting?
> 

Benefit is in terms of reduced performance variation (and expected
throughput) of certain workloads from run to run on the same kernel. 

-rohit

