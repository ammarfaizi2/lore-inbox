Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266059AbRGHXdw>; Sun, 8 Jul 2001 19:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbRGHXdm>; Sun, 8 Jul 2001 19:33:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25115 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266059AbRGHXdX>; Sun, 8 Jul 2001 19:33:23 -0400
Date: Mon, 9 Jul 2001 01:33:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mark Hemment <markhe@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_from_high_bh
Message-ID: <20010709013319.C20908@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107081102410.7044-100000@penguin.transmeta.com> <Pine.LNX.4.33.0107081918350.9756-100000@alloc.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107081918350.9756-100000@alloc.wat.veritas.com>; from markhe@veritas.com on Sun, Jul 08, 2001 at 07:26:01PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 07:26:01PM +0100, Mark Hemment wrote:
> On Sun, 8 Jul 2001, Linus Torvalds wrote:
> > On Sun, 8 Jul 2001 markhe@veritas.com wrote:
> > >
> > >   mm/highmem.c/copy_from_high_bh() blocks interrupts while copying "down"
> > > to a bounce buffer, for writing.
> > >   This function is only ever called from create_bounce() (which cannot
> > > be called from an interrupt context - it may block), and the kmap
> > > 'KM_BOUNCE_WRITE' is only used in copy_from_high_bh().
> >
> > If so it's not just the interrupt disable that is unnecessary, the
> > "kmap_atomic()" should also be just a plain "kmap()", I think.
> 
>   That might eat through kmap()'s virtual window too quickly.

certainly not more quickly than a flood of allocation of highmem pages
in anon mem. I don't see your point. kmap has to work just fine over
there and the __cli/__sti was obviously useless. (should be faster
because we won't need to invlpg at every bounce, but OTOH we'll flush
the whole tlb after the wrap around but as said above if flushing the
tlb too frequently is the issue we should simply improve kmap because
the flood of kmap will happen anyways in the very fast paths regardless
of the bounces)

>   I did think about adding a test to see if the page was already mapped,
> and falling back to kmap_atomic() if it isn't.  That should give the best
> of both worlds?
> 
> Mark


Andrea
