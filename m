Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUIZAUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUIZAUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUIZAUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:20:52 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:46227 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269079AbUIZAUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:20:46 -0400
Date: Sun, 26 Sep 2004 02:20:37 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040926002037.GP3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random> <1096155207.475.40.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096155207.475.40.camel@gaston>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 09:33:27AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2004-09-26 at 01:54, Andrea Arcangeli wrote:
> 
> > Worthy to note is that we're buggy in all set_pte implementations since,
> > all archs would need to also implement the set_pte in assembler to make
> > sure the C language doesn't write it byte-by-byte which would break the
> > SMP in the other thread. On ppc64 where a problem triggered (possibily
> > unrelated to this) the pte is an unsigned long and it's being updated by
> > set_pte with this:
> 
> Bye by byte ? Ahem ... That would be a really broken C compiler ;) I

that would be an overoptimized or underoptimized C compiler, sure not a
really broken one. The C compiler is perfectly allowed to do that, check
the specs or ask your C compiler friends to get confirmation.

anyways on x86 the bug is real in practice, regardless of the C
compiler, heck we even put a smp_wmb() in between the two writes. The
fact all other archs are buggy in theory too is just a corollary. I
thought it worth to fix the theoretical bug in all other archs too,
instead of keeping playing russian roulette.

> don't see how it could be broken on archs where the PTE size is a single
> long for example, ppc64 is not. ppc32 is already atomic for different
> reasons

of course in practice it's expectedly working correctly for all archs,
except x86 where there is a smp_wmb() in between, and even if x86 was
using an unsigned long, the C compiler would still not be writing it
atomically.

> > 	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS
> 
> This is not broken, how can somebody else race on modifying this

It is broken as far as C language is concerned. You're just hoping to
have an efficient compiler under you, and you're hoping to have an
architecture where doing a single write is more efficient.

This happens to work in practice, but it's still wrong in theory, check
C language. What you are assuming in the above code are semantics the C
language _cannot_ provide you.

the C language has no knowledge of the "somebody else", the C language
thinks it's single threaded and it can do whatever it wants as far as it
writes that data to that place eventually.

> That isn't the case of the pte_clear call issued by set_pte itself on
> ppc64. I haven't looked at othe cases in the generic code, but I
> suppose they indeed use get_and_clear instead.

generic code should really use get_and_clear for that. pte_clear in
common code can only be called on non present ptes. Again, ppc64 would
be ok in practice (still not in theory), but x86 would break even in
practice (not only in theory) if you use pte_clear on a present pte.

But even ppc64 is wrong as far as C is concerned, your  = 0 can be
implemented in 8 byte writes, and the C compiler would be right, and you
would be wrong. You never know if they could ever choose to do a memset
instead of an atomic write, or whatever new assembler instruction in
future implementations of the cpu.

I perfectly know it works fine in practice and that the only definitive
bug is in the x86 arch, but this is a theoretical bug for _all_ archs.

> > so we don't race with other threads, it's
> > only set_pte that should always be written in assembler in the last
> > opcode that writes in the pte)
> 
> Why ? I mean, why _always_ ? The above is perfectly correct on ppc64

it's not correct even on ppc64.

> 
> > We don't need an SMP lock, we only need to write 4 or 8 bytes at once (a
> > plain movl in x86 would do the trick). That's all we need. 
> 
> No, we need the page table lock on ppc64 because we must make sure the

you misunderstood, obviously everybody is required to hold the
page_table_lock while writing to any pagetable.

What I meant with lock above, was the "lock prefix to the movl"
instruction, not the lock as in page_table_lock.

The write to the pte doesn't need to be executed with an atomic opcode,
a movl would work, it doesn't need to be a "lock movl", because thanks
to the page_table_lock, there's only one writer, and all readers are in
userspace racing with us (hence the need for an assembler write, the
only thing that can provide an atomicity guarantee, C can't, check the
language specifications). It works by luck, now if it crashed you could
still blamed the compiler for being suboptimal, but you definitely
cannot blame the compiler for being wrong. The only wrong thing is your
implementation of set_pte that you keep advocating, not the compiler.

> I don't understand your point... PTE's are usually the native long size
> of the arch and usually set_pte is a single aligned store, which mean
> it's pretty much always "atomic"...

same question all over, already answered why C cannot provide any atomic
operation many times above. And you even seem to partially agree that it's
buggy when you say "pretty much always", instead of a plain "always" ;).

> If I understand your explanation, all you need is make sure that x86
> set_pte sets the HW present bit last when writing the 2 halves, no ?

x86 already does that. But that's not enough. It must be a
set_pte_atomic, writing all 8 bytes at once. Because the pte is already
established, so the first write of the first halve will make any racing
thread load into the tlb a mapping to a wrong random page in the system.
This is a security compromise (note: seccomp not involved as usual,
since I obviously disallow clone on bytecode running under seccomp mode).

If every other kernel guy agrees with you to keep depending on semantics
the C language cannot provide us, I can live with that (in such case I'm
only going to fix x86 and x86-64 respective set_pte in asm and I will
save this email if in the future a MM corruption bug triggers due subtle
compiler behaviour ;).

returning to the pratical bug (ignoring the thoeretical bug) we will
have to at least move the ptep_enstablish modified as I posted (with
set_pte_atomic instead of set_pte) from asm-generic to asm-i386.  That
will fix the security issue I found on x86 PAE with >4G of ram.
