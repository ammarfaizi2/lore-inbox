Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSIXTRa>; Tue, 24 Sep 2002 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSIXTRa>; Tue, 24 Sep 2002 15:17:30 -0400
Received: from [198.149.18.6] ([198.149.18.6]:49879 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261749AbSIXTR1>;
	Tue, 24 Sep 2002 15:17:27 -0400
Date: Tue, 24 Sep 2002 14:22:36 -0500 (CDT)
From: Alan Mayer <ajm@sgi.com>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: irqs on large machines (patch)
Message-ID: <Pine.SGI.3.96.1020924142045.102141A-100000@fergus.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Below is a patch against 2.5.38.  All it does is
add a new tag (NR_IVECS) that is the number of hardware
interrupt vectors supported by the processor.  We need this
for the SGI Itanium based NUMA machines.  I've run the idea
past David Mossberger and he likes it.  However, some of the
changes leaked over into the base linux code, so I'm sending
those changes out to the mailing list.

	There is a longer explanation/justification at the end
of this email, if you're interested.  Small patch, long
explanation follows.


diff -Naur linux-2.5.38/fs/proc/proc_misc.c linux-2.5.38.new/fs/proc/proc_misc.c
--- linux-2.5.38/fs/proc/proc_misc.c	Sat Sep 21 23:25:01 2002
+++ linux-2.5.38.new/fs/proc/proc_misc.c	Tue Sep 24 11:38:12 2002
@@ -324,7 +324,7 @@
 		nice += kstat.per_cpu_nice[i];
 		system += kstat.per_cpu_system[i];
 #if !defined(CONFIG_ARCH_S390)
-		for (j = 0 ; j < NR_IRQS ; j++)
+		for (j = 0 ; j < NR_IVECS ; j++)
 			sum += kstat.irqs[i][j];
 #endif
 	}
@@ -356,7 +356,7 @@
 			sum
 	);
 #if !defined(CONFIG_ARCH_S390)
-	for (i = 0 ; i < NR_IRQS ; i++)
+	for (i = 0 ; i < NR_IVECS ; i++)
 		len += sprintf(page + len, " %u", kstat_irqs(i));
 #endif
 
diff -Naur linux-2.5.38/include/linux/irq.h linux-2.5.38.new/include/linux/irq.h
--- linux-2.5.38/include/linux/irq.h	Sat Sep 21 23:25:07 2002
+++ linux-2.5.38.new/include/linux/irq.h	Tue Sep 24 11:24:55 2002
@@ -68,6 +68,10 @@
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
+#ifndef NR_IVECS
+#define NR_IVECS NR_IRQS
+#endif
+
 extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 extern int setup_irq(unsigned int , struct irqaction * );
 
diff -Naur linux-2.5.38/include/linux/kernel_stat.h linux-2.5.38.new/include/linux/kernel_stat.h
--- linux-2.5.38/include/linux/kernel_stat.h	Sat Sep 21 23:25:07 2002
+++ linux-2.5.38.new/include/linux/kernel_stat.h	Tue Sep 24 11:31:14 2002
@@ -2,7 +2,7 @@
 #define _LINUX_KERNEL_STAT_H
 
 #include <linux/config.h>
-#include <asm/irq.h>
+#include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
 
@@ -32,7 +32,7 @@
 	unsigned int pgscan, pgsteal;
 	unsigned int pageoutrun, allocstall;
 #if !defined(CONFIG_ARCH_S390)
-	unsigned int irqs[NR_CPUS][NR_IRQS];
+	unsigned int irqs[NR_CPUS][NR_IVECS];
 #endif
 };
 



	I will try to explain how we manage with 256 interrupt
vectors on a system with up to 2176 sources of IO interrupts.
What follows is applicable to our system.  I hope that I give
enough detail that it can be understood by someone who is not
familiar with the SGI platform.  I'm not really an IO guy.  I've
had to learn all this stuff on the fly over the last two years.
If I use names for things that are unfamiliar to an experienced
IO guy, that's why.  I've made up a lot of my own terminology.

	First, some terminology:  An interrupt vector (ivec) is what 
the processor presents to the software as an indication of which 
source of an external interrupt needs attention.  An irq is a small
integer which the software uses to find the interrupt handling
routine for the associated ivec.  There exists an easy mapping 
from ivec to irq and from irq to ivec.  Note that I view irqs and
ivecs as different, though related things.  

	An interrupt has a source and a target.  The source is 
