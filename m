Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUHRUVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUHRUVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUHRUUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:20:51 -0400
Received: from holomorphy.com ([207.189.100.168]:64952 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267591AbUHRUUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:20:41 -0400
Date: Wed, 18 Aug 2004 13:20:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Lameter <clameter@sgi.com>, "David S. Miller" <davem@redhat.com>,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for 8,32 and    512 cpu SMP
Message-ID: <20040818202018.GC11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>,
	Christoph Lameter <clameter@sgi.com>,
	"David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
	benh@kernel.crashing.org, manfred@colorfullife.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408170804430.8365@schroedinger.engr.sgi.com> <Pine.LNX.4.44.0408181807500.15027-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408181807500.15027-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 06:55:07PM +0100, Hugh Dickins wrote:
> It is interesting.  I don't like it at all in its current state,
> #ifdef'ed special casing for one particular path through the code,
> but it does seem worth taking further.
> Just handling that one anonymous case is not worth it, when we know
> that the next day someone else from SGI will post a similar test
> which shows the same on file pages ;)
> Your ptep lock bit avoids collision with pte bits, but does it not
> also need to avoid collision with pte swap entry bits?  And the
> pte_file bit too, at least once it's extended to nopage areas.
> I'm very suspicious of the way you just return VM_FAULT_MINOR when
> you find the lock bit already set.  Yes, you can do that, but the
> lock bit is held right across the alloc_page_vma, so other threads
> trying to fault the same pte will be spinning back out to user and
> refaulting back into kernel while they wait: we'd usually use a
> waitqueue and wakeup with that kind of lock; or not hold it across,
> and make it a bitspin lock.
> It's a realistic case, which I guess your test program won't be trying.
> Feels livelocky to me, but I may be overreacting against: it's not as
> if you're changing the page_table_lock to be treated that way.

Both points are valid; it should retry in-kernel for the pte lock bit
and arrange to use a bit not used for swap (there are at least
PAGE_SHIFT of these on all 64-bit arches).


On Tue, 17 Aug 2004, Christoph Lameter wrote:
>> Introducing the page_table_lock even for a short time makes performance
>> drop to the level before the patch.

On Wed, Aug 18, 2004 at 06:55:07PM +0100, Hugh Dickins wrote:
> That's interesting, and disappointing.
> The main lesson I took from your patch (I think wli was hinting at
> the same) is that we ought now to question page_table_lock usage,
> should be possible to cut it a lot.
> I recall from exchanges with Dave McCracken 18 months ago that the
> page_table_lock is _almost_ unnecessary in rmap.c, should be possible
> to get avoid it there and in some other places.
> We take page_table_lock when making absent present and when making
> present absent: I like your observation that those are exclusive cases.
> But you've found that narrowing the width of the page_table_lock
> in a particular path does not help.  You sound surprised, me too.
> Did you find out why that was?

It also protects against vma tree modifications in mainline, but rmap.c
shouldn't need it for vmas anymore, as the vma is rooted to the spot by
mapping->i_shared_lock for file pages and anon_vma->lock for anonymous.


On Tue, 17 Aug 2004, Christoph Lameter wrote:
>> - One could avoid pte locking by introducing a pte_cmpxchg. cmpxchg
>> seems to be supported by all ia64 and i386 cpus except the original 80386.

On Wed, Aug 18, 2004 at 06:55:07PM +0100, Hugh Dickins wrote:
> I do think this will be a more fruitful direction than pte locking:
> just looking through the arches for spare bits puts me off pte locking.

Fortunately, spare bits aren't strictly necessary, and neither is
cmpxchg. A single invalid value can serve in place of a bitflag. When
using such an invalid value, just xchg()'ing it and looping when the
invalid value is seen should suffice. This holds more generally for all
radix trees, not just pagetables, and happily xchg() or emulation
thereof is required by core code for all arches.


-- wli
