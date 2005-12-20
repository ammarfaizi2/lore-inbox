Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVLTUPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVLTUPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVLTUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:15:52 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:25286 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVLTUPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:15:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=saAiKzsbaTAG5fT2I1jbFFpTdEVxgsChJBXxmD8HFJHRVDAf7upttlD9stIM/naDf1Kx0YBI+leCA0vIPk4Lz7siHgvaNvJ/PlEmSJzKoo/jFyurHA00qwx++WFeI+9o72V+nr/VvPD3/qyY0ut/J7Syl1nt2xSw2ERejFg0jjA=
Message-ID: <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
Date: Tue, 20 Dec 2005 22:15:47 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 00/02] SLOB optimizations
Cc: Matt Mackall <mpm@selenic.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1135106124.13138.339.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14378_33440897.1135109747843"
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220181921.GF3356@waste.org>
	 <1135106124.13138.339.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14378_33440897.1135109747843
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Steve and Matt,

On 12/20/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> That looks like quite an undertaking, but may be well worth it.  I think
> Linux's memory management is starting to show it's age.  It's been
> through a few transformations, and maybe it's time to go through
> another.  The work being done by the NUMA folks, should be taking into
> account, and maybe we can come up with a way that can make things easier
> and less complex without losing performance.

The slab allocator is indeed complex, messy, and hard to understand.
In case you're interested, I have included a replacement I started out
a while a go. It follows the design of a magazine allocator described
by Bonwick. It's not a complete replacement but should boot (well, did
anyway at some point). I have also included a user space test harness
I am using to smoke it.

If there's enough interest, I would be more than glad to help write a
replacement for mm/slab.c :-)

                                        Pekka

------=_Part_14378_33440897.1135109747843
Content-Type: text/x-patch; name=magazine-slab.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="magazine-slab.patch"

Index: 2.6/mm/kmalloc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/mm/kmalloc.c
@@ -0,0 +1,170 @@
+/*
+ * mm/kmalloc.c - A general purpose memory allocator.
+ *
+ * Copyright (C) 1996, 1997 Mark Hemment
+ * Copyright (C) 1999 Andrea Arcangeli
+ * Copyright (C) 2000, 2002 Manfred Spraul
+ * Copyright (C) 2005 Shai Fultheim
+ * Copyright (C) 2005 Shobhit Dayal
+ * Copyright (C) 2005 Alok N Kataria
+ * Copyright (C) 2005 Christoph Lameter
+ * Copyright (C) 2005 Pekka Enberg
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kmem.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+struct cache_sizes malloc_sizes[] =3D {
+#define CACHE(x) { .cs_size =3D (x) },
+#include <linux/kmalloc_sizes.h>
+=09{ .cs_size =3D ULONG_MAX }
+#undef CACHE
+};
+EXPORT_SYMBOL(malloc_sizes);
+
+struct cache_names {
+=09char *name;
+=09char *name_dma;
+};
+
+static struct cache_names cache_names[] =3D {
+#define CACHE(x) { .name =3D "size-" #x, .name_dma =3D "size-" #x "(DMA" }=
,
+#include <linux/kmalloc_sizes.h>
+=09{ NULL, }
+#undef CACHE
+};
+
+void kmalloc_init(void)
+{
+=09struct cache_sizes *sizes =3D malloc_sizes;
+=09struct cache_names *names =3D cache_names;
+
+=09while (sizes->cs_size !=3D ULONG_MAX) {
+=09=09sizes->cs_cache =3D kmem_cache_create(names->name,
+=09=09=09=09=09=09    sizes->cs_size, 0, 0,
+=09=09=09=09=09=09    NULL, NULL);
+=09=09sizes->cs_dma_cache =3D kmem_cache_create(names->name_dma,
+=09=09=09=09=09=09=09sizes->cs_size, 0, 0,
+=09=09=09=09=09=09=09NULL, NULL);
+=09=09sizes++;
+=09=09names++;
+=09}
+}
+
+static struct kmem_cache *find_general_cache(size_t size, gfp_t flags)
+{
+=09struct cache_sizes *sizes =3D malloc_sizes;
+
+=09while (size > sizes->cs_size)
+=09=09sizes++;
+
+=09if (unlikely(flags & GFP_DMA))
+=09=09return sizes->cs_dma_cache;
+=09return sizes->cs_cache;
+}
+
+/**
+ * kmalloc - allocate memory
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ *
+ * kmalloc is the normal method of allocating memory
+ * in the kernel.
+ *
+ * The @flags argument may be one of:
+ *
+ * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
+ * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
+ * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers=
.
+ *
+ * Additionally, the %GFP_DMA flag may be set to indicate the memory
+ * must be suitable for DMA.  This can mean different things on different
+ * platforms.  For example, on i386, it means that the memory must come
+ * from the first 16MB.
+ */
+void *__kmalloc(size_t size, gfp_t flags)
+{
+=09struct kmem_cache *cache =3D find_general_cache(size, flags);
+=09if (unlikely(cache =3D=3D NULL))
+=09=09return NULL;
+=09return kmem_cache_alloc(cache, flags);
+}
+EXPORT_SYMBOL(__kmalloc);
+
+void *kmalloc_node(size_t size, unsigned int __nocast flags, int node)
+{
+=09return __kmalloc(size, flags);
+}
+EXPORT_SYMBOL(kmalloc_node);
+
+/**
+ * kzalloc - allocate memory. The memory is set to zero.
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ */
+void *kzalloc(size_t size, gfp_t flags)
+{
+        void *ret =3D kmalloc(size, flags);
+        if (ret)
+                memset(ret, 0, size);
+        return ret;
+}
+EXPORT_SYMBOL(kzalloc);
+
+/*
+ * kstrdup - allocate space for and copy an existing string
+ *
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kstrdup(const char *s, gfp_t gfp)
+{
+=09size_t len;
+=09char *buf;
+
+=09if (!s)
+=09=09return NULL;
+
+=09len =3D strlen(s) + 1;
+=09buf =3D kmalloc(len, gfp);
+=09if (buf)
+=09=09memcpy(buf, s, len);
+=09return buf;
+}
+EXPORT_SYMBOL(kstrdup);
+
+// F=CCXME: duplicate!
+static struct kmem_cache *page_get_cache(struct page *page)
+{
+=09return (struct kmem_cache *)page->lru.next;
+}
+
+/**
+ * kfree - free previously allocated memory
+ * @objp: pointer returned by kmalloc.
+ *
+ * If @objp is NULL, no operation is performed.
+ *
+ * Don't free memory not originally allocated by kmalloc()
+ * or you will run into trouble.
+ */
+void kfree(const void *obj)
+{
+=09struct page *page;
+=09struct kmem_cache *cache;
+
+=09if (unlikely(!obj))
+=09=09return;
+
+=09page =3D virt_to_page(obj);
+=09cache =3D page_get_cache(page);
+=09kmem_cache_free(cache, (void *)obj);
+}
+EXPORT_SYMBOL(kfree);
Index: 2.6/mm/kmem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/mm/kmem.c
@@ -0,0 +1,1203 @@
+/*
+ * mm/kmem.c - An object-caching memory allocator.
+ *
+ * Copyright (C) 1996, 1997 Mark Hemment
+ * Copyright (C) 1999 Andrea Arcangeli
+ * Copyright (C) 2000, 2002 Manfred Spraul
+ * Copyright (C) 2005 Shai Fultheim
+ * Copyright (C) 2005 Shobhit Dayal
+ * Copyright (C) 2005 Alok N Kataria
+ * Copyright (C) 2005 Christoph Lameter
+ * Copyright (C) 2005 Pekka Enberg
+ *
+ * This file is released under the GPLv2.
+ *
+ * The design of this allocator is based on the following papers:
+ *
+ * Jeff Bonwick.  The Slab Allocator: An Object-Caching Kernel Memory
+ * =09Allocator. 1994.
+ *
+ * Jeff Bonwick, Jonathan Adams.  Magazines and Vmem: Extending the Slab
+ * =09Allocator to Many CPUs and Arbitrary Resources. 2001.
+ *
+ * TODO:
+ *
+ *   - Shrinking
+ *   - Alignment
+ *   - Coloring
+ *   - Per node slab lists and depots
+ *   - Compatible procfs
+ *   - Red zoning
+ *   - Poisoning
+ *   - Use after free
+ *   - Adaptive magazine size?
+ *   - Batching for freeing of wrong-node objects?
+ *   - Lock-less magazines?
+ *   - Disable magazine layer for UP?
+ *   - sysfs?
+ */
+
+#include <linux/kmem.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+#include <linux/percpu.h>
+#include <linux/workqueue.h>
+
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+
+/* Guard access to the cache-chain. */
+static struct semaphore=09cache_chain_sem;
+static struct list_head cache_chain;
+
+atomic_t slab_reclaim_pages;
+
+static DEFINE_PER_CPU(struct work_struct, reap_work);
+
+#define REAP_TIMEOUT_CPU_CACHES (2*HZ)
+
+
+/*
+ *=09Internal Caches
+ */
+
+static void kmem_cache_ctor(void *, struct kmem_cache *, unsigned long);
+static void kmem_magazine_ctor(void *, struct kmem_cache *, unsigned long)=
;
+
+static struct kmem_cache cache_cache =3D {
+=09.name =3D "cache-cache",
+=09.objsize =3D sizeof(struct kmem_cache),
+=09.ctor =3D kmem_cache_ctor
+};
+
+static struct kmem_cache slab_cache =3D {
+=09.name =3D "slab-cache",
+=09.objsize =3D sizeof(struct kmem_slab)
+};
+
+static struct kmem_cache magazine_cache =3D {
+=09.name =3D "magazine-cache",
+=09.objsize =3D sizeof(struct kmem_magazine),
+=09.ctor =3D kmem_magazine_ctor
+};
+
+
+/*
+ *=09The following functions are used to find the cache and slab an object
+ *=09belongs to. They are used when we want to free an object.
+ */
+
+static void page_set_cache(struct page *page, struct kmem_cache *cache)
+{
+=09page->lru.next =3D (struct list_head *)cache;
+}
+
+static struct kmem_cache *page_get_cache(struct page *page)
+{
+=09return (struct kmem_cache *)page->lru.next;
+}
+
+static void page_set_slab(struct page *page, struct kmem_slab *slab)
+{
+=09page->lru.prev =3D (struct list_head *)slab;
+}
+
+static struct kmem_slab *page_get_slab(struct page *page)
+{
+=09return (struct kmem_slab *)page->lru.prev;
+}
+
+
+/*
+ *=09Cache Statistics
+ */
+
+static inline void stats_inc_grown(struct kmem_cache *cache)
+{
+=09cache->stats.grown++;
+}
+
+static inline void stats_inc_reaped(struct kmem_cache *cache)
+{
+=09cache->stats.reaped++;
+}
+
+
+/*
+ *=09Magazines, CPU Caches, and Depots
+ */
+
+static void init_magazine(struct kmem_magazine *mag)
+{
+=09memset(mag, 0, sizeof(*mag));
+=09INIT_LIST_HEAD(&mag->list);
+}
+
+static void kmem_magazine_ctor(void *obj, struct kmem_cache *cache,
+=09=09=09       unsigned long flags)
+{
+=09struct kmem_magazine *mag =3D obj;
+=09if (cache !=3D &magazine_cache)
+=09=09BUG();
+=09init_magazine(mag);
+}
+
+static int magazine_is_empty(struct kmem_magazine *mag)
+{
+=09return mag->rounds =3D=3D 0;
+}
+
+static int magazine_is_full(struct kmem_magazine *mag)
+{
+=09return mag->rounds =3D=3D MAX_ROUNDS;
+}
+
+static void *magazine_get(struct kmem_magazine *mag)
+{
+=09BUG_ON(magazine_is_empty(mag));
+=09return mag->objs[--mag->rounds];
+}
+
+static void magazine_put(struct kmem_magazine *mag, void *obj)
+{
+=09BUG_ON(magazine_is_full(mag));
+=09mag->objs[mag->rounds++] =3D obj;
+}
+
+static struct kmem_cpu_cache *__cpu_cache_get(struct kmem_cache *cache,
+=09=09=09=09=09      unsigned long cpu)
+{
+=09return &cache->cpu_cache[cpu];
+}
+
+static struct kmem_cpu_cache *cpu_cache_get(struct kmem_cache *cache)
+{
+=09return __cpu_cache_get(cache, smp_processor_id());
+}
+
+static void depot_put_full(struct kmem_cache *cache,
+=09=09=09   struct kmem_magazine *magazine)
+{
+=09BUG_ON(!magazine_is_full(magazine));
+=09list_add(&magazine->list, &cache->full_magazines);
+}
+
+static struct kmem_magazine *depot_get_full(struct kmem_cache *cache)
+{
+=09struct kmem_magazine *ret =3D list_entry(cache->full_magazines.next,
+=09=09=09=09=09       struct kmem_magazine, list);
+=09list_del(&ret->list);
+=09BUG_ON(!magazine_is_full(ret));
+=09return ret;
+}
+
+static void depot_put_empty(struct kmem_cache *cache,
+=09=09=09    struct kmem_magazine *magazine)
+{
+=09BUG_ON(!magazine_is_empty(magazine));
+=09list_add(&magazine->list, &cache->empty_magazines);
+}
+
+static struct kmem_magazine *depot_get_empty(struct kmem_cache *cache)
+{
+=09struct kmem_magazine *ret =3D list_entry(cache->empty_magazines.next,
+=09=09=09=09=09       struct kmem_magazine, list);
+=09list_del(&ret->list);
+=09BUG_ON(!magazine_is_empty(ret));
+=09return ret;
+}
+
+
+/*
+ *=09Object Caches and Slabs
+ */
+
+const char *kmem_cache_name(struct kmem_cache *cache)
+{
+=09return cache->name;
+}
+EXPORT_SYMBOL_GPL(kmem_cache_name);
+
+static inline struct kmem_bufctl *obj_to_bufctl(struct kmem_cache *cache,
+=09=09=09=09=09=09struct kmem_slab *slab,
+=09=09=09=09=09=09void *ptr)
+{
+=09return ptr + (cache->objsize) - sizeof(struct kmem_bufctl);
+}
+
+static void init_cache(struct kmem_cache *cache)
+{
+=09spin_lock_init(&cache->lists_lock);
+=09INIT_LIST_HEAD(&cache->full_slabs);
+=09INIT_LIST_HEAD(&cache->partial_slabs);
+=09INIT_LIST_HEAD(&cache->empty_slabs);
+=09INIT_LIST_HEAD(&cache->full_magazines);
+=09INIT_LIST_HEAD(&cache->empty_magazines);
+}
+
+static void kmem_cache_ctor(void *obj, struct kmem_cache *cache,
+=09=09=09    unsigned long flags)
+{
+=09struct kmem_cache *cachep =3D obj;
+=09if (cache !=3D &cache_cache)
+=09=09BUG();
+=09init_cache(cachep);
+}
+
+#define MAX_WASTAGE (PAGE_SIZE/8)
+
+static inline int mgmt_in_slab(struct kmem_cache *cache)
+{
+=09return cache->objsize < MAX_WASTAGE;
+}
+
+static inline size_t order_to_size(unsigned int order)
+{
+=09return (1UL << order) * PAGE_SIZE;
+}
+
+static inline size_t slab_size(struct kmem_cache *cache)
+{
+=09return order_to_size(cache->cache_order);
+}
+
+static inline unsigned int slab_capacity(struct kmem_cache *cache)
+{
+=09unsigned long mgmt_size =3D 0;
+=09if (mgmt_in_slab(cache))
+=09=09mgmt_size =3D sizeof(struct kmem_slab);
+
+=09return (slab_size(cache) - mgmt_size) / cache->objsize;
+}
+
+static void *obj_at(struct kmem_cache *cache, struct kmem_slab *slab,
+=09=09    unsigned long idx)
+{
+=09return slab->mem + idx * cache->objsize;
+}
+
+static void init_slab_bufctl(struct kmem_cache *cache, struct kmem_slab *s=
lab)
+{
+=09unsigned long i;
+=09struct kmem_bufctl *bufctl;
+=09void *obj;
+
+=09for (i =3D 0; i < cache->slab_capacity-1; i++) {
+=09=09obj =3D obj_at(cache, slab, i);
+=09=09bufctl =3D obj_to_bufctl(cache, slab, obj);
+=09=09bufctl->addr =3D obj;
+=09=09bufctl->next =3D obj_to_bufctl(cache, slab, obj+cache->objsize);
+=09}
+=09obj =3D obj_at(cache, slab, cache->slab_capacity-1);
+=09bufctl =3D obj_to_bufctl(cache, slab, obj);
+=09bufctl->addr =3D obj;
+=09bufctl->next =3D NULL;
+
+=09slab->free =3D obj_to_bufctl(cache, slab, slab->mem);
+}
+
+static struct kmem_slab *create_slab(struct kmem_cache *cache, gfp_t gfp_f=
lags)
+{
+=09struct page *page;
+=09void *addr;
+=09struct kmem_slab *slab;
+=09int nr_pages;
+
+=09page =3D alloc_pages(cache->gfp_flags, cache->cache_order);
+=09if (!page)
+=09=09return NULL;
+
+=09addr =3D page_address(page);
+
+=09if (mgmt_in_slab(cache))
+=09=09slab =3D addr + slab_size(cache) - sizeof(*slab);
+=09else {
+=09=09slab =3D kmem_cache_alloc(&slab_cache, gfp_flags);
+=09=09if (!slab)
+=09=09=09goto failed;
+=09}
+
+=09INIT_LIST_HEAD(&slab->list);
+=09slab->nr_available =3D cache->slab_capacity;
+=09slab->mem =3D addr;
+=09init_slab_bufctl(cache, slab);
+
+=09nr_pages =3D 1 << cache->cache_order;
+=09add_page_state(nr_slab, nr_pages);
+
+=09while (nr_pages--) {
+=09=09SetPageSlab(page);
+=09=09page_set_cache(page, cache);
+=09=09page_set_slab(page, slab);
+=09=09page++;
+=09}
+
+=09cache->free_objects +=3D cache->slab_capacity;
+
+=09return slab;
+
+  failed:
+=09free_pages((unsigned long)addr, cache->cache_order);
+=09return NULL;
+}
+
+static void construct_object(void *obj, struct kmem_cache *cache,
+=09=09=09     gfp_t gfp_flags)
+{
+=09unsigned long ctor_flags =3D SLAB_CTOR_CONSTRUCTOR;
+
+=09if (!cache->ctor)
+=09=09return;
+
+=09if (!(gfp_flags & __GFP_WAIT))
+=09=09ctor_flags |=3D SLAB_CTOR_ATOMIC;
+
+=09cache->ctor(obj, cache, ctor_flags);
+}
+
+static inline void destruct_object(void *obj, struct kmem_cache *cache)
+{
+=09if (unlikely(cache->dtor))
+=09=09cache->dtor(obj, cache, 0);
+}
+
+static void destroy_slab(struct kmem_cache *cache, struct kmem_slab *slab)
+{
+=09unsigned long addr =3D (unsigned long)slab->mem;
+=09struct page *page =3D virt_to_page(addr);
+=09unsigned long nr_pages;
+
+=09BUG_ON(slab->nr_available !=3D cache->slab_capacity);
+
+=09if (!mgmt_in_slab(cache))
+=09=09kmem_cache_free(&slab_cache, slab);
+
+=09nr_pages =3D 1 << cache->cache_order;
+
+=09sub_page_state(nr_slab, nr_pages);
+
+=09while (nr_pages--) {
+=09=09if (!TestClearPageSlab(page))
+=09=09=09BUG();
+=09=09page++;
+=09}
+=09free_pages(addr, cache->cache_order);
+=09cache->free_objects -=3D cache->slab_capacity;
+
+=09stats_inc_reaped(cache);
+}
+
+static struct kmem_slab *expand_cache(struct kmem_cache *cache, gfp_t gfp_=
flags)
+{
+=09struct kmem_slab *slab =3D create_slab(cache, gfp_flags);
+=09if (!slab)
+=09=09return NULL;
+
+=09list_add_tail(&slab->list, &cache->full_slabs);
+=09stats_inc_grown(cache);
+
+=09return slab;
+}
+
+static struct kmem_slab *find_slab(struct kmem_cache *cache)
+{
+=09struct kmem_slab *slab;
+=09struct list_head *list =3D NULL;
+=09
+=09if (!list_empty(&cache->partial_slabs))
+=09=09list =3D &cache->partial_slabs;
+=09else if (!list_empty(&cache->full_slabs))
+=09=09list =3D &cache->full_slabs;
+=09else
+=09=09BUG();
+
+=09slab =3D list_entry(list->next, struct kmem_slab, list);
+=09BUG_ON(!slab->nr_available);
+=09return slab;
+}
+
+static void *alloc_obj(struct kmem_cache *cache, struct kmem_slab *slab)
+{
+=09void *obj =3D slab->free->addr;
+=09slab->free =3D slab->free->next;
+=09slab->nr_available--;
+=09cache->free_objects--;
+=09return obj;
+}
+
+/* The caller must hold cache->lists_lock.  */
+static void *slab_alloc(struct kmem_cache *cache, gfp_t gfp_flags)
+{
+=09struct kmem_slab *slab;
+=09void *ret;
+
+=09if (list_empty(&cache->partial_slabs) &&
+=09    list_empty(&cache->full_slabs) &&
+=09    !expand_cache(cache, gfp_flags))
+=09=09return NULL;
+
+=09slab =3D find_slab(cache);
+=09if (slab->nr_available =3D=3D cache->slab_capacity)
+=09=09list_move(&slab->list, &cache->partial_slabs);
+
+=09ret =3D alloc_obj(cache, slab);
+=09if (!slab->nr_available)
+=09=09list_move(&slab->list, &cache->empty_slabs);
+
+=09return ret;
+}
+
+static void swap_magazines(struct kmem_cpu_cache *cpu_cache)
+{
+=09struct kmem_magazine *tmp =3D cpu_cache->loaded;
+=09cpu_cache->loaded =3D cpu_cache->prev;
+=09cpu_cache->prev =3D tmp;
+}
+
+/**
+ * kmem_ptr_validate - check if an untrusted pointer might
+ *=09be a slab entry.
+ * @cachep: the cache we're checking against
+ * @ptr: pointer to validate
+ *
+ * This verifies that the untrusted pointer looks sane: it is _not_ a
+ * guarantee that the pointer is actually part of the slab cache in
+ * question, but it at least validates that the pointer can be
+ * dereferenced and looks half-way sane.
+ *
+ * Currently only used for dentry validation.
+ */
+int fastcall kmem_ptr_validate(struct kmem_cache *cache, void *ptr)
+{
+=09unsigned long addr =3D (unsigned long) ptr;
+=09unsigned long min_addr =3D PAGE_OFFSET;
+=09unsigned long size =3D cache->objsize;
+=09struct page *page;
+
+=09if (unlikely(addr < min_addr))
+=09=09goto out;
+=09if (unlikely(addr > (unsigned long)high_memory - size))
+=09=09goto out;
+=09if (unlikely(!kern_addr_valid(addr)))
+=09=09goto out;
+=09if (unlikely(!kern_addr_valid(addr + size - 1)))
+=09=09goto out;
+=09page =3D virt_to_page(ptr);
+=09if (unlikely(!PageSlab(page)))
+=09=09goto out;
+=09if (unlikely(page_get_cache(page) !=3D cache))
+=09=09goto out;
+=09return 1;
+  out:
+=09return 0;
+}
+
+/**
+ * kmem_cache_alloc - Allocate an object
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ *
+ * This function can be called from interrupt and process contexts.
+ *
+ * Allocate an object from this cache.  The flags are only relevant
+ * if the cache has no available objects.
+ */
+void *kmem_cache_alloc(struct kmem_cache *cache, gfp_t gfp_flags)
+{
+=09void *ret =3D NULL;
+=09unsigned long flags;
+=09struct kmem_cpu_cache *cpu_cache =3D cpu_cache_get(cache);
+
+=09spin_lock_irqsave(&cpu_cache->lock, flags);
+
+=09while (1) {
+=09=09if (likely(!magazine_is_empty(cpu_cache->loaded))) {
+=09=09=09ret =3D magazine_get(cpu_cache->loaded);
+=09=09=09break;
+=09=09} else if (magazine_is_full(cpu_cache->prev)) {
+=09=09=09swap_magazines(cpu_cache);
+=09=09=09continue;
+=09=09}
+
+=09=09spin_lock(&cache->lists_lock);
+
+=09=09if (list_empty(&cache->full_magazines)) {
+=09=09=09ret =3D slab_alloc(cache, gfp_flags);
+=09=09=09spin_unlock(&cache->lists_lock);
+=09=09=09if (ret)
+=09=09=09=09construct_object(ret, cache, gfp_flags);
+=09=09=09break;
+=09=09}
+=09=09depot_put_empty(cache, cpu_cache->prev);
+=09=09cpu_cache->prev =3D cpu_cache->loaded;
+=09=09cpu_cache->loaded =3D depot_get_full(cache);
+
+=09=09spin_unlock(&cache->lists_lock);
+=09}
+
+=09spin_unlock_irqrestore(&cpu_cache->lock, flags);
+=09return ret;
+}
+EXPORT_SYMBOL(kmem_cache_alloc);
+
+void *kmem_cache_alloc_node(struct kmem_cache *cache, unsigned int __nocas=
t flags, int nodeid)
+{
+=09return kmem_cache_alloc(cache, flags);
+}
+EXPORT_SYMBOL(kmem_cache_alloc_node);
+
+static void free_obj(struct kmem_cache *cache, struct kmem_slab *slab,
+=09=09     void *obj)
+{
+=09struct kmem_bufctl *bufctl;
+
+=09bufctl =3D obj_to_bufctl(cache, slab, obj);
+=09bufctl->next =3D slab->free;
+=09bufctl->addr =3D obj;
+
+=09slab->free =3D bufctl;
+=09slab->nr_available++;
+=09cache->free_objects++;
+}
+
+static void slab_free(struct kmem_cache *cache, void *obj)
+{
+=09struct page *page =3D virt_to_page(obj);
+=09struct kmem_slab *slab =3D page_get_slab(page);
+
+=09if (page_get_cache(page) !=3D cache)
+=09=09BUG();
+
+=09if (slab->nr_available =3D=3D 0)
+=09=09list_move(&slab->list, &cache->partial_slabs);
+
+=09free_obj(cache, slab, obj);
+
+=09if (slab->nr_available =3D=3D cache->slab_capacity)
+=09=09list_move(&slab->list, &cache->full_slabs);
+}
+
+/**
+ * kmem_cache_free - Deallocate an object
+ * @cachep: The cache the allocation was from.
+ * @objp: The previously allocated object.
+ *
+ * This function can be called from interrupt and process contexts.
+ *
+ * Free an object which was previously allocated from this
+ * cache.
+ */
+void kmem_cache_free(struct kmem_cache *cache, void *obj)
+{
+=09unsigned long flags;
+=09struct kmem_cpu_cache *cpu_cache =3D cpu_cache_get(cache);
+
+=09if (!obj)
+=09=09return;
+
+=09spin_lock_irqsave(&cpu_cache->lock, flags);
+
+=09while (1) {
+=09=09if (!magazine_is_full(cpu_cache->loaded)) {
+=09=09=09magazine_put(cpu_cache->loaded, obj);
+=09=09=09break;
+=09=09}
+
+=09=09if (magazine_is_empty(cpu_cache->prev)) {
+=09=09=09swap_magazines(cpu_cache);
+=09=09=09continue;
+=09=09}
+=09
+=09=09spin_lock(&cache->lists_lock);
+=09=09if (unlikely(list_empty(&cache->empty_magazines))) {
+=09=09=09struct kmem_magazine *magazine;
+
+=09=09=09spin_unlock(&cache->lists_lock);
+=09=09=09magazine =3D kmem_cache_alloc(&magazine_cache,
+=09=09=09=09=09=09    GFP_KERNEL);
+=09=09=09if (magazine) {
+=09=09=09=09depot_put_empty(cache, magazine);
+=09=09=09=09continue;
+=09=09=09}
+=09=09=09destruct_object(obj, cache);
+=09=09=09spin_lock(&cache->lists_lock);
+=09=09=09slab_free(cache, obj);
+=09=09=09spin_unlock(&cache->lists_lock);
+=09=09=09break;
+=09=09}
+=09=09depot_put_full(cache, cpu_cache->prev);
+=09=09cpu_cache->prev =3D cpu_cache->loaded;
+=09=09cpu_cache->loaded =3D depot_get_empty(cache);
+=09=09spin_unlock(&cache->lists_lock);
+=09}
+
+=09spin_unlock_irqrestore(&cpu_cache->lock, flags);
+}
+
+EXPORT_SYMBOL(kmem_cache_free);
+
+static void free_slab_list(struct kmem_cache *cache, struct list_head *sla=
b_list)
+{
+=09struct kmem_slab *slab, *tmp;
+
+=09list_for_each_entry_safe(slab, tmp, slab_list, list) {
+=09=09list_del(&slab->list);
+=09=09destroy_slab(cache, slab);
+=09}
+}
+
+static void free_cache_slabs(struct kmem_cache *cache)
+{
+=09free_slab_list(cache, &cache->full_slabs);
+=09free_slab_list(cache, &cache->partial_slabs);
+=09free_slab_list(cache, &cache->empty_slabs);
+}
+
+static void purge_magazine(struct kmem_cache *cache,
+=09=09=09   struct kmem_magazine *mag)
+{
+=09while (!magazine_is_empty(mag)) {
+=09=09void *obj =3D magazine_get(mag);
+=09=09destruct_object(obj, cache);
+=09=09spin_lock(&cache->lists_lock);
+=09=09slab_free(cache, obj);
+=09=09spin_unlock(&cache->lists_lock);
+=09}
+}
+
+static void destroy_magazine(struct kmem_cache *cache,
+=09=09=09     struct kmem_magazine *mag)
+{
+=09if (!mag)
+=09=09return;
+
+=09purge_magazine(cache, mag);
+=09kmem_cache_free(&magazine_cache, mag);
+}
+
+static void free_cpu_caches(struct kmem_cache *cache)
+{
+=09int i;
+
+=09for (i =3D 0; i < NR_CPUS; i++) {
+=09=09struct kmem_cpu_cache *cpu_cache =3D __cpu_cache_get(cache, i);
+=09=09destroy_magazine(cache, cpu_cache->loaded);
+=09=09destroy_magazine(cache, cpu_cache->prev);
+=09}
+}
+
+static int init_cpu_cache(struct kmem_cpu_cache *cpu_cache)
+{
+=09int err =3D 0;
+
+=09spin_lock_init(&cpu_cache->lock);
+
+=09cpu_cache->loaded =3D kmem_cache_alloc(&magazine_cache, GFP_KERNEL);
+=09if (!cpu_cache->loaded)
+=09=09goto failed;
+
+=09cpu_cache->prev =3D kmem_cache_alloc(&magazine_cache, GFP_KERNEL);
+=09if (!cpu_cache->prev)
+=09=09goto failed;
+
+  out:
+=09return err;
+
+  failed:
+=09kmem_cache_free(&magazine_cache, cpu_cache->loaded);
+=09err =3D -ENOMEM;
+=09goto out;
+}
+
+static int init_cpu_caches(struct kmem_cache *cache)
+{
+=09int i;
+=09int ret =3D 0;
+
+=09for (i =3D 0; i < NR_CPUS; i++) {
+=09=09struct kmem_cpu_cache *cpu_cache =3D __cpu_cache_get(cache, i);
+=09=09ret =3D init_cpu_cache(cpu_cache);
+=09=09if (ret)
+=09=09=09break;
+=09}
+
+=09if (ret)
+=09=09free_cpu_caches(cache);
+
+=09return ret;
+}
+
+static unsigned long wastage(struct kmem_cache *cache, unsigned long order=
)
+{
+=09unsigned long size =3D order_to_size(order);
+=09return size % cache->objsize;
+}
+
+static long cache_order(struct kmem_cache *cache)
+{
+=09unsigned int prev, order;
+
+=09prev =3D order =3D 0;
+
+=09/*
+=09 * First find the first order in which the objects fit.
+=09 */=20
+=09while (1) {
+=09=09if (cache->objsize <=3D order_to_size(order))
+=09=09=09break;
+=09=09if (++order > MAX_ORDER) {
+=09=09=09order =3D -1;
+=09=09=09goto out;
+=09=09}
+=09}
+
+=09/*
+=09 * Then see if we can find a better one.
+=09 */
+=09while (order < MAX_ORDER-1) {
+=09=09unsigned long prev_wastage, current_wastage;
+
+=09=09prev =3D order;
+=09=09prev_wastage =3D wastage(cache, prev);
+=09=09current_wastage =3D wastage(cache, ++order);
+
+=09=09if (prev_wastage < current_wastage ||
+=09=09    prev_wastage-current_wastage < MAX_WASTAGE) {
+=09=09=09order =3D prev;
+=09=09=09break;
+=09=09}
+=09}
+
+  out:
+=09return order;
+}
+
+/**
+ * kmem_cache_create - Create a cache.
+ * @name: A string which is used in /proc/slabinfo to identify this cache.
+ * @size: The size of objects to be created in this cache.
+ * @align: The required alignment for the objects.
+ * @flags: SLAB flags
+ * @ctor: A constructor for the objects.
+ * @dtor: A destructor for the objects.
+ *
+ * This function must not be called from interrupt context.
+ *
+ * Returns a ptr to the cache on success, NULL on failure.  Cannot be
+ * called within a int, but can be interrupted.  The @ctor is run when
+ * new pages are allocated by the cache and the @dtor is run before
+ * the pages are handed back.
+ *
+ * @name must be valid until the cache is destroyed. This implies that
+ * the module calling this has to destroy the cache before getting
+ * unloaded.
+ *
+ * The flags are
+ *
+ * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
+ * to catch references to uninitialised memory.
+ *
+ * %SLAB_RED_ZONE - Insert `Red' zones around the allocated memory to
+ * check for buffer overruns.
+ *
+ * %SLAB_NO_REAP - Don't automatically reap this cache when we're
+ * under memory pressure.
+ *
+ * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
+ * cacheline.  This can be beneficial if you're counting cycles as
+ * closely as davem.
+ */
+struct kmem_cache *kmem_cache_create(const char *name, size_t objsize,
+=09=09=09=09     size_t align, unsigned long flags,
+=09=09=09=09     kmem_ctor_fn ctor, kmem_dtor_fn dtor)
+{
+=09struct kmem_cache *cache =3D kmem_cache_alloc(&cache_cache, GFP_KERNEL)=
;
+=09if (!cache)
+=09=09return NULL;
+
+=09cache->name =3D name;
+=09cache->objsize =3D objsize;
+=09cache->ctor =3D ctor;
+=09cache->dtor =3D dtor;
+=09cache->free_objects =3D 0;
+
+=09cache->cache_order =3D cache_order(cache);
+=09if (cache->cache_order < 0)
+=09=09goto failed;
+
+=09cache->slab_capacity =3D slab_capacity(cache);
+
+=09memset(&cache->stats, 0, sizeof(struct kmem_cache_statistics));
+
+=09if (init_cpu_caches(cache))
+=09=09goto failed;
+
+=09down(&cache_chain_sem);
+=09list_add(&cache->next, &cache_chain);
+=09up(&cache_chain_sem);
+
+=09return cache;
+
+  failed:
+=09kmem_cache_free(&cache_cache, cache);
+=09return NULL;
+}
+
+EXPORT_SYMBOL(kmem_cache_create);
+
+static void free_depot_magazines(struct kmem_cache *cache)
+{
+=09struct kmem_magazine *magazine, *tmp;
+
+=09list_for_each_entry_safe(magazine, tmp, &cache->empty_magazines, list) =
{
+=09=09list_del(&magazine->list);
+=09=09destroy_magazine(cache, magazine);
+=09}
+
+=09list_for_each_entry_safe(magazine, tmp, &cache->full_magazines, list) {
+=09=09list_del(&magazine->list);
+=09=09destroy_magazine(cache, magazine);
+=09}
+}
+
+/**
+ * kmem_cache_destroy - delete a cache
+ * @cache: the cache to destroy
+ *
+ * This function must not be called from interrupt context.
+ *
+ * Remove a kmem_cache from the slab cache.
+ *
+ * It is expected this function will be called by a module when it is
+ * unloaded.  This will remove the cache completely, and avoid a
+ * duplicate cache being allocated each time a module is loaded and
+ * unloaded, if the module doesn't have persistent in-kernel storage
+ * across loads and unloads.
+ *
+ * The cache must be empty before calling this function.
+ *
+ * The caller must guarantee that no one will allocate memory from the
+ * cache during the kmem_cache_destroy().
+ */
+int kmem_cache_destroy(struct kmem_cache *cache)
+{
+=09unsigned long flags;
+
+=09down(&cache_chain_sem);
+=09list_del(&cache->next);
+=09up(&cache_chain_sem);
+
+=09spin_lock_irqsave(&cache->lists_lock, flags);
+=09free_cpu_caches(cache);
+=09free_depot_magazines(cache);
+=09free_cache_slabs(cache);
+=09kmem_cache_free(&cache_cache, cache);
+=09spin_unlock_irqrestore(&cache->lists_lock, flags);
+
+=09return 0;
+}
+EXPORT_SYMBOL(kmem_cache_destroy);
+
+extern int kmem_cache_shrink(struct kmem_cache *cache)
+{
+=09unsigned long flags;
+=09struct kmem_cpu_cache *cpu_cache =3D cpu_cache_get(cache);
+
+=09purge_magazine(cache, cpu_cache->loaded);
+=09purge_magazine(cache, cpu_cache->prev);
+
+=09spin_lock_irqsave(&cache->lists_lock, flags);
+=09free_depot_magazines(cache);
+=09free_slab_list(cache, &cache->full_slabs);
+=09spin_unlock_irqrestore(&cache->lists_lock, flags);
+=09return 0;
+}
+EXPORT_SYMBOL(kmem_cache_shrink);
+
+
+/*
+ *=09Cache Reaping
+ */
+
+/**
+ * cache_reap - Reclaim memory from caches.
+ * @unused: unused parameter
+ *
+ * Called from workqueue/eventd every few seconds.
+ * Purpose:
+ * - clear the per-cpu caches for this CPU.
+ * - return freeable pages to the main free memory pool.
+ *
+ * If we cannot acquire the cache chain semaphore then just give up - we'l=
l
+ * try again on the next iteration.
+ */
+static void cache_reap(void *unused)
+{
+=09struct list_head *walk;
+
+=09if (down_trylock(&cache_chain_sem))
+=09=09goto out;
+
+=09list_for_each(walk, &cache_chain) {
+=09=09struct kmem_cache *cache =3D list_entry(walk, struct kmem_cache,
+=09=09=09=09=09=09      next);
+=09=09kmem_cache_shrink(cache);
+=09}
+
+=09up(&cache_chain_sem);
+  out:
+=09/* Setup the next iteration */
+=09schedule_delayed_work(&__get_cpu_var(reap_work),
+=09=09=09      REAP_TIMEOUT_CPU_CACHES);
+}
+
+/*
+ * Initiate the reap timer running on the target CPU.  We run at around 1 =
to 2Hz
+ * via the workqueue/eventd.
+ * Add the CPU number into the expiration time to minimize the possibility=
 of
+ * the CPUs getting into lockstep and contending for the global cache chai=
n
+ * lock.
+ */
+static void __devinit start_cpu_timer(int cpu)
+{
+=09struct work_struct *reap_work =3D &per_cpu(reap_work, cpu);
+
+=09/*
+=09 * When this gets called from do_initcalls via cpucache_init(),
+=09 * init_workqueues() has already run, so keventd will be setup
+=09 * at that time.
+=09 */
+=09if (keventd_up() && reap_work->func =3D=3D NULL) {
+=09=09INIT_WORK(reap_work, cache_reap, NULL);
+=09=09schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
+=09}
+}
+
+
+/*
+ *=09Proc FS
+ */
+
+#ifdef CONFIG_PROC_FS
+
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+=09loff_t n =3D *pos;
+=09struct list_head *p;
+
+=09down(&cache_chain_sem);
+=09if (!n) {
+=09=09/*
+=09=09 * Output format version, so at least we can change it
+=09=09 * without _too_ many complaints.
+=09=09 */
+=09=09seq_puts(m, "slabinfo - version: 2.1\n");
+=09=09seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <o=
bjperslab> <pagesperslab>");
+=09=09seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
+=09=09seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
+=09=09seq_putc(m, '\n');
+=09}
+=09p =3D cache_chain.next;
+=09while (n--) {
+=09=09p =3D p->next;
+=09=09if (p =3D=3D &cache_chain)
+=09=09=09return NULL;
+=09}
+=09return list_entry(p, struct kmem_cache, next);
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+=09struct kmem_cache *cache =3D p;
+=09++*pos;
+=09return cache->next.next =3D=3D &cache_chain ? NULL
+=09=09: list_entry(cache->next.next, struct kmem_cache, next);
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+=09up(&cache_chain_sem);
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+=09struct kmem_cache *cache =3D p;
+=09struct list_head *q;
+=09struct kmem_slab *slab;
+=09unsigned long active_objs;
+=09unsigned long num_objs;
+=09unsigned long active_slabs =3D 0;
+=09unsigned long num_slabs, free_objects =3D 0, shared_avail =3D 0;
+=09const char *name;
+=09char *error =3D NULL;
+
+=09spin_lock_irq(&cache->lists_lock);
+
+=09active_objs =3D 0;
+=09num_slabs =3D 0;
+
+=09list_for_each(q, &cache->full_slabs) {
+=09=09slab =3D list_entry(q, struct kmem_slab, list);
+=09=09active_slabs++;
+=09=09active_objs +=3D cache->slab_capacity - slab->nr_available;
+=09}
+
+=09list_for_each(q, &cache->partial_slabs) {
+=09=09slab =3D list_entry(q, struct kmem_slab, list);
+=09=09active_slabs++;
+=09=09active_objs +=3D cache->slab_capacity - slab->nr_available;
+=09}
+
+=09list_for_each(q, &cache->empty_slabs) {
+=09=09slab =3D list_entry(q, struct kmem_slab, list);
+=09=09active_slabs++;
+=09=09active_objs +=3D cache->slab_capacity - slab->nr_available;
+=09}
+
+=09num_slabs +=3D active_slabs;
+=09num_objs =3D num_slabs * cache->slab_capacity;
+=09free_objects =3D cache->free_objects;
+
+=09if (num_objs - active_objs !=3D free_objects && !error)
+=09=09error =3D "free_objects accounting error";
+
+=09name =3D cache->name;
+=09if (error)
+=09=09printk(KERN_ERR "slab: cache %s error: %s\n", name, error);
+
+=09seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
+=09=09name, active_objs, num_objs, cache->objsize,
+=09=09cache->slab_capacity, (1 << cache->cache_order));
+=09seq_printf(m, " : slabdata %6lu %6lu %6lu",
+=09=09=09active_slabs, num_slabs, shared_avail);
+=09seq_putc(m, '\n');
+
+=09spin_unlock_irq(&cache->lists_lock);
+=09return 0;
+}
+
+/*
+ * slabinfo_op - iterator that generates /proc/slabinfo
+ *
+ * Output layout:
+ * cache-name
+ * num-active-objs
+ * total-objs
+ * object size
+ * num-active-slabs
+ * total-slabs
+ * num-pages-per-slab
+ * + further values on SMP and with statistics enabled
+ */
+
+struct seq_operations slabinfo_op =3D {
+=09.start=09=3D s_start,
+=09.next=09=3D s_next,
+=09.stop=09=3D s_stop,
+=09.show=09=3D s_show,
+};
+
+ssize_t slabinfo_write(struct file *file, const char __user *buffer,
+=09=09       size_t count, loff_t *ppos)
+{
+=09return -EFAULT;
+}
+#endif
+
+
+/*
+ *=09Memory Allocator Initialization
+ */
+
+static int bootstrap_cpu_caches(struct kmem_cache *cache)
+{
+=09int i, err =3D 0;
+
+=09for (i =3D 0; i < NR_CPUS; i++) {
+=09=09struct kmem_cpu_cache *cpu_cache =3D __cpu_cache_get(cache, i);
+=09=09spin_lock_init(&cpu_cache->lock);
+
+=09=09spin_lock(&cache->lists_lock);
+=09=09cpu_cache->loaded =3D slab_alloc(cache, GFP_KERNEL);
+=09=09spin_unlock(&cache->lists_lock);
+=09=09if (!cpu_cache->loaded) {
+=09=09=09err =3D -ENOMEM;
+=09=09=09goto out;
+=09=09}
+
+=09=09init_magazine(cpu_cache->loaded);
+
+=09=09spin_lock(&cache->lists_lock);
+=09=09cpu_cache->prev =3D slab_alloc(cache, GFP_KERNEL);
+=09=09spin_unlock(&cache->lists_lock);
+=09=09if (!cpu_cache->prev) {
+=09=09=09err =3D -ENOMEM;
+=09=09=09goto out;
+=09=09}
+
+=09=09init_magazine(cpu_cache->prev);
+=09}
+
+  out:
+=09return err;
+}
+
+void kmem_cache_init(void)
+{
+=09init_MUTEX(&cache_chain_sem);
+=09INIT_LIST_HEAD(&cache_chain);
+
+=09cache_cache.cache_order =3D cache_order(&cache_cache);
+=09cache_cache.slab_capacity =3D slab_capacity(&cache_cache);
+=09slab_cache.cache_order =3D cache_order(&slab_cache);
+=09slab_cache.slab_capacity =3D slab_capacity(&slab_cache);
+=09magazine_cache.cache_order =3D cache_order(&magazine_cache);
+=09magazine_cache.slab_capacity =3D slab_capacity(&magazine_cache);
+
+=09init_cache(&cache_cache);
+=09init_cache(&slab_cache);
+=09init_cache(&magazine_cache);
+
+=09if (bootstrap_cpu_caches(&magazine_cache))
+=09=09goto failed;
+
+=09if (init_cpu_caches(&cache_cache))
+=09=09goto failed;
+
+=09if (init_cpu_caches(&slab_cache))
+=09=09goto failed;
+
+=09list_add(&cache_cache.next, &cache_chain);
+=09list_add(&slab_cache.next, &cache_chain);
+=09list_add(&magazine_cache.next, &cache_chain);
+
+=09kmalloc_init();
+
+=09return;
+
+  failed:
+=09panic("slab allocator init failed");
+}
+
+static int __init cpucache_init(void)
+{
+=09int cpu;
+
+=09/*=20
+=09 * Register the timers that return unneeded
+=09 * pages to gfp.
+=09 */
+=09for_each_online_cpu(cpu)
+=09=09start_cpu_timer(cpu);
+
+=09return 0;
+}
+
+__initcall(cpucache_init);
+
+void kmem_cache_release(void)
+{
+}
Index: 2.6/test/CuTest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/CuTest.c
@@ -0,0 +1,331 @@
+#include <assert.h>
+#include <setjmp.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <math.h>
+
+#include "CuTest.h"
+
+/*------------------------------------------------------------------------=
-*
+ * CuStr
+ *------------------------------------------------------------------------=
-*/
+
+char* CuStrAlloc(int size)
+{
+=09char* newStr =3D (char*) malloc( sizeof(char) * (size) );
+=09return newStr;
+}
+
+char* CuStrCopy(const char* old)
+{
+=09int len =3D strlen(old);
+=09char* newStr =3D CuStrAlloc(len + 1);
+=09strcpy(newStr, old);
+=09return newStr;
+}
+
+/*------------------------------------------------------------------------=
-*
+ * CuString
+ *------------------------------------------------------------------------=
-*/
+
+void CuStringInit(CuString* str)
+{
+=09str->length =3D 0;
+=09str->size =3D STRING_MAX;
+=09str->buffer =3D (char*) malloc(sizeof(char) * str->size);
+=09str->buffer[0] =3D '\0';
+}
+
+CuString* CuStringNew(void)
+{
+=09CuString* str =3D (CuString*) malloc(sizeof(CuString));
+=09str->length =3D 0;
+=09str->size =3D STRING_MAX;
+=09str->buffer =3D (char*) malloc(sizeof(char) * str->size);
+=09str->buffer[0] =3D '\0';
+=09return str;
+}
+
+void CuStringDelete(CuString* str)
+{
+=09free(str->buffer);
+=09free(str);
+}
+
+void CuStringResize(CuString* str, int newSize)
+{
+=09str->buffer =3D (char*) realloc(str->buffer, sizeof(char) * newSize);
+=09str->size =3D newSize;
+}
+
+void CuStringAppend(CuString* str, const char* text)
+{
+=09int length;
+
+=09if (text =3D=3D NULL) {
+=09=09text =3D "NULL";
+=09}
+
+=09length =3D strlen(text);
+=09if (str->length + length + 1 >=3D str->size)
+=09=09CuStringResize(str, str->length + length + 1 + STRING_INC);
+=09str->length +=3D length;
+=09strcat(str->buffer, text);
+}
+
+void CuStringAppendChar(CuString* str, char ch)
+{
+=09char text[2];
+=09text[0] =3D ch;
+=09text[1] =3D '\0';
+=09CuStringAppend(str, text);
+}
+
+void CuStringAppendFormat(CuString* str, const char* format, ...)
+{
+=09va_list argp;
+=09char buf[HUGE_STRING_LEN];
+=09va_start(argp, format);
+=09vsprintf(buf, format, argp);
+=09va_end(argp);
+=09CuStringAppend(str, buf);
+}
+
+void CuStringInsert(CuString* str, const char* text, int pos)
+{
+=09int length =3D strlen(text);
+=09if (pos > str->length)
+=09=09pos =3D str->length;
+=09if (str->length + length + 1 >=3D str->size)
+=09=09CuStringResize(str, str->length + length + 1 + STRING_INC);
+=09memmove(str->buffer + pos + length, str->buffer + pos, (str->length - p=
os) + 1);
+=09str->length +=3D length;
+=09memcpy(str->buffer + pos, text, length);
+}
+
+/*------------------------------------------------------------------------=
-*
+ * CuTest
+ *------------------------------------------------------------------------=
-*/
+
+void CuTestInit(CuTest* t, const char* name, TestFunction function)
+{
+=09t->name =3D CuStrCopy(name);
+=09t->failed =3D 0;
+=09t->ran =3D 0;
+=09t->message =3D NULL;
+=09t->function =3D function;
+=09t->jumpBuf =3D NULL;
+}
+
+CuTest* CuTestNew(const char* name, TestFunction function)
+{
+=09CuTest* tc =3D malloc(sizeof(*tc));
+=09CuTestInit(tc, name, function);
+=09return tc;
+}
+
+void CuTestDelete(CuTest *ct)
+{
+=09free((char *)ct->name);
+=09free(ct);
+}
+
+void CuTestRun(CuTest* tc)
+{
+=09jmp_buf buf;
+=09tc->jumpBuf =3D &buf;
+=09if (setjmp(buf) =3D=3D 0)
+=09{
+=09=09tc->ran =3D 1;
+=09=09(tc->function)(tc);
+=09}
+=09tc->jumpBuf =3D 0;
+}
+
+static void CuFailInternal(CuTest* tc, const char* file, int line, CuStrin=
g* string)
+{
+=09char buf[HUGE_STRING_LEN];
+
+=09sprintf(buf, "%s:%d: ", file, line);
+=09CuStringInsert(string, buf, 0);
+
+=09tc->failed =3D 1;
+=09tc->message =3D string->buffer;
+=09if (tc->jumpBuf !=3D 0) longjmp(*(tc->jumpBuf), 0);
+}
+
+void CuFail_Line(CuTest* tc, const char* file, int line, const char* messa=
ge2, const char* message)
+{
+=09CuString string;
+
+=09CuStringInit(&string);
+=09if (message2 !=3D NULL)
+=09{
+=09=09CuStringAppend(&string, message2);
+=09=09CuStringAppend(&string, ": ");
+=09}
+=09CuStringAppend(&string, message);
+=09CuFailInternal(tc, file, line, &string);
+}
+
+void CuAssert_Line(CuTest* tc, const char* file, int line, const char* mes=
sage, int condition)
+{
+=09if (condition) return;
+=09CuFail_Line(tc, file, line, NULL, message);
+}
+
+void CuAssertStrEquals_LineMsg(CuTest* tc, const char* file, int line, con=
st char* message,
+=09const char* expected, const char* actual)
+{
+=09CuString string;
+=09if ((expected =3D=3D NULL && actual =3D=3D NULL) ||
+=09    (expected !=3D NULL && actual !=3D NULL &&
+=09     strcmp(expected, actual) =3D=3D 0))
+=09{
+=09=09return;
+=09}
+
+=09CuStringInit(&string);
+=09if (message !=3D NULL)
+=09{
+=09=09CuStringAppend(&string, message);
+=09=09CuStringAppend(&string, ": ");
+=09}
+=09CuStringAppend(&string, "expected <");
+=09CuStringAppend(&string, expected);
+=09CuStringAppend(&string, "> but was <");
+=09CuStringAppend(&string, actual);
+=09CuStringAppend(&string, ">");
+=09CuFailInternal(tc, file, line, &string);
+}
+
+void CuAssertIntEquals_LineMsg(CuTest* tc, const char* file, int line, con=
st char* message,
+=09int expected, int actual)
+{
+=09char buf[STRING_MAX];
+=09if (expected =3D=3D actual) return;
+=09sprintf(buf, "expected <%d> but was <%d>", expected, actual);
+=09CuFail_Line(tc, file, line, message, buf);
+}
+
+void CuAssertDblEquals_LineMsg(CuTest* tc, const char* file, int line, con=
st char* message,
+=09double expected, double actual, double delta)
+{
+=09char buf[STRING_MAX];
+=09if (fabs(expected - actual) <=3D delta) return;
+=09sprintf(buf, "expected <%lf> but was <%lf>", expected, actual);
+=09CuFail_Line(tc, file, line, message, buf);
+}
+
+void CuAssertPtrEquals_LineMsg(CuTest* tc, const char* file, int line, con=
st char* message,
+=09void* expected, void* actual)
+{
+=09char buf[STRING_MAX];
+=09if (expected =3D=3D actual) return;
+=09sprintf(buf, "expected pointer <0x%p> but was <0x%p>", expected, actual=
);
+=09CuFail_Line(tc, file, line, message, buf);
+}
+
+
+/*------------------------------------------------------------------------=
-*
+ * CuSuite
+ *------------------------------------------------------------------------=
-*/
+
+void CuSuiteInit(CuSuite* testSuite)
+{
+=09testSuite->count =3D 0;
+=09testSuite->failCount =3D 0;
+}
+
+CuSuite* CuSuiteNew(void)
+{
+=09CuSuite* testSuite =3D malloc(sizeof(*testSuite));
+=09CuSuiteInit(testSuite);
+=09return testSuite;
+}
+
+void CuSuiteDelete(CuSuite *testSuite)
+{
+=09int i;
+=09for (i =3D 0 ; i < testSuite->count ; ++i)
+=09{
+=09=09CuTestDelete(testSuite->list[i]);
+=09}
+=09free(testSuite);
+}
+
+void CuSuiteAdd(CuSuite* testSuite, CuTest *testCase)
+{
+=09assert(testSuite->count < MAX_TEST_CASES);
+=09testSuite->list[testSuite->count] =3D testCase;
+=09testSuite->count++;
+}
+
+void CuSuiteAddSuite(CuSuite* testSuite, CuSuite* testSuite2)
+{
+=09int i;
+=09for (i =3D 0 ; i < testSuite2->count ; ++i)
+=09{
+=09=09CuTest* testCase =3D testSuite2->list[i];
+=09=09CuSuiteAdd(testSuite, testCase);
+=09}
+}
+
+void CuSuiteRun(CuSuite* testSuite)
+{
+=09int i;
+=09for (i =3D 0 ; i < testSuite->count ; ++i)
+=09{
+=09=09CuTest* testCase =3D testSuite->list[i];
+=09=09CuTestRun(testCase);
+=09=09if (testCase->failed) { testSuite->failCount +=3D 1; }
+=09}
+}
+
+void CuSuiteSummary(CuSuite* testSuite, CuString* summary)
+{
+=09int i;
+=09for (i =3D 0 ; i < testSuite->count ; ++i)
+=09{
+=09=09CuTest* testCase =3D testSuite->list[i];
+=09=09CuStringAppend(summary, testCase->failed ? "F" : ".");
+=09}
+=09CuStringAppend(summary, "\n\n");
+}
+
+void CuSuiteDetails(CuSuite* testSuite, CuString* details)
+{
+=09int i;
+=09int failCount =3D 0;
+
+=09if (testSuite->failCount =3D=3D 0)
+=09{
+=09=09int passCount =3D testSuite->count - testSuite->failCount;
+=09=09const char* testWord =3D passCount =3D=3D 1 ? "test" : "tests";
+=09=09CuStringAppendFormat(details, "OK (%d %s)\n", passCount, testWord);
+=09}
+=09else
+=09{
+=09=09if (testSuite->failCount =3D=3D 1)
+=09=09=09CuStringAppend(details, "There was 1 failure:\n");
+=09=09else
+=09=09=09CuStringAppendFormat(details, "There were %d failures:\n", testSu=
ite->failCount);
+
+=09=09for (i =3D 0 ; i < testSuite->count ; ++i)
+=09=09{
+=09=09=09CuTest* testCase =3D testSuite->list[i];
+=09=09=09if (testCase->failed)
+=09=09=09{
+=09=09=09=09failCount++;
+=09=09=09=09CuStringAppendFormat(details, "%d) %s: %s\n",
+=09=09=09=09=09failCount, testCase->name, testCase->message);
+=09=09=09}
+=09=09}
+=09=09CuStringAppend(details, "\n!!!FAILURES!!!\n");
+
+=09=09CuStringAppendFormat(details, "Runs: %d ",   testSuite->count);
+=09=09CuStringAppendFormat(details, "Passes: %d ", testSuite->count - test=
Suite->failCount);
+=09=09CuStringAppendFormat(details, "Fails: %d\n",  testSuite->failCount);
+=09}
+}
Index: 2.6/test/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/Makefile
@@ -0,0 +1,18 @@
+all: test
+
+gen:
+=09sh make-tests.sh mm/*.c > test-runner.c
+
+compile:
+=09gcc -O2 -g -Wall -Iinclude -I../include -D__KERNEL__=3D1 ../mm/kmalloc.=
c mm/kmalloc-test.c ../mm/kmem.c mm/kmem-test.c mm/page_alloc.c kernel/pani=
c.c kernel/workqueue.c kernel/timer.c CuTest.c test-runner.c -o test-runner
+
+run:
+=09./test-runner
+
+test: gen compile run
+
+valgrind: gen compile
+=09valgrind --leak-check=3Dfull test-runner
+
+clean:
+=09rm -f *.o tags test-runner test-runner.c
Index: 2.6/test/include/CuTest.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/CuTest.h
@@ -0,0 +1,116 @@
+#ifndef CU_TEST_H
+#define CU_TEST_H
+
+#include <setjmp.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+/* CuString */
+
+char* CuStrAlloc(int size);
+char* CuStrCopy(const char* old);
+
+#define CU_ALLOC(TYPE)=09=09((TYPE*) malloc(sizeof(TYPE)))
+
+#define HUGE_STRING_LEN=098192
+#define STRING_MAX=09=09256
+#define STRING_INC=09=09256
+
+typedef struct
+{
+=09int length;
+=09int size;
+=09char* buffer;
+} CuString;
+
+void CuStringInit(CuString* str);
+CuString* CuStringNew(void);
+void CuStringDelete(CuString *str);
+void CuStringRead(CuString* str, const char* path);
+void CuStringAppend(CuString* str, const char* text);
+void CuStringAppendChar(CuString* str, char ch);
+void CuStringAppendFormat(CuString* str, const char* format, ...);
+void CuStringInsert(CuString* str, const char* text, int pos);
+void CuStringResize(CuString* str, int newSize);
+
+/* CuTest */
+
+typedef struct CuTest CuTest;
+
+typedef void (*TestFunction)(CuTest *);
+
+struct CuTest
+{
+=09const char* name;
+=09TestFunction function;
+=09int failed;
+=09int ran;
+=09const char* message;
+=09jmp_buf *jumpBuf;
+};
+
+void CuTestInit(CuTest* t, const char* name, TestFunction function);
+CuTest* CuTestNew(const char* name, TestFunction function);
+void CuTestDelete(CuTest *tc);
+void CuTestRun(CuTest* tc);
+
+/* Internal versions of assert functions -- use the public versions */
+void CuFail_Line(CuTest* tc, const char* file, int line, const char* messa=
ge2, const char* message);
+void CuAssert_Line(CuTest* tc, const char* file, int line, const char* mes=
sage, int condition);
+void CuAssertStrEquals_LineMsg(CuTest* tc,
+=09const char* file, int line, const char* message,
+=09const char* expected, const char* actual);
+void CuAssertIntEquals_LineMsg(CuTest* tc,
+=09const char* file, int line, const char* message,
+=09int expected, int actual);
+void CuAssertDblEquals_LineMsg(CuTest* tc,
+=09const char* file, int line, const char* message,
+=09double expected, double actual, double delta);
+void CuAssertPtrEquals_LineMsg(CuTest* tc,
+=09const char* file, int line, const char* message,
+=09void* expected, void* actual);
+
+/* public assert functions */
+
+#define CuFail(tc, ms)                        CuFail_Line(  (tc), __FILE__=
, __LINE__, NULL, (ms))
+#define CuAssert(tc, ms, cond)                CuAssert_Line((tc), __FILE__=
, __LINE__, (ms), (cond))
+#define CuAssertTrue(tc, cond)                CuAssert_Line((tc), __FILE__=
, __LINE__, "assert failed", (cond))
+
+#define CuAssertStrEquals(tc,ex,ac)           CuAssertStrEquals_LineMsg((t=
c),__FILE__,__LINE__,NULL,(ex),(ac))
+#define CuAssertStrEquals_Msg(tc,ms,ex,ac)    CuAssertStrEquals_LineMsg((t=
c),__FILE__,__LINE__,(ms),(ex),(ac))
+#define CuAssertIntEquals(tc,ex,ac)           CuAssertIntEquals_LineMsg((t=
c),__FILE__,__LINE__,NULL,(ex),(ac))
+#define CuAssertIntEquals_Msg(tc,ms,ex,ac)    CuAssertIntEquals_LineMsg((t=
c),__FILE__,__LINE__,(ms),(ex),(ac))
+#define CuAssertDblEquals(tc,ex,ac,dl)        CuAssertDblEquals_LineMsg((t=
c),__FILE__,__LINE__,NULL,(ex),(ac),(dl))
+#define CuAssertDblEquals_Msg(tc,ms,ex,ac,dl) CuAssertDblEquals_LineMsg((t=
c),__FILE__,__LINE__,(ms),(ex),(ac),(dl))
+#define CuAssertPtrEquals(tc,ex,ac)           CuAssertPtrEquals_LineMsg((t=
c),__FILE__,__LINE__,NULL,(ex),(ac))
+#define CuAssertPtrEquals_Msg(tc,ms,ex,ac)    CuAssertPtrEquals_LineMsg((t=
c),__FILE__,__LINE__,(ms),(ex),(ac))
+
+#define CuAssertPtrNotNull(tc,p)        CuAssert_Line((tc),__FILE__,__LINE=
__,"null pointer unexpected",(p !=3D NULL))
+#define CuAssertPtrNotNullMsg(tc,msg,p) CuAssert_Line((tc),__FILE__,__LINE=
__,(msg),(p !=3D NULL))
+
+/* CuSuite */
+
+#define MAX_TEST_CASES=091024
+
+#define SUITE_ADD_TEST(SUITE,TEST)=09CuSuiteAdd(SUITE, CuTestNew(#TEST, TE=
ST))
+
+typedef struct
+{
+=09int count;
+=09CuTest* list[MAX_TEST_CASES];
+=09int failCount;
+
+} CuSuite;
+
+
+void CuSuiteInit(CuSuite* testSuite);
+CuSuite* CuSuiteNew(void);
+void CuSuiteDelete(CuSuite *);
+void CuSuiteAdd(CuSuite* testSuite, CuTest *testCase);
+void CuSuiteAddSuite(CuSuite* testSuite, CuSuite* testSuite2);
+void CuSuiteRun(CuSuite* testSuite);
+void CuSuiteSummary(CuSuite* testSuite, CuString* summary);
+void CuSuiteDetails(CuSuite* testSuite, CuString* details);
+
+#endif /* CU_TEST_H */
Index: 2.6/test/make-tests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/make-tests.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+
+# Auto generate single AllTests file for CuTest.
+# Searches through all *.c files in the current directory.
+# Prints to stdout.
+# Author: Asim Jalis
+# Date: 01/08/2003
+
+if test $# -eq 0 ; then FILES=3D*.c ; else FILES=3D$* ; fi
+
+echo '
+
+/* This is auto-generated code. Edit at your own peril. */
+
+#include "CuTest.h"
+
+'
+
+cat $FILES | grep '^void test' |
+    sed -e 's/(.*$//' \
+        -e 's/$/(CuTest*);/' \
+        -e 's/^/extern /'
+
+echo \
+'
+
+void RunAllTests(void)
+{
+    CuString *output =3D CuStringNew();
+    CuSuite* suite =3D CuSuiteNew();
+
+'
+cat $FILES | grep '^void test' |
+    sed -e 's/^void //' \
+        -e 's/(.*$//' \
+        -e 's/^/    SUITE_ADD_TEST(suite, /' \
+        -e 's/$/);/'
+
+echo \
+'
+    CuSuiteRun(suite);
+    CuSuiteSummary(suite, output);
+    CuSuiteDetails(suite, output);
+    printf("%s\n", output->buffer);
+    CuSuiteDelete(suite);
+    CuStringDelete(output);
+}
+
+int main(void)
+{
+    RunAllTests();
+    return 0;
+}
+'
Index: 2.6/test/mm/kmalloc-test.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/mm/kmalloc-test.c
@@ -0,0 +1,21 @@
+#include <CuTest.h>
+#include <linux/kmem.h>
+
+void test_kmalloc_returns_from_slab(CuTest *ct)
+{
+=09kmem_cache_init();
+=09void *obj1 =3D kmalloc(10, GFP_KERNEL);
+=09void *obj2 =3D kmalloc(10, GFP_KERNEL);
+=09CuAssertIntEquals(ct, (unsigned long)obj1+32, (unsigned long)obj2);
+=09kmem_cache_release();
+}
+
+void test_kzalloc_zeros_memory(CuTest *ct)
+{
+=09int i;
+=09kmem_cache_init();
+=09char *obj =3D kzalloc(10, GFP_KERNEL);
+=09for (i =3D 0; i < 10; i++)
+=09=09CuAssertIntEquals(ct, 0, obj[i]);
+=09kmem_cache_release();
+}
Index: 2.6/test/mm/kmem-test.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/mm/kmem-test.c
@@ -0,0 +1,239 @@
+#include <CuTest.h>
+#include <linux/kmem.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+
+#define DEFAULT_OBJSIZE (PAGE_SIZE/2)
+#define MAX_OBJS (100)
+
+void test_retains_cache_name(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("object_cache", 512, 0, =
0, NULL, NULL);
+=09CuAssertStrEquals(ct, "object_cache", cache->name);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+void test_alloc_grows_cache(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
, 0, 0, NULL, NULL);
+=09CuAssertIntEquals(ct, 0, cache->stats.grown);
+=09void *obj =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09CuAssertIntEquals(ct, 1, cache->stats.grown);
+=09kmem_cache_free(cache, obj);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+static void alloc_objs(struct kmem_cache *cache, void *objs[], size_t nr_o=
bjs)
+{
+=09int i;
+=09for (i =3D 0; i < nr_objs; i++) {
+=09=09objs[i] =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09}
+}
+
+static void free_objs(struct kmem_cache *cache, void *objs[], size_t nr_ob=
js)
+{
+=09int i;
+=09for (i =3D 0; i < nr_objs; i++) {
+=09=09kmem_cache_free(cache, objs[i]);
+=09}
+}
+
+void test_destroying_cache_reaps_slabs(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
, 0, 0, NULL, NULL);
+=09void *objs[MAX_OBJS];
+=09alloc_objs(cache, objs, MAX_OBJS);
+=09free_objs(cache, objs, MAX_OBJS);
+=09kmem_cache_destroy(cache);
+=09CuAssertIntEquals(ct, 1, list_empty(&cache->full_slabs));
+=09CuAssertIntEquals(ct, 1, list_empty(&cache->partial_slabs));
+=09CuAssertIntEquals(ct, 1, list_empty(&cache->empty_slabs));
+=09kmem_cache_release();
+}
+
+void test_multiple_objects_within_one_page(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
, 0, 0, NULL, NULL);
+=09void *objs[MAX_OBJS];
+=09alloc_objs(cache, objs, MAX_OBJS);
+=09CuAssertIntEquals(ct, (MAX_OBJS*DEFAULT_OBJSIZE/PAGE_SIZE), cache->stat=
s.grown);
+=09free_objs(cache, objs, MAX_OBJS);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+void test_allocates_from_magazine_when_available(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
, 0, 0, NULL, NULL);
+=09void *obj1 =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09kmem_cache_free(cache, obj1);
+=09void *obj2 =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09kmem_cache_free(cache, obj2);
+=09CuAssertPtrEquals(ct, obj1, obj2);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+void test_allocated_objects_are_from_same_slab(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
, 0, 0, NULL, NULL);
+=09void *obj1 =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09void *obj2 =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09CuAssertPtrEquals(ct, obj1+(DEFAULT_OBJSIZE), obj2);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+static unsigned long nr_ctor_dtor_called;
+static struct kmem_cache *cache_passed_to_ctor_dtor;
+static unsigned long flags_passed_to_ctor_dtor;
+
+static void ctor_dtor(void *obj, struct kmem_cache *cache, unsigned long f=
lags)
+{
+=09nr_ctor_dtor_called++;
+=09cache_passed_to_ctor_dtor =3D cache;
+=09flags_passed_to_ctor_dtor =3D flags;
+}
+
+static void reset_ctor_dtor(void)
+{
+=09nr_ctor_dtor_called =3D 0;
+=09cache_passed_to_ctor_dtor =3D NULL;
+=09flags_passed_to_ctor_dtor =3D 0;
+}
+
+void test_constructor_is_called_for_allocated_objects(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
,
+=09=09=09=09=09=09     0, 0, ctor_dtor, NULL);
+=09reset_ctor_dtor();
+=09void *obj =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09CuAssertIntEquals(ct, 1, nr_ctor_dtor_called);
+=09CuAssertPtrEquals(ct, cache, cache_passed_to_ctor_dtor);
+=09CuAssertIntEquals(ct, SLAB_CTOR_CONSTRUCTOR,
+=09=09=09  flags_passed_to_ctor_dtor);
+=09kmem_cache_free(cache, obj);
+=09kmem_cache_release();
+}
+
+void test_atomic_flag_is_passed_to_constructor(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
,
+=09=09=09=09=09=09     0, 0, ctor_dtor, NULL);
+=09reset_ctor_dtor();
+=09void *obj =3D kmem_cache_alloc(cache, GFP_ATOMIC);
+=09CuAssertIntEquals(ct, SLAB_CTOR_CONSTRUCTOR|SLAB_CTOR_ATOMIC,
+=09=09=09  flags_passed_to_ctor_dtor);
+=09kmem_cache_free(cache, obj);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+void test_destructor_is_called_for_allocated_objects(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
,
+=09=09=09=09=09=09     0, 0, NULL, ctor_dtor);
+=09reset_ctor_dtor();
+=09void *obj =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09kmem_cache_free(cache, obj);
+=09CuAssertIntEquals(ct, 0, nr_ctor_dtor_called);
+=09kmem_cache_destroy(cache);
+=09CuAssertIntEquals(ct, 1, nr_ctor_dtor_called);
+=09CuAssertPtrEquals(ct, cache, cache_passed_to_ctor_dtor);
+=09CuAssertIntEquals(ct, 0, flags_passed_to_ctor_dtor);
+=09kmem_cache_release();
+}
+
+#define PATTERN 0x7D
+
+static void memset_ctor(void *obj, struct kmem_cache *cache, unsigned long=
 flags)
