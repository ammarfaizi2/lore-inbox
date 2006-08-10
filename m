Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWHJAwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWHJAwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWHJAwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:52:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14769 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932456AbWHJAwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:52:20 -0400
Date: Wed, 9 Aug 2006 17:52:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Matt Mackall <mpm@selenic.com>
cc: npiggin@suse.de, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: [RFC] Simple Slab: A slab allocator with minimal meta information
Message-ID: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately I have started tinkering around with the slab in particular after
Matt Mackal mentioned that the slab should be more modular at the KS.

One particular design issue with the current slab is that it is build on the
basic notion of shifting object references from list to list. Without NUMA this
is wild enough with the per cpu caches and the shared cache but with NUMA we now
have per node shared arrays, per node list and per node per node alien caches.
Somehow this all works but one wonders does it have to be that way? On very
large systems the number of these entities grows to unbelievable numbers.

After getting through a lot of patching of the existing slab to get there 
I got finally fed up with this. Maybe it is best to try to develop another 
basic slab layer that does not have all the object queues and that does 
not have to carry so much state information. I also have had concerns 
about the way locking is handled for awhile. We could increase parallelism 
by finer grained locking. This in turn may avoid the need for object 
queues (what was it... We had ~7-10 mio cpu array allocations on our 1k 
processor system on bootup ...). Ironically not having object queues may 
be beneficial for embedded and for large systems at this point.

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
allocator.  The page allocator has its own per cpu page queues that should provide
enough caching.

Per cpu caches exist in the sense that each processor has a per processor
"cpuslab". Objects in this slab will only be allocated from this processor.
The page state is likely going to stay in the cache. Allocation will be
very fast since we only need the page struct reference for all our needs
which is likely not contended at all. Fetching the next free pointer from
the location of the object nicely prefetches the object.

This is by no means complete and probably full of bugs. Feedback and help 
wanted! I have tried to switch over two minor system caches (memory 
policies) to use simple slab and it seems to work. We probably have some 
way to go before we could do performance tests.

sslab does not disable interrupts by default--Not sure if that is something that would be
desirable. sslab does not have the per cpu object cache addiction of the regular slab
that requires the disablig of irqs. Maybe there is a way to work around it.

