Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWCPXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWCPXQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWCPXQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:16:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21406 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751066AbWCPXQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:16:46 -0500
Date: Thu, 16 Mar 2006 15:17:23 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Message-ID: <20060316231723.GB1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18351.1142432599@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 02:23:19PM +0000, David Howells wrote:
> 
> The attached patch documents the Linux kernel's memory barriers.
> 
> I've updated it from the comments I've been given.
> 
> The per-arch notes sections are gone because it's clear that there are so many
> exceptions, that it's not worth having them.
> 
> I've added a list of references to other documents.
> 
> I've tried to get rid of the concept of memory accesses appearing on the bus;
> what matters is apparent behaviour with respect to other observers in the
> system.
> 
> Interrupts barrier effects are now considered to be non-existent. They may be
> there, but you may not rely on them.
> 
> I've added a couple of definition sections at the top of the document: one to
> specify the minimum execution model that may be assumed, the other to specify
> what this document refers to by the term "memory".
> 
> I've made greater mention of the use of mmiowb().
> 
> I've adjusted the way in which caches are described, and described the fun
> that can be had with cache coherence maintenance being unordered and data
> dependency not being necessarily implicit.
> 
> I've described (smp_)read_barrier_depends().

Good stuff!!!  Please see comments interspersed, search for empty lines.

One particularly serious issue involve your smp_read_barrier_depends()
example.

> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> warthog>diffstat -p1 /tmp/mb.diff 
>  Documentation/memory-barriers.txt | 1039 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1039 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> new file mode 100644
> index 0000000..fd7a6f1
> --- /dev/null
> +++ b/Documentation/memory-barriers.txt
> @@ -0,0 +1,1039 @@
> +			 ============================
> +			 LINUX KERNEL MEMORY BARRIERS
> +			 ============================
> +
> +Contents:
> +
> + (*) Assumed minimum execution ordering model.
> +
> + (*) What is considered memory?

Suggest the following -- most people need to rethink what memory
means:

(*) What is memory?

Or maybe "What is 'memory'"?

> +
> +     - Cached interactions.
> +     - Cache coherency.
> +     - Uncached interactions.
> +
> + (*) What are memory barriers?
> +
> + (*) Where are memory barriers needed?
> +
> +     - Accessing devices.
> +     - Multiprocessor interaction.
> +     - Interrupts.
> +
> + (*) Explicit kernel compiler barriers.
> +
> + (*) Explicit kernel memory barriers.
> +
> +     - Barrier pairing.
> +
> + (*) Implicit kernel memory barriers.
> +
> +     - Locking functions.
> +     - Interrupt disabling functions.
> +     - Miscellaneous functions.
> +
> + (*) Inter-CPU locking barrier effects.
> +
> +     - Locks vs memory accesses.
> +     - Locks vs I/O accesses.
> +
> + (*) Kernel I/O barrier effects.
> +
> + (*) References.
> +
> +
> +========================================
> +ASSUMED MINIMUM EXECUTION ORDERING MODEL
> +========================================
> +
> +It has to be assumed that the conceptual CPU is weakly-ordered in all respects
> +but that it will maintain the appearance of program causality with respect to
> +itself.  Some CPUs (such as i386 or x86_64) are more constrained than others
> +(such as powerpc or frv), and so the most relaxed case must be assumed outside

Might as well call it out:

+(such as powerpc or frv), and so the most relaxed case (namely DEC Alpha)
+must be assumed outside

> +of arch-specific code.

Also, I have some verbiage and diagrams of Alpha's operation at
http://www.rdrop.com/users/paulmck/scalability/paper/ordering.2006.03.13a.pdf
Feel free to take any that helps.  (Source for paper is Latex and xfig,
for whatever that is worth.)

> +This means that it must be considered that the CPU will execute its instruction
> +stream in any order it feels like - or even in parallel - provided that if an
> +instruction in the stream depends on the an earlier instruction, then that
> +earlier instruction must be sufficiently complete[*] before the later
> +instruction may proceed.

Suggest replacing the last two lines with:

+instruction may proceed, in other words, provided that the appearance of
+causality is maintained.

> +

Suggest just folding the following footnotes into the above paragraph:

> + [*] Some instructions have more than one effect[**] and different instructions
> +     may depend on different effects.
> +
> + [**] Eg: changes to condition codes and registers; memory events.
> +
> +A CPU may also discard any instruction sequence that ultimately winds up having
> +no effect.  For example if two adjacent instructions both load an immediate
> +value into the same register, the first may be discarded.
> +
> +
> +Similarly, it has to be assumed that compiler might reorder the instruction
> +stream in any way it sees fit, again provided the appearance of causality is
> +maintained.
> +
> +
> +==========================
> +WHAT IS CONSIDERED MEMORY?
> +==========================

+===============
+WHAT IS MEMORY?
+===============

> +For the purpose of this specification what's meant by "memory" needs to be
> +defined, and the division between CPU and memory needs to be marked out.
> +
> +
> +CACHED INTERACTIONS
> +-------------------
> +
> +As far as cached CPU vs CPU[*] interactions go, "memory" has to include the CPU
> +caches in the system.  Although any particular read or write may not actually
> +appear outside of the CPU that issued it (the CPU may may have been able to
> +satisfy it from its own cache), it's still as if the memory access had taken
> +place as far as the other CPUs are concerned since the cache coherency and
> +ejection mechanisms will propegate the effects upon conflict.
> +
> + [*] Also applies to CPU vs device when accessed through a cache.
> +
> +The system can be considered logically as:

Suggest showing the (typical) possibility of MMIO bypassing the CPU cache,
as happens in many systems.  See below for a hacky suggested change.

