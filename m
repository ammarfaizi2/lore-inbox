Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVCaX4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVCaX4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVCaXzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:55:44 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:3734 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262074AbVCaXfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:35:54 -0500
Message-ID: <424C8956.7070108@yahoo.com.au>
Date: Fri, 01 Apr 2005 09:35:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Linus Torvalds'" <torvalds@osdl.org>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
In-Reply-To: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Linus Torvalds wrote on Thursday, March 31, 2005 12:09 PM
> 
>>Btw, I realize that you can't give good oprofiles for the user-mode
>>components, but a kernel profile with even just single "time spent in user
>>mode" datapoint would be good, since a kernel scheduling problem might
>>just make caches work worse, and so the biggest negative might be visible
>>in the amount of time we spend in user mode due to more cache misses..
> 
> 
> I was going to bring it up in another thread.  Since you brought it up, I
> will ride it along.
> 
> The low point in 2.6.11 could very well be the change in the scheduler.
> It does too many load balancing in the wake up path and possibly made a
> lot of unwise decision.

OK, and considering you have got no idle time at all, and the 2.6.11
kernel included some scheduler changes to make balancing much more
aggressive, so unfortunately that's likely to have caused the latest drop.

> For example, in try_to_wake_up(), it will try
> SD_WAKE_AFFINE for task that is not hot.  By not hot, it looks at when it
> was last ran and compare to a constant sd->cache_hot_time.

The other problem with using that value there is that it represents a hard
cutoff point in behaviour. For example, on a workload that really wants to
have wakers and wakees together, it will work poorly on low loads, but when
things get loaded up enough that we start seeing cache cold tasks there,
behaviour suddenly changes.

In the -mm kernels, there are a large number of scheduler changes that
reduce the amount of balancing. They also remove cache_hot_time from this
path (though it is still useful for periodic balancing).

 > The problem
 > is this cache_hot_time is fixed for the entire universe, whether it is a
 > little celeron processor with 128KB of cache or a sever class Itanium2
 > processor with 9MB L3 cache.  This one size fit all isn't really working
 > at all.

Ingo had a cool patch to estimate dirty => dirty cacheline transfer latency
for all processors with respect to all others, and dynamically tune
cache_hot_time. Unfortunately it was never completely polished, and it is
an O(cpus^2) operation. It is a good idea to look into though.


> We had experimented that parameter earlier and found it was one of the major
> source of low point in 2.6.8.  I debated the issue on LKML about 4 month
> ago and finally everyone agreed to make that parameter a boot time param.
> The change made into bk tree for 2.6.9 release, but somehow it got ripped
> right out 2 days after it went in.  I suspect 2.6.11 is a replay of 2.6.8
> for the regression in the scheduler.  We are running experiment to confirm
> this theory.
> 
> That actually brings up more thoughts: what about all other sched parameters?
> We found values other than the default helps to push performance up, but it
> is probably not acceptable to pick a default number from a db benchmark.
> Kernel needs either a dynamic closed feedback loop to adapt to the workload
> or some runtime tunables to control them.  Though the latter option did not
> go anywhere in the past.
> 

They're in -mm. I think Andrew would rather see things (like auto tuning
cache hot time) rather than putting more runtime variables in.

If you were to make a program which adjusted various parameters using a
feedback loop, then that would be a good argument to put runtime tunables
in.

Oh, one last thing - if you do a great deal of scheduler tuning, it would
be very good if you could possibly use the patchset in -mm. Things have
changed sufficiently that optimal values you find in 2.6 will not be the
same as those in -mm. I realise this may be difficult to justify, but I
would hate for the whole cycle to have to happen again when the patches
go into 2.6.

