Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVCGFey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVCGFey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCGFex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:34:53 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:1183 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261652AbVCGFeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:34:23 -0500
Message-ID: <422BE7DA.5040304@yahoo.com.au>
Date: Mon, 07 Mar 2005 16:34:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
References: <1109229491.5177.71.camel@npiggin-nld.site> <1109229542.5177.73.camel@npiggin-nld.site> <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au> <20050305214336.A9085@unix-os.sc.intel.com>
In-Reply-To: <20050305214336.A9085@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:

> 
> By code inspection, I see an issue with this patch
> 	[PATCH 10/13] remove aggressive idle balancing
> 
> Why are we removing cpu_and_siblings_are_idle check from active_load_balance?
> In case of SMT, we  want to give prioritization to an idle package while
> doing active_load_balance(infact, active_load_balance will be kicked
> mainly because there is an idle package) 
> 
> Just the re-addition of cpu_and_siblings_are_idle check to 
> active_load_balance might not be enough. We somehow need to communicate 
> this to move_tasks, otherwise can_migrate_task will fail and we will 
> never be able to do active_load_balance.
> 

Active balancing should only kick in after the prescribed number
of rebalancing failures - can_migrate_task will see this, and
will allow the balancing to take place.

That said, we currently aren't doing _really_ well for SMT on
some workloads, however with this patch we are heading in the
right direction I think.

I have been mainly looking at tuning CMP Opterons recently (they
are closer to a "traditional" SMP+NUMA than SMT, when it comes
to the scheduler's point of view). However, in earlier revisions
of the patch I had been looking at SMT performance and was able
to get it much closer to perfect:

I was working on a 4 socket x440 with HT. The problem area is
usually when the load is lower than the number of logical CPUs.
So on tbench, we do say 450MB/s with 4 or more threads without
HT, and 550MB/s with 8 or more threads with HT, however we only
do 300MB/s with 4 threads.

Those aren't the exact numbers, but that's basically what they
look like. Now I was able to bring the 4 thread + HT case much
closer to the 4 thread - HT numbers, but with earlier patchsets.
When I get a chance I will do more tests on the HT system, but
the x440 is infuriating for fine tuning performance, because it
is a NUMA system, but it doesn't tell the kernel about it, so
it will randomly schedule things on "far away" CPUs, and results
vary.

PS. Another thing I would like to see tested is a 3 level domain
setup (SMT + SMP + NUMA). I don't have access to one though.