typically a card (or a function on a card) in a PCI slot.  The 
target is a cpu.  If the source is in a PCI slot, it is identified 
by the IO node, the bus number, the slot number, and the function.  
The target is just the logical cpu number.

	There are two parts of interrupt management. The first is
allocation, the second is delivery.  

	An interrupt is allocated to a device by the IO 
infrastructure at IO initialization time.  On an SGI system,
the allocation algorithm works as follows.  The IO infrastructure
performs IO discovery.  It finds all the IO nodes.  For each IO
node, it finds all the buses.  For all the buses, it finds the slots.
For each slot, it determines which (cpu, ivec) pair to assign to
the slot.  It chooses the cpu by first looking at the compute node
that is closest to the IO node.  If a cpu on that node has an 
available ivec, it uses that cpu.  If it doesn't, it searches the
rest of the nodes until it finds one with a cpu with available
ivecs.  Once it has found a cpu, it chooses one of  the available
ivecs.  It assigns that pair to the slot.  It does this by 
constructing an irq out of the cpu/ivec pair (irq ::= (cpu << 8) | ivec).
Constructing irqs in this fashion means that the irq range is
0..(num_cpus * 256), since each cpu can have 256 ivecs.  There is,
of course, some initialization of chipset registers to target
the interrupt.  The details of this will be ignored in this document.
When the driver initializes, it gets the irq assigned to it (it
has been placed in the pci_dev struct) and calls request_irq
with it.  David M. has given us a machvec routine that, given an
irq, returns the irq_desc entry associated with it.  On most
(all but ours?) systems, this routine just uses the irq as
an index into the irq_desc array.  On our system, we break
the irq into cpu and ivec.  We use the cpu to index to the
irq_desc array for that cpu, then use the ivec to get the
irq_desc entry for that irq.  The rest of request_irq then
doesn't need to know anything about the architectural differences
in the SGI platform.

	Interrupt delivery on SGI machines reverses the process.
The processor presents the software with an ivec.  Since, on
SGI machines, we have targeted the ivec to a particular processor
and the underlying hardware will send it to just that processor
and no other, it is trivial to reconstruct the irq from the
ivec and smp_processor_id().  Then we can use the irq_desc()
machvec to find the irq_desc entry for this interrupt and
call the correct interrupt handler.

	The above works.  It has been implemented and has been
running on IPF processor based systems for well over a year.
The problem is what to do with NR_IRQS.  Should NR_IRQS be
set to the number of ivecs (256) or the number of irqs 
(num_cpus * 256)?  If we set it to the number of ivecs, then
the places where we test if an irq is valid (usually,
"if (irq <= NR_IRQS)"), the test will fail on our system
for legitimate irqs that are targeted to cpu 1 or higher.
Our attempt to get David to accept a change to allow for
irqs outside the range of 0..NR_IRQS was rejected, as it
probably should have been.  If we set NR_IRQS to the number
of irqs in the system (num_cpus * 256), then the above 
problem goes away, but new ones crop up.  These problems
include (but probably aren't limited to) allocation of way
to much space in some data structures and breaking the
/proc interface for interrupts.  The kstat structure
becomes much larger, because it has an array dimensioned
by NR_IRQS.  There are some arrays in random.c that are
dimensioned by NR_IRQS.  However, the worst is that
the irq_desc arrays, one per cpu, are allocated using
NR_IRQS as the size.  These are allocated on the node
local to the cpu that uses them, for obvious reasons.
We only need 256 entries per cpu.  With the large value
for NR_IRQS, we will get 65,536 entries per cpu.
That means that there will be 16,711,680 unused irq_desc
entries on a fully configured system (256 cpus).  
This is intolerable.

	We are considering proposing for linux that rather
than choose between two bad values for NR_IRQS, that we
add a new value, NR_IVECS.  The addition of this value
will recognize that irqs and ivecs are similar, related,
but different entities.  On most systems (all but ours?),
NR_IVECS would be equal to NR_IRQS.  On our system, we
would set NR_IVECS to 256, and NR_IRQS to NR_IVECS * NR_CPUS.
Then, in those places where we are talking about ivecs,
we could use NR_IVECS and those places where we are
talking about irqs, we could use NR_IRQS.  Since those
systems where the number of irqs and ivecs are equal, and
where they are all referred to as irqs, NR_IVECS would
be defined as NR_IRQS.  Thus, on systems that don't
care, there would be no change.

We are star dust,
We are golden,
We are caught in the Devil's bargain.
--
Alan J. Mayer
SGI
ajm@sgi.com
WORK: 651-683-3131
HOME: 651-407-0134
--

