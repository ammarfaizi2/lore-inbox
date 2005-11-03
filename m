Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVKCXGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVKCXGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVKCXGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:06:12 -0500
Received: from waste.org ([216.27.176.166]:46815 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751029AbVKCXGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:06:10 -0500
Date: Thu, 3 Nov 2005 17:00:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <2.505517440@selenic.com>
Message-Id: <3.505517440@selenic.com>
Subject: [PATCH 2/2] slob: introduce the SLOB allocator
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

configurable replacement for slab allocator

This adds a CONFIG_SLAB option under CONFIG_EMBEDDED. When CONFIG_SLAB
is disabled, the kernel falls back to using the 'SLOB' allocator.

SLOB is a traditional K&R/UNIX allocator with a SLAB emulation layer,
similar to the original Linux kmalloc allocator that SLAB replaced.
It's signicantly smaller code and is more memory efficient. But like
all similar allocators, it scales poorly and suffers from
fragmentation more than SLAB, so it's only appropriate for small
systems.

It's been tested extensively in the Linux-tiny tree. I've also
stress-tested it with make -j 8 compiles on a 3G SMP+PREEMPT box (not
recommended).

Here's a comparison for otherwise identical builds, showing SLOB
saving nearly half a megabyte of RAM:

$ size vmlinux*
   text    data     bss     dec     hex filename
3336372  529360  190812 4056544  3de5e0 vmlinux-slab
3323208  527948  190684 4041840  3dac70 vmlinux-slob

$ size mm/{slab,slob}.o
   text    data     bss     dec     hex filename
  13221     752      48   14021    36c5 mm/slab.o
   1896      52       8    1956     7a4 mm/slob.o

/proc/meminfo:
                  SLAB          SLOB      delta
MemTotal:        27964 kB      27980 kB     +16 kB
MemFree:         24596 kB      25092 kB    +496 kB
Buffers:            36 kB         36 kB       0 kB
Cached:           1188 kB       1188 kB       0 kB
SwapCached:          0 kB          0 kB       0 kB
Active:            608 kB        600 kB      -8 kB
Inactive:          808 kB        812 kB      +4 kB
HighTotal:           0 kB          0 kB       0 kB
HighFree:            0 kB          0 kB       0 kB
LowTotal:        27964 kB      27980 kB     +16 kB
LowFree:         24596 kB      25092 kB    +496 kB
SwapTotal:           0 kB          0 kB       0 kB
SwapFree:            0 kB          0 kB       0 kB
Dirty:               4 kB         12 kB      +8 kB
Writeback:           0 kB          0 kB       0 kB
Mapped:            560 kB        556 kB      -4 kB
Slab:             1756 kB          0 kB   -1756 kB
CommitLimit:     13980 kB      13988 kB      +8 kB
Committed_AS:     4208 kB       4208 kB       0 kB
PageTables:         28 kB         28 kB       0 kB
VmallocTotal:  1007312 kB    1007312 kB       0 kB
VmallocUsed:        48 kB         48 kB       0 kB
VmallocChunk:  1007264 kB    1007264 kB       0 kB

(this work has been sponsored in part by CELF)

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-slob/mm/slob.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.14-slob/mm/slob.c	2005-11-03 14:55:45.000000000 -0800
@@ -0,0 +1,385 @@
+/*
+ * SLOB Allocator: Simple List Of Blocks
+ *
+ * Matt Mackall <mpm@selenic.com> 12/30/03
+ *
+ * How SLOB works:
+ *
+ * The core of SLOB is a traditional K&R style heap allocator, with
+ * support for returning aligned objects. The granularity of this
+ * allocator is 8 bytes on x86, though it's perhaps possible to reduce
+ * this to 4 if it's deemed worth the effort. The slob heap is a
+ * singly-linked list of pages from __get_free_page, grown on demand
+ * and allocation from the heap is currently first-fit.
+ *
+ * Above this is an implementation of kmalloc/kfree. Blocks returned
+ * from kmalloc are 8-byte aligned and prepended with a 8-byte header.
+ * If kmalloc is asked for objects of PAGE_SIZE or larger, it calls
+ * __get_free_pages directly so that it can return page-aligned blocks
+ * and keeps a linked list of such pages and their orders. These
+ * objects are detected in kfree() by their page alignment.
+ *
+ * SLAB is emulated on top of SLOB by simply calling constructors and
+ * destructors for every SLAB allocation. Objects are returned with
+ * the 8-byte alignment unless the SLAB_MUST_HWCACHE_ALIGN flag is
+ * set, in which case the low-level allocator will fragment blocks to
+ * create the proper alignment. Again, objects of page-size or greater
+ * are allocated by calling __get_free_pages. As SLAB objects know
+ * their size, no separate size bookkeeping is necessary and there is
+ * essentially no allocation space overhead.
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/cache.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+
+struct slob_block {
+	int units;
+	struct slob_block *next;
+};
+typedef struct slob_block slob_t;
+
+#define SLOB_UNIT sizeof(slob_t)
+#define SLOB_UNITS(size) (((size) + SLOB_UNIT - 1)/SLOB_UNIT)
+#define SLOB_ALIGN L1_CACHE_BYTES
+
+struct bigblock {
+	int order;
+	void *pages;
+	struct bigblock *next;
+};
+typedef struct bigblock bigblock_t;
+
+static slob_t arena = { .next = &arena, .units = 1 };
+static slob_t *slobfree = &arena;
+static bigblock_t *bigblocks;
+static DEFINE_SPINLOCK(slob_lock);
+static DEFINE_SPINLOCK(block_lock);
+
+static void slob_free(void *b, int size);
+
+static void *slob_alloc(size_t size, gfp_t gfp, int align)
+{
+	slob_t *prev, *cur, *aligned = 0;
+	int delta = 0, units = SLOB_UNITS(size);
+	unsigned long flags;
+
+	spin_lock_irqsave(&slob_lock, flags);
+	prev = slobfree;
+	for (cur = prev->next; ; prev = cur, cur = cur->next) {
+		if (align) {
+			aligned = (slob_t *)ALIGN((unsigned long)cur, align);
+			delta = aligned - cur;
+		}
+		if (cur->units >= units + delta) { /* room enough? */
+			if (delta) { /* need to fragment head to align? */
+				aligned->units = cur->units - delta;
+				aligned->next = cur->next;
+				cur->next = aligned;
+				cur->units = delta;
+				prev = cur;
+				cur = aligned;
+			}
+
+			if (cur->units == units) /* exact fit? */
+				prev->next = cur->next; /* unlink */
+			else { /* fragment */
+				prev->next = cur + units;
+				prev->next->units = cur->units - units;
+				prev->next->next = cur->next;
+				cur->units = units;
+			}
+
+			slobfree = prev;
+			spin_unlock_irqrestore(&slob_lock, flags);
+			return cur;
+		}
+		if (cur == slobfree) {
+			spin_unlock_irqrestore(&slob_lock, flags);
+
+			if (size == PAGE_SIZE) /* trying to shrink arena? */
+				return 0;
+
+			cur = (slob_t *)__get_free_page(gfp);
+			if (!cur)
+				return 0;
+
+			slob_free(cur, PAGE_SIZE);
+			spin_lock_irqsave(&slob_lock, flags);
+			cur = slobfree;
+		}
+	}
+}
+
+static void slob_free(void *block, int size)
+{
+	slob_t *cur, *b = (slob_t *)block;
+	unsigned long flags;
+
+	if (!block)
+		return;
+
+	if (size)
+		b->units = SLOB_UNITS(size);
+
+	/* Find reinsertion point */
+	spin_lock_irqsave(&slob_lock, flags);
+	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
+		if (cur >= cur->next && (b > cur || b < cur->next))
+			break;
+
+	if (b + b->units == cur->next) {
+		b->units += cur->next->units;
+		b->next = cur->next->next;
+	} else
+		b->next = cur->next;
+
+	if (cur + cur->units == b) {
+		cur->units += b->units;
+		cur->next = b->next;
+	} else
+		cur->next = b;
+
+	slobfree = cur;
+
+	spin_unlock_irqrestore(&slob_lock, flags);
+}
+
+static int FASTCALL(find_order(int size));
+static int fastcall find_order(int size)
+{
+	int order = 0;
+	for ( ; size > 4096 ; size >>=1)
+		order++;
+	return order;
+}
+
+void *kmalloc(size_t size, gfp_t gfp)
+{
+	slob_t *m;
+	bigblock_t *bb;
+	unsigned long flags;
+
+	if (size < PAGE_SIZE - SLOB_UNIT) {
+		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
+		return m ? (void *)(m + 1) : 0;
+	}
+
+	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
+	if (!bb)
+		return 0;
+
+	bb->order = find_order(size);
+	bb->pages = (void *)__get_free_pages(gfp, bb->order);
+
+	if (bb->pages) {
+		spin_lock_irqsave(&block_lock, flags);
+		bb->next = bigblocks;
+		bigblocks = bb;
+		spin_unlock_irqrestore(&block_lock, flags);
+		return bb->pages;
+	}
+
+	slob_free(bb, sizeof(bigblock_t));
+	return 0;
+}
+
+EXPORT_SYMBOL(kmalloc);
+
+void kfree(const void *block)
+{
+	bigblock_t *bb, **last = &bigblocks;
+	unsigned long flags;
+
+	if (!block)
+		return;
+
+	if (!((unsigned int)block & (PAGE_SIZE-1))) {
+		/* might be on the big block list */
+		spin_lock_irqsave(&block_lock, flags);
+		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
+			if (bb->pages == block) {
+				*last = bb->next;
+				spin_unlock_irqrestore(&block_lock, flags);
+				free_pages((unsigned long)block, bb->order);
+				slob_free(bb, sizeof(bigblock_t));
+				return;
+			}
+		}
+		spin_unlock_irqrestore(&block_lock, flags);
+	}
+
+	slob_free((slob_t *)block - 1, 0);
+	return;
+}
+
+EXPORT_SYMBOL(kfree);
+
+unsigned int ksize(const void *block)
+{
+	bigblock_t *bb;
+	unsigned long flags;
+
+	if (!block)
+		return 0;
+
+	if (!((unsigned int)block & (PAGE_SIZE-1))) {
+		spin_lock_irqsave(&block_lock, flags);
+		for (bb = bigblocks; bb; bb = bb->next)
+			if (bb->pages == block) {
+				spin_unlock_irqrestore(&slob_lock, flags);
+				return PAGE_SIZE << bb->order;
+			}
+		spin_unlock_irqrestore(&block_lock, flags);
+	}
+
+	return ((slob_t *)block - 1)->units * SLOB_UNIT;
+}
+
+struct kmem_cache_s {
+	unsigned int size, align;
+	const char *name;
+	void (*ctor)(void *, kmem_cache_t *, unsigned long);
+	void (*dtor)(void *, kmem_cache_t *, unsigned long);
+};
+
+kmem_cache_t *kmem_cache_create(const char *name, size_t size, size_t align,
+	unsigned long flags,
+	void (*ctor)(void*, kmem_cache_t *, unsigned long),
+	void (*dtor)(void*, kmem_cache_t *, unsigned long))
+{
+	kmem_cache_t *c;
+
+	c = slob_alloc(sizeof(kmem_cache_t), flags, 0);
+
+	if (c) {
+		c->name = name;
+		c->size = size;
+		c->ctor = ctor;
+		c->dtor = dtor;
+		/* ignore alignment unless it's forced */
+		c->align = (flags & SLAB_MUST_HWCACHE_ALIGN) ? SLOB_ALIGN : 0;
+		if (c->align < align)
+			c->align = align;
+	}
+
+	return c;
+}
+EXPORT_SYMBOL(kmem_cache_create);
+
+int kmem_cache_destroy(kmem_cache_t *c)
+{
+	slob_free(c, sizeof(kmem_cache_t));
+	return 0;
+}
+EXPORT_SYMBOL(kmem_cache_destroy);
+
+void *kmem_cache_alloc(kmem_cache_t *c, gfp_t flags)
+{
+	void *b;
+
+	if (c->size < PAGE_SIZE)
+		b = slob_alloc(c->size, flags, c->align);
+	else
+		b = (void *)__get_free_pages(flags, find_order(c->size));
+
+	if (c->ctor)
+		c->ctor(b, c, SLAB_CTOR_CONSTRUCTOR);
+
+	return b;
+}
+EXPORT_SYMBOL(kmem_cache_alloc);
+
+void kmem_cache_free(kmem_cache_t *c, void *b)
+{
+	if (c->dtor)
+		c->dtor(b, c, 0);
+
+	if (c->size < PAGE_SIZE)
+		slob_free(b, c->size);
+	else
+		free_pages((unsigned long)b, find_order(c->size));
+}
+EXPORT_SYMBOL(kmem_cache_free);
+
+unsigned int kmem_cache_size(kmem_cache_t *c)
+{
+	return c->size;
+}
+EXPORT_SYMBOL(kmem_cache_size);
+
+const char *kmem_cache_name(kmem_cache_t *c)
+{
+	return c->name;
+}
+EXPORT_SYMBOL(kmem_cache_name);
+
+static struct timer_list slob_timer = TIMER_INITIALIZER(
+	(void (*)(unsigned long))kmem_cache_init, 0, 0);
+
+void kmem_cache_init(void)
+{
+	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
+
+	if (p)
+		free_page((unsigned int)p);
+
+	mod_timer(&slob_timer, jiffies + HZ);
+}
+
+atomic_t slab_reclaim_pages = ATOMIC_INIT(0);
+EXPORT_SYMBOL(slab_reclaim_pages);
+
+#ifdef CONFIG_SMP
+
+void *__alloc_percpu(size_t size, size_t align)
+{
+	int i;
+	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
+
+	if (!pdata)
+		return NULL;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
+		if (!pdata->ptrs[i])
+			goto unwind_oom;
+		memset(pdata->ptrs[i], 0, size);
+	}
+
+	/* Catch derefs w/o wrappers */
+	return (void *) (~(unsigned long) pdata);
+
+unwind_oom:
+	while (--i >= 0) {
+		if (!cpu_possible(i))
+			continue;
+		kfree(pdata->ptrs[i]);
+	}
+	kfree(pdata);
+	return NULL;
+}
+EXPORT_SYMBOL(__alloc_percpu);
+
+void
+free_percpu(const void *objp)
+{
+	int i;
+	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		kfree(p->ptrs[i]);
+	}
+	kfree(p);
+}
+EXPORT_SYMBOL(free_percpu);
+
+#endif
Index: 2.6.14-slob/mm/Makefile
===================================================================
--- 2.6.14-slob.orig/mm/Makefile	2005-11-03 14:48:17.000000000 -0800
+++ 2.6.14-slob/mm/Makefile	2005-11-03 14:54:22.000000000 -0800
@@ -9,7 +9,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
-			   readahead.o slab.o swap.o truncate.o vmscan.o \
+			   readahead.o swap.o truncate.o vmscan.o \
 			   prio_tree.o util.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
@@ -18,5 +18,7 @@ obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+obj-$(CONFIG_SLOB) += slob.o
+obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
Index: 2.6.14-slob/include/linux/slab.h
===================================================================
--- 2.6.14-slob.orig/include/linux/slab.h	2005-11-03 14:40:31.000000000 -0800
+++ 2.6.14-slob/include/linux/slab.h	2005-11-03 14:53:53.000000000 -0800
@@ -53,6 +53,8 @@ typedef struct kmem_cache_s kmem_cache_t
 #define SLAB_CTOR_ATOMIC	0x002UL		/* tell constructor it can't sleep */
 #define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */
 
+#ifndef CONFIG_SLOB
+
 /* prototypes */
 extern void __init kmem_cache_init(void);
 
@@ -134,6 +136,38 @@ static inline void *kmalloc_node(size_t 
 extern int FASTCALL(kmem_cache_reap(int));
 extern int FASTCALL(kmem_ptr_validate(kmem_cache_t *cachep, void *ptr));
 
+#else /* CONFIG_SLOB */
+
+/* SLOB allocator routines */
+
+void kmem_cache_init(void);
+kmem_cache_t *kmem_find_general_cachep(size_t, gfp_t gfpflags);
+kmem_cache_t *kmem_cache_create(const char *c, size_t, size_t, unsigned long,
+	void (*)(void *, kmem_cache_t *, unsigned long),
+	void (*)(void *, kmem_cache_t *, unsigned long));
+int kmem_cache_destroy(kmem_cache_t *c);
+void *kmem_cache_alloc(kmem_cache_t *c, gfp_t flags);
+void kmem_cache_free(kmem_cache_t *c, void *b);
+const char *kmem_cache_name(kmem_cache_t *);
+void *kmalloc(size_t size, gfp_t flags);
+void *kzalloc(size_t size, gfp_t flags);
+void kfree(const void *m);
+unsigned int ksize(const void *m);
+unsigned int kmem_cache_size(kmem_cache_t *c);
+
+static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return kzalloc(n * size, flags);
+}
+
+#define kmem_cache_shrink(d) (0)
+#define kmem_cache_reap(a)
+#define kmem_ptr_validate(a, b) (0)
+#define kmem_cache_alloc_node(c, f, n) kmem_cache_alloc(c, f)
+#define kmalloc_node(s, f, n) kmalloc(s, f)
+
+#endif /* CONFIG_SLOB */
+
 /* System wide caches */
 extern kmem_cache_t	*vm_area_cachep;
 extern kmem_cache_t	*names_cachep;
