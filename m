Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbRCIQW6>; Fri, 9 Mar 2001 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130542AbRCIQWs>; Fri, 9 Mar 2001 11:22:48 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:3005 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130540AbRCIQWj>; Fri, 9 Mar 2001 11:22:39 -0500
Date: Fri, 09 Mar 2001 08:18:17 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <055e01c0a8b4$8d91dbe0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
 <00d401c0a5c6$f289d200$6800000a@brownell.org>
 <20010305232053.A16634@flint.arm.linux.org.uk>
 <15012.27969.175306.527274@pizda.ninka.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> Russell King writes:
>  > A while ago, I looked at what was required to convert the OHCI driver
>  > to pci_alloc_consistent, and it turns out that the current interface is
>  > highly sub-optimal.  It looks good on the face of it, but it _really_
>  > does need sub-page allocations to make sense for USB.
>  > 
>  > At the time, I didn't feel like creating a custom sub-allocator just
>  > for USB, ...
> 
> Gerard Roudier wrote for the sym53c8xx driver the exact thing
> UHCI/OHCI need for this.

I looked at that, and it didn't seem it'd drop in very easily.

I'd be interested in feedback on the API below.  It can
handle the USB host controllers (EHCI/OHCI/UHCI) on
currently unsupported hardware (the second bug I noted).
Questions:  is it general enough for other drivers to use?
Should I package it as a patch for 2.4?

There's also a simple implementation, which works (to limited
testing) but would IMO better be replaced by something using
the innards of the slab allocator (mm/slab.c).  That'd need new
APIs inside that allocator ... those changes seem like 2.5 fixes,
unlike the slab allocator bug(s) I pointed out.  (And which
Manfred seems to have gone silent on.)

- Dave


/* LOGICALLY:  <linux/pci.h> */

/*
 * This works like a pci-dma-consistent kmem_cache_t would, and handles
 * alignment guarantees for its (small) memory blocks.  Many PCI device
 * drivers need such functionality.
 */
struct pci_pool;


/* Create a pool - flags are SLAB_* */
extern struct pci_pool *
pci_pool_create (const char *name, struct pci_dev *pdev,
  int size, int align, int flags);

/* Get memory from a pool - flags are GFP_KERNEL or GFP_ATOMIC */
extern void *
pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);

/* Return memory too a pool */
extern void
pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t handle);

/* Destroy a pool */
extern void
pci_pool_destroy (struct pci_pool *pool);


/* Convert a DMA mapping to its cpu address (as returned by pci_pool_alloc).
 * Don't assume this is cheap, although on some platforms it may be simple
 * macros adding a constant to the DMA handle.
 */
extern void *
pci_pool_dma_to_cpu (struct pci_pool *pool, dma_addr_t handle);



/* LOGICALLY:  drivers/linux/pci.c */

/*
    There should be some memory pool allocator that this code
    can use ... it'd be a layer (just like kmem_cache_alloc and
    kmalloc) with an API that exposes PCI devices, dma address
    mappings, and hardware alignment requirements.

    Until that happens, this quick'n'dirty implementation of the
    API should work, and should be fast enough for small pools
    that use at most a few pages (and small allocation units).
*/

struct pci_pool {
 char   name [32];
 struct pci_dev  *dev;
 struct list_head pages;
 int   size;
 int   align;
 int   flags;
 int   blocks_offset;
 int   blocks_per_page;
};


/* pci consistent pages allocated in units of LOGICAL_PAGE_SIZE, layout:
 * - pci_page (always in the 'slab')
 * - bitmap (with blocks_per_page bits)
 * - blocks (starting at blocks_offset)
 *
 * this can easily be optimized, but the best fix would be to
 * make this just a bus-specific front end to mm/slab.c logic.
 */
struct pci_page {
 struct list_head pages;
 dma_addr_t  dma;
 unsigned long  bitmap [0];
};

#define LOGICAL_PAGE_SIZE PAGE_SIZE


/* irq-safe; protects any pool's pages and bitmaps */
static spinlock_t pci_page_lock = SPIN_LOCK_UNLOCKED;

#define POISON_BYTE  0xa5


/**
 * pci_pool_create - Creates a pool of pci consistent memory blocks, for dma.
 * @name: name of pool, for diagnostics
 * @pdev: pci device that will be doing the DMA
 * @size: size of the blocks in this pool.
 * @align: alignment requirement for blocks; must be a power of two
 * @flags: SLAB_* (or GFP_*) flags (not all are supported).
 *
 * Returns a pci allocation pool with the requested characteristics, or
 * null if one can't be created.
 *
 * Memory from the pool will always be aligned to at least L1_CACHE_BYTES,
 * or more strictly if requested.  The actual size be larger than requested.
 * Such memory will all have "consistent" DMA mappings, accessible by both
 * devices and their drivers without using cache flushing primitives.
 *
 * FIXME: probably need a way to specify "objects must not cross boundaries
 * of N Bytes", required by some device interfaces.
 */
