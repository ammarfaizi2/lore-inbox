Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRHLRC0>; Sun, 12 Aug 2001 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269387AbRHLRCR>; Sun, 12 Aug 2001 13:02:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33300 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269372AbRHLRCD>; Sun, 12 Aug 2001 13:02:03 -0400
Date: Sun, 12 Aug 2001 19:02:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8aa1
Message-ID: <20010812190202.H737@athlon.random>
In-Reply-To: <20010811160231.C19169@athlon.random> <Pine.LNX.4.33.0108111105470.15497-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108111105470.15497-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 11, 2001 at 11:20:07AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 11:20:07AM -0700, Linus Torvalds wrote:
> 
> Andrea,
>  mind cleaning this up a bit and not just papering over the horridness?

I'm sorry but while fixing the compilation troubles I didn't spent one
millisecond looking at what the code was trying to achieve despite it
looked doing something silly, I was just doing a blind
sed/page->virtual/page_address(page)/ and I cared to communicate the
community to never use page->virtual but to always use page_address()
instead. Infact you obviously didn't looked at such horrid code either
when you included it between 2.4.8pre6 and 2.4.8pre7 (not that I pretend
you to look at every driver update you include of course, this is not a
remark, it's just a matter of fact):

diff -urN 2.4.8pre6/drivers/char/drm/drm_vm.h
2.4.8pre7/drivers/char/drm/drm_vm.h
--- 2.4.8pre6/drivers/char/drm/drm_vm.h	Thu Jan  1 01:00:00 1970
+++ 2.4.8pre7/drivers/char/drm/drm_vm.h	Wed Aug  8 22:06:34 2001
[..]
+	physical = (unsigned long)pte_page( *pte )->virtual;
+	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */
[..]

BTW, I think it would be nice if we also avoid to waste ram and x86 ram
bandwith with page->virtual in mainline where it's not needed, here the
patch (possibly other archs could use it too by simply defining the
CONFIG_NO_PAGE_VIRTUAL to Y when highmem is not defined, but I thought
it was mostly important for x86 lowend):

diff -urN 2.4.6pre5/arch/i386/config.in novirtual/arch/i386/config.in
--- 2.4.6pre5/arch/i386/config.in	Thu Jun 21 08:03:30 2001
+++ novirtual/arch/i386/config.in	Thu Jun 21 16:02:11 2001
@@ -165,6 +165,9 @@
    define_bool CONFIG_HIGHMEM y
    define_bool CONFIG_X86_PAE y
 fi
+if [ "$CONFIG_NOHIGHMEM" = "y" ]; then
+   define_bool CONFIG_NO_PAGE_VIRTUAL y
+fi
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
diff -urN 2.4.6pre5/include/asm-i386/pgtable.h novirtual/include/asm-i386/pgtable.h
--- 2.4.6pre5/include/asm-i386/pgtable.h	Thu Jun 14 18:07:49 2001
+++ novirtual/include/asm-i386/pgtable.h	Thu Jun 21 16:02:11 2001
@@ -255,7 +255,11 @@
  * Permanent address of a page. Obviously must never be
  * called on a highmem page.
  */
+#ifdef CONFIG_NO_PAGE_VIRTUAL
+#define page_address(page) __va((page - mem_map) << PAGE_SHIFT)
+#else
 #define page_address(page) ((page)->virtual)
+#endif
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
 
 /*
diff -urN 2.4.6pre5/include/linux/mm.h novirtual/include/linux/mm.h
--- 2.4.6pre5/include/linux/mm.h	Thu Jun 21 08:03:56 2001
+++ novirtual/include/linux/mm.h	Thu Jun 21 16:02:33 2001
@@ -160,8 +160,10 @@
 	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
 	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
+#ifndef CONFIG_NO_PAGE_VIRTUAL
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
+#endif
 	struct zone_struct *zone;	/* Memory zone we are in. */
 } mem_map_t;
 
