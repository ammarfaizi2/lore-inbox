Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283675AbRLOUVP>; Sat, 15 Dec 2001 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284019AbRLOUVG>; Sat, 15 Dec 2001 15:21:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38273 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283675AbRLOUUy>;
	Sat, 15 Dec 2001 15:20:54 -0500
Date: Sat, 15 Dec 2001 23:18:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
In-Reply-To: <20011215134711.A30548@redhat.com>
Message-ID: <Pine.LNX.4.33.0112152235340.26748-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Dec 2001, Benjamin LaHaise wrote:

> [...] The design for reservations is to use enforced accounting limits
> to achive the effect of seperate memory pools. [...]

how is this going to handle higher-order pools? How is this going to
handle the need for composite allocations?

I think putting in reservation for higher-order pages is going to make
some parts of page_alloc.c *really* complex, and this complexity i dont
think we need.

> [...] Mempool's design is to build seperate pools on top of existing
> pools of memory. Can't you see the obvious duplication that implies?

no. Mempool's design is to build preallocated, reserved,
guaranteed-allocation pools on top of simpler allocators. Simpler
allocators will try reasonably hard to get something allocated, but might
fail as well. The majority of allocations within the kernel has no
deadlock relevance at all. If we allocate a new file structure, or create
a new socket, or are trying to page in overcommitted memory then we can
return with -ENOMEM (or OOM) just fine. Allocators are simpler and faster
without built-in deadlock avoidance and 'reserves'.

so the difference in design is that you are trying to add reservations as
a feature of the allocators themselves, while i'm trying to add it as a
generic, allocator-independent subsystem, which also solved a number of
other problems we always had in the IO code. Under this design, the 'pure'
allocators themselves have no concept of reserved pools at all, so there
is no duplication in concepts. (and no duplication of code.)

so the fundamental question is, should reservation be a core functionality
of allocators, or should it be a separate subsystem. *If* it can be put
into the core allocators (page allocator, SLAB) that gives us all the
features that mempool gives us today then i think i'd like that approach.
But i cannot really see how the composite allocation thing can be done via
reservations.

	Ingo

