Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRDQUew>; Tue, 17 Apr 2001 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132619AbRDQUem>; Tue, 17 Apr 2001 16:34:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20302 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132643AbRDQUef>; Tue, 17 Apr 2001 16:34:35 -0400
Date: Tue, 17 Apr 2001 22:49:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010417224933.E31982@athlon.random>
In-Reply-To: <01041720185700.01003@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041720185700.01003@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Tue, Apr 17, 2001 at 08:18:57PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 08:18:57PM +0100, D . W . Howells wrote:
> Andrea,
> 
> > As said the design of the framework to plugin per-arch rwsem implementation 
> > isn't flexible enough and the generic spinlocks are as well broken, try to 
> > use them if you can (yes I tried that for the alpha, it was just a mess and 
> > it was more productive to rewrite than to fix).
> 
> Having thought about the matter a bit, I know what the problem is:
> 
> As stated in the email with the latest patch, I haven't yet extended this to 
> cover any architecture but i386. That patch was actually put up for comments, 
> though it got included anyway.
> 
> Therefore, all other archs use the old (and probably) broken implementations!

I am sure ppc couldn't race (at least unless up_read/up_write were excuted
from irq/softnet context and that never happens in 2.4.4pre3, see below ;).

> I'll quickly knock up a patch to fix the other archs. This should also fix 
> the alpha problem.

This is not the point. The point is that we want a generic implementation in C
always available as a fallback and my one is IMHO better to what is in
2.4.4pre3, and secondly it has a superior API to replace the generic
implementation with a per-arch implementation. So the only thing left to do is
to plugin your x86 specific implementation in my patch using the simple API I
provide to override the generic implementation completly and I preferred if you
could do that at least for the 386/486 case (you know your code better). If
you're not interested I probably end ingoring the <586 compiles by implementing
only the atomic_*_return with xadd for >=586 and a CONFIG_RWSEM_ATOMIC_RETURN
config option in the common code so I will optimize almost all archs in one go
as I think that's the way to go and so I prefer to invest time in such direction
only.

> As for making the stuff I had done less generic, and more specific, I only 
> made it more generic because I got asked to by a number of people. It was 
> suggested that I move the contention functions into lib/rwsem.c and make them 
> common.

And the generic part was implemented bad and that's why I rewrote it to boot
my alpha.

> As far as using atomic_add_return() goes, the C compiler cannot make the 
> fastpath anywhere near as efficient, because amongst other things, I can make 
> use of the condition flags set in EFLAGS and the compiler can't.

All we need to do is to avoid the spinlock until we enter the fast path.  We
only need the fast path to be a few asm inlined opcodes that jumps out of line
if there's contention. I don't think other optimizations are interesting.

That can obviously be done for example with C code like this:

	count = atomic_inc_return(&sem->count);
	if (__builtin_expect(count == 0, 0))
		slow_path()

The above is the perfect C implementation IMHO, but it cannot be
the most generic one because [34]86 doesn't have xadd and they
cannot implement atomic_*_return and friends.

And incidentally the above is what (I guess Richard) did on the alpha and that
should really go into common code instead of having asm-i386/rwsem-xadd.h
asm-alpha/rwsem.h etcc.etc...  just implement atomic_inc_return using xadd in
asm-i386/atomic.h, that's much better design IMHO.

> > And it's also more readable and it's not bloated code, 65+110 lines
> > compared to 156+148+174 lines. 
> 
> You do my code an injustice there... I've put comments in mine.

Put it this way: my one is readable enough that I don't need to add comments ;).
More serously I may be biased in the readability point, but if I read
lib/rwsem.c and include/linux/rwsem*.h before applying the patch and after
applying the patch I have no dobut on what I want to run on my computer (I'm
not talking about asm-i386/rwsem*.h of course).  You are of course free to keep
your one if you prefer it but I don't see technical arguments for that
decision.

BTW, Andrew Morton is been so kind to audit my code and he noticed my patch was
not allowing up_read/up_write to be called from irqs because I forgotten an
_irq in the down_write (thanks Andrew!). I didn't catched during regression
testing because nobody in the whole 2.4.4pre3 kernel is running either up_read
or up_write from irq/softirq context, so it cannot destabilize the runtime but
nevertheless that was a leftover also shared by the ppc port code in 2.4.3. So
if you just started the alpha regression testing on the -1 revision go head and
don't stop because you are reading this.  just for Linus I released a -2 new
version of the patch but again upgrade is not necessary for production (at
least unless you use drivers outside the kernel tree that could release rwsem
from irq/softirq context).

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre3/rwsem-generic-2

I didn't exported rwsem.c if CONFIG_RWSEM_GENERIC is set to n as suggested
by Christoph yet because the old code couldn't be buggy and it's not obvious to
me that the other way around is correct (Christoph are you sure we can export an
object file that is not even compiled/generated? If answer is yes the export
mechanism must be smart enough to discard that file if not present but I'm not
sure if that's the case ;)

thanks for your comments.

Andrea
