Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSHBFIn>; Fri, 2 Aug 2002 01:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318167AbSHBFIn>; Fri, 2 Aug 2002 01:08:43 -0400
Received: from holomorphy.com ([66.224.33.161]:23231 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316953AbSHBFIn>;
	Fri, 2 Aug 2002 01:08:43 -0400
Date: Thu, 1 Aug 2002 22:11:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: large page patch
Message-ID: <20020802051151.GX29537@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20020801.211357.93822733.davem@redhat.com> <Pine.LNX.4.33.0208012128110.1857-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208012128110.1857-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 09:32:44PM -0700, Linus Torvalds wrote:
> I bet that is mainly because of CPU scalability, and being able to avoid
> touching the buddy lists from multiple CPU's - the same reason _we_ have
> the per-CPU front-ends on various allocators.
> I doubt it is because buddy matters past the 4MB mark. I just can't see 
> how you can avoid the naive math which says that it should be 1/512th as 
> common to coalesce to 4MB as it is to coalesce to 8kB. 
> Walking the buddy bitmaps for a few levels (ie up to order 3 or 4) is
> probably quite common, and it's likely to be bad from a SMP cache
> standpoint (touching a few bits with what must be fairly random patterns). 
> So avoiding the buddy with a simple front-end is likely to win you 
> something, without actually being meaningful at the MAX_ORDER point.

This is actually part of my strategy.

By properly organizing the deferred queues into lists of lists and
maintaining a small per-cpu cache of pages, a "cache fill" involves
doing a single list deletion under the zone->lock and the remainder
of the work to fill a pagevec occurs outside the lock, reducing the
mean hold time down to ridiculous lows. And since the allocations
are batched, the arrival rate is then divided by the batch size.
Conversely, frees are also batched and the same effect achieved with
the dual operations.

i.e. magazines for the page-level allocator

This can't be achieved with a pure buddy system, as it must examine
individual pages one-by-one to keep the bitmaps updated. Vahalia
discusses the general approach in another section, and integration with
buddy systems (and other allocators) in an exercise.


Cheers,
Bill
