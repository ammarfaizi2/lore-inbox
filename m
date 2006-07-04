Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWGDHsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWGDHsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGDHsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:48:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10896 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751120AbWGDHsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:48:14 -0400
Message-ID: <44AA1D09.7080308@sgi.com>
Date: Tue, 04 Jul 2006 09:47:21 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net> <200607040516.k645GFTj014564@sullivan.realtime.net>
In-Reply-To: <200607040516.k645GFTj014564@sullivan.realtime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller wrote:
> On Mon Jul 03 2006 - 11:37:43 EST,  Jes Sorensen wrote:
>> Anyway, this patch reduces the IPI noise by keeping a cpumask of CPUs
>> which have items in the bh lru and only flushing on the relevant
>> CPUs. On systems with larger CPU counts it's quite normal that only a
>> few CPUs are actively doing block IO, so spewing IPIs everywhere to
>> flush this is unnecessary.

> Ok we are optimizing for the low but not zero traffic case ... 

Well yes and no. $#@$#@* hald will do the open/close stupidity a
couple of times per second. On a 128 CPU system thats quite a lot of
IPI traffic, resulting in measurable noise if you run a benchmark.
Remember that the IPIs are synchronous so you have to wait for them to
hit across the system :(

>> static void invalidate_bh_lrus(void)
>> {
>> - on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
>> + /*
>> + * Need to hand down a copy of the mask or we wouldn't be run
>> + * anywhere due to the original mask being cleared
>> + */
>> + cpumask_t mask = lru_in_use;
>> + cpus_clear(lru_in_use);
>> + schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
>> }
> 
> But that is totally racy!
> 
> Another cpu could set its bit between the assignment to mask and
> the call to cpus_clear.
> 
> Which means we end up with cpus holding a bh in their lru but no
> idea which ones.

The idea I wrote the code under was that we are really only concerned to
make sure all bh's related to the device causing the invalidate are hit.
It doesn't matter that there are bh's in the lru from other devices.

> Unfornately clearing the bit in the callback means we pass the cpu
> mask around twice (once to clear, and later to set as we start
> freeing bhs again).

Doing it in the callback also means each CPU has to go back and hit the
mask remotely causing a lot of cache line ping pong effects, especially
as they'll be doing it at roughly the same time. This is why I
explicitly did the if (!test_bit) set_bit() optimization.

> Although that is probably not much worse than scanning other cpus'
> per-cpu data for NULL (and I would probably just scan 8 pointers
> rather than add another per-cpu something is cached flag).

8 pointers * NR_CPUS - that can be a lot of cachelines you have to pull
in from remote :(

> I don't like the idea of invalidate_bdev (say due to openers going
> to zero) running against one device causing a buffer to be left
> artificially busy on another device, causing a page to be left
> around.
> 
> If you want to cut down on the cache line passing, then putting
> the cpu mask in the bdev (for "I have cached a bh on this bdev
> sometime") might be useful.  You could even do a bdev specific
> lru kill, but then we get into the next topic.

That could be an interesting way out.

Cheers,
Jes

