Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315617AbSECJZt>; Fri, 3 May 2002 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315618AbSECJZt>; Fri, 3 May 2002 05:25:49 -0400
Received: from holomorphy.com ([66.224.33.161]:30938 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315617AbSECJZr>;
	Fri, 3 May 2002 05:25:47 -0400
Date: Fri, 3 May 2002 02:24:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503092426.GH24506@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <20020503080433.R11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize in advance for the untimeliness of this response; I took
perhaps more time than necessary to consider the contents thereof.

On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
>> Without relaxing this invariant for this architecture there is no hope
>> that NUMA-Q can ever be efficiently operated by this kernel.

On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> I don't think it make sense to attempt breaking GFP_KERNEL semantics in
> 2.4 but for 2.5 we can change stuff so that all non-DMA users can ask
> for ZONE_NORMAL that will be backed by physical memory over 4G (that's
> fine for all inodes,dcache,files,bufferheader,kiobuf,vma and many other
> in-core data structures never accessed by hardware via DMA, it's ok even
> for the buffer cache because the lowlevel layer has the bounce buffer
> layer that is smart enough to understand when bounce buffers are needed
> on top of the physical address space pagecache).

Well, in a sense, they're already facing some problems from the
progressively stranger hardware people have been porting Linux to. For
instance, suppose there were a machine whose buses were only capable
of addressing memory on nodes local to them... The assumption that a
membership within a single address region suffices to ensure that
devices are capable of addressing it already then breaks down.
(The workaround was to IPI and issue the command from another node.)


On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
>> Artificially tying together the device-addressibility of memory and
>> virtual addressibility of memory is a fundamental design decision which
>> seems to behave poorly for NUMA-Q, though general it seems to work okay.

On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> Yes, you know since a few months ago we weren't even capable of skipping
> the bounce buffers for the memory between 1G and 4G and for the memory
> above 4G with pci-64, now we can, in the future we can be more
> finegrined if there's the need to.
> Again note that nonlinear can do nothing to help you there, the
> limitation you deal with is pci32 and the GFP API, not at all about
> discontigmem or nonlinear. we basically changed topic from here.

Given the amount of traffic that's already happened for that thread,
I'd be glad to change subjects. =)

While I don't have a particular plan to address what changes to the
GFP API might be required to make these scenarios work, a quick thought
is to pass in indices into a table of zones corresponding to regions of
memory addressible by some devices and not others. It'd give rise to a
partition like what is already present with foreknowledge of ISA DMA
and 32-bit PCI, but there would be strange corner cases, for instance,
devices claiming to be 32-bit PCI that don't wire all the address lines.
I'm not entirely sure how smoothly these cases are now handled anyway.


On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
>> I believe 64-bit PCI is pretty much taken to be a requirement; if it
>> weren't the 4GB limit would once again apply and we'd be in much
>> trouble, or we'd have to implement a different method of accommodating
>> limited device addressing capabilities and would be in trouble again.

On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> If you're sure all the hw device are pci64 and the device drivers are
> using DAC to submit the bus addresses, then you're just fine and you can
> use pages over 4G for the ZONE_NORMAL too. and yes, if you add an IOMMU
> unit like the GART then you can fill the zone_normal with phys pages
> over 4G too because then the bus address won't be an identity anymore
> with the phys addr, I just assumed it wasn't the case because most x86
> doesn't have that capability besides the GART that isn't currently used
> by the kernel as an iommu but that it's left to use to build contigous
> ram for the AGP cards (and also not all x86 have an AGP so we couldn't
> use it by default on x86 even assuming the graphics card doesn't need
> it).

That sounds a bit painful; digging through drivers to check if any are
missing DAC support is not my idea of a good time.


On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
>> I've not been using the generic page_address() in conjunction with
>> highmem, but this sounds like a very natural thing to do when the need
>> to do so arises; arranging for storage of the virtual address sounds
>> trickier, though doable. I'm not sure if mainline would want it, and
>> I don't feel a pressing need to implement it yet, but then again, I've
>> not yet been parked in front of a 64GB x86 machine yet...

On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> Personally I always had the hope to never need to see a 64G 32bit
> machine 8). I mean, even if you manage to solve the pci32bit problem
> with GFP_KERNEL, then you still have to share 800M across 16 nodes with
> 4G each. So by striping zone_normal over all the nodes to have numa-local
> data structures with fast slab allocations will get at most 50mbyte per
> node of which around 90% of this 50M will be eat by the mem_map array
> for those 50M plus the other 4G-50M. So at the end you'll be left with
> only say 5/10M per node of zone_normal that will be filled immediatly as
> soon as you start reading some directory from disk. a few hundred mbyte
> of vfs cache is the minimum for those machines, this doesn't even take
> into account bh headers for the pagecache, physical address space
> pagecache for the buffercache, kiobufs, vma, etc... Even ignoring the fact
> it's NUMA a 64G machine will boot fine (thanks to your 2.4.19pre work
> that shrinks of some bytes each page structure) but still it will work well
> only depending on what you're doing, for example it's fine for number
> cruncking but it will be bad for most other important workloads. And
> this is only because of the 32bit address space, it doesn't have anything
> to do with nonlinear/numa/discontigmem or pci32.  It's just that 1G of
> virtual address space reserved for kernel is too low to handle
> efficiently 64G of physical ram, this is a fact and you can't workaround
> it. every workaround will add a penality here or there. The workaround
> you will be mostly forced to take is CONFIG_2G, after that the userspace
> will be limited to less than 1G per task returned by malloc (from over
> 1G to below 2G) and that will be a showstopper again for most userspace
> apps that wants to run on a 64G box like a DBMS that wants almost 2G of
> SGA. I'm glad we're finally going to migrate all to 64bit, just in time
> not to see a relevant number of 32bit 64G boxes.

