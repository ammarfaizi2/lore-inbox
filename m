Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbRGJFno>; Tue, 10 Jul 2001 01:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265577AbRGJFnf>; Tue, 10 Jul 2001 01:43:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38768 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265571AbRGJFnU>; Tue, 10 Jul 2001 01:43:20 -0400
Date: Tue, 10 Jul 2001 07:43:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.7-pre hurts...
Message-ID: <20010710074315.N1594@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107092053130.10187-100000@penguin.transmeta.com> <Pine.LNX.4.33.0107092112180.10220-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107092112180.10220-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jul 09, 2001 at 09:20:23PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 09:20:23PM -0700, Linus Torvalds wrote:
> In contrast, the version in pre4 doesn't depend on any memory ordering
> between BH_Locked at all - it really only depends on a memory barrier
> before the final atomic_dec() that releases the buffer, as it ends up
> being sufficient for try_to_free_buffers() to just worry about the buffer
> count when it comes to IO completion. The b_flags BUSY bits don't matter
> wrt the IO completion at all - they end up being used only for "idle"
> buffers (which in turn are totally synchronized by the LRU and hash
> spinlocks, so that is the "obviously correct" case)
> 
> I personally think it's a hard thing to depend on memory ordering,

Sometime memory ordering pays off by avoiding locks, but this isn't the
case ;).

> especially if there are two independent fields. Which is why I really
> don't think that the pre4 fix is "overkill".

It certainly isn't overkill in respect of doing get_bh in an implicitly
sychronized points where we submit the I/O (that was my second argument
and that was plain wrong).

My first arguments about "overkill" were for async I/O and kiobufs, where
the race cannot trigger. Mainly for the kiobufs I/O I'm still not very
convinced.

> Oh, it does really need a
> 
> 	smp_mb_before_atomic_dec();
> 
> as part of the "put_bh()". On x86, this obviously is a no-op. And we
> actually need that one in general - not just for IO completion - as long
> as we consider the "atomic_dec(&bh->b_flags)" to "release" the buffer.
> 
> Andrea?

yes, agreed.

Andrea
