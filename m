Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSDZWq1>; Fri, 26 Apr 2002 18:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314413AbSDZWq0>; Fri, 26 Apr 2002 18:46:26 -0400
Received: from [195.223.140.120] ([195.223.140.120]:12402 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314396AbSDZWqW>; Fri, 26 Apr 2002 18:46:22 -0400
Date: Sat, 27 Apr 2002 00:46:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020427004641.L19278@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 07:27:11PM +0100, Russell King wrote:
> Hi,
> 
> I've been looking at some of the ARM discontigmem implementations, and
> have come across a nasty bug.  To illustrate this, I'm going to take
> part of the generic kernel, and use the Alpha implementation to
> illustrate the problem we're facing on ARM.
> 
> I'm going to argue here that virt_to_page() can, in the discontigmem
> case, produce rather a nasty bug when used with non-direct mapped
> kernel memory arguments.
> 
> In mm/memory.c:remap_pte_range() we have the following code:
> 
>                 page = virt_to_page(__va(phys_addr));
>                 if ((!VALID_PAGE(page)) || PageReserved(page))
>                         set_pte(pte, mk_pte_phys(phys_addr, prot));
> 
> Let's look closely at the first line:
> 
>                 page = virt_to_page(__va(phys_addr));
> 
> Essentially, what we're trying to do here is convert a physical address
> to a struct page pointer.
> 
> __va() is defined, on Alpha, to be:
> 
> 	#define __va(x)  ((void *)((unsigned long) (x) + PAGE_OFFSET))
> 
> so we produce a unique "va" for any physical address that is passed.  No
> problem so far.  Now, lets look at virt_to_page() for the Alpha:
> 
> 	#define virt_to_page(kaddr) \
> 	     (ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
> 
> Looks inoccuous enough.  However, look closer at ADDR_TO_MAPBASE:
> 
> 	#define ADDR_TO_MAPBASE(kaddr) \
>                         NODE_MEM_MAP(KVADDR_TO_NID((unsigned long)(kaddr)))
> 	#define NODE_MEM_MAP(nid)       (NODE_DATA(nid)->node_mem_map)
> 	#define NODE_DATA(n)		(&((PLAT_NODE_DATA(n))->gendata))
> 	#define PLAT_NODE_DATA(n)       (plat_node_data[(n)])
> 
> Ok, so here we get the map base via:
> 
> 	plat_node_data[KVADDR_TO_NID((unsigned long)(kaddr))]->
> 		gendata.node_mem_map
> 
> plat_node_data is declared as:
> 
> 	plat_pg_data_t *plat_node_data[MAX_NUMNODES];
> 
> Lets look closer at KVADDR_TO_NID() and MAX_NUMNODES:
> 
> 	#define KVADDR_TO_NID(kaddr)    PHYSADDR_TO_NID(__pa(kaddr))
> 	#define __pa(x)                 ((unsigned long) (x) - PAGE_OFFSET)
> 	#define PHYSADDR_TO_NID(pa)     ALPHA_PA_TO_NID(pa)
> 	#define ALPHA_PA_TO_NID(pa)     ((pa) >> 36)    /* 16 nodes max due 43bit kseg */
> 
> 	#define MAX_NUMNODES            WILDFIRE_MAX_QBB
> 	#define WILDFIRE_MAX_QBB        8       /* more than 8 requires other mods */
> 
> So, we have a maximum of 8 nodes total, and therefore the plat_node_data
> array is 8 entries large.
> 
> Now, what happens if 'kaddr' is below PAGE_OFFSET (because the user has
> opened /dev/mem and mapped some random bit of physical memory space)?
> 
> __pa returns a large positive number.  We shift this large positive
> number left by 36 bits, leaving 28 bits of large positive number, which
> is larger than our total 8 nodes.
> 
> We use this 28-bit number to index plat_node_data.  Whoops.
> 
> And now, for the icing on the cake, take a look at Alpha's pte_page()
> implementation:
> 
>         unsigned long kvirt;                                            \
>         struct page * __xx;                                             \
>                                                                         \
>         kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));     \
>         __xx = virt_to_page(kvirt);                                     \
>                                                                         \
>         __xx;                                                           \
> 
> 
> Someone *please* tell me where I'm wrong.  I really want to be wrong,
> because I can see the same thing happening (in theory, and one report
> in practice from a developer) on a certain ARM platform.
> 
> On ARM, however, we have cherry to add here.  __va() may alias certain
> physical memory addresses to the same virtual memory address, which
> makes:
> 
> 	VALID_PAGE(virt_to_page(__va(phys)))
> 
> completely nonsensical.

correct. This should fix it:

--- 2.4.19pre7aa2/include/asm-alpha/mmzone.h.~1~	Fri Apr 26 10:28:28 2002
+++ 2.4.19pre7aa2/include/asm-alpha/mmzone.h	Sat Apr 27 00:30:02 2002
@@ -106,8 +106,8 @@
 #define kern_addr_valid(kaddr)	test_bit(LOCAL_MAP_NR(kaddr), \
 					 NODE_DATA(KVADDR_TO_NID(kaddr))->valid_addr_bitmap)
 
-#define virt_to_page(kaddr)	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
-#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
+#define virt_to_page(kaddr)	(KVADDR_TO_NID((unsigned long) kaddr) < MAX_NUMNODES ? ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr) : 0)
+#define VALID_PAGE(page)	((page) != NULL)
 
 #ifdef CONFIG_NUMA
 #ifdef CONFIG_NUMA_SCHED

It still doesn't cover the ram between the end of a node and the start
of the next node, but at least on alpha-wildfire there can be nothing
mapped there (it's reserved for "more dimm ram" slots) and it would be
even more costly to check if the address is in those intra-node holes.

The invalid pages now will start at phys addr 64G*8 that is the maximum
ram that linux can handle the the wildfire. if you mmap the intra-node
ram via /dev/mem you risk for troubles anyways because there's no dimm
there and probably the effect is undefined or unpredictable, it's just a
"mustn't do that", /dev/mem is a "root" thing so the above approch looks
fine to me.

Andrea