64GB machines are not new. NUMA-Q's original OS (DYNIX/ptx) must have
been doing something radically different, for it appeared to run well
there, and it did so years ago. The amount of data actually required to
be globally mapped should in principle be no larger than the kernel's
loaded image, and everything else can be dynamically mapped by mapping
pages as pointers into them are followed. The practical reality of
getting Linux to do this for a significant fraction of its globally-mapped
structures (or anyone accepting a patch to make it do so) is another
matter entirely.  Optional facilities for the worst offenders might be
more practical, for instance:

(1) Given per-zone kswapd's, i.e. separate process contexts for each
	large fragment of mem_map, it should be possible to reserve
	a large portion of the process' address space for mapping in
	its local mem_map. Algorithms allowing sufficient locality
	of reference (e.g. reverse-mappings) would be required for
	this to be effective.

(2) Various large boot-time allocated structures (think big hash
	tables) could be changed so that either the algorithm only
	requires a small root to be globally mapped in the kernel
	virtual address space (trees), localized on a per-object basis
	if there is an object to hang them off of (e.g. ratcache), or
	highmem allocate the table with a globally-mapped physical
	address available for mapping in the needed portions on-demand
	(like the above mem_map suggestion but without any way to
	give process contexts the ability to restrict themselves
	to orthogonal subsets of the structure).

(3) In order to accommodate the sheer number of dynamic mappings
	going on a large process/mmu-context-local cache of virtual
	address space for mapping them in would be needed for
	efficiency, changing the memory map of Linux/i386 as well
	as adding another kind of (address-space local) kmapping.

(4) The bootstrap sequence would need to be altered so that dynamic
	mappings of boot-time allocated structures residing outside
	the direct-mapped portion of the kernel virtual address space
	are possible, as well as the usual sprinkling of small chunks
	of ZONE_NORMAL across nodes so that something is possible.

Almost anything could exhaust of the kernel virtual address space if
left permanently mapped. And worse yet, there are some DBMS's that want
3.5GB, not just 3GB. These potentially very time-consuming changes
basically kmap everything, including the larger portions of mem_map.
The answer I seem to hear most often is "get a 64-bit CPU".

But I believe it's fully possible to get the larger highmem systems to
what is very near a sane working state and feed back to mainline a good
portion of the less invasive patches required to address fundamental
stability issues associated with highmem, and welcome any assistance
toward that end.

What is likely the more widely beneficial aspect of this work is that
it can expose the fundamental stability issues of the highmem
implementation very readily and so provide users of more common 32-bit
highmem systems a greater degree of stability than they have previously
enjoyed owing to kva exhaustion issues.


On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> And of course, I don't mean a 64G 32bit machine doesn't make sense, it
> can make perfect sense for a certain number of users with specific needs
> of lots of ram and with very few kernel data structures, if you do that
> that's because you know what you're doing and you know you can tweak
> linux for your own workload and that's fine as far it's not supposed to
> be a general purpose machine (with general purpose I mean pretending to
> run a DBMS with a 1.7G SGA requiring CONFIG_3G, plus a cvs [or bk if
> you're a bk fan] server dealing with huge vfs metadata at the same time,
> for istance the cvs workload would run faster booting with mem=32G :)

Well, this is certainly not the case with other OS's. The design
limitations of Linux' i386 memory layout, while they now severely
hamper performance on NUMA-Q, are a tradeoff that has proved
advantageous on other platforms, and should be approached with some
degree of caution even while Martin Bligh (truly above all others),
myself, and others attempt to address the issues raised by it on NUMA-Q.
But I believe it is possible to achieve a good degree of virtual
address space conservation without compromising the general design,
and if I may be so bold as to speak on behalf of my friends, I believe
we are willing to, capable of, and now exercising that caution.


On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
>> Absolutely; I'd be very supportive of improvements for this case as well.
>> Many of the systems with the need for discontiguous memory support will
>> also benefit from parallelizations or other methods of avoiding references
>> to remote nodes/zones or iterations over all nodes/zones.

On Fri, May 03, 2002 at 08:04:33AM +0200, Andrea Arcangeli wrote:
> I would suggest to start on case-by-case basis looking at the profiling,
> so we make more complex only what is worth to optimize.  For example
> nr_free_buffer_pages() I guess it will showup because it is used quite
> frequently.

I think I see nr_free_pages(), but nr_free_buffer_pages() sounds very
likely as well. Both of these would likely benefit from per-cpu
counters.


Cheers,
Bill