The Simple Slab is not NUMA capable at this point and I think the NUMAness may
better be implemented in a different way. Maybe we could understand the Simple Slab
as a lower layer and then add all the bells and whistles including NUMAness, proc API,
kmalloc caches etc. on top as a management layer for this lower level 
functionality.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4/include/linux/sslab.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/include/linux/sslab.h	2006-08-09 16:54:19.506233021 -0700
@@ -0,0 +1,79 @@
+/*
+ * Slab allocator with minimal management overhead.
+ *
+ * (C) 2006 Silicon Graphics Inc., Christoph Lameter <clameter@sgi.com>
+ */
+#include <linux/mm.h>
+
+/*
+ * In a NUMA configuration we plan to have an sslab per node and we can
+ * then allocate based on the node. The NR_CPUS should reflect the
+ * maximum number of processors per node. Remote processors will share in
+ * the use of cpuslabs.
+ */
+struct sslab {
+	struct list_head partial;	/* List of partially allocated slabs */
+	struct list_head full;		/* Fully allocated slabs */
+	struct list_head active;	/* Slabs from which we currently allocate */
+	spinlock_t list_lock;		/* Lock for partial slabs */
+	int order;			/* Allocation order */
+	gfp_t gfpflags;			/* Allocation flags */
+	unsigned int size;		/* Size of objects */
+	unsigned long slabs;		/* Slabs in use for this one */
+	unsigned long objects;		/* Objects per slab */
+	struct page *cpuslab[NR_CPUS];	/* Per CPU slabs list */
+	struct work_struct flush[NR_CPUS];/* Cache flushers */
+};
+
+/*
+ * Sslab_create produces objects aligned at size and the first object
+ * is placed at offset 0 in the slab (sslab has no metainformation on the
+ * slab, all slabs are in essence off slab).
+ *
+ * In order to get the desired alignment one just needs to align the
+ * size. F.e.
+ *
+ * sslab_create(&my_cache, ALIGN(sizeof(struct mystruct)), CACHE_L1_SIZE), 2, GFP_KERNEL);
+ *
+ * Notice that the allocation order determines the sizes of the per cpu caches.
+ * Each processor has always one slab available for allocations. Increasing the
+ * allocation order reduces the number of times that slabs must be moved
+ * on and off lists and therefore influences sslab overhead.
+ */
+
+extern int sslab_create(struct sslab *s, size_t size, int order, gfp_t flags);
+
+extern void *sslab_alloc(struct sslab *, gfp_t);
+extern void *sslab_zalloc(struct sslab *, gfp_t);
+
+/*
+ * If the struct sslab pointer is NULL then sslab will determine the
+ * proper cache on its on. Otherwise the sslab pointer will be verified
+ * before object removal.
+ */
+extern void sslab_free(struct sslab *, void *);
+
+/*
+ * Preloading allows a guarantee that the slab will not call the page
+ * allocator for the given number of allocations. This will add new slabs
+ * to the partial list until the required number of objects can be allocated
+ * without additional system call overhead.
+ */
+extern void sslab_preload(struct sslab *, unsigned long);
+
+extern void sslab_destroy(struct sslab *);
+
+/*
+ * Shrinking drops all the per cpu slabs and also reaps all empty slabs
+ * off the partial list. (preloading may have added those).
+ *
+ * Note that there is currently no slab reaping. The per cpu slabs
+ * will stay allocated if this function is not called.
+ */
+extern void sslab_shrink(struct sslab *);
+
+extern int sslab_pointer_valid(struct sslab *, void *);
+
+extern unsigned long sslab_objects(struct sslab *);
+
+
Index: linux-2.6.18-rc4/mm/sslab.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4/mm/sslab.c	2006-08-09 16:54:19.505256518 -0700
@@ -0,0 +1,528 @@
+/*
+ * Simple slab allocator with minimal management overhead.
+ *
+ * (C) 2006 Silicon Graphics Inc., Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/sslab.h>
+#include <linux/bit_spinlock.h>
+
+/*
+ * The page struct is used to keep necessary information about a slab.
+ * For a compound page the first page keeps the slab state.
+ *
+ * Overloaded fields in struct page:
+ *
+ * 	lru	 -> used to a slab on the lists
+ *	mapping	 -> pointer to struct sslab
+ *	index	 -> pointer to next free object
+ *	_mapcount -> count number of elements in use
+ *
+ * Lock order:
+ *   1. slab_lock(page)
+ *   2. sslab->list_lock
+ *
+ * The sslab assigns one slab for allocation to each processor
+ * for allocations. This slab is on the active list and allocations
+ * occur only on the active slabs. If a cpuslab is active then
+ * a workqueue thread checks every 10 seconds if the cpuslab is
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
+#define SSLAB_DEBUG
+
+#define lru_to_page(_head) (list_entry((_head)->next, struct page, lru))
+
+/* Some definitions to overload certain fields in struct page */
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
+static void *get_sslab(struct page *page)
+{
+	return (struct sslab *)page->mapping;
+}
+
+static void set_sslab(struct page *page, struct sslab *s)
+{
+	page->mapping = (void *)s;
+}
+
+int *object_counter(struct page *page)
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
+ * Locking for each individual slab using the pagelock
+ */
+static void slab_lock(struct page *page)
+{
+	if (!TestSetPageLocked(page))
+		return;
+	bit_spin_lock(PG_locked, &page->flags);
+}
+
+static void slab_unlock(struct page *page)
+{
+	smp_mb__before_clear_bit();
+	if (!TestClearPageLocked(page))
+		BUG();
+}
+
+/*
+ * Discard an unused slab page
+ * List lock is held.
+ */
+static void discard_slab(struct sslab *s, struct page *page)
+{
+	list_del(&page->lru);
+	s->slabs--;
+	set_sslab(page, NULL);
+	set_object_pointer(page, NULL);
+	set_object_counter(page, -1);	/* -1 is convention for mapcount */
+	__ClearPageSlab(page);
+	__free_pages(page, s->order);
+	sub_zone_page_state(page_zone(page), NR_SLAB, 1 << s->order);
+}
+
+static struct page *new_slab(struct sslab *s)
+{
+	void **p, **last;
+	int i;
+	struct page *page;
+
+	page = alloc_pages(s->gfpflags, s->order);
+	if (!page)
+		return NULL;
+
+	set_sslab(page, s);
+	last = page_address(page);
+	set_object_pointer(page, last);
+
+	for (i = 0; i < s->objects - 1; i++) {
+		p = last + s->size / sizeof(void *);
+		*last = p;
+		last = p;
+	}
+	*last = NULL;
+
+	__SetPageSlab(page);
+	set_object_counter(page, 0);
+	add_zone_page_state(page_zone(page), NR_SLAB, 1 << s->order);
+	return page;
+}
+/*
+ * Return a per cpu slab by taking it off the active list.
+ */
+void flush_cpuslab(struct sslab *s, int cpu)
+{
+	struct page *page;
+
+	/* Terminate any active flusher */
+	cancel_delayed_work(&s->flush[cpu]);
+
+	/* Avoid lock inversion here. */
+redo:
+	page = s->cpuslab[cpu];
+	if (!page)
+		return;
+	slab_lock(page);
+	if (s->cpuslab[cpu] != page) {
+		slab_unlock(page);
+		goto redo;
+	}
+
+	spin_lock(&s->list_lock);
+	page = s->cpuslab[cpu];
+	s->cpuslab[cpu] = NULL;
+	ClearPageActive(page);
+	if (get_object_counter(page)) {
+		if (get_object_counter(page) < s->objects)
+			list_move(&page->lru, &s->partial);
+		else
+			list_move(&page->lru, &s->full);
+		spin_unlock(&s->list_lock);
+		slab_unlock(page);
+	} else {
+		slab_unlock(page);
+		discard_slab(s, page);
+		spin_unlock(&s->list_lock);
+	}
+}
+
+/*
+ * Flush the per cpu slab if it is not in use.
+ */
+void flusher(void *d)
+{
+	struct sslab *s = d;
+	int cpu = smp_processor_id();
+	struct page *page;
+
+	page = s->cpuslab[cpu];
+
+	if (!page)
+		return;
+
+	if (PageReferenced(page)) {
+		ClearPageReferenced(page);
+		schedule_delayed_work(&s->flush[cpu], 10 * HZ);
+	} else
+		flush_cpuslab(s, cpu);
+}
+
+/*
+ * Reload the per cpu slab
+ */
+static int reload(struct sslab *s, int cpu, gfp_t flags)
+{
+	struct page *page;
+
+	cancel_delayed_work(&s->flush[cpu]);
+	spin_lock(&s->list_lock);
+	if (!list_empty(&s->partial)) {
+		page = lru_to_page(&s->partial);
+		list_move(&page->lru, &s->active);
+
+	} else {
+
+		/* No slabs with free objets */
+		spin_unlock(&s->list_lock);
+		page = new_slab(s);
+		if (!page)
+			return 0;
+
+		spin_lock(&s->list_lock);
+		s->slabs++;
+		list_add(&page->lru, &s->active);
+	}
+	SetPageActive(page);
+	ClearPageReferenced(page);
+	s->cpuslab[cpu] = page;
+	spin_unlock(&s->list_lock);
+	if (keventd_up())
+		schedule_delayed_work_on(cpu, &s->flush[cpu], 10 * HZ);
+	return 1;
+}
+
+
+void check_valid_pointer(struct sslab *s, struct page *page, void *object)
+{
+#ifdef SSLAB_DEBUG
+	BUG_ON(!PageSlab(page));
+	BUG_ON(object < page_address(page));
+	BUG_ON(object >= page_address(page) + s->objects * s->size);
+	BUG_ON((object - page_address(page)) % s->size);
+#endif
+}
+
+void check_free_chain(struct sslab *s, struct page *page)
+{
+#ifdef SSLAB_DEBUG
+	int nr = 0;
+	void **object = get_sslab(page);
+
+	BUG_ON(!PageSlab(page));
+
+	while (object) {
+		check_valid_pointer(s, page, object);
+		object = *object;
+		nr++;
+	}
+	BUG_ON(nr > s->objects);
+#endif
+}
+
+/*
+ * Create a new slab.
+ */
+int sslab_create(struct sslab *s, size_t size, int order, gfp_t flags)
+{
+	int cpu;
+
+	s->size = ALIGN(size, sizeof(void *));
+	s->order = order;
+	s->gfpflags = flags;
+	if (order > 1)
+		s->gfpflags  |= __GFP_COMP;
+	s->objects = (PAGE_SIZE << order) / size;
+	if (!s->objects)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&s->partial);
+	INIT_LIST_HEAD(&s->full);
+	INIT_LIST_HEAD(&s->active);
+	spin_lock_init(&s->list_lock);
+	s->slabs = 0;
+	for_each_possible_cpu(cpu) {
+		s->cpuslab[cpu] = NULL;
+		INIT_WORK(&s->flush[cpu], &flusher, s);
+	}
+	return 0;
+}
+
+void *sslab_alloc(struct sslab *s, gfp_t flags)
+{
+	int cpu = smp_processor_id();
+	struct page *page;
+	void **x;
+
+	do {
+		page = s->cpuslab[cpu];
+		if (unlikely(!page))
+			continue;
+
+		check_free_chain(s, page);
+		slab_lock(page);
+		if (!PageActive(page)) {
+			slab_unlock(page);
+			continue;
+		}
+		x = get_object_pointer(page);
+		if (likely(x)) {
+			set_object_pointer(page, *x);
+			inc_object_counter(page);
+			SetPageReferenced(page);
+			slab_unlock(page);
+			check_free_chain(s, page);
+			return x;
+		}
+
+		/* Slab is full */
+		spin_lock(&s->list_lock);
+		ClearPageActive(page);
+		list_move(&page->lru, &s->full);
+		s->cpuslab[cpu] = NULL;
+		spin_unlock(&s->list_lock);
+		slab_unlock(page);
+	} while (reload(s, cpu, flags));
+	return NULL;
+}
+
+/*
+ * Allocate and zero an object
+ */
+void *sslab_zalloc(struct sslab *s, gfp_t flags)
+{
+	void *x = sslab_alloc(s, flags);
+
+	if (x)
+		memset(x, 0, s->size);
+	return x;
+}
+
+void sslab_free(struct sslab *s, void *object) {
+	struct page * page;
+	int leftover;
+	void *prior;
+
+	/* Figure out on which slab the object resides */
+	page = virt_to_page(object);
+	if (unlikely(PageCompound(page)))
+		page = (struct page *)page_private(page);
+
+	if (!s)
+		s = get_sslab(page);
+	else
+		BUG_ON(s != get_sslab(page));
+
+	check_free_chain(s, page);
+	check_valid_pointer(s, page, object);
+	slab_lock(page);
+	prior = get_object_pointer(page);
+	* (void **) object = prior;
+	set_object_pointer(page, object);
+	dec_object_counter(page);
+	leftover = get_object_counter(page);
+	slab_unlock(page);
+
+	if (unlikely(PageActive(page)))
+		return;
+
+	if (unlikely(leftover == 0)) {
+		spin_lock(&s->list_lock);
+		if (PageActive(page)) {
+			/* No discarding of slabs under active allocation */
+			spin_unlock(&s->list_lock);
+			return;
+		}
+		discard_slab(s, page);
+		spin_unlock(&s->list_lock);
+	}
+
+	if (unlikely(!prior)) {
+		/*
+		 * Page was fully used before. It will only have one free
+		 * object now. So move to the front of the partial list.
+		 */
+		spin_lock(&s->list_lock);
+		if (!PageActive(page))
+			list_move(&page->lru, &s->partial);
+		spin_unlock(&s->list_lock);
+	}
+	check_free_chain(s, page);
+}
+
+/*
+ * Check if a given pointer is valid
+ */
+int sslab_pointer_valid(struct sslab *s, void *object) {
+	struct page * page;
+	void *slab_addr;
+
+	/* Figure out on which slab the object resides */
+	page = virt_to_page(object);
+	if (unlikely(PageCompound(page)))
+		page = (struct page *)page_private(page);
+
+	if (!PageSlab(page) || s != get_sslab(page))
+		return 0;
+
+	slab_addr = page_address(page);
+	if (object < slab_addr || object >= slab_addr + s->objects * s->size)
+		return 0;
+
+	if ((object - slab_addr) & s->size)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * Preload the cache with enough slabs so that we we not need to
+ * allocate for the specified number of objects.
+ */
+void sslab_preload(struct sslab *s, unsigned long nr)
+{
+	int nr_local = 0;
+	int cpu = smp_processor_id();
+	struct page * page = s->cpuslab[cpu];
+
+	if (page)
+		nr_local = get_object_counter(page);
+
+	nr_local += sslab_objects(s);
+
+	while (nr_local < nr) {
+		struct page *page = new_slab(s);
+
+		spin_lock(&s->list_lock);
+		list_add_tail(&page->lru, &s->partial);
+		s->slabs++;
+		spin_unlock(&s->list_lock);
+		nr_local += s->objects;
+	}
+}
+
+
+static void drain_cpu(void *v)
+{
+	struct sslab *s = v;
+
+	flush_cpuslab(s, smp_processor_id());
+}
+
+/*
+ * Try to remove as many slabs as possible. In particular try to undo the
+ * effect of sslab_preload which may have added empty pages to the
+ * partial list.
+ */
+void sslab_shrink(struct sslab *s) {
+	struct list_head *h1,*h2;
+
+	spin_lock(&s->list_lock);
+	list_for_each_safe(h1, h2, &s->partial) {
+		struct page *page = lru_to_page(h1);
+
+		if (get_object_counter(page) == 0)
+			discard_slab(s, page);
+	}
+	spin_unlock(&s->list_lock);
+
+	/*
+	 * Free each of the per cpu slabs
+	 */
+	on_each_cpu(drain_cpu, s, 0, 0);
+}
+
+static void free_list(struct sslab *s, struct list_head *list)
+{
+	while (!list_empty(list))
+		discard_slab(s, lru_to_page(list));
+
+}
+
+/*
+ * Release all leftover slabs. If there are any leftover pointers dangling
+ * to these objects then we will get into a lot of trouble later.
+ */
+void sslab_destroy(struct sslab *s)
+{
+	sslab_shrink(s);
+
+	spin_lock(&s->list_lock);
+	free_list(s, &s->full);
+	free_list(s, &s->partial);
+	spin_unlock(&s->list_lock);
+
+	/* Just to make sure that no one uses this again */
+	s->size = 0;
+	BUG_ON(s->slabs);
+}
+
+static unsigned long count_objects(struct sslab *s, struct list_head *list)
+{
+	int count = 0;
+	struct list_head *h1;
+
+	spin_lock(&s->list_lock);
+	list_for_each(h1, list) {
+		struct page *page = lru_to_page(h1);
+
+		count += get_object_counter(page);
+	}
+	spin_unlock(&s->list_lock);
+	return count;
+}
+
+unsigned long sslab_objects(struct sslab *s)
+{
+	return count_objects(s, &s->partial) +
+		 count_objects(s, &s->full) +
+		count_objects(s, &s->active);
+}
+
Index: linux-2.6.18-rc4/mm/Makefile
===================================================================
--- linux-2.6.18-rc4.orig/mm/Makefile	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/mm/Makefile	2006-08-09 15:14:42.694933996 -0700
@@ -19,8 +19,9 @@ obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
 obj-$(CONFIG_SLOB) += slob.o
-obj-$(CONFIG_SLAB) += slab.o
+obj-$(CONFIG_SLAB) += slab.o sslab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 
+
