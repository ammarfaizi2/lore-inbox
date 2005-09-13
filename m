Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVIMP4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVIMP4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVIMP4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:56:18 -0400
Received: from serv01.siteground.net ([70.85.91.68]:58524 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964807AbVIMP4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:56:15 -0400
Date: Tue, 13 Sep 2005 08:56:08 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 2/11] mm: Reimplementation of dynamic per-cpu allocator -- alloc_percpu
Message-ID: <20050913155608.GD3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch re-implements the linux dynamic percpu memory allocator
so that:
1. Percpu memory dereference is faster 
	- One less memory reference compared to existing simple alloc_percpu
	- As fast as with static percpu areas, one mem ref less actually.
2. Better memory usage
	- Doesn't need a NR_CPUS pointer array for each allocation
	- Interlaces objects making better utilization of memory/cachelines
	- Userspace tests show 98% utilization with random sized allocations
	  after repeated random frees.  Utilization with small sized 
	  allocations (counters) expected to be better than random sized 
	  allocations.
3. Provides truly node local allocation
	- The percpu memory with existing alloc_percpu does node local
	  allocation, but the NR_CPUS place holder is not node local. This
	  problem doesn't exist with the new implementation.
4. CPU Hotplug friendly
5. Independent of slab.  Works early

Design:
We have "blocks" of memory akin to slabs.  Each block has 
(percpu blocksize) * NR_CPUS + (block management data structures) of kernel 
VA space allocated to it.  Node local pages are allocated and mapped 
against the corresponding cpus' VA space.  Pages are allocated for block 
management data structures and mapped to their corresponding VA.  These 
reside at (percpu blocksize) * NR_CPUS offset from the beginning of the block.  
The allocator maintains a circular linked list of blocks, sorted in 
descending order of block utilization.  On requests for objects, allocator 
tries to serve the request from the most utilized block.
The allocator allocates memory in multiples of a fixed currency size for 
a request.  The allocator returns address of the percpu
object corresponding to cpu0.  The cpu local variable for any given cpu
can be obtained by simple arithmetic:
obj_address + cpu_id  * PCPU_BLKSIZE.

Testing:
The block allocator has undergone some userspace stress testing with small
counter sized objects as well as a large number of random sized objects.  

Signed-off-by: Ravikiran Thirumalai <kiran.th@gmail.com>
---
Index: alloc_percpu-2.6.13-rc6/include/linux/kernel.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/kernel.h	2005-08-15 00:54:41.154135250 -0400
+++ alloc_percpu-2.6.13-rc6/include/linux/kernel.h	2005-08-15 00:55:06.611726250 -0400
@@ -29,6 +29,8 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
+#define IS_ALIGNED(x,a) (!(((a) - 1) & (x)))
+#define IS_POWEROFTWO(x) (!(((x) - 1) & (x)))
 
 #define	KERN_EMERG	"<0>"	/* system is unusable			*/
 #define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
Index: alloc_percpu-2.6.13-rc6/include/linux/percpu.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/percpu.h	2005-08-15 00:54:41.154135250 -0400
+++ alloc_percpu-2.6.13-rc6/include/linux/percpu.h	2005-08-15 00:55:06.615726500 -0400
@@ -15,23 +15,19 @@
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
-#ifdef CONFIG_SMP
-
-struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
-};
+/* This is the upper bound for an object using alloc_percpu */
+#define PCPU_BLKSIZE (PAGE_SIZE << 1)
+#define PCPU_CURR_SIZE        (sizeof (int))
 
+#ifdef CONFIG_SMP
 /* 
  * Use this to get to a cpu's version of the per-cpu object allocated using
  * alloc_percpu.  Non-atomic access to the current CPU's version should
  * probably be combined with get_cpu()/put_cpu().
  */ 
 #define per_cpu_ptr(ptr, cpu)                   \
-({                                              \
-        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
-        (__typeof__(ptr))__p->ptrs[(cpu)];	\
-})
+	((__typeof__(ptr))                      \
+	(RELOC_HIDE(ptr,  PCPU_BLKSIZE * cpu)))
 
 extern void *__alloc_percpu(size_t size, size_t align);
 extern void free_percpu(const void *);
