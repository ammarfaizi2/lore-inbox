Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272595AbRIFVDs>; Thu, 6 Sep 2001 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272597AbRIFVDj>; Thu, 6 Sep 2001 17:03:39 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:26034 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272595AbRIFVDa>;
	Thu, 6 Sep 2001 17:03:30 -0400
Date: Thu, 06 Sep 2001 22:01:17 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: [RFC] Defragmentation proposal: preventative maintenance and
 cleanup [LONG]
Message-ID: <1383771457.999813677@[169.254.198.40]>
In-Reply-To: <20010906174422Z16127-26184+6@humbolt.nl.linux.org>
In-Reply-To: <20010906174422Z16127-26184+6@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd try coding this, then I thought better of it and so am asking
people's opinions first. The following describes a mechanism to change the
zone/buddy allocation system to minimize fragmentation before it happens,
and then defragment post-facto.

Background, & Statement of problem
==================================

High order [1] memory allocations tend to fail when memory is fragmented.
Memory becomes fragmented through normal system usage, without memory
pressure. When memory is fragmented, it stays fragmented.

While non-atomic [2] high order can wait until progress is made freeing
pages, the algorithm 'free pages without reference to their location until
sufficient adjacent pages have by chance been freed for a coalescence' is
inefficient compared to a defragmentation routine, or an attempt to free
specific adjacent pages which may coalesce.

The problem is worse for atomic [2] request, which can neither defragment
memory (due to I/O and locking restrictions), nor can they make progress
via (for instance) page_launder().

Therefore, in a fragmented memory environment, it has been observed that
high order requests, particularly atomic ones [3], fail frequently.

Common sources of atomic high order requests include allocations from the
network layer where packets exceed 4k in size (for instance NFS packets
with rsize,wsize>2048, fragmentation and reassembly), and the SCSI layer.
Whilst it is undeniable that some drivers would benefit from using
technologies like scatter lists to avoid the necessity of contiguous
physical memory allocation, large swathes of current code assumes the
opposite, and some is hard to change. [4]

As many of these allocations occur in bottom half, or interrupt routines,
it is more difficult to handle a failure gracefully than in other code.
This tends to lead to performance problems [5], or worse (hard errors),
which should be minimized.


Causes of fragmentation
=======================

Linux adopts a largely requestor-anonymous form of page allocation. Memory
is divided into 3 zones, and page requesters can specify a list of suitable
zones from which pages may be allocated, but beyond that, pages are
allocated in a manner which does not distinguish between users of given
pages.

Thus pages allocated for packets in flight are likely to be intermingled
with buffer pages, cache pages, code pages and data pages. Each of these
different types of allocation has a different persistence over time. Some
(for instance pages on the InactiveDirty list in an idle system) will
persist indefinitely.

The buddy allocator will attempt (by looking at lowest order lists first)
to allocate pages from fragmented areas first. Assuming pages are freed at
random, this would act as a defragmentation process. However, if a system
is taken to high utilization and back again to idle, the dispersion of
persistent pages (for instance InactiveDirty pages) becomes great, and the
buddy allocator performs poorly at coalescing blocks.

The situation is worsened by the understandable desire for simplicity in
the VM system, which measures solely the number of pages free in different
zones, as opposed their respective locations. It is possible (and has been
observed) to have a system in a state with hardly any high order buddies on
free area lists (thus where it would be impossible to make many atomic high
order allocations), but copious easilly freeable RAM. This is in essence
because no attempt is made to balance for different order free-lists, and
shortage of entries on high-order free lists does not in itself cause
memory pressure.

It is probably undesirable for the normal VM system to react to
fragmentation in the same way it does to normal memory pressure. This would
result in an unselective paging out / discarding of data, whereas an
approach which selected pages to free which would be most likely to cause
coalescence would be more useful. Further, it would be possible, by moving
the data in physical pages, to move many types of page, without loss of
in-memory data at all.


Approaches to solution
======================

It has been suggested that post-facto defragementation is a useful
technique. This is undoubtedly true, but the defragmentation needs to run
before it is 'needed' - i.e. we need to ensure that memory is never
sufficiently fragmented that a reasonable size burst of high order atomic
allocations can fail. This could be achieved by running some background
defragmentation task against some measurable fragmentation target. Here
fragmentation pressure would be an orthogonal measure to memory pressure.
Non atomic high order allocations which are failing should allow the
defragmenter to run, rather than call pagelaunder().

