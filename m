Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSHFTJu>; Tue, 6 Aug 2002 15:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHFTJt>; Tue, 6 Aug 2002 15:09:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45543 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315278AbSHFTJr>;
	Tue, 6 Aug 2002 15:09:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Seth, Rohit" <rohit.seth@intel.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 6 Aug 2002 15:11:33 -0400
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
References: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
In-Reply-To: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061511.34021.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 07:30 pm, Seth, Rohit wrote:
> > -----Original Message-----
> > From: Hubertus Franke [mailto:frankeh@watson.ibm.com]
> > Sent: Sunday, August 04, 2002 12:30 PM
> > To: Linus Torvalds
> > Cc: David S. Miller; davidm@hpl.hp.com; davidm@napali.hpl.hp.com;
> > gh@us.ibm.com; Martin.Bligh@us.ibm.com; wli@holomorphy.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: large page patch (fwd) (fwd)
> >
> > Well, in what you described above there is no concept of superpages
> > the way it is defined for the purpose of <tracking> and <TLB overhead
> > reduction>.
> > If you don't know about super pages at the VM level, then you need to
> > deal with them at TLB fault level to actually create the <large TLB>
> > entry. That what the INTC patch will do, namely throughing all the
> > complexity over the fence for the page fault.
>
> Our patch does the preallocation of large pages at the time of request.
> There is really nothing special like replicating PTEs (that you mentioned
> below in your design) happens there. In any case,  even for IA-64 where the
> TLBs are also sw controlled (we also have Hardware Page Walker that can
> walk any 3rd level pt and insert the PTE in TLB.) there are almost no
> changes (to be precise one additional asm instructionin the begining of
> handler for shifting extra bits) in our implementation that pollute the low
> level TLB fault handlers to have the knowledge of large page size in
> traversing the 3-level page table. (Though there are couple of other asm
> instructions that are added in this low-level routine to set helping
> register with proper page_size while inserting bigger TLBs).  On IA-32
> obviously things fall in place automagically as the page tables are setup
> as per arch.
>

Hi, I quite apparent from your answer that I didn't make our approach and 
intent clear.
I don't mean to discredit your approach in anyway, its quick, its special 
purpose and does what it does namely anonymous memory for large pages
supported by a particular architecture on specific request in an efficient 
manner with absolutely no overhead on the base kernel. Agreed that
the interface is up for negotiation but that has nothing to do with the 
essense its estatics and other API arguments.

Our intent has been, if you followed our presentation at OLS or on the web,
to build a multiple page size support that spans (i) mmap'ed files, (ii) shm 
segments and (iii) anonymous files and memory, hence covers the page cache 
and eventually the swap system as well. The target would really to be like 
the Rice BSD paper with automatic promotion/demotion and reservation. 
Ofcourse its up to discussions whether that is any good or just overkill and
useless in the face that if important apps could simply use a special purpose 
interface and force the issue.

We are nowhere close to there. More analysis is required to even establish 
that fragmentation, large page aware defragmenter etc. won't kill any TLB 
overhead performance gains seen. The Rice Paper is one reference point.
But its important to point out that this is what the OS research community 
wants to see.
This can NOT be accomplished in one big patch, several intermediate steps are 
required.
(a) The first one is to demonstrate that large pages for anonymous memory 
(shared through fork and non-shared) can be integrated effortless into the 
current VM 
code with no overhead an almost no major cludges and code messups.....
Doing so would give the benefit for every architecture. In essense what needs 
to be provided is a few low level macros to force the page order into the 
PTE/PMD entry.
(b) The second one is to extend the concept to the I/O to be able to back 
regions with files.

We are closed to be done with (a) having pulled out the stuff out of Simon's 
patch for 2.4.18 and moved it up to 2.5.30. We will retrofit (b) later.

The next confusion is that of the definition of a large page and a super page.
I am guilty too of mixing these up every now and then.
SuperPage:   a cluster of contiguous physical pages that is treated by the OS
                   as a single entity. Operations are on superpages, including
                   tracking of Dirty, referenced, active .... although 
                   they might be broken down in smaller operations on their 
                   base pages.
Large Page:  A superpage that coincides with pagesize supported by the HW.

In your case you are clearly dealing with <LargePages> as a special memory 
area that is intercepted at fault time and specially dealt with.
Our case, essentially supports the super page concept as defined above.
Not all is implemented and the x86 prototype was focused on the
SuperPage=LargePage issue. 
Continuation below ....

