Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSFKESF>; Tue, 11 Jun 2002 00:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSFKESE>; Tue, 11 Jun 2002 00:18:04 -0400
Received: from amdext2.amd.com ([163.181.251.1]:42495 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S316747AbSFKESA>;
	Tue, 11 Jun 2002 00:18:00 -0400
From: richard.brunner@amd.com
X-Server-Uuid: 18a6aeba-11ae-11d5-983c-00508be33d6d
Message-ID: <39073472CFF4D111A5AB00805F9FE4B609BA666B@txexmta9.amd.com>
To: linux-kernel@vger.kernel.org
Subject: Cache-attribute conflict bug in the kernel exposed on newer AMD
 A thlon processors [1]
Date: Mon, 10 Jun 2002 23:17:53 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 111BA67E533334-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[place re-cycled note here ;-)

Folks,

AMD has been working with Andrea
Arcangeli, Andi Kleen, and Dave Jones from SuSE in
researching what looks like a cache-attribute conflict bug
in the Linux kernel that is being exposed by newer versions
of AMD's Athlon processors (AthlonXP and AthlonMP). The
kernel bug is often exposed in conjunction with use of the
AGP Aperture on these platforms.

The good news is that a short-term fix is easy to do and
there are several long-term fixes that can do an even better
job in addressing this.

AMD is still sort of new to the Linux Community; we hope that
giving lots of details in this long note is the right way to
let the community know about this.  We wanted to be crystal
clear on the cause and solutions before bothering you.  The
discussion is laid out below:

      1) Architecture & Athlon Processor Background

      2) The problem in the Linux Kernel

      3) Short-term Linux Kernel Solution 

      4) Long-term Linux Kernel Solution


Thanks!

-Rich ...

[richard.brunner@amd.com    -- (360)-867-0654]
[Senior Member, Technical Staff, SW R&D @ AMD]




1. Architecture and Athlon Processor Background
===============================================
The x86 architecture allows a number of important
performance optimizations for memory which is marked as
write-back cacheable.  One such important optimization
allows the processor to speculatively read memory and cache
it. Such cache lines can be allocated in the shared,
exclusive, or modified states. [1] [4]

The architecture even allows a processor to speculate on
some of the sub-operations that will be necessary for an
instruction that will write memory. Although the processor
can not speculatively commit to memory a speculative write
nor make its results visible to software [2], it is allowed
to speculatively read the cache line that could be modified
into the cache and place it in the "modified" state without
modifying it. [1] (This cache-line read is also referred to
as Read-For-Ownership.) If the speculated write instruction
is "not taken", the line is allowed to remain unmodified,
but still marked as "modified" in the cache. Normal cache
eviction can then write the line back to memory at an
appropriate time.

Correctness is ensured because the architecture requires
cache-coherency for write-back (WB) cacheable data. [3] [4]
Thus, if all processors see the data as write-back
cacheable, there is never a possibility of data-corruption
or "stale data". This is the intent of the x86
architecture. [6]

This is an important requirement; the x86 architecture does
not support the practice of having a single physical page
mapped to two or more different linear addresses (virtual
aliasing), each with different memory types because it may
lead to undefined operations that can result in a system
failure. [5] By extension, not only are conflicting cache
attributes not allowed for virtual aliasing, they are also
not allowed for physical aliasing.

Physical aliasing is possible through the AGP Aperture
which provides a re-mapping table of Aperture physical page
addresses to DRAM physical page addresses. We will see below
how this causes the actual problem.


Footnotes
---------
[1] AMD x86-64 Architecture Programmer's Manual, Volume 2:
    System Programming, Revision 3.0, Section 7.3 "Memory Types".
[2] Ibid., Section 7.1.2 "Write Ordering"
[3] Ibid., Section 7.2 "Memory Coherency and Protocol"
[4] IA-32 Intel Architecture Software Developer's Manual
    Volume 3: System Programming Guide, Order Number
    245472-006, Section 10.3. "METHODS OF CACHING AVAILABLE"
[5] Ibid., Section 10.12.4. "Programming the PAT"
[6] Ibid., Section 10.11.8. "MTRR Considerations in MP Systems"



Speculation for WB data on Newer Athlon Processors
--------------------------------------------------
Newer AMD processors such as AthlonXP and AthlonMP take
advantage of aggressive Write-Back cacheable optimizations
for speculated read-for-ownership accesses (RFO).  This
helps improve overall processor performance on many
applications. (In the patch code we refer to this
as "advanced speculative caching". )

