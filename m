Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUGOCdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUGOCdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGOCdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:33:20 -0400
Received: from holomorphy.com ([207.189.100.168]:37537 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265545AbUGOCdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:33:07 -0400
Date: Wed, 14 Jul 2004 19:33:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715023300.GJ3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de, linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <1089857602.15336.4120.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089857602.15336.4120.camel@abyss.home>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 18:54, William Lee Irwin III wrote:
>> The only method the kernel now has to relocate userspace memory is IO.
>> When mlocked, or if anonymous when there's no swap, it's pinned.

On Wed, Jul 14, 2004 at 07:13:23PM -0700, Peter Zaitsev wrote:
> OK. So it is practically technical difficulty rather than fundamental
> reason ?   Why "move to other zone" way is not implemented ? It normally
> should be cheaper than IO ?

There is no technical difficulty, however, do notice there are other forms
of placement-restricted pagecache, i.e. blockdev pagecache, ramdisks, etc.


On Wed, 2004-07-14 at 18:54, William Lee Irwin III wrote:
>> Userspace allocations can also trigger OOM, it's merely that in this
>> case only allocations restricted to ZONE_NORMAL or below, e.g. kernel
>> allocations, are affected. Your memory pressure is restricted to one zone.

On Wed, Jul 14, 2004 at 07:13:23PM -0700, Peter Zaitsev wrote:
> Right. After being explained what without swap you have all pages pinned
> it makes sense.  On other hand  why user Allocation will trigger OOM if
> there are pages in other zone which still can be used ? Or are there any
> restriction on this ?

Allocations can be requested to come from restricted physical areas.
In this kind of situation, the OOM comes from exhaustion of a physical
area smaller than all of RAM, i.e. ZONE_NORMAL or ZONE_DMA.

The OOM decision-making is noteworthy:
        do_retry = 0;
        if (!(gfp_mask & __GFP_NORETRY)) {
                if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
                        do_retry = 1;
                if (gfp_mask & __GFP_NOFAIL)
                        do_retry = 1;
        }
        if (do_retry) {
                blk_congestion_wait(WRITE, HZ/50);
                goto rebalance;
        }

At the rebalance label, failure will only be delivered when the
check if (current->flags & (PF_MEMALLOC|PF_MEMDIE)), otherwise,
__alloc_pages() retries indefinitely and ignores signals.

Furthermore, notice the OOM killer will trip if out_of_memory() is
called more than 10 times in one second, which is plausible for a
single process to do, as it only sleeps for HZ/50 jiffies. More
interestingly, out_of_memory() is never called unless __GFP_FS is set.


On Wed, 2004-07-14 at 18:54, William Lee Irwin III wrote:
>> In order to relocate a userspace page, the kernel performs IO to write
>> the page to some backing store, then lazily faults it back in later. When
>> the userspace page lacks a backing store, e.g. anonymous pages on
>> swapless systems, Linux does not now understand how to relocate them.

On Wed, Jul 14, 2004 at 07:13:23PM -0700, Peter Zaitsev wrote:
> Can't it just be just (theoretically) moved to other zone with
> appropriate system tables modifications ? 
> Well anyway it is good to hear "pinned anonymous" is only issue on
> swapless systems.   Together with the fact what 2.6 VM does not seems to
> swap without a good reason as 2.4 one did, I perhaps can just have swap
> file enabled. 

There is no technical (or even practical) obstacle to implementing
in-core page relocation, only a social one: kernel politics. I would not
be surprised if hotplug memory patches already had code usable for this.


-- wli
