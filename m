Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752544AbWCQGWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbWCQGWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbWCQGWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:22:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:21908 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751446AbWCQGWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:22:24 -0500
Date: Thu, 16 Mar 2006 22:23:00 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Message-ID: <20060317062300.GE1323@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com> <20060316231723.GB1323@us.ibm.com> <Pine.LNX.4.64.0603161551000.3618@g5.osdl.org> <20060317012916.GD1323@us.ibm.com> <Pine.LNX.4.64.0603162118450.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603162118450.3618@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:32:03PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 16 Mar 2006, Paul E. McKenney wrote:
> > 
> > In section 7.1.1 on page 195, it says:
> > 
> > 	For cacheable memory types, the following rules govern
> > 	read ordering:
> > 
> > 	o	Out-of-order reads are allowed.  Out-of-order reads
> > 		can occur as a result of out-of-order instruction
> > 		execution or speculative execution.  The processor
> > 		can read memory out-of-order to allow out-of-order
> > 		to proceed.
> > 
> > 	o	Speculative reads are allows ... [but no effect on
> > 		ordering beyond that given in the other rules, near
> > 		as I can tell]
> > 
> > 	o	Reads can be reordered ahead of writes.  Reads are
> > 		generally given a higher priority by the processor
> > 		than writes because instruction execution stalls
> > 		if the read data required by an instruction is not
> > 		immediately available.  Allowing reads ahead of
> > 		writes usually maximizes software performance.
> 
> These are just the same as the x86 ordering. Notice how reads can pass 
> (earlier) writes, but won't be pushed back after later writes. That's very 
> much the x86 ordering (together with the "CPU ordering" for writes).

OK, so you are not arguing with the "AMD" row, but rather with the
x86 row.  So I was looking in the wrong manual.  Specifically, you are
saying that the x86's "Loads Reordered After Stores" cell should be
blank rather than "Y", right?

> > > (Also, x86 doesn't have an incoherent instruction cache - some older x86 
> > > cores have an incoherent instruction decode _buffer_, but that's a 
> > > slightly different issue with basically no effect on any sane program).
> > 
> > Newer cores check the linear address, so code generated in a different
> > address space now needs to do CPUID.  This is admittedly an unusual
> > case -- perhaps I was getting overly worked up about it.  I based this
> > on Section 10.6 on page 10-21 (physical page 405) of Intel's "IA-32
> > Intel Architecture Software Developer's Manual Volume 3: System
> > Programming Guide", 2004.  PDF available (as of 2/16/2005) from:
> > 
> > 	ftp://download.intel.com/design/Pentium4/manuals/25366814.pdf
> 
> Not according to the docs I have.
> 
> The _prefetch_ queue is invalidated based on the linear address, but not 
> the caches. The caches are coherent, and the prefetch is also coherent in 
> modern cores wrt linear address (but old cores, like the original i386, 
> would literally not see the write, so you could do
> 
> 		movl $1234,1f
> 	1:	xorl %eax,%eax
> 
> and the "movl" would overwrite the "xorl", but the "xorl" would still get 
> executed if it was in the 16-byte prefetch buffer or whatever).
> 
> Modern cores will generally be _totally_ serialized, so if you write to 
> the next instruction, I think most modern cores will notice it. It's only 
> if you use paging or something to write to the physical address to 
> something that is in the prefetch buffers that it can get you.

Yep.  But I would not put it past some JIT writer to actually do something
like double-mapping the JITed code to two different linear addresses.

> Now, the prefetching has gotten longer over time, but it is basically 
> still just a few tens of instructions, and any serializing instruction 
> will force it to be serialized with the cache.

Agreed.

> It's really a non-issue, because regular self-modifying code will trigger 
> the linear address check, and system code will always end up doing an 
> "iret" or other serializing instruction, so it really doesn't trigger. 

Only if there is a context switch between the writing of the instruction
and the executing of it.  Might not be the case if someone double-maps
the memory or some other similar stunt.  And I agree modern cores seem
to be getting less aggressive in their search for instruction-level
parallelism, but it doesn't take too much speculative-execution capability
to (sometimes!) get some pretty strange stuff loaded into the instruction
prefetch buffer.

> So in practice, you really should see it as being entirely coherent. You 
> have to do some _really_ strange sh*t to ever see anything different.

No argument with your last sentence!  (And, believe it or not, there
was a time when self-modifying code was considered manly rather than
strange.  But that was back in the days of 4096-byte main memories...)

I believe we are in violent agreement on this one.  The column label in
the table is "Incoherent Instruction Cache/Pipeline".  You are saying
that only the pipeline can be incoherent, and even then, only in strange
situations.  But the only situation in which I would leave a cell in
this column blank would be if -both- the cache -and- the pipeline were
-always- coherent, even in strange situations.  So I believe that this
one still needs to stay "Y".

I would rather see someone's JIT execute an extra CPUID after generating
a new chunk of code than to see it fail strangely -- but only sometimes,
and not reproducibly.

Would it help if the column were instead labelled "Incoherent Instruction
Cache or Pipeline", replacing the current "/" with "or"?

							Thanx, Paul
