Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWHPCXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHPCXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWHPCXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:23:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5805 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750825AbWHPCXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:23:22 -0400
Date: Tue, 15 Aug 2006 19:23:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: mpm@selenic.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060816022303.13379.59408.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 5/7] A slab allocator: SLABIFIER
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slabifier: A slab allocator with minimal meta information

Lately I have started tinkering around with the slab in particular after
Matt Mackal mentioned that the slab should be more modular at the KS.
One particular design issue with the current slab is that it is build on the
basic notion of shifting object references from list to list. Without NUMA this
is wild enough with the per cpu caches and the shared cache but with NUMA we now
have per node shared arrays, per node list and per node per node alien caches.
Somehow this all works but one wonders does it have to be that way? On very
large systems the number of these entities grows to unbelievable numbers.

So I thought it may be best to try to develop another basic slab layer
that does not have all the object queues and that does not have to carry
so much state information. I also have had concerns about the way locking
is handled for awhile. We could increase parallelism by finer grained locking.
This in turn may avoid the need for object queues.

After toying around for awhile I came to the realization that the page struct
contains all the information necessary to manage a slab block. One can put
all the management information there and that is also advantageous
for performance since we constantly have to use the page struct anyways for
reverse object lookups and during slab creation. So this also reduces the
cache footprint of the slab. The alignment is naturally the best since the
first object starts right at the page boundary. This reduces the complexity
of alignment calculations.

We use two locks:

1. The per slab list_lock to protect the lists. This lock does not protect
   the slab and is only taken during list manipulation. List manupulation
   is reduced to necessary moves if the state of a page changes. An allocation
   of an object or the freeing of an object in a slab does not require
   that the list_lock is taken if the slab does not run empty or overflows.

2. The page lock in struct page is used to protect the slab during
   allocation and freeing. This lock is conveniently placed in a cacheline
   that is already available. Other key information is also placed there.

struct page overloading:

- _mapcout	=> Used to count the objects in use in a slab
- mapping	=> Reference to the slab structure
- index		=> Pointer to the first free element in a slab
- lru		=> Used for list management.

Flag overloading:

PageReferenced	=> Used to control per cpu slab freeing.
PageActive	=> slab is under active allocation.
PageLocked	=> slab locking

The freelists of objects per page are managed as a chained list.
The struct page contains a pointer to the first element. The first 4 bytes of
the free element contains a pointer to the next free element etc until the
chain ends with NULL.

There is no freelist for slabs. slabs are immediately returned to the page
allocator.  The page allocator has its own per cpu page queues that should
provide enough caching (only works for order 0 pages though).