> +	    <--- CPU --->         :       <----------- Memory ----------->
> +	                          :
> +	+--------+    +--------+  :   +--------+    +-----------+
> +	|        |    |        |  :   |        |    |           |    +--------+
> +	|  CPU   |    | Memory |  :   | CPU    |    |           |    |	      |
> +	|  Core  |--->| Access |----->| Cache  |<-->|           |    |	      |
> +	|        |    | Queue  |  :   |        |    |           |--->| Memory |
> +	|        |    |        |  :   |        |    |           |    |	      |
> +	+--------+    +--------+  :   +--------+    |           |    | 	      |
> +	                   V      :                 | Cache     |    +--------+
> +	                   |      :                 | Coherency |
> +	                   |      :                 | Mechanism |    +--------+
> +	+--------+    +--------+  :   +--------+    |           |    |	      |
> +	|        |    |        |  :   |        |    |           |    |        |
> +	|  CPU   |    | Memory |  :   | CPU    |    |           |--->| Device |
> +	|  Core  |--->| Access |----->| Cache  |<-->|           |    | 	      |
> +	|        |    | Queue  |  :   |        |    |           |    | 	      |
> +	|        |    |        |  :   |        |    |           |    +----+---+
> +	+--------+    +--------+  :   +--------+    +-----------+         ^
> +	                   V      :                                       |
> +	                   |      :                                       |
> +	                   +----------------------------------------------+
> +	                          :
> +	                          :

In the past, there have been systems in which the devices did -not- see
coherent memory, where (for example) CPU caches had to be manually flushed
before a DMA operation was allowed to procede.

> +The CPU core may execute instructions in any order it deems fit, provided the
> +expected program causality appears to be maintained.  Some of the instructions
> +generate load and store operations which then go into the memory access queue
> +to be performed.  The core may place these in the queue in any order it wishes,
> +and continue execution until it is forced to wait for an instruction to
> +complete.
> +
> +What memory barriers are concerned with is controlling the order in which
> +accesses cross from the CPU side of things to the memory side of things, and
> +the order in which the effects are perceived to happen by the other observers
> +in the system.

Suggest emphasizing this point:

+Memory barriers are -not- needed within a given CPU, as CPUs always see
+their own loads and stores as if they had happened in program order.

Might also want to define program order, execution order, and perceived
order, or similar terms.

> +CACHE COHERENCY
> +---------------
> +
> +Life isn't quite as simple as it may appear above, however: for while the
> +caches are expected to be coherent, there's no guarantee that that coherency
> +will be ordered.  This means that whilst changes made on one CPU will
> +eventually become visible on all CPUs, there's no guarantee that they will
> +become apparent in the same order on those other CPUs.

Nit, perhaps not worth calling out -- a given change might well be overwritten
by a second change, so that the first change is never seen by other CPUs.

> +Consider dealing with a pair of CPUs (1 & 2), each of which has a pair of
> +parallel data caches (A,B and C,D) with the following properties:
> +
> + (*) a cacheline may be in one of the caches;
> +
> + (*) whilst the CPU core is interrogating one cache, the other cache may be
> +     making use of the bus to access the rest of the system - perhaps to
> +     displace a dirty cacheline or to do a speculative read;
> +
> + (*) each cache has a queue of operations that need to be applied to that cache
> +     to maintain coherency with the rest of the system;
> +
> + (*) the coherency queue is not flushed by normal reads to lines already
> +     present in the cache, even though the contents of the queue may
> +     potentially effect those reads.

Suggest the following:

+ (*) the coherency queue is not flushed by normal reads to lines already
+     present in the cache, however, the reads will access the data in
+     the coherency queue in preference to the (obsoleted) data in the cache.
+     This is necessary to give the CPU the illusion that its operations
+     are being performed in order.

> +Imagine, then, two writes made on the first CPU, with a barrier between them to
> +guarantee that they will reach that CPU's caches in the requisite order:
> +
> +	CPU 1		CPU 2		COMMENT
> +	===============	===============	=======================================
> +					a == 0, b == 1 and p == &a, q == &a
> +	b = 2;
> +	smp_wmb();			Make sure b is changed before p

Suggest the more accurate:

+	smp_wmb();			Make sure change to b visible before p

The CPU is within its rights to execute these out of order as long as all
the other CPUs perceive the change to b as preceding the change to p.
And I believe that many CPUs in fact do just this sort of sneaky reordering,
e.g., via speculative execution.

> +	<A:modify b=2>			The cacheline of b is now ours
> +	p = &b;
> +	<A:modify p=&b>			The cacheline of p is now ours
> +
> +The write memory barrier forces the local CPU caches to be updated in the
> +correct order.

It actually forces the other CPUs to see the updates in the correct order,
the updates to the local CPU caches might well be misordered.

Also, shouldn't one or the other of the "A:"s above be "B:"?  I am assuming
that they are supposed to refer to the "parallel data caches (A,B and C,D)"
mentioned earlier.  If they don't, I have no idea what they are supposed
to mean.

> +                But now imagine that the second CPU that wants to read those
> +values:
> +
> +	CPU 1		CPU 2		COMMENT
> +	===============	===============	=======================================
> +	...
> +			q = p;
> +			d = *q;
> +
> +The above pair of reads may then fail to apparently happen in expected order,
> +as the cacheline holding p may get updated in one of the second CPU's caches
> +whilst the update to the cacheline holding b is delayed in the other of the
> +second CPU's caches by some other cache event:
> +
> +	CPU 1		CPU 2		COMMENT
> +	===============	===============	=======================================
> +					a == 0, b == 1 and p == &a, q == &a
> +	b = 2;
> +	smp_wmb();			Make sure b is changed before p
> +	<A:modify b=2>	<C:busy>
> +			<C:queue b=2>
> +	p = &b;		q = p;
> +			<D:request p>
> +	<A:modify p=&b>	<D:commit p=&b>
> +		  	<D:read p>
> +			d = *q;
> +			<C:read *q>	Reads from b before b updated in cache
> +			<C:unbusy>
> +			<C:commit b=2>

