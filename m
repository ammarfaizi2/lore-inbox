Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315561AbSECGE0>; Fri, 3 May 2002 02:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315562AbSECGEZ>; Fri, 3 May 2002 02:04:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23840 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315561AbSECGEY>; Fri, 3 May 2002 02:04:24 -0400
Date: Fri, 3 May 2002 08:04:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503080433.R11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 12:19:03PM -0700, William Lee Irwin III wrote:
> On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
> >> Being unable to have any ZONE_NORMAL above 4GB allows no change at all.
> 
> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > No change if your first node maps the whole first 4G of physical address
> > space, but in such case nonlinear cannot help you in any way anyways.
> > The fact you can make no change at all has only to do with the fact
> > GFP_KERNEL must return memory accessible from a pci32 device.
> 
> Without relaxing this invariant for this architecture there is no hope
> that NUMA-Q can ever be efficiently operated by this kernel.

I don't think it make sense to attempt breaking GFP_KERNEL semantics in
2.4 but for 2.5 we can change stuff so that all non-DMA users can ask
for ZONE_NORMAL that will be backed by physical memory over 4G (that's
fine for all inodes,dcache,files,bufferheader,kiobuf,vma and many other
in-core data structures never accessed by hardware via DMA, it's ok even
for the buffer cache because the lowlevel layer has the bounce buffer
layer that is smart enough to understand when bounce buffers are needed
on top of the physical address space pagecache).

> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > I think most configurations have more than one node mapped into the
> > first 4G, and so in those configurations you can do changes and spread
> > the direct mapping across all the nodes mapped in the first 4G phys.
> 
> These would be partially-populated nodes. There may be up to 16 nodes.
> Some unusual management of the interrupt controllers is required to get
> the last 4 cpus. Those who know how tend to disavow the knowledge. =)
> 
> 
> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > the fact you can or you can't have something to change with discontigmem
> > or nonlinear, it's all about pci32.
> 
> Artificially tying together the device-addressibility of memory and
> virtual addressibility of memory is a fundamental design decision which
> seems to behave poorly for NUMA-Q, though general it seems to work okay.

Yes, you know since a few months ago we weren't even capable of skipping
the bounce buffers for the memory between 1G and 4G and for the memory
above 4G with pci-64, now we can, in the future we can be more
finegrined if there's the need to.

Again note that nonlinear can do nothing to help you there, the
limitation you deal with is pci32 and the GFP API, not at all about
discontigmem or nonlinear. we basically changed topic from here.

> On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
> >> 32-bit PCI is not used on NUMA-Q AFAIK.
> 
> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > but can you plugin 32bit pci hardware into your 64bit-pci slots, right?
> > If not, and if you're also sure the linux drivers for your hardware are all
> > 64bit-pci capable then you can do the changes regardless of the 4G
> > limit, in such case you can spread the direct mapping all over the whole
> > 64G physical ram, whereever you want, no 4G constraint anymore.
> 
> I believe 64-bit PCI is pretty much taken to be a requirement; if it
> weren't the 4GB limit would once again apply and we'd be in much
> trouble, or we'd have to implement a different method of accommodating
> limited device addressing capabilities and would be in trouble again.

If you're sure all the hw device are pci64 and the device drivers are
using DAC to submit the bus addresses, then you're just fine and you can
use pages over 4G for the ZONE_NORMAL too. and yes, if you add an IOMMU
unit like the GART then you can fill the zone_normal with phys pages
over 4G too because then the bus address won't be an identity anymore
with the phys addr, I just assumed it wasn't the case because most x86
doesn't have that capability besides the GART that isn't currently used
by the kernel as an iommu but that it's left to use to build contigous
ram for the AGP cards (and also not all x86 have an AGP so we couldn't
use it by default on x86 even assuming the graphics card doesn't need
it).

> On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
> >> So long as zones are physically contiguous and __va() does what its
> 
> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > zones remains physically contigous, it's the virtual address returned by
> > page_address that changes. Also the kmap header will need some
> > modification, you should always check for PageHIGHMEM in all places to
> > know if you must kmap or not, that's a few liner.
> 
> I've not been using the generic page_address() in conjunction with
> highmem, but this sounds like a very natural thing to do when the need
> to do so arises; arranging for storage of the virtual address sounds
> trickier, though doable. I'm not sure if mainline would want it, and
> I don't feel a pressing need to implement it yet, but then again, I've
> not yet been parked in front of a 64GB x86 machine yet...

