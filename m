Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUJLOyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUJLOyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUJLOxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:53:03 -0400
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265697AbUJLOuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:50:05 -0400
Date: Tue, 12 Oct 2004 10:50:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Questions about memory barriers
Message-ID: <Pine.LNX.4.44L0.0410121015480.1173-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple of questions regarding memory barriers.

The first question concerns read_barrier_depends().  I'm not sure exactly
what it does.

The documentation in include/asm-i386/system.h says:

 * No data-dependent reads from memory-like regions are ever reordered
 * over this barrier.  All reads preceding this primitive are guaranteed
 * to access memory (but not necessarily other CPUs' caches) before any
 * reads following this primitive that depend on the data return by
 * any of the preceding reads.

Taken at face value, this implies that all reads preceding 
read_barrier_depends are guaranteed to access memory before the barrier 
finishes.  Even reads whose data is not used by a subsequent read.  Is 
this right?

Furthermore, the text's distinction of reads "that depend on the data
return[ed] by any of the preceding reads" is nearly meaningless.  Almost
any read from a non-constant location could fall into that category.  
Consider this example:

	q = p;
	<... millions of instructions ...>
	read_barrier_depends();
	d = *q;

How is the processor supposed to remember whether or not the value of q 
depends on the earlier read of p?  Obviously it can't, so it must assume
that such a dependency exists.  Only if q had very recently been assigned 
a constant value would the processor know otherwise.

Putting these ideas together, they amount to saying that
read_barrier_depends is just like rmb except that reads from a constant
location following the barrier are allowed to be moved before the barrier.  
Have I missed anything?

The first code example in system.h is not informative.  It says that this
code sequence:

		q = p;
		read_barrier_depends();
		d = *q;

enforces ordering.  But that means nothing; the ordering is already forced 
by the C language definition.  After all, it's impossible for the 
processor to load data from *q before it knows what value is stored in q.

The other code example says that

		y = b;
		read_barrier_depends();
		x = a;

enforces nothing since there is no dependency between the read of "b" and
the read of "a".  But the other documentation doesn't require such a
dependency to exist; it only requires that the read of "a" depends on data
from a previous read -- which is quite likely unless "a" is a statically
allocated variable.  Was that the intention?  It's not clear; the example 
seems to imply that read_barrier_depends enforces ordering only in 
situations where the C language already enforces it.


My second question concerns guarantees about barriers and synchronization 
primitives.  It doesn't seem to be documented anywhere, but I would assume 
the following statements are all true:

	Acquiring a semaphore or spinlock implicitly includes a read
	barrier.

	Releasing a semaphore or spinlock implicitly includes a write
	barrier.

	Reading the value of an atomic_t implicitly includes a read
	barrier.

	Setting or changing the value of an atomic_t implicitly includes
	a write barrier.

	test_bit(), test_and_set_bit(), etc. implicitly include read 
	barriers.

	set_bit(), clear_bit(), test_and_set_bit(), etc. implicitly
	include write barriers.

Without some guarantees like these, the synchronization primitives would 
be a lot harder to use.  Are these statements in fact correct?

Alan Stern

