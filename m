Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSBSACN>; Mon, 18 Feb 2002 19:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289015AbSBSACE>; Mon, 18 Feb 2002 19:02:04 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:14737 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289018AbSBSABx>;
	Mon, 18 Feb 2002 19:01:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [TEST] page tables filling non-highmem
Date: Tue, 19 Feb 2002 01:06:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        rsf@us.ibm.com
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <E16cnOQ-0000LC-00@starship.berlin> <20020218141545.P7940@athlon.random>
In-Reply-To: <20020218141545.P7940@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cxnS-0000xk-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 18, 2002 02:15 pm, Andrea Arcangeli wrote:
> On Mon, Feb 18, 2002 at 01:59:42PM +0100, Daniel Phillips wrote:
> > Could you describe your page table deadlock-avoidance algorithm in more
> > detail please?
> 
> There is nothing specific with the pagetables. If the lowmem was eat by
> skb instead of ptes you'd deadlock the very same way. The kernel will
> just see lots of cache in highmem and of swap available (not to tell the
> kernel never knows how much of such cache is really freeable or how much
> of the mappings are swappable and that's the very next problem that will
> leads to the same deadlock) and it will think there's "freeable" memory
> available and it will keep looping.  That's simply plain broken. The
> only way if there's something freeable is to try to free it and if we
> fail we say "oom". You cannot say if there's something freeable by
> checking the cache size or the number of free swap pages, no-way.
> 
> If in 2.5 we want perfect accounting of freeable resources instead, fine
> with me (that would math guarantee to never fail allocations if there's
> at least one page freeable, while right now you only can calculate a
> probabilistic measure), but it has to be _perfect_, and with 2.4 there
> isn't such perfect accounting, so we definitely cannot rely on cache
> size and swap available to know if to trigger oom or not. That's totally
> broken and it will deadlock. I care about those minor theorical things
> too, I want everything calculated and under control, I hate
> approximations that can leads to deadlocks, and it pays off eventually.

You're right, we have to get serious about doing what it takes to have a
precise accounting of pinned memory.  What are we going to do, count the
number of 1->2 and 2->1 transitions on page->count?  Or should we have a
pin/unpin_page(page) api?  Or what?

-- 
Daniel
