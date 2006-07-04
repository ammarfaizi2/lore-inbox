Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGDJa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGDJa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGDJaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:30:55 -0400
Received: from mercury.realtime.net ([205.238.132.86]:12449 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S1751252AbWGDJaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:30:55 -0400
In-Reply-To: <44AA2DFA.6060107@sgi.com>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net> <200607040516.k645GFTj014564@sullivan.realtime.net> <44AA1D09.7080308@sgi.com> <dcbd59443f05c17a3b290f1c2bf6336a@bga.com> <44AA2DFA.6060107@sgi.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4b7f0f8d246b77fce1c3572efbcaf334@bga.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
Date: Tue, 4 Jul 2006 04:30:39 -0500
To: Jes Sorensen <jes@sgi.com>
X-Mailer: Apple Mail (2.624)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 4, 2006, at 3:59 AM, Jes Sorensen wrote:

> Milton Miller wrote:
>> On Jul 4, 2006, at 2:47 AM, Jes Sorensen wrote:
>>> The idea I wrote the code under was that we are really only 
>>> concerned to
>>> make sure all bh's related to the device causing the invalidate are 
>>> hit.
>>> It doesn't matter that there are bh's in the lru from other devices.
>>
>> And that is fine as far as it goes.  The problem is that an unrelated
>> device might be be hit by this operation.
... [ fs POOF scenerio ]
> Hrmpf, maybe it's back to putting the mask into the bdev then.
>
>>> 8 pointers * NR_CPUS - that can be a lot of cachelines you have to 
>>> pull
>>> in from remote :(
>>
>> 8 pointers in one array, hmm...  8*8 = 64 consecutive bytes, that is
>> half a cache line in my arch.  (And on 32 bit archs, 8*4 = 32 bytes,
>> typically 1 full cache line).  Add an alignment constraint if you 
>> like.
>>  I was comparing to fetching a per-cpu variable saying we had any
>> entries; I'd say the difference is the time to do 8 loads once you 
>> have
>> the line vs the chance the other cpu is actively storing and stealing 
>> it
>> back before you finish.  I'd be really surprised if it was stolen 
>> twice.
>
> The problem is that if you throw the IPI onto multiple CPUs they will
> all try and hit this array at the same time. Besides, on some platforms
> this would be 64 * 8 * 8 (or even bigger) - scalability quickly goes
> out the window, especially as it's to be fetched from another node :( I
> know these are the extreme in today's world, but it's becoming more of
> an issue with all the multi-core stuff we're going to see.


Huh?  The cpus have their own local array, you scan the remote to see 
if you need to wake that guy up.  Sort of like need_reseched/polling 
flags.  Ok, they all have to pull it back from shared with the caller 
to exclusive/modified at once.  Of course they had to do that with 
whatever you method you used to tell them what to do also.

The trade off is bouncing one line with the mask of who might have 
something relevant in a bit vector (two bounces if you clear always, 
shared if you do it lazy) vs pulling a line per cpu when you need to 
check, that will be actively pulled back every bh lookup.

Maybe you shouldn't push the work until some time expires.  Just let 
wait a bit for the eventd to kick in first.   After all, you would just 
be slowing down the thread trying to invalidate a dead device.

>>>> If you want to cut down on the cache line passing, then putting
>>>> the cpu mask in the bdev (for "I have cached a bh on this bdev
>>>> sometime") might be useful.  You could even do a bdev specific
>>>> lru kill, but then we get into the next topic.
>>>
>>> That could be an interesting way out.
>>
>> Another approach is to age the cache. Only clear the bit during the 
>> IPI
>> call if you had nothing there on the last N calls (N being some
>> combination of absolute time and number of invalidate calls).
>
> I guess if there's nothing in the LRU you don't get the call and the
> number of cross node clears are limited, but it seems to get worse
> exponentially with the size of the machine, especially if it's busy
> doing IO, which is what worries me :(
>

If you are doing that much bh based IO then you will have to issue
the IPI, even with the cpu mask.  Unless you go the per-bdev cpu_mask.

> Next, I'll look for my asbestos suit and take a peak at the hald 
> source.

* miltonm stands well back

later,
milton