Personally I always had the hope to never need to see a 64G 32bit
machine 8). I mean, even if you manage to solve the pci32bit problem
with GFP_KERNEL, then you still have to share 800M across 16 nodes with
4G each. So by striping zone_normal over all the nodes to have numa-local
data structures with fast slab allocations will get at most 50mbyte per
node of which around 90% of this 50M will be eat by the mem_map array
for those 50M plus the other 4G-50M. So at the end you'll be left with
only say 5/10M per node of zone_normal that will be filled immediatly as
soon as you start reading some directory from disk. a few hundred mbyte
of vfs cache is the minimum for those machines, this doesn't even take
into account bh headers for the pagecache, physical address space
pagecache for the buffercache, kiobufs, vma, etc... Even ignoring the fact
it's NUMA a 64G machine will boot fine (thanks to your 2.4.19pre work
that shrinks of some bytes each page structure) but still it will work well
only depending on what you're doing, for example it's fine for number
cruncking but it will be bad for most other important workloads. And
this is only because of the 32bit address space, it doesn't have anything
to do with nonlinear/numa/discontigmem or pci32.  It's just that 1G of
virtual address space reserved for kernel is too low to handle
efficiently 64G of physical ram, this is a fact and you can't workaround
it. every workaround will add a penality here or there. The workaround
you will be mostly forced to take is CONFIG_2G, after that the userspace
will be limited to less than 1G per task returned by malloc (from over
1G to below 2G) and that will be a showstopper again for most userspace
apps that wants to run on a 64G box like a DBMS that wants almost 2G of
SGA. I'm glad we're finally going to migrate all to 64bit, just in time
not to see a relevant number of 32bit 64G boxes.

And of course, I don't mean a 64G 32bit machine doesn't make sense, it
can make perfect sense for a certain number of users with specific needs
of lots of ram and with very few kernel data structures, if you do that
that's because you know what you're doing and you know you can tweak
linux for your own workload and that's fine as far it's not supposed to
be a general purpose machine (with general purpose I mean pretending to
run a DBMS with a 1.7G SGA requiring CONFIG_3G, plus a cvs [or bk if
you're a bk fan] server dealing with huge vfs metadata at the same time,
for istance the cvs workload would run faster booting with mem=32G :)

> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > BTW, about the pgdat loops optimizations, you misunderstood what I meant
> > in some previous email, with "removing them" I didn't meant to remove
> > them in the discontigmem case, that would had to be done case by case,
> > with removing them I meant to remove them only for mainline 2.4.19-pre7
> > when kernel is compiled for x86 target like 99% of userbase uses it. A
> > discontigmem using nonlinear also doesn't need to loop. It's a 1 branch
> > removal optimization (doesn't decrease the complexity of the algorithm
> > for discontigmem enabled). It's all in function of
> > #ifndef CONFIG_DISCONTIGMEM.
> 
> >From my point of view this would be totally uncontroversial. Some arch
> maintainers might want a different #ifdef condition but it's fairly
> trivial to adjust that to their needs when they speak up.

Yep. Nobody did it probably just to left the code clean and because it
would only remove a branch that wouldn't be measurable in any benchmark.
Infact I'm not doing it either, I raised it just as a more
worthwhile improvement compared to sharing a cachline between the last
page of a mem_map and the first page of the mem_map in the next pgdat
(again assuming a sane number of discontig chunks, say 16 with 32/64G of
ram global, not hundred of chunks)

> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > Dropping the loop when discontigmem is enabled is much more interesting
> > optimization of course.
> > Andrea
> 
> Absolutely; I'd be very supportive of improvements for this case as well.
> Many of the systems with the need for discontiguous memory support will
> also benefit from parallelizations or other methods of avoiding references
> to remote nodes/zones or iterations over all nodes/zones.

I would suggest to start on case-by-case basis looking at the profiling,
so we make more complex only what is worth to optimize.  For example
nr_free_buffer_pages() I guess it will showup because it is used quite
frequently.

Andrea
