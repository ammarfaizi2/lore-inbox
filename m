Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUHRRz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUHRRz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267389AbUHRRz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 13:55:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42843 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267375AbUHRRzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 13:55:17 -0400
Date: Wed, 18 Aug 2004 18:55:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Lameter <clameter@sgi.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, <raybry@sgi.com>, <ak@muc.de>,
       <benh@kernel.crashing.org>, <manfred@colorfullife.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for 8,32
    and    512 cpu SMP
In-Reply-To: <Pine.LNX.4.58.0408170804430.8365@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0408181807500.15027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, Christoph Lameter wrote:

> This is the second release of the page fault fastpath path. The fast path
> avoids locking during the creation of page table entries for anonymous
> memory in a threaded application running on a SMP system. The performance
> increases significantly for more than 4 threads running concurrently.

It is interesting.  I don't like it at all in its current state,
#ifdef'ed special casing for one particular path through the code,
but it does seem worth taking further.

Just handling that one anonymous case is not worth it, when we know
that the next day someone else from SGI will post a similar test
which shows the same on file pages ;)

Your ptep lock bit avoids collision with pte bits, but does it not
also need to avoid collision with pte swap entry bits?  And the
pte_file bit too, at least once it's extended to nopage areas.

I'm very suspicious of the way you just return VM_FAULT_MINOR when
you find the lock bit already set.  Yes, you can do that, but the
lock bit is held right across the alloc_page_vma, so other threads
trying to fault the same pte will be spinning back out to user and
refaulting back into kernel while they wait: we'd usually use a
waitqueue and wakeup with that kind of lock; or not hold it across,
and make it a bitspin lock.

It's a realistic case, which I guess your test program won't be trying.
Feels livelocky to me, but I may be overreacting against: it's not as
if you're changing the page_table_lock to be treated that way.

> Introducing the page_table_lock even for a short time makes performance
> drop to the level before the patch.

That's interesting, and disappointing.

The main lesson I took from your patch (I think wli was hinting at
the same) is that we ought now to question page_table_lock usage,
should be possible to cut it a lot.

I recall from exchanges with Dave McCracken 18 months ago that the
page_table_lock is _almost_ unnecessary in rmap.c, should be possible
to get avoid it there and in some other places.

We take page_table_lock when making absent present and when making
present absent: I like your observation that those are exclusive cases.

But you've found that narrowing the width of the page_table_lock
in a particular path does not help.  You sound surprised, me too.
Did you find out why that was?
 
> - One could avoid pte locking by introducing a pte_cmpxchg. cmpxchg
> seems to be supported by all ia64 and i386 cpus except the original 80386.

I do think this will be a more fruitful direction than pte locking:
just looking through the arches for spare bits puts me off pte locking.

Hugh

