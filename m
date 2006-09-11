Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWIKSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWIKSjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWIKSjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:39:12 -0400
Received: from outbound-mail-41.bluehost.com ([70.96.188.10]:33194 "HELO
	outbound-mail-41.bluehost.com") by vger.kernel.org with SMTP
	id S964833AbWIKSjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:39:11 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
Date: Mon, 11 Sep 2006 11:39:34 -0700
User-Agent: KMail/1.9.4
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
References: <1157947414.31071.386.camel@localhost.localdomain>
In-Reply-To: <1157947414.31071.386.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111139.35344.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 70.103.140.128 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 10, 2006 9:03 pm, Benjamin Herrenschmidt wrote:
>  1- {read,write}{b,w,l,q} : Those accessors provide all MMIO ordering
> requirements. They are thus called "fully ordered". That is #1, #2 and
> #4 for writes and #1 and #3 for reads.

Fine.

>  2- PIO accessors (all of them, that is inb...inl, ins*, out
> equivalents,...): Those are fully ordered, all ordering rules apply. They
> are slow anyways :)

Yeah, I think these are already defined to operate this way.  Not sure if that 
fact is documented clearly though (haven't checked).

>  3- memcpy_to_io, memcpy_from_io: #1 semantics apply (all MMIO loads or
> stores are performed in order to each other). #2+#4 (stores) or #3
> (loads) semantics apply to the operation as a whole. That is #2: all
> previous memory stores are globally visible before the first MMIO store
> of memcpy_to_io, #3: The last MMIO read (and thus all previous ones too
> due to rule #1) have been fully performed before a subsequent memory
> read is performed by memcpy_from_io. And #4: all MMIO stores performed
> by memcpy_to_io will have reached the host bridge before the effect of a
> subsequent spin_unlock are visible.

See Alan's comments here.  I don't think the intra-memcpy semantics have to be 
defined as strongly as you say here... it should be enough to treat the whole 
memcpy as a unit, not specifying what happens inside but rather defining it 
to be strongly ordered wrt to previous and subsequent code.

>  4- io{read,write}{8,16,32}[be]: Those have the same semantics as 1 for
> MMIO and the same semantics as 2 for PIO. As for the "repeat" versions
> of those, they follow the semantics of memcpy_to_io and memcpy_from_io
> (the only difference being the lack of increment of the MMIO address).

This reminds me... when these routines were added I asked that they be defined 
as having weak ordering wrt DMA (does linux-arch have archives?), but then I 
think Linus changed his mind?

>  1- __{read,write}{b,w,l,q} : Those accessors provide only ordering rule
> #1. That is, MMIOs are ordered vs. each other as issued by one CPU.
> Barriers are required to ensure ordering vs. memory and vs. locks (see
> "Barriers" section).

Ok, but I still don't like the naming.  __ implies some sort of implementation 
detail and doesn't communicate meaning very clearly.  But I'm not going to 
argue too much about it.

> Some of the above accessors do not provide all ordering rules define in
> * I *, thus explicit barriers are provided to enforce those ordering
> rules:
>
>  1- io_to_io_barrier() : This barrier provides ordering requirement #1
> between two MMIO accesses. It's to be used in conjuction with fully
> relaxed accessors of Class 3.

Ok, basically mb() but for I/O space.

>  2- memory_to_io_wb() : This barrier provides ordering requirement #2
> between a memory store and an MMIO store. It can be used in conjunction
> with write accessors of Class 2 and 3.
>
>  3- io_to_memory_rb(value) : This barrier provides ordering requirement
> #3 between an MMIO read and a subsequent read from memory. For
> implementation purposes on some architectures, the value actually read
> by the MMIO read shall be passed as an argument to this barrier. (This
> allows to generate the appropriate CPU instruction magic to force the
> CPU to consider the value as being "used" and thus force the read to be
> performed immediately). It can be used in conjunction with read
> accessors of Class 2 and 3

These sound fine.  I think PPC64 is the only platform that will need them?

>  4- io_to_lock_wb() : This barrier provides ordering requirement #4
> between an MMIO store and a subsequent spin_unlock(). It can be used in
> conjunction with write accessors of Class 2 and 3.

Ok.

> [Note] A barrier commonly used by drivers and not described here are the
> memory-to-memory read and write barriers (rmb, wmb, mb). Those are
> necessary when manipulating data structures in memory that are accessed
> at the same time via DMA. The rules here are identical to the usual SMP
> data ordering rules and are beyond the scope of this document.

Unless as Alan suggests these barriers are also documented in 
memory-barriers.txt (probably a good place).

> [* Question 1] Should Rule #4 be generalized to MMIO store followed by a
> memory store ? (as spin_unlock are essentially a wmb followed by a
> memory store) or do we need to keep a rule specific for locks to avoid
> arch specific pitfalls on some architecture ? In that case, do we need a
> specific barrier to provide MMIO store followed by a memory store ? That
> sort of ordering is not generally useful and is generally expensive as
> it requires to access the PCI host bridge to enforce that the previous
> MMIO stores have reached the bus. Drivers generally don't need such a
> rule or a barrier, as they have to deal with write posting anyway, and
> thus use an MMIO read to provide the necessary synchronisation when it
> makes sense.

But isn't this how you'll implement io_to_lock_wb() on PPC anyway?  If so, 
might be best to name it and document it that way (though keeping the idea of 
barriering before unlocking prominent in the documentation).

> [* Question 2] : Do we actually want the "ordered" accessors to also
> provide ordering rule #4 in the general case ?

Isn't that the whole point of making the regular readX/writeX strongly 
ordered?  To get rid of the need for mmiowb() in the general case and make it 
into a performance optimization to be used in conjunction with __writeX?

> If we decide to not enforce rule #4 for ordered accessors, and thus
> require the barrier before spin_unlock, the above trick, could still be
> implemented as a debug option to "detect" the lack of appropriate
> barriers.

I think this should be done in any case, and I think it can be done in generic 
code (using per-cpu counters in the spinlock and mmiowb() routines); it's a 
good idea.

> [* Question 3] If we decide that accessors of Class 1 do not provide rule
> #4, then this barrier is to be used for all classes of accessors, except
> maybe PIO which should always be fully ordered.

Right, though see above about my understanding of the genesis of this 
discussion. :)

> [* Question 4] Would it be a useful optimisation on archs like ia64 to
> require this accessor to take the struct device of the device as an
> argument (with can NULL for a "generic" barrier) or it doesn't matter ?

For ia64 in particular it doesn't matter, though there was speculation several 
years that it might be necessary.  No actual examples stepped forward though, 
so the current implementation doesn't take an argument.

> [* Question 5] Should we document the rules for memory-memory barriers
> here as well ? (and give examples, like live updating of a network
> driver ring descriptor entry)

Should probably be added to memory-barriers.txt.

Thanks,
Jesse
