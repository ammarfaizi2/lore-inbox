Return-Path: <linux-kernel-owner+w=401wt.eu-S1751011AbWLLDZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWLLDZE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWLLDZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:25:04 -0500
Received: from science.horizon.com ([192.35.100.1]:17910 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751036AbWLLDZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:25:01 -0500
Date: 11 Dec 2006 22:24:56 -0500
Message-ID: <20061212032456.23036.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <457D0A6A.1090806@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> to keep the amount of code between ll and sc to an absolute minimum
>> to avoid interference which causes livelock.  Processor timeouts
>> are generally much longer than any reasonable code sequence.

> "Generally" does not mean you can just ignore it and hope the C compiler
> does the right thing. Nor is it enough for just SOME of the architectures
> to have the properties you require.

If it's an order of magnitude larger than the common case, then yes
you can.  Do we worry about writing functions so big that they
exceed branch displacement limits?

That's detected at compile time, but LL/SC pair distance is
in principle straightforward to measure, too.

> Ralf tells us that MIPS cannot execute any loads, stores, or sync
> instructions on MIPS. Ivan says no loads, stores, taken branches etc
> on Alpha.
>
> MIPS also has a limit of 2048 bytes between the ll and sc.

I agree with you about the Alpha, and that will have to be directly
coded.  But on MIPS, the R4000 manual (2nd ed, covering the R4400
as well) says

> The link is broken in the following circumstances:
>    ·   if any external request (invalidate, snoop, or intervention)
>        changes the state of the line containing the lock variable to
>        invalid
>    ·   upon completion of an ERET (return from exception)
>        instruction
>    ·   an external update to the cache line containing the lock
>        variable

Are you absolutely sure of what you are reporting about MIPS?
Have you got a source?  I've been checking the most authoritative
references I can find and can't find mention of such a restriction.
(The R8000 User's Manual doesn't appear to mention LL/SC at all, sigh.)

One thing I DID find is the "R4000MC Errata, Processor Revision 2.2 and
3.0", which documents several LL/SC bugs (Numbers 10, 12, 13) and #12
in particular requires extremely careful coding in the workaround.

That may completely scuttle the idea of using generic LL/SC functions.

> So you almost definitely cannot have gcc generated assembly between. I
> think we agree on that much.

We don't.  I think that if that restriction applies, it's worthless,
because you can't achieve a net reduction in arch-dependent code.

GCC specifically says that if you want a 100% guarantee of no reloads
between asm instructions, place them in a single asm() statement.

> In truth, however, realizing that we're only talking about three
> architectures (wo of which have 32 & 64-bit versions) it's probably not
> worth it.  If there were five, it would probably be a savings, but 3x
> code duplication of some small, well-defined primitives is a fair price
> to pay for avoiding another layer of abstraction (a.k.a. obfuscation).
> 
> And it lets you optimize them better.
> 
> I apologize for not having counted them before.

> I also disagree that the architectures don't matter. ARM and PPC are
> pretty important, and I believe Linux on MIPS is growing too.

Er... I definitely don't see where I said, and I don't even see where
I implied - or even hinted - that MIPS, ARM and PPC "don't matter."
I use Linux on ARM daily.

I just thought that writing a nearly-optimal generic primitive is about
3x harder than writing a single-architecture one, so even for primitives
yet to be written, its just as easy to do it fully arch-specific.

Plus you have corner cases like the R5900 that don't have LL/SC at all.
(Can it be used multiprocessor?)

> One proposal that I could buy is an atomic_ll/sc API, which mapped
> to a cmpxchg emulation even on those llsc architectures which had
> any sort of restriction whatsoever. This could be used in regular C
> code (eg. you indicate powerpc might be able to do this). But it may
> also help cmpxchg architectures optimise their code, because the
> load really wants to be a "load with intent to store" -- and is
> IMO the biggest suboptimal aspect of current atomic_cmpxchg.

Or, possibly, an interface like

do {
	oldvalue = ll(addr)
	newvalue = ... oldvalue ...
} while (!sc(addr, oldvalue, newvalue))

Where sc() could be a cmpxchg.  But, more importantly, if the
architecture did implement LL/SC, it could be a "try plain SC; if
that fails try CMPXCHG built out of LL/SC; if that fails, loop"

Actually, I'd want something a bit more integrated, that could
have the option of fetching the new oldvalue as part of the sc()
implementation if that failed.  Something like

	DO_ATOMIC(addr, oldvalue) {
		... code ...
	} UNTIL_ATOMIC(addr, oldvalue, newvalue);

or perhaps, to encourage short code sections,
	DO_ATOMIC(addr, oldvalue, code, newvalue);

The problem is, that's already not optimal for spinlocks, where
you want to use a non-linked load while spinning.
