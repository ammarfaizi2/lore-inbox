Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310252AbSCPLIt>; Sat, 16 Mar 2002 06:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310249AbSCPLIj>; Sat, 16 Mar 2002 06:08:39 -0500
Received: from mail.bstc.net ([63.90.24.2]:59151 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S310248AbSCPLIb>;
	Sat, 16 Mar 2002 06:08:31 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.9919.92453.811733@argo.ozlabs.ibm.com>
Date: Sat, 16 Mar 2002 22:04:31 +1100 (EST)
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
In-Reply-To: <a6uubq$uqr$1@penguin.transmeta.com>
In-Reply-To: <20020313085217.GA11658@krispykreme>
	<20020316061535.GA16653@krispykreme>
	<a6uubq$uqr$1@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I wonder if you wouldn't be better off just getting rid of the TLB range
> flush altogether, and instead making it select a new VSID in the segment
> register, and just forgetting about the old TLB contents entirely.
> 
> Then, when you do a TLB miss, you just re-use any hash table entries
> that have a stale VSID.

We used to do something a bit like that on ppc32 - flush_tlb_mm would
just assign a new mmu context number to the task, which translates
into a new set of VSIDs.  We didn't do the second part, reusing hash
table entries with stale VSIDs, because we couldn't see a good fast
way to tell whether a given VSID was stale.  Instead, when the hash
bucket filled up, we just picked an entry to overwrite semi-randomly.

It turned out that the stale VSIDs were causing us various problems,
particularly on SMP, so I tried a solution that always cleared all the
hash table entries, using a bit in the linux pte to say whether there
was (or had ever been) a hash table entry corresponding to that pte as
an optimization to avoid doing unnecessary hash lookups.  To my
surprise, that turned out to be faster, so that's what we do now.

Your suggestion has the problem that when you get to needing to reuse
one of the VSIDs that you have thrown away, it becomes very difficult
and expensive to ensure that there aren't any stale hash table entries
left around for that VSID - particularly on a system with logical
partitioning where we don't control the size of the hash table.  And
there is a finite number of VSIDs so you have to reuse them sooner or
later.

[For those not familiar with the PPC MMU, think of the VSID as an MMU
context number, but separately settable for each 256MB of the virtual
address space.]

> It would also be interesting to hear if you can just make the hash table
> smaller (I forget the details of 64-bit ppc VM horrors, thank God!) or

On ppc32 we use a hash table 1/4 of the recommended size and it works
fine.

> just bypass it altogether (at least the 604e used to be able to just
> disable the stupid hashing altogether and make the whole thing much
> saner). 

That was the 603, actually.  In fact the newest G4 processors also let
you do this.  When I get hold of a machine with one of these new G4
chips I'm going to try it again and see how much faster it goes
without the hash table.

One other thing - I would *love* it if we could get rid of
flush_tlb_all and replace it with a flush_tlb_kernel_range, so that
_all_ of the flush_tlb_* functions tell us what address(es) we need to
invalidate, and let the architecture code decide whether a complete
TLB flush is justified.

Paul.
