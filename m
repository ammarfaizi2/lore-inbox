Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269432AbTCDN3j>; Tue, 4 Mar 2003 08:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269433AbTCDN3j>; Tue, 4 Mar 2003 08:29:39 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:2500 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S269432AbTCDN3h>;
	Tue, 4 Mar 2003 08:29:37 -0500
Subject: [RFC] IO vs. DMA and barriers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046785439.885.52.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 04 Mar 2003 14:43:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a problem that affects ppc32 and ppc63 archs, and possibly
other architectures with strong re-ordering capabilities and split
bus queues.

The problem is ensuring the order of accesses between CPU<->memory,
device<->memory and MMIO to the device.

>From my view of the problem (that is PPC), we have spotted 2
different kind of barrier requirements for the 2 different
problems below:

1) CPU write to memory, then CPU write to MMIO, then device
DMA reads from memory. This is the typical case of a ring of
descriptor based DMA engine. The CPU updates a descriptor in
memory, then "kicks" the chip using an MMIO write, then the
chip will do a bus master read from that descriptor.

The problem occurs if the processor re-orders the 2 writes
(memory and MMIO). The typical MMIO operations write{b,w,l}
do have a "simple" IO barrier, which is what is needed for
90% of the IO writes. However, on PPC, this barrier will not
enforce odering between cachable and non-cachable accesses.
I suspect NUMA architectures may have a similar issues if
IO and memory are on different nodes. It would be possible
to change the MMIO write operations to do a full sync (full
barrier), but that would have a significant performance
impact in the common case where a simple IO barrier (eieio)
is enough.

2) device DMA writes to memory, issue an IRQ, CPU MMIO
reads from the device, CPU reads from memory. This is
a typical case as well, happens with a descriptor-like
DMA engine: chip use DMA to update the descriptor and
issues an interrupt. The CPU use MMIO to read some kind
of interrupt status register (this is very important is
this read is what will flush the PCI posting buffers and
ensure the DMA to memory actually completed). Then, the
CPU reads the descriptor in memory.

The problem here occurs if the 2 reads (MMIO from device,
that is the one that flushes the PCI write posting, and
read from memory of the newly updated descriptor) get re-
ordered, possibly due to speculative execution.

For the same reason as 1), the IO barriers normally used
for ensuring MMIO ordering won't have any effect with the
read from normal memory (cacheable space) as this is
considered by the CPU as a different bus space.like

In this case, it's usually (at least on PPC) the IO latency
on reads is long enough that we have a temporary workaround
by hacking directly the read{b,w,l} operations so that they
use a non-taken branch and an isync (instruction sync) to
make the CPU think the read result was actually used before
executing the next operation. However, I suspect other archs
may have a similar problem with a non trivial workaround.

After long discussions with various driver writers and Alan,
it appears that the best solution would be to define an
abstraction of the kind

io_dma_{wmb,rmb,mb}(struct device* dev, 
	void* mem_virt, unsigned long mmio_virt)

and a wrapper

pci_dma_{wmb,rmb,mb}(struct pci_dev* dev,
	void* mem_virt, unsigned long mmio_virt)

for PCI drivers.

The definition is simple:

  - io_dma_wmb() ensures all memory writes done before
the barrier are ordered with further MMIO accesses.

  - io_dma_rmb() ensures all MMIO reads done before the
barrier are ordered with further memory reads

  - io_dma_mb() ensures both.

With the additional provision that the mem_virt parameter
can be set to some "undefined" value (~0 ?) to enforce
ordering with any memory location.

Those could be simply inlined as empty functions on arch with
strong ordering (x86). PPC would probably just implement the
wmb()/mb() doing a "sync", and keep the current workaround on
reads, then leaving the rmb() empty. Other archs (I'm thinking
about NUMA typically) have all the necessary infos from
struct device* to figure out what bus the access was made on
if this is necessary to do proper synchronisation.

Please, let me know if you are ok with this design, in which
case I'll produce a patch adding empty implementation for 
all archs but PPC, and I'll start feeding some driver
maintainers with updates 

Regards,
Ben.

