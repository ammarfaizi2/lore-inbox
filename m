Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156701AbPLTM1a>; Mon, 20 Dec 1999 07:27:30 -0500
Received: by vger.rutgers.edu id <S156515AbPLTM0X>; Mon, 20 Dec 1999 07:26:23 -0500
Received: from front2m.grolier.fr ([195.36.216.52]:34612 "EHLO front2m.grolier.fr") by vger.rutgers.edu with ESMTP id <S156692AbPLTMYw> convert rfc822-to-8bit; Mon, 20 Dec 1999 07:24:52 -0500
Date: Mon, 20 Dec 1999 14:49:47 +0100 (MET)
From: Gerard Roudier <groudier@club-internet.fr>
To: Gabriel Paubert <paubert@iram.es>
Cc: Jes Sorensen <Jes.Sorensen@cern.ch>, Linux <linux-kernel@vger.rutgers.edu>
Subject: Re: readX/writeX semantic and ordering
In-Reply-To: <Pine.HPX.4.10.9912161100150.8289-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.95.991220141721.1274A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 16 Dec 1999, Gabriel Paubert wrote:
 
> On Thu, 16 Dec 1999, Gerard Roudier wrote:
> 
> > > Cachable CPU stores (whether buffered due to a cache miss or not) will not
> > > be carried out to system bus, they will only be put into the cache. The
> > 
> > If the cache controller snoops memory accesses (including DMA) from the 
> > system BUS and agrees with the memory/bus controller for performing 
> > cache line write-back when a dirty cache line is hit, ordering is as
> > expected.
> 
> All PPC snoop (the data and L2 cache) provided the host bridge flags the
> accesses it performs on behalf of PCI devices as global (with the GBL bus
> signal). Setting or not this signal is an option on some bridges but you
> can safely assume that it will be set since it makes things much simpler
> (otherwise you'd have to explicitly flush the caches).

Could I suggest the kernel to be made careful about that, if detection is 
possible, and warn about misconfiguration.
I have been reported some problem on the G3 that seems to disappear when 
the cache is set write-through. Could a bridge misconfiguration explain 
that ?
  
> > > architecture does not guarantee anything about the ordering in theory,
> > > but in all current implementations the only effect is that loads may be
> > > moved ahead of pending stores and stores may be combined (but not on
> > > guarded memory which happens to be the case of areas returned by ioremap).
> > 
> > No problem there. A driver should normally expect IO/MMIO accesses to
> > follow strong ordering, but should insert explicit memory barrier for
> > STOREs to memory to be observed in order from the BUS each time it is
> > needed. OTOH, having reads from memory passing writes when possible should
> > not make problems.
> 
> Sorry I was not clear:
> on PPC an MMIO read can go ahead of an MMIO write unless an eieio or sync
> instruction is in between (or the read is from the same address as the
> write). Writes can be reordered / gathered in host bridge too (or in the
> processor for non guarded storage) unless there is an explicit ordering
> barrier. This cause all {read,write,in,out}[bwl] on PPC to be followed by
> an eieio instruction. 

The current readX/writeX implementation does eieio (that's full chinese to
me, especially when I try to pronounce it;-)) after MMIOing.  The
sym53c8xx driver knows about (since I teached it about :)) and performs
mb() = "sync" for PPC in places when ordering between MMIO and memory
accesses has to be guaranteed. This works on paper but has been reported
not to be enough with some G3 (cache snooping against DMA is assumed).

> If I understand correctly all the issues (a big if), you have to put a
> strong memory barrier to have guaranteed behaviour in your case.  By
> strong I mean a PPC 'sync' instruction, 'eieio' is not enough since it
> does not order writeback memory accesses relative to noncacheable memory
> accesses. 

That was close to my understanding.
 
> AFAIK, all _current_ PPC processors execute stores in order, and store
> buffers will not be a problem since they are inside the coherent memory
> domain (this is clearly stated on the 604 documentation, unfortunately the
> available 7400/G4 documentation is still very poor). This means that
> stores to memory will enter the coherent memory domain before a write to a
> device register takes place. But this is not required and therefore not
> safe...
> 
> I still don't see why they would want to execute the write to the device
> register before the earlier stores enters the coherent memory domain. The
> implementation complexity is probably not worth the performance gain.

Current CPU optimizations are too CPU centric in my opinion and just move
the complexity to IO sub-systems. And, btw, there are too many bridges
broken by design because of the ingeneers seeming to focus too much the
CPU. Or may-be they were unable to understand PCI specs for example.;-) 
 
> > > So in the end I defined my own macros to access the registers of this
> > > device: sometimes I don't care about reordering/merging for 5 or so
> > > consecutive register writes which are a mixture of big and little endian
> > > accesses. Without considering code bloat, eieio is expensive on some
> > > processors since it goes to the bus to tell the bridge not to perform
> > > reordering.
> > 
> > When actual data transfer uses BUS mastering, the number of IOs/MMIOs is
> > generally small. I would prefer to be safe rather than to spare a couple
> > of micro-seconds, since ordering problems have very weird effects. 
> 
> Indeed, but in my case (generating VMEbus locked cycle through Tundra's
> Universe chip) the things are clear: 
> 1) acquire a spinlock for SMP
> 2) write 5 registers which describe the locked cycle
> 3) ordering barrier
> 4) read from a register to actually perform the locked cycle
> 5) ordering barrier
> 6) write to disable the locked cycle generator
> 7) release the spinlock
> 
> the order in which registers are accessed in step 2 is totally irrelevant
> and actually 5) is a nop since I don't know of any processor which would
> reorder a write before a read. If you count the bus cycles with an eieio
> after each read/write versus the minimum actually implemented, 14 versus
> 9, it becomes significant.

A single micro-second (hundreds of cycles) per IO does not make difference
with SCSI when mastering and a single interrupt per IO is possible. I (and
user) can invest this micro-second per IO for the system to work reliably.
I may end-up differentiating arch at driver level if needed, but this
requires me to learn about all of them. If I add everything needed for
PCI, SCSI and freinds, may-be I should overclock my brain in order to deal
properly with all of that. :-)

> > Indeed I am interested.
> 
> Ok, I've put them on ftp://vlab1.iram.es/pub/ppcdocs since it's too big
> for email (even private, I never considered posting it to the list).

Thanks very much. I have downloaded them, but haven't had time for now to
look into them.

Regards,
   Gérard.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