+{
+=09memset(obj, PATTERN, cache->objsize);
+}
+
+static void memcmp_dtor(void *obj, struct kmem_cache *cache, unsigned long=
 flags)
+{
+=09int i;
+=09char *array =3D obj;
+
+=09for (i =3D 0; i < cache->objsize; i++) {
+=09=09if (array[i] !=3D PATTERN)
+=09=09=09BUG();
+=09}
+}
+
+void test_object_is_preserved_until_destructed(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", DEFAULT_OBJSIZE=
,
+=09=09=09=09=09=09     0, 0, memset_ctor,
+=09=09=09=09=09=09     memcmp_dtor);
+=09reset_ctor_dtor();
+=09void *obj =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09kmem_cache_free(cache, obj);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+static void assert_num_objs_and_cache_order(CuTest *ct,
+=09=09=09=09=09    unsigned long expected_num_objs,
+=09=09=09=09=09    unsigned int expected_order,
+=09=09=09=09=09    unsigned long objsize)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", objsize,
+=09=09=09=09=09=09     0, 0, NULL, NULL);
+=09CuAssertIntEquals(ct, expected_num_objs, cache->slab_capacity);
+=09CuAssertIntEquals(ct, expected_order, cache->cache_order);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
+
+void test_slab_order_grows_with_object_size(CuTest *ct)
+{
+=09assert_num_objs_and_cache_order(ct, 127, 0, 32);
+=09assert_num_objs_and_cache_order(ct, 63, 0, 64);
+=09assert_num_objs_and_cache_order(ct, 31, 0, 128);
+=09assert_num_objs_and_cache_order(ct, 15, 0, 256);
+=09assert_num_objs_and_cache_order(ct,  8, 0, 512);
+=09assert_num_objs_and_cache_order(ct,  4, 0, 1024);
+=09assert_num_objs_and_cache_order(ct,  2, 0, 2048);
+=09assert_num_objs_and_cache_order(ct,  1, 0, 4096);
+=09assert_num_objs_and_cache_order(ct,  1, 1, 8192);
+=09assert_num_objs_and_cache_order(ct,  1, 2, 16384);
+=09assert_num_objs_and_cache_order(ct,  1, 3, 32768);
+=09assert_num_objs_and_cache_order(ct,  1, 11, (1<<MAX_ORDER)*PAGE_SIZE);
+}
+
+void test_find_best_order_for_worst_fitting_objects(CuTest *ct)
+{
+=09assert_num_objs_and_cache_order(ct, 5, 0, 765);
+=09assert_num_objs_and_cache_order(ct, 1, 1, PAGE_SIZE+1);
+=09assert_num_objs_and_cache_order(ct, 7, 3, PAGE_SIZE+512);
+}
+
+void test_shrinking_cache_purges_magazines(CuTest *ct)
+{
+=09kmem_cache_init();
+=09struct kmem_cache *cache =3D kmem_cache_create("cache", PAGE_SIZE, 0, 0=
, NULL, NULL);
+=09void *obj =3D kmem_cache_alloc(cache, GFP_KERNEL);
+=09kmem_cache_free(cache, obj);
+=09CuAssertIntEquals(ct, 0, cache->stats.reaped);
+=09kmem_cache_shrink(cache);
+=09CuAssertIntEquals(ct, 1, list_empty(&cache->full_slabs));
+=09CuAssertIntEquals(ct, 1, cache->stats.reaped);
+=09kmem_cache_destroy(cache);
+=09kmem_cache_release();
+}
Index: 2.6/test/include/linux/gfp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/gfp.h
@@ -0,0 +1,60 @@
+#ifndef __LINUX_GFP_H
+#define __LINUX_GFP_H
+
+/*
+ * GFP bitmasks..
+ */
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
+#define __GFP_DMA=09((__force gfp_t)0x01u)
+#define __GFP_HIGHMEM=09((__force gfp_t)0x02u)
+
+/*
+ * Action modifiers - doesn't change the zoning
+ *
+ * __GFP_REPEAT: Try hard to allocate the memory, but the allocation attem=
pt
+ * _might_ fail.  This depends upon the particular VM implementation.
+ *
+ * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
+ * cannot handle allocation failures.
+ *
+ * __GFP_NORETRY: The VM implementation must not retry indefinitely.
+ */
+#define __GFP_WAIT=09((__force gfp_t)0x10u)=09/* Can wait and reschedule? =
*/
+#define __GFP_HIGH=09((__force gfp_t)0x20u)=09/* Should access emergency p=
ools? */
+#define __GFP_IO=09((__force gfp_t)0x40u)=09/* Can start physical IO? */
+#define __GFP_FS=09((__force gfp_t)0x80u)=09/* Can call down to low-level =
FS? */
+#define __GFP_COLD=09((__force gfp_t)0x100u)=09/* Cache-cold page required=
 */