extern struct pci_pool *
pci_pool_create (const char *name, struct pci_dev *pdev,
 int size, int align, int flags)
{
 struct pci_pool  *retval;
 size_t   temp;

 if ((LOGICAL_PAGE_SIZE - sizeof (struct pci_page)) < size)
  return 0;

 if (!(retval = kmalloc (sizeof *retval, flags)))
  return retval;

 if (align < L1_CACHE_BYTES)
  align = L1_CACHE_BYTES;

 if (size < align)
  size = align;
 else if (size % align)
  size = (size + align - 1) & ~(align - 1);

 strncpy (retval->name, name, sizeof retval->name);
 retval->name [sizeof retval->name - 1] = 0;

 retval->dev = pdev;
 INIT_LIST_HEAD (&retval->pages);
 retval->size = size;
 retval->align = align;
 retval->flags = flags;

 temp = sizeof (struct pci_page);
 if (temp % align)
  temp = (temp + align - 1) & ~(align - 1);
 retval->blocks_offset = temp;
 retval->blocks_per_page = (LOGICAL_PAGE_SIZE - temp) / size;

 temp -= sizeof (struct pci_page); /* bitmap size */
 while ((temp * 8) < retval->blocks_per_page) {
  temp += align;
  retval->blocks_offset += align;
  retval->blocks_per_page =
   (LOGICAL_PAGE_SIZE - retval->blocks_offset)
    / size;
 }

 dbg ("create %s/%s, size %d align %d offset %d per-page %d",
  pdev->slot_name, retval->name, size, align,
  retval->blocks_offset, retval->blocks_per_page);

 return retval;
}
EXPORT_SYMBOL (pci_pool_create);


static struct pci_page *
pci_alloc_page (struct pci_pool *pool)
{
 void  *vaddr;
 struct pci_page *page;
 dma_addr_t dma;

 vaddr = pci_alloc_consistent (pool->dev, LOGICAL_PAGE_SIZE, &dma);
 page = (struct pci_page *) vaddr;
 if (page) {
  page->dma = dma;
  memset (page->bitmap, 0,
       sizeof (long) *
    ((pool->blocks_per_page + BITS_PER_LONG - 1)
        / BITS_PER_LONG));
  if (pool->flags & SLAB_POISON)
   memset (vaddr + pool->blocks_offset, POISON_BYTE,
     pool->size * pool->blocks_per_page);
  list_add (&page->pages, &pool->pages);
 }
 return page;
}


static inline int
is_page_busy (int blocks, struct pci_page *page)
{
 int  i, bit;

 for (i = 0; i < blocks; i += BITS_PER_LONG) {
  bit = ffs (page->bitmap [i / BITS_PER_LONG]);
  if (!bit || (i + bit) > blocks)
   continue;
  return 1;
 }
 return 0;
}

static void
pci_free_page (struct pci_pool *pool, struct pci_page *page)
{
 dma_addr_t dma = page->dma;

#ifdef CONFIG_SLAB_DEBUG
 if (is_page_busy (pool->blocks_per_page, page)) {
  printk (KERN_ERR "pcipool %s/%s, free_page %p leak\n",
   pool->dev->slot_name, pool->name, page);
  return;
 }
#endif
 if (pool->flags & SLAB_POISON)
  memset (page, POISON_BYTE, LOGICAL_PAGE_SIZE);
 pci_free_consistent (pool->dev, LOGICAL_PAGE_SIZE, (void *) page, dma);
}


/**
 * pci_pool_destroy - destroys a pool of pci memory blocks.
 * @pool: pci pool that will be freed
 *
 * Caller guarantees no more memory from the pool is in use,
 * and nothing will try to use the pool after this call.
 */
extern void
pci_pool_destroy (struct pci_pool *pool)
{
 unsigned long  flags;
 struct pci_page  *page;

 dbg ("destroy %s/%s", pool->dev->slot_name, pool->name);

 spin_lock_irqsave (&pci_page_lock, flags);
 while (!list_empty (&pool->pages)) {
  page = list_entry (pool->pages.next, struct pci_page, pages);
  list_del (&page->pages);
  pci_free_page (pool, page);
 }
 spin_unlock_irqrestore (&pci_page_lock, flags);
 kfree (pool);
}
EXPORT_SYMBOL (pci_pool_destroy);


/**
 * pci_pool_alloc - allocate a block of consistent memory
 * @pool: pci pool that will produce the block
 * @mem_flags: GFP_KERNEL or GFP_ATOMIC
 * @handle: pointer to dma address of block
 *
 * This returns the kernel virtual address of the block, and reports
 * its dma address through the handle.
 */