> > In your case not keeping track of the super pages in the
> > VM layer and PT layer requires to discover the large page at soft TLB
> > time by scanning PT proximity for contigous pages if we are
> > talking now
> > about the read_ahead ....
> > In our case, we store the same physical address of the super page
> > in the PTEs spanning the superpage together with the page order.
> > At software TLB time we simply extra the single PTE from the PT based
> > on the faulting address and move it into the TLB. This
> > ofcourse works only
> > for software TLBs (PwrPC, MIPS, IA64). For HW TLB (x86) the
> > PT structure
> > by definition overlaps the large page size support.
> > The HW TLB case can be extended to not store the same PA in
> > all the PTEs,
> > but conceptually carry the superpage concept for the purpose
> > described above.
>
> I'm afraid you may be wasting a lot of extra memory by replicaitng these
> PTEs(Take an example of one 4G large TLB size entry and assume there are
> few hunderd processes using that same physical page.)
>
4GB TLB entry size ??? 
I assume you mean 4MB TLB entry size or did I fall into a coma for 10 years 
:-)

Well, the way it is architected is that all translations (including 
superpages) are stored in the PT. Should a superpage coincide with
a PMD we do not allocate the lowest level of (1<<PMD_SHIFT) entries and
record that fact in the PMD. 
In case the super page is smaller then a PMD (e.g. 4MB), then entries need
to be created in the PTEs. One can dream up some optimizations, that only
a single entry needs to be created, but that only works for SW-TLB. 
For HW-TLB (x86) there is no choice but doing so.
For SW-TLB, this probably works the same as you stuff (only have seen the 
HW-TLB x86 port). You store this one entry in the PT at the basepage 
translation of the superpage and walk at page fault time. This can be done 
equally in architecture independent code as far as I can tell, with the same
tricks you are mentioning above dressed up in architecture dependent code.
super 

> > We have that concept exactly the way you want it, but the dress code
> > seems to be wrong. That can be worked on.
> > Our goal was in the long run 2.7 to explore the Rice approach to see
> > whether it yields benefits or whether we getting down the road of
> > fragmentation reduction overhead that will kill all the
> > benefits we get
> > from reduced TLB overhead. Time would tell.
> >
> > But to go down this route we need the concept of a superpage
> > in the VM,
> > not just at TLB time or a hack that throws these things over
> > the fence.
>
> As others have already said that you may want to have the support of
> smaller superpages in this way.  Where VM is embeded with some knowledge of
> different page sizes that it can support.  Demoting and permoting pages
> from one size to another (efficiently)will be very critical in the design.
> In my opinion supporting the largest TLB on archs (like 256M or 4G) will
> need more direct appraoch and less intrusion from kernel VM will be
> prefered. Ofcourse, kernel will need to put extra checks etc. to maintain
> some sanity for allowed users.
>

Yipp, that's the goal. Just think that in general coverage of up to decently 
large TLB entry sizes (4MB) can be handled with our approach and it would 
essentially allow the filemaps and general shm segments.

> There has already been lot of discussion on this mailing list about what is
> the right approach.  Whether the new APIs are needed or something like
> madvise would do it, whether kernel needs to allocate large_pages
> transparently to the user or we should expose the underlying HW feature to
> user land.  There are issues that favor one approach over another.  But the
> bottom line is: 1) We should not break anything semantically for regular
> system calls that happen to be using large TLBs and 2) The performance
> advantage of this HW feature (on most of the archs I hope) is just too much
> to let go without notice.  I hope we get to consensus for getting this
> support in kernel ASAP.  This will benefit lot of Linux users.  (And yes I
> understand that we need to do things right in kernel so that we don't make
> unforeseen errors.)
>

Absolutely, well phrased. The "+"s and "-"s of each approach have been 
pointed out by many folks and papers. Your stuff certainly provides a short 
term solution that works. After OLS I was hoping to look from it at a long 
term solution ala Rice BSD approach. 

> > > And no, I do not want separate coloring support in the
> >
> > allocator. I think
> >
> > > coloring without superpage support is stupid and worthless (and
> > > complicates the code for no good reason).
> > >
> > > 		Linus
> >
> > That <stupid> seems premature. You are mixing the concept of
> > superpage from a TLB miss reduction perspective
> > with the concept of superpage for page coloring.
>
> I have seen couple of HPC apps that try to fit (configure) in their data
> sets on the L3 caches size (Like on IA-64 4M).  I think these are the apps
> that really get hit hardest by lack of proper page coloring support in
> Linux kernel.  The performance variation of these workloads from run to run
> could be as much as 60%  And with the page coloring patch, these apps seems
> to be giving consistent higher throuput (The real bad part is that once the
> throughput of these workloads drop, it stays down thereafter :( )  But
> seems like DavidM has enough real world data that prohibits the use of this
> approach in kernel for real world scenarios.  The good part of large TLBs
> is that, TLBs larger than CPU cache size will automatically get you perfect
> page coloring .........for free.
>
> rohit

Yipp.... 
let's see how it evolves. 
As DavidM so elegantly stated:  talk=BS  walk=code    :-)

Cheers....

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