+#define __GFP_NOWARN=09((__force gfp_t)0x200u)=09/* Suppress page allocati=
on failure warning */
+#define __GFP_REPEAT=09((__force gfp_t)0x400u)=09/* Retry the allocation. =
 Might fail */
+#define __GFP_NOFAIL=09((__force gfp_t)0x800u)=09/* Retry for ever.  Canno=
t fail */
+#define __GFP_NORETRY=09((__force gfp_t)0x1000u)/* Do not retry.  Might fa=
il */
+#define __GFP_NO_GROW=09((__force gfp_t)0x2000u)/* Slab internal usage */
+#define __GFP_COMP=09((__force gfp_t)0x4000u)/* Add compound page metadata=
 */
+#define __GFP_ZERO=09((__force gfp_t)0x8000u)/* Return zeroed page on succ=
ess */
+#define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency =
reserves */
+#define __GFP_NORECLAIM  ((__force gfp_t)0x20000u) /* No realy zone reclai=
m during allocation */
+#define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpu=
set memory allocs */
+
+#define __GFP_BITS_SHIFT 20=09/* Room for 20 __GFP_FOO bits */
+#define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
+
+/* if you forget to add the bitmask here kernel will crash, period */
+#define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
+=09=09=09__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
+=09=09=09__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
+=09=09=09__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
+
+#define GFP_ATOMIC=09(__GFP_HIGH)
+#define GFP_NOIO=09(__GFP_WAIT)
+#define GFP_NOFS=09(__GFP_WAIT | __GFP_IO)
+#define GFP_KERNEL=09(__GFP_WAIT | __GFP_IO | __GFP_FS)
+#define GFP_USER=09(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_HIGHUSER=09(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL =
| \
+=09=09=09 __GFP_HIGHMEM)
+
+/* Flag - indicates that the buffer will be suitable for DMA.  Ignored on =
some
+   platforms, used as appropriate on others */
+
+#define GFP_DMA=09=09__GFP_DMA
+
+#endif
Index: 2.6/test/include/asm/processor.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/processor.h
@@ -0,0 +1,4 @@
+#ifndef __LINUX_PROCESSOR_H
+#define __LINUX_PROCESSOR_H
+
+#endif
Index: 2.6/test/include/linux/compiler-gcc3.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/compiler-gcc3.h
@@ -0,0 +1,30 @@
+/* Never include this file directly.  Include <linux/compiler.h> instead. =
 */