extern void *
pci_pool_alloc (struct pci_pool *pool, int mem_flags, dma_addr_t *handle)
{
 unsigned long  flags;
 struct list_head *entry;
 struct pci_page  *page;
 int   map, block;
 size_t   offset;
 void   *retval;

 spin_lock_irqsave (&pci_page_lock, flags);
 list_for_each (entry, &pool->pages) {
  int  i;
  page = list_entry (entry, struct pci_page, pages);
  for (map = 0, i = 0;
    i < pool->blocks_per_page;
    i += BITS_PER_LONG, map++) {
   if (page->bitmap [map] == ~0UL)
    continue;
   block = ffz (page->bitmap [map]);
   if ((i + block) < pool->blocks_per_page) {
    set_bit (block, &page->bitmap [map]);
    offset = (BITS_PER_LONG * map) + block;
    offset *= pool->size;
    goto ready;
   }
  }
 }
 if (!(page = pci_alloc_page (pool))) {
  if (mem_flags == GFP_KERNEL) {
   /* FIXME: drop spinlock, block till woken
    * or timeout, then restart
    */
   printk (KERN_WARNING
    "pci_pool_alloc %s/%s, can't block yet\n",
    pool->dev->slot_name, pool->name);
  }

  retval = 0;
  goto done;
 }

 offset = 0;
 set_bit (0, &page->bitmap [0]);
ready:
 offset += pool->blocks_offset;
 retval = offset + (void *) page;
 *handle = offset + page->dma;
done:
 spin_unlock_irqrestore (&pci_page_lock, flags);
 return retval;
}
EXPORT_SYMBOL (pci_pool_alloc);


static struct pci_page *
find_page (struct pci_pool *pool, dma_addr_t dma)
{
 unsigned long  flags;
 struct list_head *entry;
 struct pci_page  *page;

 spin_lock_irqsave (&pci_page_lock, flags);
 list_for_each (entry, &pool->pages) {
  page = list_entry (pool->pages.next, struct pci_page, pages);
  if (dma < page->dma)
   continue;
  if (dma < (page->dma + LOGICAL_PAGE_SIZE))
   goto done;
 }
 page = 0;
done:
 spin_unlock_irqrestore (&pci_page_lock, flags);
 return page;
}


#ifdef pci_pool_dma_to_cpu
# undef pci_pool_dma_to_cpu
#endif


/**
 * pci_pool_dma_to_cpu - maps a block's dma address to a kernel virtual address.
 * @pool: the pci pool holding the block
 * @dma: dma address of the allocated block
 *
 * Convert a DMA mapping to its cpu address (as returned by pci_pool_alloc), or
 * to null if the pool does not have a mapping for that particular dma address.
 *
 * Don't assume this is cheap, although on some platforms it can be optimized
 * into macros that add some constant to the DMA address.
 */
extern void *
pci_pool_dma_to_cpu (struct pci_pool *pool, dma_addr_t dma)
{
 struct pci_page  *page;

 if ((page = find_page (pool, dma)) == 0)
  return 0;
 return (dma - page->dma) + (void *)page;
}
EXPORT_SYMBOL (pci_pool_dma_to_cpu);


/**
 * pci_pool_free - free an entry from a pci pool
 * @pool: the pci pool holding the block
 * @vaddr: virtual address of block
 * @dma: dma address of block
 *
 * Caller promises neither device nor driver will touch this block unless
 * it re-allocated.
 */
extern void
pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t dma)
{
 struct pci_page  *page;
 unsigned long  flags;
 int   block;

 if ((page = find_page (pool, dma)) == 0) {
  printk (KERN_ERR "pci_pool_free %s/%s, invalid dma %x\n",
   pool->dev->slot_name, pool->name, dma);
  return;
 }
#ifdef CONFIG_SLAB_DEBUG
 if (((dma - page->dma) + (void *)page) != vaddr) {
  printk (KERN_ERR "pci_pool_free %s/%s, invalid vaddr %p\n",
   pool->dev->slot_name, pool->name, vaddr);
  return;
 }
#endif
 if (pool->flags & SLAB_POISON)
  memset (vaddr, POISON_BYTE, pool->size);
 block = dma - page->dma;
 block /= pool->size;

 spin_lock_irqsave (&pci_page_lock, flags);
 clear_bit (block % BITS_PER_LONG,
   &page->bitmap [block / BITS_PER_LONG]);
 /* FIXME:  if someone's waiting here, wakeup ... else */
 if (!is_page_busy (pool->blocks_per_page, page)) {
  list_del (&page->pages);
  pci_free_page (pool, page);
 }
 spin_unlock_irqrestore (&pci_page_lock, flags);
}
EXPORT_SYMBOL (pci_pool_free);