I don't understand the "A:", "B:", etc. in the above example.  Is variable
"b" in cacheline A or in cacheline C?  Or do A and C mean something
other than "cacheline" as indicated earlier.

> +Basically, whilst both cachelines will be updated on CPU 2 eventually, there's
> +no guarantee that, without intervention, the order of update will be the same
> +as that committed on CPU 1.
> +
> +
> +To intervene, we need to emplace a data dependency barrier or a read barrier.
> +This will force the cache to commit its coherency queue before processing any
> +further requests:
> +
> +	CPU 1		CPU 2		COMMENT
> +	===============	===============	=======================================
> +					a == 0, b == 1 and p == &a, q == &a
> +	b = 2;
> +	smp_wmb();			Make sure b is changed before p
> +	<A:modify b=2>	<C:busy>
> +			<C:queue b=2>
> +	p = &b;		q = p;
> +			<D:request p>
> +	<A:modify p=&b>	<D:commit p=&b>
> +		  	<D:read p>
> +			smp_read_barrier_depends()
> +			<C:unbusy>
> +			<C:commit b=2>
> +			d = *q;
> +			<C:read *q>	Reads from b after b updated in cache

Again, I don't understand the "A:", "B:", etc. in the above example.
Is variable "b" in cacheline A or in cacheline C?  Or do A and C mean
something other than "cacheline" as indicated earlier.

> +This sort of problem can be encountered on Alpha processors as they have a
> +split cache that improves performance by making better use of the data bus.
> +Whilst most CPUs do imply a data dependency barrier on the read when a memory
> +access depends on a read, not all do, so it may not be relied on.
> +
> +
> +UNCACHED INTERACTIONS
> +---------------------
> +
> +Note that the above model does not show uncached memory or I/O accesses.  These
> +procede directly from the queue to the memory or the devices, bypassing any
> +caches or cache coherency:
> +
> +	    <--- CPU --->         :
> +       	                          :		+-----+

There are some gratuitious tabs in the above line.

> +	+--------+    +--------+  :             |     |
> +	|        |    |        |  :             |     |              +---------+
> +	|  CPU   |    | Memory |  :             |     |              |	       |
> +	|  Core  |--->| Access |--------------->|     |              |	       |
> +	|        |    | Queue  |  :             |     |------------->| Memory  |
> +	|        |    |        |  :             |     |              |	       |
> +	+--------+    +--------+  :             |     |              | 	       |
> +	                          :             |     |              +---------+
> +	                          :             | Bus |
> +	                          :             |     |              +---------+
> +	+--------+    +--------+  :             |     |              |	       |
> +	|        |    |        |  :             |     |              |         |
> +	|  CPU   |    | Memory |  :             |     |<------------>| Device  |
> +	|  Core  |--->| Access |--------------->|     |              | 	       |
> +	|        |    | Queue  |  :             |     |              | 	       |
> +	|        |    |        |  :             |     |              +---------+
> +	+--------+    +--------+  :             |     |
> +	                          :		+-----+
> +	                          :
> +
> +
> +=========================
> +WHAT ARE MEMORY BARRIERS?
> +=========================
> +
> +Memory barriers are instructions to both the compiler and the CPU to impose an
> +apparent partial ordering between the memory access operations specified either

Suggest s/apparent/perceived/

> +side of the barrier.  They request that the sequence of memory events generated
> +appears to other components of the system as if the barrier is effective on
> +that CPU.
> +
> +Note that:
> +
> + (*) there's no guarantee that the sequence of memory events is _actually_ so
> +     ordered.  It's possible for the CPU to do out-of-order accesses _as long
> +     as no-one is looking_, and then fix up the memory if someone else tries to
> +     see what's going on (for instance a bus master device); what matters is
> +     the _apparent_ order as far as other processors and devices are concerned;
> +     and
> +
> + (*) memory barriers are only guaranteed to act within the CPU processing them,
> +     and are not, for the most part, guaranteed to percolate down to other CPUs
> +     in the system or to any I/O hardware that that CPU may communicate with.

Suggest s/not, for the most part,/_not_ necessarily/

> +For example, a programmer might take it for granted that the CPU will perform
> +memory accesses in exactly the order specified, so that if a CPU is, for
> +example, given the following piece of code:
> +
> +	a = *A;
> +	*B = b;
> +	c = *C;
> +	d = *D;
> +	*E = e;
> +
> +They would then expect that the CPU will complete the memory access for each
> +instruction before moving on to the next one, leading to a definite sequence of
> +operations as seen by external observers in the system:
> +
> +	read *A, write *B, read *C, read *D, write *E.
> +
> +
> +Reality is, of course, much messier.  With many CPUs and compilers, this isn't
> +always true because:
> +
> + (*) reads are more likely to need to be completed immediately to permit
> +     execution progress, whereas writes can often be deferred without a
> +     problem;
> +
> + (*) reads can be done speculatively, and then the result discarded should it
> +     prove not to be required;
> +
> + (*) the order of the memory accesses may be rearranged to promote better use
> +     of the CPU buses and caches;
> +
> + (*) reads and writes may be combined to improve performance when talking to
> +     the memory or I/O hardware that can do batched accesses of adjacent
> +     locations, thus cutting down on transaction setup costs (memory and PCI
> +     devices may be able to do this); and
> +
> + (*) the CPU's data cache may affect the ordering, and whilst cache-coherency
> +     mechanisms may alleviate this - once the write has actually hit the cache
> +     - there's no guarantee that the coherency management will be propegated in
> +     order to other CPUs.
> +
> +So what another CPU, say, might actually observe from the above piece of code
> +is:
> +
> +	read *A, read {*C,*D}, write *E, write *B
> +
> +	(By "read {*C,*D}" I mean a combined single read).
> +
> +
> +It is also guaranteed that a CPU will be self-consistent: it will see its _own_
> +accesses appear to be correctly ordered, without the need for a memory barrier.
> +For instance with the following code:
> +
> +	X = *A;
> +	*A = Y;
> +	Z = *A;
> +
> +assuming no intervention by an external influence, it can be taken that:
> +
> + (*) X will hold the old value of *A, and will never happen after the write and
> +     thus end up being given the value that was assigned to *A from Y instead;
> +     and
> +
> + (*) Z will always be given the value in *A that was assigned there from Y, and
> +     will never happen before the write, and thus end up with the same value
> +     that was in *A initially.
> +
> +(This is ignoring the fact that the value initially in *A may appear to be the
> +same as the value assigned to *A from Y).
> +
> +
> +=================================
> +WHERE ARE MEMORY BARRIERS NEEDED?
> +=================================
> +
> +Under normal operation, access reordering is probably not going to be a problem
> +as a linear program will still appear to operate correctly.  There are,
> +however, three circumstances where reordering definitely _could_ be a problem:

Suggest listing the three circumstances (accessing devices, multiprocessor
interaction, interrupts) before the individual sections.  Don't leave us
in suspense!  ;-)

> +ACCESSING DEVICES
> +-----------------
> +
> +Many devices can be memory mapped, and so appear to the CPU as if they're just
> +memory locations.  However, to control the device, the driver has to make the
> +right accesses in exactly the right order.
> +
> +Consider, for example, an ethernet chipset such as the AMD PCnet32.  It
> +presents to the CPU an "address register" and a bunch of "data registers".  The
> +way it's accessed is to write the index of the internal register to be accessed
> +to the address register, and then read or write the appropriate data register
> +to access the chip's internal register, which could - theoretically - be done
> +by:
> +
> +	*ADR = ctl_reg_3;
> +	reg = *DATA;
> +
> +The problem with a clever CPU or a clever compiler is that the write to the
> +address register isn't guaranteed to happen before the access to the data
> +register, if the CPU or the compiler thinks it is more efficient to defer the
> +address write:
> +
> +	read *DATA, write *ADR
> +
> +then things will break.
> +
> +
> +In the Linux kernel, however, I/O should be done through the appropriate
> +accessor routines - such as inb() or writel() - which know how to make such
> +accesses appropriately sequential.
> +
> +On some systems, I/O writes are not strongly ordered across all CPUs, and so
> +locking should be used, and mmiowb() must be issued prior to unlocking the
> +critical section.
> +
> +See Documentation/DocBook/deviceiobook.tmpl for more information.
> +
> +
> +MULTIPROCESSOR INTERACTION
> +--------------------------
> +
> +When there's a system with more than one processor, the CPUs in the system may
> +be working on the same set of data at the same time.  This can cause
> +synchronisation problems, and the usual way of dealing with them is to use
> +locks - but locks are quite expensive, and so it may be preferable to operate
> +without the use of a lock if at all possible.  In such a case accesses that
> +affect both CPUs may have to be carefully ordered to prevent error.
> +
> +Consider the R/W semaphore slow path.  In that, a waiting process is queued on
> +the semaphore, as noted by it having a record on its stack linked to the
> +semaphore's list:
> +
> +	struct rw_semaphore {
> +		...
> +		struct list_head waiters;
> +	};
> +
> +	struct rwsem_waiter {
> +		struct list_head list;
> +		struct task_struct *task;
> +	};
> +
> +To wake up the waiter, the up_read() or up_write() functions have to read the
> +pointer from this record to know as to where the next waiter record is, clear
> +the task pointer, call wake_up_process() on the task, and release the reference
> +held on the waiter's task struct:
> +
> +	READ waiter->list.next;
> +	READ waiter->task;
> +	WRITE waiter->task;
> +	CALL wakeup
> +	RELEASE task
> +
> +If any of these steps occur out of order, then the whole thing may fail.
> +
> +Note that the waiter does not get the semaphore lock again - it just waits for
> +its task pointer to be cleared.  Since the record is on its stack, this means
> +that if the task pointer is cleared _before_ the next pointer in the list is
> +read, another CPU might start processing the waiter and it might clobber its
> +stack before up*() functions have a chance to read the next pointer.
> +
> +	CPU 1				CPU 2
> +	===============================	===============================
> +					down_xxx()
> +					Queue waiter
> +					Sleep
> +	up_yyy()
> +	READ waiter->task;
> +	WRITE waiter->task;
> +	<preempt>
> +					Resume processing
> +					down_xxx() returns
> +					call foo()
> +					foo() clobbers *waiter
> +	</preempt>
> +	READ waiter->list.next;
> +	--- OOPS ---
> +
> +This could be dealt with using a spinlock, but then the down_xxx() function has
> +to get the spinlock again after it's been woken up, which is a waste of
> +resources.
> +
> +The way to deal with this is to insert an SMP memory barrier:
> +
> +	READ waiter->list.next;
> +	READ waiter->task;
> +	smp_mb();
> +	WRITE waiter->task;
> +	CALL wakeup
> +	RELEASE task
> +
> +In this case, the barrier makes a guarantee that all memory accesses before the
> +barrier will appear to happen before all the memory accesses after the barrier
> +with respect to the other CPUs on the system.  It does _not_ guarantee that all
> +the memory accesses before the barrier will be complete by the time the barrier
> +itself is complete.
> +
> +SMP memory barriers are normally nothing more than compiler barriers on a

Suggest s/barriers are/barriers (e.g., smp_mb(), as opposed to mb()) are/

> +kernel compiled for a UP system because the CPU orders overlapping accesses
> +with respect to itself, and so CPU barriers aren't needed.
> +
> +
> +INTERRUPTS
> +----------
> +
> +A driver may be interrupted by its own interrupt service routine, and thus they
> +may interfere with each other's attempts to control or access the device.
> +
> +This may be alleviated - at least in part - by disabling interrupts (a form of
> +locking), such that the critical operations are all contained within the
> +interrupt-disabled section in the driver.  Whilst the driver's interrupt
> +routine is executing, the driver's core may not run on the same CPU, and its
> +interrupt is not permitted to happen again until the current interrupt has been
> +handled, thus the interrupt handler does not need to lock against that.
> +
> +However, consider a driver was talking to an ethernet card that sports an
> +address register and a data register.  If that driver's core is talks to the
> +card under interrupt-disablement and then the driver's interrupt handler is
> +invoked:
> +
> +	LOCAL IRQ DISABLE
> +	writew(ADDR, ctl_reg_3);
> +	writew(DATA, y);
> +	LOCAL IRQ ENABLE
> +	<interrupt>
> +	writew(ADDR, ctl_reg_4);
> +	q = readw(DATA);
> +	</interrupt>
> +
> +If ordering rules are sufficiently relaxed, the write to the data register
> +might happen after the second write to the address register.
> +
> +If ordering rules are relaxed, it must be assumed that accesses done inside an
> +interrupt disabled section may leak outside of it and may interleave with
> +accesses performed in an interrupt and vice versa unless implicit or explicit
> +barriers are used.
> +
> +Normally this won't be a problem because the I/O accesses done inside such
> +sections will include synchronous read operations on strictly ordered I/O
> +registers that form implicit I/O barriers. If this isn't sufficient then an
> +mmiowb() may need to be used explicitly.
> +
> +
> +A similar situation may occur between an interrupt routine and two routines
> +running on separate CPUs that communicate with each other. If such a case is
> +likely, then interrupt-disabling locks should be used to guarantee ordering.
> +
> +
> +=================================
> +EXPLICIT KERNEL COMPILER BARRIERS
> +=================================
> +
> +The Linux kernel has an explicit compiler barrier function that prevents the
> +compiler from moving the memory accesses either side of it to the other side:
> +
> +	barrier();
> +
> +This has no direct effect on the CPU, which may then reorder things however it
> +wishes.
> +
> +
> +===============================
> +EXPLICIT KERNEL MEMORY BARRIERS
> +===============================
> +
> +The Linux kernel has eight basic CPU memory barriers:
> +
> +	TYPE		MANDATORY		SMP CONDITIONAL
> +	===============	=======================	===========================
> +	GENERAL		mb()			smp_mb()
> +	WRITE		wmb()			smp_wmb()
> +	READ		rmb()			smp_rmb()
> +	DATA DEPENDENCY	read_barrier_depends()	smp_read_barrier_depends()
> +
> +General memory barriers give a guarantee that all memory accesses specified
> +before the barrier will appear to happen before all memory accesses specified
> +after the barrier with respect to the other components of the system.
> +
> +Read and write memory barriers give similar guarantees, but only for memory
> +reads versus memory reads and memory writes versus memory writes respectively.
> +
> +Data dependency memory barriers ensure that if two reads are issued such that
> +the second depends on the result of the first, then the first read is completed
> +and the cache coherence is up to date before the second read is performed.  The
> +primary case is where the address used in a subsequent read is calculated from
> +the result of the first read:
> +
> +	CPU 1		CPU 2
> +	===============	===============
> +	{ a == 0, b == 1 and p == &a, q == &a }
> +	...
> +	b = 2;
> +	smp_wmb();
> +	p = &b;		q = p;
> +			smp_read_barrier_depends();
> +			d = *q;
> +
> +Without the data dependency barrier, any of the following results could be
> +seen:
> +
> +	POSSIBLE RESULT	PERMISSIBLE	ORIGIN
> +	===============	===============	=======================================
> +	q == &a, d == 0	Yes
> +	q == &b, d == 2	Yes
> +	q == &b, d == 1 No		Cache coherency maintenance delay

Either s/No/Yes/ in the preceding line, or s/Without/With/ earlier.  I
believe the former is better.  In absence of the smp_read_barrier_depends(),
you really -can- see the (q == &b, d == 1) case on DEC Alpha!!!  So the
preceding line should instead be:

+	q == &b, d == 1 Yes

This extremely counterintuitive situation arises most easily on machines
with split caches, so that (for example) one cache bank processes
even-numbered cache lines and the other bank processes odd-numbered
cache lines.  The pointer p might be stored in an odd-numbered cache
line, and the variable b might be stored in an even-numbered cache line.
Then, if the even-numbered bank of the reading CPU's cache is extremely
busy while the odd-numbered bank is idle, one can see the new value of
the pointer (&b), but the old value of the variable (1).

I must confess to having strenuously resisted this scenario when first
introduced to it, and Wayne Cardoza should be commended on his patience
in leading me through it...

Please see http://www.openvms.compaq.com/wizard/wiz_2637.html if you
think that I am making all this up!

This DEC-Alpha example is extremely important, since it defines Linux's
memory-barrier semantics.  I have some verbiage and diagrams in the
aforementioned PDF, feel free to use them.

> +	q == &b, d == 0	No		q read after a
> +
> +See the "Cache Coherency" section above.
> +
> +
> +All memory barriers imply compiler barriers.
> +
> +Read memory barriers imply data dependency barriers.
> +
> +SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
> +systems because it is assumed that a CPU will be apparently self-consistent,
> +and will order overlapping accesses correctly with respect to itself.

Suggest adding:

	However, mandatory memory barriers still have effect in
	uniprocessor kernel builds due to the need to correctly
	order reads and writes to device registers.