+
+/* These definitions are for GCC v3.x.  */
+#include <linux/compiler-gcc.h>
+
+#if __GNUC_MINOR__ >=3D 1
+# define inline=09=09inline=09=09__attribute__((always_inline))
+# define __inline__=09__inline__=09__attribute__((always_inline))
+# define __inline=09__inline=09__attribute__((always_inline))
+#endif
+
+#if __GNUC_MINOR__ > 0
+# define __deprecated=09=09__attribute__((deprecated))
+#endif
+
+#if __GNUC_MINOR__ >=3D 3
+#else
+# define __attribute_used__=09__attribute__((__unused__))
+#endif
+
+#define __attribute_const__=09__attribute__((__const__))
+
+#if __GNUC_MINOR__ >=3D 1
+#define  noinline=09=09__attribute__((noinline))
+#endif
+
+#if __GNUC_MINOR__ >=3D 4
+#define __must_check=09=09__attribute__((warn_unused_result))
+#endif
+
Index: 2.6/test/include/asm/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/system.h
@@ -0,0 +1,7 @@
+#ifndef __LINUX_SYSTEM_H
+#define __LINUX_SYSTEM_H
+
+#define smp_wmb(x) x
+#define cmpxchg(ptr,o,n)
+
+#endif
Index: 2.6/test/include/asm/bug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/bug.h
@@ -0,0 +1,13 @@
+#ifndef _I386_BUG_H
+#define _I386_BUG_H
+
+#include <linux/config.h>
+#include <assert.h>
+
+#define HAVE_ARCH_BUG
+#define BUG() assert(!"bug")
+#define HAVE_ARCH_BUG_ON
+#define BUG_ON(cond) assert(!cond)
+
+#include <asm-generic/bug.h>
+#endif
Index: 2.6/test/include/linux/mm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/mm.h
@@ -0,0 +1,41 @@
+#ifndef __MM_H
+#define __MM_H
+
+#include <linux/types.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
+#include <linux/mmzone.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <asm/pgtable.h>
+
+struct page {
+=09unsigned long flags;
+=09void *virtual;
+=09struct list_head lru;
+=09struct list_head memory_map;
+=09unsigned int order;
+};
+
+#define high_memory (~0UL)
+
+#define PageSlab(page) (page->flags & 0x01)
+#define SetPageSlab(page) do { page->flags |=3D 0x01; } while (0)
+#define ClearPageSlab(page) do { page->flags &=3D ~0x01; } while (0)
+
+#define add_page_state(member,delta)
+#define sub_page_state(member,delta)
+
+static inline int TestClearPageSlab(struct page *page)
+{
+=09int ret =3D page->flags;
+=09ClearPageSlab(page);
+=09return ret;
+}
+
+#define page_address(page) (page->virtual)
+
+extern struct page *alloc_pages(gfp_t, unsigned int);
+extern void free_pages(unsigned long, unsigned int);
+
+#endif
Index: 2.6/include/linux/kmem.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/include/linux/kmem.h
@@ -0,0 +1,242 @@
+/*
+ * include/linux/kmem.h - An object-caching memory allocator.
+ *
+ * Copyright (C) 2005 Pekka Enberg
+ *
+ * This file is released under the GPLv2.
+ */
+
+#ifndef __LINUX_KMEM_H
+#define __LINUX_KMEM_H
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+#include <asm/cache.h>
+#include <asm/page.h>
+
+/*
+ *=09Object-Caching Allocator
+ */
+
+struct kmem_bufctl {
+=09void *addr;
+=09void *next;
+};
+
+/**
+ * struct kmem_slab - contiguous memory carved up into equal-sized chunks.
+ *
+ * @list: List head used by object cache slab lists.
+ * @mem: Pointer to the beginning of a contiguous memory block.
+ * @nr_available: Number of available objects.
+ * @free: A pointer to bufctl of next free object.
+ *
+ * A slab consist of one or more pages of contiguous memory carved up into
+ * equal-sized chunks.
+ */
+struct kmem_slab {
+=09struct list_head list;
+=09void *mem;
+=09size_t nr_available;
+=09struct kmem_bufctl *free;
+};
+
+enum { MAX_ROUNDS =3D 10 };
+
+/**
+ * struct kmem_magazine - a stack of objects.
+ *
+ * @rounds: Number of objects available for allocation.
+ * @objs: Objects in this magazine.
+ * @list: List head used by object cache depot magazine lists.
+ *
+ * A magazine contains a stack of objects. It is used as a per-CPU data
+ * structure that can satisfy M allocations without a need for a global
+ * lock.
+ */
+struct kmem_magazine {
+=09size_t rounds;
+=09void *objs[MAX_ROUNDS];
+=09struct list_head list;
+};
+
+struct kmem_cpu_cache {
+=09spinlock_t lock;
+=09struct kmem_magazine *loaded;
+=09struct kmem_magazine *prev;
+};
+
+struct kmem_cache_statistics {
+=09unsigned long grown;
+=09unsigned long reaped;
+};
+
+struct kmem_cache;
+
+typedef void (*kmem_ctor_fn)(void *, struct kmem_cache *, unsigned long);
+typedef void (*kmem_dtor_fn)(void *, struct kmem_cache *, unsigned long);
+
+/**
+ * An object cache for equal-sized objects. An cache consists of per-CPU
+ * magazines, a depot, and a list of slabs.
+ *
+ * @lists_lock: A lock protecting full_slabs, partia_slabs, empty_slabs,
+ * =09full_magazines, and empty_magazines lists.
+ * @slabs: List of slabs that contain free buffers.
+ * @empty_slabs: List of slabs do not contain any free buffers.
+ * @full_magazines: List of magazines that can contain objects.
+ * @empty_magazines: List of empty magazines that do not contain any objec=
ts.
+ */
+struct kmem_cache {
+=09struct kmem_cpu_cache cpu_cache[NR_CPUS];
+=09size_t objsize;
+=09gfp_t gfp_flags;
+=09unsigned int slab_capacity;
+=09unsigned int cache_order;
+=09spinlock_t lists_lock;
+=09struct list_head full_slabs;
+=09struct list_head partial_slabs;
+=09struct list_head empty_slabs;
+=09struct list_head full_magazines;
+=09struct list_head empty_magazines;
+=09struct kmem_cache_statistics stats;
+=09kmem_ctor_fn ctor;
+=09kmem_ctor_fn dtor;
+=09const char *name;
+=09struct list_head next;
+=09unsigned long active_objects;
+=09unsigned long free_objects;
+};
+
+typedef struct kmem_cache kmem_cache_t;
+
+extern void kmem_cache_init(void);
+extern void kmem_cache_release(void);
+extern struct kmem_cache *kmem_cache_create(const char *, size_t, size_t,
+=09=09=09=09=09    unsigned long, kmem_ctor_fn,
+=09=09=09=09=09    kmem_ctor_fn);
+extern int kmem_cache_destroy(struct kmem_cache *);
+extern int kmem_cache_shrink(struct kmem_cache *);
+extern const char *kmem_cache_name(struct kmem_cache *cache);
+extern void *kmem_cache_alloc(struct kmem_cache *, gfp_t);
+extern void *kmem_cache_alloc_node(kmem_cache_t *, unsigned int __nocast, =
int);
+extern void kmem_cache_free(struct kmem_cache *, void *);
+
+/* Flags passd to kmem_cache_alloc().  */
+#define=09SLAB_NOFS=09GFP_NOFS
+#define=09SLAB_NOIO=09GFP_NOIO
+#define=09SLAB_ATOMIC=09GFP_ATOMIC
+#define=09SLAB_USER=09GFP_USER
+#define=09SLAB_KERNEL=09GFP_KERNEL
+#define=09SLAB_DMA=09GFP_DMA
+
+/* Flags passed to kmem_cache_create(). The first three are only valid whe=
n
+ * the allocator as been build with SLAB_DEBUG_SUPPORT.
+ */
+#define=09SLAB_DEBUG_FREE=09=090x00000100UL=09/* Peform (expensive) checks=
 on free */
