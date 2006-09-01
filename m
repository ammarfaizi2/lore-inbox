Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWIAWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWIAWfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWIAWfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:35:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44516 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751142AbWIAWeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:50 -0400
Date: Fri, 1 Sep 2006 15:34:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060901223408.21034.44664.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
References: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 2/5] Slabifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slabifier: A slab allocator with minimal meta information

V2->V3:
- Overload struct page
- Add new PageSlabsingle flag

Lately I have started tinkering around with the slab in particular after
Matt Mackal mentioned that the slab should be more modular at the KS.
One particular design issue with the current slab is that it is build on the
basic notion of shifting object references from list to list. Without NUMA this
is wild enough with the per cpu caches and the shared cache but with NUMA we now
have per node shared arrays, per node list and per node per node alien caches.
Somehow this all works but one wonders does it have to be that way? On very
large systems the number of these entities grows to unbelievable numbers.
On our 1k cpu/node system each slab need 128M for alien caches alone.

So I thought it may be best to try to develop another basic slab layer
that does not have all the object queues and that does not have to carry
so much state information. I also have had concerns about the way locking
is handled for awhile. We could increase parallelism by finer grained locking.
This in turn may avoid the need for object queues.

One of the problems of the NUMA slab allocator is that per node partial
slab lists are used. Partial slabs cannot be filled up from other nodes.
So what I have tried to do here is to have minimal metainformation combined
with one centralized list of partially allocated slabs. The list_lock
is only taken if list modifications become necessary. The need for those
has been drastically reduced with a few measures. See below.

After toying around for awhile I came to the realization that the page struct
contains all the information necessary to manage a slab block. One can put
all the management information there and that is also advantageous
for performance since we constantly have to use the page struct anyways for
reverse object lookups and during slab creation. So this also reduces the
cache footprint of the slab. The alignment is naturally the best since the
first object starts right at the page boundary. This reduces the complexity
of alignment calculations.

Also we have a page lock in the page struct that is used
for locking each slab during modifications. Taking the lock per slab
is the finest grained locking available and this is fundamental
to the slabifier. The slab lock is taken if the slab contains
multiple objects in order to protect the freelist.

The freelists of objects per page are managed as a chained list.
The struct page contains a pointer to the first element. The first 4 bytes of
the free element contains a pointer to the next free element etc until the
chain ends with NULL. If the object cannot be overwritten after free (RCU
and constructors etc) then we can shift the pointer to the next free element
behind the object.

The slabifier does remove the need for a list of free slabs and a list
of used slabs. Free slabs are immediately returned to the page allocator.
The page allocator has its own per cpu queues that will manage these
free pages. Used slabs are simply not tracked because we never have
a need to find out where the used slabs are. The only important thing
is that the slabs come back to the partial list when an object in them
is deleted. The metadata in the corresponding page struct will allow
us to do that easily.

Per cpu caches exist in the sense that each processor has a per processor
"cpuslab". Objects in this "active" slab will only be allocated from this
processor. This naturally makes all allocations from a single processor
come from the same slab page which reduces fragmentation.
The page state is likely going to stay in the cache. Allocation will be
very fast since we only need the page struct reference for all our needs
which is likely not contended at all. Fetching the next free pointer from
the location of the object nicely prefetches the object.

The list_lock is used only in very rare cases. Lets discuss one example
of multiple processors allocating from the same cache. The first thing that
happens when the slab cache is empty is that every processors gets its own
slab (the "active" slab). This does not require the list_lock because we
get a page from the page allocator and that immediately becomes the
active slab. Now all processors allocate from their slabs. This also
does not require any access to the partial lists so no list_lock is taken.

If a slab becomes full then each processor is simply forgetting about
the slab and gets a new one from the page allocator.

Therefore as long as all processors are just allocating no list_lock is
needed at all.

If a free now happens then things get a bit more complicated. If the free
occurs on an active page then again no list_lock needs to be taken.
Only the slab lock may be contended since it may be under current allocation
by a process.

If the free occurs on a fully allocated page then we make a partially
allocated page from a full page. Now the list_lock will be taken and
the page is put on the partial list.

If further frees occur on a partially allocated page then also no
list_lock needs to be taken because it is still a partially allocated
page. This works until the page has no objects left. At that point
we take the page of the list of partial slabs to free it and that
requires the list_lock again.