to this paragraph.

> +There is no guarantee that any of the memory accesses specified before a memory
> +barrier will be complete by the completion of a memory barrier; the barrier can
> +be considered to draw a line in that CPU's access queue that accesses of the
> +appropriate type may not cross.
> +
> +There is no guarantee that issuing a memory barrier on one CPU will have any
> +direct effect on another CPU or any other hardware in the system.  The indirect
> +effect will be the order in which the second CPU sees the effects of the first
> +CPU's accesses occur.

And the second CPU may need to execute memory barriers of its own to
reliably see the ordering effects.  Might be good to explicitly note this.

> +There is no guarantee that some intervening piece of off-the-CPU hardware[*]
> +will not reorder the memory accesses.  CPU cache coherency mechanisms should
> +propegate the indirect effects of a memory barrier between CPUs, but may not do

Suggest s/propegate/propagate/

> +so in order (see above).
> +
> + [*] For information on bus mastering DMA and coherency please read:
> +
> +	Documentation/pci.txt
> +	Documentation/DMA-mapping.txt
> +	Documentation/DMA-API.txt
> +
> +Note that these are the _minimum_ guarantees.  Different architectures may give
> +more substantial guarantees, but they may not be relied upon outside of arch
> +specific code.
> +
> +
> +There are some more advanced barrier functions:
> +
> + (*) set_mb(var, value)
> + (*) set_wmb(var, value)
> +
> +     These assign the value to the variable and then insert at least a write
> +     barrier after it, depending on the function.  They aren't guaranteed to
> +     insert anything more than a compiler barrier in a UP compilation.

smp_mb__before_atomic_dec() and friends as well?

> +BARRIER PAIRING
> +---------------

Great section, good how-to information!!!

> +Certain types of memory barrier should always be paired.  A lack of an
> +appropriate pairing is almost certainly an error.
> +
> +An smp_wmb() should always be paired with an smp_read_barrier_depends() or an
> +smp_rmb(), though an smp_mb() would also be acceptable.  Similarly an smp_rmb()
> +or an smp_read_barrier_depends() should always be paired with at least an
> +smp_wmb(), though, again, an smp_mb() is acceptable:
> +
> +	CPU 1		CPU 2		COMMENT
> +	===============	===============	=======================
> +	a = 1;
> +	smp_wmb();			Could be smp_mb()
> +	b = 2;
> +			x = a;
> +			smp_rmb();	Could be smp_mb()
> +			y = b;

Need to note that (for example) set_mb(), smp_mb__before_atomic_dec(),
and friends can stand in for smp_mb().  Similarly with related primitives.

> +The data dependency barrier - smp_read_barrier_depends() - is a very specific
> +optimisation.  It's a weaker form of the read memory barrier, for use in the
> +case where there's a dependency between two reads - since on some architectures
> +we can't rely on the CPU to imply a data dependency barrier.  The typical case
> +is where a read is used to generate an address for a subsequent memory access:
> +
> +	CPU 1		CPU 2				COMMENT
> +	===============	===============================	=======================
> +	a = 1;
> +	smp_wmb();					Could be smp_mb()
> +	b = &a;
> +			x = b;
> +			smp_read_barrier_depends();	Or smp_rmb()/smp_mb()
> +			y = *x;
> +
> +This is used in the RCU system.

Strictly speaking, this is not dependent on RCU, but probably close enough
for now...

Might be worth noting that array accesses are data-dependent on the
corresponding index.  Some architectures have more expansive definition
of data dependency, including then- and else-clauses being data-dependent
on the if-condition, but this is probably too much detail.

> +If the two reads are independent, an smp_read_barrier_depends() is not
> +sufficient, and an smp_rmb() or better must be employed.
> +
> +Basically, the read barrier always has to be there, even though it can be of
> +the "weaker" type.
> +
> +Note also that the address really has to have a _data_ dependency, not a
> +control dependency.  If the address is dependent on the first read, but the
> +dependency is through a conditional rather than actually reading the address
> +itself, then it's a control dependency, and existing CPU's already deal with
> +those through branch prediction.
> +
> +
> +===============================
> +IMPLICIT KERNEL MEMORY BARRIERS
> +===============================
> +
> +Some of the other functions in the linux kernel imply memory barriers, amongst
> +which are locking and scheduling functions.
> +
> +This specification is a _minimum_ guarantee; any particular architecture may
> +provide more substantial guarantees, but these may not be relied upon outside
> +of arch specific code.
> +
> +
> +LOCKING FUNCTIONS
> +-----------------
> +
> +The Linux kernel has a number of locking constructs:
> +
> + (*) spin locks
> + (*) R/W spin locks
> + (*) mutexes
> + (*) semaphores
> + (*) R/W semaphores
> +
> +In all cases there are variants on "LOCK" operations and "UNLOCK" operations
> +for each construct.  These operations all imply certain barriers:
> +
> + (*) LOCK operation implication:
> +
> +     Memory accesses issued after the LOCK will be completed after the LOCK
> +     accesses have completed.

Suggest s/accesses have/operation has/ here and below.

> +     Memory accesses issued before the LOCK may be completed after the LOCK
> +     accesses have completed.

Suggest making the consequence very clear, perhaps adding ", so that code
preceding a lock acquisition can "bleed" into the critical section".

> + (*) UNLOCK operation implication:
> +
> +     Memory accesses issued before the UNLOCK will be completed before the
> +     UNLOCK accesses have completed.
> +
> +     Memory accesses issued after the UNLOCK may be completed before the UNLOCK
> +     accesses have completed.

Again, suggest making the consequence very clear, perhaps adding ", so that
code following a lock release can "bleed into" the critical section".

