Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWGDJAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWGDJAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWGDJAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:00:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46486 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750830AbWGDJAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:00:07 -0400
Message-ID: <44AA2DFA.6060107@sgi.com>
Date: Tue, 04 Jul 2006 10:59:38 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net> <200607040516.k645GFTj014564@sullivan.realtime.net> <44AA1D09.7080308@sgi.com> <dcbd59443f05c17a3b290f1c2bf6336a@bga.com>
In-Reply-To: <dcbd59443f05c17a3b290f1c2bf6336a@bga.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller wrote:
> On Jul 4, 2006, at 2:47 AM, Jes Sorensen wrote:
>> The idea I wrote the code under was that we are really only concerned to
>> make sure all bh's related to the device causing the invalidate are hit.
>> It doesn't matter that there are bh's in the lru from other devices.
> 
> And that is fine as far as it goes.  The problem is that an unrelated
> device might be be hit by this operation.  For example, hal is running
> on cpu 0, so the fsck gets run on cpu 1 and hits this race.   It
> finishes, and now hal is back to sleep, and cpu power saving balancing
> says run the mount on cpu 0.  The file system tries to change the block
> size, which calls kill_bdev which calls invalidate_bdev, but we forgot
> that cpu 1 had a bh, so the bh doesn't free, and the page is left in the
> page cache with the wrong size buffer.  POOOF there goes the filesystem.

Hrmpf, maybe it's back to putting the mask into the bdev then.

>> 8 pointers * NR_CPUS - that can be a lot of cachelines you have to pull
>> in from remote :(
> 
> 8 pointers in one array, hmm...  8*8 = 64 consecutive bytes, that is
> half a cache line in my arch.  (And on 32 bit archs, 8*4 = 32 bytes,
> typically 1 full cache line).  Add an alignment constraint if you like.
>  I was comparing to fetching a per-cpu variable saying we had any
> entries; I'd say the difference is the time to do 8 loads once you have
> the line vs the chance the other cpu is actively storing and stealing it
> back before you finish.  I'd be really surprised if it was stolen twice.

The problem is that if you throw the IPI onto multiple CPUs they will
all try and hit this array at the same time. Besides, on some platforms
this would be 64 * 8 * 8 (or even bigger) - scalability quickly goes
out the window, especially as it's to be fetched from another node :( I
know these are the extreme in today's world, but it's becoming more of
an issue with all the multi-core stuff we're going to see.

>>> If you want to cut down on the cache line passing, then putting
>>> the cpu mask in the bdev (for "I have cached a bh on this bdev
>>> sometime") might be useful.  You could even do a bdev specific
>>> lru kill, but then we get into the next topic.
>>
>> That could be an interesting way out.
> 
> Another approach is to age the cache. Only clear the bit during the IPI
> call if you had nothing there on the last N calls (N being some
> combination of absolute time and number of invalidate calls).

I guess if there's nothing in the LRU you don't get the call and the
number of cross node clears are limited, but it seems to get worse
exponentially with the size of the machine, especially if it's busy
doing IO, which is what worries me :(

Next, I'll look for my asbestos suit and take a peak at the hald source.

Cheers,
Jes