+#define=09SLAB_DEBUG_INITIAL=090x00000200UL=09/* Call constructor (as veri=
fier) */
+#define=09SLAB_RED_ZONE=09=090x00000400UL=09/* Red zone objs in a cache */
+#define=09SLAB_POISON=09=090x00000800UL=09/* Poison objects */
+#define=09SLAB_NO_REAP=09=090x00001000UL=09/* never reap from the cache */
+#define=09SLAB_HWCACHE_ALIGN=090x00002000UL=09/* align objs on a h/w cache=
 lines */
+#define SLAB_CACHE_DMA=09=090x00004000UL=09/* use GFP_DMA memory */
+#define SLAB_MUST_HWCACHE_ALIGN=090x00008000UL=09/* force alignment */
+#define SLAB_STORE_USER=09=090x00010000UL=09/* store the last owner for bu=
g hunting */
+#define SLAB_RECLAIM_ACCOUNT=090x00020000UL=09/* track pages allocated to =
indicate
+=09=09=09=09=09=09   what is reclaimable later*/
+#define SLAB_PANIC=09=090x00040000UL=09/* panic if kmem_cache_create() fai=
ls */
+#define SLAB_DESTROY_BY_RCU=090x00080000UL=09/* defer freeing pages to RCU=
 */
+
+/* Flags passed to a constructor function.  */
+#define=09SLAB_CTOR_CONSTRUCTOR=090x001UL=09=09/* if not set, then deconst=
ructor */
+#define SLAB_CTOR_ATOMIC=090x002UL=09=09/* tell constructor it can't sleep=
 */