> + (*) LOCK vs UNLOCK implication:
> +
> +     The LOCK accesses will be completed before the UNLOCK accesses.
> +
> +     Therefore an UNLOCK followed by a LOCK is equivalent to a full barrier,
> +     but a LOCK followed by an UNLOCK is not.
> +
> + (*) Failed conditional LOCK implication:
> +
> +     Certain variants of the LOCK operation may fail, either due to being
> +     unable to get the lock immediately, or due to receiving an unblocked
> +     signal whilst asleep waiting for the lock to become available.  Failed
> +     locks do not imply any sort of barrier.
> +
> +Locks and semaphores may not provide any guarantee of ordering on UP compiled
> +systems, and so cannot be counted on in such a situation to actually achieve
> +anything at all - especially with respect to I/O accesses - unless combined
> +with interrupt disabling operations.
> +
> +See also the section on "Inter-CPU locking barrier effects".
> +
> +
> +As an example, consider the following:
> +
> +	*A = a;
> +	*B = b;
> +	LOCK
> +	*C = c;
> +	*D = d;
> +	UNLOCK
> +	*E = e;
> +	*F = f;
> +
> +The following sequence of events is acceptable:
> +
> +	LOCK, {*F,*A}, *E, {*C,*D}, *B, UNLOCK
> +
> +But none of the following are:
> +
> +	{*F,*A}, *B,	LOCK, *C, *D,	UNLOCK, *E
> +	*A, *B, *C,	LOCK, *D,	UNLOCK, *E, *F
> +	*A, *B,		LOCK, *C,	UNLOCK, *D, *E, *F
> +	*B,		LOCK, *C, *D,	UNLOCK, {*F,*A}, *E
> +
> +
> +INTERRUPT DISABLING FUNCTIONS
> +-----------------------------
> +
> +Functions that disable interrupts (LOCK equivalent) and enable interrupts
> +(UNLOCK equivalent) will act as compiler barriers only.  So if memory or I/O
> +barriers are required in such a situation, they must be provided from some
> +other means.
> +
> +
> +MISCELLANEOUS FUNCTIONS
> +-----------------------
> +
> +Other functions that imply barriers:
> +
> + (*) schedule() and similar imply full memory barriers.
> +
> +
> +=================================
> +INTER-CPU LOCKING BARRIER EFFECTS
> +=================================
> +
> +On SMP systems locking primitives give a more substantial form of barrier: one
> +that does affect memory access ordering on other CPUs, within the context of
> +conflict on any particular lock.
> +
> +
> +LOCKS VS MEMORY ACCESSES
> +------------------------
> +
> +Consider the following: the system has a pair of spinlocks (N) and (Q), and
> +three CPUs; then should the following sequence of events occur:
> +
> +	CPU 1				CPU 2
> +	===============================	===============================
> +	*A = a;				*E = e;
> +	LOCK M				LOCK Q
> +	*B = b;				*F = f;
> +	*C = c;				*G = g;
> +	UNLOCK M			UNLOCK Q
> +	*D = d;				*H = h;
> +
> +Then there is no guarantee as to what order CPU #3 will see the accesses to *A
> +through *H occur in, other than the constraints imposed by the separate locks
> +on the separate CPUs. It might, for example, see:
> +
> +	*E, LOCK M, LOCK Q, *G, *C, *F, *A, *B, UNLOCK Q, *D, *H, UNLOCK M
> +
> +But it won't see any of:
> +
> +	*B, *C or *D preceding LOCK M
> +	*A, *B or *C following UNLOCK M
> +	*F, *G or *H preceding LOCK Q
> +	*E, *F or *G following UNLOCK Q
> +
> +
> +However, if the following occurs:
> +
> +	CPU 1				CPU 2
> +	===============================	===============================
> +	*A = a;
> +	LOCK M		[1]
> +	*B = b;
> +	*C = c;
> +	UNLOCK M	[1]
> +	*D = d;				*E = e;
> +					LOCK M		[2]
> +					*F = f;
> +					*G = g;
> +					UNLOCK M	[2]
> +					*H = h;
> +
> +CPU #3 might see:
> +
> +	*E, LOCK M [1], *C, *B, *A, UNLOCK M [1],
> +		LOCK M [2], *H, *F, *G, UNLOCK M [2], *D
> +
> +But assuming CPU #1 gets the lock first, it won't see any of:
> +
> +	*B, *C, *D, *F, *G or *H preceding LOCK M [1]
> +	*A, *B or *C following UNLOCK M [1]
> +	*F, *G or *H preceding LOCK M [2]
> +	*A, *B, *C, *E, *F or *G following UNLOCK M [2]
> +
> +
> +LOCKS VS I/O ACCESSES
> +---------------------
> +
> +Under certain circumstances (such as NUMA), I/O accesses within two spinlocked
> +sections on two different CPUs may be seen as interleaved by the PCI bridge.

Suggest adding something to the effect of ", because the PCI bridge is
not participating in the cache-coherence protocol, and therefore is
incapable of issuing the required read-side memory barriers."

