Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWCHOiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWCHOiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCHOiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:38:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7623 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751415AbWCHOiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:38:15 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com> 
References: <31492.1141753245@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com
Cc: linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Document Linux's memory barriers [try #2]
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 14:37:58 +0000
Message-ID: <29826.1141828678@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch documents the Linux kernel's memory barriers.

I've updated it from the comments I've been given.

Note that the per-arch notes sections are gone because it's clear that there
are so many exceptions, that it's not worth having them.

I've added a list of references to other documents.

I've tried to get rid of the concept of memory accesses appearing on the bus;
what matters is apparent behaviour with respect to other observers in the
system.

I'm not sure that any mention interrupts vs interrupt disablement should be
retained... it's unclear that there is actually anything that guarantees that
stuff won't leak out of an interrupt-disabled section and into an interrupt
handler. Paul Mackerras says this isn't valid on powerpc, and looking at the
code seems to confirm that, barring implicit enforcement by the CPU.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/mb.diff 
 Documentation/memory-barriers.txt |  589 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 589 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
new file mode 100644
index 0000000..1340c8d
--- /dev/null
+++ b/Documentation/memory-barriers.txt
@@ -0,0 +1,589 @@
+			 ============================
+			 LINUX KERNEL MEMORY BARRIERS
+			 ============================
+
+Contents:
+
+ (*) What are memory barriers?
+
+ (*) Where are memory barriers needed?
+
+     - Accessing devices.
+     - Multiprocessor interaction.
+     - Interrupts.
+
+ (*) Linux kernel compiler barrier functions.
+
+ (*) Linux kernel memory barrier functions.
+
+ (*) Implicit kernel memory barriers.
+
+     - Locking functions.
+     - Interrupt disablement functions.
+     - Miscellaneous functions.
+
+ (*) Linux kernel I/O barriering.
+
+ (*) References.
+
+
+=========================
+WHAT ARE MEMORY BARRIERS?
+=========================
+
+Memory barriers are instructions to both the compiler and the CPU to impose an
+apparent partial ordering between the memory access operations specified either
+side of the barrier.  They request that the sequence of memory events generated
+appears to other components of the system as if the barrier is effective on
+that CPU.
+
+Note that:
+
+ (*) there's no guarantee that the sequence of memory events is _actually_ so
+     ordered.  It's possible for the CPU to do out-of-order accesses _as long
+     as no-one is looking_, and then fix up the memory if someone else tries to
+     see what's going on (for instance a bus master device); what matters is
+     the _apparent_ order as far as other processors and devices are concerned;
+     and
+
+ (*) memory barriers are only guaranteed to act within the CPU processing them,
+     and are not, for the most part, guaranteed to percolate down to other CPUs
+     in the system or to any I/O hardware that that CPU may communicate with.
+
+
+For example, a programmer might take it for granted that the CPU will perform
+memory accesses in exactly the order specified, so that if a CPU is, for
+example, given the following piece of code:
+
+	a = *A;
+	*B = b;
+	c = *C;
+	d = *D;
+	*E = e;
+
+They would then expect that the CPU will complete the memory access for each
+instruction before moving on to the next one, leading to a definite sequence of
+operations as seen by external observers in the system:
+
+	read *A, write *B, read *C, read *D, write *E.
+
+
+Reality is, of course, much messier.  With many CPUs and compilers, this isn't
+always true because:
+
+ (*) reads are more likely to need to be completed immediately to permit
+     execution progress, whereas writes can often be deferred without a
+     problem;
+
+ (*) reads can be done speculatively, and then the result discarded should it
+     prove not to be required;
+
+ (*) the order of the memory accesses may be rearranged to promote better use
+     of the CPU buses and caches;
+
+ (*) reads and writes may be combined to improve performance when talking to
+     the memory or I/O hardware that can do batched accesses of adjacent
+     locations, thus cutting down on transaction setup costs (memory and PCI
+     devices may be able to do this); and
+
+ (*) the CPU's data cache may affect the ordering, though cache-coherency
+     mechanisms should alleviate this - once the write has actually hit the
+     cache.
+
+So what another CPU, say, might actually observe from the above piece of code
+is:
+
+	read *A, read {*C,*D}, write *E, write *B
+
+	(By "read {*C,*D}" I mean a combined single read).
+
+
+It is also guaranteed that a CPU will be self-consistent: it will see its _own_
+accesses appear to be correctly ordered, without the need for a memory
+barrier.  For instance with the following code:
+
+	X = *A;
+	*A = Y;
+	Z = *A;
+
+assuming no intervention by an external influence, it can be taken that:
+
+ (*) X will hold the old value of *A, and will never happen after the write and
+     thus end up being given the value that was assigned to *A from Y instead;
+     and
+
+ (*) Z will always be given the value in *A that was assigned there from Y, and
+     will never happen before the write, and thus end up with the same value
+     that was in *A initially.
+
+(This is ignoring the fact that the value initially in *A may appear to be the
+same as the value assigned to *A from Y).
+
+
+=================================
+WHERE ARE MEMORY BARRIERS NEEDED?
+=================================
+
+Under normal operation, access reordering is probably not going to be a problem
+as a linear program will still appear to operate correctly.  There are,
+however, three circumstances where reordering definitely _could_ be a problem:
+
+
+ACCESSING DEVICES
+-----------------
+
+Many devices can be memory mapped, and so appear to the CPU as if they're just
+memory locations.  However, to control the device, the driver has to make the
+right accesses in exactly the right order.
+
+Consider, for example, an ethernet chipset such as the AMD PCnet32.  It
+presents to the CPU an "address register" and a bunch of "data registers".  The
+way it's accessed is to write the index of the internal register to be accessed
+to the address register, and then read or write the appropriate data register
+to access the chip's internal register, which could - theoretically - be done
+by:
+
+	*ADR = ctl_reg_3;
+	reg = *DATA;
+
+The problem with a clever CPU or a clever compiler is that the write to the
+address register isn't guaranteed to happen before the access to the data
+register, if the CPU or the compiler thinks it is more efficient to defer the
+address write:
+
+	read *DATA, write *ADR
+
+then things will break.
+
+
+In the Linux kernel, however, I/O should be done through the appropriate
+accessor routines - such as inb() or writel() - which know how to make such
+accesses appropriately sequential.
+
+On some systems, I/O writes are not strongly ordered across all CPUs, and so
+locking should be used, and mmiowb() should be issued prior to unlocking the
+critical section.
+
+See Documentation/DocBook/deviceiobook.tmpl for more information.
+
+
+MULTIPROCESSOR INTERACTION
+--------------------------
+
+When there's a system with more than one processor, these may be working on the
+same set of data, but attempting not to use locks as locks are quite expensive.
+This means that accesses that affect both CPUs may have to be carefully ordered
+to prevent error.
+
+Consider the R/W semaphore slow path.  In that, a waiting process is queued on
+the semaphore, as noted by it having a record on its stack linked to the
+semaphore's list:
+
+	struct rw_semaphore {
+		...
+		struct list_head waiters;
+	};
+
+	struct rwsem_waiter {
+		struct list_head list;
+		struct task_struct *task;
+	};
+
+To wake up the waiter, the up_read() or up_write() functions have to read the
+pointer from this record to know as to where the next waiter record is, clear
+the task pointer, call wake_up_process() on the task, and release the reference
+held on the waiter's task struct:
+
+	READ waiter->list.next;
+	READ waiter->task;
+	WRITE waiter->task;
+	CALL wakeup
+	RELEASE task
+
+If any of these steps occur out of order, then the whole thing may fail.
+
+Note that the waiter does not get the semaphore lock again - it just waits for
+its task pointer to be cleared.  Since the record is on its stack, this means
+that if the task pointer is cleared _before_ the next pointer in the list is
+read, another CPU might start processing the waiter and it might clobber its
+stack before up*() functions have a chance to read the next pointer.
+
+	CPU 0				CPU 1
+	===============================	===============================
+					down_xxx()
+					Queue waiter
+					Sleep
+	up_yyy()
+	READ waiter->task;
+	WRITE waiter->task;
+	<preempt>
+					Resume processing
+					down_xxx() returns
+					call foo()
+					foo() clobbers *waiter
+	</preempt>
+	READ waiter->list.next;
+	--- OOPS ---
+
+This could be dealt with using a spinlock, but then the down_xxx() function has
+to get the spinlock again after it's been woken up, which is a waste of
+resources.
+
+The way to deal with this is to insert an SMP memory barrier:
+
+	READ waiter->list.next;
+	READ waiter->task;
+	smp_mb();
+	WRITE waiter->task;
+	CALL wakeup
+	RELEASE task
+
+In this case, the barrier makes a guarantee that all memory accesses before the
+barrier will appear to happen before all the memory accesses after the barrier
+with respect to the other CPUs on the system.  It does _not_ guarantee that all
+the memory accesses before the barrier will be complete by the time the barrier
+itself is complete.
+
+SMP memory barriers are normally mere compiler barriers on a UP system because
+the CPU orders overlapping accesses with respect to itself.
+
+
+INTERRUPTS
+----------
+
+A driver may be interrupted by its own interrupt service routine, and thus they
+may interfere with each other's attempts to control or access the device.
+
+This may be alleviated - at least in part - by disabling interrupts (a form of
+locking), such that the critical operations are all contained within the
+disabled-interrupt section in the driver.  Whilst the driver's interrupt
+routine is executing, the driver's core may not run on the same CPU, and its
+interrupt is not permitted to happen again until the current interrupt has been
+handled, thus the interrupt handler does not need to lock against that.
+
+
+However, consider the following example:
+
+	CPU 1				CPU 2
+	===============================	===============================
+	[A is 0 and B is 0]
+	DISABLE IRQ
+	*A = 1;
+	smp_wmb();
+	*B = 2;
+	ENABLE IRQ
+	<interrupt>
+	*A = 3
+					a = *A;
+					b = *B;
+	smp_wmb();
+	*B = 4;
+	</interrupt>
+
+CPU 2 might see *A == 3 and *B == 0, when what it probably ought to see is *B
+== 2 and *A == 1 or *A == 3, or *B == 4 and *A == 3.
+
+This might happen because the write "*B = 2" might occur after the write "*A =
+3" - in which case the former write has leaked from the interrupt-disabled
+section into the interrupt handler. In this case it is a lock of some
+description should very probably be used.
+
+
+This sort of problem might also occur with relaxed I/O ordering rules, if it's
+permitted for I/O writes to cross.  For instance, if a driver was talking to an
+ethernet card that sports an address register and a data register:
+
+	DISABLE IRQ
+	writew(ADR, ctl_reg_3);
+	writew(DATA, y);
+	ENABLE IRQ
+	<interrupt>
+	writew(ADR, ctl_reg_4);
+	q = readw(DATA);
+	</interrupt>
+
+In such a case, an mmiowb() is needed, firstly to prevent the first write to
+the address register from occurring after the write to the data register, and
+secondly to prevent the write to the data register from happening after the
+second write to the address register.
+
+
+=======================================
+LINUX KERNEL COMPILER BARRIER FUNCTIONS
+=======================================
+
+The Linux kernel has an explicit compiler barrier function that prevents the
+compiler from moving the memory accesses either side of it to the other side:
+
+	barrier();
+
+This has no direct effect on the CPU, which may then reorder things however it
+wishes.
+
+In addition, accesses to "volatile" memory locations and volatile asm
+statements act as implicit compiler barriers.
+
+
+=====================================
+LINUX KERNEL MEMORY BARRIER FUNCTIONS
+=====================================
+
+The Linux kernel has six basic CPU memory barriers:
+
+		MANDATORY	SMP CONDITIONAL
+		===============	===============
+	GENERAL	mb()		smp_mb()
+	READ	rmb()		smp_rmb()
+	WRITE	wmb()		smp_wmb()
+
+General memory barriers give a guarantee that all memory accesses specified
+before the barrier will appear to happen before all memory accesses specified
+after the barrier with respect to the other components of the system.
+
+Read and write memory barriers give similar guarantees, but only for memory
+reads versus memory reads and memory writes versus memory writes respectively.
+
+All memory barriers imply compiler barriers.
+
+SMP memory barriers are only compiler barriers on uniprocessor compiled systems
+because it is assumed that a CPU will be apparently self-consistent, and will
+order overlapping accesses correctly with respect to itself.
+
+There is no guarantee that any of the memory accesses specified before a memory
+barrier will be complete by the completion of a memory barrier; the barrier can
+be considered to draw a line in that CPU's access queue that accesses of the
+appropriate type may not cross.
+
+There is no guarantee that issuing a memory barrier on one CPU will have any
+direct effect on another CPU or any other hardware in the system.  The indirect
+effect will be the order in which the second CPU sees the first CPU's accesses
+occur.
+
+There is no guarantee that some intervening piece of off-the-CPU hardware will
+not reorder the memory accesses.  CPU cache coherency mechanisms should
+propegate the indirect effects of a memory barrier between CPUs.
+
+Note that these are the _minimum_ guarantees.  Different architectures may give
+more substantial guarantees, but they may not be relied upon outside of arch
+specific code.
+
+
+There are some more advanced barriering functions:
+
+ (*) set_mb(var, value)
+ (*) set_wmb(var, value)
+
+     These assign the value to the variable and then insert at least a write
+     barrier after it, depending on the function.
+
+
+===============================
+IMPLICIT KERNEL MEMORY BARRIERS
+===============================
+
+Some of the other functions in the linux kernel imply memory barriers, amongst
+them are locking and scheduling functions and interrupt management functions.
+
+This specification is a _minimum_ guarantee; any particular architecture may
+provide more substantial guarantees, but these may not be relied upon outside
+of arch specific code.
+
+
+LOCKING FUNCTIONS
+-----------------
+
+For instance all the following locking functions imply barriers:
+
+ (*) spin locks
+ (*) R/W spin locks
+ (*) mutexes
+ (*) semaphores
+ (*) R/W semaphores
+
+In all cases there are variants on a LOCK operation and an UNLOCK operation.
+
+ (*) LOCK operation implication:
+
+     Memory accesses issued after the LOCK will be completed after the LOCK
+     accesses have completed.
+
+     Memory accesses issued before the LOCK may be completed after the LOCK
+     accesses have completed.
+
+ (*) UNLOCK operation implication:
+
+     Memory accesses issued before the UNLOCK will be completed before the
+     UNLOCK accesses have completed.
+
+     Memory accesses issued after the UNLOCK may be completed before the UNLOCK
+     accesses have completed.
+
+ (*) LOCK vs UNLOCK implication:
+
+     The LOCK accesses will be completed before the UNLOCK accesses.
+
+And therefore an UNLOCK followed by a LOCK is equivalent to a full barrier, but
+a LOCK followed by an UNLOCK isn't.
+
+Locks and semaphores may not provide any guarantee of ordering on UP compiled
+systems, and so can't be counted on in such a situation to actually do anything
+at all, especially with respect to I/O barriering, unless combined with
+interrupt disablement operations.
+
+
+As an example, consider the following:
+
+	*A = a;
+	*B = b;
+	LOCK
+	*C = c;
+	*D = d;
+	UNLOCK
+	*E = e;
+	*F = f;
+
+The following sequence of events is acceptable:
+
+	LOCK, {*F,*A}, *E, {*C,*D}, *B, UNLOCK
+
+But none of the following are:
+
+	{*F,*A}, *B,	LOCK, *C, *D,	UNLOCK, *E
+	*A, *B, *C,	LOCK, *D,	UNLOCK, *E, *F
+	*A, *B,		LOCK, *C,	UNLOCK, *D, *E, *F
+	*B,		LOCK, *C, *D,	UNLOCK, {*F,*A}, *E
+
+
+INTERRUPT DISABLEMENT FUNCTIONS
+-------------------------------
+
+Interrupt disablement (LOCK equivalent) and enablement (UNLOCK equivalent) will
+barrier memory and I/O accesses versus memory and I/O accesses done in the
+interrupt handler.  This prevents an interrupt routine interfering with
+accesses made in a disabled-interrupt section of code and vice versa.
+
+Note that whilst interrupt disablement barriers all act as compiler barriers,
+they only act as memory barriers with respect to interrupts, not with respect
+to nested sections.
+
+Consider the following:
+
+	<interrupt>
+	*X = x;
+	</interrupt>
+	*A = a;
+	SAVE IRQ AND DISABLE
+	*B = b;
+	SAVE IRQ AND DISABLE
+	*C = c;
+	RESTORE IRQ
+	*D = d;
+	RESTORE IRQ
+	*E = e;
+	<interrupt>
+	*Y = y;
+	</interrupt>
+
+It is acceptable to observe the following sequences of events:
+
+	{ INT, *X }, *A, SAVE, *B, SAVE, *C, REST, *D, REST, *E, { INT, *Y }
+	{ INT, *X }, *A, SAVE, *B, SAVE, *C, REST, *D, REST, { INT, *Y, *E }
+	{ INT, *X }, SAVE, SAVE, *A, *B, *C, *D, *E, REST, REST, { INT, *Y }
+	{ INT }, *X, SAVE, SAVE, *A, *B, *C, *D, *E, REST, REST, { INT, *Y }
+	{ INT }, *A, *X, SAVE, SAVE, *B, *C, *D, *E, REST, REST, { INT, *Y }
+
+But not the following:
+
+	{ INT }, SAVE, *A, *B, *X, SAVE, *C, REST, *D, REST, *E, { INT, *Y }
+	{ INT, *X }, *A, SAVE, *B, SAVE, *C, REST, REST, { INT, *Y, *D, *E }
+
+
+MISCELLANEOUS FUNCTIONS
+-----------------------
+
+Other functions that imply barriers:
+
+ (*) schedule() and similar imply full memory barriers.
+
+
+===========================
+LINUX KERNEL I/O BARRIERING
+===========================
+
+When accessing I/O memory, drivers should use the appropriate accessor
+functions:
+
+ (*) inX(), outX():
+
+     These are intended to talk to legacy i386 hardware using an alternate bus
+     addressing mode.  They are synchronous as far as the x86 CPUs are
+     concerned, but other CPUs and intermediary bridges may not honour that.
+
+     They are guaranteed to be fully ordered with respect to each other.
+
+ (*) readX(), writeX():
+
+     These are guaranteed to be fully ordered and uncombined with respect to
+     each other on the issuing CPU, provided they're not accessing a
+     prefetchable device.  However, intermediary hardware (such as a PCI
+     bridge) may indulge in deferral if it so wishes; to flush a write, a read
+     from the same location must be performed.
+
+     Used with prefetchable I/O memory, an mmiowb() barrier may be required to
+     force writes to be ordered.
+
+ (*) readX_relaxed()
+
+     These are not guaranteed to be ordered in any way. There is no I/O read
+     barrier available.
+
+ (*) ioreadX(), iowriteX()
+
+     These will perform as appropriate for the type of access they're actually
+     doing, be it in/out or read/write.
+
+
+==========
+REFERENCES
+==========
+
+AMD64 Architecture Programmer's Manual Volume 2: System Programming
+	Chapter 7.1: Memory-Access Ordering
+	Chapter 7.4: Buffering and Combining Memory Writes
+
+IA-32 Intel Architecture Software Developer's Manual, Volume 3:
+System Programming Guide
+	Chapter 7.1: Locked Atomic Operations
+	Chapter 7.2: Memory Ordering
+	Chapter 7.4: Serializing Instructions
+
+The SPARC Architecture Manual, Version 9
+	Chapter 8: Memory Models
+	Appendix D: Formal Specification of the Memory Models
+	Appendix J: Programming with the Memory Models
+
+UltraSPARC Programmer Reference Manual
+	Chapter 5: Memory Accesses and Cacheability
+	Chapter 15: Sparc-V9 Memory Models
+
+UltraSPARC III Cu User's Manual
+	Chapter 9: Memory Models
+
+UltraSPARC IIIi Processor User's Manual
+	Chapter 8: Memory Models
+
+UltraSPARC Architecture 2005
+	Chapter 9: Memory
+	Appendix D: Formal Specifications of the Memory Models
+
+UltraSPARC T1 Supplment to the UltraSPARC Architecture 2005
+	Chapter 8: Memory Models
+	Appendix F: Caches and Cache Coherency
+
+Solaris Internals, Core Kernel Architecture, p63-68:
+	Chapter 3.3: Hardware Considerations for Locks and
+			Synchronization
+
+Unix Systems for Modern Architectures, Symmetric Multiprocessing and Caching
+for Kernel Programmers:
+	Chapter 13: Other Memory Models
