Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318311AbSGWUwe>; Tue, 23 Jul 2002 16:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSGWUwe>; Tue, 23 Jul 2002 16:52:34 -0400
Received: from [195.223.140.120] ([195.223.140.120]:50226 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318311AbSGWUwd>; Tue, 23 Jul 2002 16:52:33 -0400
Date: Tue, 23 Jul 2002 22:56:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: David F Barrera <dbarrera@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0, mode:0x0
Message-ID: <20020723205628.GM1117@dualathlon.random>
References: <OF6F39340B.FF1F1097-ON85256BFF.005C6460@pok.ibm.com> <3D3DAD54.6825F86@zip.com.au> <20020723203445.GK1117@dualathlon.random> <3D3DC0E0.EDE4CF20@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3DC0E0.EDE4CF20@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 01:47:28PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Tue, Jul 23, 2002 at 12:24:04PM -0700, Andrew Morton wrote:
> > > David F Barrera wrote:
> > > >
> > > > I have experienced the following errors while running a test suite (LTP
> > > > test suite)  on the 2.4.26 kernel.  Has anybody seen this problem, and, if
> > > > so, is there a patch for it?  Thanks.
> > > >
> > > > kernel BUG at page_alloc.c:92!
> > >
> > > Could you please replace the put_page(page) in
> > > kernel/ptrace.c:access_process_vm() with page_cache_release(page)
> > > and retest?
> > 
> > I prefer to drop page_cache_release and to have __free_pages_ok to deal
> > with the lru pages like it's been fixed in 2.4.
> 
> That would fix it too.  But a __free_pages_ok call from interrupt
> context can deadlock the box.

I guess you mean it can corrupt the lru list, not necessairly deadlock
the box. That's not the case either though, see the in_interrupt() check
in my tree in free_pages_ok, only normal context is allowed to play with
pagecache. (async-io isn't in my tree)

> 
> The removal of pages from the LRU is rather a mess.  It's getting
> better, and we can fix up some more of this if/when pagemap_lru_lock
> becomes an interrupt-safe lock.

that will allow irq to manage pagecahce but the fact it's not interrupt
safe it's really a irq latency feature, the fact disabling irqs during
the critical section decreases contention on the lock is kind of hack,
that is true for all spinlocks out there, by that argument all spinlocks
should be irq safe.

Andrea
