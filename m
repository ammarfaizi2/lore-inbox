Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWIQXQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWIQXQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWIQXQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:16:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:21932 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965154AbWIQXQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:16:00 -0400
Subject: [RFC] MMIO accessors & barriers documentation #2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:15:13 +1000
Message-Id: <1158534913.14473.276.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Here's a second version of my proposed documentation for MMIO accessors
and proposal for relaxed versions and associated barriers. I've removed
the questions as those have been answered most of the time (and when
they haven't directly, I've decided on a response myself :)

I'd like to have this submited for 2.6.19, along with an implementation
of the relaxed ops for PowerPC (it would be nice if ia64 could provide
one too), a generic implementation defining the relxaed ops based on the
normal one for other archs and maybe changes to a few drivers to use the
relaxed ops in some hot path.

Ben.

------


Definitions of MMIO accessors and IO related barriers semantics. First
we define some ordering requirements. Then, we define accessors and
which of these requirements they implement. Note that anything that
isn't explicitly mentioned in that list is left free to the
implementation, and thus isn't defined.


[Note] Those semantics are only currently defined for non-cacheable
MMIO mappings obtained from ioremap() or pci_iomap(). Anything mapped
cacheable via some architecture specific mecanisms will have
architecture specific ordering semantics.

[Note] Those ordering requirements and barriers are strictly specific
to MMIO/PIO and MMIO/PIO vs. memory ordering. Ordering between memory
accesses not directly involving MMIO is not covered in this document
and is the domain of the "traditional" memory barriers (wmb,mb,rmb)
which are to be used to provide explicit ordering of accesses to
consistent memory shared with the IO adapter.

[Note] About write combining. Some architectures can provide an
ioremap_wc() that enables write-combining globally over a given
mapping. However, on such a mapping, only relaxed or partially relaxed
accessors are defined as allowing write combining. It's yet to be
defined wether we can provide global write combining semantics, a lot
in that area is still left to the architecture.


* I * Ordering requirements:
============================

First, let's define 4 types of ordering requirements that can be
provided by MMIO accessors:

 1- MMIO + MMIO: This type of ordering means that two consecutive MMIO
accesses performed by one processors are issued in program order on the
bus. Reads can't cross writes. Writes can't be re-oredered vs. each
other. There is no implication on MMIOs issued by different CPUs nor
non-MMIO accesses.

 2- memory W + MMIO R/W: This type of ordering means that an store to main
memory that is performed in program order before an MMIO load or store to a
device, must be visible to that device before the MMIO access reaches it.
For example: updating of a DMA descriptor in memory is visible to the
chip before the MMIO write that cause that chip to go fetch it.

 3- MMIO R + memory R: This type of ordering means that an MMIO read will
be effectively performed (the result returned by the device to the
processor) before a following read for memory. That is, the value
returned by that following read is what was present in the coherency
domain after the MMIO read is complete. For example: reading a DMA
"pointer" from a device with an MMIO read, and then fetching the data in
memory up to that pointer.

 4- MMIO W + spin_unlock: This type of ordering means that MMIO stores
followed by a spin unlock will have all reached a host IO bridge
before the unlocking is visible to other CPUs. For example, two CPUs
have a locked section (same spinlock) issuing some MMIO stores to the
same device. Such ordering means that both sets of MMIO stores will not
be interleaved when reaching the host IO controller (PCI typically)
and thus the device. All MMIO stores from one locked section will be
performed before all MMIO stores from the other.

[Note] Rule #4 is strictly specific to MMIO stores followed by a
spin_unlock(). There is no ordering requirement provided by Linux to
ensure ordering of an MMIO store followed by a generic memory store
unless an explicit barrier is used. This limitation allows platforms
to limit the cost of such a barrier by implementing a per-cpu flag set
by MMIO stores, and test it in spin_unlock() instead of doing the
actual barrier on every MMIO store access which can be very expensive.


* II * Accessors:
=================

We provide 3 classes of accessors:

Class 1: Ordered accessors
--------------------------

 1- {read,write}{b,w,l,q} : MMIO accessors. Those accessors provide
all MMIO ordering requirements. They are thus called "fully ordered".
That is #1, #2 and #4 for writes and #1 and #3 for reads. 

 2- {in,out}{b,w,l,sb,sw,sl} " PIO accessors Those accessors provide
all MMIO ordering requirements. They are thus called "fully ordered".
That is #1, #2 and #4 for writes and #1 and #3 for reads.


 3- memcpy_to_io, memcpy_from_io: #1+#2+#4 (stores) or #1+#3 (loads)
semantics apply to the operation as a whole. That is memcpy_to_io() is
equivalent to a single writel() vs. preceding or subsequent operations
and memcpy_from_io() is equivalent to a single readl(). There is no
definition of the order or size of accesses within the actual memcpy
operation which is left to the implementation.

 4- io{read,write}{8,16,32}[be]: Those have the same semantics as 1
and 2.

Class 2: Partially relaxed accessors
------------------------------------

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

 2- memory_to_io_barrier() : This barrier provides ordering
requirement #2 between a memory store and an MMIO access. It can be
used in conjunction with MMIO accessors of Class 2 and 3.

 3- memory_to_io_wb() : This barrier is a subset of memory_to_io_barrier()
(and thus can be implemented as an equivalent if the architecture
doesn't provide the facility). It provides a subset of ordering
requirement #2 by ordering a memory store followed by an MMIO store
only. It doesn't provide any ordering guarantee vs. a subsequent
memory load.

 4- io_to_memory_rb(value) : This barrier provides ordering requirement
#3 between an MMIO read and a subsequent read from memory. For
implementation purposes on some architectures, the value actually read
by the MMIO read shall be passed as an argument to this barrier. (This
allows to generate the appropriate CPU instruction magic to force the
CPU to consider the value as being "used" and thus force the read to be
performed immediately). It can be used in conjunction with read
accessors of Class 2 and 3

 5- io_to_lock_wb() : This barrier provides ordering requirement #4
between an MMIO store and a subsequent spin_unlock(). It can be used in
conjunction with write accessors of Class 2 and 3. It's the equivalent
of the old mmiowb().


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
 

