Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316484AbSEUBly>; Mon, 20 May 2002 21:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316486AbSEUBlx>; Mon, 20 May 2002 21:41:53 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29968 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316484AbSEUBlw>; Mon, 20 May 2002 21:41:52 -0400
Date: Tue, 21 May 2002 03:40:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug with shared memory.
Message-ID: <20020521014018.GP21806@dualathlon.random>
In-Reply-To: <20020520141523.GB21806@dualathlon.random> <Pine.LNX.4.44L.0205201618110.24352-100000@imladris.surriel.com> <20020520234622.GL21806@dualathlon.random> <262840000.1021940064@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 05:14:24PM -0700, Martin J. Bligh wrote:
> > For the memclass_related_bhs() fix in -aa, that's in the testing TODO
> > list of Martin (on the multi giga machines), he also nicely proposed to
> > compare it to the other throw-away-all-bh-regardless patch from Andrew
> > (that I actually didn't seen floating around yet but it's clear how it
> > works, it's a subset of memclass_related_bhs). However the right way to
> > test the memclass_related_bhs vs throw-away-all-bh, is to run a rewrite
> > test that fits in cache, so write,fsync,write,fsync,write,fsync. specweb
> > or any other read-only test will obviously perform exactly the same both
> > ways (actually theoretically a bit cpu-faster in throw-away-all-bh
> > because it doesn't check the bh list).
> 
> The only thing that worries me in theory about your approach for this
> Andrea is fragmentation - if we try to shrink only when we're low on
> memory, isn't there a danger that one buffer_head per page of slab
> cache will be in use, and thus no pages are freeable (obviously this
> is extreme, but I can certainly see a situation with lots of partially used
> pages)? 

well, then you should be worried first for the whole /proc/slabinfo, not
just the bh heahders :) if it's a problem for the bh, it's a problem for
everything else.

The reason fragmentation is never a problem is that as far as the
persistent slab objects can be reclaimed dynamically by the vm we will
always be able to free all the slab pages, the only downside we run into
vs being aware of the slab fragmentation, is that we risk to reclaim
more objects than necessary at the layer above the slab cache (so at the
bh layer), but dropping more bh than necessary will never be a problem
(Andrew wants to drop them all indeed).

> With Andrew's approach, keeping things freed as we go, we should
> reuse the partially allocated slab pages, which would seem (to me)
> to result in less fragmentation?

less fragmentation because of zero bh allocated from slab cache :).

Andrea
