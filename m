Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUIZArn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUIZArn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUIZArm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:47:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:18307 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269464AbUIZAp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:45:59 -0400
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all
	set_pte must be written in asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926002037.GP3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random>
	 <1096155207.475.40.camel@gaston>  <20040926002037.GP3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096159487.18234.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 10:44:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 10:20, Andrea Arcangeli wrote:

> that would be an overoptimized or underoptimized C compiler, sure not a
> really broken one. The C compiler is perfectly allowed to do that, check
> the specs or ask your C compiler friends to get confirmation.
> 
> anyways on x86 the bug is real in practice, regardless of the C
> compiler, heck we even put a smp_wmb() in between the two writes. The
> fact all other archs are buggy in theory too is just a corollary. I
> thought it worth to fix the theoretical bug in all other archs too,
> instead of keeping playing russian roulette.

How so ? A bunch of archs have the pte beeing a simple long, on these
set_pte is perfectly atomic as it is... I'd say in this regard that
x86 is the exception ;)

> > don't see how it could be broken on archs where the PTE size is a single
> > long for example, ppc64 is not. ppc32 is already atomic for different
> > reasons
> 
> of course in practice it's expectedly working correctly for all archs,
> except x86 where there is a smp_wmb() in between, and even if x86 was
> using an unsigned long, the C compiler would still not be writing it
> atomically.

Ugh ? Writing an unsigned long with a single instruction is always
atomic, whatever the C compiler does. If the compiler turns a single
long aligned write into something else, then it's very broken imho

> > > 	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS
> > 
> > This is not broken, how can somebody else race on modifying this
> 
> It is broken as far as C language is concerned. You're just hoping to
> have an efficient compiler under you, and you're hoping to have an
> architecture where doing a single write is more efficient.

I'm not convinced :)

> This happens to work in practice, but it's still wrong in theory, check
> C language. What you are assuming in the above code are semantics the C
> language _cannot_ provide you.

Oh yes, I suppose we could imagine a compiler writing the above
bit-by-bit, but let's stay serious on that one, there are a bunch of
other places in the kernel that would be broken if the compiler started
breaking up an int or long write in pieces :)
 
> the C language has no knowledge of the "somebody else", the C language
> thinks it's single threaded and it can do whatever it wants as far as it
> writes that data to that place eventually.

And ? The above example is clearly a read/modify/write case, all the
compiler might ever do is move the last write around, but it can't
move it before the if () since there's a clear data dependency and
the flush done in there has an implicit barrier, so all that can happen
is the write to the PTE to happen a bit later ... I don't see where
is the issue here.

> > That isn't the case of the pte_clear call issued by set_pte itself on
> > ppc64. I haven't looked at othe cases in the generic code, but I
> > suppose they indeed use get_and_clear instead.
> 
> generic code should really use get_and_clear for that. pte_clear in
> common code can only be called on non present ptes. Again, ppc64 would
> be ok in practice (still not in theory), but x86 would break even in
> practice (not only in theory) if you use pte_clear on a present pte.
> 
> But even ppc64 is wrong as far as C is concerned, your  = 0 can be
> implemented in 8 byte writes, and the C compiler would be right, and you
> would be wrong. 

And I would change to another compiler. Any compiler trafficking a
write of an aligned native sized type like that is good for the
trashcan.

> You never know if they could ever choose to do a memset
> instead of an atomic write, or whatever new assembler instruction in
> future implementations of the cpu.
> 
> I perfectly know it works fine in practice and that the only definitive
> bug is in the x86 arch, but this is a theoretical bug for _all_ archs.
> 
> > > so we don't race with other threads, it's
> > > only set_pte that should always be written in assembler in the last
> > > opcode that writes in the pte)
> > 
> > Why ? I mean, why _always_ ? The above is perfectly correct on ppc64
> 
> it's not correct even on ppc64.

Find me a single case of a compiler not generating that correctly then.
Doing an atomic instruction there would have a cost I don't want to pay.

> > > We don't need an SMP lock, we only need to write 4 or 8 bytes at once (a
> > > plain movl in x86 would do the trick). That's all we need. 
> > 
> > No, we need the page table lock on ppc64 because we must make sure the
> 
> you misunderstood, obviously everybody is required to hold the
> page_table_lock while writing to any pagetable.

Except in the fault path when setting accessed or dirty on a rw page...

But then, I refer you to the patches that have been floating around for
implementing page table lock-less do_page_fault(), this is what I was
talking about.

> What I meant with lock above, was the "lock prefix to the movl"
> instruction, not the lock as in page_table_lock.

I understood what you were saying

> The write to the pte doesn't need to be executed with an atomic opcode,
> a movl would work, it doesn't need to be a "lock movl", because thanks
> to the page_table_lock, there's only one writer, and all readers are in
> userspace racing with us (hence the need for an assembler write, the
> only thing that can provide an atomicity guarantee, C can't, check the
> language specifications). It works by luck, now if it crashed you could
> still blamed the compiler for being suboptimal, but you definitely
> cannot blame the compiler for being wrong. The only wrong thing is your
> implementation of set_pte that you keep advocating, not the compiler.

Again, find me a single case where the compiler will generate anything 
but an "std" instruction for the above on ppc64 and you'll get a free
case of champagne :)

> > I don't understand your point... PTE's are usually the native long size
> > of the arch and usually set_pte is a single aligned store, which mean
> > it's pretty much always "atomic"...
> 
> same question all over, already answered why C cannot provide any atomic
> operation many times above. And you even seem to partially agree that it's
> buggy when you say "pretty much always", instead of a plain "always" ;).
> 
> > If I understand your explanation, all you need is make sure that x86
> > set_pte sets the HW present bit last when writing the 2 halves, no ?
> 
> x86 already does that. But that's not enough. It must be a
> set_pte_atomic, writing all 8 bytes at once. Because the pte is already
> established, so the first write of the first halve will make any racing
> thread load into the tlb a mapping to a wrong random page in the system.

Unless you do like ppc64 and clear it first :) But I agree that if your
architecture lets you do 64 bits atomic writes on the 32 bits arch, then
it's definitely the better solution. But then, you don't need a special
set_pte_atomic, just make the normal set_pte do that and be done with
it... Or is there a perf. issue there ?

> This is a security compromise (note: seccomp not involved as usual,
> since I obviously disallow clone on bytecode running under seccomp mode).
> 
> If every other kernel guy agrees with you to keep depending on semantics
> the C language cannot provide us, I can live with that (in such case I'm
> only going to fix x86 and x86-64 respective set_pte in asm and I will
> save this email if in the future a MM corruption bug triggers due subtle
> compiler behaviour ;).
> 
> returning to the pratical bug (ignoring the thoeretical bug) we will
> have to at least move the ptep_enstablish modified as I posted (with
> set_pte_atomic instead of set_pte) from asm-generic to asm-i386.  That
> will fix the security issue I found on x86 PAE with >4G of ram.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

