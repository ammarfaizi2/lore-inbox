Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWIKEEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWIKEEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 00:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWIKEEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 00:04:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:25252 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750856AbWIKEEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 00:04:08 -0400
Subject: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 14:03:33 +1000
Message-Id: <1157947414.31071.386.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here's a formal documentation of the proposed accessor semantics. It
still contains a couple of questions (see [* Question]) that need
answering before we can start implementing anything, so I'm waiting for
feedback here. The Questions are grouped at the end of the document to
avoid cluttering it.

I've on purpose not included Segher proposal of having the
"writel/readl" type accessors behave differently based on an ioremap
flag. There are pros and cons to this approach, but this is almost a
separate debate as we shall first define the semantics we need and
that's what that document attempt to do.


*** Definitions of MMIO accessors and IO related barriers semantics ***


* I * Ordering requirements:
============================

First, let's define 4 types of ordering requirements that can be
provided by MMIO accessors:

 1- MMIO + MMIO: This type of ordering means that two consecutive MMIO
accesses performed by one processors are issued in program order on the
bus. Reads can't cross writes. Writes can't be re-oredered vs. each
other. There is no implication on MMIOs issued by different CPUs nor
non-MMIO accesses.

 2- memory W + MMIO W: This type of ordering means that an store to main
memory that is performed in program order before an MMIO store to a
device, must be visible to that device before the MMIO store reaches it.
For example: updating of a DMA descriptor in memory is visible to the
chip before the MMIO write that cause that chip to go fetch it. This is
purely a store ordering, there is no assumption made about reads

 3- MMIO R + memory R: This type of ordering means that an MMIO read will
be effectively performed (the result returned by the device to the
processor) before a following read for memory. That is, the value
returned by that following read is what was present in the coherency
domain after the MMIO read is complete. For example: reading a DMA
"pointer" from a device with an MMIO read, and then fetching the data in
memory up to that pointer.

 4- MMIO W + spin_unlock: This type of ordering means that MMIO stores
followed by a spin unlock will have all reached the host PCI bridge
before the unlocking is visible to other CPUs. For example, two CPUs
have a locked section (same spinlock) issuing some MMIO stores to the
same device. Such ordering means that both sets of MMIO stores will not
be interleaved when reaching the host PCI controller (and thus the
device). All MMIO stores from one locked section will be performed
before all MMIO stores from the other.

[Note] Rule #4 is strictly specific to MMIO stores followed by a
spin_unlock(). There is no ordering requirement provided by Linux to
ensure ordering of an MMIO store followed by a generic memory store
unless an explicit barrier is used:

[ -> Question 1]

* II * Accessors:
=================

We provide 3 classes of accessors:

Class 1: Ordered accessors
--------------------------

[Note] None of these accessors will provide write combining

 1- {read,write}{b,w,l,q} : Those accessors provide all MMIO ordering
requirements. They are thus called "fully ordered". That is #1, #2 and
#4 for writes and #1 and #3 for reads. 

[ -> Question 2]

 2- PIO accessors (all of them, that is inb...inl, ins*, out
equivalents,...): Those are fully ordered, all ordering rules apply. They
are slow anyways :)

 3- memcpy_to_io, memcpy_from_io: #1 semantics apply (all MMIO loads or
stores are performed in order to each other). #2+#4 (stores) or #3
(loads) semantics apply to the operation as a whole. That is #2: all
previous memory stores are globally visible before the first MMIO store
of memcpy_to_io, #3: The last MMIO read (and thus all previous ones too
due to rule #1) have been fully performed before a subsequent memory
read is performed by memcpy_from_io. And #4: all MMIO stores performed
by memcpy_to_io will have reached the host bridge before the effect of a
subsequent spin_unlock are visible.

 4- io{read,write}{8,16,32}[be]: Those have the same semantics as 1 for
MMIO and the same semantics as 2 for PIO. As for the "repeat" versions
of those, they follow the semantics of memcpy_to_io and memcpy_from_io
(the only difference being the lack of increment of the MMIO address).

Class 2: Partially relaxed accessors
------------------------------------

[Note] Stores using those accessors will provide write combining on MMIO
(not PIO) which have been mapped with the appropriate <insert call name
here, TBD. possible ioremap_wc>

 1- __{read,write}{b,w,l,q} : Those accessors provide only ordering rule
#1. That is, MMIOs are ordered vs. each other as issued by one CPU.
Barriers are required to ensure ordering vs. memory and vs. locks (see
"Barriers" section). 

 2- __io{read,write}{8,16,32}[be] (optional ?) : Those have the same
