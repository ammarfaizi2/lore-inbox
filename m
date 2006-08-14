Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWHNLEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHNLEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWHNLEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:04:31 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14291 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751986AbWHNLEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:04:30 -0400
Date: Mon, 14 Aug 2006 15:04:03 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/1] network memory allocator.
Message-ID: <20060814110359.GA27704@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 15:04:08 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Network tree allocator can be used to allocate memory for all network
operations from any context. Main designed features are:
 * reduced fragmentation (self defragmentation)
 * possibility to create zero-copy sending and receiving (ground work 
 	for userspace netchannels and high-performance sniffers)
 * greater than SLAB speed
 * full per CPU allocation and freeing (objects are never freed on
 	different CPU)
 * separate network allocations from main system's ones

Design notes.
Original idea was to store meta information used for allocation in an
AVL tree [1], but since I found a way to use some "unused" fields in struct page,
tree is unused in the allocator.

Terms.
node - container for per-page (of different order) meta information.
chunk - region of free or allocated memory.

Each allocation is aligned to the minimum allocation size (32 bytes, but
actually it should be L1 cache entry size).
Each node contains a bitmask of used/unused chunks of memory for memory 
region bound to that node. Each free chunk is placed into double linked
list inside array, indexed of size (divided by minimal allocation size).

Allocation algo.
When user requests some memory regiosn, it's size is rounded upto
minimum allocation size (instead of power of two in SLAB) and
appropriate entry in array of lists of free chunks is selected. If that
list contains free elements, first one is returned, otherwise next list
is selected with bigger size until non-empty list is found.
Then allocator determines a node for appropriate chunk (using fields in
corresponding struct page->lru), and bits corresponding to selected
chunk are marked as used. If chunk had bigger size than requested, the
rest is placed back into the list for appropriate size.
Thus allocator gets requested memory aligned to minimum allocation size.

Freeing algo.
When user frees chunk of the memory, appropriate node and allocation CPU 
are selected for given memory regions (by dereferencing page->lru
fields). If current CPU does not correspond to allocation CPU, then
chunk is dereferenced into single-linked list entry and placed into list
of semi-free objects for freeing on original (allocation) CPU.
If freeing CPU is the same as allocation one, appropriate node is
checked and neighbours for being freed chunk are found. Free
neighbour(s) are then dereferenced into double linked list entry and
removed from appropriate lists of free elements. Then all free chunks
are combined into one and appropriate bitmask is updated in the node.
Chunk of (possibly) bigger size then is dereferenced into double-linked
list and placed into list of free objects for appropriate size.
Then freeing algo checks if list of "semi-free" objects (objects which
were started to be freed on different CPUs, but should be freed actually
on current one) is not empty, and if so, all chunks from that list are
freed as described above.