+#define=09SLAB_CTOR_VERIFY=090x004UL=09=09/* tell constructor it's a verif=
y call */
+
+extern int FASTCALL(kmem_ptr_validate(struct kmem_cache *cachep, void *ptr=
));
+
+
+/*
+ *=09General purpose allocator
+ */
+
+extern void kmalloc_init(void);
+
+struct cache_sizes {
+=09size_t cs_size;
+=09struct kmem_cache *cs_cache, *cs_dma_cache;
+};
+
+extern struct cache_sizes malloc_sizes[];
+
+extern void *kmalloc_node(size_t size, unsigned int __nocast flags, int no=
de);
+extern void *__kmalloc(size_t, gfp_t);
+
+static inline void *kmalloc(size_t size, gfp_t flags)
+{
+=09if (__builtin_constant_p(size)) {
+=09=09int i =3D 0;
+#define CACHE(x) \
+=09=09if (size <=3D x) \
+=09=09=09goto found; \
+=09=09else \
+=09=09=09i++;
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
+=09=09{
+=09=09=09extern void __you_cannot_kmalloc_that_much(void);
+=09=09=09__you_cannot_kmalloc_that_much();
+=09=09}
+found:
+=09=09return kmem_cache_alloc((flags & GFP_DMA) ?
+=09=09=09malloc_sizes[i].cs_dma_cache :
+=09=09=09malloc_sizes[i].cs_cache, flags);
+=09}
+=09return __kmalloc(size, flags);
+}
+
+extern void *kzalloc(size_t, gfp_t);
+
+/**
+ * kcalloc - allocate memory for an array. The memory is set to zero.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate.
+ */
+static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+{
+=09if (n !=3D 0 && size > INT_MAX / n)
+=09=09return NULL;
+=09return kzalloc(n * size, flags);
+}
+
+extern void kfree(const void *);
+extern unsigned int ksize(const void *);
+
+
+/*
+ *=09System wide caches
+ */
+
+extern struct kmem_cache *vm_area_cachep;
+extern struct kmem_cache *names_cachep;
+extern struct kmem_cache *files_cachep;
+extern struct kmem_cache *filp_cachep;
+extern struct kmem_cache *fs_cachep;
+extern struct kmem_cache *signal_cachep;
+extern struct kmem_cache *sighand_cachep;
+extern struct kmem_cache *bio_cachep;
+
+
+/*
+ * =09???
+ */
+
+extern atomic_t slab_reclaim_pages;
+
+#endif
Index: 2.6/mm/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.6.orig/mm/Makefile
+++ 2.6/mm/Makefile
@@ -9,7 +9,7 @@ mmu-$(CONFIG_MMU)=09:=3D fremap.o highmem.o=20
=20
 obj-y=09=09=09:=3D bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 =09=09=09   page_alloc.o page-writeback.o pdflush.o \
-=09=09=09   readahead.o slab.o swap.o truncate.o vmscan.o \
+=09=09=09   readahead.o kmem.o kmalloc.o swap.o truncate.o vmscan.o \
 =09=09=09   prio_tree.o $(mmu-y)
=20
 obj-$(CONFIG_SWAP)=09+=3D page_io.o swap_state.o swapfile.o thrash.o
