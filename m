Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSCPSeF>; Sat, 16 Mar 2002 13:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291745AbSCPSdz>; Sat, 16 Mar 2002 13:33:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40966 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291625AbSCPSdu>; Sat, 16 Mar 2002 13:33:50 -0500
Date: Sat, 16 Mar 2002 10:32:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <15507.9919.92453.811733@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0203161020230.31850-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, Paul Mackerras wrote:
> 
> Your suggestion has the problem that when you get to needing to reuse
> one of the VSIDs that you have thrown away, it becomes very difficult
> and expensive to ensure that there aren't any stale hash table entries
> left around for that VSID - particularly on a system with logical
> partitioning where we don't control the size of the hash table.

But the VSID is something like 20 bits, no? So the re-use is a fairly 
uncommon thing, in the end.

Remember: think about the hashes as just TLB's, and the VSID's are just 
address space identifiers (yeah, yeah, you can have several VSID's per 
process at least in 32-bit mode, I don't remember the 64-bit thing). So 
what you do is the same thing alpha does with it's 6-bit ASN thing: when 
you wrap around, you blast the whole TLB to kingdom come.

The alpha wraps around a lot more often with just 6 bits, but on the other 
hand it's a lot cheaper to get rid of the TLB too, so it evens out.

Yeah, there are latency issues, but that can be handled by just switching
the hash table base: you have two hash tables, and whenever you increment
the VSID you clear a small part of the other table, designed so that when
the VSID wraps around the other table is 100% clear, and you just switch
the two.

You _can_ switch the hash table base around on ppc64, can't you?

So now the VM invalidate becomes

	++vsid;
	partial_clear_secondary_hash();
	if (++vsid > MAXVSID)
		vsid = 0;
		switch_hashes();
	}

> > just bypass it altogether (at least the 604e used to be able to just
> > disable the stupid hashing altogether and make the whole thing much
> > saner). 
> 
> That was the 603, actually.

Ahh, my mind is going.

>			  In fact the newest G4 processors also let
> you do this.  When I get hold of a machine with one of these new G4
> chips I'm going to try it again and see how much faster it goes
> without the hash table.

Maybe somebody is seeing the light.

> One other thing - I would *love* it if we could get rid of
> flush_tlb_all and replace it with a flush_tlb_kernel_range, so that
> _all_ of the flush_tlb_* functions tell us what address(es) we need to
> invalidate, and let the architecture code decide whether a complete
> TLB flush is justified.

Sure, sounds reasonable.

		Linus

