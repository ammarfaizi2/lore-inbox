Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269470AbUIZBca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269470AbUIZBca (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269472AbUIZBca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:32:30 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:44515 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269470AbUIZBcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:32:08 -0400
Date: Sun, 26 Sep 2004 03:32:00 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040926013200.GT3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random> <1096155207.475.40.camel@gaston> <20040926002037.GP3309@dualathlon.random> <1096159487.18234.64.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096159487.18234.64.camel@gaston>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 10:44:48AM +1000, Benjamin Herrenschmidt wrote:
> How so ? A bunch of archs have the pte beeing a simple long, on these
> set_pte is perfectly atomic as it is... I'd say in this regard that
> x86 is the exception ;)

this is a C language issue, not a gcc issue. I know gcc does things
optimially and it will always write it atomically.

But the word "atomic" doesn't exist in C, so you cannot write C code and
expect anything to be written atomically.

The single fact you agree set_pte has to be done with a perfect
atomic-SMP operation, means you also agree it cannot be fully
implemented in C. which is the only thing I'm advocating.

> Ugh ? Writing an unsigned long with a single instruction is always
> atomic, whatever the C compiler does. If the compiler turns a single
> long aligned write into something else, then it's very broken imho

It doesn't need to be. It's always atomic with your current cpu
revision, future cpus may introduce not-SMP atomic writes and gcc would
be perfectly allowed to use those new instructions by default (though
I guess in the kernel other things would break doing that, this may not
be the only place where we do this, but it would be our problem, not a
gcc issue).

> I'm not convinced :)

I know it perfectly works in practice today, and you most certainly
don't risk anything with current gcc (I doubt nobody except a gcc hacker
keeping most of gcc in mind at once could give you a true guarantee
of correctness though, I sure can't).

> > This happens to work in practice, but it's still wrong in theory, check
> > C language. What you are assuming in the above code are semantics the C
> > language _cannot_ provide you.
> 
> Oh yes, I suppose we could imagine a compiler writing the above
> bit-by-bit, but let's stay serious on that one, there are a bunch of
> other places in the kernel that would be broken if the compiler started
> breaking up an int or long write in pieces :)

I hope not ;). Peraphs you mean readl/writel? at least those are
volatile, which means gcc will not be allowed to mess with those as much
as it can with a plain unsigned long pointer (i.e. the pte).

There's also another kind of bugs that is that we often abuse, that is
to sometime touch memory that can change from under us, without marking
the variable as volatile. That can confuse gcc, in some cases, Linus
preferred to allow that by thinking when GCC could ever get confused.
So for example if you use non-volatile variables that can change under
you in SMP, for a switch statement, your kernel can crash freely, and
it's up to you not to do that and remeber gcc can generate kernel
crashing code if you do that (switch can be implemented with an hash or
similar techniques that may generate overflows and jump into a random
location in memory if the variable can change under gcc). If you only
test them with an if you're probably safe instead (and that's what most
kernel code does, to avoid taking spinlocks in the fast paths).

This case with set_pte is a similar, and I'm ready to lose on this one
too, no problem with me, but at least I tried to do the right thing as
far as I can tell.

so I'm really fine to stick to bugs that are real like the x86 one I
just found.

> Find me a single case of a compiler not generating that correctly then.

I really hope there is none... but I don't read ppc64 asm anyways, so
you'd have to look into it yourself if you want to be sure.

> Doing an atomic instruction there would have a cost I don't want to pay.

Not really, it would be definitely zerocost at runtime, you
misunderstood if you think the asm generated wouldn't be the same. The
asm produced would be exactly the same as today, the hardware couldn't
notice the difference, only the C programmer could. I'm not talking
about locked instructions.  I'm talking about a single atomic _assembly_
instruction instead of a C line of code (which we would then depend on
the compiler to generate as atomic).

> > you misunderstood, obviously everybody is required to hold the
> > page_table_lock while writing to any pagetable.
> 
> Except in the fault path when setting accessed or dirty on a rw page...

maybe I'm biased because I'm reading x86-64 code, but where? the
software mkdirty and mkyoung seem to all be inside the page_table_lock.

> But then, I refer you to the patches that have been floating around for
> implementing page table lock-less do_page_fault(), this is what I was
> talking about.

Not sure how could I get you were talking about those floating around
patches. I still don't get any connetion with those patches and the
above discussion.

> Again, find me a single case where the compiler will generate anything 
> but an "std" instruction for the above on ppc64 and you'll get a free
> case of champagne :)

If something I can check x86-64 which has the same issue, not ppc64.

If you prefer to ignore those theoretical smp races, then I will save
this email and I'll forward it to you when it triggers in production
because gcc did something strange, and then you will send me the free
case of champagne :). I'm also waiting the other bug for the lack of
volatile variables where we access memory that can change under us to
trigger anywhere in the kernel, only after it does I will have a good
argument to convince people not to depend on subtle behaviour of gcc,
and to write C language instead and to leave the atomic guarantees to
asm statements that the C compiler isn't allowed to mess up.

Oh maybe it already triggers on Martin's machine... ;), this is another
reason why I would like to see this can of warms closed, so I don't have
to worry every time that gcc doesn't something silly that could never be
catched by the gcc regression test suite, since gcc would be still C
complaint despite the apparently silly thing (silly from the point of
view of a kernel developer at least, not necessairly silly from the
point of view of a gcc developer).

I recommend to talk to the IBM compiler guys too, not just with me, I'm
probably not the right person to advocate for not depending on subtles
of the current gcc implementation, last time it wasn't me to ask to
change the kernel to stop touching memory that can change under gcc, but
it was Honza, a gcc developer recommending me not to depend on that (but
we gave up eventually, like I will very easily giveup on this too).

> Unless you do like ppc64 and clear it first :) But I agree that if your
> architecture lets you do 64 bits atomic writes on the 32 bits arch, then
> it's definitely the better solution. But then, you don't need a special
> set_pte_atomic, just make the normal set_pte do that and be done with
> it... Or is there a perf. issue there ?

there is a perf issue, cmpxchg8b is a lot more costly than two movl and
a smp_wmb in between. We only need atomic writes (not locked writes) in
all set_pte, except ptep_establish which is the only overwriting a pte
that is already present.

so let's remove the C-language compliant corollary and let's stick to
the userspace crashing x86 bug that is a tangible pratical bug. This
fixes an smp race generating userspace mm corruption + potential
security compromise sniffing random memory with threads on x86 with PAE
with > 4G of ram.

Signed-Off-By: Andrea Arcangeli <andrea@novell.com>

Index: linux-2.5/include/asm-i386/pgtable-3level.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-i386/pgtable-3level.h,v
retrieving revision 1.20
diff -u -p -r1.20 pgtable-3level.h
--- linux-2.5/include/asm-i386/pgtable-3level.h	24 Aug 2004 18:28:07 -0000	1.20
+++ linux-2.5/include/asm-i386/pgtable-3level.h	26 Sep 2004 01:13:10 -0000
@@ -88,6 +88,13 @@ static inline pte_t ptep_get_and_clear(p
 	return res;
 }
 
+#define __HAVE_ARCH_PTEP_ESTABLISH
+#define ptep_establish(__vma, __address, __ptep, __entry)		\
+do {				  					\
+	set_pte_atomic(__ptep, __entry);				\
+	flush_tlb_page(__vma, __address);				\
+} while (0)
+
 static inline int pte_same(pte_t a, pte_t b)
 {
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
