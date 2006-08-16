Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWHPHwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWHPHwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWHPHwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:52:12 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52128 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750965AbWHPHwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:52:10 -0400
Date: Wed, 16 Aug 2006 11:51:37 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH2 1/1] network memory allocator.
Message-ID: <20060816075137.GA22397@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060814110359.GA27704@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 11:51:40 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Network tree allocator can be used to allocate memory for all network
operations from any context.

Changes from previous release:
 * added dynamically grown cache
 * changed some inline issues
 * reduced code size
 * removed AVL tree implementation from the sources
 * changed minimum allocation size to l1 cache line size (some arches require that)
 * removed skb->__tsize parameter
 * added a lot of comments
 * a lot of small cleanups

Trivial epoll based web server achieved more than 2450 requests per
second with this version (usual numbers are about 1600-1800 when usual
kmalloc is used for all network operations).

Network allocator design and implementation notes as long as performance
and fragmentation analysis can be found at project homepage:
http://tservice.net.ru/~s0mbre/old/?section=projects&item=nta

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 19c96d4..f550f95 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -327,6 +327,10 @@ #include <linux/slab.h>
 
 #include <asm/system.h>
 
+extern void *avl_alloc(unsigned int size, gfp_t gfp_mask);
+extern void avl_free(void *ptr, unsigned int size);
+extern int avl_init(void);
+
 extern void kfree_skb(struct sk_buff *skb);
 extern void	       __kfree_skb(struct sk_buff *skb);
 extern struct sk_buff *__alloc_skb(unsigned int size,
diff --git a/net/core/Makefile b/net/core/Makefile
index 2645ba4..d86d468 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_SYSCTL) += sysctl_net_core.
 obj-y		     += dev.o ethtool.o dev_mcast.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
 
+obj-y += alloc/
+
 obj-$(CONFIG_XFRM) += flow.o
 obj-$(CONFIG_SYSFS) += net-sysfs.o
 obj-$(CONFIG_NET_DIVERT) += dv.o
