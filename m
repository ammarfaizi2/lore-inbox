Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSCRTjY>; Mon, 18 Mar 2002 14:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSCRTjP>; Mon, 18 Mar 2002 14:39:15 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:14340 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S292554AbSCRTjA>;
	Mon, 18 Mar 2002 14:39:00 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 12:37:22 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020318123722.B4155@host110.fsmlabs.com>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020316061535.GA16653@krispykreme> <a6uubq$uqr$1@penguin.transmeta.com> <15507.9919.92453.811733@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fact we _did_ do the second part.  Rather, I did anyway.  The zombie
reclaim code (used to live in idle.c before it was removed) would run much
like the zero-paged code I put in there.  It ran with the cache off to
avoid blowing the entire contents of the L1/L2 in the idle task.  It would
just invalidate (genuinely clearing the valid bit) for any hash table entry
that was stale (zombie was the term I used).

That method was a definite win in UP but didn't help terribly well for SMP
since once a processor bogs down it no longer gets the advantage of the
easy to find empty slot in the hash replacement code.

At this point, I think it would be worth throwing out the tlb invalidate
optimization (by changing VSID's) and benchmarking that against the code
with the optimization.  A test a year ago that I did showed that they were
pretty much even.  I'm betting the latest changes have made that
optimization an actual loss now.

Linus, shrinking that hash table was a very very bad thing.  Early on we
used a very small hash table and it really put too much pressure on the
entries and we were throwing them out nearly constantly.  Adding some code
to scatter the entries and use the table more efficient helped but a large
has table is a need, unfortunately.

The ultimate solution was actually not using the hash table on the 603's
that I added a few years ago.  I documented how doing this actually
improved performance in a OSDI paper from '99 that I have on my web page.
Linux, It's worth a look - it actually supports most of your opinions of
the PPC MMU.
 
} > I wonder if you wouldn't be better off just getting rid of the TLB range
} > flush altogether, and instead making it select a new VSID in the segment
} > register, and just forgetting about the old TLB contents entirely.
} > 
} > Then, when you do a TLB miss, you just re-use any hash table entries
} > that have a stale VSID.
} 
} We used to do something a bit like that on ppc32 - flush_tlb_mm would
} just assign a new mmu context number to the task, which translates
} into a new set of VSIDs.  We didn't do the second part, reusing hash
} table entries with stale VSIDs, because we couldn't see a good fast
} way to tell whether a given VSID was stale.  Instead, when the hash
} bucket filled up, we just picked an entry to overwrite semi-randomly.
} 
} It turned out that the stale VSIDs were causing us various problems,
} particularly on SMP, so I tried a solution that always cleared all the
} hash table entries, using a bit in the linux pte to say whether there
} was (or had ever been) a hash table entry corresponding to that pte as
} an optimization to avoid doing unnecessary hash lookups.  To my
} surprise, that turned out to be faster, so that's what we do now.
} 
} Your suggestion has the problem that when you get to needing to reuse
} one of the VSIDs that you have thrown away, it becomes very difficult
} and expensive to ensure that there aren't any stale hash table entries
} left around for that VSID - particularly on a system with logical
} partitioning where we don't control the size of the hash table.  And
} there is a finite number of VSIDs so you have to reuse them sooner or
} later.
} 
} [For those not familiar with the PPC MMU, think of the VSID as an MMU
} context number, but separately settable for each 256MB of the virtual
} address space.]
} 
} > It would also be interesting to hear if you can just make the hash table
} > smaller (I forget the details of 64-bit ppc VM horrors, thank God!) or
} 
} On ppc32 we use a hash table 1/4 of the recommended size and it works
} fine.
} 
} > just bypass it altogether (at least the 604e used to be able to just
} > disable the stupid hashing altogether and make the whole thing much
} > saner). 
} 
} That was the 603, actually.  In fact the newest G4 processors also let
} you do this.  When I get hold of a machine with one of these new G4
} chips I'm going to try it again and see how much faster it goes
} without the hash table.
} 
} One other thing - I would *love* it if we could get rid of
} flush_tlb_all and replace it with a flush_tlb_kernel_range, so that
} _all_ of the flush_tlb_* functions tell us what address(es) we need to
} invalidate, and let the architecture code decide whether a complete
} TLB flush is justified.
} 
} Paul.
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
