Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289836AbSA2Uue>; Tue, 29 Jan 2002 15:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSA2UuY>; Tue, 29 Jan 2002 15:50:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289877AbSA2UuN>; Tue, 29 Jan 2002 15:50:13 -0500
Date: Tue, 29 Jan 2002 12:49:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <20020129123932.K899@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0201291240180.1223-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, William Lee Irwin III wrote:
>
> In my mind it's not about the form but about how much of it is exposed.
> For instance, exposing the number of levels seems to require emulating
> an extra level for machines with 2-level pagetables.

Well, you have two choices:

 - _not_ exposing fundamental details like the number of levels causes
   different architectures to have wildly different code (see how UNIX
   traditionally does MM, and puke)

 - trivial "folding" macros to take 3 levels down to 2 (or four levels
   down to 3 or two).

Note that the folding macros really _are_ trivial. The pmd macros for x86
are basically these few lines:

	static inline int pgd_none(pgd_t pgd)           { return 0; }
	static inline int pgd_bad(pgd_t pgd)            { return 0; }
	static inline int pgd_present(pgd_t pgd)        { return 1; }
	#define pgd_clear(xp)                           do { } while (0)

	static inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
	{
	        return (pmd_t *) dir;
	}

And that's it.

So I'd much rather have a generic VM and do some trivial folding.

> It's quite a happy coincidence when this happens, and in my mind making
> it happen more often would be quite nice.

I really isn't a co-incidence. The reason so many architectures have page
table trees is that most architects try to make good decisions, and a tree
layout is a simple and efficient data structure that maps well to both
hardware and to usage patterns.

Hashed page tables are incredibly naive, and perform badly for build-up
and tear-down (and mostly have horrible cache access patterns). At least
in some version of the UltraSparc, the Linux tree-based software TLB fill
outperformed the Solaris version, even though the Solaris version was
handtuned assembly and used hardware acceleration for the hash
computations. That should tell you something.

			Linus