Index: 2.6/test/include/stdlib.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/stdlib.h
@@ -0,0 +1,11 @@
+#ifndef __STDLIB_H
+#define __STDLIB_H
+
+#include <stddef.h>
+
+extern void *malloc(size_t);
+extern void *calloc(size_t, size_t);
+extern void free(void *);
+extern void *realloc(void *, size_t);
+
+#endif
Index: 2.6/test/mm/page_alloc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/mm/page_alloc.c
@@ -0,0 +1,44 @@
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/list.h>
+
+#include <asm/page.h>
+
+#include <stdlib.h>
+
+static LIST_HEAD(pages);
+
+struct page *__virt_to_page(unsigned long addr)
+{
+=09struct page *page;
+
+=09list_for_each_entry(page, &pages, memory_map) {
+=09=09unsigned long virtual =3D (unsigned long) page->virtual;
+
+=09=09if (virtual <=3D addr && addr < virtual+(1<<page->order)*PAGE_SIZE)
+=09=09=09return page;
+=09}
+=09return NULL;
+}
+
+struct page *alloc_pages(gfp_t flags, unsigned int order)
+{
+=09unsigned long nr_pages =3D 1<<order;
+=09struct page *page =3D malloc(sizeof(*page));
+=09memset(page, 0, sizeof(*page));
+=09page->order =3D order;
+=09page->virtual =3D calloc(nr_pages, PAGE_SIZE);
+=09INIT_LIST_HEAD(&page->memory_map);
+=09list_add(&page->memory_map, &pages);
+=09return page;
+}
+
+void free_pages(unsigned long addr, unsigned int order)
+{
+=09struct page *page =3D virt_to_page(addr);
+=09free(page->virtual);
+=09free(page);
+}
+
+
Index: 2.6/include/linux/slab.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.6.orig/include/linux/slab.h
+++ 2.6/include/linux/slab.h
@@ -1,151 +1,6 @@
-/*
- * linux/mm/slab.h
- * Written by Mark Hemment, 1996.
- * (markhe@nextd.demon.co.uk)
- */
-
 #ifndef _LINUX_SLAB_H
 #define=09_LINUX_SLAB_H
=20
-#if=09defined(__KERNEL__)
-
-typedef struct kmem_cache kmem_cache_t;
-
-#include=09<linux/config.h>=09/* kmalloc_sizes.h needs CONFIG_ options */
-#include=09<linux/gfp.h>
-#include=09<linux/init.h>
-#include=09<linux/types.h>
-#include=09<asm/page.h>=09=09/* kmalloc_sizes.h needs PAGE_SIZE */
-#include=09<asm/cache.h>=09=09/* kmalloc_sizes.h needs L1_CACHE_BYTES */
-
-/* flags for kmem_cache_alloc() */
-#define=09SLAB_NOFS=09=09GFP_NOFS
-#define=09SLAB_NOIO=09=09GFP_NOIO
-#define=09SLAB_ATOMIC=09=09GFP_ATOMIC
-#define=09SLAB_USER=09=09GFP_USER
-#define=09SLAB_KERNEL=09=09GFP_KERNEL
-#define=09SLAB_DMA=09=09GFP_DMA
-
-#define SLAB_LEVEL_MASK=09=09GFP_LEVEL_MASK
-
-#define=09SLAB_NO_GROW=09=09__GFP_NO_GROW=09/* don't grow a cache */
-
-/* flags to pass to kmem_cache_create().
- * The first 3 are only valid when the allocator as been build
- * SLAB_DEBUG_SUPPORT.
- */
-#define=09SLAB_DEBUG_FREE=09=090x00000100UL=09/* Peform (expensive) checks=
 on free */
-#define=09SLAB_DEBUG_INITIAL=090x00000200UL=09/* Call constructor (as veri=
fier) */
-#define=09SLAB_RED_ZONE=09=090x00000400UL=09/* Red zone objs in a cache */
-#define=09SLAB_POISON=09=090x00000800UL=09/* Poison objects */
-#define=09SLAB_NO_REAP=09=090x00001000UL=09/* never reap from the cache */
-#define=09SLAB_HWCACHE_ALIGN=090x00002000UL=09/* align objs on a h/w cache=
 lines */
-#define SLAB_CACHE_DMA=09=090x00004000UL=09/* use GFP_DMA memory */
-#define SLAB_MUST_HWCACHE_ALIGN=090x00008000UL=09/* force alignment */
-#define SLAB_STORE_USER=09=090x00010000UL=09/* store the last owner for bu=
g hunting */
-#define SLAB_RECLAIM_ACCOUNT=090x00020000UL=09/* track pages allocated to =
indicate
-=09=09=09=09=09=09   what is reclaimable later*/
-#define SLAB_PANIC=09=090x00040000UL=09/* panic if kmem_cache_create() fai=
ls */
-#define SLAB_DESTROY_BY_RCU=090x00080000UL=09/* defer freeing pages to RCU=
 */
-
-/* flags passed to a constructor func */
-#define=09SLAB_CTOR_CONSTRUCTOR=090x001UL=09=09/* if not set, then deconst=
ructor */
-#define SLAB_CTOR_ATOMIC=090x002UL=09=09/* tell constructor it can't sleep=
 */
-#define=09SLAB_CTOR_VERIFY=090x004UL=09=09/* tell constructor it's a verif=
y call */
-
-/* prototypes */
-extern void __init kmem_cache_init(void);
-
-extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsig=
ned long,
-=09=09=09=09       void (*)(void *, kmem_cache_t *, unsigned long),
-=09=09=09=09       void (*)(void *, kmem_cache_t *, unsigned long));
-extern int kmem_cache_destroy(kmem_cache_t *);
-extern int kmem_cache_shrink(kmem_cache_t *);
-extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
-extern void kmem_cache_free(kmem_cache_t *, void *);
-extern unsigned int kmem_cache_size(kmem_cache_t *);
-extern const char *kmem_cache_name(kmem_cache_t *);
-extern kmem_cache_t *kmem_find_general_cachep(size_t size, gfp_t gfpflags)=
;
-
-/* Size description struct for general caches. */
-struct cache_sizes {
-=09size_t=09=09 cs_size;
-=09kmem_cache_t=09*cs_cachep;
-=09kmem_cache_t=09*cs_dmacachep;
-};
-extern struct cache_sizes malloc_sizes[];
-extern void *__kmalloc(size_t, gfp_t);
-
-static inline void *kmalloc(size_t size, gfp_t flags)
-{
-=09if (__builtin_constant_p(size)) {
-=09=09int i =3D 0;
-#define CACHE(x) \
-=09=09if (size <=3D x) \
-=09=09=09goto found; \
-=09=09else \
-=09=09=09i++;
-#include "kmalloc_sizes.h"
-#undef CACHE
-=09=09{
-=09=09=09extern void __you_cannot_kmalloc_that_much(void);
-=09=09=09__you_cannot_kmalloc_that_much();
-=09=09}
-found:
-=09=09return kmem_cache_alloc((flags & GFP_DMA) ?
-=09=09=09malloc_sizes[i].cs_dmacachep :
-=09=09=09malloc_sizes[i].cs_cachep, flags);
-=09}
-=09return __kmalloc(size, flags);
-}
-
-extern void *kzalloc(size_t, gfp_t);
-
-/**
- * kcalloc - allocate memory for an array. The memory is set to zero.
- * @n: number of elements.
- * @size: element size.
- * @flags: the type of memory to allocate.
- */
-static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
-{
-=09if (n !=3D 0 && size > INT_MAX / n)
-=09=09return NULL;
-=09return kzalloc(n * size, flags);
-}
-
-extern void kfree(const void *);
-extern unsigned int ksize(const void *);
-
-#ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
-extern void *kmalloc_node(size_t size, gfp_t flags, int node);
-#else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flag=
s, int node)
-{
-=09return kmem_cache_alloc(cachep, flags);
-}
-static inline void *kmalloc_node(size_t size, gfp_t flags, int node)
-{
-=09return kmalloc(size, flags);
-}
-#endif
-
-extern int FASTCALL(kmem_cache_reap(int));
-extern int FASTCALL(kmem_ptr_validate(kmem_cache_t *cachep, void *ptr));
-
-/* System wide caches */
-extern kmem_cache_t=09*vm_area_cachep;
-extern kmem_cache_t=09*names_cachep;
-extern kmem_cache_t=09*files_cachep;
-extern kmem_cache_t=09*filp_cachep;
-extern kmem_cache_t=09*fs_cachep;
-extern kmem_cache_t=09*signal_cachep;
-extern kmem_cache_t=09*sighand_cachep;
-extern kmem_cache_t=09*bio_cachep;
-
-extern atomic_t slab_reclaim_pages;
-
-#endif=09/* __KERNEL__ */
+#include <linux/kmem.h>
=20
 #endif=09/* _LINUX_SLAB_H */
Index: 2.6/test/include/asm/page.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/page.h
@@ -0,0 +1,15 @@
+#ifndef __LINUX_PAGE_H
+#define __LINUX_PAGE_H
+
+#include <linux/mm.h>
+
+#define PAGE_OFFSET 0
+#define PAGE_SHIFT 12
+#define PAGE_SIZE 4096
+#define PAGE_MASK    (~(PAGE_SIZE-1))
+
+#define virt_to_page(addr) __virt_to_page((unsigned long) addr)
+
+extern struct page *__virt_to_page(unsigned long);
+
+#endif
Index: 2.6/test/include/linux/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/spinlock.h
@@ -0,0 +1,14 @@
+#ifndef __LINUX_SPINLOCK_H
+#define __LINUX_SPINLOCK_H
+
+#include <asm/atomic.h>
+
+typedef int spinlock_t;
+
+#define spin_lock_init(x)
+#define spin_lock_irqsave(x, y) (y =3D 1)
+#define spin_unlock_irqrestore(x, y) (y =3D 0)
+#define spin_lock(x)
+#define spin_unlock(x)
+
+#endif
Index: 2.6/test/include/linux/mmzone.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/mmzone.h
@@ -0,0 +1,8 @@
+#ifndef __LINUX_MMZONE_H
+#define __LINUX_MMZONE_H
+
+#include <linux/threads.h>
+
+#define MAX_ORDER 11
+
+#endif
Index: 2.6/test/include/linux/threads.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/threads.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_THREADS_H
+#define __LINUX_THREADS_H
+
+#define NR_CPUS 1
+
+#endif
Index: 2.6/test/include/linux/module.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/module.h
@@ -0,0 +1,7 @@
+#ifndef __LINUX_MODULE_H
+#define __LINUX_MODULE_H
+
+#define EXPORT_SYMBOL(x)
+#define EXPORT_SYMBOL_GPL(x)
+
+#endif
Index: 2.6/test/kernel/panic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/kernel/panic.c
@@ -0,0 +1,6 @@
+extern void abort(void);
+
+void panic(const char * fmt, ...)
+{
+=09abort();
+}
Index: 2.6/test/include/asm/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/pgtable.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_PGTABLE_H
+#define __ASM_PGTABLE_H
+
+#define kern_addr_valid(addr)    (1)
+
+#endif
Index: 2.6/test/include/asm/semaphore.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/semaphore.h
@@ -0,0 +1,24 @@
+#ifndef __ASM_SEMAPHORE_H
+#define __ASM_SEMAPHORE_H
+
+struct semaphore {
+};
+
+static inline void init_MUTEX(struct semaphore *sem)
+{
+}
+
+static inline void up(struct semaphore *sem)
+{
+}
+
+static inline void down(struct semaphore *sem)
+{
+}
+
+static inline int down_trylock(struct semaphore *sem)
+{
+=09return 1;
+}
+
+#endif
Index: 2.6/test/include/asm/uaccess.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/uaccess.h
@@ -0,0 +1,4 @@
+#ifndef __ASM_UACCESS_H
+#define __ASM_UACCESS_H
+
+#endif
Index: 2.6/test/include/linux/config.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/config.h
@@ -0,0 +1,8 @@
+#ifndef __LINUX_CONFIG_H
+#define __LINUX_CONFIG_H
+
+#include <linux/autoconf.h>
+
+#undef CONFIG_PROC_FS
+
+#endif
Index: 2.6/test/include/linux/seq_file.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/seq_file.h
@@ -0,0 +1,4 @@
+#ifndef __LINUX_SEQFILE_H
+#define __LINUX_SEQFILE_H
+
+#endif
Index: 2.6/test/include/asm/param.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/param.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_PARAM_H
+#define __ASM_PARAM_H
+
+#define HZ 100
+
+#endif
Index: 2.6/test/include/asm/percpu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/percpu.h
@@ -0,0 +1,6 @@
+#ifndef __ARCH_I386_PERCPU__
+#define __ARCH_I386_PERCPU__
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ARCH_I386_PERCPU__ */
Index: 2.6/test/include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/linux/sched.h
@@ -0,0 +1,7 @@
+#ifndef __LINUX_SCHED_H
+#define __LINUX_SCHED_H
+
+#include <linux/cpumask.h>
+#include <asm/param.h>
+
+#endif
Index: 2.6/test/kernel/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/kernel/timer.c
@@ -0,0 +1,5 @@
+#include <linux/timer.h>
+
+void fastcall init_timer(struct timer_list *timer)
+{
+}
Index: 2.6/test/kernel/workqueue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/kernel/workqueue.c
@@ -0,0 +1,17 @@
+#include <linux/workqueue.h>
+
+int keventd_up(void)
+{
+=09return 1;
+}
+
+int fastcall schedule_delayed_work(struct work_struct *work, unsigned long=
 delay)
+{
+=09return 1;
+}
+
+int schedule_delayed_work_on(int cpu,
+=09=09=09struct work_struct *work, unsigned long delay)
+{
+=09return 1;
+}
Index: 2.6/test/include/asm/thread_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ 2.6/test/include/asm/thread_info.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_THREADINFO_H
+#define __ASM_THREADINFO_H
+
+#include <linux/config.h>
+#include <linux/compiler.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+
+struct thread_info {
+=09unsigned long flags;
+};
+
+#endif




------=_Part_14378_33440897.1135109747843--
