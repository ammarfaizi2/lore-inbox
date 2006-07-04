Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWGDImt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWGDImt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGDImt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:42:49 -0400
Received: from mercury.realtime.net ([205.238.132.86]:48021 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S932118AbWGDIms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:42:48 -0400
In-Reply-To: <44AA1D09.7080308@sgi.com>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net> <200607040516.k645GFTj014564@sullivan.realtime.net> <44AA1D09.7080308@sgi.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dcbd59443f05c17a3b290f1c2bf6336a@bga.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
Date: Tue, 4 Jul 2006 03:42:36 -0500
To: Jes Sorensen <jes@sgi.com>
X-Mailer: Apple Mail (2.624)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 4, 2006, at 2:47 AM, Jes Sorensen wrote:

> Milton Miller wrote:
>> On Mon Jul 03 2006 - 11:37:43 EST,  Jes Sorensen wrote:
>>
>> But that is totally racy!
>>
>> Another cpu could set its bit between the assignment to mask and
>> the call to cpus_clear.
>>
>> Which means we end up with cpus holding a bh in their lru but no
>> idea which ones.
>
> The idea I wrote the code under was that we are really only concerned 
> to
> make sure all bh's related to the device causing the invalidate are 
> hit.
> It doesn't matter that there are bh's in the lru from other devices.
>

And that is fine as far as it goes.  The problem is that an unrelated
device might be be hit by this operation.  For example, hal is running 
on cpu 0, so the fsck gets run on cpu 1 and hits this race.   It 
finishes, and now hal is back to sleep, and cpu power saving balancing 
says run the mount on cpu 0.  The file system tries to change the block 
size, which calls kill_bdev which calls invalidate_bdev, but we forgot 
that cpu 1 had a bh, so the bh doesn't free, and the page is left in 
the page cache with the wrong size buffer.  POOOF there goes the 
filesystem.

Oh, and there isn't any safety check there, is there?


>> Unfortunately clearing the bit in the callback means we pass the cpu
>> mask around twice (once to clear, and later to set as we start
>> freeing bhs again).
>
> Doing it in the callback also means each CPU has to go back and hit the
> mask remotely causing a lot of cache line ping pong effects, especially
> as they'll be doing it at roughly the same time. This is why I
> explicitly did the if (!test_bit) set_bit() optimization.
>
>> Although that is probably not much worse than scanning other cpus'
>> per-cpu data for NULL (and I would probably just scan 8 pointers
>> rather than add another per-cpu something is cached flag).
>
> 8 pointers * NR_CPUS - that can be a lot of cachelines you have to pull
> in from remote :(

8 pointers in one array, hmm...  8*8 = 64 consecutive bytes, that is 
half a cache line in my arch.  (And on 32 bit archs, 8*4 = 32 bytes, 
typically 1 full cache line).  Add an alignment constraint if you like. 
  I was comparing to fetching a per-cpu variable saying we had any 
entries; I'd say the difference is the time to do 8 loads once you have 
the line vs the chance the other cpu is actively storing and stealing 
it back before you finish.  I'd be really surprised if it was stolen 
twice.

>> I don't like the idea of invalidate_bdev (say due to openers going
>> to zero) running against one device causing a buffer to be left
>> artificially busy on another device, causing a page to be left
>> around.
>>
>> If you want to cut down on the cache line passing, then putting
>> the cpu mask in the bdev (for "I have cached a bh on this bdev
>> sometime") might be useful.  You could even do a bdev specific
>> lru kill, but then we get into the next topic.
>
> That could be an interesting way out.
>

Another approach is to age the cache. Only clear the bit during the IPI 
call if you had nothing there on the last N calls (N being some 
combination of absolute time and number of invalidate calls).

milton