diff -urN 2.4.6pre5/mm/page_alloc.c novirtual/mm/page_alloc.c
--- 2.4.6pre5/mm/page_alloc.c	Thu Jun 21 08:03:57 2001
+++ novirtual/mm/page_alloc.c	Thu Jun 21 16:02:11 2001
@@ -851,8 +851,10 @@
 		for (i = 0; i < size; i++) {
 			struct page *page = mem_map + offset + i;
 			page->zone = zone;
+#ifndef CONFIG_NO_PAGE_VIRTUAL
 			if (j != ZONE_HIGHMEM)
 				page->virtual = __va(zone_start_paddr);
+#endif
 			zone_start_paddr += PAGE_SIZE;
 		}
 

> On Sat, 11 Aug 2001, Andrea Arcangeli wrote:
> >
> > This is the same problem I mentioned yesterday to the list. Nobody
> > should ever use page->virtual directly, it's not there in -aa when
> > highmem is disabled to save memory and increase performance, if it would
> > be in C or python it would be a private field of the class to make it
> > explicit (nitpicking, in python __ just rename and it's techincally
> > still visible from the outside of the class).
> >
> > page_address(page) must be used instead of page->virtual.
> 
> It would be good to instead adding the functions
> 
> 	unsigned long pte_to_pfn(pte_t pte)
> 	{
> 		.. architecture-specific in asm/pgtable.h ..
> 	}
> 
> 	/*
> 	 * struct page -> "page frame number", ie
> 	 * physical page number.
> 	 */
> 	unsigned long page_to_pfn(struct page *page)
> 	{
> 		zone_t zone = page->zone;
> 		return (page - zone->zone_mem_map) + zone->zone_start_mapnr;
> 	}
> 
> 	unsigned long long page_to_bus(struct page *page)
> 	{
> 		return (unsigned long long) phys_to_bus(page_to_pfn(page) << PAGE_SHIFT;
> 	}
> 
> and using those? As it is right now, drivers that _could_ use up to 4GB of
> bus addresses simply cannot do it, because there is no good way to get the
> high physical addresses from a "struct page".
> 
> (You can do the above by hand, of course, but device driver writers really
> shouldn't know about the internals of page zone handling).
> 
> The things that you changed were all
> 
> 	virt_to_bus( page_address (...) )
> 
> which really is rather distateful in that it artificially limits itself to
> only lowmem code, and gets randomly incorrect values for anything else.

virt_to_bus(page_address(pte_page(pte))) actually returns the right bus
address on x86 in a range of 4G, so the first part of the highmem (99%
of boxes where those drivers are needed I guess) gets covered too (of
course also virt_to_bus is limited to 32bit in its reval in first place
so anything physical above 4g breaks on the 32bit boxes). In 2.2 instead
virt_to_bus malfunctions on _all_ the highmem "virtual addresses" (if we
can call ""virtual addresses"" the wrap around).

But of course calling page_address() on anything highmem is ugly like
hell even if it ""incidentally"" works on 2.4 up to 4G (it temporarly
wraps around in userspace).

Furthmore the worst bug here is that calling virt_to_bus will break
badly on alpha or any other 64bit arch. virt_to_bus should never used
and it should been undefined by davem when he introduced in the iommu
API so people would stop doing those mistakes even today in a 2.4.8
driver update. The pci api on x86 will work up to 4G (as well as the
virt_to_bus(page_address(pte_page(pte))) and then it will break because
there's not iommu on x86, while on the real 64bit platforms it works for
all the physical ram, but nobody checks for the reval so the iommu
capable platforms are prone to break too.

Also the fact we pass virtual addresses to the pci_map API is quite
an ugly API for the 32bit platforms, same ugliness of
virt_to_bus(page_address(pte_page(pte))) on the memory between 1G and
4G, it was really only supposed to get the lowmem virtual addresses
infact (as virt_to_bus after all).

For your suggestion of the pte_to_pfn and the reverse I'm not sure why
they're needed (of course for the arch is extremely simple to implement
pte_to_pfn, on x86 is a shitright of 12, on alpha it's a shiftright of
32, much simpler than pte_page, pte_page has to deal with discontigmem
on numa system so it's slower). But in general people shouldn't use
pte_page in drivers, they shouldn't walk pagetables, the vm of linux
walks pagetables instead. We need pte_page for things like ptrace,
flushing of dirty pagetables etc... when we have virtual userspace
addresses and we must find the pages we are working with. But a device
driver can either get the page structure via the kiobuf if it's using
the direct I/O "pinning userspace memory way" or allocate the memory
itself inside the driver so it will have to deal again only with an arry
of page structures in first place, never with pte_page. So any usage of
pte_page in drivers looks a bit suspect on the design side.

Now about your page_to_bus suggestion I think it's on the right track,
virt_*anything* has to die, we cannot deal with kernel virtual addresses
on pci data any longer, people should either use pfn or page structures
(page structures is the most generic and preferred way I believe because
drivers should only deal with page structures as said above).

So I believe a kind of page_to_bus64 should be implemented, and it should
possibly return dma64_addr_t typedeffed as 'unsigned long long'.

But the real problem is how to have the driver understand that on some
arch it should keep using the iommu 32bit api instead of DAC because
those archs have crappy PCI64 DAC hardware implementation that inhibits
pci prefetch cycles or stuff like that that leads to bad performance
(DaveM can certainly provide more details). This is the hard part of the
API I believe. So we either need the driver to have two explicit cases
(then the plain page_to_bus64 would not need other changes), or to hide
the iommu stuff inside the page_to_bus64, but in such case it means we
also need to have a second function to release the pte ala pci_unmap_*.

BTW, at the moment what the quadrics and myri folks are doing on alpha
in 2.4 is just to use the monster window by hand and to use DAC where
avaialble, we enabled it by default on the tsunami chipsets for that
reason (for those drivers that maps huge amounts of ram it's manadatory
not to generate pressure on the iommu pagetables or they can destabilize
the system since all drivers are buggy and they don't check for iommu
map functions faliures). The myri folks told me if the monster window is
not available they now have an high bound of 32mbytes of data in flight
again to avoid those stability troubles and that looks fine.

And what the driver should ever do when its device is 32bit and it gets
a bus address out of page_to_bus64 that overflows 32bit and no iommu is
available? To handle that case it should either enforce that condition
not to happen by design (by allocating its pages without __GFP_HIGHMEM
if it's using the mmap callback, of course with map_user_kiobuf directIO
way it's not possible to enforce it by design instead) or to preallocate
some lowmem page to do the bounce buffers (note: it cannot allocate the
lowmem page on the fly if it is in a path that could be used to release
memory, like I/O or it could deadlock, the memory reservation should be
provided by the VM as Stephen suggested, Ben has some patches for that.
The advantage of the having the reservation provided by the VM rather
than having each subsystem preallocating a minimal amount of ram that
allows it to make progress regardless of GFP [like highmem.c currently
does] is that the VM has the knowledge to still allow those "reserved"
pages to be used as "clean unmapped cache", so they would not be wasted,
but it must not be "clean cache" as it is now, it should really be "not
locked" and "unmapped" atomically freeable cache, as soon as somebody
wants to do I/O or map the page in userspace, the page should be refiled
and replaced, and possibly the I/O should wait for some other memory to
be freed before the lock/map on the page can succeed, so it's *way* more
complicated than what I seen implemented so far by Ben if we want
something reliable).

> > @@ -107,7 +107,7 @@
> >  	if( !pmd_present( *pmd ) ) return NOPAGE_OOM;
> >  	pte = pte_offset( pmd, i );
> >  	if( !pte_present( *pte ) ) return NOPAGE_OOM;
> > -	physical = (unsigned long)pte_page( *pte )->virtual;
> > +	physical = (unsigned long)page_address(pte_page( *pte ));
> >  	atomic_inc(&virt_to_page(physical)->count); /* Dec. by kernel */
> 
> That is just too ugly for words. It's not a "physical" address at all, but
> a virtual one, and we're getting the virtual address from the struct page
> just to get back to the struct page.
> 
> It should really do
> 
> 	struct page *page = pte_page( *pte );
> 	get_page(page);
> 
> instead..

Indeed ;)

Andrea