The discussion below describes the process.


Scenario: Thread 1's speculated read-for-ownership (RFO)
          accesses a datum in memory that is assigned
          "Write-Back" (WB) cache-attribute by Memory Type
          Range Registers.

      [* CPU *]
          |
          |
         (2) 
          |
          |         Cache                       Memory
       +- | -------------+            +---------------+
       |  +              |            |               |
       | /               |            |               |
       +*+---+---+---+---+            +---+---+---+---+
   +---|m| A | B | C | D | <---(1)--- | A | B | C | D | 
   |   +-+---+---+---+---+            +---+---+---+---+ <--+
   |   |        (3)      |            |               |    |
   |   |                 |            |               |    |
   |   |                 |            |               |    |
   |   +-----------------+            |               |    |
   |                                  |               |    |
   |                                  +---------------+    ^
   |                                                       |
   +------------>--------------(4)------------->-----------+


Steps:    1. For thread 1, on a speculated-RFO to WB data,
             the CPU fetches a line from memory and places
             it in cache.

          2. Expecting to write, the CPU marks the line
             modified (dirty) but doesn't modify the line.

          3. If the speculated execution flow is "not taken", the
             line remains unchanged but marked as modified.

          4. As part of normal operation, the cache line is
             evicted from the cache and written back to
             memory, much, much later.  It remains unchanged
             from its original value.

Outcome:  This works just fine because all software and
          processors see the memory as "WB" and so
          cache-coherency protocols come into play to ensure
          correctness.




When Cache Attributes Collide on Newer Athlon Processors
--------------------------------------------------------
Scenario: Thread 1's access sees the datum as WB, but thread 2's
          access to the same datum sees it as "Uncached"
          (UC). Thread 2's UC write bypasses the cache.


      [* CPU *]----------------(4)-------------------------+
          |                                                |
          |                                                |
         (2)                                               |
          |                                                |
          |         Cache                       Memory     |
       +- | -------------+            +---------------+    |
       |  +              |            |               |    |
       | /               |            |               |    |
       +*+---+---+---+---+            +---+---+---+---+ <--+
   +---|m| A | B | C | D | <---(1)--- | A | B | C | D | 
   |   +-+---+---+---+---+            +---+---+---+---+ <--+
   |   |        (3)      |            |      (6)      |    |
   |   |                 |            |               |    |
   |   |                 |            |               |    |
   |   +-----------------+            |               |    |
   |                                  |               |    |
   |                                  +---------------+    ^
   |                                                       |
   +------------>--------------(5)------------->-----------+


Steps:    1. For thread 1, on a speculated-RFO to WB data,
             the CPU fetches a line from memory and places
             it in cache.

          2. Expecting to write, the CPU marks the line
             modified (dirty) but doesn't modify the line.

          3. If the speculated execution flow is "not
             taken", the line remains unchanged but marked
             as modified.

          4. Thread 2 does a write to same memory while the
             line is already cached, but uses a 
             UC mapping, which ignores the CPU cache.

          5. As part of normal operation, the cache line is
             evicted from the cache and written back to
             memory, much, much later. The value written
             back is the original value that was read so
             long ago.

          6. Thread 2's write has been lost; clobbered by
             the writeback from CPU cache.

Outcome:  This causes data corruption because NOT all
          software and processors see the memory as "WB"
          and so cache-coherency protocols can't help ensure
          correctness.



2. The Problem in the Linux Kernel
==================================
Theoretically, there are numerous cases where this conflict
problem in the kernel can occur. However, AMD has seen the
majority of occurrences across Linux Kernels and AMD systems
when an AGP card is present and the AGPGART driver requests
a page from the kernel to map into the Graphics
Aperture. Details follow.

