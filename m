Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271616AbRHPS5V>; Thu, 16 Aug 2001 14:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271621AbRHPS5N>; Thu, 16 Aug 2001 14:57:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30474 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271616AbRHPS5E>; Thu, 16 Aug 2001 14:57:04 -0400
Date: Thu, 16 Aug 2001 20:57:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mark Hemment <markhe@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Align VM locks
Message-ID: <20010816205706.D8726@athlon.random>
In-Reply-To: <20010816202606.B8726@athlon.random> <Pine.LNX.4.33.0108161933240.3340-100000@alloc.wat.veritas.com> <20010816205224.C8726@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816205224.C8726@athlon.random>; from andrea@suse.de on Thu, Aug 16, 2001 at 08:52:24PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 08:52:24PM +0200, Andrea Arcangeli wrote:
> On Thu, Aug 16, 2001 at 07:44:04PM +0100, Mark Hemment wrote:
> >   At least on the work load I'm interest in, SpecFS v2.0 over NFSv3,
> > removing the KM_BOUNCE_WRITE results in a performance drop (confirmed
> > today).
> >
> >   It is often the case that when it comes time to write a page out it has
> > lost any mapping it had when it was made dirty via a write(), so there is
> > no side benefit of using a straight kmap().
> > 
> >   By having KM_BOUNCE_WRITE we don't run through the "normal" mapping
> > space on I/O.  Not having KM_BOUNCE_WRITE causing extra shootdowns, which
> > _are_ expensive, as the code needs to busy-wait for all the other engines
> > (while the kmap_lock held - and on a 4-way there is a good chance one of
> > the processors is running with interrupts disabled).
> >   KM_BOUNCE_WRITE may waste virtual address-space, but it saves on
> > expensive shootdowns.
> 
> I would never save addresss-space for performance of course, it's just
> that it is unused in my tree so it doesn't make sense to left it.
> 
> I believe the slowdown is more a sign that kmap is not fast enoguh, not
> that you really need the BOUNCE_WRITE. I'd suggest to try to invlpg at
> kmap time entry-per-entry and to skip the global tlb flush during the
> wrap around as first thing and mark the kmap entries global (since it is
> safe with the invlpg) and see if it changes something. If kmap hurts on
> the I/O path it means it hurts on the pagecache read/writes etc... too,
> so lefting KM_BOUNCE_WRITE looks more hiding the performance hit instead
> of fixing it.

btw, the invlpg thing is easy to do only in UP... (in smp we cannot send
an IPI at every kmap of course). What happens if you only increase the
kmap pool?

Andrea
