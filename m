Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318962AbSHEX1x>; Mon, 5 Aug 2002 19:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHEX1w>; Mon, 5 Aug 2002 19:27:52 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:51529 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S318962AbSHEX1t>; Mon, 5 Aug 2002 19:27:49 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'frankeh@watson.ibm.com'" <frankeh@watson.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: RE: large page patch (fwd) (fwd)
Date: Mon, 5 Aug 2002 16:30:54 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hubertus Franke [mailto:frankeh@watson.ibm.com]
> Sent: Sunday, August 04, 2002 12:30 PM
> To: Linus Torvalds
> Cc: David S. Miller; davidm@hpl.hp.com; davidm@napali.hpl.hp.com;
> gh@us.ibm.com; Martin.Bligh@us.ibm.com; wli@holomorphy.com;
> linux-kernel@vger.kernel.org
> Subject: Re: large page patch (fwd) (fwd)
> 
> Well, in what you described above there is no concept of superpages
> the way it is defined for the purpose of <tracking> and <TLB overhead 
> reduction>. 
> If you don't know about super pages at the VM level, then you need to
> deal with them at TLB fault level to actually create the <large TLB> 
> entry. That what the INTC patch will do, namely throughing all the 
> complexity over the fence for the page fault.
Our patch does the preallocation of large pages at the time of request.
There is really nothing special like replicating PTEs (that you mentioned
below in your design) happens there. In any case,  even for IA-64 where the
TLBs are also sw controlled (we also have Hardware Page Walker that can walk
any 3rd level pt and insert the PTE in TLB.) there are almost no changes (to
be precise one additional asm instructionin the begining of handler for
shifting extra bits) in our implementation that pollute the low level TLB
fault handlers to have the knowledge of large page size in traversing the
3-level page table. (Though there are couple of other asm instructions that
are added in this low-level routine to set helping register with proper
page_size while inserting bigger TLBs).  On IA-32 obviously things fall in
place automagically as the page tables are setup as per arch.

> In your case not keeping track of the super pages in the 
> VM layer and PT layer requires to discover the large page at soft TLB 
> time by scanning PT proximity for contigous pages if we are 
> talking now 
> about the read_ahead ....
> In our case, we store the same physical address of the super page 
> in the PTEs spanning the superpage together with the page order.
> At software TLB time we simply extra the single PTE from the PT based
> on the faulting address and move it into the TLB. This 
> ofcourse works only
> for software TLBs (PwrPC, MIPS, IA64). For HW TLB (x86) the 
> PT structure
> by definition overlaps the large page size support.
> The HW TLB case can be extended to not store the same PA in 
> all the PTEs,
> but conceptually carry the superpage concept for the purpose 
> described above.
> 
I'm afraid you may be wasting a lot of extra memory by replicaitng these
PTEs(Take an example of one 4G large TLB size entry and assume there are few
hunderd processes using that same physical page.)

> We have that concept exactly the way you want it, but the dress code 
> seems to be wrong. That can be worked on.
> Our goal was in the long run 2.7 to explore the Rice approach to see
> whether it yields benefits or whether we getting down the road of 
> fragmentation reduction overhead that will kill all the 
> benefits we get
> from reduced TLB overhead. Time would tell.
> 
> But to go down this route we need the concept of a superpage 
> in the VM,
> not just at TLB time or a hack that throws these things over 
> the fence. 
> 
As others have already said that you may want to have the support of smaller
superpages in this way.  Where VM is embeded with some knowledge of
different page sizes that it can support.  Demoting and permoting pages from
one size to another (efficiently)will be very critical in the design. In my
opinion supporting the largest TLB on archs (like 256M or 4G) will need more
direct appraoch and less intrusion from kernel VM will be prefered.
Ofcourse, kernel will need to put extra checks etc. to maintain some sanity
for allowed users. 

There has already been lot of discussion on this mailing list about what is
the right approach.  Whether the new APIs are needed or something like
madvise would do it, whether kernel needs to allocate large_pages
transparently to the user or we should expose the underlying HW feature to
user land.  There are issues that favor one approach over another.  But the
bottom line is: 1) We should not break anything semantically for regular
system calls that happen to be using large TLBs and 2) The performance
advantage of this HW feature (on most of the archs I hope) is just too much
to let go without notice.  I hope we get to consensus for getting this
support in kernel ASAP.  This will benefit lot of Linux users.  (And yes I
understand that we need to do things right in kernel so that we don't make
unforeseen errors.)
> 
> > And no, I do not want separate coloring support in the 
> allocator. I think
> > coloring without superpage support is stupid and worthless (and
> > complicates the code for no good reason).
> >
> > 		Linus
> 
> That <stupid> seems premature. You are mixing the concept of 
> superpage from a TLB miss reduction perspective 
> with the concept of superpage for page coloring. 
> 
>
I have seen couple of HPC apps that try to fit (configure) in their data
sets on the L3 caches size (Like on IA-64 4M).  I think these are the apps
that really get hit hardest by lack of proper page coloring support in Linux
kernel.  The performance variation of these workloads from run to run could
be as much as 60%  And with the page coloring patch, these apps seems to be
giving consistent higher throuput (The real bad part is that once the
throughput of these workloads drop, it stays down thereafter :( )  But seems
like DavidM has enough real world data that prohibits the use of this
approach in kernel for real world scenarios.  The good part of large TLBs is
that, TLBs larger than CPU cache size will automatically get you perfect
page coloring .........for free. 

rohit
