Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVKCPem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVKCPem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVKCPek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:34:40 -0500
Received: from dvhart.com ([64.146.134.43]:52397 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030334AbVKCPeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:34:31 -0500
Date: Thu, 03 Nov 2005 07:34:31 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Mel Gorman <mel@csn.ul.ie>
Cc: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 - Summary
Message-ID: <305710000.1131032071@[10.10.2.4]>
In-Reply-To: <43698080.3040800@yahoo.com.au>
References: <20051030235440.6938a0e9.akpm@osdl.org>  <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au>  <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost>  <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost> <43680D8C.5080500@yahoo.com.au> <Pine.LNX.4.58.0511021231440.5235@skynet> <43698080.3040800@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   Physical hotplug remove: Vendors of the hardware that support this -
>> 	Fujitsu, HP (I think), IBM etc
>> 
>>   Virtualization hotplug remove: Sellers of virtualization software, some
>> 	hardware like any IBM machine that lists LPAR in it's list of
>> 	features.  Probably software solutions like Xen are also affected
>> 	if they want to be able to grow and shrink the virtual machines on
>> 	demand
> 
> Ingo said that Xen is fine with per page granular freeing - this covers
> embedded, desktop and small server users of VMs into the future I'd say.

Not using large page mappings for the kernel area will be a substantial
performance hit. It's a less efficient approach inside the hypervisor, 
and not all VMs / hardware can support it.
 
>>   High order allocations: Ultimately, hugepage users. Today, that is a
>> 	feature only big server users like Oracle care about. In the
>> 	future I reckon applications will be able to use them for things
>> 	like backing the heap by huge pages. Other users like GigE,
>> 	loopback devices with large MTUs, some filesystem like CIFS are
>> 	all interested although they are also been told use use smaller
>> 	pages.
> 
> I think that saying its now OK to use higher order allocations is wrong
> because as I said even with your patches they are going to run into
> problems.
> 
> Actually I think one reason your patches may perform so well is because
> there aren't actually a lot of higher order allocations in the kernel.
> 
> I think that probably leaves us realistically with demand hugepages,
> hot unplug memory, and IBM lpars?

Sigh. You seem obsessed with this. There are various critical places in
the kernel that use higher order allocations. Yes, they're normally
smaller ones rather than larger ones, but .... please try re-reading
the earlier portions of this thread. You are NOT going to be able to
get rid of all higher-order allocations - please quit pretending you
can - living in denial is not going to help us.

If you really, really believe you can do that, please go ahead and prove
it. Until that point, please let go of the "it's only for a few specialized
users" arguement, and acknowledge we DO actually use higher order allocs
in the kernel right now.

>>   o Aim9 shows no significant regressions (.37% on page_test). On some
>>     tests, it shows performance gains (> 5% on fork_test)
>>   o Stress tests show that it manages to keep fragmentation down to a far
>>     lower level even without teaching kswapd how to linear reclaim
> 
> This sounds like a kind of funny test to me if nobody is actually
> using higher order allocations.

It's a regression test. To, like, test for regressions in the normal
case ;-)

>> New Zone Cons
>>   o Zones historically have introduced balancing problems
>>   o Been tried for hotplug and dropped because of being awkward to work with
>>   o It only helps hotplug and potentially HugeTLB pages for userspace
>>   o Tunable required. If you get it wrong, the system suffers a lot
> 
> Pro: it keeps IBM mainframe and pseries sysadmins in a job ;) Let
> them get it right.

Having met some of them ... that's not a pro ;-) We have quite enough
meaningless tunables already. And to be honest, the bigger problem is
that it's a problem with no correct answer - workloads shift day vs.
night, etc.
 
> You don't need to continually tune things for each and every possible
> workload under the sun. It is like how we currently drive 16GB highmem
> systems quite nicely under most workloads with 1GB of normal memory.
> Make that an 8:1 ratio if you're worried.

Thanks for turning my 64 bit system back into a 32 bit one. really 
appreciate that. Note the last 5 years of endless whining about all
the problems with large 32 bit systems, and how they're unfixable
and we should all move to 64 bit please.
 
> To me it seems like it solves the hotplug, lpar hotplug, and hugepages
> problems which seem to be the main ones.

That's because you're not listening, you're going on your own preconcieved
notions ...
 
> I think it is very cool because it means the tiny minority of Linux
> users who want this can do so without impacting the rest of the code
> or users.

Ditto.
 
M.