If a processors has filled up its active slab and needs a new one then
it will first check if there are partially allocated slabs available.
If so then it will take a partially allocated slab and begin to fill
it up. That also requires taking the list lock.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc5-mm1/mm/slabifier.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/mm/slabifier.c	2006-09-01 14:25:55.907938735 -0700
@@ -0,0 +1,936 @@
+/*
+ * Generic Slabifier for the allocator abstraction framework.
+ *
+ * The allocator synchronizes using slab based locks and only
+ * uses a centralized list lock to manage the pool of partial slabs.
+ *
+ * (C) 2006 Silicon Graphics Inc., Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/allocator.h>
+#include <linux/bit_spinlock.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+
+/*
+ * Enabling SLABIFIER_DEBUG will check various things. Among others it will
+ * flag double frees.
+ */
+/* #define SLABIFIER_DEBUG */
+
+struct slab {
+	struct slab_cache sc;
+#ifdef CONFIG_SMP
+	int flusher_active;
+	struct work_struct flush;
+#endif
+	atomic_t refcount;		/* Refcount for destroy */
+	atomic_long_t nr_slabs;		/* Total slabs used */
+	/* Performance critical items follow */
+	int size;			/* Total size of an object */
+	int offset;			/* Free pointer offset. */
+	int objects;			/* Number of objects in slab */
+	spinlock_t list_lock;
+	struct list_head partial;
+	unsigned long nr_partial;
+	struct page *active[NR_CPUS];
+};
+
+/*
+ * The page struct is used to keep necessary information about a slab.
+ * For a compound page the first page keeps the slab state.
+ *
+ * Lock order:
+ *   1. slab_lock(page)
+ *   2. slab->list_lock
+ *
+ * The slabifier assigns one slab for allocation to each processor.
+ * Allocations only occur from these active slabs.
+ *
+ * If a cpu slab is active then a workqueue thread checks every 10
+ * seconds if the cpu slab is still in use. The cpu slab is pushed back
+ * to the list if inactive [only needed for SMP].
+ *
+ * Leftover slabs with free elements are kept on a partial list.
+ * There is no list for full slabs. If an object in a full slab is
+ * freed then the slab will show up again on the partial lists.
+ * Otherwise there is no need to track filled up slabs.
+ *
+ * Slabs are freed when they become empty. Teardown and setup is
+ * minimal so we rely on the page allocators per cpu caches for
+ * fast frees and allocations.
+ */
+
+/*
+ * Locking for each individual slab using the pagelock
+ */
+static __always_inline void slab_lock(struct page *page)
+{
+	bit_spin_lock(PG_locked, &page->flags);
+}
+
+static __always_inline void slab_unlock(struct page *page)
+{
+	bit_spin_unlock(PG_locked, &page->flags);
+}
+
+/*
+ * Management of partially allocated slabs
+ */
+static void __always_inline add_partial(struct slab *s, struct page *page)
+{
+	spin_lock(&s->list_lock);
+	s->nr_partial++;
+	list_add_tail(&page->lru, &s->partial);
+	spin_unlock(&s->list_lock);
+}
+
+static void __always_inline remove_partial(struct slab *s,
+						struct page *page)
+{
+	spin_lock(&s->list_lock);
+	list_del(&page->lru);
+	s->nr_partial--;
+	spin_unlock(&s->list_lock);
+}
+
+/*
+ * Lock page and remove it from the partial list
+ *
+ * Must hold list_lock
+ */
+static __always_inline int lock_and_del_slab(struct slab *s,
+						struct page *page)
+{
+	if (bit_spin_trylock(PG_locked, &page->flags)) {
+		list_del(&page->lru);
+		s->nr_partial--;
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Get a partial page, lock it and return it.
+ */
+#ifdef CONFIG_NUMA
+static struct page *get_partial(struct slab *s, int node)
+{
+	struct page *page;
+	int searchnode = (node == -1) ? numa_node_id() : node;
+
+	spin_lock(&s->list_lock);
+	/*
+	 * Search for slab on the right node
+	 */
+	list_for_each_entry(page, &s->partial, lru)
+		if (likely(page_to_nid(page) == searchnode) &&
+			lock_and_del_slab(s, page))
+				goto out;
+
+	if (likely(node == -1)) {
+		/*
+		 * We can fall back to any other node in order to
+		 * reduce the size of the partial list.
+		 */
+		list_for_each_entry(page, &s->partial, lru)
+			if (likely(lock_and_del_slab(s, page)))
+				goto out;
+	}
+
+	/* Nothing found */
+	page = NULL;
+out:
+	spin_unlock(&s->list_lock);
+	return page;
+}
+#else
+static struct page *get_partial(struct slab *s, int node)
+{
+	struct page *page;
+
+	spin_lock(&s->list_lock);
+	list_for_each_entry(page, &s->partial, lru)
+		if (likely(lock_and_del_slab(s, page)))
+			goto out;
+
+	/* No slab or all slabs busy */
+	page = NULL;
+out:
+	spin_unlock(&s->list_lock);
+	return page;
+}
+#endif
+
+
+/*
+ * Debugging checks
+ */
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
+static int check_valid_pointer(struct slab *s, struct page *page,
+					 void *object, void *origin)
+{
+#ifdef SLABIFIER_DEBUG
+	void *base = page_address(page);
+
+	if (object < base || object >= base + s->objects * s->size) {
+		printk(KERN_CRIT "slab %s size %d: pointer %p->%p\nnot in"
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
+ * therefore free. Must hold the slab lock for active slabs to
+ * guarantee that the chains are consistent.
+ */
+static int on_freelist(struct slab *s, struct page *page, void *search)
+{
+	int nr = 0;
+	void **object = page->freelist;
+	void *origin = &page->lru;
+
+	if (PageSlabsingle(page))
+		return 0;
+
+	check_slab(page);
+
+	while (object && nr <= s->objects) {
+		if (object == search)
+			return 1;
+		if (!check_valid_pointer(s, page, object, origin))
+			goto try_recover;
+		origin = object;
+		object = object[s->offset];
+		nr++;
+	}
+
+	if (page->inuse != s->objects - nr) {
+		printk(KERN_CRIT "slab %s: page %p wrong object count."
+			" counter is %d but counted were %d\n",
+			s->sc.name, page, page->inuse,
+			s->objects - nr);
+try_recover:
+		printk(KERN_CRIT "****** Trying to continue by marking "
+			"all objects in the slab used (memory leak!)\n");
+		page->inuse = s->objects;
+		page->freelist =  NULL;
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
+ * Operations on slabs
+ */
+static void discard_slab(struct slab *s, struct page *page)
+{
+	atomic_long_dec(&s->nr_slabs);
+
+	page->mapping = NULL;
+	reset_page_mapcount(page);
+	__ClearPageSlab(page);
+	__ClearPageSlabsingle(page);
+
+	s->sc.page_alloc->free(s->sc.page_alloc, page, s->sc.order);
+}
+
+/*
+ * Allocate a new slab and prepare an empty freelist and the basic struct
+ * page settings.
+ */
+static struct page *new_slab(struct slab *s, gfp_t flags, int node)
+{
+	struct page *page;
+
+	if (flags & __GFP_WAIT)
+		local_irq_enable();
+
+	page = s->sc.page_alloc->allocate(s->sc.page_alloc, s->sc.order,
+			flags, node == -1 ? s->sc.node : node);
+	if (!page)
+		goto out;
+
+	page->offset = s->offset;
+
+	atomic_long_inc(&s->nr_slabs);
+
+	page->slab = (struct slab_cache *)s;
+	__SetPageSlab(page);
+
+	if (s->objects > 1) {
+		void *start = page_address(page);
+		void *end = start + s->objects * s->size;
+		void **last = start;
+		void *p = start + s->size;
+
+		while (p < end) {
+			last[s->offset] = p;
+			last = p;
+			p += s->size;
+		}
+		last[s->offset] = NULL;
+		page->freelist = start;
+		page->inuse = 0;
+		check_free_chain(s, page);
+	} else
+		__SetPageSlabsingle(page);
+
+out:
+	if (flags & __GFP_WAIT)
+		local_irq_disable();
+	return page;
+}
+
+/*
+ * Move a page back to the lists.
+ *
+ * Must be called with the slab lock held.
+ *
+ * On exit the slab lock will have been dropped.
+ */
+static void __always_inline putback_slab(struct slab *s, struct page *page)
+{
+	if (page->inuse) {
+		if (page->inuse < s->objects)
+			add_partial(s, page);
+		slab_unlock(page);
+	} else {
+		slab_unlock(page);
+		discard_slab(s, page);
+	}
+}
+
+/*
+ * Remove the currently active slab
+ */
+static void __always_inline deactivate_slab(struct slab *s,
+						struct page *page, int cpu)
+{
+	s->active[cpu] = NULL;
+	__ClearPageActive(page);
+	__ClearPageReferenced(page);
+
+	putback_slab(s, page);
+}
+
+/*
+ * Deactivate slab if we have an active slab.
+ */
+static void flush_active(struct slab *s, int cpu)
+{
+	struct page *page;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	page = s->active[cpu];
+	if (likely(page)) {
+		slab_lock(page);
+		deactivate_slab(s, page, cpu);
+	}
+	local_irq_restore(flags);
+}
+
+#ifdef CONFIG_SMP
+/*
+ * Check active per cpu slabs and flush them if they are not in use.
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
+		schedule_delayed_work(&s->flush, 2 * HZ);
+	else
+		s->flusher_active = 0;
+}
+
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
+#else
+static void drain_all(struct slab *s)
+{
+	flush_active(s, 0);
+}
+#endif
+
+static __always_inline void *__slab_alloc(struct slab_cache *sc,
+					gfp_t gfpflags, int node)
+{
+	struct slab *s = (void *)sc;
+	struct page *page;
+	void **object;
+	void *next_object;
+	unsigned long flags;
+	int cpu;
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	page = s->active[cpu];
+	if (!page)
+		goto new_slab;
+
+	slab_lock(page);
+	check_free_chain(s, page);
+	if (unlikely(!page->freelist))
+		goto another_slab;
+
+	if (unlikely(node != -1 && page_to_nid(page) != node))
+		goto another_slab;
+redo:
+	page->inuse++;
+	object = page->freelist;
+	page->freelist = next_object = object[page->offset];
+	__SetPageReferenced(page);
+	slab_unlock(page);
+	local_irq_restore(flags);
+	return object;
+
+another_slab:
+	deactivate_slab(s, page, cpu);
+
+new_slab:
+	/*
+	 * This was moved out of line since it dereferences s and thus
+	 * potentially touches an extra cacheline
+	 */
+	if (unlikely(s->objects == 1)) {
+		page = new_slab(s, gfpflags, node);
+		local_irq_restore(flags);
+		if (page)
+			return page_address(page);
+		else
+			return NULL;
+	}
+
+	/* Racy check. If we mistakenly see no partial slabs then we
+	 * just allocate an empty slab. If we mistakenly try to get a
+	 * partial slab then get_partials() will return NULL.
+	 */
+	if (s->nr_partial) {
+		page = get_partial(s, node);
+		if (page)
+			goto gotpage;
+	}
+
+	page = new_slab(s, flags, node);
+
+	if (!page) {
+		local_irq_restore(flags);
+		return NULL;
+	}
+
+	slab_lock(page);
+
+gotpage:
+	if (s->active[cpu]) {
+		slab_unlock(page);
+		discard_slab(s, page);
+		page = s->active[cpu];
+		slab_lock(page);
+	} else
+		s->active[cpu] = page;
+
+	__SetPageActive(page);
+	check_free_chain(s, page);
+
+#ifdef CONFIG_SMP
+	if (keventd_up() && !s->flusher_active) {
+		s->flusher_active = 1;
+		schedule_delayed_work(&s->flush, 2 * HZ);
+	}
+#endif
+	goto redo;
+}
+
+static void *slab_alloc(struct slab_cache *sc, gfp_t gfpflags)
+{
+	return __slab_alloc(sc, gfpflags, -1);
+}
+
+static void *slab_alloc_node(struct slab_cache *sc, gfp_t gfpflags,
+							int node)
+{
+#ifdef CONFIG_NUMA
+	return __slab_alloc(sc, gfpflags, node);
+#else
+	return slab_alloc(sc, gfpflags);
+#endif
+}
+
+static void slab_free(struct slab_cache *sc, const void *x)
+{
+	struct slab *s = (void *)sc;
+	struct page * page;
+	void *prior;
+	void **object = (void *)x;
+	unsigned long flags;
+
+	if (!object)
+		return;
+
+	page = virt_to_page(x);
+
+	if (unlikely(PageCompound(page)))
+		page = page->first_page;
+
+	if (!s)
+		s = (void *)page->slab;
+
+	if (unlikely(PageSlabsingle(page)))
+		goto single_object_slab;
+
+#ifdef SLABIFIER_DEBUG
+	if (unlikely(s != (void *)page->slab))
+		goto slab_mismatch;
+	if (unlikely(!check_valid_pointer(s, page, object, NULL)))
+		goto dumpret;
+#endif
+
+	local_irq_save(flags);
+	slab_lock(page);
+
+#ifdef SLABIFIER_DEBUG
+	if (on_freelist(s, page, object))
+		goto double_free;
+#endif
+
+	prior = object[page->offset] = page->freelist;
+	page->freelist = object;
+	page->inuse--;
+
+	if (likely(PageActive(page) || (page->inuse && prior))) {
+out_unlock:
+		slab_unlock(page);
+		local_irq_restore(flags);
+		return;
+	}
+
+	if (!prior) {
+		/*
+		 * Page was fully used before. It will have one free
+		 * object now. So move to the partial list.
+		 */
+		add_partial(s, page);
+		goto out_unlock;
+	}
+
+	/*
+	 * All object have been freed.
+	 */
+	remove_partial(s, page);
+	slab_unlock(page);
+	discard_slab(s, page);
+	local_irq_restore(flags);
+	return;
+
+single_object_slab:
+	discard_slab(s, page);
+	return;
+
+#ifdef SLABIFIER_DEBUG
+double_free:
+	printk(KERN_CRIT "slab_free %s: object %p already free.\n",
+					s->sc.name, object);
+	dump_stack();
+	goto out_unlock;
+
+slab_mismatch:
+	if (!PageSlab(page)) {
+		printk(KERN_CRIT "slab_free %s size %d: attempt to free "
+			"object(%p) outside of slab.\n",
+			s->sc.name, s->size, object);
+		goto dumpret;
+	}
+
+	if (!page->slab) {
+		printk(KERN_CRIT
+			"slab_free : no slab(NULL) for object %p.\n",
+					object);
+			goto dumpret;
+	}
+
+	printk(KERN_CRIT "slab_free %s(%d): object at %p"
+			" belongs to slab %s(%d)\n",
+			s->sc.name, s->sc.size, object,
+			page->slab->name, page->slab->size);
+
+dumpret:
+	dump_stack();
+	printk(KERN_CRIT "***** Trying to continue by not "
+			"freeing object.\n");
+	return;
+#endif
+}
+
+/* Figure out on which slab object the object resides */
+static __always_inline struct page *get_object_page(const void *x)
+{
+	struct page * page = virt_to_page(x);
+
+	if (unlikely(PageCompound(page)))
+		page = page->first_page;
+
+	if (!PageSlab(page))
+		return NULL;
+
+	return page;
+}
+
+/*
+ * slab_create produces objects aligned at size and the first object
+ * is placed at offset 0 in the slab (We have no metainformation on the
+ * slab, all slabs are in essence off slab).
+ *
+ * In order to get the desired alignment one just needs to align the
+ * size.
+ *
+ * Notice that the allocation order determines the sizes of the per cpu
+ * caches. Each processor has always one slab available for allocations.
+ * Increasing the allocation order reduces the number of times that slabs
+ * must be moved on and off the partial lists and therefore may influence
+ * locking overhead.
+ *
+ * The offset is used to relocate the free list link in each object. It is
+ * therefore possible to move the free list link behind the object. This
+ * is necessary for RCU to work properly and also useful for debugging.
+ *
+ * However no freelists are necessary if there is only one element per
+ * slab.
+ */
+static struct slab_cache *slab_create(struct slab_control *x,
+	const struct slab_cache *sc)
+{
+	struct slab *s = (void *)x;
+	int cpu;
+
+	/* Verify that the generic structure is big enough for our data */
+	BUG_ON(sizeof(struct slab_control) < sizeof(struct slab));
+
+	memcpy(&x->sc, sc, sizeof(struct slab_cache));
+
+	s->size = ALIGN(sc->size, sizeof(void *));
+
+	if (sc->offset > s->size - sizeof(void *) ||
+			(sc->offset % sizeof(void*)))
+		return NULL;
+
+	s->offset = sc->offset / sizeof(void *);
+	BUG_ON(s->offset > 65535);
+	s->objects = (PAGE_SIZE << sc->order) / s->size;
+	BUG_ON(s->objects > 65535);
+	atomic_long_set(&s->nr_slabs, 0);
+	s->nr_partial = 0;
+#ifdef CONFIG_SMP
+	s->flusher_active = 0;
+	INIT_WORK(&s->flush, &flusher, s);
+#endif
+	if (!s->objects)
+		return NULL;
+
+	INIT_LIST_HEAD(&s->partial);
+
+	atomic_set(&s->refcount, 1);
+	spin_lock_init(&s->list_lock);
+
+	for_each_possible_cpu(cpu)
+		s->active[cpu] = NULL;
+	return &s->sc;
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
+	page = get_object_page(object);
+
+	if (!page || sc != page->slab)
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
+	struct slab_cache *s;
+
+
+	page = get_object_page(object);
+	if (page) {
+		s = page->slab;
+		BUG_ON(sc && s != sc);
+		if (s)
+			return sc->size;
+	}
+	BUG();
+	return 0;	/* Satisfy compiler */
+}
+
+/*
+ * Move slab objects in a given slab by calling the move_objects function.
+ *
+ * Must be called with the slab lock held but will drop and reacquire the
+ * slab lock.
+ */
+static int move_slab_objects(struct slab *s, struct page *page,
+			 int (*move_objects)(struct slab_cache *, void *))
+{
+	int unfreeable = 0;
+	void *addr = page_address(page);
+
+	while (page->inuse - unfreeable > 0) {
+		void *p;
+
+		for (p = addr; p < addr + s->objects; p+= s->size) {
+			if (!on_freelist(s, page, p)) {
+				/*
+				 * Drop the lock here to allow the
+				 * move_object function to do things
+				 * with the slab_cache and maybe this
+				 * page.
+				 */
+				slab_unlock(page);
+				local_irq_enable();
+				if (move_objects((struct slab_cache *)s, p))
+					slab_free(&s->sc, p);
+				else
+					unfreeable++;
+				local_irq_disable();
+				slab_lock(page);
+			}
+		}
+	}
+	return unfreeable;
+}
+
+/*
+ * Shrinking drops the active per cpu slabs and also reaps all empty
+ * slabs off the partial list. Returns the number of slabs freed.
+ *
+ * The move_object function will be called for each objects in partially
+ * allocated slabs. move_object() needs to perform a new allocation for
+ * the object and move the contents of the object to the new location.
+ *
+ * If move_object() returns 1 for success then the object is going to be
+ * removed. If 0 then the object cannot be freed at all. As a result the
+ * slab containing the object will also not be freeable.
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
+
+	local_irq_save(flags);
+	for(i = 0; s->nr_partial > 1 && i < s->nr_partial - 1; i++ ) {
+		struct page * page;
+
+		page = get_partial(s, -1);
+		if (!page)
+			break;
+
+		/*
+		 * Pin page so that slab_free will not free even if we
+		 * drop the slab lock.
+		 */
+		__SetPageActive(page);
+
+		if (page->inuse < s->objects && move_object)
+			if (move_slab_objects(s,
+					page, move_object) == 0)
+				slabs_freed++;
+
+		/*
+		 * This will put the slab on the front of the partial
+		 * list, the used list or free it.
+		 */
+		__ClearPageActive(page);
+		putback_slab(s, page);
+	}
+	local_irq_restore(flags);
+	return slabs_freed;
+
+}
+
+static struct slab_cache *slab_dup(struct slab_cache *sc)
+{
+	struct slab *s = (void *)sc;
+
+	atomic_inc(&s->refcount);
+	return &s->sc;
+}
+
+static int free_list(struct slab *s, struct list_head *list)
+{
+	int slabs_inuse = 0;
+	unsigned long flags;
+	struct page *page, *h;
+
+	spin_lock_irqsave(&s->list_lock, flags);
+	list_for_each_entry_safe(page, h, list, lru)
+		if (!page->inuse) {
+			list_del(&s->partial);
+			discard_slab(s, page);
+		} else
+			slabs_inuse++;
+	spin_unlock_irqrestore(&s->list_lock, flags);
+	return slabs_inuse;
+}
+
+static int slab_destroy(struct slab_cache *sc)
+{
+	struct slab *s = (void *)sc;
+
+	if (!atomic_dec_and_test(&s->refcount))
+		return 0;
+
+	drain_all(s);
+	free_list(s, &s->partial);
+
+	if (atomic_long_read(&s->nr_slabs))
+		return 1;
+
+	/* Just to make sure that no one uses this again */
+	s->size = 0;
+	return 0;
+}
+
+static unsigned long count_objects(struct slab *s, struct list_head *list)
+{
+	int count = 0;
+	struct page *page;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->list_lock, flags);
+	list_for_each_entry(page, list, lru)
+		count += page->inuse;
+	spin_unlock_irqrestore(&s->list_lock, flags);
+	return count;
+}
+
+static unsigned long slab_objects(struct slab_cache *sc,
+	unsigned long *p_total, unsigned long *p_active,
+	unsigned long *p_partial)
+{
+	struct slab *s = (void *)sc;
+	int partial = count_objects(s, &s->partial);
+	int nr_slabs = atomic_read(&s->nr_slabs);
+	int active = 0;		/* Active slabs */
+	int nr_active = 0;	/* Objects in active slabs */
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct page *page = s->active[cpu];
+
+		if (page) {
+			nr_active++;
+			active += page->inuse;
+		}
+	}
+
+	if (p_partial)
+		*p_partial = s->nr_partial;
+
+	if (p_active)
+		*p_active = nr_active;
+
+	if (p_total)
+		*p_total = nr_slabs;
+
+	return partial + active +
+		(nr_slabs - s->nr_partial - nr_active) * s->objects;
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
+	.get_objects = slab_objects,
+	.shrink = slab_shrink,
+	.dup = slab_dup,
+	.destroy = slab_destroy,
+	.destructor = null_slab_allocator_destructor,
+};
+EXPORT_SYMBOL(slabifier_allocator);
Index: linux-2.6.18-rc5-mm1/mm/Makefile
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/Makefile	2006-09-01 14:10:50.404299038 -0700
+++ linux-2.6.18-rc5-mm1/mm/Makefile	2006-09-01 14:10:50.510737778 -0700
@@ -28,4 +28,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o
Index: linux-2.6.18-rc5-mm1/include/linux/mm.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/linux/mm.h	2006-09-01 10:13:35.890454083 -0700
+++ linux-2.6.18-rc5-mm1/include/linux/mm.h	2006-09-01 14:10:50.530267822 -0700
@@ -226,10 +226,16 @@ struct page {
 	unsigned long flags;		/* Atomic flags, some possibly
 					 * updated asynchronously */
 	atomic_t _count;		/* Usage count, see below. */
-	atomic_t _mapcount;		/* Count of ptes mapped in mms,
+	union {
+		atomic_t _mapcount;	/* Count of ptes mapped in mms,
 					 * to show when page is mapped
 					 * & limit reverse map searches.
 					 */
+		struct {	/* Slabifier */
+			short unsigned int inuse;
+			short unsigned int offset;
+		};
+	};
 	union {
 	    struct {
 		unsigned long private;		/* Mapping-private opaque data:
@@ -250,8 +256,15 @@ struct page {
 #if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
 	    spinlock_t ptl;
 #endif
+	    struct {			/* Slabifier */
+		struct page *first_page;	/* Compound pages */
+		struct slab_cache *slab;	/* Pointer to slab */
+	    };
+	};
+	union {
+		pgoff_t index;		/* Our offset within mapping. */
+		void *freelist;		/* Slabifier: free object */
 	};
-	pgoff_t index;			/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list
 					 * protected by zone->lru_lock !
 					 */
Index: linux-2.6.18-rc5-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/linux/page-flags.h	2006-09-01 10:13:36.121885132 -0700
+++ linux-2.6.18-rc5-mm1/include/linux/page-flags.h	2006-09-01 14:10:50.530267822 -0700
@@ -92,7 +92,7 @@
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
 #define PG_readahead		20	/* Reminder to do readahead */
-
+#define PG_slabsingle		21	/* Slab with a single object */
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -126,6 +126,8 @@
 #define PageReferenced(page)	test_bit(PG_referenced, &(page)->flags)
 #define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
+#define __SetPageReferenced(page) __set_bit(PG_referenced, &(page)->flags)
+#define __ClearPageReferenced(page) __clear_bit(PG_referenced, &(page)->flags)
 #define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
 
 #define PageUptodate(page)	test_bit(PG_uptodate, &(page)->flags)
@@ -155,6 +157,7 @@
 
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
+#define __SetPageActive(page)	__set_bit(PG_active, &(page)->flags)
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
 #define __ClearPageActive(page)	__clear_bit(PG_active, &(page)->flags)
 
@@ -254,6 +257,10 @@
 #define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
 #define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
 
+#define PageSlabsingle(page)	test_bit(PG_slabsingle, &(page)->flags)
+#define __SetPageSlabsingle(page) __set_bit(PG_slabsingle, &(page)->flags)
+#define __ClearPageSlabsingle(page) __clear_bit(PG_slabsingle, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);

-- 
VGER BF report: U 0.5
