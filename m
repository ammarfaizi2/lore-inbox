Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265771AbTGABZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 21:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbTGABZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 21:25:40 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:11208 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265771AbTGABZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 21:25:32 -0400
Date: Tue, 1 Jul 2003 02:39:47 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Memory Management List <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: What to expect with the 2.6 VM
Message-ID: <Pine.LNX.4.53.0307010238210.22576@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writing a small paper on the 2.6 VM for a conference. It is based on
2.5.73 and is basically an introduction to some of the new features that are
up and coming. As it's only an introduction, it's a little light on heavy
detail. Below is the parts of the paper which I thought would be of general
interest (I left out stuff like the abstract, introduction, conclusion and
bibliography). Any comments, feedback or pointings out of big features I've
missed are appreciated.




                        Linux Virtual Memory Management
                         Some Things to Expect In 2.6

   Describing Memory
   =================

   The 2.6 VM has put a lot of effort into being scalable to enterprise level
   architectures while trying not to compromise on performance on low to mid
   level computers. Consequently, a number of the changes are aimed at
   reducing spin lock contention and keeping operations local to the CPU
   where possible.

   Physical nodes for NUMA architectures are described in a very similar
   manner to 2.4 which just two minor differences. The first difference is
   that the starting location of the node is now identified by a Page Frame
   Number (PFN) instead of as a physical address which is an offset of pages
   within the virtual mem_map array. This solved the problem of where
   architecture used addressing extensions such as Intel's Physical Address
   Extensions (PAE) which cannot be addressed by a 32 number. The second is
   that each node now has its own wait queue for the page replacement daemon
   kswapd which is discussed further in a later section.

   The principal changes made to how zones are represented is related to the
   page replacement policy. The LRU lists for pages and the associated locks
   are now per-zone where they were global with 2.4. As LRU lists could grow
   quite large, especially if IO intensive applications were running, the old
   LRU list lock could heavily contended. This resulted in the LRU list being
   locked while kswapd performed a linear search for pages in the zone of
   interest. As the lists are now per-zone, and an instance of kswapd runs
   for each node, the contention is greatly reduced.

   The second noticeable change is aimed at improving CPU cache usage for
   which Linux now uses a few simple tricks. The first utilises a padding in
   the structures to ensure that zone>lock and
   zone>lru_lock use separate lines [Sea] in the CPU cache. To
   further alleviate lock contention, a list of pages, called a pageset, is
   maintained for each CPU in the system and for each zone with
   per_cpu_pageset array which is discussed later with Section 7.

   Pages are represented in almost the same fashion as 2.4 except for one
   innocent looking difference. In 2.4, process pages tables were traversed
   to locate the struct page that represented the page mapped by the process.
   However, there was no mechanism that would give a list of Page Table
   Entries (PTE) that had mapped a particular page. This is now addressed by
   what is referred to as Reverse Mapping1. PTEs which map a page can now be
   found by traversing a chain of PTEs which is headed by a list stored in
   the struct page. This is discussed later in Section 3.

   Reverse Page Table Mapping
   ==========================

   One of the most important introductions in the 2.6 kernel is Reverse
   Mapping commonly referred to as rmap. In 2.4, there is a one way mapping
   from a PTE to a struct page which is sufficient for process addressing.
   However, this presents a problem for the page replacement algorithm when
   dealing with shared pages are used as there is no way in 2.4 to acquire a
   list of PTEs which map a particular struct page without traversing the
   page tables for every running process in the system.

   In 2.6, a new field is introduced to the struct page called union pte.
   When a page is shared between two or more processes, a PTE chain is
   created and linked to this field. PTE chain elements are managed by the
   slab allocator and each node is able to locate up to NRPTE number of PTEs
   where NRPTE is related to the L1 cache size of the target architecture.
   Once NRPTE PTEs have been mapped, a new node is added to the PTE chain.

   Using these chains, it is possible for all PTEs mapping a struct page to
   be located and swapped out to backing storage. This means that it is now
   unnecessary for whole processes to be swapped out when memory is tight and
   most pages in the LRU lists are shared as was the case with 2.4. The 2.6
   VM is able to make much better page replacement decisions as the LRU list
   ordering is obeyed.

   PTEs in High Memory
   ===================

   In 2.4, Page Table Entries (PTEs) must be allocated from ZONE_ NORMAL as
   the kernel needs to address them directly for page table traversal. In a
   system with many tasks or with large mapped memory regions, this can place
   significant pressure on ZONE_ NORMAL so 2.6 has the option of allocating
   PTEs from high memory.

   Allocating from high memory is a compile time option as there is a
   significant penalty associated with high memory PTEs. As the PTEs can no
   longer be addressed directly by the kernel, kmap() must be used to map the
   high memory page into lower memory. It must be later unmapped with
   kunmap() placing a limit on the number of PTEs that can be addressed by a
   CPU at a time.

   To reflect the move of PTEs to high memory, the API related to PTEs has
   changed. The allocation function pte_alloc() has been replaced by two
   functions. pte_alloc_kernel() is for kernel PTEs and are always allocated
   from ZONE_ NORMAL. pte_alloc_map() for userspace allocations.

   As the PTEs need to be mapped before addressing, page table walking has
   changed slightly. In 2.4, the PTE could be referenced directly but in 2.6,
   pte_offset_map() must be called before it may be used and pte_unmap()
   called as quickly as possible to unmap it again.

   The overhead of mapping the PTEs from high memory should not be ignored.
   Generally, only one PTE may be mapped at a time for a CPU with the rare
   exception when pte_offset_map_nested() is used. This can be a heavy
   penalty when all PTEs need to be examined such as when a memory region is
   being unmapped. It has been proposed to have a Userspace Kernel Virtual
   Area (UKVA) which is a region in the kernel address space private to a
   process. This UKVA could be used to map high memory PTEs into low memory
   but it is currently a proposal and unlikely to be merged by 2.6.

   At time of writing, a patch has been submitted which implemented PMDs in
   high memory. The implementation is essentially the same as PTEs in high
   memory.

   Huge TLB Filesystem
   ===================

   Most modern architectures support more than one page size. For example,
   the IA-32 architecture supports 4KiB pages or 4MiB pages but Linux only
   used large pages for mapping the actual kernel image. As TLB slots are a
   scarce resource, it is desirable to be able to take advantages of the
   large pages especially on machines with large amounts of physical memory.

   In 2.6, Linux allows processes to use large pages, referred to as huge
   pages. The number of available huge pages is configured by the system
   administrator via the /proc/sys/vm/nr_hugepages proc interface. As the
   success of the allocation depends on the availability of physically
   contiguous memory, the allocation should be made during system startup.

   The root of the implementation is a Huge TLB Filesystem (hugetlbfs) which
   is a pseudo-filesystem implemented in fs/hugetlbfs/inode.c and based on
   ramfs. The basic idea is that any file that exists in the filesystem is
   backed by huge pages. This filesystem is initialised and registered as an
   internal filesystem at system start-up.

   There is two ways that huge pages may be accessed by a process. The first
   is by using shmget() to setup a shared region backed by huge pages and the
   second is the call mmap() on a file opened in the huge page filesystem.

   When a shared memory region should be backed by huge pages, the process
   should call shmget() and pass SHM_HUGETLB as one of the flags. This
   results in a file being created in the root of the internal filesystem.
   The name of the file is determined by an atomic counter called
   hugetlbfs_counter which is incremented every time a shared region is
   setup.

   To create a file backed by huge pages, a filesystem of type hugetlbfs must
   first be mounted by the system administrator. Once the filesystem is
   mounted, files can be created as normal with the system call open(). When
   mmap() is called on the open file, the hugetlbfs registered mmap()
   function creates the appropriate VMA for the process.

   Huge TLB pages have their own function for the management of page tables,
   address space operations and filesystem operations. The names of the
   functions for page table management can all be seen in $<$linux/hugetlb.h
   $>$ and they are named very similar to their ``normal'' page equivalents.

   Non-Linear Populating of Virtual Areas
   ======================================

   In 2.4, a VMA backed by a file would be populated in a linear fashion.
   This can be optionally changed in 2.6 with the introduction of the
   MAP_POPULATE flag to mmap() and the new system call remap_file_pages().
   This system call allows arbitrary pages in an existing VMA to be remapped
   to an arbitrary location on the backing file. This is mainly of interest
   to database servers which previously simulated this behavior by the
   creation of many VMAs.

   On page-out, the non-linear address for the file is encoded within the PTE
   so that it can be installed again correctly on page fault. How it is
   encoded is architecture specific so two macros are defined called
   pgoff_to_pte() and pte_to_pgoff() for the task.

   Physical Page Allocation
   ========================

   Physical page allocation is still based on the buddy algorithm but it has
   been extended to resemble a lazy buddy algorithm which delays the
   splitting and coalescing of buddies until it is necessary [BL89]. To
   implement this, kernel 2.6 has per-cpu page lists of 0 order pages, the
   most common type of allocation and free. These pagesets contain two lists
   for hot and cold pages where hot pages have been recently used and can
   still be expected to be present in the CPU cache. For an allocation, the
   pageset for the running CPU will be first checked and if pages are
   available, they will be allocated. To determine when the pageset should be
   emptied or filled, two watermarks are in place. When the low watermark is
   reached, a batch of pages will be allocated and placed on the list. When
   the high watermark is reached, a batch of pages will be freed at the same
   time. Higher order allocations are treated essentially the same as they
   were in 2.4.

   The implication of this change is straight forward, the number of times
   the spinlock protecting the buddy lists must be acquired is drastically
   reduced. Higher order allocations are relatively rare in Linux so the
   optimisation is for the common case. This change will be noticeable on
   large number of CPU machines but will make little difference to single
   CPUs.

   The second major change is largely cosmetic with function declarations,
   flags and defines bring moved to new header files. One important part of
   the shuffling is that the distinction between NUMA and UMA architectures
   no longer exists for page allocations. In 2.4, there was an explicit
   function which implemented a node-local allocation policy. In 2.6,
   architectures are expected to provide a CPU to NUMA node mapping. They
   then export a macro called NODE_DATA() which takes the NID, returned by
   numa_node_id() as a parameter. With UMA architectures, this will always
   return the static node descriptor contig_page_data, but with NUMA
   architectures, the node ``closest'' to the running CPU will be used. This
   is still a node-local allocation policy but without the two separate
   allocation schemes. This change is largely a ``cleaniness'' issue reducing
   the amount of special case code that deals with UMA and NUMA architectures
   separately.

   The last major change is the introduction of three new GFP flags called
   __GFP_NOFAIL, __GFP_REPEAT and __GFP_NORETRY. The three flags determine
   how hard the VM works to satisfy a given allocation and were introduced as
   the flags are implemented in many different parts of the kernel. The
   NOFAIL flag requires teh VM to constantly retry an allocation until it
   succeeds. The REPEAT flag is intended to retry a number of times before
   failing, although currently it is implemented like NOFAIL. The last,
   NORETRY says that an allocation will fail immediately and return.

   Delayed Coalescing
   ==================

   2.6 extends the buddy algorithm to resemble a lazy buddy algorithm [BL89]
   which delays the splitting and coalescing of buddies until it is
   necessary. The delay is implemented only for 0 order allocations with the
   per-cpu pagesets. Higher order allocations, which are rare anyway, will
   require the interrupt safe spinlock to be held and there will be no delay
   in the splits or coalescing. With 0 order allocations, splits will be
   delayed until the low watermark is reached in the per-cpu set and
   coalescing will be delayed until the high watermark is reached.

   It is interesting to note that there is a possibility that high order
   allocations will fail if many of the pagesets are just below the high
   watermark. There is also the problem that buddies could exist in different
   pagesets leading to fragmentation problems.

   Emergency Memory Pools
   ======================

   In 2.4, the high memory manager was the only subsystem that maintained
   emergency pools of pages. In 2.6, memory pools are implemented as a
   generic concept when a minimum amount of ``stuff'' needs to be reserved
   for when memory is tight. ``Stuff'' in this case can be any type of object
   such as pages in the case of the high memory manager or, more frequently,
   some object managed by the slab allocator.

   Pools are created with mempool_create() and a number of parameters are
   provided. They are the minimum number of objects that should be reserved
   (min_nr), an allocator function for the object type (alloc_fn()), a free
   function (free_fn()) and optional private data that is passed to the
   allocate and free functions.

   In most cases, the allocate and free functions used are
   mempool_alloc_slab() and mempool_free_slab() for reserving objects managed
   by the slab allocator. In this case, the private data based is a pointer
   to the slab cache descriptor.

   In the case of the high memory manager, two pools of pages are created. On
   page pool is for normal use and the second page pool is for use with ISA
   devices that must allocate from ZONE_ DMA. The memory pools replace the
   emergency pool code that exists in 2.4.

   Aging Slab Allocator Objects
   ============================

   Many of the changes in the slab allocator for 2.6 are either cosmetic or
   are related to the reduction of lock contention. However, one significant
   new feature is the introduction of slab shrinker callback.

   In 2.4, the function kmem_cache_reap() was called in low memory situations
   which selected a cache to delete all free slabs from and free objects in
   the per-cpu object cache. In 2.6, caches can register a shrinker callback
   with set_shrinker() and kmem_cache_reap() has been dispensed with.

   set_shrinker() populates a struct with a pointer to the callback and a
   ``seeks' weight which indicates how hard it is to recreate the object.
   During page reclaim, each shrinker is called twice. The first call passes
   0 as a parameter which indicates that the callback should return how many
   pages it expects it could free if it was called properly. A basic
   heuristic is applied to determine if it is worth the cost of using the
   callback. If it is, it is called a second time with a parameter indicating
   how many objects to free.

   Page Replacement
   ================

   In the 2.4 kernel, a global daemon called kswapd acted as the page
   replacement daemon. It was responsible for keeping a reserve of memory
   free and only when memory was tight would processes have to free pages on
   their own behalf. In 2.6, a kswapd daemon exists for each node in the
   system. Each daemon is called kswapdN where N is the node ID. The
   presumption is that there will be a one-to-few mapping between CPUs and
   nodes and Linux wishes to avoid a penalty of a kswapd daemon trying to
   free pages on a remote node.

   Manipulating LRU Lists
   ======================

   In 2.4, a spinlock is acquired when removing pages from the LRU list. This
   made the lock very heavily contended so in 2.6, operations involving the
   LRU lists take place via struct pagevec structures. This allows pages to
   be added or removed from the LRU lists in batches of up to PAGEVEC_SIZE
   numbers of pages.

   When removing pages, the zone>lru_lock lock is acquired and
   the pages placed on a temporary list. Once the list of pages to remove is
   assembled, shrink_list() is called to perform the actual freeing of pages
   which can now perform most of it's task without needing the
   zone>lru_lock spinlock.

   When adding the pages back, a new page vector struct is initialised with
   pagevec_init(). Pages are added to the vector with pagevec_add() and then
   committed to being placed on the LRU list in bulk with pagevec_release().

    Footnotes

   ... Mapping1
           Reverse mapping is commonly referred to as rmap although the
           phrase rmap is sometimes a little overloaded.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel
