Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbSLDMKQ>; Wed, 4 Dec 2002 07:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbSLDMKQ>; Wed, 4 Dec 2002 07:10:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:15749 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266435AbSLDMKI>; Wed, 4 Dec 2002 07:10:08 -0500
Date: Wed, 4 Dec 2002 17:45:50 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Rusty Russell <rusty@rustcorp.com.au>,
       dipankar@in.ibm.com
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021204174550.B17375@in.ibm.com>
References: <20021204174209.A17375@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021204174209.A17375@in.ibm.com>; from kiran@in.ibm.com on Wed, Dec 04, 2002 at 05:42:09PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a 2.5.50 version of kmalloc_percpu originally submitted by Dipankar.
This one incorporates Rusty's suggestions to rearrange code and sync
up with its static counterpart. This version needs exposure of malloc_sizes
in order to move the interfaces to percpu.c from slab.c (kmalloc_percpu and
kfree_percpu donot have anything to do with the slab allocator itself).
First of the two patches is to expose the malloc_sizes and the second
one is the actual allocator.  I'll follow this up with patchsets to enable
networking mibs use kmalloc_percpu. We'll have to use kmalloc_percpu
for mibs since DEFINE_PER_CPU won't work with modules (and ipv6 stuff
can be compiled in as modules)
 
Following is the 2 of 2 patches.
 
D: Name: kmalloc_percpu-2.5.50-1.patch
D: Description: Dynamic per-cpu kernel memory allocator
D: Author: Dipankar Sarma & Ravikiran Thirumalai


 include/linux/percpu.h |   39 ++++
 init/main.c            |    1 
 kernel/Makefile        |    4 
 kernel/ksyms.c         |    4 
 kernel/percpu.c        |  452 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 498 insertions(+), 2 deletions(-)


diff -ruN linux-2.5.50/include/linux/percpu.h kmalloc_percpu-2.5.50/include/linux/percpu.h
--- linux-2.5.50/include/linux/percpu.h	Thu Nov 28 04:06:19 2002
+++ kmalloc_percpu-2.5.50/include/linux/percpu.h	Sun Dec  1 11:54:49 2002
@@ -1,10 +1,49 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
 #include <linux/spinlock.h> /* For preempt_disable() */
+#include <linux/slab.h> /* For kmalloc_percpu() */
 #include <asm/percpu.h>
 
 /* Must be an lvalue. */
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
+#ifdef CONFIG_SMP
+
+struct percpu_data {
+	void *ptrs[NR_CPUS];
+	void *blkp;
+};
+
+/* Use this with kmalloc_percpu */
+#define per_cpu_ptr(ptr, cpu)                   \
+({                                              \
+        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
+        (__typeof__(ptr))__p->ptrs[(cpu)];	\
+})
+
+extern void *kmalloc_percpu(size_t size, int flags);
+extern void kfree_percpu(const void *);
+extern void kmalloc_percpu_init(void);
+
+#else /* CONFIG_SMP */
+
+#define per_cpu_ptr(ptr, cpu) (ptr)
+
+static inline void *kmalloc_percpu(size_t size, int flags)
+{
+	return(kmalloc(size, flags));
+}
+static inline void kfree_percpu(const void *ptr)
+{	
+	kfree(ptr);
+}
+static inline void kmalloc_percpu_init(void) { }
+
+#endif /* CONFIG_SMP */
+
+/* Use these with kmalloc_percpu */
+#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
+#define put_cpu_ptr(ptr) put_cpu()
+
 #endif /* __LINUX_PERCPU_H */
diff -ruN linux-2.5.50/init/main.c kmalloc_percpu-2.5.50/init/main.c
--- linux-2.5.50/init/main.c	Thu Nov 28 04:05:51 2002
+++ kmalloc_percpu-2.5.50/init/main.c	Sun Dec  1 11:54:49 2002
@@ -423,6 +423,7 @@
 	page_address_init();
 	mem_init();
 	kmem_cache_sizes_init();
+	kmalloc_percpu_init();
 	pidhash_init();
 	pgtable_cache_init();
 	pte_chain_init();
diff -ruN linux-2.5.50/kernel/Makefile kmalloc_percpu-2.5.50/kernel/Makefile
--- linux-2.5.50/kernel/Makefile	Thu Nov 28 04:05:51 2002
+++ kmalloc_percpu-2.5.50/kernel/Makefile	Sun Dec  1 11:54:49 2002
@@ -4,7 +4,7 @@
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
 		printk.o platform.o suspend.o dma.o module.o cpufreq.o \
-		profile.o rcupdate.o intermodule.o
+		profile.o rcupdate.o intermodule.o percpu.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
@@ -13,7 +13,7 @@
 	    rcupdate.o intermodule.o extable.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-obj-$(CONFIG_SMP) += cpu.o