Per cpu caches exist in the sense that each processor has a per processor
"cpuslab". Objects in this slab will only be allocated from this processor.
The page state is likely going to stay in the cache. Allocation will be
very fast since we only need the page struct reference for all our needs
which is likely not contended at all. Fetching the next free pointer from
the location of the object nicely prefetches the object.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/mm/slabifier.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/slabifier.c	2006-08-15 16:29:48.958782043 -0700
@@ -0,0 +1,1014 @@
+/*
+ * Generic Slabifier for any allocator with minimal management overhead.
+ *
+ * (C) 2006 Silicon Graphics Inc., Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/allocator.h>
+#include <linux/bit_spinlock.h>
+#include <linux/module.h>
+
+#define SLABIFIER_DEBUG
+
+#ifdef SLABIFIER_DEBUG
+#define	DBUG_ON(_x) BUG_ON(_x)
+#else
+#define DBUG_ON(_x)
+#endif
+
+#define TPRINTK printk
+//#define TPRINTK(x, ...)
+
+struct slab {
+	struct slab_cache sc;
+	spinlock_t list_lock;		/* Lock for partial slabs.
+					 * Also protects active slabs and bit
+					 */
+	struct list_head partial;	/* List of partially allocated slabs */
+	struct list_head full;		/* Fully allocated slabs */
+	unsigned long nr_partial;	/* Partial slabs */
+	unsigned long slabs;		/* Total slabs used */
+	int size;			/* Slab size */
+	int offset;			/* Free pointer offset. */
+	int objects;			/* Number of objects in slab */
+	atomic_t refcount;		/* Refcount for destroy */
+	/* Flusher related data */
+	int flusher_active;
+	struct work_struct flush;
+	struct page *active[NR_CPUS];	/* Per CPU slabs list protected by
+					 * page lock
+					 */
+};
+
+static struct slab cache_cache;
+
+/*
+ * A good compiler should figure out that the result of this function
+ * is constant.
+ */
+static int get_slab_order(void)
+{
+	return max(0, (fls(sizeof(struct slab)-1) - PAGE_SHIFT));
+}
+
+/*
+ * The page struct is used to keep necessary information about a slab.
+ * For a compound page the first page keeps the slab state.
+ *
+ * Overloaded fields in struct page:
+ *
+ * 	lru	 -> used to a slab on the lists
+ *	mapping	 -> pointer to struct slab
+ *	index	 -> pointer to next free object
+ *	_mapcount -> count number of elements in use
+ *
+ * Lock order:
+ *   1. slab_lock(page)
+ *   2. slab->list_lock
+ *
+ * The slabifier assigns one slab for allocation to each processor
+ * This slab is on the active list and allocations
+ * occur only on the active slabs. If a cpu slab is active then
+ * a workqueue thread checks every 10 seconds if the cpu slab is
+ * still in use. It is dropped back to the inactive lists if not.
+ *
+ * Leftover slabs with free elements are kept on the partial list
+ * and full slabs on the full list.
+ *
+ * Slabs are freed when they become empty. Teardown and setup is
+ * minimal so we rely on the page cache per cpu caches for
+ * performance on frees/allocs.
+ */
+
+#define lru_to_last_page(_head) (list_entry((_head)->next, struct page, lru))
+#define lru_to_first_page(_head) (list_entry((_head)->next, struct page, lru))
+
+/* Some definitions to overload certain fields in struct page */
+
+static void *get_object_pointer(struct page *page)
+{
+	return (void *)page->index;
+}
+
+static void set_object_pointer(struct page *page, void *object)
+{
+	page->index = (unsigned long)object;
+}
+
+static struct slab *get_slab(struct page *page)
+{
+	return (struct slab *)page->mapping;
+}
+
+static void set_slab(struct page *page, struct slab *s)
+{
+	page->mapping = (void *)s;
+}
+
+static int *object_counter(struct page *page)
+{
+	return (int *)&page->_mapcount;
+}
+
+static void inc_object_counter(struct page *page)
+{
+	(*object_counter(page))++;
+}
+
+static void dec_object_counter(struct page *page)
+{
+	(*object_counter(page))--;
+}
+
+static void set_object_counter(struct page *page, int counter)
+{
+	(*object_counter(page))= counter;
+}
+
+static int get_object_counter(struct page *page)
+{
+	return (*object_counter(page));
+}
+
+/*
+ * For a given active page get the corresponding cpu */
+static int get_active_cpu(struct page *page)
+{
+	return (unsigned long)(page->lru.prev);
+}
+
+static void set_active_cpu(struct page *page, unsigned long cpu)
+{
+	page->lru.prev = (void *)cpu;
+}
+
+/*
+ * Locking for each individual slab using the pagelock
+ */
+static void slab_lock(struct page *page)
+{
+	bit_spin_lock(PG_locked, &page->flags);
+}
+
+static void slab_unlock(struct page *page)
+{
+	bit_spin_unlock(PG_locked, &page->flags);
+}
+
+static void check_slab(struct page *page)
+{
+#ifdef SLABIFIER_DEBUG
+	if (!PageSlab(page)) {
+		printk(KERN_CRIT "Not a valid slab page @%p flags=%lx"
+			" mapping=%p count=%d \n",
+			page, page->flags, page->mapping, page_count(page));
+		BUG();
+	}
+#endif
+}
+
+static void check_active_slab(struct page *page)
+{
+#ifdef SLABIFIER_DEBUG
+	if (!PageActive(page)) {
+		printk(KERN_CRIT "Not an active slab page @%p flags=%lx"
+			" mapping=%p count=%d \n",
+			page, page->flags, page->mapping, page_count(page));
+		BUG();
+	}
+#endif
+}
+
+/*
+ * Discard an unused slab page
+ * Must hold list_lock.
+ * Cannot hold the slab lock since the page is going away.
+ */
+static void discard_slab(struct slab *s, struct page *page)
+{
+	TPRINTK(KERN_CRIT "slab %s free %p page_alloc=%p free=%p\n", s->sc.name, page,
+		s->sc.page_alloc, s->sc.page_alloc->free);
+
+	DBUG_ON(PageActive(page));
+	DBUG_ON(PageLocked(page));
+	list_del(&page->lru);
+	s->slabs--;
+
+	/* Restore page state */
+	page->mapping = NULL;		/* was used for slab pointer */
+	page->index = 0;		/* was used for the object pointer */
+	reset_page_mapcount(page);	/* Was used for inuse counter */
+	__ClearPageSlab(page);
+
+	s->sc.page_alloc->free(s->sc.page_alloc, page, s->sc.order);
+	sub_zone_page_state(page_zone(page), NR_SLAB, 1 << s->sc.order);
+}
+
+/*
+ * Move a page back to the lists.
+ *
+ * Must be called with the slab lock held.
+ * On exit the slab lock will have been dropped.
+ */
+static void deactivate_slab(struct slab *s, struct page *page, int contended)
+{
+	int inuse;
+#ifdef SLABIFIER_DEBUG
+	void *objp;
+	int cpu = get_active_cpu(page);
+#endif
+
+	spin_lock(&s->list_lock);
+//	We are also using this from slab_shrink!
+//	DBUG_ON(!s->active[get_active_cpu(page)]);
+//	check_active_slab(page);
+
+	s->active[get_active_cpu(page)] = NULL;
+	ClearPageActive(page);
+	ClearPageReferenced(page);
+	inuse = get_object_counter(page);
+#ifdef SLABIFIER_DEBUG
+	/*
+	 * Must get this before dropping slab lock otherwise others
+	 * may already be freeing objects in the page again.
+	 */
+	objp = get_object_pointer(page);
+#endif
+	slab_unlock(page);
+	if (inuse) {
+		if (inuse < s->objects) {
+			DBUG_ON(!objp);
+			TPRINTK(KERN_CRIT "slab %s: %p partial %d/%d %d cpu=%d\n",s->sc.name, page, inuse, s->objects, contended, cpu);
+			s->nr_partial++;
+			if (contended)
+				list_add_tail(&page->lru, &s->partial);
+			else
+				list_add(&page->lru, &s->partial);
+		} else {
+			DBUG_ON(objp);
+			TPRINTK(KERN_CRIT "slab %s:  %p full %d cpu=%d\n",s->sc.name, page, contended, cpu);
+			list_add_tail(&page->lru, &s->full);
+		}
+	} else {
+		/* For discard_slab we must have the slab on some list */
+		list_add_tail(&page->lru, &s->full);
+		discard_slab(s, page);
+	}
+	spin_unlock(&s->list_lock);
+}
+
+static int check_valid_pointer(struct slab *s, struct page *page, void *object, void *origin)
+{
+#ifdef SLABIFIER_DEBUG
+	void *base = page_address(page);
+
+	check_slab(page);
+
+	if (object < base || object >= base + s->objects * s->size) {
+		printk(KERN_CRIT "slab %s size %d: pointer %p->%p\nnot in "
+			" range (%p-%p) in page %p\n", s->sc.name, s->size,
+			origin, object, base, base + s->objects * s->size,
+			page);
+		return 0;
+	}
+
+	if ((object - base) % s->size) {
+		printk(KERN_CRIT "slab %s size %d: pointer %p->%p\n"
+			"does not properly point"
+			"to an object in page %p\n",
+			s->sc.name, s->size, origin, object, page);
+		return 0;
+	}
+#endif
+	return 1;
+}
+
+/*
+ * Determine if a certain object on a page is on the freelist and
+ * therefore free. Must hold either the list_lock for inactive slabs
+ * or the slab lock for active slabs to guarantee that the chains
+ * are consistent.
+ */
+static int on_freelist(struct slab *s, struct page *page, void *search)
+{
+	int nr = 0;
+	void **object = get_object_pointer(page);
+	void *origin = &page->lru;
+
+	check_slab(page);
+
+	while (object) {
+		if (object == search)
+			return 1;
+		if (!check_valid_pointer(s, page, object, origin))
+			goto try_recover;
+		origin = object;
+		object = object[s->offset];
+		nr++;
+	}
+
+	if (get_object_counter(page) != s->objects - nr) {
+		printk(KERN_CRIT "slab %s: page %p wrong object count."
+			" counter is %d but counted were %d\n",
+			s->sc.name, page, get_object_counter(page), nr);
+try_recover:
+		printk(KERN_CRIT "****** Trying to continue by marking "
+			"all objects used (memory leak!)\n");
+		set_object_counter(page, s->objects);
+		set_object_pointer(page, NULL);
+	}
+	return 0;
+}
+
+void check_free_chain(struct slab *s, struct page *page)
+{
+#ifdef SLABIFIER_DEBUG
+	on_freelist(s, page, NULL);
+#endif
+}
+
+/*
+ * Allocate a new slab and prepare an empty freelist
+ * and the basic struct page settings.
+ */
+static struct page *new_slab(struct slab *s, gfp_t flags)
+{
+	void *p, *start, *end;
+	void **last;
+	struct page *page;
+
+	TPRINTK(KERN_CRIT "add slab %s flags=%x\n", s->sc.name, flags);
+
+	page = s->sc.page_alloc->allocate(s->sc.page_alloc, s->sc.order,
+			flags, s->sc.node);
+	if (!page)
+		return NULL;
+
+	set_slab(page, s);
+	start = page_address(page);
+	set_object_pointer(page, start);
+
+	end = start + s->objects * s->size;
+	last = start;
+	for (p = start +  s->size; p < end; p += s->size) {
+		last[s->offset] = p;
+		last = p;
+	}
+	last[s->offset] = NULL;
+	set_object_counter(page, 0);
+	__SetPageSlab(page);
+	check_free_chain(s, page);
+	add_zone_page_state(page_zone(page), NR_SLAB, 1 << s->sc.order);
+	return page;
+}
+
+/*
+ * Acquire the slab lock from the active array. If there is active
+ * slab for this processor then return NULL;
+ */
+static struct page *get_and_lock_active(struct slab *s, int cpu)
+{
+	struct page *page;
+
+redo:
+	page = s->active[cpu];
+	if (unlikely(!page))
+		return NULL;
+	slab_lock(page);
+	if (unlikely(s->active[cpu] != page)) {
+		slab_unlock(page);
+		goto redo;
+	}
+	check_active_slab(page);
+	return page;
+}
+
+/*
+ * Return a per cpu slab by taking it off the active list.
+ */
+static void flush_active(struct slab *s, int cpu)
+{
+	struct page *page;
+	unsigned long flags;
+
+	TPRINTK(KERN_CRIT "flush_active %s cpu=%d\n", s->sc.name, cpu);
+	local_irq_save(flags);
+	page = get_and_lock_active(s, cpu);
+	if (likely(page))
+		deactivate_slab(s, page, 0);
+	local_irq_restore(flags);
+}
+
+/*
+ * Flush per cpu slabs if they are not in use.
+ */
+void flusher(void *d)
+{
+	struct slab *s = d;
+	int cpu = smp_processor_id();
+	struct page *page;
+	int nr_active = 0;
+
+	for_each_online_cpu(cpu) {
+
+		page = s->active[cpu];
+		if (!page)
+			continue;
+
+		if (PageReferenced(page)) {
+			ClearPageReferenced(page);
+			nr_active++;
+		} else
+			flush_active(s, cpu);
+	}
+	if (nr_active)
+		schedule_delayed_work(&s->flush, 10 * HZ);
+	else
+		s->flusher_active = 0;
+}
+
+/*
+ * Drain all per cpu slabs
+ */
+static void drain_all(struct slab *s)
+{
+	int cpu;
+
+	if (s->flusher_active) {
+		cancel_delayed_work(&s->flush);
+		for_each_possible_cpu(cpu)
+			flush_active(s, cpu);
+		s->flusher_active = 0;
+	}
+}
+
+/*
+ * slab_create produces objects aligned at size and the first object
+ * is placed at offset 0 in the slab (We have no metainformation on the
+ * slab, all slabs are in essence off slab).
+ *
+ * In order to get the desired alignment one just needs to align the
+ * size. F.e.
+ *
+ * slab_create(&my_cache, ALIGN(sizeof(struct mystruct)), CACHE_L1_SIZE),
+ *				2, page_allocator);
+ *
+ * Notice that the allocation order determines the sizes of the per cpu
+ * caches. Each processor has always one slab available for allocations.
+ * Increasing the allocation order reduces the number of times that slabs
+ * must be moved on and off lists and therefore influences overhead.
+ *
+ * The offset is used to relocate the free list link in each object. It is
+ * therefore possible to move the free list link behind the object. This
+ * is necessary for RCU to work properly and also useful for debugging.
+ */
+static int __slab_create(struct slab *s,
+	const struct slab_allocator *slab_alloc,
+	const struct page_allocator *page_alloc, int node, const char *name,
+	int size, int align, int order, int objsize, int inuse, int offset)
+{
+	int cpu;
+
+	slab_allocator_fill(&s->sc, slab_alloc, page_alloc, node, name, size,
+		align, order, objsize, inuse, offset);
+
+	s->size = ALIGN(size, sizeof(void *));
+
+	if (offset > s->size - sizeof(void *) || (offset % sizeof(void*)))
+		return -EINVAL;
+
+	s->offset = offset / sizeof(void *);
+	s->objects = (PAGE_SIZE << order) / s->size;
+	s->slabs = 0;
+	s->nr_partial = 0;
+	s->flusher_active = 0;
+
+	if (!s->objects)
+		return -EINVAL;
+
+
+	INIT_LIST_HEAD(&s->partial);
+	INIT_LIST_HEAD(&s->full);
+
+	atomic_set(&s->refcount, 1);
+	spin_lock_init(&s->list_lock);
+	INIT_WORK(&s->flush, &flusher, s);
+
+	for_each_possible_cpu(cpu)
+		s->active[cpu] = NULL;
+	return 0;
+}
+
+/*
+ * Deal with ugly bootstrap issues.
+ */
+static struct slab_cache *slab_create(const struct slab_allocator *slab_alloc,
+	const struct page_allocator *page_alloc, int node, const char *name,
+	int size, int align, int order, int objsize, int inuse, int offset)
+{
+	struct slab *s;
+
+	if (!cache_cache.sc.size) {
+		if (__slab_create(&cache_cache,
+			slab_alloc, page_alloc, node, "cache_cache",
+			ALIGN(sizeof(struct slab), L1_CACHE_BYTES),
+				L1_CACHE_BYTES,
+			get_slab_order(), sizeof(struct slab),
+				sizeof(struct slab), 0))
+		panic("Cannot create slab of slabifier slabs!");
+	}
+
+	s = cache_cache.sc.slab_alloc->alloc_node(&cache_cache.sc,
+				GFP_KERNEL, node);
+
+	if (!s)
+		return NULL;
+	__slab_create(s, slab_alloc, page_alloc, node, name, size, align,
+		order, objsize, inuse, offset);
+	return &s->sc;
+}
+
+/*
+ * Reload a new active cpu slab
+ *
+ * On entry the active slab for this cpu must be NULL.
+ * If we have reloaded successfully then we exit with holding the slab lock
+ * and return the pointer to the new page.
+ *
+ * Return NULL if we cannot reload.
+ */
+static struct page *reload(struct slab *s, unsigned long cpu, gfp_t flags)
+{
+	struct page *page;
+
+	spin_lock(&s->list_lock);
+
+redo:
+	if (s->active[cpu]) {
+		/* Someone else updated it first. */
+		spin_unlock(&s->list_lock);
+		page = get_and_lock_active(s, cpu);
+		if (!page)
+			goto redo;
+		return page;
+	}
+
+	if (unlikely(list_empty(&s->partial))) {
+
+		/* No slabs with free objets */
+		spin_unlock(&s->list_lock);
+		if ((flags & __GFP_WAIT)) {
+			local_irq_enable();
+			page = new_slab(s, flags);
+			local_irq_disable();
+		} else
+			page = new_slab(s, flags);
+
+		if (!page)
+			return NULL;
+
+		spin_lock(&s->list_lock);
+		list_add(&page->lru,&s->partial);
+		s->nr_partial++;
+		/*
+		 * Need to recheck conditions since we dropped
+		 * the list_lock
+		 */
+		goto redo;
+	}
+	page = lru_to_first_page(&s->partial);
+	list_del(&page->lru);
+	s->nr_partial--;
+	slab_lock(page);
+	SetPageActive(page);
+	ClearPageReferenced(page);
+	set_active_cpu(page, cpu);
+	s->active[cpu] = page;
+	spin_unlock(&s->list_lock);
+	if (keventd_up() && !s->flusher_active)
+		schedule_delayed_work(&s->flush, 10 * HZ);
+	return page;
+}
+/*
+ * If the gfp mask has __GFP_WAIT set then slab_alloc() may enable interrupts
+ * if it needs to acquire more pages for new slabs.
+ */
+static void *slab_alloc(struct slab_cache *sc, gfp_t gfpflags)
+{
+	struct slab *s = (void *)sc;
+	int cpu = smp_processor_id();
+	struct page *page;
+	void **object = NULL;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	do {
+		page = get_and_lock_active(s, cpu);
+
+		if (unlikely(!page)) {
+			page = reload(s, cpu, gfpflags);
+
+			if (!page)
+				goto out;
+		}
+
+		check_free_chain(s, page);
+		object = get_object_pointer(page);
+		if (likely(!object))
+			/* Sorry, fully allocated slab! */
+			deactivate_slab(s, page, 0);
+	} while (!object);
+
+	set_object_pointer(page, object[s->offset]);
+	inc_object_counter(page);
+	SetPageReferenced(page);
+	check_free_chain(s, page);
+	slab_unlock(page);
+out:
+	local_irq_restore(flags);
+	return object;
+}
+
+/* Figure out on which slab object the object resides */
+static struct page *get_object_page(const void *x)
+{
+	struct page * page;
+
+	page = virt_to_page(x);
+	if (unlikely(PageCompound(page)))
+		page = (struct page *)page_private(page);
+
+	if (!PageSlab(page))
+		return NULL;
+
+	return page;
+}
+
+/*
+ * If the struct slab pointer is NULL then we will determine the
+ * proper cache. Otherwise the slab ownership will be verified
+ * before object removal.
+ */
+static void slab_free(struct slab_cache *sc, const void *x)
+{
+	struct slab *s = (void *)sc;
+	struct page * page;
+	int leftover;
+	void *prior;
+	void **object = (void *)x;
+	unsigned long flags;
+
+	if (!object)
+		return;
+
+	page = get_object_page(object);
+	if (unlikely(!page)) {
+		printk(KERN_CRIT "slab_free %s size %d: attempt to free object"
+			"(%p) outside of slab.\n", s->sc.name, s->size, object);
+		goto dumpret;
+	}
+
+	if (!s) {
+		s = get_slab(page);
+
+		if (unlikely(!s)) {
+#ifdef CONFIG_SLAB
+			extern void __kfree(void *);
+			/*
+			 * Upps we use multiple slab allocator. This
+			 * must be another one (regular slab?)
+			 */
+			__kfree(object);
+			return;
+#else
+			printk(KERN_CRIT
+				"slab_free : no slab(NULL) for object %p.\n",
+						object);
+#endif
+			goto dumpret;
+		}
+	}
+
+	if (unlikely(s != get_slab(page))) {
+		printk(KERN_CRIT "slab_free %s: object at %p"
+				" belongs to slab %p\n",
+				s->sc.name, object, get_slab(page));
+		dump_stack();
+		s = get_slab(page);
+	}
+
+	if (unlikely(!check_valid_pointer(s, page, object, NULL))) {
+dumpret:
+		dump_stack();
+		printk(KERN_CRIT "***** Trying to continue by not"
+				"freeing object.\n");
+		return;
+	}
+
+	local_irq_save(flags);
+	slab_lock(page);
+
+	/* Check for double free */
+#ifdef SLABIFIER_DEBUG
+	if (on_freelist(s, page, object)) {
+		printk(KERN_CRIT "slab_free %s: object %p already free.\n",
+						s->sc.name, object);
+		dump_stack();
+		goto out_unlock;
+	}
+#endif
+
+	prior = get_object_pointer(page);
+	object[s->offset] = prior;
+
+	set_object_pointer(page, object);
+	dec_object_counter(page);
+	leftover = get_object_counter(page);
+
+	if (unlikely(PageActive(page)))
+		goto out_unlock;
+
+	if (unlikely(leftover == 0)) {
+		/*
+		 * We deallocated all objects in a slab and the slab
+		 * is not under allocation. So we can free it.
+		 */
+		spin_lock(&s->list_lock);
+		check_free_chain(s, page);
+		slab_unlock(page);
+		discard_slab(s, page);
+		spin_unlock(&s->list_lock);
+		goto out;
+	}
+	if (unlikely(!prior)) {
+		/*
+		 * Page was fully used before. It will only have one free
+		 * object now. So move to the front of the partial list.
+		 * This will increase the chances of the first object
+		 * to be reused soon. Its likely cache hot.
+		 */
+		spin_lock(&s->list_lock);
+		list_move(&page->lru, &s->partial);
+		s->nr_partial++;
+		spin_unlock(&s->list_lock);
+	}
+out_unlock:
+	slab_unlock(page);
+out:
+	local_irq_restore(flags);
+}
+
+/*
+ * Check if a given pointer is valid
+ */
+static int slab_pointer_valid(struct slab_cache *sc, const void *object)
+{
+	struct slab *s = (void *)sc;
+	struct page * page;
+	void *addr;
+
+	TPRINTK(KERN_CRIT "slab_pointer_valid(%s,%p\n",s->sc.name, object);
+
+	page = get_object_page(object);
+
+	if (!page || s != get_slab(page))
+		return 0;
+
+	addr = page_address(page);
+	if (object < addr || object >= addr + s->objects * s->size)
+		return 0;
+
+	if ((object - addr) & s->size)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * Determine the size of a slab object
+ */
+static unsigned long slab_object_size(struct slab_cache *sc,
+						const void *object)
+{
+	struct page *page;
+	struct slab *s;
+
+	TPRINTK(KERN_CRIT "slab_object_size(%p)\n",object);
+
+	page = get_object_page(object);
+	if (page) {
+		s = get_slab(page);
+		BUG_ON(sc && s != (void *)sc);
+		if (s)
+			return s->size;
+	}
+	BUG();
+}
+
+/*
+ * Move slab objects in a given slab by calling the move_objects
+ * function.
+ */
+static int move_slab_objects(struct slab *s, struct page *page,
+			 int (*move_objects)(struct slab_cache *, void *))
+{
+	int unfreeable = 0;
+	void *addr = page_address(page);
+
+	while (get_object_counter(page) - unfreeable > 0) {
+		void *p;
+
+		for (p = addr; p < addr + s->objects; p+= s->size) {
+			if (!on_freelist(s, page, p)) {
+				if (move_objects((struct slab_cache *)s, p))
+					slab_free(&s->sc, p);
+				else
+					unfreeable++;
+			}
+		}
+	}
+	return unfreeable;
+}
+
+/*
+ * Shrinking drops all the active per cpu slabs and also reaps all empty
+ * slabs off the partial list (preloading may have added those). Returns the
+ * number of slabs freed.
+ *
+ * If a move_object function is specified then the partial list is going
+ * to be compacted by calling the function on all slabs until only a single
+ * slab is on the partial list. The move_object function
+ * will be called for each objects in the respective slab. Move_object needs to
+ * perform a new allocation for the object and move the contents
+ * of the object to the new location. If move_object returns 1
+ * for success then the object is going to be removed. If 0 then the
+ * slab object cannot be freed at all.
+ *
+ * Try to remove as many slabs as possible. In particular try to undo the
+ * effect of slab_preload which may have added empty pages to the
+ * partial list.
+ *
+ * Returns the number of slabs freed.
+ */
+static int slab_shrink(struct slab_cache *sc,
+			int (*move_object)(struct slab_cache *, void *))
+{
+	struct slab *s = (void *)sc;
+	unsigned long flags;
+	int slabs_freed = 0;
+	int i;
+
+	drain_all(s);
+	/*
+	 * Take the last element of the partial list and free entries until
+	 * the free list contains only a single page.
+	 *
+	 * FIXME: If there are multiple objects pinned in multiple
+	 * slabs then this loop may never terminate!
+	 */
+	for(i = 0; s->nr_partial > 1 && i < s->nr_partial - 1 ; i++) {
+		struct page * page;
+
+		/* Take one page off the list */
+		spin_lock_irqsave(&s->list_lock, flags);
+
+		if (s->nr_partial == 0) {
+			spin_unlock_irqrestore(&s->list_lock, flags);
+			break;
+		}
+
+		page = lru_to_last_page(&s->partial);
+		s->nr_partial--;
+		list_del(&page->lru);
+
+		spin_unlock_irqrestore(&s->list_lock, flags);
+
+		/* Free the objects in it */
+		if (s->nr_partial) {
+			if (get_object_counter(page) < s->objects)
+				if (move_slab_objects(s,
+						page, move_object) == 0)
+					slabs_freed++;
+
+		}
+		/*
+		 * This will put the slab on the front of the partial
+		 * list, the used list or free it.
+		 */
+		slab_lock(page);
+		deactivate_slab(s, page, 0);
+	}
+
+	return slabs_freed;
+
+}
+
+static void free_list(struct slab *s, struct list_head *list)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->list_lock, flags);
+	while (!list_empty(list))
+		discard_slab(s, lru_to_last_page(list));
+
+	spin_unlock_irqrestore(&s->list_lock, flags);
+}
+
+
+/* Duplicate a slab handle */
+static struct slab_cache *slab_dup(struct slab_cache *sc)
+{
+	struct slab *s = (void *)sc;
+
+	atomic_inc(&s->refcount);
+	return &s->sc;
+}
+
+/*
+ * Release all leftover slabs. If there are any leftover pointers dangling
+ * to these objects then we will get into a lot of trouble later.
+ */
+static int slab_destroy(struct slab_cache *sc)
+{
+	struct slab * s = (void *)sc;
+
+	if (!atomic_dec_and_test(&s->refcount))
+		return 0;
+
+	TPRINTK("Slab destroy %s\n",sc->name);
+	drain_all(s);
+
+	free_list(s, &s->full);
+	free_list(s, &s->partial);
+
+	if (s->slabs)
+		return 1;
+
+	/* Just to make sure that no one uses this again */
+	s->size = 0;
+	cache_cache.sc.slab_alloc->free(&cache_cache.sc, sc);
+	return 0;
+
+}
+
+static unsigned long count_objects(struct slab *s, struct list_head *list)
+{
+	int count = 0;
+	struct list_head *h;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->list_lock, flags);
+	list_for_each(h, list) {
+		struct page *page = lru_to_first_page(h);
+
+		count += get_object_counter(page);
+	}
+	spin_unlock_irqrestore(&s->list_lock, flags);
+	return count;
+}
+
+static unsigned long slab_objects(struct slab_cache *sc,
+			unsigned long *p_active, unsigned long *p_partial)
+{
+	struct slab *s = (void *)sc;
+	int partial;
+	int active = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (s->active[cpu])
+			active++;
+
+	partial = count_objects(s, &s->partial);
+
+	if (p_partial)
+		*p_partial = partial;
+
+	if (p_active)
+		*p_active = active;
+
+	return active + partial + count_objects(s, &s->full);
+}
+
+static void *slab_alloc_node(struct slab_cache *sc, gfp_t flags, int node)
+{
+	return slab_alloc(sc, flags);
+}
+
+const struct slab_allocator slabifier_allocator = {
+	.name = "Slabifier",
+	.create = slab_create,
+	.alloc = slab_alloc,
+	.alloc_node = slab_alloc_node,
+	.free = slab_free,
+	.valid_pointer = slab_pointer_valid,
+	.object_size = slab_object_size,
+	.objects = slab_objects,
+	.shrink = slab_shrink,
+	.dup = slab_dup,
+	.destroy = slab_destroy,
+	.destructor = null_slab_allocator_destructor,
+};
+EXPORT_SYMBOL(slabifier_allocator);
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-15 16:20:52.526098853 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-15 16:20:53.007514428 -0700
@@ -24,5 +24,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o slabulator.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o kmalloc.o slabulator.o slabifier.o
 
