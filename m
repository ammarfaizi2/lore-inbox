Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293052AbSCEFR1>; Tue, 5 Mar 2002 00:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293154AbSCEFRS>; Tue, 5 Mar 2002 00:17:18 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:41708 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S293052AbSCEFRA>; Tue, 5 Mar 2002 00:17:00 -0500
Date: Mon, 04 Mar 2002 21:17:39 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] breaking up the pagemap_lru_lock in rmap
Message-ID: <793424263.1015276658@[10.10.2.3]>
In-Reply-To: <20020305030204.A20606@dualathlon.random>
In-Reply-To: <20020305030204.A20606@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, March 05, 2002 3:02 AM +0100 Andrea Arcangeli 
<andrea@suse.de> wrote:

> On Mon, Mar 04, 2002 at 10:04:51AM -0800, Martin J. Bligh wrote:
>> High contention on the pagemap_lru lock seems to be a major
>> scalability problem for rmap at the moment. Based on wli's and
>> Rik's suggestions, I've made a first cut at a patch to split up the
>> lock into a per-page lock for each pte_chain.
>
> some year ago when I put a spinlock in the page structure I was flamed :)
> That was fair enough. Sometime the theorical maximum degree of
> scalability doesn't worth the additional ram usage.

I'm starting to think that I used an extremely large power jackhammer
to break this up a little too much ;-) I'm not too broken-hearted about the
RAM usage - seems to me that the capacity of memory is growing faster than
its speed. John Stultz also pointed out to me today that the atomic ops to
grab these things aren't free either, but if we're grabbing and releasing
the lock just to do ops on one page at a time, then collating back up to
something larger scale won't help.

> but anyways, can you show where do you see this high contenction on the
> pagemap_lru lock?

 45.5% 72.0%  8.5us( 341us)  138us(  11ms)(44.3%)   3067414 28.0% 72.0% 
0%  pagemap_lru_lock
 0.03% 31.7%  5.2us(  30us)  139us(3473us)(0.02%)      3204 68.3% 31.7% 
0%    deactivate_page+0xc
  6.0% 78.3%  6.8us(  87us)  162us(9847us)( 9.4%)    510349 21.7% 78.3% 
0%    lru_cache_add+0x2c
  6.7% 73.2%  7.6us( 180us)  120us(8138us)( 6.4%)    506534 26.8% 73.2% 
0%    lru_cache_del+0xc
 12.7% 64.2%  7.1us( 151us)  140us(  10ms)(13.4%)   1023578 35.8% 64.2% 
0%    page_add_rmap+0x2c
 20.1% 76.0%   11us( 341us)  133us(  11ms)(15.0%)   1023749 24.0% 76.0% 
0%    page_remove_rmap+0x3c

12 way NUMA-Q doing a kernel compile. Compile time increases by about 50%,
which surely isn't wholly due to this, but it does stick out like a sore
thumb in the lockmeter data. The NUMA characteristics of the machine make
this even worse - notice the 11ms wait time for a max hold time of 341us -
looks like the lock's getting bounced around unfairly within the node.
Average wait isn't too bad, but look at the count on it ;-(
I'll try John's MCS-type locking stuff one of these days when
I get a minute ... I suspect it'll help, but not be the proper answer.

I suspect that once we've cracked this lock, there will be a few other
scalability things lying underneath, but that seems top of the pile
right now.

> Maybe that's more a sympthom that the rmap is doing
> something silly with the lock acquired,

It seems that we're reusing the pagemap_lru_lock for both the lru chain
and the pte chain locking, which is hurting somewhat. Maybe a per-zone
lock is enough to break this up (would also dispose of cross-node lock
cacheline bouncing) ... I still think the two chains need to be seperated
from each other though.

> can you measure high contention
> also on my tree on similar workloads?

If I could boot your kernel ;-) When I have a free moment, I'll try
those fixes you already sent me to get the early ioremap working.
As the main users (both in count and duration) seem to be page_add_rmap
and page_remove_rmap, I doubt your kernel will have anything like the
same contention on that lock.

> I think we should worry about the
> pagecache_lock, before the pagemap_lru lock. During heavy paging
> activity, the system should become I/O bound, and the spinlock there
> shouldn't matter. while when the system time goes up, it usually doesn't
> run inside the vm, but it usually runs cached and there the
> pagecache_lock matters.

I think this problem is specific to rmap, thus for your kernel, the
priorities may be a little different. The usage pattern you describe
makes perfect sense to me, but would be a little difficult to measure
empirically - hacking lockmeter .... ;-)

Thanks,

Martin.