@@ -56,6 +52,6 @@
 
 /* Simple wrapper for the common case: zeros memory. */
 #define alloc_percpu(type) \
-	((type *)(__alloc_percpu(sizeof(type), __alignof__(type))))
+	((type *)(__alloc_percpu(ALIGN(sizeof (type), PCPU_CURR_SIZE),  __alignof__(type))))
 
 #endif /* __LINUX_PERCPU_H */
Index: alloc_percpu-2.6.13-rc6/mm/Makefile
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/mm/Makefile	2005-08-15 00:54:41.154135250 -0400
+++ alloc_percpu-2.6.13-rc6/mm/Makefile	2005-08-15 00:55:06.615726500 -0400
@@ -18,5 +18,6 @@
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+obj-$(CONFIG_SMP)	+= percpu.o
 
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
Index: alloc_percpu-2.6.13-rc6/mm/percpu.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/mm/percpu.c	2005-08-12 07:14:03.324696250 -0400
+++ alloc_percpu-2.6.13-rc6/mm/percpu.c	2005-08-15 00:59:16.099318250 -0400
@@ -0,0 +1,693 @@
+/*
+ * Dynamic percpu memory allocator.
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
+ * Copyright (C) IBM Corporation, 2003
+ *
+ * Author: Ravikiran Thirumalai <kiran.th@gmail.com>
+ * 
+ * Originally by Dipankar Sarma and Ravikiran Thirumalai,
+ * This reimplements alloc_percpu to make it 
+ * 1. Independent of slab/kmalloc
+ * 2. Use node local memory
+ * 3. Use simple pointer arithmetic 
+ * 4. Minimise fragmentation.
+ *
+ * Allocator is slow -- expected to be called during module/subsytem
+ * init. alloc_percpu can block.
+ *
+ */
+
+#include <linux/percpu.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+
+#include <linux/sort.h>
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
+#include <asm/pgtable.h>
+#include <asm/hardirq.h>
+
+#define MAX_OBJSIZE	PCPU_BLKSIZE
+#define OBJS_PER_BLOCK	(PCPU_BLKSIZE/PCPU_CURR_SIZE)
+#define	BITMAP_ARR_SIZE (OBJS_PER_BLOCK/(sizeof (unsigned long) * 8))
+#define MAX_NR_BITS	(OBJS_PER_BLOCK)
+#define PCPUPAGES_PER_BLOCK ((PCPU_BLKSIZE >> PAGE_SHIFT) * NR_CPUS)
+
+/* Block descriptor */
+struct pcpu_block {
+	void *start_addr;
+	struct page *pages[PCPUPAGES_PER_BLOCK * 2];	/* Extra for block mgt */
+	struct list_head blklist;
+	unsigned long bitmap[BITMAP_ARR_SIZE];	/* Object Freelist */
+	int bufctl_fl[OBJS_PER_BLOCK];	/* bufctl_fl freelist */
+	int bufctl_fl_head;
+	unsigned int size_used;
+};
+
+#define BLK_SIZE_USED(listpos) (list_entry(listpos, 		 	      \
+					struct pcpu_block, blklist)->size_used)
+
+/* Block list maintanance */
+
+/* Ordered list of pcpu_blocks -- Full, partial first */
+static struct list_head blkhead = LIST_HEAD_INIT(blkhead);
+static struct list_head *firstnotfull = &blkhead;
+static spinlock_t blklist_lock = SPIN_LOCK_UNLOCKED;
+
+/* 
+ * Bufctl descriptor and bufctl list for all allocated objs...
+ * Having one list for all buffers in the allocater might not be very efficient
+ * but we are not expecting allocs and frees in fast path (only during module
+ * load and unload hopefully
+ */
+struct buf_ctl {
+	void *addr;
+	size_t size;
+	struct buf_ctl *next;
+};
+
+static struct buf_ctl *buf_head = NULL;
+
+#define BLOCK_MANAGEMENT_SIZE						\
+({									\
+	int extra = sizeof (struct buf_ctl)*OBJS_PER_BLOCK 		\
+				+ sizeof (struct pcpu_block); 		\
+	ALIGN(extra, PAGE_SIZE);					\
+})
+
+#define BLOCK_MANAGEMENT_PAGES (BLOCK_MANAGEMENT_SIZE >> PAGE_SHIFT)
+
+void init_pcpu_block(struct pcpu_block *blkp)
+{
+	int i;
+
+	/* Setup the freelist */
+	blkp->bufctl_fl_head = 0;
+	for (i = 0; i < OBJS_PER_BLOCK - 1; i++)
+		blkp->bufctl_fl[i] = i + 1;
+	blkp->bufctl_fl[i] = -1;	/* Sentinel to mark End of list */
+}
+
+/*
+ * Allocate PCPU_BLKSIZE * NR_CPUS + BLOCK_MANAGEMENT_SIZE  worth of 
+ * contiguous kva space, and PCPU_BLKSIZE amount of node local 
+ * memory (pages) for all cpus possible + BLOCK_MANAGEMENT_SIZE pages
+ */
+static void *valloc_percpu(void)
+{
+	int i, j = 0;
+	unsigned int nr_pages;
+	struct vm_struct *area, tmp;
+	struct page **tmppage;
+	struct page *pages[BLOCK_MANAGEMENT_PAGES];
+	unsigned int cpu_pages = PCPU_BLKSIZE >> PAGE_SHIFT;
+	struct pcpu_block *blkp = NULL;
+
+	BUG_ON(!IS_ALIGNED(PCPU_BLKSIZE, PAGE_SIZE));
+	BUG_ON(!PCPU_BLKSIZE);
+	nr_pages = PCPUPAGES_PER_BLOCK + BLOCK_MANAGEMENT_PAGES;
+
+	/* Alloc Managent block pages */
+	for (i = 0; i < BLOCK_MANAGEMENT_PAGES; i++) {
+		pages[i] = alloc_pages(GFP_ATOMIC|__GFP_ZERO, 0);
+		if (!pages[i]) {
+			while (--i >= 0)
+				__free_pages(pages[i], 0);
+			return NULL;
+		}
+	}
+
+	/* Get the contiguous VA space for this block */
+	area = __get_vm_area(nr_pages << PAGE_SHIFT, VM_MAP, VMALLOC_START,
+				VMALLOC_END, GFP_KERNEL);
+	if (!area)
+		goto rollback_mgt;
+
+	/* Map pages for the block management pages */
+	tmppage = pages;
+	tmp.addr = area->addr + NR_CPUS * PCPU_BLKSIZE;
+	tmp.size = BLOCK_MANAGEMENT_SIZE + PAGE_SIZE;
+	if (map_vm_area(&tmp, PAGE_KERNEL, &tmppage))
+		goto rollback_vm_area;
+
+	/* Init the block descriptor */
+	blkp = area->addr + NR_CPUS * PCPU_BLKSIZE;
+	init_pcpu_block(blkp);
+	for (i = 0; i < BLOCK_MANAGEMENT_PAGES; i++)
+		blkp->pages[i + PCPUPAGES_PER_BLOCK] = pages[i];
+
+	/* Alloc node local pages for all cpus possible */
+	for_each_cpu(i) {
+		int start_idx = i * cpu_pages;
+		for (j = start_idx; j < start_idx + cpu_pages; j++) {
+			blkp->pages[j] = alloc_pages_node(cpu_to_node(i)
+							  ,
+							  GFP_ATOMIC |
+							  __GFP_HIGHMEM,
+							  0);
+			if (unlikely(!blkp->pages[j]))
+				goto rollback_pages;
+		}
+	}
+
+	/* Map pages for each cpu by splitting vm_struct for each cpu */
+	for_each_cpu(i) {
+		tmppage = &blkp->pages[i * cpu_pages];
+		tmp.addr = area->addr + i * PCPU_BLKSIZE;
+		/* map_vm_area assumes a guard page of size PAGE_SIZE */
+		tmp.size = PCPU_BLKSIZE + PAGE_SIZE;
+		if (map_vm_area(&tmp, PAGE_KERNEL, &tmppage))
+			goto fail_map;
+	}
+
+	return area->addr;
+
+fail_map:
+	i--;
+	for (; i >= 0; i--) {
+		if (cpu_possible(i)) {
+			tmp.addr = area->addr + i * PCPU_BLKSIZE;
+			/* we've mapped a guard page extra earlier... */
+			tmp.size = PCPU_BLKSIZE + PAGE_SIZE;
+			unmap_vm_area(&tmp);
+		}
+	}
+
+	/* set i and j with proper values for the roll back at fail: */
+	i = NR_CPUS - 1;
+	j = PCPUPAGES_PER_BLOCK;
+
+rollback_pages:
+	j--;
+	for (; j >= 0; j--)
+		if (cpu_possible(j / cpu_pages))
+			__free_pages(blkp->pages[j], 0);
+
+	/* Unmap  block management */
+	tmp.addr = area->addr + NR_CPUS * PCPU_BLKSIZE;
+	tmp.size = BLOCK_MANAGEMENT_SIZE + PAGE_SIZE;
+	unmap_vm_area(&tmp);
+
+rollback_vm_area:
+	/* Give back the contiguous mem area */
+	area = remove_vm_area(area->addr);
+	BUG_ON(!area);
+
+rollback_mgt:
+
+	/* Free the block management pages */
+	for (i = 0; i < BLOCK_MANAGEMENT_PAGES; i++)
+		__free_pages(pages[i], 0);
+
+	return NULL;
+}
+
+/* Free memory block allocated by valloc_percpu */
+static void vfree_percpu(void *addr)
+{
+	int i;
+	struct pcpu_block *blkp = addr + PCPUPAGES_PER_BLOCK * PAGE_SIZE;
+	struct vm_struct *area, tmp;
+	unsigned int cpu_pages = PCPU_BLKSIZE >> PAGE_SHIFT;
+	struct page *pages[BLOCK_MANAGEMENT_PAGES];
+
+	/* Backup the block management struct pages */
+	for (i = 0; i < BLOCK_MANAGEMENT_PAGES; i++)
+		pages[i] = blkp->pages[i + PCPUPAGES_PER_BLOCK];
+
+	/* Unmap all cpu_pages from the block's vm space */
+	for_each_cpu(i) {
+		tmp.addr = addr + i * PCPU_BLKSIZE;
+		/* We've mapped a guard page extra earlier */
+		tmp.size = PCPU_BLKSIZE + PAGE_SIZE;
+		unmap_vm_area(&tmp);
+	}
+
+	/* Give back all allocated pages */
+	for (i = 0; i < PCPUPAGES_PER_BLOCK; i++) {
+		if (cpu_possible(i / cpu_pages))
+			__free_pages(blkp->pages[i], 0);
+	}
+
+	/* Unmap block management pages */
+	tmp.addr = addr + NR_CPUS * PCPU_BLKSIZE;
+	tmp.size = BLOCK_MANAGEMENT_SIZE + PAGE_SIZE;
+	unmap_vm_area(&tmp);
+
+	/* Free block management pages */
+	for (i = 0; i < BLOCK_MANAGEMENT_PAGES; i++)
+		__free_pages(pages[i], 0);
+
+	/* Give back vm area for this block */
+	area = remove_vm_area(addr);
+	BUG_ON(!area);
+
+}
+
+static int add_percpu_block(void)
+{
+	struct pcpu_block *blkp;
+	void *start_addr;
+	unsigned long flags;
+
+	start_addr = valloc_percpu();
+	if (!start_addr)
+		return 0;
+	blkp = start_addr + PCPUPAGES_PER_BLOCK * PAGE_SIZE;
+	blkp->start_addr = start_addr;
+	spin_lock_irqsave(&blklist_lock, flags);
+	list_add_tail(&blkp->blklist, &blkhead);
+	if (firstnotfull == &blkhead)
+		firstnotfull = &blkp->blklist;
+	spin_unlock_irqrestore(&blklist_lock, flags);
+
+	return 1;
+}
+
+struct obj_map_elmt {
+	int startbit;
+	int obj_size;
+};
+
+/* Fill the array with obj map info and return no of elements in the array */
+static int
+make_obj_map(struct obj_map_elmt arr[], struct pcpu_block *blkp)
+{
+	int nr_elements = 0;
+	int i, j, obj_size;
+
+	for (i = 0, j = 0; i < MAX_NR_BITS; i++) {
+		if (!test_bit(i, blkp->bitmap)) {
+			/* Free block start */
+			arr[j].startbit = i;
+			nr_elements++;
+			obj_size = 1;
+			i++;
+			while (i < MAX_NR_BITS && (!test_bit(i, blkp->bitmap))) {
+				i++;
+				obj_size++;
+			}
+			arr[j].obj_size = obj_size * PCPU_CURR_SIZE;
+			j++;
+		}
+	}
+
+	return nr_elements;
+}
+
+/* Compare routine for sort -- for asceding order */
+static int obj_map_cmp(const void *a, const void *b)
+{
+	struct obj_map_elmt *sa, *sb;
+
+	sa = (struct obj_map_elmt *) a;
+	sb = (struct obj_map_elmt *) b;
+	return sa->obj_size - sb->obj_size;
+}
+
+/* Add bufctl to list of bufctl */
+static void add_bufctl(struct buf_ctl *bufp)
+{
+	if (buf_head == NULL)
+		buf_head = bufp;
+	else {
+		bufp->next = buf_head;
+		buf_head = bufp;
+	}
+}
+
+/* After you alloc from a block, It can only go up the ordered list */
+static void sort_blk_list_up(struct pcpu_block *blkp)
+{
+	struct list_head *pos;
+
+	for (pos = blkp->blklist.prev; pos != &blkhead; pos = pos->prev) {
+		if (BLK_SIZE_USED(pos) < blkp->size_used) {
+			/* Move blkp up */
+			list_del(&blkp->blklist);
+			list_add_tail(&blkp->blklist, pos);
+			pos = &blkp->blklist;
+		} else
+			break;
+	}
+	/* Fix firstnotfull if needed */
+	if (blkp->size_used == PCPU_BLKSIZE) {
+		firstnotfull = blkp->blklist.next;
+		return;
+	}
+	if (blkp->size_used > BLK_SIZE_USED(firstnotfull)) {
+		firstnotfull = &blkp->blklist;
+		return;
+	}
+}
+
+struct buf_ctl *alloc_bufctl(struct pcpu_block *blkp)
+{
+	void *bufctl;
+	int head = blkp->bufctl_fl_head;
+	BUG_ON(head == -1);	/* If bufctls for this block has exhausted */
+	blkp->bufctl_fl_head = blkp->bufctl_fl[blkp->bufctl_fl_head];
+	BUG_ON(head >= OBJS_PER_BLOCK);
+	bufctl = (void *) blkp + sizeof (struct pcpu_block) +
+	    sizeof (struct buf_ctl) * head;
+	return bufctl;
+}
+
+/* Don't want to kmalloc this -- to avoid dependence on slab for future */
+static struct obj_map_elmt obj_map[OBJS_PER_BLOCK];
+
+/* Scan the freelist and return suitable obj if found */
+static void *
+get_obj_from_block(size_t size, size_t align, struct pcpu_block *blkp)
+{
+	int nr_elements, nr_currency, obj_startbit, obj_endbit;
+	int i, j;
+	void *objp;
+	struct buf_ctl *bufctl;
+
+	nr_elements = make_obj_map(obj_map, blkp);
+	if (!nr_elements)
+		return NULL;
+
+	/* Sort list in ascending order */
+	sort(obj_map, nr_elements, sizeof (obj_map[0]), obj_map_cmp, NULL);
+
+	/* Get the smallest obj_sized chunk for this size */
+	i = 0;
+	while (i < nr_elements - 1 && size > obj_map[i].obj_size)
+		i++;
+	if (obj_map[i].obj_size < size)	/* No suitable obj_size found */
+		return NULL;
+
+	/* chunk of obj_size >= size is found, check for suitability (align) 
+	 * and alloc 
+	 */
+	nr_currency = size / PCPU_CURR_SIZE;
+	obj_startbit = obj_map[i].startbit;
+
+try_again_for_align:
+
+	obj_endbit = obj_map[i].startbit + obj_map[i].obj_size / PCPU_CURR_SIZE
+	    - 1;
+	objp = obj_startbit * PCPU_CURR_SIZE + blkp->start_addr;
+
+	if (IS_ALIGNED((unsigned long) objp, align)) {
+		/* Alignment is ok so alloc this chunk */
+		bufctl = alloc_bufctl(blkp);
+		if (!bufctl)
+			return NULL;
+		bufctl->addr = objp;
+		bufctl->size = size;
+		bufctl->next = NULL;
+
+		/* Mark the bitmap as allocated */
+		for (j = obj_startbit; j < nr_currency + obj_startbit; j++)
+			set_bit(j, blkp->bitmap);
+		blkp->size_used += size;
+		/* Re-arrange list to preserve full, partial and free order */
+		sort_blk_list_up(blkp);
+		/* Add to the allocated buffers list and return */
+		add_bufctl(bufctl);
+		return objp;
+	} else {
+		/* Alignment is not ok */
+		int obj_size = (obj_endbit - obj_startbit + 1) * PCPU_CURR_SIZE;
+		if (obj_size > size && obj_startbit <= obj_endbit) {
+			/* Since obj_size is bigger than requested, check if
+			   alignment can be met by changing startbit */
+			obj_startbit++;
+			goto try_again_for_align;
+		} else {
+			/* Try in the next chunk */
+			if (++i < nr_elements) {
+				/* Reset start bit and try again */
+				obj_startbit = obj_map[i].startbit;
+				goto try_again_for_align;
+			}
+		}
+	}
+
+	/* Everything failed so return NULL */
+	return NULL;
+}
+
+static void zero_obj(void *obj, size_t size)
+{
+	int cpu;
+	for_each_cpu(cpu)
+		memset(per_cpu_ptr(obj, cpu), 0, size);
+}
+
+/* 
+ * __alloc_percpu - allocate one copy of the object for every present
+ * cpu in the system, zeroing them.
+ * Objects should be dereferenced using per_cpu_ptr/get_cpu_ptr
+ * macros only
+ *
+ * This allocator is slow as we assume allocs to come
+ * by during boot/module init.
+ * Should not be called from interrupt context 
+ */
+void *__alloc_percpu(size_t size, size_t align)
+{
+	struct pcpu_block *blkp;
+	struct list_head *l;
+	void *obj;
+	unsigned long flags;
+
+	if (!size)
+		return NULL;
+
+	if (size < PCPU_CURR_SIZE)
+		size = PCPU_CURR_SIZE;
+
+	if (align == 0)
+		align = PCPU_CURR_SIZE;
+
+	if (size > MAX_OBJSIZE) {
+		printk("alloc_percpu: ");
+		printk("size %d requested is more than I can handle\n", size);
+		return NULL;
+	}
+
+	BUG_ON(!IS_ALIGNED(size, PCPU_CURR_SIZE));
+
+try_after_refill:
+
+	/* Get the block to allocate from */
+	spin_lock_irqsave(&blklist_lock, flags);
+	l = firstnotfull;
+
+try_next_block:
+
+	/* If you have reached end of list, add another block and try */
+	if (l == &blkhead)
+		goto unlock_and_get_mem;
+	blkp = list_entry(l, struct pcpu_block, blklist);
+	obj = get_obj_from_block(size, align, blkp);
+	if (!obj) {
+		l = l->next;
+		goto try_next_block;
+	}
+	spin_unlock_irqrestore(&blklist_lock, flags);
+	zero_obj(obj, size);
+	return obj;
+
+unlock_and_get_mem:
+
+	spin_unlock_irqrestore(&blklist_lock, flags);
+	if (add_percpu_block())
+		goto try_after_refill;
+	return NULL;
+
+}
+
+EXPORT_SYMBOL(__alloc_percpu);
+
+/* After you free from a block, It can only go down the ordered list */
+static void sort_blk_list_down(struct pcpu_block *blkp)
+{
+	struct list_head *pos, *prev, *next;
+	/* Store the actual prev and next pointers for fnof fixing later */
+	prev = blkp->blklist.prev;
+	next = blkp->blklist.next;
+
+	/* Fix the ordering on the list */
+	for (pos = blkp->blklist.next; pos != &blkhead; pos = pos->next) {
+		if (BLK_SIZE_USED(pos) > blkp->size_used) {
+			/* Move blkp down */
+			list_del(&blkp->blklist);
+			list_add(&blkp->blklist, pos);
+			pos = &blkp->blklist;
+		} else
+			break;
+	}
+	/* Fix firstnotfull if needed and return */
+	if (firstnotfull == &blkhead) {
+		/* There was no block free, so now this block is fnotfull */
+		firstnotfull = &blkp->blklist;
+		return;
+	}
+
+	if (firstnotfull == &blkp->blklist) {
+		/* This was firstnotfull so fix fnof pointer accdly */
+		if (prev != &blkhead && BLK_SIZE_USED(prev) != PCPU_BLKSIZE) {
+			/* Move fnof pointer up */
+			firstnotfull = prev;
+			prev = prev->prev;
+			/* If size_used of prev is same as fnof, fix fnof to 
+			   point to topmost of the equal sized blocks */
+			while (prev != &blkhead &&
+			       BLK_SIZE_USED(prev) != PCPU_BLKSIZE) {
+				if (BLK_SIZE_USED(prev) !=
+				    BLK_SIZE_USED(firstnotfull))
+					return;
+				firstnotfull = prev;
+				prev = prev->prev;
+			}
+		} else if (next != &blkhead) {
+			/* Move fnof pointer down */
+			firstnotfull = next;
+			next = next->next;
+			if (BLK_SIZE_USED(firstnotfull) != PCPU_BLKSIZE)
+				return;
+			/* fnof is pointing to block which is full...fix it */
+			while (next != &blkhead &&
+			       BLK_SIZE_USED(next) == PCPU_BLKSIZE) {
+				firstnotfull = next;
+				next = next->next;
+			}
+		}
+
+	}
+
+}
+
+void free_bufctl(struct pcpu_block *blkp, struct buf_ctl *bufp)
+{
+	int idx = ((void *) bufp - (void *) blkp - sizeof (struct pcpu_block))
+	    / sizeof (struct buf_ctl);
+	blkp->bufctl_fl[idx] = blkp->bufctl_fl_head;
+	blkp->bufctl_fl_head = idx;
+}
+
+/*
+ * Free the percpu obj and whatever memory can be freed
+ */
+static void free_percpu_obj(struct list_head *pos, struct buf_ctl *bufp)
+{
+	struct pcpu_block *blkp;
+	blkp = list_entry(pos, struct pcpu_block, blklist);
+
+	/* Update blkp->size_used and free if size_used is 0 */
+	blkp->size_used -= bufp->size;
+	if (blkp->size_used) {
+		/* Mark the bitmap corresponding to this object free */
+		int i, obj_startbit;
+		int nr_currency = bufp->size / PCPU_CURR_SIZE;
+		obj_startbit = (bufp->addr - blkp->start_addr) / PCPU_CURR_SIZE;
+		for (i = obj_startbit; i < obj_startbit + nr_currency; i++)
+			clear_bit(i, blkp->bitmap);
+		sort_blk_list_down(blkp);
+	} else {
+		/* Usecount is zero, so prepare to give this block back to vm */
+		/* Fix firstnotfull if freeing block was firstnotfull 
+		 * If there are more blocks with the same usecount as fnof,
+		 * point to the first block from the head */
+		if (firstnotfull == pos) {
+			firstnotfull = pos->prev;
+			while (firstnotfull != &blkhead) {
+				unsigned int fnf_size_used;
+				fnf_size_used = BLK_SIZE_USED(firstnotfull);
+
+				if (fnf_size_used == PCPU_BLKSIZE)
+					firstnotfull = &blkhead;
+				else if (firstnotfull->prev == &blkhead)
+					break;
+				else if (BLK_SIZE_USED(firstnotfull->prev)
+					 == fnf_size_used)
+					firstnotfull = firstnotfull->prev;
+				else
+					break;
+			}
+		}
+		list_del(pos);
+	}
+
+	/* Free bufctl after fixing the bufctl list */
+	if (bufp == buf_head) {
+		buf_head = bufp->next;
+	} else {
+		struct buf_ctl *tmp = buf_head;
+		while (tmp && tmp->next != bufp)
+			tmp = tmp->next;
+		BUG_ON(!tmp || tmp->next != bufp);
+		tmp->next = bufp->next;
+	}
+	free_bufctl(blkp, bufp);
+	/* If usecount is zero, give this block back to vm */
+	if (!blkp->size_used)
+		vfree_percpu(blkp->start_addr);
+	return;
+}
+
+/*
+ * Free memory allocated using alloc_percpu.
+ */
+
+void free_percpu(const void *objp)
+{
+	struct buf_ctl *bufp;
+	struct pcpu_block *blkp;
+	struct list_head *pos;
+	unsigned long flags;
+	if (!objp)
+		return;
+
+	/* Find block from which obj was allocated by scanning  bufctl list */
+	spin_lock_irqsave(&blklist_lock, flags);
+	bufp = buf_head;
+	while (bufp) {
+		if (bufp->addr == objp)
+			break;
+		bufp = bufp->next;
+	}
+	BUG_ON(!bufp);
+
+	/* We have the bufctl for the obj here, Now get the block */
+	list_for_each(pos, &blkhead) {
+		blkp = list_entry(pos, struct pcpu_block, blklist);
+		if (objp >= blkp->start_addr &&
+		    objp < blkp->start_addr + PCPU_BLKSIZE)
+			break;
+	}
+
+	BUG_ON(pos == &blkhead);	/* Couldn't find obj in block list */
+
+	/* 
+	 * Mark the bitmap free, Update use count, fix the ordered 
+	 * blklist, free the obj bufctl. 
+	 */
+	free_percpu_obj(pos, bufp);
+
+	spin_unlock_irqrestore(&blklist_lock, flags);
+	return;
+}
+
+EXPORT_SYMBOL(free_percpu);
Index: alloc_percpu-2.6.13-rc6/mm/slab.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/mm/slab.c	2005-08-15 00:54:41.158135500 -0400
+++ alloc_percpu-2.6.13-rc6/mm/slab.c	2005-08-15 00:55:06.615726500 -0400
@@ -2493,49 +2493,6 @@
 }
 EXPORT_SYMBOL(__kmalloc);
 