Defragmentation routines appear to be simple at first. Simply run through
the free lists of particular zones, examining whether the constituent pages
of buddies of free areas can be freed or moved. However, using this
approach alone has some drawbacks. Firstly, it is not immediately obvious
that by moving pages you are making the situation any better, because it is
not clear that the (new) destination page will be allocated somewhere less
awkward. Secondly, whilst many types of page can be allocated and moved
with minimal effort (for instance pages on the Active or Inactive lists),
it is less obvious how to move buffer and cache pages transparently (given
only a pointer to the page struct to start with, it is hard to determine
where they are used and referred to, for a start) and it is far from
obvious how to move arbitrary pages allocated by the kernel for disparate
purposes (including pages allocated by the slab allocator).

However, this is not the only possibility to minimize fragmentation.

Part of the problem is the fact that pages are allocated by location
without reference to the caller. If (for instance) buffer pages tended to
be allocated next to eachother, cache pages tended to be allocated next to
eachother, pages allocated by the network stack tended to be allocated next
to eachother, then a number of benefits would accrue:

Firstly, defragmentation would be more successful. Defragmentation would
tend to focus on pages allocated away from their natural brethren, and
their newly allocated pages, into which their data would be moved, would
tend to be next to these. This would help ensure that the new page was
indeed a better location than the old page. Also, as pages of similar ease
or difficulty to move would be clumped, the effect of a large number of
difficult to move pages would be reduced by their mutual proximity.

Secondly, defragmentation would be less necessary. Pages allocated by
different functions have different natural persistence. For instance, pages
allocated within the networking stack typically have short persistence, due
to the transitory nature of the packets they represent. Therefore, in areas
of memory preferred by low persistence users, the natural defragmentation
effect of the buddy allocator would be greater.

Therefore it is suggested that different allocators have affinities for
different areas of memory. One mechanism of achieving this effect would be
an extension to the zone system.

Currently, there are three zones (DMA, Normal and High memory). Imagine
instead, there were many more zones, and the above three labels became
'zone types'. There would thus be many DMA zones, many normal zones, and
many high memory zones. These zones would be at least the highest order
allocation in size - currently 2Mb on i386, but this could be reduced
slightly with minimal disruption. In this manner, the efficiency of the
buddy allocator is not reduced, as the buddy allocator has no visibility of
coalescence etc. above this level anyway.

Balancing would occur accross the aggregate of zone types (i.e. across all
DMA zones in aggregate, accross all High memory zones in aggregate, etc.)
as opposed to by individual zones.

Each zone type would have an associated hash table, the entries being zones
of that type. A routine requesting an allocation would pass information to
__alloc_pages which identified it - it may well be that the GFP flags, the
order, and perhaps some ID for the subsystem is sufficient. This would act
as the key to the hash table concerned. When allocating a page, all zones
in the hash table with the appropriate key (i.e. a matching allocator) are
first tried, in order. If no page is found, then an empty zone (special
key) is found, which is then labelled, and used as, a zone of the type
required. If no empty zone is available of that zone type, then, other zone
types (using the list of appropriate zone types are tried). If no page is
found, then starting with the first zone type again, the first page in ANY
zone within that zone hash table is utilized, and so on through other
suitable zone types.

In this manner, pages are likely to be clustered in zones by allocator. The
role of the defragmenter becomes firstly to target pages which have an
inappropriate key for the zone concerned, and secondly to target pages in
sparsely allocated zones, so the zone becomes unkeyed, and free for
rekeying later. As statistics could easilly be kept per zone on the number
of appropriately and inappropriately keyed pages which had been allocated
within that zone, scanning (and hence finding suitable targets) would
become considerably easier. Equally, maintenance of these statistics can
determine when the defragmenter should be run as a background process.

Some further changes will be necessary; for instance direct_reclaim should
not occur when the page to be reclaimed would be inappropriately keyed for
the zone; in practice this means using direct reclaim only to reclaim pages
for purposes where the allocated page might itself reach the InactiveDirty
list AND where the page reclaimed is correctly keyed.

Furthermore, the number unkeyed (i.e. empty) zones will need to have a
particular low water market target, below which memory pressure must
somehow be caused, in order to force buffer flushing or paging.

This effectively relegates the buddy system to allocating pages for
particular purposes within small chunks of memory - there is a parallel
purpose here with a sort of extended slab system. The zone system would
then become a low overhead manager of larger areas - a sort of 'super slab'.

Thoughts?

Notes
=====

[1] Higher order meaning greater than order 0

[2] By atomic I mean without __GFP_WAIT set, which
    are in the main GFP_ATOMIC allocations.

[3] The lack of any detail at all on non-atomic requests
    suggests that this is either a non-problem, or they
    are little used in the kernel - possibly wrongly so.

[4] For instance, the network code assumes that packets
    (pre-fragmentation, or post-reassembly), are contiguous
    in memory.

[5] For instance, packet drops, which whilst recoverable,
    impede performance.

--
Alex Bligh