diff --git a/net/core/alloc/Makefile b/net/core/alloc/Makefile
new file mode 100644
index 0000000..21b7c51
--- /dev/null
+++ b/net/core/alloc/Makefile
@@ -0,0 +1,3 @@
+obj-y		:= allocator.o
+
+allocator-y	:= avl.o
diff --git a/net/core/alloc/avl.c b/net/core/alloc/avl.c
new file mode 100644
index 0000000..c404cbe
--- /dev/null
+++ b/net/core/alloc/avl.c
@@ -0,0 +1,651 @@
+/*
+ * 	avl.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/skbuff.h>
+
+#include "avl.h"
+
+static struct avl_allocator_data avl_allocator[NR_CPUS];
+
+/*
+ * Get node pointer from address.
+ */
+static inline struct avl_node *avl_get_node_ptr(unsigned long ptr)
+{
+	struct page *page = virt_to_page(ptr);
+	struct avl_node *node = (struct avl_node *)(page->lru.next);
+
+	return node;
+}
+
+/*
+ * Set node pointer for page for given address.
+ */
+static void avl_set_node_ptr(unsigned long ptr, struct avl_node *node, int order)
+{
+	int nr_pages = 1<<order, i;
+	struct page *page = virt_to_page(ptr);
+	
+	for (i=0; i<nr_pages; ++i) {
+		page->lru.next = (void *)node;
+		page++;
+	}
+}
+
+/*
+ * Get allocation CPU from address.
+ */
+static inline int avl_get_cpu_ptr(unsigned long ptr)
+{
+	struct page *page = virt_to_page(ptr);
+	int cpu = (int)(unsigned long)(page->lru.prev);
+
+	return cpu;
+}
+
+/*
+ * Set allocation cpu for page for given address.
+ */
+static void avl_set_cpu_ptr(unsigned long ptr, int cpu, int order)
+{
+	int nr_pages = 1<<order, i;
+	struct page *page = virt_to_page(ptr);
+			
+	for (i=0; i<nr_pages; ++i) {
+		page->lru.prev = (void *)(unsigned long)cpu;
+		page++;
+	}
+}
+
+/*
+ * Convert pointer to node's value.
+ * Node's value is a start address for contiguous chunk bound to given node.
+ */
+static inline unsigned long avl_ptr_to_value(void *ptr)
+{
+	struct avl_node *node = avl_get_node_ptr((unsigned long)ptr);
+	return node->value;
+}
+
+/*
+ * Convert pointer into offset from start address of the contiguous chunk
+ * allocated for appropriate node.
+ */
+static inline int avl_ptr_to_offset(void *ptr)
+{
+	return ((unsigned long)ptr - avl_ptr_to_value(ptr))/AVL_MIN_SIZE;
+}
+
+/*
+ * Count number of bits set down (until first unset is met in a mask) 
+ * to the smaller addresses including bit at @pos in @mask.
+ */
+unsigned int avl_count_set_down(unsigned long *mask, unsigned int pos)
+{
+	unsigned int stop, bits = 0;
+	int idx;
+	unsigned long p, m;
+
+	idx = pos/BITS_PER_LONG;
+	pos = pos%BITS_PER_LONG;
+
+	while (idx >= 0) {
+		m = (~0UL>>pos)<<pos;
+		p = mask[idx] | m;
+
+		if (!(mask[idx] & m))
+			break;
+
+		stop = fls(~p);
+
+		if (!stop) {
+			bits += pos + 1;
+			pos = BITS_PER_LONG - 1;
+			idx--;
+		} else {
+			bits += pos - stop + 1;
+			break;
+		}
+	}
+
+	return bits;
+}
+
+/*
+ * Count number of bits set up (until first unset is met in a mask) 
+ * to the bigger addresses including bit at @pos in @mask.
+ */
+unsigned int avl_count_set_up(unsigned long *mask, unsigned int mask_num, 
+		unsigned int pos)
+{
+	unsigned int idx, stop, bits = 0;
+	unsigned long p, m;
+
+	idx = pos/BITS_PER_LONG;
+	pos = pos%BITS_PER_LONG;
+
+	while (idx < mask_num) {
+		if (!pos)
+			m = 0;
+		else
+			m = (~0UL<<(BITS_PER_LONG-pos))>>(BITS_PER_LONG-pos);
+		p = mask[idx] | m;
+
+		if (!(mask[idx] & ~m))
+			break;
+
+		stop = ffs(~p);
+
+		if (!stop) {
+			bits += BITS_PER_LONG - pos;
+			pos = 0;
+			idx++;
+		} else {
+			bits += stop - pos - 1;
+			break;
+		}
+	}
+
+	return bits;
+}
+
+/*
+ * Fill @num bits from position @pos up with bit value @bit in a @mask.
+ */
+
+static void avl_fill_bits(unsigned long *mask, unsigned int mask_size, 
+		unsigned int pos, unsigned int num, unsigned int bit)
+{
+	unsigned int idx, start;
+
+	idx = pos/BITS_PER_LONG;
+	start = pos%BITS_PER_LONG;
+
+	while (num && idx < mask_size) {
+		unsigned long m = ((~0UL)>>start)<<start;
+
+		if (start + num <= BITS_PER_LONG) {
+			unsigned long upper_bits = BITS_PER_LONG - (start+num);
+
+			m = (m<<upper_bits)>>upper_bits;
+		}
+
+		if (bit)
+			mask[idx] |= m;
+		else
+			mask[idx] &= ~m;
+
+		if (start + num <= BITS_PER_LONG)
+			num = 0;
+		else {
+			num -= BITS_PER_LONG - start;
+			start = 0;
+			idx++;
+		}
+	}
+}
+
+/*
+ * Add free chunk into array.
+ */
+static inline void avl_container_insert(struct avl_container *c, unsigned int pos, int cpu)
+{
+	list_add_tail(&c->centry, &avl_allocator[cpu].avl_container_array[pos]);
+}
+
+/*
+ * Update node's bitmask of free/used chunks.
+ * If processed chunk size is bigger than requested one, 
+ * split it and add the rest into list of free chunks with appropriate size.
+ */
+static void avl_update_node(struct avl_container *c, unsigned int cpos, unsigned int size)
+{
+	struct avl_node *node = avl_get_node_ptr((unsigned long)c->ptr);
+	unsigned int num = AVL_ALIGN(size)/AVL_MIN_SIZE;
+
+	BUG_ON(cpos < num - 1);
+
+	avl_fill_bits(node->mask, ARRAY_SIZE(node->mask), avl_ptr_to_offset(c->ptr), num, 0);
+
+	if (cpos != num-1) {
+		void *ptr = c->ptr + size;
+		c = ptr;
+		c->ptr = ptr;
+
+		cpos -= num;
+
+		avl_container_insert(c, cpos, smp_processor_id());
+	}
+}
+
+/*
+ * Dereference free chunk into container and add it into list of free
+ * chunks with appropriate size.
+ */
+static int avl_container_add(void *ptr, unsigned int size, int cpu)
+{
+	struct avl_container *c = ptr;
+	unsigned int pos = AVL_ALIGN(size)/AVL_MIN_SIZE-1;
+
+	if (!size)
+		return -EINVAL;
+
+	c->ptr = ptr;
+	avl_container_insert(c, pos, cpu);
+
+	return 0;
+}
+
+/*
+ * Dequeue first free chunk from the list.
+ */
+static inline struct avl_container *avl_dequeue(struct list_head *head)
+{
+	struct avl_container *cnt;
+
+	cnt = list_entry(head->next, struct avl_container, centry);
+	list_del(&cnt->centry);
+
+	return cnt;
+}
+
+/*
+ * Add new node entry int network allocator.
+ * must be called with disabled preemtpion.
+ */
+static void avl_node_entry_commit(struct avl_node_entry *entry, int cpu)
+{
+	int i, idx, off;
+
+	idx = off = 0;
+	for (i=0; i<entry->avl_node_num; ++i) {
+		struct avl_node *node;
+
+		node = &entry->avl_node_array[idx][off];
+
+		if (++off >= AVL_NODES_ON_PAGE) {
+			idx++;
+			off = 0;
+		}
+
+		avl_set_cpu_ptr(node->value, cpu, entry->avl_node_order);
+		avl_set_node_ptr(node->value, node, entry->avl_node_order);
+		avl_container_add((void *)node->value, (1<<entry->avl_node_order)<<PAGE_SHIFT, cpu);
+	}
+}
+
+/*
+ * Simple cache growing function - allocate as much as possible,
+ * but no more than @AVL_NODE_NUM pages when there is a need for that.
+ */
+static struct avl_node_entry *avl_node_entry_alloc(gfp_t gfp_mask, int order)
+{
+	struct avl_node_entry *entry;
+	int i, num = 0, idx, off;
+	unsigned long ptr;
+
+	entry = kzalloc(sizeof(struct avl_node_entry), gfp_mask);
+	if (!entry)
+		return NULL;
+
+	entry->avl_node_array = kzalloc(AVL_NODE_PAGES * sizeof(void *), gfp_mask);
+	if (!entry->avl_node_array)
+		goto err_out_free_entry;
+
+	for (i=0; i<AVL_NODE_PAGES; ++i) {
+		entry->avl_node_array[i] = (struct avl_node *)__get_free_page(gfp_mask);
+		if (!entry->avl_node_array[i]) {
+			num = i;
+			goto err_out_free;
+		}
+	}
+
+	idx = off = 0;
+
+	for (i=0; i<AVL_NODE_NUM; ++i) {
+		struct avl_node *node;
+
+		ptr = __get_free_pages(gfp_mask, order);
+		if (!ptr)
+			break;
+
+		node = &entry->avl_node_array[idx][off];
+
+		if (++off >= AVL_NODES_ON_PAGE) {
+			idx++;
+			off = 0;
+		}
+
+		node->value = ptr;
+		memset(node->mask, 0, sizeof(node->mask));
+		avl_fill_bits(node->mask, ARRAY_SIZE(node->mask), 0, ((1<<order)<<PAGE_SHIFT)/AVL_MIN_SIZE, 1);
+	}
+
+	ulog("%s: entry: %p, node: %u, node_pages: %lu, node_num: %lu, order: %d, allocated: %d, container: %u, max_size: %u, min_size: %u, bits: %u.\n", 
+		__func__, entry, sizeof(struct avl_node), AVL_NODE_PAGES, AVL_NODE_NUM, order, 
+		i, AVL_CONTAINER_ARRAY_SIZE, AVL_MAX_SIZE, AVL_MIN_SIZE, ((1<<order)<<PAGE_SHIFT)/AVL_MIN_SIZE);
+
+	if (i == 0)
+		goto err_out_free;
+
+	entry->avl_node_num = i;
+	entry->avl_node_order = order;
+
+	return entry;
+
+err_out_free:
+	for (i=0; i<AVL_NODE_PAGES; ++i)
+		free_page((unsigned long)entry->avl_node_array[i]);
+err_out_free_entry:
+	kfree(entry);
+	return NULL;
+}
+
+/*
+ * Allocate memory region with given size and mode.
+ * If allocation fails due to unsupported order, otherwise
+ * allocate new node entry with given mode and try to allocate again
+ * Cache growing happens only with 0-order allocations.
+ */
+void *avl_alloc(unsigned int size, gfp_t gfp_mask)
+{
+	unsigned int i, try = 0;
+	void *ptr = NULL;
+	unsigned long flags;
+
+	size = AVL_ALIGN(size);
+
+	if (size > AVL_MAX_SIZE || size < AVL_MIN_SIZE) {
+		/*
+		 * Print info about unsupported order so user could send a "bug report"
+		 * or increase initial allocation order.
+		 */
+		if (get_order(size) > AVL_ORDER && net_ratelimit()) {
+			printk(KERN_INFO "%s: Failed to allocate %u bytes with %02x mode, order %u, max order %u.\n", 
+					__func__, size, gfp_mask, get_order(size), AVL_ORDER);
+			WARN_ON(1);
+		}
+
+		return NULL;
+	}
+
+	local_irq_save(flags);
+repeat:
+	for (i=size/AVL_MIN_SIZE-1; i<AVL_CONTAINER_ARRAY_SIZE; ++i) {
+		struct list_head *head = &avl_allocator[smp_processor_id()].avl_container_array[i];
+		struct avl_container *c;
+
+		if (!list_empty(head)) {
+			c = avl_dequeue(head);
+			ptr = c->ptr;
+			avl_update_node(c, i, size);
+			break;
+		}
+	}
+	local_irq_restore(flags);
+
+	if (!ptr && !try) {
+		struct avl_node_entry *entry;
+		
+		try = 1;
+
+		entry = avl_node_entry_alloc(gfp_mask, 0);
+		if (entry) {
+			local_irq_save(flags);
+			avl_node_entry_commit(entry, smp_processor_id());
+			goto repeat;
+		}
+			
+	}
+
+
+	return ptr;
+}
+
+/*
+ * Remove free chunk from the list.
+ */
+static inline struct avl_container *avl_search_container(void *ptr, unsigned int idx, int cpu)
+{
+	struct avl_container *c = ptr;
+	
+	list_del(&c->centry);
+	c->ptr = ptr;
+
+	return c;
+}
+
+/*
+ * Combine neighbour free chunks into the one with bigger size
+ * and put new chunk into list of free chunks with appropriate size.
+ */
+static void avl_combine(struct avl_node *node, void *lp, unsigned int lbits, void *rp, unsigned int rbits, 
+		void *cur_ptr, unsigned int cur_bits, int cpu)
+{
+	struct avl_container *lc, *rc, *c;
+	unsigned int idx;
+	void *ptr;
+
+	lc = rc = c = NULL;
+	idx = cur_bits - 1;
+	ptr = cur_ptr;
+
+	c = (struct avl_container *)cur_ptr;
+	c->ptr = cur_ptr;
+	
+	if (rp) {
+		rc = avl_search_container(rp, rbits-1, cpu);
+		if (!rc) {
+			printk(KERN_ERR "%p.%p: Failed to find a container for right pointer %p, rbits: %u.\n", 
+					node, cur_ptr, rp, rbits);
+			BUG();
+		}
+
+		c = rc;
+		idx += rbits;
+		ptr = c->ptr;
+	}
+
+	if (lp) {
+		lc = avl_search_container(lp, lbits-1, cpu);
+		if (!lc) {
+			printk(KERN_ERR "%p.%p: Failed to find a container for left pointer %p, lbits: %u.\n", 
+					node, cur_ptr, lp, lbits);
+			BUG();
+		}
+
+		idx += lbits;
+		ptr = c->ptr;
+	}
+	avl_container_insert(c, idx, cpu);
+}
+
+/*
+ * Free memory region of given size.
+ * Must be called on the same CPU where allocation happend
+ * with disabled interrupts.
+ */
+static void __avl_free_local(void *ptr, unsigned int size)
+{
+	unsigned long val = avl_ptr_to_value(ptr);
+	unsigned int pos, idx, sbits = AVL_ALIGN(size)/AVL_MIN_SIZE;
+	unsigned int rbits, lbits, cpu = avl_get_cpu_ptr(val);
+	struct avl_node *node;
+	unsigned long p;
+	void *lp, *rp;
+
+	node = avl_get_node_ptr((unsigned long)ptr);
+
+	pos = avl_ptr_to_offset(ptr);
+	idx = pos/BITS_PER_LONG;
+
+	p = node->mask[idx] >> (pos%BITS_PER_LONG);
+	
+	if ((p & 1)) {
+		printk(KERN_ERR "%p.%p: Broken pointer: value: %lx, pos: %u, idx: %u, mask: %lx, p: %lx.\n", 
+				node, ptr, val, pos, idx, node->mask[idx], p);
+		BUG();
+	}
+
+	avl_fill_bits(node->mask, ARRAY_SIZE(node->mask), pos, sbits, 1);
+
+	lp = rp = NULL;
+	rbits = lbits = 0;
+
+	idx = (pos+sbits)/BITS_PER_LONG;
+	p = (pos+sbits)%BITS_PER_LONG;
+
+	if ((node->mask[idx] >> p) & 1) {
+		lbits = avl_count_set_up(node->mask, ARRAY_SIZE(node->mask), pos+sbits);
+		if (lbits) {
+			lp = (void *)(val + (pos + sbits)*AVL_MIN_SIZE);
+		}
+	}
+
+	if (pos) {
+		idx = (pos-1)/BITS_PER_LONG;
+		p = (pos-1)%BITS_PER_LONG;
+		if ((node->mask[idx] >> p) & 1) {
+			rbits = avl_count_set_down(node->mask, pos-1);
+			if (rbits) {
+				rp = (void *)(val + (pos-rbits)*AVL_MIN_SIZE);
+			}
+		}
+	}
+
+	avl_combine(node, lp, lbits, rp, rbits, ptr, sbits, cpu);
+}
+
+/*
+ * Free memory region of given size.
+ * If freeing CPU is not the same as allocation one, chunk will 
+ * be placed into list of to-be-freed objects on allocation CPU,
+ * otherwise chunk will be freed and combined with neighbours.
+ * Must be called with disabled interrupts.
+ */
+static void __avl_free(void *ptr, unsigned int size)
+{
+	int cpu = avl_get_cpu_ptr((unsigned long)ptr);
+
+	if (cpu != smp_processor_id()) {
+		struct avl_free_list *l, *this = ptr;
+		struct avl_allocator_data *alloc = &avl_allocator[cpu];
+
+		this->cpu = smp_processor_id();
+		this->size = size;
+
+		spin_lock(&alloc->avl_free_lock);
+		l = alloc->avl_free_list_head;
+		alloc->avl_free_list_head = this;
+		this->next = l;
+		spin_unlock(&alloc->avl_free_lock);
+		return;
+	}
+
+	__avl_free_local(ptr, size);
+}
+
+/*
+ * Free memory region of given size.
+ */
+void avl_free(void *ptr, unsigned int size)
+{
+	unsigned long flags;
+	struct avl_free_list *l;
+	struct avl_allocator_data *alloc;
+
+	local_irq_save(flags);
+	__avl_free(ptr, size);
+	
+	alloc = &avl_allocator[smp_processor_id()];
+
+	while (alloc->avl_free_list_head) {
+		spin_lock(&alloc->avl_free_lock);
+		l = alloc->avl_free_list_head;
+		alloc->avl_free_list_head = l->next;
+		spin_unlock(&alloc->avl_free_lock);
+		__avl_free_local(l, l->size);
+	};
+	local_irq_restore(flags);
+}
+
+/*
+ * Initialize per-cpu allocator data.
+ */
+static int avl_init_cpu(int cpu)
+{
+	unsigned int i;
+	struct avl_allocator_data *alloc = &avl_allocator[cpu];
+	struct avl_node_entry *entry;
+
+	spin_lock_init(&alloc->avl_free_lock);
+
+	alloc->avl_container_array = kzalloc(sizeof(struct list_head) * AVL_CONTAINER_ARRAY_SIZE, GFP_KERNEL);
+	if (!alloc->avl_container_array)
+		goto err_out_exit;
+
+	for (i=0; i<AVL_CONTAINER_ARRAY_SIZE; ++i)
+		INIT_LIST_HEAD(&alloc->avl_container_array[i]);
+
+	entry = avl_node_entry_alloc(GFP_KERNEL, AVL_ORDER);
+	if (!entry)
+		goto err_out_free_container;
+
+	avl_node_entry_commit(entry, cpu);
+
+	return 0;
+
+err_out_free_container:
+	kfree(alloc->avl_container_array);
+err_out_exit:
+	return -ENOMEM;
+}
+
+/*
+ * Initialize network allocator.
+ */
+int avl_init(void)
+{
+	int err, cpu;
+
+	for_each_possible_cpu(cpu) {
+		err = avl_init_cpu(cpu);
+		if (err)
+			goto err_out;
+	}
+
+	printk(KERN_INFO "Network tree allocator has been initialized.\n");
+	return 0;
+
+err_out:
+	panic("Failed to initialize network allocator.\n");
+
+	return -ENOMEM;
+}
diff --git a/net/core/alloc/avl.h b/net/core/alloc/avl.h
new file mode 100644
index 0000000..600b66a
--- /dev/null
+++ b/net/core/alloc/avl.h
@@ -0,0 +1,117 @@
+/*
+ * 	avl.h
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHAAVLBILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __AVL_H
+#define __AVL_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/page.h>
+
+//#define AVL_DEBUG
+
+#ifdef AVL_DEBUG
+#define ulog(f, a...) printk(f, ##a)
+#else
+#define ulog(f, a...)
+#endif
+
+/*
+ * Network tree allocator variables.
+ */
+
+#define AVL_ALIGN_SIZE		L1_CACHE_BYTES
+#define AVL_ALIGN(x) 		ALIGN(x, AVL_ALIGN_SIZE)
+
+#define AVL_ORDER		3	/* Maximum allocation order */
+#define AVL_BITS		3	/* Must cover maximum number of pages used for allocation pools */
+
+#define AVL_NODES_ON_PAGE	(PAGE_SIZE/sizeof(struct avl_node))
+#define AVL_NODE_NUM		(1UL<<AVL_BITS)
+#define AVL_NODE_PAGES		((AVL_NODE_NUM+AVL_NODES_ON_PAGE-1)/AVL_NODES_ON_PAGE)
+
+#define AVL_MIN_SIZE		AVL_ALIGN_SIZE
+#define AVL_MAX_SIZE		((1<<AVL_ORDER) << PAGE_SHIFT)
+
+#define AVL_CONTAINER_ARRAY_SIZE	(AVL_MAX_SIZE/AVL_MIN_SIZE)
+
+/*
+ * Meta-information container for each contiguous block used in allocation.
+ * @value - start address of the contiguous block.
+ * @mask - bitmask of free and empty chunks [1 - free, 0 - used].
+ */
+struct avl_node
+{
+	unsigned long		value;
+	DECLARE_BITMAP(mask, AVL_MAX_SIZE/AVL_MIN_SIZE);
+};
+
+/*
+ * Free chunks are dereferenced into this structure and placed into LIFO list.
+ */
+
+struct avl_container
+{
+	void			*ptr;
+	struct list_head	centry;
+};
+
+/*
+ * When freeing happens on different than allocation CPU,
+ * chunk is dereferenced into this structure and placed into
+ * single-linked list in allocation CPU private area.
+ */
+
+struct avl_free_list
+{
+	struct avl_free_list		*next;
+	unsigned int			size;
+	unsigned int			cpu;
+};
+
+/*
+ * Each array of nodes is places into dynamically grown list.
+ * @avl_node_num - number of nodes in @avl_node_array
+ * @avl_node_start - index of the first node
+ * @avl_node_array - array of nodes (linked into pages)
+ */
+
+struct avl_node_entry
+{
+	unsigned int 		avl_node_order, avl_node_num;
+	struct avl_node 	**avl_node_array;
+};
+
+/*
+ * Main per-cpu allocator structure.
+ * @avl_container_array - array of lists of free chunks indexed by size of the elements
+ * @avl_free_list_head - single-linked list of objects, which were started to be freed on different CPU
+ * @avl_free_lock - lock protecting avl_free_list_head
+ */
+struct avl_allocator_data
+{
+	struct list_head *avl_container_array;
+	struct avl_free_list *avl_free_list_head;
+	spinlock_t avl_free_lock;
+};
+
+
+#endif /* __AVL_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 022d889..d10af88 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -156,7 +156,7 @@ struct sk_buff *__alloc_skb(unsigned int
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
 	size = SKB_DATA_ALIGN(size);
-	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	data = avl_alloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
@@ -223,7 +223,7 @@ struct sk_buff *alloc_skb_from_cache(kme
 
 	/* Get the DATA. */
 	size = SKB_DATA_ALIGN(size);
-	data = kmem_cache_alloc(cp, gfp_mask);
+	data = avl_alloc(size, gfp_mask);
 	if (!data)
 		goto nodata;
 
@@ -313,7 +313,7 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		avl_free(skb->head, skb->end - skb->head + sizeof(struct skb_shared_info));
 	}
 }
 
@@ -688,7 +688,7 @@ int pskb_expand_head(struct sk_buff *skb
 
 	size = SKB_DATA_ALIGN(size);
 
-	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	data = avl_alloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
@@ -2057,6 +2057,9 @@ void __init skb_init(void)
 						NULL, NULL);
 	if (!skbuff_fclone_cache)
 		panic("cannot create skbuff cache");
+
+	if (avl_init())
+		panic("Failed to initialize network tree allocator.\n");
 }
 
 EXPORT_SYMBOL(___pskb_trim);


-- 
	Evgeniy Polyakov