-#ifdef CONFIG_SMP
-/**
- * __alloc_percpu - allocate one copy of the object for every present
- * cpu in the system, zeroing them.
- * Objects should be dereferenced using the per_cpu_ptr macro only.
- *
- * @size: how many bytes of memory are required.
- * @align: the alignment, which can't be greater than SMP_CACHE_BYTES.
- */
-void *__alloc_percpu(size_t size, size_t align)
-{
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof (*pdata), GFP_KERNEL);
-
-	if (!pdata)
-		return NULL;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL,
-						cpu_to_node(i));
-
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-		memset(pdata->ptrs[i], 0, size);
-	}
-
-	/* Catch derefs w/o wrappers */
-	return (void *) (~(unsigned long) pdata);
-
-unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(pdata->ptrs[i]);
-	}
-	kfree(pdata);
-	return NULL;
-}
-EXPORT_SYMBOL(__alloc_percpu);
-#endif
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
@@ -2596,30 +2553,6 @@
 }
 EXPORT_SYMBOL(kfree);
 
-#ifdef CONFIG_SMP
-/**
- * free_percpu - free previously allocated percpu memory
- * @objp: pointer returned by alloc_percpu.
- *
- * Don't free memory not originally allocated by alloc_percpu()
- * The complemented objp is to check for that.
- */
-void
-free_percpu(const void *objp)
-{
-	int i;
-	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(p->ptrs[i]);
-	}
-	kfree(p);
-}
-EXPORT_SYMBOL(free_percpu);
-#endif
-
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
 	return obj_reallen(cachep);
