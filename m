Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWIAWfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWIAWfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIAWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:34:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41444 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751131AbWIAWer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:47 -0400
Date: Fri, 1 Sep 2006 15:34:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060901223424.21034.94168.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
References: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 5/5] Slabulator: Emulate the existing Slab Layer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The slab emulation layer.

This provides a layer that implements the existing slab API.
We try to keep the definitions that we copy from slab.h
to an absolute minimum. If things break then more
(useless) definitions from slab.h may be needed.

We put a hook into slab.h to redirect includes for slab.h to
slabulator.h.

The slabulator also contains the remnants of the slab reaper since it is
used by the page allocator in the CONFIG_NUMA case. The slabifier does not
need this anymore since it is not object cache based.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc5-mm1/mm/slabulator.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/mm/slabulator.c	2006-09-01 14:10:50.808570950 -0700
@@ -0,0 +1,299 @@
+/*
+ * Slabulator = Emulate the Slab API.
+ *
+ * (C) 2006 Silicon Graphics, Inc. Christoph Lameter <clameter@sgi.com>
+ *
+ */
+#include <linux/mm.h>
+#include <linux/kmalloc.h>
+#include <linux/module.h>
+#include <linux/allocator.h>
+#include <linux/bitops.h>
+#include <linux/slabulator.h>
+#include <linux/slabstat.h>
+
+#define SLAB_MAX_ORDER 4
+
+#define SLABULATOR_MERGE
+
+#ifndef ARCH_SLAB_MINALIGN
+#define ARCH_SLAB_MINALIGN sizeof(void *)
+#endif
+
+static int calculate_order(int size)
+{
+	int order;
+	int rem;
+
+	if ((size & (size -1)) == 0) {
+		/*
+		 * We can use the page allocator if the requested size
+		 * is compatible with the page sizes supported.
+		 */
+		int order = fls(size) -1 - PAGE_SHIFT;
+
+		if (order >= 0)
+			return 0;
+	}
+
+	for(order = max(slab_min_order, fls(size - 1) - PAGE_SHIFT);
+			order < MAX_ORDER; order++) {
+		unsigned long slab_size = PAGE_SIZE << order;
+
+		if (slab_size < size)
+			continue;
+
+		rem = slab_size % size;
+
+		if (rem * 8 <= PAGE_SIZE << order)
+			break;
+
+	}
+	if (order >= MAX_ORDER)
+		return -E2BIG;
+	return order;
+}
+
+/*
+ * We can actually operate slabs any time after the page allocator is up.
+ * slab_is_available() merely means that the kmalloc array is available.
+ *
+ * However, be aware that deriving allocators depends on kmalloc being
+ * functional.
+ */
+int slabulator_up = 0;
+
+int slab_is_available(void) {
+	return slabulator_up;
+}
+
+void kmem_cache_init(void)
+{
+	extern void kmalloc_init(void);
+
+	kmalloc_init();
+	slabulator_up = 1;
+}
+
+struct slab_cache *kmem_cache_create(const char *name, size_t size,
+		size_t align, unsigned long flags,
+		void (*ctor)(void *, struct slab_cache *, unsigned long),
+		void (*dtor)(void *, struct slab_cache *, unsigned long))
+{
+	const struct page_allocator *a;
+	struct slab_cache s;
+	struct slab_cache *rs;
+	struct slab_control *x;
+	int one_object_slab;
+
+	s.offset = 0;
+	s.align = max(ARCH_SLAB_MINALIGN, ALIGN(align, sizeof(void *)));
+
+	if (flags & (SLAB_MUST_HWCACHE_ALIGN|SLAB_HWCACHE_ALIGN))
+		s.align = L1_CACHE_BYTES;
+
+	s.inuse = size;
+	s.objsize = size;
+	s.size = ALIGN(size, s.align);
+
+	/* Pick the right allocator for our purposes */
+	if (flags & SLAB_RECLAIM_ACCOUNT)
+		a = reclaimable_allocator;
+	else
+		a = unreclaimable_allocator;
+
+	if (flags & SLAB_CACHE_DMA)
+		a = dmaify_page_allocator(a);
+
+	if (flags & SLAB_DESTROY_BY_RCU)
+		a = rcuify_page_allocator(a);
+
+	one_object_slab = s.size > ((PAGE_SIZE / 2)  << calculate_order(s.size));
+
+	if (!one_object_slab && ((flags & SLAB_DESTROY_BY_RCU) || ctor || dtor)) {
+		/*
+		 * For RCU processing and constructors / destructors:
+		 * The object must remain intact even if it is free.
+		 * The free pointer would hurt us there.
+		 * Relocate the free object pointer out of
+		 * the space used by the object.
+		 *
+		 * Slabs with a single object do not need this since
+		 * those do not have to deal with free pointers.
+		 */
+		s.offset = s.size - sizeof(void *);
+		if (s.offset < s.objsize) {
+			/*
+			 * Would overlap the object. We need to waste some
+			 * more space to make the object safe from the
+			 * free pointer.
+			 */
+			s.offset = s.size;
+			s.size += s.align;
+		}
+		s.inuse = s.size;
+	}
+
+	s.order = calculate_order(s.size);
+
+	if (s.order < 0)
+		goto error;
+
+	s.name = name;
+	s.node = -1;
+
+	x = kmalloc(sizeof(struct slab_control), GFP_KERNEL);
+
+	if (!x)
+		return NULL;
+	s.page_alloc = a;
+	s.slab_alloc = &SLABULATOR_ALLOCATOR;
+#ifdef SLABULATOR_MERGE
+	/*
+	 * This works but is this really something we want?
+	 */
+	if (((s.size & (s.size - 1))==0) && !ctor && !dtor &&
+		   !(flags & (SLAB_DESTROY_BY_RCU|SLAB_RECLAIM_ACCOUNT))) {
+
+		printk(KERN_INFO "Merging slab_cache %s size %d into"
+			" kmalloc array\n", name, s.size);
+		rs = kmalloc_slab_allocator.create(x, &s);
+		kfree(x);
+		x = NULL;
+	} else
+#endif
+	rs = SLABULATOR_ALLOCATOR.create(x, &s);
+	if (!rs)
+		goto error;
+
+	/*
+	 * Now deal with constuctors and destructors. We need to know the
+	 * slab_cache address in order to be able to pass the slab_cache
+	 * address down the chain.
+	 */
+	if (ctor || dtor)
+		rs->page_alloc =
+			ctor_and_dtor_for_page_allocator(rs->page_alloc,
+				rs->size, rs,
+				(void *)ctor, (void *)dtor);
+
+	if (x)
+		register_slab(rs);
+	return rs;
+
+error:
+	a->destructor((struct page_allocator *)a);
+	if (flags & SLAB_PANIC)
+		panic("Cannot create slab %s size=%d realsize=%d "
+			"order=%d offset=%d flags=%lx\n",
+			s.name, size, s.size, s.order, s.offset, flags);
+
+
+	return NULL;
+}
+EXPORT_SYMBOL(kmem_cache_create);
+
+int kmem_cache_destroy(struct slab_cache *s)
+{
+	SLABULATOR_ALLOCATOR.destroy(s);
+	unregister_slab(s);
+	kfree(s);
+	return 0;
+}
+EXPORT_SYMBOL(kmem_cache_destroy);
+
+void *kmem_cache_zalloc(struct slab_cache *s, gfp_t flags)
+{
+	void *x;
+
+	x = kmem_cache_alloc(s, flags);
+	if (x)
+		memset(x, 0, s->objsize);
+	return x;
+}
+
+/*
+ * Generic reaper (the slabifier has its own way of reaping)
+ */
+#ifdef CONFIG_NUMA
+/*
+ * Special reaping functions for NUMA systems called from cache_reap().
+ */
+static DEFINE_PER_CPU(unsigned long, reap_node);
+
+static void init_reap_node(int cpu)
+{
+	int node;
+
+	node = next_node(cpu_to_node(cpu), node_online_map);
+	if (node == MAX_NUMNODES)
+		node = first_node(node_online_map);
+
+	__get_cpu_var(reap_node) = node;
+}
+
+static void next_reap_node(void)
+{
+	int node = __get_cpu_var(reap_node);
+
+	/*
+	 * Also drain per cpu pages on remote zones
+	 */
+	if (node != numa_node_id())
+		drain_node_pages(node);
+
+	node = next_node(node, node_online_map);
+	if (unlikely(node >= MAX_NUMNODES))
+		node = first_node(node_online_map);
+	__get_cpu_var(reap_node) = node;
+}
+#else
+#define init_reap_node(cpu) do { } while (0)
+#define next_reap_node(void) do { } while (0)
+#endif
+
+#define REAPTIMEOUT_CPUC	(2*HZ)
+
+#ifdef CONFIG_SMP
+static DEFINE_PER_CPU(struct work_struct, reap_work);
+
+static void cache_reap(void *unused)
+{
+	next_reap_node();
+	refresh_cpu_vm_stats(smp_processor_id());
+
+	schedule_delayed_work(&__get_cpu_var(reap_work),
+				      REAPTIMEOUT_CPUC);
+}
+
+static void __devinit start_cpu_timer(int cpu)
+{
+	struct work_struct *reap_work = &per_cpu(reap_work, cpu);
+
+	/*
+	 * When this gets called from do_initcalls via cpucache_init(),
+	 * init_workqueues() has already run, so keventd will be setup
+	 * at that time.
+	 */
+	if (keventd_up() && reap_work->func == NULL) {
+		init_reap_node(cpu);
+		INIT_WORK(reap_work, cache_reap, NULL);
+		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
+	}
+}
+
+static int __init cpucache_init(void)
+{
+	int cpu;
+
+	/*
+	 * Register the timers that drain pcp pages and update vm statistics
+	 */
+	for_each_online_cpu(cpu)
+		start_cpu_timer(cpu);
+	return 0;
+}
+__initcall(cpucache_init);
+#endif
+
+
Index: linux-2.6.18-rc5-mm1/include/linux/slabulator.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/include/linux/slabulator.h	2006-09-01 14:10:50.835913012 -0700
@@ -0,0 +1,123 @@
+#ifndef _LINUX_SLABULATOR_H
+#define _LINUX_SLABULATOR_H
+/*
+ * Slabulator: Emulate the existing Slab API.
+ *
+ * (C) 2006 Silicon Graphics, Inc.
+ *		Christoph Lameter <clameter@sgi.com>
+ */
+
+#include <linux/allocator.h>
+#include <linux/kmalloc.h>
+
+#define kmem_cache_t	struct slab_cache
+#define kmem_cache	slab_cache
+
+#ifndef SLABULATOR_ALLOCATOR
+#define SLABULATOR_ALLOCATOR slabifier_allocator
+#endif
+
+/*
+ * We really should be getting rid of these. This is only
+ * a select list/
+ */
+#define	SLAB_KERNEL		GFP_KERNEL
+#define	SLAB_ATOMIC		GFP_ATOMIC
+#define	SLAB_NOFS		GFP_NOFS
+#define SLAB_NOIO		GFP_NOIO
+
+/* No debug features for now */
+#define	SLAB_HWCACHE_ALIGN	0x00002000UL
+#define SLAB_CACHE_DMA		0x00004000UL
+#define SLAB_MUST_HWCACHE_ALIGN	0x00008000UL
+#define SLAB_RECLAIM_ACCOUNT	0x00020000UL
+#define SLAB_PANIC		0x00040000UL
+#define SLAB_DESTROY_BY_RCU	0x00080000UL
+#define SLAB_MEM_SPREAD		0x00100000UL
+
+/* flags passed to a constructor func */
+#define	SLAB_CTOR_CONSTRUCTOR	0x001UL
+#define SLAB_CTOR_ATOMIC	0x002UL
+#define	SLAB_CTOR_VERIFY	0x004UL
+
+/*
+ * slab_allocators are always available after the page allocator
+ * has been brought up. kmem_cache_init creates the kmalloc array:
+ */
+extern int slab_is_available(void);
+extern void kmem_cache_init(void);
+
+/* System wide caches (Should these be really here?) */
+extern struct slab_cache *vm_area_cachep;
+extern struct slab_cache *names_cachep;
+extern struct slab_cache *files_cachep;
+extern struct slab_cache *filp_cachep;
+extern struct slab_cache *fs_cachep;
+extern struct slab_cache *sighand_cachep;
+extern struct slab_cache *bio_cachep;
+
+extern struct slab_cache *kmem_cache_create(const char *name, size_t size,
+	size_t align, unsigned long flags,
+	void (*ctor)(void *, struct slab_cache *, unsigned long),
+	void (*dtor)(void *, struct slab_cache *, unsigned long));
+
+static inline unsigned int kmem_cache_size(struct slab_cache *s)
+{
+	return s->objsize;
+}
+
+static inline const char *kmem_cache_name(struct slab_cache *s)
+{
+	return s->name;
+}
+
+static inline void *kmem_cache_alloc(struct slab_cache *s, gfp_t flags)
+{
+	return SLABULATOR_ALLOCATOR.alloc(s, flags);
+}
+
+static inline void *kmem_cache_alloc_node(struct slab_cache *s,
+					gfp_t flags, int node)
+{
+	return SLABULATOR_ALLOCATOR.alloc_node(s, flags, node);
+}
+
+extern void *kmem_cache_zalloc(struct slab_cache *s, gfp_t flags);
+
+static inline void kmem_cache_free(struct slab_cache *s, const void *x)
+{
+	SLABULATOR_ALLOCATOR.free(s, x);
+}
+
+static inline int kmem_ptr_validate(struct slab_cache *s, void *x)
+{
+	return SLABULATOR_ALLOCATOR.valid_pointer(s, x);
+}
+
+extern int kmem_cache_destroy(struct slab_cache *s);
+
+static inline int kmem_cache_shrink(struct slab_cache *s)
+{
+	return SLABULATOR_ALLOCATOR.shrink(s, NULL);
+}
+
+/**
+ * kcalloc - allocate memory for an array. The memory is set to zero.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate.
+ */
+static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+{
+	if (n != 0 && size > ULONG_MAX / n)
+		return NULL;
+	return kzalloc(n * size, flags);
+}
+
+/* No current shrink statistics */
+struct shrinker;
+static inline void kmem_set_shrinker(kmem_cache_t *cachep,
+		struct shrinker *shrinker)
+{}
+#endif /* _LINUX_SLABULATOR_H */
+
Index: linux-2.6.18-rc5-mm1/mm/Makefile
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/Makefile	2006-09-01 14:10:50.744121805 -0700
+++ linux-2.6.18-rc5-mm1/mm/Makefile	2006-09-01 14:10:50.836889514 -0700
@@ -28,4 +28,5 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o slabstat.o kmalloc.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o slabstat.o \
+				kmalloc.o slabulator.o
Index: linux-2.6.18-rc5-mm1/init/Kconfig
===================================================================
--- linux-2.6.18-rc5-mm1.orig/init/Kconfig	2006-09-01 10:13:37.382549626 -0700
+++ linux-2.6.18-rc5-mm1/init/Kconfig	2006-09-01 14:10:50.837866016 -0700
@@ -332,6 +332,26 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+config SLAB
+	default y
+	bool "Traditional SLAB allocator"
+	help
+	  Disabling this allows the use of alternate slab allocators
+	  with less overhead such as SLOB (very simple) or the
+	  use the slabifier with the module allocator framework.
+	  Note that alternate slab allocators may not provide
+	  the complete functionality for slab.
+
+config MODULAR_SLAB
+	default y
+	bool "Use the modular allocator framework"
+	depends on EXPERIMENTAL && !SLAB
+	help
+	 The modular  allocator framework allows the flexible use
+	 of different slab allocators and page allocators for memory
+	 allocation. This will completely replace the existing
+	 slab allocator. Beware this is experimental code.
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
@@ -370,7 +390,6 @@ config KALLSYMS_EXTRA_PASS
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
-
 config HOTPLUG
 	bool "Support for hot-pluggable devices" if EMBEDDED
 	default y