semantic as 1 for MMIO, and provide full ordering requirements as
defined in Classe 1 for PIO.

 3- __memcpy_to_io, __memcpy_from_io. Those provide only requirement #1,
that is the MMIOs within the copy are performed in order and are in
order vs. preceeding and subsequent MMIOs executed on the same CPU.

Class 3: Fully relaxed accessors
--------------------------------

[Note] Stores using those accessors will provide write combining the
same way as Class 2 accessors.
 
 1- __raw_{read,write}{b,w,l,q} : Those accessors provide no ordering
rule whatsoever. They also provide no endian swapping. They are
essentially the equivalent of a direct load/store instruction to/from
the MMIO space. Access is done in platform native endian.


* III * IO related barriers
===========================

Some of the above accessors do not provide all ordering rules define in
* I *, thus explicit barriers are provided to enforce those ordering
rules:

 1- io_to_io_barrier() : This barrier provides ordering requirement #1
between two MMIO accesses. It's to be used in conjuction with fully
relaxed accessors of Class 3.

 2- memory_to_io_wb() : This barrier provides ordering requirement #2
between a memory store and an MMIO store. It can be used in conjunction
with write accessors of Class 2 and 3.

 3- io_to_memory_rb(value) : This barrier provides ordering requirement
#3 between an MMIO read and a subsequent read from memory. For
implementation purposes on some architectures, the value actually read
by the MMIO read shall be passed as an argument to this barrier. (This
allows to generate the appropriate CPU instruction magic to force the
CPU to consider the value as being "used" and thus force the read to be
performed immediately). It can be used in conjunction with read
accessors of Class 2 and 3

 4- io_to_lock_wb() : This barrier provides ordering requirement #4
between an MMIO store and a subsequent spin_unlock(). It can be used in
conjunction with write accessors of Class 2 and 3.

[ -> Question 3]
[ -> Question 4]

[Note] A barrier commonly used by drivers and not described here are the
memory-to-memory read and write barriers (rmb, wmb, mb). Those are
necessary when manipulating data structures in memory that are accessed
at the same time via DMA. The rules here are identical to the usual SMP
data ordering rules and are beyond the scope of this document.

[ -> Question 5]

* IV * Mixing of accessors
==========================

There are few rules concerning the mixing of accessors of the different
ordering Classes. Basically, when accessors of different classes share
an ordering rule, then that rule apply. If not, it doesn't apply. For
example:

writel followed by __writel : both accesors provide rule #1, thus it
applies and stores are visible in order. Since the previous writel will
have ordered previous stores to memory, the second __writel naturally
benefits from this despite the fact that __writel doesn't normally
provide that semantic.

Ben.


Questions:
==========

[* Question 1] Should Rule #4 be generalized to MMIO store followed by a
memory store ? (as spin_unlock are essentially a wmb followed by a
memory store) or do we need to keep a rule specific for locks to avoid
arch specific pitfalls on some architecture ? In that case, do we need a
specific barrier to provide MMIO store followed by a memory store ? That
sort of ordering is not generally useful and is generally expensive as
it requires to access the PCI host bridge to enforce that the previous
MMIO stores have reached the bus. Drivers generally don't need such a
rule or a barrier, as they have to deal with write posting anyway, and
thus use an MMIO read to provide the necessary synchronisation when it
makes sense.

[* Question 2] : Do we actually want the "ordered" accessors to also provide
ordering rule #4 in the general case ? This can be very expensive on
some architectures like ia64 where, I think, it has to actually access
the PCI host bridge to provide the guarantee that the previous MMIO
stores have reached it before the unlock is made visible to the
coherency domain. If we decide not to, then an explicit barrier will
still be needed in most drivers before spin_unlock(). This is the
current mmiowb() barrier that I'm proposing to rename (section * III *).
A way to provide that ordering requirement with less performance impact
is to instead set a per-cpu flag in writeX(), and test it in
spin_unlock() which would then do the barrier only if the flag is set.
It's to be measured whether the impact on unrelated spin_unlock() is low
enough to make that solution realstic.
If we decide to not enforce rule #4 for ordered accessors, and thus
require the barrier before spin_unlock, the above trick, could still be
implemented as a debug option to "detect" the lack of appropriate
barriers.

[* Question 3] If we decide that accessors of Class 1 do not provide rule
#4, then this barrier is to be used for all classes of accessors, except
maybe PIO which should always be fully ordered.

[* Question 4] Would it be a useful optimisation on archs like ia64 to
require this accessor to take the struct device of the device as an
argument (with can NULL for a "generic" barrier) or it doesn't matter ?

[* Question 5] Should we document the rules for memory-memory barriers
here as well ? (and give examples, like live updating of a network
driver ring descriptor entry)