> +For example:
> +
> +	CPU 1				CPU 2
> +	===============================	===============================
> +	spin_lock(Q)
> +	writel(0, ADDR)
> +	writel(1, DATA);
> +	spin_unlock(Q);
> +					spin_lock(Q);
> +					writel(4, ADDR);
> +					writel(5, DATA);
> +					spin_unlock(Q);
> +
> +may be seen by the PCI bridge as follows:
> +
> +	WRITE *ADDR = 0, WRITE *ADDR = 4, WRITE *DATA = 1, WRITE *DATA = 5
> +
> +which would probably break.
> +
> +What is necessary here is to insert an mmiowb() before dropping the spinlock,
> +for example:
> +
> +	CPU 1				CPU 2
> +	===============================	===============================
> +	spin_lock(Q)
> +	writel(0, ADDR)
> +	writel(1, DATA);
> +	mmiowb();
> +	spin_unlock(Q);
> +					spin_lock(Q);
> +					writel(4, ADDR);
> +					writel(5, DATA);
> +					mmiowb();
> +					spin_unlock(Q);
> +
> +this will ensure that the two writes issued on CPU #1 appear at the PCI bridge
> +before either of the writes issued on CPU #2.
> +
> +
> +Furthermore, following a write by a read to the same device is okay, because
> +the read forces the write to complete before the read is performed:
> +
> +	CPU 1				CPU 2
> +	===============================	===============================
> +	spin_lock(Q)
> +	writel(0, ADDR)
> +	a = readl(DATA);
> +	spin_unlock(Q);
> +					spin_lock(Q);
> +					writel(4, ADDR);
> +					b = readl(DATA);
> +					spin_unlock(Q);
> +
> +
> +See Documentation/DocBook/deviceiobook.tmpl for more information.
> +
> +
> +==========================
> +KERNEL I/O BARRIER EFFECTS
> +==========================
> +
> +When accessing I/O memory, drivers should use the appropriate accessor
> +functions:
> +
> + (*) inX(), outX():
> +
> +     These are intended to talk to I/O space rather than memory space, but
> +     that's primarily a CPU-specific concept. The i386 and x86_64 processors do
> +     indeed have special I/O space access cycles and instructions, but many
> +     CPUs don't have such a concept.
> +
> +     The PCI bus, amongst others, defines an I/O space concept - which on such
> +     CPUs as i386 and x86_64 cpus readily maps to the CPU's concept of I/O
> +     space.  However, it may also mapped as a virtual I/O space in the CPU's
> +     memory map, particularly on those CPUs that don't support alternate
> +     I/O spaces.
> +
> +     Accesses to this space may be fully synchronous (as on i386), but
> +     intermediary bridges (such as the PCI host bridge) may not fully honour
> +     that.
> +
> +     They are guaranteed to be fully ordered with respect to each other.
> +
> +     They are not guaranteed to be fully ordered with respect to other types of
> +     memory and I/O operation.
> +
> + (*) readX(), writeX():
> +
> +     Whether these are guaranteed to be fully ordered and uncombined with
> +     respect to each other on the issuing CPU depends on the characteristics
> +     defined for the memory window through which they're accessing. On later
> +     i386 architecture machines, for example, this is controlled by way of the
> +     MTRR registers.
> +
> +     Ordinarily, these will be guaranteed to be fully ordered and uncombined,,
> +     provided they're not accessing a prefetchable device.
> +
> +     However, intermediary hardware (such as a PCI bridge) may indulge in
> +     deferral if it so wishes; to flush a write, a read from the same location
> +     is preferred[*], but a read from the same device or from configuration
> +     space should suffice for PCI.
> +
> +     [*] NOTE! attempting to read from the same location as was written to may
> +     	 cause a malfunction - consider the 16550 Rx/Tx serial registers for
> +     	 example.
> +
> +     Used with prefetchable I/O memory, an mmiowb() barrier may be required to
> +     force writes to be ordered.
> +
> +     Please refer to the PCI specification for more information on interactions
> +     between PCI transactions.
> +
> + (*) readX_relaxed()
> +
> +     These are similar to readX(), but are not guaranteed to be ordered in any
> +     way. Be aware that there is no I/O read barrier available.
> +
> + (*) ioreadX(), iowriteX()
> +
> +     These will perform as appropriate for the type of access they're actually
> +     doing, be it inX()/outX() or readX()/writeX().
> +
> +
> +==========
> +REFERENCES
> +==========

Suggest adding:

Alpha AXP Architecture Reference Manual, Second Edition (Sites & Witek,
Digital Press)
	Chapter 5.2: Physical Address Space Characteristics
	Chapter 5.4: Caches and Write Buffers
	Chapter 5.5: Data Sharing
	Chapter 5.6: Read/Write Ordering

> +AMD64 Architecture Programmer's Manual Volume 2: System Programming
> +	Chapter 7.1: Memory-Access Ordering
> +	Chapter 7.4: Buffering and Combining Memory Writes
> +
> +IA-32 Intel Architecture Software Developer's Manual, Volume 3:
> +System Programming Guide
> +	Chapter 7.1: Locked Atomic Operations
> +	Chapter 7.2: Memory Ordering
> +	Chapter 7.4: Serializing Instructions
> +
> +The SPARC Architecture Manual, Version 9
> +	Chapter 8: Memory Models
> +	Appendix D: Formal Specification of the Memory Models
> +	Appendix J: Programming with the Memory Models
> +
> +UltraSPARC Programmer Reference Manual
> +	Chapter 5: Memory Accesses and Cacheability
> +	Chapter 15: Sparc-V9 Memory Models
> +
> +UltraSPARC III Cu User's Manual
> +	Chapter 9: Memory Models
> +
> +UltraSPARC IIIi Processor User's Manual
> +	Chapter 8: Memory Models
> +
> +UltraSPARC Architecture 2005
> +	Chapter 9: Memory
> +	Appendix D: Formal Specifications of the Memory Models
> +
> +UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005
> +	Chapter 8: Memory Models
> +	Appendix F: Caches and Cache Coherency
> +
> +Solaris Internals, Core Kernel Architecture, p63-68:
> +	Chapter 3.3: Hardware Considerations for Locks and
> +			Synchronization
> +
> +Unix Systems for Modern Architectures, Symmetric Multiprocessing and Caching
> +for Kernel Programmers:
> +	Chapter 13: Other Memory Models
> +
> +Intel Itanium Architecture Software Developer's Manual: Volume 1:
> +	Section 2.6: Speculation
> +	Section 4.4: Memory Access
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
