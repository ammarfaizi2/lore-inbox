Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752513AbWCQB2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWCQB2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbWCQB2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:28:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36792 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752510AbWCQB2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:28:39 -0500
Date: Thu, 16 Mar 2006 17:29:16 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Message-ID: <20060317012916.GD1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com> <20060316231723.GB1323@us.ibm.com> <Pine.LNX.4.64.0603161551000.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603161551000.3618@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:55:07PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 16 Mar 2006, Paul E. McKenney wrote:
> > 
> > Also, I have some verbiage and diagrams of Alpha's operation at
> > http://www.rdrop.com/users/paulmck/scalability/paper/ordering.2006.03.13a.pdf
> > Feel free to take any that helps.  (Source for paper is Latex and xfig,
> > for whatever that is worth.)
> 
> This paper too claims that x86-64 has somehow different memory ordering 
> constraints than regular x86. Do you actually have a source for that 
> statement, or is it just a continuation of what looks like confusion in 
> the Linux x86-64 header files?

I based the table in that paper on "AMD x86-64 Architecture Programmer's
Manual, Volume 2: System Programming", AMD publication #24593 rev 3.07
published in September 2002.  This is a hardcopy (but soft-bound) book.

In section 7.1.1 on page 195, it says:

	For cacheable memory types, the following rules govern
	read ordering:

	o	Out-of-order reads are allowed.  Out-of-order reads
		can occur as a result of out-of-order instruction
		execution or speculative execution.  The processor
		can read memory out-of-order to allow out-of-order
		to proceed.

	o	Speculative reads are allows ... [but no effect on
		ordering beyond that given in the other rules, near
		as I can tell]

	o	Reads can be reordered ahead of writes.  Reads are
		generally given a higher priority by the processor
		than writes because instruction execution stalls
		if the read data required by an instruction is not
		immediately available.  Allowing reads ahead of
		writes usually maximizes software performance.

	o	[additional constraints if read and write are to
		the same location]

In section 7.1.2 on pages 195-6, it says:

	o	Generally, out-of-order writes are -not- allowed.
		Write instructions executed out of order cannot
		commit (write) their result to memory until all
		previous instructions have completed in program
		order.  The processor can, however, hold the
		result of an out-of-order write instruction in
		a private buffer (not visible to software) until
		that result can be committed to memory.

	o	[write-combining memory -- but we are not talking
		about frame buffers.]

	o	Speculative writes are -not- allowed.  As with
		out-of-order writes, speculative write instructions
		cannot commit their result to memory until all
		previous instructions have completed in program
		order.  Processors can hold the result in a
		private buffer (not visible to the software) until
		the result can be committed.

	o	Write buffering is allowed.  When a write instruction
		completes and commits its result, that result can be
		buffered before actually writing the result into a
		memory location in program order.  Although the write
		buffer itself is not directly accessible by software,
		the results in the buffer are accessible during
		memory accesses to he locations that are buffered.
		For cacheable memory types, the write buffer can
		be read out-of-order and speculatively read, just like
		memory.

	o	Write combining is allowed ... [but we aren't worried
		about frame buffers.]

Of course, I might well have misinterpreted something.  It would not
be the first time.  ;-)

> (Also, x86 doesn't have an incoherent instruction cache - some older x86 
> cores have an incoherent instruction decode _buffer_, but that's a 
> slightly different issue with basically no effect on any sane program).

Newer cores check the linear address, so code generated in a different
address space now needs to do CPUID.  This is admittedly an unusual
case -- perhaps I was getting overly worked up about it.  I based this
on Section 10.6 on page 10-21 (physical page 405) of Intel's "IA-32
Intel Architecture Software Developer's Manual Volume 3: System
Programming Guide", 2004.  PDF available (as of 2/16/2005) from:

	ftp://download.intel.com/design/Pentium4/manuals/25366814.pdf

							Thanx, Paul
