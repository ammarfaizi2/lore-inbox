Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWCGRk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWCGRk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWCGRk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:40:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751407AbWCGRk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:40:57 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
cc: linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Document Linux's memory barriers
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 17:40:45 +0000
Message-ID: <31492.1141753245@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch documents the Linux kernel's memory barriers.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mb.diff 
 Documentation/memory-barriers.txt |  359 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 359 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
new file mode 100644
index 0000000..c2fc51b
--- /dev/null
+++ b/Documentation/memory-barriers.txt
@@ -0,0 +1,359 @@
+			 ============================
+			 LINUX KERNEL MEMORY BARRIERS
+			 ============================
+
+Contents:
+
+ (*) What are memory barriers?
+
+ (*) Linux kernel memory barrier functions.
+
+ (*) Implied kernel memory barriers.
+
+ (*) i386 and x86_64 arch specific notes.
+
+
+=========================
+WHAT ARE MEMORY BARRIERS?
+=========================
+
+Memory barriers are instructions to both the compiler and the CPU to impose a
+partial ordering between the memory access operations specified either side of
+the barrier.
+
+Older and less complex CPUs will perform memory accesses in exactly the order
+specified, so if one is given the following piece of code:
+
+	a = *A;
+	*B = b;
+	c = *C;
+	d = *D;
+	*E = e;
+
+It can be guaranteed that it will complete the memory access for each
+instruction before moving on to the next line, leading to a definite sequence
+of operations on the bus:
+
+	read *A, write *B, read *C, read *D, write *E.
+
+However, with newer and more complex CPUs, this isn't always true because:
+
+ (*) they can rearrange the order of the memory accesses to promote better use
+     of the CPU buses and caches;
+
+ (*) reads are synchronous and may need to be done immediately to permit
+     progress, whereas writes can often be deferred without a problem;
+
+ (*) and they are able to combine reads and writes to improve performance when
+     talking to the SDRAM (modern SDRAM chips can do batched accesses of
+     adjacent locations, cutting down on transaction setup costs).
+
+So what you might actually get from the above piece of code is:
+
+	read *A, read *C+*D, write *E, write *B
+
+Under normal operation, this is probably not going to be a problem; however,
+there are two circumstances where it definitely _can_ be a problem:
+
+ (1) I/O
+
+     Many I/O devices can be memory mapped, and so appear to the CPU as if
+     they're just memory locations. However, to control the device, the driver
+     has to make the right accesses in exactly the right order.
+
+     Consider, for example, an ethernet chipset such as the AMD PCnet32. It
+     presents to the CPU an "address register" and a bunch of "data registers".
+     The way it's accessed is to write the index of the internal register you
+     want to access to the address register, and then read or write the
+     appropriate data register to access the chip's internal register:
+
+	*ADR = ctl_reg_3;
+	reg = *DATA;
+
+     The problem with a clever CPU or a clever compiler is that the write to
+     the address register isn't guaranteed to happen before the access to the
+     data register, if the CPU or the compiler thinks it is more efficient to
+     defer the address write:
+
+	read *DATA, write *ADR
+
+     then things will break.
+
+     The way to deal with this is to insert an I/O memory barrier between the
+     two accesses:
+
+	*ADR = ctl_reg_3;
+	mb();
+	reg = *DATA;
+
+     In this case, the barrier makes a guarantee that all memory accesses
+     before the barrier will happen before all the memory accesses after the
+     barrier. It does _not_ guarantee that all memory accesses before the
+     barrier will be complete by the time the barrier is complete.
+
+ (2) Multiprocessor interaction
+
+     When there's a system with more than one processor, these may be working
+     on the same set of data, but attempting not to use locks as locks are
+     quite expensive. This means that accesses that affect both CPUs may have
+     to be carefully ordered to prevent error.
+
+     Consider the R/W semaphore slow path. In that, a waiting process is
+     queued on the semaphore, as noted by it having a record on its stack
+     linked to the semaphore's list:
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
+     To wake up the waiter, the up_read() or up_write() functions have to read
+     the pointer from this record to know as to where the next waiter record
+     is, clear the task pointer, call wake_up_process() on the task, and
+     release the task struct reference held:
+
+	READ waiter->list.next;
+	READ waiter->task;
+	WRITE waiter->task;
+	CALL wakeup
+	RELEASE task
+
+     If any of these steps occur out of order, then the whole thing may fail.
+
+     Note that the waiter does not get the semaphore lock again - it just waits
+     for its task pointer to be cleared. Since the record is on its stack, this
+     means that if the task pointer is cleared _before_ the next pointer in the
+     list is read, then another CPU might start processing the waiter and it
+     might clobber its stack before up*() functions have a chance to read the
+     next pointer.
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
+     This could be dealt with using a spinlock, but then the down_xxx()
+     function has to get the spinlock again after it's been woken up, which is
+     a waste of resources.
+
+     The way to deal with this is to insert an SMP memory barrier:
+
+	READ waiter->list.next;
+	READ waiter->task;
+	smp_mb();
+	WRITE waiter->task;
+	CALL wakeup
+	RELEASE task
+
+     In this case, the barrier makes a guarantee that all memory accesses
+     before the barrier will happen before all the memory accesses after the
+     barrier. It does _not_ guarantee that all memory accesses before the
+     barrier will be complete by the time the barrier is complete.
+
+     SMP memory barriers are normally no-ops on a UP system because the CPU
+     orders overlapping accesses with respect to itself.
+
+
+=====================================
+LINUX KERNEL MEMORY BARRIER FUNCTIONS
+=====================================
+
+The Linux kernel has six basic memory barriers:
+
+		MANDATORY (I/O)	SMP
+		===============	================
+	GENERAL	mb()		smp_mb()
+	READ	rmb()		smp_rmb()
+	WRITE	wmb()		smp_wmb()
+
+General memory barriers make a guarantee that all memory accesses specified
+before the barrier will happen before all memory accesses specified after the
+barrier.
+
+Read memory barriers make a guarantee that all memory reads specified before
+the barrier will happen before all memory reads specified after the barrier.
+
+Write memory barriers make a guarantee that all memory writes specified before
+the barrier will happen before all memory writes specified after the barrier.
+
+SMP memory barriers are no-ops on uniprocessor compiled systems because it is
+assumed that a CPU will be self-consistent, and will order overlapping accesses
+with respect to itself.
+
+There is no guarantee that any of the memory accesses specified before a memory
+barrier will be complete by the completion of a memory barrier; the barrier can
+be considered to draw a line in the access queue that accesses of the
+appropriate type may not cross.
+
+There is no guarantee that issuing a memory barrier on one CPU will have any
+direct effect on another CPU or any other hardware in the system. The indirect
+effect will be the order the first CPU commits its accesses to the bus.
+
+Note that these are the _minimum_ guarantees. Different architectures may give
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
+==============================
+IMPLIED KERNEL MEMORY BARRIERS
+==============================
+
+Some of the other functions in the linux kernel imply memory barriers. For
+instance all the following (pseudo-)locking functions imply barriers.
+
+ (*) interrupt disablement and/or interrupts
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
+     The LOCK accesses will be completed before the unlock accesses.
+
+Locks and semaphores may not provide any guarantee of ordering on UP compiled
+systems, and so can't be counted on in such a situation to actually do
+anything at all, especially with respect to I/O memory barriering.
+
+Either interrupt disablement (LOCK) and enablement (UNLOCK) will barrier
+memory and I/O accesses individually, or interrupt handling will barrier
+memory and I/O accesses on entry and on exit. This prevents an interrupt
+routine interfering with accesses made in a disabled-interrupt section of code
+and vice versa.
+
+This specification is a _minimum_ guarantee; any particular architecture may
+provide more substantial guarantees, but these may not be relied upon outside
+of arch specific code.
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
+The following sequence of events on the bus is acceptable:
+
+	LOCK, *F+*A, *E, *C+*D, *B, UNLOCK
+
+But none of the following are:
+
+	*F+*A, *B,	LOCK, *C, *D,	UNLOCK, *E
+	*A, *B, *C,	LOCK, *D,	UNLOCK, *E, *F
+	*A, *B,		LOCK, *C,	UNLOCK, *D, *E, *F
+	*B,		LOCK, *C, *D,	UNLOCK, *F+*A, *E
+
+
+Consider also the following (going back to the AMD PCnet example):
+
+	DISABLE IRQ
+	*ADR = ctl_reg_3;
+	mb();
+	x = *DATA;
+	*ADR = ctl_reg_4;
+	mb();
+	*DATA = y;
+	*ADR = ctl_reg_5;
+	mb();
+	z = *DATA;
+	ENABLE IRQ
+	<interrupt>
+	*ADR = ctl_reg_7;
+	mb();
+	q = *DATA
+	</interrupt>
+
+What's to stop "z = *DATA" crossing "*ADR = ctl_reg_7" and reading from the
+wrong register? (There's no guarantee that the process of handling an
+interrupt will barrier memory accesses in any way).
+
+
+==============================
+I386 AND X86_64 SPECIFIC NOTES
+==============================
+
+Earlier i386 CPUs (pre-Pentium-III) are fully ordered - the operations on the
+bus appear in program order - and so there's no requirement for any sort of
+explicit memory barriers.
+
+From the Pentium-III onwards were three new memory barrier instructions:
+LFENCE, SFENCE and MFENCE which correspond to the kernel memory barrier
+functions rmb(), wmb() and mb(). However, there are additional implicit memory
+barriers in the CPU implementation:
+
+ (*) Interrupt processing implies mb().
+
+ (*) The LOCK prefix adds implication of mb() on whatever instruction it is
+     attached to.
+
+ (*) Normal writes to memory imply wmb() [and so SFENCE is normally not
+     required].
+
+ (*) Normal writes imply a semi-rmb(): reads before a write may not complete
+     after that write, but reads after a write may complete before the write
+     (ie: reads may go _ahead_ of writes).
+
+ (*) Non-temporal writes imply no memory barrier, and are the intended target
+     of SFENCE.
+
+ (*) Accesses to uncached memory imply mb() [eg: memory mapped I/O].
+
+
+======================
+POWERPC SPECIFIC NOTES
+======================
+
+The powerpc is weakly ordered, and its read and write accesses may be
+completed generally in any order. It's memory barriers are also to some extent
+more substantial than the mimimum requirement, and may directly effect
+hardware outside of the CPU.