+obj-$(CONFIG_SMP) += cpu.o percpu.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff -ruN linux-2.5.50/kernel/ksyms.c kmalloc_percpu-2.5.50/kernel/ksyms.c
--- linux-2.5.50/kernel/ksyms.c	Thu Nov 28 04:05:47 2002
+++ kmalloc_percpu-2.5.50/kernel/ksyms.c	Sun Dec  1 11:54:49 2002
@@ -97,6 +97,10 @@
 EXPORT_SYMBOL(remove_shrinker);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(kmalloc_percpu);
+EXPORT_SYMBOL(kfree_percpu);
+#endif
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
 EXPORT_SYMBOL(vmalloc);
diff -ruN linux-2.5.50/kernel/percpu.c kmalloc_percpu-2.5.50/kernel/percpu.c
--- linux-2.5.50/kernel/percpu.c	Thu Jan  1 05:30:00 1970
+++ kmalloc_percpu-2.5.50/kernel/percpu.c	Sun Dec  1 11:54:49 2002
@@ -0,0 +1,452 @@
+/*
+ * Dynamic Per-CPU Data Allocator.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (c) IBM Corporation, 2002
+ *
+ * Author:              Dipankar Sarma <dipankar@in.ibm.com>
+ * 			Ravikiran G. Thirumalai <kiran@in.ibm.com>
+ *
+ */
+
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cache.h>
+
+struct percpu_data_blklist {
+	struct list_head blks;
+	struct list_head *firstnotfull;
+	spinlock_t lock;
+	size_t objsize;
+	size_t blksize;
+	kmem_cache_t *cachep;
+	char *cachename;
+};
+
+struct percpu_data_blk {
+	struct list_head linkage;
+	void *blkaddr[NR_CPUS];
+	unsigned int usecount;
+	int *freearr;
+	int freehead;
+	struct percpu_data_blklist *blklist;
+};
+
+static struct percpu_data_blklist data_blklist[] = {
+	{
+	 .blks = LIST_HEAD_INIT(data_blklist[0].blks),
+	 .firstnotfull = &data_blklist[0].blks,
+	 .lock = SPIN_LOCK_UNLOCKED,
+	 .objsize = 4,
+	 .blksize = ALIGN(4, SMP_CACHE_BYTES),
+	 .cachep = NULL,
+	 .cachename = "percpu_data_4"},
+	{
+	 .blks = LIST_HEAD_INIT(data_blklist[1].blks),
+	 .firstnotfull = &data_blklist[1].blks,
+	 .lock = SPIN_LOCK_UNLOCKED,
+	 .objsize = 8,
+	 .blksize = ALIGN(8, SMP_CACHE_BYTES),
+	 .cachep = NULL,
+	 .cachename = "percpu_data_8"},
+	{
+	 .blks = LIST_HEAD_INIT(data_blklist[2].blks),
+	 .firstnotfull = &data_blklist[2].blks,
+	 .lock = SPIN_LOCK_UNLOCKED,
+	 .objsize = 16,
+	 .blksize = ALIGN(16, SMP_CACHE_BYTES),
+	 .cachep = NULL,
+	 .cachename = "percpu_data_16"},
+#if PAGE_SIZE != 4096
+	{
+	 .blks = LIST_HEAD_INIT(data_blklist[3].blks),
+	 .firstnotfull = &data_blklist[3].blks,
+	 .lock = SPIN_LOCK_UNLOCKED,
+	 .objsize = 32,
+	 .blksize = ALIGN(32, SMP_CACHE_BYTES),
+	 .cachep = NULL,
+	 .cachename = "percpu_data_32"}
+#endif
+};
+
+static int data_blklist_count =
+    sizeof (data_blklist) / sizeof (struct percpu_data_blklist);
+
+/*
+ * Allocate a block descriptor structure and initialize it.  
+ * Returns the address of the block descriptor or NULL on failure.
+ */
+static struct percpu_data_blk *
+percpu_data_blk_alloc(struct percpu_data_blklist *blklist, int flags)
+{
+	struct percpu_data_blk *blkp;
+	int i;
+	int count;
+
+	if (!(blkp = kmalloc(sizeof (struct percpu_data_blk), flags)))
+		goto out1;
+	INIT_LIST_HEAD(&blkp->linkage);
+	blkp->usecount = 0;
+	count = blklist->blksize / blklist->objsize;
+	blkp->freearr = kmalloc(count, flags);
+	if (!blkp->freearr)
+		goto out;
+	blkp->freehead = 0;
+	for (i = 0; i < count; i++)
+		blkp->freearr[i] = i + 1;
+	blkp->freearr[i - 1] = -1;	/* Marks the end of the array */
+	blkp->blklist = blklist;
+	return blkp;
+out:
+	kfree(blkp);
+out1:
+	return NULL;
+}
+
+/*
+ * Frees the block descriptor structure
+ */
+static void
+percpu_data_blk_free(struct percpu_data_blk *blkp)
+{
+	kfree(blkp);
+}
+
+/*
+ * Add a block to the percpu data object memory pool.
+ * Returns 0 on failure and 1 on success
+ */
+static int
+percpu_data_mem_grow(struct percpu_data_blklist *blklist, int flags)
+{
+	struct percpu_data_blk *blkp;
+	unsigned long save_flags;
+	int i;
+
+	if (!(blkp = percpu_data_blk_alloc(blklist, flags)))
+		goto out;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		blkp->blkaddr[i] = kmem_cache_alloc(blklist->cachep, flags);
+		if (!(blkp->blkaddr[i]))
+			goto out1;
+		memset(blkp->blkaddr[i], 0, blklist->blksize);
+	}
+
+	/* 
+	 * Now that we have the block successfully allocated 
+	 * and instantiated..  add it.....
+	 */
+	spin_lock_irqsave(&blklist->lock, save_flags);
+	list_add_tail(&blkp->linkage, &blklist->blks);
+	if (blklist->firstnotfull == &blklist->blks)
+		blklist->firstnotfull = &blkp->linkage;
+	spin_unlock_irqrestore(&blklist->lock, save_flags);
+	return 1;
+
+out1:
+	i--;
+	for (; i >= 0; i--) {
+		if (!cpu_possible(i))
+			continue;
+		kmem_cache_free(blklist->cachep, blkp->blkaddr[i]);
+	}
+	percpu_data_blk_free(blkp);
+out:
+	return 0;
+}
+
+/*
+ * Initialise the main percpu data control structure.
+ */
+static void __init
+percpu_data_blklist_init(struct percpu_data_blklist *blklist)
+{
+	blklist->cachep = kmem_cache_create(blklist->cachename,
+					    blklist->blksize, 0,
+					    SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!blklist->cachep)
+		BUG();
+}
+
+static struct percpu_data_blklist *
+percpu_data_get_blklist(size_t size, int flags)
+{
+	int i;
+	for (i = 0; i < data_blklist_count; i++) {
+		if (size > data_blklist[i].objsize)
+			continue;
+		return &data_blklist[i];
+	}
+	return NULL;
+}
+
+/*
+ * Initialize the percpu_data subsystem.
+ */
+void __init
+kmalloc_percpu_init(void)
+{
+	int i;
+	for (i = 0; i < data_blklist_count; i++) {
+		percpu_data_blklist_init(&data_blklist[i]);
+	}
+}
+
+/*
+ * Allocs an object from the block.  Returns back the object index.
+ */
+static int
+__percpu_interlaced_alloc_one(struct percpu_data_blklist *blklist,
+			      struct percpu_data_blk *blkp)
+{
+	unsigned int objidx;
+
+	objidx = blkp->freehead;
+	blkp->freehead = blkp->freearr[objidx];
+	blkp->usecount++;
+	if (blkp->freehead < 0) {
+		blklist->firstnotfull = blkp->linkage.next;
+	}
+	return objidx;
+}
+
+/*
+ * Allocate a per cpu data object and return a pointer to it.
+ */
+static int
+__percpu_interlaced_alloc(struct percpu_data *percpu,
+			  struct percpu_data_blklist *blklist, int flags)
+{
+	struct percpu_data_blk *blkp;
+	unsigned long save_flags;
+	struct list_head *l;
+	int objidx;
+	int i;
+
+tryagain:
+
+	spin_lock_irqsave(&blklist->lock, save_flags);
+	l = blklist->firstnotfull;
+	if (l == &blklist->blks)
+		goto unlock_and_get_mem;
+	blkp = list_entry(l, struct percpu_data_blk, linkage);
+
+	objidx = __percpu_interlaced_alloc_one(blklist, blkp);
+	spin_unlock_irqrestore(&blklist->lock, save_flags);
+	/* 
+	 * Since we hold the lock and firstnotfull is not the
+	 * head list, we should be getting an object alloc here. firstnotfull 
+	 * can be pointing to head of the list when all the blks are 
+	 * full or when there're no blocks left 
+	 */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		percpu->ptrs[i] = blkp->blkaddr[i] + objidx * blklist->objsize;
+	}
+	percpu->blkp = (void *) blkp;
+	return 1;
+
+unlock_and_get_mem:
+
+	spin_unlock_irqrestore(&blklist->lock, save_flags);
+	if (percpu_data_mem_grow(blklist, flags))
+		goto tryagain;	/* added another block..try allocing obj .. */
+
+	return 0;
+}
+
+/*
+ * Allocate a per-cpu data object and return a pointer to it.
+ * Returns NULL on failure. 
+ */
+static int
+percpu_interlaced_alloc(struct percpu_data *pdata, size_t size, int flags)
+{
+	struct percpu_data_blklist *blklist;
+
+	blklist = percpu_data_get_blklist(size, flags);
+	if (blklist == NULL)
+		return 0;
+	return __percpu_interlaced_alloc(pdata, blklist, flags);
+}
+
+/*
+ * Frees memory associated with a percpu data block
+ */
+static void
+percpu_data_blk_destroy(struct percpu_data_blklist *blklist,
+			struct percpu_data_blk *blkp)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i))
+			continue;
+		kmem_cache_free(blklist->cachep, blkp->blkaddr[i]);
+	}
+	percpu_data_blk_free(blkp);
+}
+
+/*
+ * Frees an object from a block and fixes the freelist accdly.
+ * Frees the slab cache memory if a block gets empty during free.
+ */
+static void
+__percpu_interlaced_free(struct percpu_data_blklist *blklist,
+			 struct percpu_data *percpu)
+{
+	struct percpu_data_blk *blkp;
+	int objidx;
+	int objoffset;
+	struct list_head *t;
+	unsigned long save_flags;
+
+	spin_lock_irqsave(&blklist->lock, save_flags);
+	blkp = (struct percpu_data_blk *) percpu->blkp;
+	objoffset = percpu->ptrs[0] - blkp->blkaddr[0];
+	objidx = objoffset / blklist->objsize;
+
+	kfree(percpu);
+
+	blkp->freearr[objidx] = blkp->freehead;
+	blkp->freehead = objidx;
+	blkp->usecount--;
+
+	if (blkp->freearr[objidx] < 0) {
+		/* 
+		 * block was previously full and is now just partially full ..
+		 * so make firstnotfull pt to this block and fix list accdly 
+		 */
+		t = blklist->firstnotfull;
+		blklist->firstnotfull = &blkp->linkage;
+		if (blkp->linkage.next == t) {
+			spin_unlock_irqrestore(&blklist->lock, save_flags);
+			return;
+		}
+		list_del(&blkp->linkage);
+		list_add_tail(&blkp->linkage, t);
+
+		spin_unlock_irqrestore(&blklist->lock, save_flags);
+		return;
+	}
+
+	if (blkp->usecount == 0) {
+		t = blklist->firstnotfull->prev;
+
+		list_del(&blkp->linkage);
+		if (blklist->firstnotfull == &blkp->linkage)
+			blklist->firstnotfull = t->next;
+
+		spin_unlock_irqrestore(&blklist->lock, save_flags);
+		percpu_data_blk_destroy(blklist, blkp);
+		return;
+	}
+
+	spin_unlock_irqrestore(&blklist->lock, save_flags);
+	return;
+}
+
+/*
+ * Frees up a percpu data object
+ */
+static void
+percpu_interlaced_free(struct percpu_data *percpu)
+{
+	struct percpu_data_blk *blkp = percpu->blkp;
+	__percpu_interlaced_free(blkp->blklist, percpu);
+}
+
+/**
+ * kmalloc_percpu - allocate one copy of the object for every present
+ * cpu in the system.
+ *
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ * The @flags argument may be one of:
+ *
+ * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
+ * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
+ * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
+ */
+void *
+kmalloc_percpu(size_t size, int flags)
+{
+	int i;
+	struct percpu_data *pdata = kmalloc(sizeof (*pdata), flags);
+
+	if (!pdata)
+		goto out_done;
+	pdata->blkp = NULL;
+	if (size <= (malloc_sizes[0].cs_size >> 1)) {
+		if (!percpu_interlaced_alloc(pdata, size, flags))
+			goto out;
+	} else {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_possible(i))
+				continue;
+			pdata->ptrs[i] = kmalloc(size, flags);
+			if (!pdata->ptrs[i])
+				goto unwind_oom;
+		}
+	}
+	/* Catch derefs w/o wrappers */
+	return (void *) (~(unsigned long) pdata);
+
+unwind_oom:
+	while (--i >= 0) {
+		if (!cpu_possible(i))
+			continue;
+		kfree(pdata->ptrs[i]);
+	}
+out:
+	kfree(pdata);
+out_done:
+	return NULL;
+}
+
+/**
+ * kfree_percpu - free previously allocated percpu memory
+ * @objp: pointer returned by kmalloc_percpu.
+ *
+ * Don't free memory not originally allocated by kmalloc_percpu()
+ * The complemented objp is to check for that.
+ */
+void
+kfree_percpu(const void *objp)
+{
+	int i;
+	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
+
+	if (p->blkp) {
+		percpu_interlaced_free(p);
+	} else {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_possible(i))
+				continue;
+			kfree(p->ptrs[i]);
+		}
+	}
+}