All above lists and arrays are not accessed by different CPUs, exept
"semi-freed" list, which is accessed under appropriate lock (each CPU
has it's own lock and list).

Defragmentation is a part of freeing algorithm and initial fragmentation
avoidance is being done at allocation time by removing power-of-two
allocations. Rate of fragmentation can be found in some userspace
modlling tests being done for both power-of-two SLAB-like and NTA
allocators. (more details on project's homepage [4]).

Benchmarks with trivial epoll based web server showed noticeble (more
than 40%) imrovements of the request rates (1600-1800 requests per
second vs. more than 2300 ones). It can be described by more
cache-friendly freeing algorithm, by tighter objects packing and thus
reduced cache line ping-pongs, reduced lookups into higher-layer caches
and so on.

Design of allocator allows to map all node's pages into userspace thus
allows to have true zero-copy support for both sending and receiving
dataflows.

As described in recent threads [3] it is also possible to eliminate any 
kind of main system OOM influence on network dataflow processing, thus 
it is possible to prevent deadlock for systems, which use network as 
memory storage (swap over network, iSCSI, NBD and so on).

The only changes in core network stack includes new field in struct
sk_buff to store size of the original skb (skb->truesize is not constant
anymore) and replace of kmalloc()/kfree() with avl_alloc()/avl_free().

Things in TODO list:
 * grow cache when predefined threshold of memory is used (simple task)
 * implement userspace mapping and move netchannels [2] into userspace
	(move netchannels to userspace is more complex task)

1. AVL tree.
http://en.wikipedia.org/wiki/AVL_tree

2. Netchannels implementation with alternative TCP/IP stack in kernel.
http://tservice.net.ru/~s0mbre/old/index.php?section=projects

3. Discussion about deadlock prevention in network based storage devices
http://thread.gmane.org/gmane.linux.kernel/434411/focus=434411
http://thread.gmane.org/gmane.linux.kernel/435986/focus=435986
http://thread.gmane.org/gmane.linux.kernel.mm/11682/focus=11682

4. Network tree allocator homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=nta

Current patch includes AVL tree implementation and other unused bits
for reference and will be removed in future releases.

Thank you.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 19c96d4..ded8b31 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -311,7 +311,7 @@ #endif
 
 
 	/* These elements must be at the end, see alloc_skb() for details.  */
-	unsigned int		truesize;
+	unsigned int		truesize, __tsize;
 	atomic_t		users;
 	unsigned char		*head,
 				*data,
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
index 0000000..a98ee88
--- /dev/null
+++ b/net/core/alloc/Makefile
@@ -0,0 +1,3 @@
+obj-y		:= allocator.o
+
+allocator-y	:= avl.o
diff --git a/net/core/alloc/avl.c b/net/core/alloc/avl.c
new file mode 100644
index 0000000..ff85519
--- /dev/null
+++ b/net/core/alloc/avl.c
@@ -0,0 +1,882 @@
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
+#define AVL_CONTAINER_ARRAY_SIZE	(AVL_MAX_SIZE/AVL_MIN_SIZE)
+#define AVL_NODES_ON_PAGE		(PAGE_SIZE/sizeof(struct avl_node))
+#define AVL_NODE_PAGES			((AVL_NODE_NUM+AVL_NODES_ON_PAGE-1)/AVL_NODES_ON_PAGE)
+
+struct avl_free_list
+{
+	struct avl_free_list		*next;
+	unsigned int			size;
+	unsigned int			cpu;
+};
+
+static avl_t avl_node_id[NR_CPUS];
+static struct avl_node **avl_node_array[NR_CPUS];
+static struct list_head *avl_container_array[NR_CPUS];
+static struct avl_node *avl_root[NR_CPUS];
+static struct avl_free_list *avl_free_list_head[NR_CPUS];
+static spinlock_t avl_free_lock[NR_CPUS];
+
+static inline struct avl_node *avl_get_node(avl_t id, int cpu)
+{
+	avl_t idx, off;
+
+	if (id >= AVL_NODE_NUM)
+		return NULL;
+	
+	idx = id/AVL_NODES_ON_PAGE;
+	off = id%AVL_NODES_ON_PAGE;
+
+	return &(avl_node_array[cpu][idx][off]);
+}
+
+static inline struct avl_node *avl_get_node_ptr(unsigned long ptr)
+{
+	struct page *page = virt_to_page(ptr);
+	struct avl_node *node = (struct avl_node *)(page->lru.next);
+
+	return node;
+}
+
+static inline void avl_set_node_ptr(unsigned long ptr, struct avl_node *node, int order)
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
+static inline int avl_get_cpu_ptr(unsigned long ptr)
+{
+	struct page *page = virt_to_page(ptr);
+	int cpu = (int)(unsigned long)(page->lru.prev);
+
+	return cpu;
+}
+
+static inline void avl_set_cpu_ptr(unsigned long ptr, int cpu, int order)
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
+static inline enum avl_balance avl_compare(struct avl_node *a, struct avl_node *b)
+{
+	if (a->value == b->value)
+		return AVL_BALANCED;
+	else if (a->value > b->value)
+		return AVL_RIGHT;
+	else
+		return AVL_LEFT;
+}
+
+static inline void avl_set_left(struct avl_node *node, avl_t val)
+{
+	node->left = val;
+}
+
+static inline void avl_set_right(struct avl_node *node, avl_t val)
+{
+	node->right = val;
+}
+
+static inline void avl_set_parent(struct avl_node *node, avl_t val)
+{
+	node->parent = val;
+}
+
+static inline void avl_rotate_complete(struct avl_node *parent, struct avl_node *node, int cpu)
+{
+	avl_set_parent(node, parent->parent);
+	if (parent->parent != AVL_NODE_EMPTY) {
+		if (parent->pos == AVL_RIGHT)
+			avl_set_right(avl_get_node(parent->parent, cpu), node->id);
+		else
+			avl_set_left(avl_get_node(parent->parent, cpu), node->id);
+	}
+	avl_set_parent(parent, node->id);
+}
+
+static inline void avl_ll(struct avl_node *node, int cpu)
+{
+	struct avl_node *parent = avl_get_node(node->parent, cpu);
+	struct avl_node *left = avl_get_node(node->left, cpu);
+	
+	avl_rotate_complete(parent, node, cpu);
+	avl_set_left(node, parent->id);
+	node->pos = parent->pos;
+	parent->pos = AVL_LEFT;
+	if (!left) {
+		avl_set_right(parent, AVL_NODE_EMPTY);
+	} else {
+		avl_set_parent(left, parent->id);
+		left->pos = AVL_RIGHT;
+		avl_set_right(parent, left->id);
+	}
+}
+
+static inline void avl_rr(struct avl_node *node, int cpu)
+{
+	struct avl_node *parent = avl_get_node(node->parent, cpu);
+	struct avl_node *right = avl_get_node(node->right, cpu);
+
+	avl_rotate_complete(parent, node, cpu);
+	avl_set_right(node, parent->id);
+	node->pos = parent->pos;
+	parent->pos = AVL_RIGHT;
+	if (!right)
+		avl_set_left(parent, AVL_NODE_EMPTY);
+	else {
+		avl_set_parent(right, parent->id);
+		right->pos = AVL_LEFT;
+		avl_set_left(parent, right->id);
+	}
+}
+
+static inline void avl_rl_balance(struct avl_node *node, int cpu)
+{
+	avl_rr(node, cpu);
+	avl_ll(node, cpu);
+}
+
+static inline void avl_lr_balance(struct avl_node *node, int cpu)
+{
+	avl_ll(node, cpu);
+	avl_rr(node, cpu);
+}
+
+static inline void avl_balance_single(struct avl_node *node, struct avl_node *parent)
+{
+	node->balance = parent->balance = AVL_BALANCED;
+}
+
+static inline void avl_ll_balance(struct avl_node *node, int cpu)
+{
+	struct avl_node *parent = avl_get_node(node->parent, cpu);
+
+	avl_ll(node, cpu);
+	avl_balance_single(node, parent);
+}
+
+static inline void avl_rr_balance(struct avl_node *node, int cpu)
+{
+	struct avl_node *parent = avl_get_node(node->parent, cpu);
+
+	avl_rr(node, cpu);
+	avl_balance_single(node, parent);
+}
+
+static void avl_calc_balance_insert(struct avl_node *a, struct avl_node *b, struct avl_node *x, int cpu)
+{
+	int ao;
+
+	if (!a || !b || !x)
+		goto out;
+
+	ao = (a->balance == avl_compare(x, a));
+
+	if (ao) {
+		if (a->balance == AVL_LEFT) {
+			if (b->balance == AVL_LEFT) {
+				avl_rr_balance(b, cpu);
+			} else if (b->balance == AVL_RIGHT) {
+				avl_lr_balance(x, cpu);
+				switch (x->balance) {
+					case AVL_LEFT:
+						a->balance = AVL_RIGHT;
+						b->balance = AVL_BALANCED;
+						break;
+					case AVL_RIGHT:
+						a->balance = AVL_BALANCED;
+						b->balance = AVL_LEFT;
+						break;
+					case AVL_BALANCED:
+						a->balance = b->balance = AVL_BALANCED;
+						break;
+				}
+				x->balance = AVL_BALANCED;
+			}
+		} else if (a->balance == AVL_RIGHT){
+			if (b->balance == AVL_RIGHT) {
+				avl_ll_balance(b, cpu);
+			} else if (b->balance == AVL_LEFT) {
+				avl_rl_balance(x, cpu);
+				switch (x->balance) {
+					case AVL_LEFT:
+						a->balance = AVL_BALANCED;
+						b->balance = AVL_RIGHT;
+						break;
+					case AVL_RIGHT:
+						a->balance = AVL_LEFT;
+						b->balance = AVL_BALANCED;
+						break;
+					case AVL_BALANCED:
+						a->balance = b->balance = AVL_BALANCED;
+						break;
+				}
+				x->balance = AVL_BALANCED;
+			}
+		}
+	}
+out:
+	return;
+}
+
+static void avl_combine_nodes(struct avl_node *root, struct avl_node *node)
+{
+}
+
+static struct avl_node *__avl_set_balance(struct avl_node *node, enum avl_balance type)
+{
+	if (node->balance == AVL_BALANCED)
+		node->balance = type;
+	else if (node->balance != type)
+		node->balance = AVL_BALANCED;
+	else
+		return node;
+
+	return NULL;
+}
+
+static struct avl_node *avl_set_balance(struct avl_node *node, enum avl_balance type, int cpu)
+{
+	struct avl_node *root = avl_root[cpu];
+
+	if (__avl_set_balance(node, type))
+		return node;
+		
+	if (node->balance == AVL_BALANCED)
+		return NULL;
+
+	type = node->pos;
+	while ((node = avl_get_node(node->parent, cpu)) && node != root) {
+		if (__avl_set_balance(node, type))
+			break;
+		if (node->balance == AVL_BALANCED) {
+			node = NULL;
+			break;
+		}
+		type = node->pos;
+	}
+
+	if (node == root)
+		node = NULL;
+
+	return node;
+}
+
+static struct avl_node *avl_try_insert(struct avl_node *r, struct avl_node *root, 
+		struct avl_node *node, enum avl_balance type, int cpu)
+{
+	struct avl_node *s = NULL, *c = NULL, *R;
+	enum avl_balance t;
+
+	if (type == AVL_BALANCED) {
+		avl_combine_nodes(root, node);
+		return NULL;
+	}
+
+	if (type == AVL_RIGHT && root->right != AVL_NODE_EMPTY)
+		return avl_get_node(root->right, cpu);
+	if (type == AVL_LEFT && root->left != AVL_NODE_EMPTY)
+		return avl_get_node(root->left, cpu);
+
+	R = avl_set_balance(root, type, cpu);
+	if (type == AVL_RIGHT)
+		avl_set_right(root, node->id);
+	else
+		avl_set_left(root, node->id);
+	avl_set_parent(node, root->id);
+	node->pos = type;
+
+	if (!R)
+		return NULL;
+
+	t = avl_compare(node, r);
+	if (t == AVL_RIGHT)
+		s = avl_get_node(r->right, cpu);
+	else if (t == AVL_LEFT)
+		s = avl_get_node(r->left, cpu);
+
+	if (s) {
+		t = avl_compare(node, s);
+
+		if (t == AVL_RIGHT)
+			c = avl_get_node(s->right, cpu);
+		else if (t == AVL_LEFT)
+			c = avl_get_node(s->left, cpu);
+	}
+
+	avl_calc_balance_insert(r, s, c, cpu);
+
+	return NULL;
+}
+
+static void avl_insert(struct avl_node *root, struct avl_node *node, int cpu)
+{
+	struct avl_node *r, *s;
+
+	r = s = root;
+
+	while (root) {
+		enum avl_balance type = avl_compare(node, root);
+
+		s = avl_try_insert(r, root, node, type, cpu);
+
+		if (!s)
+			break;
+		if (type != AVL_BALANCED && root->balance == type)
+			r = root;
+		root = s;
+	}
+}
+
+static struct avl_node *avl_node_alloc(value_t value, int cpu)
+{
+	struct avl_node *node = avl_get_node(avl_node_id[cpu], cpu);
+
+	if (!node) {
+		avl_t idx, off;
+
+		idx = avl_node_id[cpu]/AVL_NODES_ON_PAGE;
+		off = avl_node_id[cpu]%AVL_NODES_ON_PAGE;
+		printk("%s: value: %lx, id: %u, max: %lu, cpu: %d, idx: %u, off: %u, on_page: %lu, node: %zu, pages: %lu.\n", 
+				__func__, value, avl_node_id[cpu], AVL_NODE_NUM, cpu, idx, off, 
+				AVL_NODES_ON_PAGE, sizeof(struct avl_node), AVL_NODE_PAGES);
+	}
+	BUG_ON(!node);
+
+	node->value = value;
+	node->balance = AVL_BALANCED;
+	node->left = node->right = node->parent = AVL_NODE_EMPTY;
+	node->id = avl_node_id[cpu]++;
+	memset(node->mask, 0xff, sizeof(node->mask));
+
+	return node;
+}
+
+static struct avl_node *avl_search(value_t value, int cpu)
+{
+	struct avl_node *node = avl_root[cpu];
+
+	while (node) {
+		if (value < node->value)
+			node = avl_get_node(node->left, cpu);
+		else if (value > node->value)
+			node = avl_get_node(node->right, cpu);
+		else
+			break;
+	}
+
+	return node;
+}
+
+static struct avl_node *avl_node_search_alloc(value_t value, int cpu)
+{
+	struct avl_node *node;
+
+	node = avl_search(value, cpu);
+	if (!node) {
+		node = avl_node_alloc(value, cpu);
+		if (node) {
+			avl_set_cpu_ptr(value, cpu, AVL_ORDER);
+			avl_set_node_ptr(value, node, AVL_ORDER);
+			avl_insert(avl_get_node(avl_root[cpu]->right, cpu), node, cpu);
+		}
+	}
+
+	return node;
+}
+
+static inline value_t avl_ptr_to_value(void *ptr)
+{
+	struct avl_node *node = avl_get_node_ptr((unsigned long)ptr);
+	return node->value;
+}
+
+static inline int avl_ptr_to_offset(void *ptr)
+{
+	return ((value_t)ptr - avl_ptr_to_value(ptr))/AVL_MIN_SIZE;
+}
+
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
+static void avl_fill_bits(struct avl_node *node, unsigned long *mask, unsigned int mask_size, 
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
+static inline void avl_container_insert(struct avl_container *c, unsigned int pos, int cpu)
+{
+	list_add_tail(&c->centry, &avl_container_array[cpu][pos]);
+}
+
+static void avl_update_node(struct avl_container *c, unsigned int cpos, unsigned int size)
+{
+	struct avl_node *node = avl_get_node_ptr((unsigned long)c->ptr);
+	unsigned int num = AVL_ALIGN(size)/AVL_MIN_SIZE;
+
+	BUG_ON(cpos < num - 1);
+
+	avl_fill_bits(node, node->mask, ARRAY_SIZE(node->mask), avl_ptr_to_offset(c->ptr), num, 0);
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
+static int avl_container_add(void *ptr, unsigned int size, gfp_t gfp_mask, int cpu)
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
+void *avl_alloc(unsigned int size, gfp_t gfp_mask)
+{
+	unsigned int i;
+	void *ptr = NULL;
+	unsigned long flags;
+
+	size = AVL_ALIGN(size);
+
+	if (size > AVL_MAX_SIZE || size < AVL_MIN_SIZE)
+		return NULL;
+
+	local_irq_save(flags);
+	for (i=size/AVL_MIN_SIZE-1; i<AVL_CONTAINER_ARRAY_SIZE; ++i) {
+		struct list_head *head = &avl_container_array[smp_processor_id()][i];
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
+	if (!ptr) {
+		printk("%s: Failed to allocate %u bytes with %02x mode.\n", __func__, size, gfp_mask);
+		WARN_ON(1);
+	}
+
+	return ptr;
+}
+
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
+static void avl_combine(struct avl_node *node, void *lp, unsigned int lbits, void *rp, unsigned int rbits, 
+		void *cur_ptr, unsigned int cur_bits, gfp_t gfp_mask, int cpu)
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
+		if (!c) {
+			c = lc;
+			c->ptr = cur_ptr;
+		}
+		idx += lbits;
+		ptr = c->ptr;
+	}
+	if (!c) {
+		if (avl_container_add(cur_ptr, cur_bits*AVL_MIN_SIZE, gfp_mask, cpu))
+			return;
+	} else {
+		avl_container_insert(c, idx, cpu);
+	}
+}
+
+static void __avl_free(void *ptr, unsigned int size, gfp_t gfp_mask)
+{
+	value_t val = avl_ptr_to_value(ptr);
+	unsigned int pos, idx, sbits = AVL_ALIGN(size)/AVL_MIN_SIZE;
+	unsigned int rbits, lbits, cpu = avl_get_cpu_ptr(val);
+	struct avl_node *node;
+	unsigned long p;
+	void *lp, *rp;
+
+	if (cpu != smp_processor_id()) {
+		struct avl_free_list *l, *this = ptr;
+
+		this->cpu = smp_processor_id();
+		this->size = size;
+
+		spin_lock(&avl_free_lock[cpu]);
+		l = avl_free_list_head[cpu];
+		avl_free_list_head[cpu] = this;
+		this->next = l;
+		spin_unlock(&avl_free_lock[cpu]);
+		return;
+	}
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
+	avl_fill_bits(node, node->mask, ARRAY_SIZE(node->mask), pos, sbits, 1);
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
+	avl_combine(node, lp, lbits, rp, rbits, ptr, sbits, gfp_mask, cpu);
+}
+
+void avl_free(void *ptr, unsigned int size)
+{
+	unsigned long flags;
+	struct avl_free_list *l;
+	int cpu;
+
+	local_irq_save(flags);
+	__avl_free(ptr, size, GFP_ATOMIC);
+	
+	cpu = smp_processor_id();
+
+	while (avl_free_list_head[cpu]) {
+		spin_lock(&avl_free_lock[cpu]);
+		l = avl_free_list_head[cpu];
+		avl_free_list_head[cpu] = l->next;
+		spin_unlock(&avl_free_lock[cpu]);
+		__avl_free(l, l->size, GFP_ATOMIC);
+	};
+	local_irq_restore(flags);
+}
+
+static void avl_fini_cpu(int cpu)
+{
+	int i;
+
+	for (i=0; i<AVL_NODE_NUM; ++i) {
+		struct avl_node *node = avl_get_node(i, cpu);
+		if (node->value)
+			free_page(node->value);
+		node->value = 0;
+	}
+	
+	kfree(avl_container_array[cpu]);
+	
+	for (i=0; i<AVL_NODE_PAGES; ++i)
+		kfree(avl_node_array[cpu][i]);
+}
+
+static int avl_init_cpu(int cpu)
+{
+	unsigned int i;
+	int err;
+	unsigned long ptr;
+	
+	spin_lock_init(&avl_free_lock[cpu]);
+
+	avl_node_array[cpu] = kzalloc(AVL_NODE_PAGES * sizeof(void *), GFP_KERNEL);
+	if (!avl_node_array[cpu])
+		return -ENOMEM;
+	
+	for (i=0; i<AVL_NODE_PAGES; ++i) {
+		avl_node_array[cpu][i] = (struct avl_node *)__get_free_page(GFP_KERNEL);
+		if (!avl_node_array[cpu][i])
+			goto err_out_free_node;
+	}
+
+	avl_container_array[cpu] = kzalloc(sizeof(struct list_head) * AVL_CONTAINER_ARRAY_SIZE, GFP_KERNEL);
+	if (!avl_container_array[cpu])
+		goto err_out_free_node;
+
+	for (i=0; i<AVL_CONTAINER_ARRAY_SIZE; ++i)
+		INIT_LIST_HEAD(&avl_container_array[cpu][i]);
+
+	/*
+	 * NTA steals pages and never return them back to the system.
+	 */
+	ptr = __get_free_pages(GFP_KERNEL, AVL_ORDER);
+	if (!ptr)
+		goto err_out_free_container;
+
+	avl_root[cpu] = avl_node_alloc(ptr, cpu);
+	avl_set_cpu_ptr(ptr, cpu, AVL_ORDER);
+	avl_set_node_ptr(ptr, avl_root[cpu], AVL_ORDER);
+
+	avl_insert(avl_root[cpu], avl_node_alloc(ptr, cpu), cpu);
+	err = avl_container_add((void *)ptr, PAGE_SIZE*(1<<AVL_ORDER), GFP_KERNEL, cpu);
+	if (err) {
+		printk(KERN_ERR "Failed to add new container: ptr: %lx, size: %lu, err: %d.\n", ptr, PAGE_SIZE, err);
+		goto err_out_free_values;
+	}
+
+	for (i=0; i<AVL_NODE_NUM-2; ++i) {
+		ptr = __get_free_pages(GFP_KERNEL, AVL_ORDER);
+		if (!ptr) {
+			printk(KERN_ERR "Failed to allocate %d'th page.\n", i);
+			goto err_out_free_values;
+		}
+
+		avl_node_search_alloc(ptr, cpu);
+		err = avl_container_add((void *)ptr, PAGE_SIZE*(1<<AVL_ORDER), GFP_KERNEL, cpu);
+		if (err) {
+			printk(KERN_ERR "Failed to add new container: ptr: %lx, size: %lu, err: %d.\n", ptr, PAGE_SIZE, err);
+			goto err_out_free_values;
+		}
+	}
+
+	return 0;
+
+err_out_free_values:
+	for (i=0; i<AVL_NODE_NUM - 1; ++i) {
+		struct avl_node *node = avl_get_node(i, cpu);
+		if (node->value)
+			free_page(node->value);
+		node->value = 0;
+	}
+	
+err_out_free_container:
+	kfree(avl_container_array[cpu]);
+err_out_free_node:
+	for (i=0; i<AVL_NODE_PAGES; ++i)
+		kfree(avl_node_array[cpu][i]);
+		
+	kfree(avl_node_array[cpu]);
+
+	return -ENOMEM;
+}
+
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
+	for_each_possible_cpu(cpu)
+		avl_fini_cpu(cpu);
+
+	return -ENOMEM;
+}
diff --git a/net/core/alloc/avl.h b/net/core/alloc/avl.h
new file mode 100644
index 0000000..e6f8b6c
--- /dev/null
+++ b/net/core/alloc/avl.h
@@ -0,0 +1,84 @@
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
+typedef unsigned long value_t;
+typedef u16 avl_t;
+
+#define AVL_ALIGN_SIZE		32
+#define AVL_ALIGN(x) 		ALIGN(x, AVL_ALIGN_SIZE)
+
+#define AVL_ORDER		2
+#define AVL_BITS		10	/* Must cover maximum number of pages used for allocation pools */
+#define AVL_NODE_EMPTY		((1UL<<AVL_BITS) - 1)
+
+#define AVL_MIN_SIZE		AVL_ALIGN_SIZE
+#define AVL_MAX_SIZE		(AVL_MIN_SIZE * AVL_NODE_EMPTY)
+#define AVL_NODE_NUM		(AVL_NODE_EMPTY - 1)
+
+enum avl_balance {
+	AVL_LEFT = 0,
+	AVL_RIGHT,
+	AVL_BALANCED,
+};
+
+struct avl_node
+{
+	u64			left:AVL_BITS,
+				right:AVL_BITS,
+				parent:AVL_BITS,
+				id:AVL_BITS,
+				balance:2,
+				pos:1,
+				res:(64-4*AVL_BITS)-3;
+	value_t			value;
+	DECLARE_BITMAP(mask, (1<<AVL_ORDER)*PAGE_SIZE/AVL_MIN_SIZE);
+};
+
+struct avl_container
+{
+	void			*ptr;
+	struct list_head	centry;
+};
+
+struct avl_container *avl_container_alloc(gfp_t gfp_mask);
+void avl_container_free(struct avl_container *);
+int avl_container_cache_init(void);
+
+#endif /* __AVL_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 022d889..7239208 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -156,7 +156,7 @@ struct sk_buff *__alloc_skb(unsigned int
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
 	size = SKB_DATA_ALIGN(size);
-	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	data = avl_alloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
@@ -176,6 +176,8 @@ struct sk_buff *__alloc_skb(unsigned int
 	shinfo->gso_type = 0;
 	shinfo->ip6_frag_id = 0;
 	shinfo->frag_list = NULL;
+	
+	skb->__tsize = size + sizeof(struct skb_shared_info);
 
 	if (fclone) {
 		struct sk_buff *child = skb + 1;
@@ -223,7 +225,7 @@ struct sk_buff *alloc_skb_from_cache(kme
 
 	/* Get the DATA. */
 	size = SKB_DATA_ALIGN(size);
-	data = kmem_cache_alloc(cp, gfp_mask);
+	data = avl_alloc(size, gfp_mask);
 	if (!data)
 		goto nodata;
 
@@ -234,6 +236,7 @@ struct sk_buff *alloc_skb_from_cache(kme
 	skb->data = data;
 	skb->tail = data;
 	skb->end  = data + size;
+	skb->__tsize = size;
 
 	atomic_set(&(skb_shinfo(skb)->dataref), 1);
 	skb_shinfo(skb)->nr_frags  = 0;
@@ -313,7 +316,7 @@ static void skb_release_data(struct sk_b
 		if (skb_shinfo(skb)->frag_list)
 			skb_drop_fraglist(skb);
 
-		kfree(skb->head);
+		avl_free(skb->head, skb->__tsize);
 	}
 }
 
@@ -495,6 +498,7 @@ #endif
 	skb_copy_secmark(n, skb);
 #endif
 	C(truesize);
+	C(__tsize);
 	atomic_set(&n->users, 1);
 	C(head);
 	C(data);
@@ -688,7 +692,7 @@ int pskb_expand_head(struct sk_buff *skb
 
 	size = SKB_DATA_ALIGN(size);
 
-	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	data = avl_alloc(size + sizeof(struct skb_shared_info), gfp_mask);
 	if (!data)
 		goto nodata;
 
@@ -707,6 +711,7 @@ int pskb_expand_head(struct sk_buff *skb
 
 	off = (data + nhead) - skb->head;
 
+	skb->__tsize = size + sizeof(struct skb_shared_info);
 	skb->head     = data;
 	skb->end      = data + size;
 	skb->data    += off;
@@ -2057,6 +2062,9 @@ void __init skb_init(void)
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
