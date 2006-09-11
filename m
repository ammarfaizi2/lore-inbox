Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWIKVqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWIKVqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIKVqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:46:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:33715 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964879AbWIKVqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:46:31 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <200609111139.35344.jbarnes@virtuousgeek.org>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <200609111139.35344.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 07:45:29 +1000
Message-Id: <1158011129.3879.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  2- memory_to_io_wb() : This barrier provides ordering requirement #2
> > between a memory store and an MMIO store. It can be used in conjunction
> > with write accessors of Class 2 and 3.
> >
> >  3- io_to_memory_rb(value) : This barrier provides ordering requirement
> > #3 between an MMIO read and a subsequent read from memory. For
> > implementation purposes on some architectures, the value actually read
> > by the MMIO read shall be passed as an argument to this barrier. (This
> > allows to generate the appropriate CPU instruction magic to force the
> > CPU to consider the value as being "used" and thus force the read to be
> > performed immediately). It can be used in conjunction with read
> > accessors of Class 2 and 3
> 
> These sound fine.  I think PPC64 is the only platform that will need them?

Ah ? What about the comment in e1000 saying that it needs a wmb()
between descriptor updates in memory and the mmio to kick them ? That
would typically be a memory_to_io_wb(). Or are your MMIOs ordered cs.
your cacheable stores ?

> >  4- io_to_lock_wb() : This barrier provides ordering requirement #4
> > between an MMIO store and a subsequent spin_unlock(). It can be used in
> > conjunction with write accessors of Class 2 and 3.
> 
> Ok.
> 
> > [Note] A barrier commonly used by drivers and not described here are the
> > memory-to-memory read and write barriers (rmb, wmb, mb). Those are
> > necessary when manipulating data structures in memory that are accessed
> > at the same time via DMA. The rules here are identical to the usual SMP
> > data ordering rules and are beyond the scope of this document.
> 
> Unless as Alan suggests these barriers are also documented in 
> memory-barriers.txt (probably a good place).

They are, but I was thinking about providing more IO-like examples. I
suppose I could refer to memory-barriers.txt from here and update it
with IO-like examples.
 
> > [* Question 1] Should Rule #4 be generalized to MMIO store followed by a
> > memory store ? (as spin_unlock are essentially a wmb followed by a
> > memory store) or do we need to keep a rule specific for locks to avoid
> > arch specific pitfalls on some architecture ? In that case, do we need a
> > specific barrier to provide MMIO store followed by a memory store ? That
> > sort of ordering is not generally useful and is generally expensive as
> > it requires to access the PCI host bridge to enforce that the previous
> > MMIO stores have reached the bus. Drivers generally don't need such a
> > rule or a barrier, as they have to deal with write posting anyway, and
> > thus use an MMIO read to provide the necessary synchronisation when it
> > makes sense.
> 
> But isn't this how you'll implement io_to_lock_wb() on PPC anyway?  If so, 
> might be best to name it and document it that way (though keeping the idea of 
> barriering before unlocking prominent in the documentation).

Well, the whole question is what does the linux semantics guarantee to
driver writers (accross archs), not what PowerPC implements :) I'd
rather not add guarantees that aren't useful to drivers even if all
current implementations happen to provide them. I'm trying to find a
case where ordering MMIO W + memory W is useful and I can't see any
since the MMIO W will take any time to go to the device anyway. The lock
rule seems to be the only useful, thus the only I think I'll guarantee.

> > [* Question 2] : Do we actually want the "ordered" accessors to also
> > provide ordering rule #4 in the general case ?
> 
> Isn't that the whole point of making the regular readX/writeX strongly 
> ordered?  To get rid of the need for mmiowb() in the general case and make it 
> into a performance optimization to be used in conjunction with __writeX?

Well, as far as I'm concerned, the whole point is rule #2 and #3 :)
Those are the ones biting us on PowerPC (we haven't seen the lock
problem but then it can't happen the way our current accessors are
written. However, if we change our accessors to provide rule #2 more
specifically, we'll end up with 2 sync instructions in writel, one for
rule #2 before the store and one for rule #4, thus we go from expensive
to very expensive). It's also my understanding that mmiowb is very
expensive on ia64 and gets worse as the box grows bigger.

Hence the question: do we provide -fully- ordered accessors in class 1,
or do we provide -mostly- ordered accessors, ordered in all means except
rule #4 vs locks. ia64 is afaik by far the platform taking the biggest
hit if you have to provide #4, so I'm interesting in your point of view
here.

> > If we decide to not enforce rule #4 for ordered accessors, and thus
> > require the barrier before spin_unlock, the above trick, could still be
> > implemented as a debug option to "detect" the lack of appropriate
> > barriers.
> 
> I think this should be done in any case, and I think it can be done in generic 
> code (using per-cpu counters in the spinlock and mmiowb() routines); it's a 
> good idea.

We don't need counters, just a flag. We did a test implementation, seems
to work. We also clear the flag in spin_lock. That means that MMIOs
issued before a lock aren't ordered vs. the locked section. But because
of rule #1, they should be ordered vs. other MMIOs inside the locked
section and thus implicitely get ordered anyway.

> > [* Question 3] If we decide that accessors of Class 1 do not provide rule
> > #4, then this barrier is to be used for all classes of accessors, except
> > maybe PIO which should always be fully ordered.
> 
> Right, though see above about my understanding of the genesis of this 
> discussion. :)

As far as I'm concerned, genesis of this discussion is rules #2 and #3,
not #4 :) Though the later quickly came in of course.

> > [* Question 4] Would it be a useful optimisation on archs like ia64 to
> > require this accessor to take the struct device of the device as an
> > argument (with can NULL for a "generic" barrier) or it doesn't matter ?
> 
> For ia64 in particular it doesn't matter, though there was speculation several 
> years that it might be necessary.  No actual examples stepped forward though, 
> so the current implementation doesn't take an argument.

Ok. My question is wether it would improve the implementation to take
it. If we define a new macro with a new name, we can do it....

> > [* Question 5] Should we document the rules for memory-memory barriers
> > here as well ? (and give examples, like live updating of a network
> > driver ring descriptor entry)
> 
> Should probably be added to memory-barriers.txt.

Yup, agreed.

Cheers,
Ben.


