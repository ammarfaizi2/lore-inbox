Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293148AbSCEBmk>; Mon, 4 Mar 2002 20:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293152AbSCEBma>; Mon, 4 Mar 2002 20:42:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20841 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293148AbSCEBmV>; Mon, 4 Mar 2002 20:42:21 -0500
Date: Tue, 5 Mar 2002 02:40:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305024046.Y20606@dualathlon.random>
In-Reply-To: <20020305020546.W20606@dualathlon.random> <Pine.LNX.4.44L.0203042225340.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203042225340.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 10:26:30PM -0300, Rik van Riel wrote:
> On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> > On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> > > This could be expressed as:
> > >
> > > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> > > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA
> >
> > Highmem? Let's assume you speak about "normal" and "dma" only of course.
> >
> > And that's not always the right zonelist layout. If an allocation asks for
> > ram from a certain node, like during the ram bindings, we should use the
> > current layout of the numa zonelist. If node A is the preferred, than we
> > should allocate from node A first,
> 
> You're forgetting about the fact that this NUMA box only

the example you made doesn't have highmem at all.

> has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
> HIGHMEM zones...

it has multiple zone normal and only one zone dma. I'm not forgetting
that.

> This makes the fallback pattern somewhat more complex.

it's not more complex than the current way, it's just different and it's
not strict, but it's the best one for allocations that doesn't "prefer"
memory from a certain node, but OTOH we don't have an API to define
'waek' or 'strict' allocation bheaviour so the default would better be
the 'strict' one like in oldnuma. Infact in the future we may want to
have also a way to define a "very strict" allocation, that means it
won't fallback into the other nodes at all, even if there's plenty of
memory free on them.  An API needs to be built with some bitflag
specifying the "strength" of the numa affinity required. Your layout
provides the 'weakest' approch, that is perfectly fine for some kind of
non-numa-aware allocations, just like "very strict" will be necessary
for the relocation bindings (if we cannot relocate in the right node
there's no point to relocate in another node, let's ingore complex
topologies for now :).

Andrea