Index: 2.6.14-slob/init/Kconfig
===================================================================
--- 2.6.14-slob.orig/init/Kconfig	2005-11-03 14:40:31.000000000 -0800
+++ 2.6.14-slob/init/Kconfig	2005-11-03 14:53:53.000000000 -0800
@@ -398,6 +398,15 @@ config CC_ALIGN_JUMPS
 	  no dummy operations need be executed.
 	  Zero means use compiler's default.
 
+config SLAB
+	default y
+	bool "Use full SLAB allocator" if EMBEDDED
+	help
+	  Disabling this replaces the advanced SLAB allocator and
+	  kmalloc support with the drastically simpler SLOB allocator.
+	  SLOB is more space efficient but does not scale well and is
+	  more susceptible to fragmentation.
+
 endmenu		# General setup
 
 config TINY_SHMEM
@@ -409,6 +418,10 @@ config BASE_SMALL
 	default 0 if BASE_FULL
 	default 1 if !BASE_FULL
 
+config SLOB
+	default !SLAB
+	bool
+
 menu "Loadable module support"
 
 config MODULES
Index: 2.6.14-slob/fs/proc/proc_misc.c
===================================================================
--- 2.6.14-slob.orig/fs/proc/proc_misc.c	2005-11-03 14:40:31.000000000 -0800
+++ 2.6.14-slob/fs/proc/proc_misc.c	2005-11-03 14:53:53.000000000 -0800
@@ -323,6 +323,7 @@ static struct file_operations proc_modul
 };
 #endif
 
+#ifdef CONFIG_SLAB
 extern struct seq_operations slabinfo_op;
 extern ssize_t slabinfo_write(struct file *, const char __user *, size_t, loff_t *);
 static int slabinfo_open(struct inode *inode, struct file *file)
@@ -336,6 +337,7 @@ static struct file_operations proc_slabi
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
+#endif
 
 static int show_stat(struct seq_file *p, void *v)
 {
@@ -600,7 +602,9 @@ void __init proc_misc_init(void)
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
+#ifdef CONFIG_SLAB
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+#endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("zoneinfo",S_IRUGO, &proc_zoneinfo_file_operations);