The BIOS enumerates and locates the Graphics Aperture above
the top-of-DRAM.  For AMD Athlon processors and chipsets,
processor and AGP device accesses to an Aperture physical
page address (4KB) is re-mapped by the system chipset to a
DRAM physical page address (4KB) using the Graphics Address
Re-mapping Table (GART).  For each 4KB page in the Aperture
that the AGPGART driver wants to "populate" (let's call it
APP_PA0 in our example below), the driver allocates a 4KB
DRAM page from the kernel (let's call it PHYS_PA0) and then
fills in a GART entry that shows the mapping between the
two.

The BIOS also sets up the Memory-Type-Range-Registers
(MTRRs) to initialize the cache-attributes for the various
ranges of memory. It sets the default cache-attribute type
to UC (uncached). The BIOS then uses the first several (or
just the first) Variable MTRR to specify a cache-attribute
type of WB (write-back). The Linux Kernel tends to use these
settings unmodified. The Graphics Aperture cache-attribute
setting comes from the MTRR default type, which is UC.



                           Physical Address
                                SPACE
   +--------------------> +---------------+ 0x0000,0000                    
   |                      |               |                                
   |                      |               |                                
   |                      | +-----------+ |                                
   |    Thread1           |               |                                
   |    Spec'ltd --WB---> +    PHYS_PA0   + <---UC----------+              
   |    Access            |      4KB      |                 |              
   |                      | +-----------+ |                 |              
   |                      |               |                 |              
   *                      |               |                 |              
[MTRRn.type=WB]           |               |                 |              
   *                      |               |                 |
   |                      |   D R A M     |                 |              
   +--------------------> |               |                 |              
                          +---------------+ top_of_dram     |              
   +--------------------> |///////////////|                 |              
   |                      |///////////////|                 |              
   *                      |///////////////|                 |              
[MTRR_def_type=UC]        +---------------+                 |              
   *                      |               |                 |              
   |                      |               |                 |              
   |                      | +-----------+ |                 |              
   |     Thread2          |               |                 |              
   |     Access  --UC---> +    APP_PA0    +-----UC-----> [*GART*]          
   |     to AGP           |      4KB      |                                
   |     Aperture         | +-----------+ |                                
   |                      |               |                                
   |                      |A P E R T U R E|                                
   |                      +---------------+                                
   |                      |///////////////|                                
   |                      |///////////////|                                
   |                      |///////////////|                                
   +--------------------> +---------------+ 0xffff,ffff                    



The instant the AGPGART driver maps the allocated page
PHYS_PA0 to the aperture page APP_PA0, the cache-attribute
conflict occurs. But data corruption does not typically
occur until a graphics-oriented thread starts writing to the
Graphics Aperture. What often happens it that thread2 writes
control/vertex information for the AGP device into APP_PA0,
but, a write-back to PHYS_PA0 (due to earlier speculation by
thread1) overwrites the data -- usually before the AGP
device has read the data written by thread2. This causes the
AGP device to become unresponsive and ultimately the
graphics software and AGP video driver get confused and
crash the system.

What is difficult to pin down is what code thread1 was
executing that caused the speculated RFO. It is likely that
thread1 is actually the AGPGART driver with some code that
is predicted to write PHYS_PA0 but which doesn't actually do
so. But even if the AGPGART driver were modified in some
torturous way to prevent this, the hole would still be
open. Any software is a candidate for thread1 if it looks
like it has a conditional flow with write access to the
linear page that maps to PHYS_PA0. Thus, the best solutions
to the problem are independent of trying to pin down thread1
candidates.


Architectural Solution
----------------------
The right architectural solution in migrating PHYS_PA0 into
Aperture page APP_PA0 involves actions from the kernel and
the AGPGART driver that ensure the following:


(1) Ensure that PHYS_PA0 does not have a valid PTE or has a
    valid PTE with the Page-Attribute-Table bits specifying
    a UC or WC cache-attribute. This implies that PHYS_PA0
    must have a 4KB page mapping rather than be part of a
    "big" page.


(2) Invalidate any old TLB entries that map PHYS_PA0 in the
    TLBs of all processors in the system.  This is done by
    executing an invlpg after the physical page has been
    migrated into the Aperture on all processors in the
    system.  This implies that PHYS_PA0 must have a 4KB page
    mapping rather than be part of a "big" page.

(3) Ensure that PHYS_PA0 is not cached in any processor by
    doing a WBINVD on all processors.


Non-Solutions
-------------
Note that the problem is not solved if the AGPGART driver
flushes the caches of all processors when allocating the
page from the kernel.  This is because it is the existence
of a valid Virtual Address Translation to PHYS_PA0, which
has a mapping to WB memory, that is the problem; not whether
the location is currently cached or not. 

Just invalidating the virtual address mapping to PHYS_PA0 in
all processor TLBs (invlpg) will not work due to the use of
4MB pages.  Typically, the request for a page from the
AGPGART driver is satisfied from the "lowmem" zone. When 4MB
pages are available on a processor, the kernel likes to use
4MB pages to map the lowmem zone. Thus, the AGPGART driver
can't invalidate the TLB mapping for the 4KB PHYS_PA0 page
because it lives in a 4MB "BIG" page and doing the
invalidation would blow away mappings for many other 4KB
pages as well in the lowmem zone.

Simply avoiding the use of 4MB pages (by using a boot line
option of mem="nopentium") also does not solve the problem,
regardless of whether the TLB entry that maps PHYS_PA0 is
invalidated, because the Athlon speculator, unconstrained,
is allowed to create new TLB entries from valid PTEs in
memory.



3. Short-term Linux Kernel Solution
=================================== 
There is a simple short-term solution that does not cause
major changes in the kernel. It requires "constraining" the
Athlon speculation logic by a simple patch to
arch/i386/kernel/setup.c:

(0) Detect the affected AMD Athlon processors (AthlonXP,
    AthlonMP, etc) and only perform the following steps on
    those.
 
(1) Stop the Athlon speculator from writing new translations
    in to the TLB and so accidentally speculating into
    PHYS_PA0. There is a control bit in a special MSR that
    the kernel needs to set.  This is done by setting the
    MSR control bit on all processors in a system.
 
(2) Prevent the kernel from using 4MB/2MB pages so that the
    Athlon speculator can't use a "big" page TLB entry
    (which may map PHYS_PA0) to speculate into
    PHYS_PA0. This is done by clearing the X86_FEATURE_PSE
    bit in boot_cpu_data.x86_capability ahead of the call to
    paging_init() in setup.c .


AMD has done rigorous testing of a kernel patch with only
the above steps and has seen no failures to
date. We are still doing some more testing, but, believe
the patch is ready for the light of day. It is at:

  ftp://ftp.suse.com/pub/people/ak/v2.4/amd-adv-spec-caching-disable-2.4.19pre9-1

Theoretically, this still leaves a hole because there is
still the possibility of a valid 4KB TLB entry that maps
PHYS_PA0 in the TLB; to close this hole, the PTE that maps
PHYS_PA0 should be marked as invalid.  However, as our
testing shows, we can squeak by without it.


 
4. Long-term Linux Kernel Solution
==================================
In theory highmem could be used for GART mappings because
there are no kernel mappings with possibly conflicting
caching attributes to it, but it has some drawbacks that
make it not seem like a good idea: most GART implementations
do not support addresses >4GB, so it would be required to
split the highmem zone in highmem below 4GB and highmem
above 4GB.  It would require adding highmem emulation to all
machines and also add a fixed upper limit to the pages that
could be possibly allocated for AGP.

These drawbacks make the following solution look better:

The kernel mapping needs to be dynamically changed to
contain the correct caching attributes for all pages.  This
requires changing the 2/4MB mappings to 4K mappings when
there are pages with non standard caching attribute in a 4MB
area and modify the linear map as needed. When a page is
allocated for the AGPGART it is set to uncacheable in the
linear map. Also the mapping is flushed on all CPUs and an
WBINVD is initiated. When all pages in an split 2/4MB have
normal PAGE_KERNEL protection again they can be reverted to
a large page mapping.

Disadvantage of the changes in the linear mapping is that it
could have a huge performance impact when the pages with non
standard caching attributes are distributed evenly through
the memory. In the worst case all large pages could be split
this way, causing additional load to the TLBs.

Best would be to change all allocators of pages with non
standard cache attributes to allocate as huge orders as
possible and return memory from these bigger clusters.  This
would ensure that as few 2/4MB pages as possible are split
to 4K mappings. Implementing this for AGP would require the
user space interface to tell the kernel agpgart driver how
many pages are needed.  Currently the number of pages are
passed in via an ioctl when allocating an "AGP key", so it
would be possible to implement this. Another way would be to
abuse the GFP_DMA zone to cluster pages, but this would only
work upto 16MB of AGP memory.

An experimental patch to do this 2.4 exists, but hasn't been
verified to fix the problem yet. It implements a basic
mechanism to set page attributes for pages in the kernel
map, but doesn't do any optimizations to cluster these
pages. The interface is a:

  int change_page_attr(struct page *, pgprot_t) 

function that is implemented for i386. It is available at:

  ftp://ftp.suse.com/pub/people/ak/v2.4/pageattr-2.4.19pre9-2

In the future it may be useful to support mappings with non
standard caching attributes generically for user space
(e.g. some applications get a speedup from write
combining). When this is implemented some equivalent to
change_page_attr() needs to be used to change the attributes
of lowmem pages that are in such special mappings. In the
case of highmem pages kmap() would need to be modified to
map with the correct caching attribute.


-Rich ...
[richard.brunner@amd.com    -- (360)-867-0654]
[Senior Member, Technical Staff, SW R&D @ AMD]

