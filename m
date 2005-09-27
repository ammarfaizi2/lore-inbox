Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbVI0Wte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbVI0Wte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVI0Wte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:49:34 -0400
Received: from dvhart.com ([64.146.134.43]:28301 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751124AbVI0Wtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:49:33 -0400
Date: Tue, 27 Sep 2005 15:49:29 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <1007710000.1127861369@flay>
In-Reply-To: <1127861347.7258.47.camel@akash.sc.intel.com>
References: <922980000.1127847470@flay> <1127851502.6144.10.camel@akash.sc.intel.com>  <970900000.1127855894@flay> <1127857919.7258.13.camel@akash.sc.intel.com>  <985130000.1127858385@flay> <1127861347.7258.47.camel@akash.sc.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Not every time there is a request for higher order pages.  That surely
>> > will defeat the purpose of pcps.  But my suggestion is only to drain
>> > when the the global pool is not able to service the request.  In the
>> > pathological case where the higher order and zero order requests are
>> > alternating you could have thrashing in terms of pages moving to pcp for
>> > them to move back to global list.
>> 
>> OK, seems fair enough. But there's multiple "harder and harder" attempts
>> within __alloc_pages to do that ... which one are you going for? just 
>> before we OOM / fail the alloc? That'd be hard to argue with, though I'm
>> unsure what the locking is to dump out other CPUs queues - you going to
>> global IPI and ask them to do it - that'd seem to cause it to race to
>> refill (as you mention).
>>  
> 
> Thinking of initiating this drain operation after the swapper daemon is
> woken up.  hopefully that will allow other possible pages to be put back
> on freelist and reduce the possible thrash of pages between freemem pool
> and pcps.

OK, but waking up kswapd doesn't indicate a low memory condition.
It's standard procedure .... we'll have to wake it up whenever we dip
below the high watermarks. Perhaps before dropping into direct reclaim
would be more appropriate?
 
> As a first step, I will be draining the local cpu's pcp.  IPI or lazy
> purging of pcps could be used as a a very last resort to drain other
> CPUs pcps for the scnearios where nothing else has worked to get more
> pages.  For these extreme low memory conditions I'm not sure if we
> should worry about thrashing any more than having free pages lying
> around and not getting used. 

Sounds fair.
 
>> >> Could you elaborate on what the benefits were from this change in the
>> >> first place? Some page colouring thing on ia64? It seems to have way more
>> >> downside than upside to me.
>> > 
>> > The original change was to try to allocate a higher order page to
>> > service a batch size bulk request.  This was with the hope that better
>> > physical contiguity will spread the data better across big caches.
>> 
>> OK ... but it has an impact on fragmentation. How much benefit are you
>> getting?
> 
> Benefit is in terms of reduced performance variation (and expected
> throughput) of certain workloads from run to run on the same kernel. 

Mmmm. how much are you talking about in terms of throughput, and on what
platforms? all previous attempts to measure page colouring seemed to 
indicate it did nothing at all - maybe some specific types of h/w are
more susceptible?

M.

