Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWHPCXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHPCXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWHPCXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:01 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53692 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750728AbWHPCXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:00 -0400
Date: Tue, 15 Aug 2006 19:22:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 0/7] A modular slab allocator V1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a proposal for a modularized slab allocator. I have tried
for a long time to find some way to untwist the code in the slab
and I think I have found it although I have some concerns about
its acceptability given the techniques and the scope of this
work.  But we have done some of this before for device drivers. However,
we have never done this in the VM as far as I can tell.

The modularization is accomplished by trying to use a few
concepts from object oriented programming. Allocators are
described by methods and functions can produce new allocators
based on existing ones by modifying their methods.

So what the patches provide here is:

1. A framework for page allocators and slab allocators

2. Various methods to derive new allocators from old ones
   (add rcu support, destructors, constructors, dma etc)

3. A layer that emulates the exist slab interface (the slabulator).

4. A layer that provides kmalloc functionality.

5. Three different slab allocators.

	A. The Slabifier. This is conceptually the Simple Slab (See my RFC
	   from last week) but with the additional allocator modifications
	   possible it grows like on steroids and then can supply most of
	   the functionality of the existing slab allocator and can go even
	   beyond it.

	   It is called the Slabifier because it can slabify any
	   page allocator. VMALLOC is a valid page allocator so
	   it can do slabs on vmalloc ranges. You can define your
	   own page allocator (mempools??) and then slabify that
	   one.

	B. The page slab allocator. This is a simple Pagesize based
	   allocator that uses the page allocator directly to manage its
	   objects. Doing so avoids all the slab overhead for large
	   allocations. The page slab can also slabify any other
	   page allocator.

	C. The NUMA Slab. This allocator is based on the slabifier
	   and simply creates one Slabifier per node and manages
	   those. This allows a clean separation of NUMA.
	   The slabifier stays simple and the NUMA slab can deal
	   with the allocation complexities. So system
	   without NUMA are not affected by the logic that is
	   put in.

All slab allocators are written to the same interface. New allocators can
be added at will. One could f.e add the slob and the existing slab. One can
dynamically decide which slab to use (if one abandons the emulation
layer) by combining page allocator, slab allocators and various methods
of deriving allocators.

The patchset is definitely still in its infancy. Large sections of the
code are not tested yet. This boots fine if the slabifier or the
numa slab are being used on an SGI Altix. Nothing beyond that has
been done yet.

Some of the other issues in the slab layer are also addressed here:

1. shrink_slab takes a function to move object. Using that
   function slabs can be defragmented to ease slab reclaim.

2. Bootstrap occurs through dynamic slab creation.

3. New slabs that are created can be merged into the kmalloc array
   if it is detected that they match. This decreases the number of caches
   and benefits cache use.

4. The slabifier can flag double frees when the act occurs
   and will attempt to continue.

5. There is no 2 second slab reaper tick. Each slab has a 10
   second flusher attached. flusher is inactive is slab is
   inactive.

Notably missing features:

- Slab Debugging
- Proper NUMA policy support.
- No support for pagese
- slab_reaper also does some other things that we would have to do
  in a different way.

Performance tests with AIM7 on an 8p Itanium machine (4 NUMA nodes)
(Memory spreading active which means that we do not take advantage of NUMA locality
in favor of load balancing)

2.6.18-rc4 straight (w/existing NUMA Slab).

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1     2434.08  100      2434.0771      2.46      0.02   Tue Aug 15 15:53:12 2006
  100   178571.43   95      1785.7143      3.36      7.21   Tue Aug 15 15:53:25 2006
  200   280964.65   90      1404.8232      4.27     14.52   Tue Aug 15 15:53:43 2006
  300   345356.87   86      1151.1896      5.21     21.87   Tue Aug 15 15:54:05 2006

2.6.18-rc4 with slabifier alone (NUMA system without NUMA slab)!

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1     2433.09  100      2433.0900      2.47      0.02   Tue Aug 15 17:10:44 2006
  100   176108.01   92      1761.0801      3.41      7.47   Tue Aug 15 17:10:58 2006
  200   275608.64   88      1378.0432      4.35     15.14   Tue Aug 15 17:11:16 2006
  300   338919.22   85      1129.7307      5.31     22.77   Tue Aug 15 17:11:38 2006

We are almost getting there even with this immature version and without having the
object caches.

2.6.18-rc4 with NUMA slab and slabifier.

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1     2431.12  100      2431.1183      2.47      0.03   Tue Aug 15 19:14:38 2006
  100   176418.70   93      1764.1870      3.40      7.53   Tue Aug 15 19:14:52 2006
  200   275862.07   90      1379.3103      4.35     15.14   Tue Aug 15 19:15:10 2006
  300   338345.86   86      1127.8195      5.32     22.85   Tue Aug 15 19:15:32 2006

Hmmm... This gets more inefficient but then it cannot use its NUMA advantage. Definitely
more overhead. But also so far a pretty naive implementation.

Using the allocator framework we could now add a generic caching layer.
Wonder what that would do.

I would appreciate feedback on the way this is done. Beware: There are
likely numerous issues with this patchset.

This patchset should just leave the existing slab allocator unharmed.
One needs to switch on the modular slab allocator to activate any of this.