@@ -445,15 +464,6 @@ config SHMEM
 	  option replaces shmem and tmpfs with the much simpler ramfs code,
 	  which may be appropriate on small systems without swap.
 
-config SLAB
-	default y
-	bool "Use full SLAB allocator" if EMBEDDED
-	help
-	  Disabling this replaces the advanced SLAB allocator and
-	  kmalloc support with the drastically simpler SLOB allocator.
-	  SLOB is more space efficient but does not scale well and is
-	  more susceptible to fragmentation.
-
 config VM_EVENT_COUNTERS
 	default y
 	bool "Enable VM event counters for /proc/vmstat" if EMBEDDED
@@ -475,7 +485,7 @@ config BASE_SMALL
 	default 1 if !BASE_FULL
 
 config SLOB
-	default !SLAB
+	default !SLAB && !MODULAR_SLAB
 	bool
 
 menu "Loadable module support"
Index: linux-2.6.18-rc5-mm1/include/linux/slab.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/linux/slab.h	2006-09-01 10:13:36.505650544 -0700
+++ linux-2.6.18-rc5-mm1/include/linux/slab.h	2006-09-01 14:10:50.837866016 -0700
@@ -9,6 +9,10 @@
 
 #if	defined(__KERNEL__)
 
+#ifdef CONFIG_MODULAR_SLAB
+#include <linux/slabulator.h>
+#else
+
 typedef struct kmem_cache kmem_cache_t;
 
 #include	<linux/gfp.h>
@@ -291,6 +295,8 @@ extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*sighand_cachep;
 extern kmem_cache_t	*bio_cachep;
 
+#endif /* CONFIG_SLABULATOR */
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */

-- 
VGER BF report: H 0.125728
