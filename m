Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWGDFV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWGDFV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWGDFV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:21:26 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:59911 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S1750838AbWGDFV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:21:26 -0400
Message-Id: <200607040516.k645GFTj014564@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
To: Jes Sorensen <jes@sgi.com>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Date: Mon,  3 Jul 2006 11:37:43 -0400 (EDT)
In-Reply-To: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 03 2006 - 11:37:43 EST,  Jes Sorensen wrote:
> Certain applications cause a lot of IPI noise due to them constantly
> doing open/close on /dev/cdrom. hald is a particularly annoying case
> of this. However since every distribution insists on shipping it, it's
> one of those that are hard to get rid of :(
> 
> Anyway, this patch reduces the IPI noise by keeping a cpumask of CPUs
> which have items in the bh lru and only flushing on the relevant
> CPUs. On systems with larger CPU counts it's quite normal that only a
> few CPUs are actively doing block IO, so spewing IPIs everywhere to
> flush this is unnecessary.
> 

Ok we are optimizing for the low but not zero traffic case ... 


> + cpu = raw_smp_processor_id();
> + /* Test first to avoid cache lines bouncing around */
> + if (!cpu_isset(cpu, lru_in_use))
> + cpu_set(cpu, lru_in_use);

Being set when local array is filled, under local locking only, but its
a set_bit and ok.


> static void invalidate_bh_lrus(void)
> {
> - on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
> + /*
> + * Need to hand down a copy of the mask or we wouldn't be run
> + * anywhere due to the original mask being cleared
> + */
> + cpumask_t mask = lru_in_use;
> + cpus_clear(lru_in_use);
> + schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
> }


But that is totally racy!

Another cpu could set its bit between the assignment to mask and
the call to cpus_clear.

Which means we end up with cpus holding a bh in their lru but no
idea which ones.

Unfornately clearing the bit in the callback means we pass the cpu
mask around twice (once to clear, and later to set as we start
freeing bhs again).

Although that is probably not much worse than scanning other cpus'
per-cpu data for NULL (and I would probably just scan 8 pointers
rather than add another per-cpu something is cached flag).


I don't like the idea of invalidate_bdev (say due to openers going
to zero) running against one device causing a buffer to be left
artificially busy on another device, causing a page to be left
around.

If you want to cut down on the cache line passing, then putting
the cpu mask in the bdev (for "I have cached a bh on this bdev
sometime") might be useful.  You could even do a bdev specific
lru kill, but then we get into the next topic.


And now for the "what is that code doing?" part of this review:

 * The LRU management algorithm is dopey-but-simple.  Sorry.

Umm.. yes.

(but time for a new subject).

milton
[sorry for the whitespace munging]
