Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVI0V7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVI0V7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVI0V7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:59:50 -0400
Received: from dvhart.com ([64.146.134.43]:25741 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965176AbVI0V7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:59:49 -0400
Date: Tue, 27 Sep 2005 14:59:45 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <985130000.1127858385@flay>
In-Reply-To: <1127857919.7258.13.camel@akash.sc.intel.com>
References: <922980000.1127847470@flay> <1127851502.6144.10.camel@akash.sc.intel.com>  <970900000.1127855894@flay> <1127857919.7258.13.camel@akash.sc.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I must be being particularly dense today ... but:
>> 
>>  pcp->high = batch / 2; 
>> 
>> Looks like half the batch size to me, not the same? 
> 
> pcp->batch = max(1UL, batch/2); is the line of code that is setting the
> batch value for the cold pcp list.  batch is just a number that we
> counted based on some parameters earlier.

Ah, OK, so I am being dense. Fair enough. But if there's a reason to do
that max, perhaps:

pcp->batch = max(1UL, batch/2);
pcp->high = pcp->batch;

would be more appropriate? Tradeoff is more frequent dump / fill against
better frag, I suppose (at least if we don't refill using higher order
allocs ;-)) which seems fair enough.

>> > In general, I think if a specific higher order ( > 0) request fails that
>> > has GFP_KERNEL set then at least we should drain the pcps.
>> 
>> Mmmm. so every time we fork a process with 8K stacks, or allocate a frame
>> for jumbo ethernet, or NFS, you want to drain the lists? that seems to
>> wholly defeat the purpose.
> 
> Not every time there is a request for higher order pages.  That surely
> will defeat the purpose of pcps.  But my suggestion is only to drain
> when the the global pool is not able to service the request.  In the
> pathological case where the higher order and zero order requests are
> alternating you could have thrashing in terms of pages moving to pcp for
> them to move back to global list.

OK, seems fair enough. But there's multiple "harder and harder" attempts
within __alloc_pages to do that ... which one are you going for? just 
before we OOM / fail the alloc? That'd be hard to argue with, though I'm
unsure what the locking is to dump out other CPUs queues - you going to
global IPI and ask them to do it - that'd seem to cause it to race to
refill (as you mention).
 
>> Could you elaborate on what the benefits were from this change in the
>> first place? Some page colouring thing on ia64? It seems to have way more
>> downside than upside to me.
> 
> The original change was to try to allocate a higher order page to
> service a batch size bulk request.  This was with the hope that better
> physical contiguity will spread the data better across big caches.

OK ... but it has an impact on fragmentation. How much benefit are you
getting?

M.
