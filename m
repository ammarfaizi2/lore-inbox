Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVKCDMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVKCDMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVKCDMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:12:45 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:10351 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030308AbVKCDMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:12:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aGdXJFyQMxMnEiBSa88as757i4SJo25zUor5NKxzrt573w6A9wR/lF3VUEDpmZZGCIbT7mVOHWsjcmD8wOXdSCPHdatVqloo0IRNhdJWQ5BJlfDVr6AyibK07Q6OZ0JNuaPXplLXgxLwiWXZDO1bGDiaSwldVr1CYkg5LPvwdA8=  ;
Message-ID: <43698080.3040800@yahoo.com.au>
Date: Thu, 03 Nov 2005 14:14:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 - Summary
References: <20051030235440.6938a0e9.akpm@osdl.org>  <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au>  <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost>  <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost> <43680D8C.5080500@yahoo.com.au> <Pine.LNX.4.58.0511021231440.5235@skynet>
In-Reply-To: <Pine.LNX.4.58.0511021231440.5235@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:

> 
> Ok. To me, the rest of the thread are beating around the same points and
> no one is giving ground. The points are made so lets summarise. Apologies
> if anything is missing.
> 

Thanks for attempting a summary of a difficult topic. I have a couple
of suggestions.

> Who cares
> =========
>   Physical hotplug remove: Vendors of the hardware that support this -
> 	Fujitsu, HP (I think), IBM etc
> 
>   Virtualization hotplug remove: Sellers of virtualization software, some
> 	hardware like any IBM machine that lists LPAR in it's list of
> 	features.  Probably software solutions like Xen are also affected
> 	if they want to be able to grow and shrink the virtual machines on
> 	demand
> 

Ingo said that Xen is fine with per page granular freeing - this covers
embedded, desktop and small server users of VMs into the future I'd say.

>   High order allocations: Ultimately, hugepage users. Today, that is a
> 	feature only big server users like Oracle care about. In the
> 	future I reckon applications will be able to use them for things
> 	like backing the heap by huge pages. Other users like GigE,
> 	loopback devices with large MTUs, some filesystem like CIFS are
> 	all interested although they are also been told use use smaller
> 	pages.
> 

I think that saying its now OK to use higher order allocations is wrong
because as I said even with your patches they are going to run into
problems.

Actually I think one reason your patches may perform so well is because
there aren't actually a lot of higher order allocations in the kernel.

I think that probably leaves us realistically with demand hugepages,
hot unplug memory, and IBM lpars?


> Pros/Cons of Solutions
> ======================
> 
> Anti-defrag Pros
>   o Aim9 shows no significant regressions (.37% on page_test). On some
>     tests, it shows performance gains (> 5% on fork_test)
>   o Stress tests show that it manages to keep fragmentation down to a far
>     lower level even without teaching kswapd how to linear reclaim

This sounds like a kind of funny test to me if nobody is actually
using higher order allocations.

When a higher order allocation is attempted, either you will satisfy
it from the kernel region, in which case the vanilla kernel would
have done the same. Or you satisfy it from an easy-reclaim contiguous
region, in which case it is no longer an easy-reclaim contiguous
region.

>   o Stress tests with a linear reclaim experimental patch shows that it
>     can successfully find large contiguous chunks of memory
>   o It is known to help hotplug on PPC64
>   o No tunables. The approach tries to manage itself as much as possible

But it has more dreaded heuristics :P

>   o It exists, heavily tested, and synced against the latest -mm1
>   o Can be compiled away be redefining the RCLM_* macros and the
>     __GFP_*RCLM flags
> 
> Anti-defrag Cons
>   o More complexity within the page allocator
>   o Adds a new layer onto the allocator that effectively creates subzones
>   o Adding a new concept that maintainers have to work with
>   o Depending on the workload, it fragments anyway
> 
> New Zone Pros
>   o Zones are a well known and understood concept
>   o For people that do not care about hotplug, they can easily get rid of it
>   o Provides reliable areas of contiguous groups that can be freed for
>     HugeTLB pages going to userspace
>   o Uses existing zone infrastructure for balancing
> 
> New Zone Cons
>   o Zones historically have introduced balancing problems
>   o Been tried for hotplug and dropped because of being awkward to work with
>   o It only helps hotplug and potentially HugeTLB pages for userspace
>   o Tunable required. If you get it wrong, the system suffers a lot

Pro: it keeps IBM mainframe and pseries sysadmins in a job ;) Let
them get it right.

>   o Needs to be planned for and developed
> 

Yasunori Goto had patches around from last year. Not sure what sort
of shape they're in now but I'd think most of the hard work is done.

> Scenarios
> =========
> 
> Lets outline some situations then or workloads that can occur
> 
> 1. Heavy job running that consumes 75% of physical memory. Like a kernel
>    build
> 
>   Anti-defrag: It will not fragment as it will never have to fallback.High
> 	order allocations will be possible in the remaining 25%.
>   Zone-based: After been tuned to a kernel build load, it will not
> 	fragment. Get the tuning wrong, performance suffers or workload
> 	fails. High order allocations will be possible in the remaining 25%.
> 

You don't need to continually tune things for each and every possible
workload under the sun. It is like how we currently drive 16GB highmem
systems quite nicely under most workloads with 1GB of normal memory.
Make that an 8:1 ratio if you're worried.

[snip]

> 
> I've tried to be as objective as possible with the summary.
> 
>>From the points above though, I think that anti-defrag gets us a lot of
> the way, with the complexity isolated in one place. It's downside is that
> it can still break down and future work is needed to stop it degrading
> (kswapd cleaning UserRclm areas and page migration when we get really
> stuck). Zone-based is more reliable but only addresses a limited
> situation, principally hotplug and it does not even go 100% of the way for
> hotplug. 

To me it seems like it solves the hotplug, lpar hotplug, and hugepages
problems which seem to be the main ones.

 > It also depends on a tunable which is not cool and it is static.

I think it is very cool because it means the tiny minority of Linux
users who want this can do so without impacting the rest of the code
or users. This is how Linux has been traditionally run and I still
have a tiny bit of faith left :)

> If we make the zones growable+shrinkable, we run into all the same
> problems that anti-defrag has today.
> 

But we don't have the extra zones layer that anti defrag has today.

And anti defrag needs limits if it is to be reliable anyway.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
