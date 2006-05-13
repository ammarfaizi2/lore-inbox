Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWEMQF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWEMQF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWEMQF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:05:57 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:38966 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932456AbWEMQF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:05:56 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Date: Sat, 13 May 2006 17:05:41 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060513160541.8848.2113.stgit@localhost.localdomain>
In-Reply-To: <20060513155757.8848.11980.stgit@localhost.localdomain>
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the base support for the kernel memory leak detector. It
traces the memory allocation/freeing in a way similar to the Boehm's
conservative garbage collector, the difference being that the orphan
pointers are not freed but only shown in /proc/memleak. Enabling this
feature would introduce an overhead to memory allocations.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 include/linux/kernel.h  |   13 +
 include/linux/memleak.h |   55 +++++
 init/main.c             |    5 
 lib/Kconfig.debug       |   11 +
 mm/Makefile             |    2 
 mm/memleak.c            |  549 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 632 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e1bd084..988e368 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,9 @@ #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#ifdef CONFIG_DEBUG_MEMLEAK
+#include <linux/memleak.h>
+#endif
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -283,9 +286,17 @@ #define max_t(type,x,y) \
  * @member:	the name of the member within the struct.
  *
  */
-#define container_of(ptr, type, member) ({			\
+#define __container_of(ptr, type, member) ({			\
         const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
         (type *)( (char *)__mptr - offsetof(type,member) );})
+#ifdef CONFIG_DEBUG_MEMLEAK
+#define container_of(ptr, type, member) ({			\
+	DECLARE_MEMLEAK_OFFSET(container_of, type, member);	\
+	__container_of(ptr, type, member);			\
+})
+#else
+#define container_of(ptr, type, member) __container_of(ptr, type, member)
+#endif
 
 /*
  * Check at compile time that something is of a particular type.
diff --git a/include/linux/memleak.h b/include/linux/memleak.h
new file mode 100644
index 0000000..86763b4
--- /dev/null
+++ b/include/linux/memleak.h
@@ -0,0 +1,55 @@
+/*
+ * include/linux/memleak.h
+ *
+ * Copyright (C) 2006 ARM Limited
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __MEMLEAK_H
+#define __MEMLEAK_H
+
+#include <linux/compiler.h>
+
+
+struct memleak_offset {
+	unsigned long offset;
+	unsigned long size;
+	unsigned long member_size;
+};
+
+/* if (&((TYPE *) 0)->MEMBER) is not a constant known at compile time,
+ * just use 0 instead since we cannot add it to the
+ * .init.memleak_offsets section
+ */
+#define memleak_offsetof(type, member)				\
+	(__builtin_constant_p(&((type *) 0)->member) ?		\
+	 ((size_t) &((type *) 0)->member) : 0)
+
+#define DECLARE_MEMLEAK_OFFSET(name, type, member)		\
+	static const struct memleak_offset			\
+	__attribute__ ((__section__ (".init.memleak_offsets")))	\
+	__attribute_used__ __memleak_offset__##name = {		\
+		memleak_offsetof(type, member),			\
+		sizeof(type),					\
+		sizeof(((type *) 0)->member)			\
+	}
+
+extern int memleak_init(void);
+/* Allocation/freeing hooks for pointers tracking */
+extern void memleak_alloc(const void *ptr, size_t size, int ref_count);
+extern void memleak_free(const void *ptr);
+
+#endif	/* __MEMLEAK_H */
diff --git a/init/main.c b/init/main.c
index f715b9b..6304628 100644
--- a/init/main.c
+++ b/init/main.c
@@ -513,6 +513,10 @@ #endif
 	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
+	radix_tree_init();
+#ifdef CONFIG_DEBUG_MEMLEAK
+	memleak_init();
+#endif
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	if (late_time_init)
@@ -533,7 +537,6 @@ #endif
 	key_init();
 	security_init();
 	vfs_caches_init(num_physpages);
-	radix_tree_init();
 	signals_init();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6ecc180..5519d55 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -89,6 +89,17 @@ config DEBUG_SLAB_LEAK
 	bool "Memory leak debugging"
 	depends on DEBUG_SLAB
 
+config DEBUG_MEMLEAK
+	bool "Kernel memory leak detector"
+	depends on DEBUG_KERNEL && SLAB
+	help
+	  Say Y here if you want to enable the memory leak
+	  detector. The memory allocation/freeing is traced in a way
+	  similar to the Boehm's conservative garbage collector, the
+	  difference being that the orphan pointers are not freed but
+	  only shown in /proc/memleak. Enabling this feature would
+	  introduce an overhead to memory allocations.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
diff --git a/mm/Makefile b/mm/Makefile
index 0b8f73f..d487d96 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -23,4 +23,4 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
-
+obj-$(CONFIG_DEBUG_MEMLEAK) += memleak.o
diff --git a/mm/memleak.c b/mm/memleak.c
new file mode 100644
index 0000000..aacdeb4
--- /dev/null
+++ b/mm/memleak.c
@@ -0,0 +1,549 @@
+/*
+ * mm/memleak.c
+ *
+ * Copyright (C) 2006 ARM Limited
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+/* #define DEBUG */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/radix-tree.h>
+#include <linux/gfp.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/kallsyms.h>
+#include <linux/mman.h>
+#include <linux/nodemask.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include <linux/mutex.h>
+
+#include <asm/bitops.h>
+#include <asm/sections.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+
+#include <linux/memleak.h>
+
+
+#ifdef CONFIG_FRAME_POINTER
+#define MAX_TRACE	4
+#else
+#define MAX_TRACE	1
+#endif
+
+
+extern struct memleak_offset __memleak_offsets_start[];
+extern struct memleak_offset __memleak_offsets_end[];
+
+
+struct memleak_alias {
+	struct hlist_node node;
+	unsigned long offset;
+};
+
+struct memleak_pointer {
+	struct list_head pointer_list;
+	struct list_head grey_list;
+	unsigned long pointer;
+	size_t size;
+	int ref_count;			/* the minimum ecounters of the value */
+	int count;			/* the ecounters of the value */
+	struct hlist_head *alias_list;
+	unsigned long trace[MAX_TRACE];
+};
+
+#define COLOR_WHITE(pointer)	((pointer)->count != -1 && (pointer)->count < (pointer)->ref_count)
+#define COLOR_GREY(pointer)	((pointer)->count >= (pointer)->ref_count)
+
+
+/* Tree storing the pointer aliases indexed by size */
+static RADIX_TREE(alias_tree, GFP_KERNEL);
+/* Tree storing all the possible pointers, indexed by the pointer value */
+static RADIX_TREE(pointer_tree, GFP_ATOMIC);
+/* The list of all allocated pointers */
+static LIST_HEAD(pointer_list);
+/* The list of the grey pointers */
+static LIST_HEAD(grey_list);
+
+static kmem_cache_t *pointer_cache;
+/* Used to avoid recursive call via the kmalloc/kfree functions */
+static spinlock_t memleak_lock = SPIN_LOCK_UNLOCKED;
+static int memleak_initialised = 0;
+static unsigned long memleak_running = 0;
+static DEFINE_MUTEX(memleak_mutex);
+
+
+/* Insert an element into the aliases radix tree.
+ * Return 0 on success.
+ */
+static inline int __init insert_alias(unsigned long size, unsigned long offset)
+{
+	int ret = 0;
+	struct hlist_head *alias_list;
+	struct memleak_alias *alias;
+
+	alias_list = radix_tree_lookup(&alias_tree, size);
+	if (alias_list) {
+		struct hlist_node *elem;
+
+		hlist_for_each_entry(alias, elem, alias_list, node) {
+			if (alias->offset == offset) {
+				ret = -EEXIST;
+				goto out;
+			}
+		}
+	} else {
+		alias_list = kmalloc(sizeof(struct hlist_head), GFP_KERNEL);
+		if (!alias_list)
+			panic("kmemleak: cannot allocate initial memory\n");
+		INIT_HLIST_HEAD(alias_list);
+
+		ret = radix_tree_insert(&alias_tree, size, alias_list);
+		if (ret)
+			panic("kmemleak: cannot insert into the aliases radix tree: %d\n", ret);
+	}
+
+	alias = kmalloc(sizeof(struct memleak_alias), GFP_KERNEL);
+	if (!alias)
+		panic("kmemleak: cannot allocate initial memory\n");
+	INIT_HLIST_NODE(&alias->node);
+	alias->offset = offset;
+
+	hlist_add_head(&alias->node, alias_list);
+
+ out:
+	return ret;
+}
+
+/* Insert a pointer and its aliases into the pointer radix tree
+ */
+static inline void insert_pointer(unsigned long ptr, size_t size, int ref_count)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+	struct memleak_pointer *pointer;
+	int err, i;
+#ifdef CONFIG_FRAME_POINTER
+	void *frame;
+#endif
+
+	pointer = kmem_cache_alloc(pointer_cache, SLAB_ATOMIC);
+	if (!pointer)
+		panic("kmemleak: cannot allocate a memleak_pointer structure\n");
+
+	INIT_LIST_HEAD(&pointer->pointer_list);
+	INIT_LIST_HEAD(&pointer->grey_list);
+	pointer->pointer = ptr;
+	pointer->size = size;
+	pointer->ref_count = ref_count;
+	pointer->count = -1;
+	pointer->alias_list = radix_tree_lookup(&alias_tree, size);
+
+#ifdef CONFIG_FRAME_POINTER
+	frame = __builtin_frame_address(0);
+	for (i = 0; i < MAX_TRACE; i++) {
+		if (kstack_end(frame)) {
+			pointer->trace[i] = 0;
+			continue;
+		}
+
+		pointer->trace[i] = arch_call_address(frame);
+		frame = arch_prev_frame(frame);
+		/* we don't need the return to do_exit() */
+		if (kstack_end(frame))
+			pointer->trace[i] = 0;
+	}
+#else
+	pointer->trace[0] = __builtin_return_address(0);
+#endif
+
+	err = radix_tree_insert(&pointer_tree, ptr, pointer);
+	if (err) {
+		dump_stack();
+		panic("kmemleak: cannot insert into the pointer radix tree: %d\n", err);
+	}
+
+	if (pointer->alias_list) {
+		hlist_for_each_entry(alias, elem, pointer->alias_list, node) {
+			if (alias->offset >= size)
+				BUG();
+
+			err = radix_tree_insert(&pointer_tree, ptr + alias->offset, pointer);
+			if (err) {
+				dump_stack();
+				panic("kmemleak: cannot insert alias into the pointer radix tree: %d\n", err);
+			}
+		}
+	}
+
+	list_add_tail(&pointer->pointer_list, &pointer_list);
+}
+
+/* Remove a pointer and its aliases from the pointer radix tree
+ */
+static inline void delete_pointer(unsigned long ptr)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+	struct memleak_pointer *pointer;
+
+	pointer = radix_tree_delete(&pointer_tree, ptr);
+	if (!pointer) {
+		printk(KERN_WARNING "kmemleak: freeing unknown pointer value 0x%08lx\n", ptr);
+		return;
+	}
+	if (pointer->pointer != ptr) {
+		dump_stack();
+		panic("kmemleak: freeing pointer by alias 0x%08lx\n", ptr);
+	}
+	if (COLOR_WHITE(pointer))
+		printk(KERN_WARNING "kmemleak: freeing orphan pointer 0x%08lx\n", ptr);
+
+	if (pointer->alias_list) {
+		hlist_for_each_entry(alias, elem, pointer->alias_list, node) {
+			if (!radix_tree_delete(&pointer_tree, ptr + alias->offset))
+				panic("kmemleak: cannot find pointer alias 0x%08lx, 0x%lx\n",
+				      ptr, alias->offset);
+		}
+	}
+
+	list_del(&pointer->pointer_list);
+
+	kmem_cache_free(pointer_cache, pointer);
+}
+
+/* Allocation function hook
+ */
+void memleak_alloc(const void *ptr, size_t size, int ref_count)
+{
+	unsigned long flags;
+	unsigned int cpu_id = smp_processor_id();
+
+	if (!ptr)
+		return;
+
+	local_irq_save(flags);
+
+	/* avoid recursive calls. After disabling the interrupts, the
+	 * only calls to this function on the same CPU should be from
+	 * kmemleak itself and we ignore them. Calls from other CPU's
+	 * would wait on the spin_lock.
+	 */
+	if (!test_and_set_bit(cpu_id, &memleak_running)) {
+		spin_lock(&memleak_lock);
+
+		if (memleak_initialised) {
+			pr_debug("kmemleak: memleak_alloc(%p, %d)\n", ptr, size);
+			insert_pointer((unsigned long) ptr, size, ref_count);
+		}
+
+		spin_unlock(&memleak_lock);
+
+		clear_bit(cpu_id, &memleak_running);
+	}
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(memleak_alloc);
+
+/* Freeing function hook
+ */
+void memleak_free(const void *ptr)
+{
+	unsigned long flags;
+	unsigned int cpu_id = smp_processor_id();
+
+	if (!ptr)
+		return;
+
+	local_irq_save(flags);
+
+	/* avoid recursive calls. See memleak_alloc() for an explanation
+	 */
+	if (!test_and_set_bit(cpu_id, &memleak_running)) {
+		spin_lock(&memleak_lock);
+
+		if (memleak_initialised) {
+			pr_debug("kmemleak: memleak_free(%p)\n", ptr);
+			delete_pointer((unsigned long) ptr);
+		}
+
+		spin_unlock(&memleak_lock);
+
+		clear_bit(cpu_id, &memleak_running);
+	}
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(memleak_free);
+
+/* Scan a block of memory (exclusive range) for pointers and move
+ * those found to the grey list
+ */
+static void memleak_scan_block(void *_start, void *_end)
+{
+	unsigned long *ptr;
+	unsigned long *start = _start;
+	unsigned long *end = _end;
+
+	for (ptr = start; ptr < end; ptr++) {
+		struct memleak_pointer *pointer =
+			radix_tree_lookup(&pointer_tree, *ptr);
+		if (!pointer)
+			continue;
+		if (!COLOR_WHITE(pointer))
+			continue;
+
+		pointer->count++;
+		if (COLOR_GREY(pointer))
+			list_add_tail_rcu(&pointer->grey_list, &grey_list);
+	}
+}
+
+/* Scan the memory and print the orphan pointers
+ */
+static void memleak_scan(void)
+{
+	unsigned long flags;
+	struct memleak_pointer *pointer;
+	struct task_struct *task;
+	int node;
+#ifdef CONFIG_SMP
+	int i;
+#endif
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	list_for_each_entry_rcu(pointer, &pointer_list, pointer_list) {
+		pointer->count = 0;
+	}
+
+	/* data/bss scanning */
+	memleak_scan_block(_sdata, _edata);
+	memleak_scan_block(__bss_start, __bss_stop);
+
+#ifdef CONFIG_SMP
+	/* per-cpu scanning */
+	for (i = 0; i < NR_CPUS; i++)
+		memleak_scan_block(__per_cpu_offset[i] + __per_cpu_start,
+				   __per_cpu_offset[i] + __per_cpu_end);
+#endif
+
+	/* mem_map scanning */
+	for_each_online_node(node) {
+		struct page *page, *end;
+
+		page = NODE_MEM_MAP(node);
+		end  = page + NODE_DATA(node)->node_spanned_pages;
+
+		memleak_scan_block(page, end);
+	}
+
+	/* task stacks scanning */
+	for_each_process(task)
+		memleak_scan_block(task_stack_page(task),
+				   task_stack_page(task) + THREAD_SIZE);
+
+	/* grey_list scanning */
+	list_for_each_entry_rcu(pointer, &grey_list, grey_list) {
+		memleak_scan_block((void *) pointer->pointer,
+				   (void *) (pointer->pointer + pointer->size));
+		list_del_rcu(&pointer->grey_list);
+	}
+
+	spin_unlock_irqrestore(&memleak_lock, flags);
+}
+
+#ifdef CONFIG_PROC_FS
+static void *memleak_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct memleak_pointer *pointer;
+	loff_t n = *pos;
+
+	mutex_lock(&memleak_mutex);
+
+	if (!n)
+		memleak_scan();
+
+	list_for_each_entry_rcu(pointer, &pointer_list, pointer_list) {
+		if (!n--)
+			return pointer;
+	}
+
+	return NULL;
+}
+
+static void *memleak_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct list_head *n = ((struct memleak_pointer *) v)->pointer_list.next;
+
+	++(*pos);
+
+	return (n != &pointer_list)
+		? list_entry(n, struct memleak_pointer, pointer_list)
+		: NULL;
+}
+
+static void memleak_seq_stop(struct seq_file *seq, void *v)
+{
+	mutex_unlock(&memleak_mutex);
+}
+
+static int memleak_seq_show(struct seq_file *seq, void *v)
+{
+	const struct memleak_pointer *pointer = v;
+	char namebuf[KSYM_NAME_LEN + 1] = "";
+	char *modname;
+	unsigned long symsize;
+	unsigned long offset = 0;
+	int i;
+
+	if (!COLOR_WHITE(pointer))
+		return 0;
+
+	seq_printf(seq, "orphan pointer 0x%08lx (size %d):\n",
+		   pointer->pointer, pointer->size);
+
+	for (i = 0; i < MAX_TRACE; i++) {
+		unsigned long trace = pointer->trace[i];
+		if (!trace)
+			break;
+
+#ifdef CONFIG_KALLSYMS
+		kallsyms_lookup(trace, &symsize, &offset, &modname, namebuf);
+#endif
+		seq_printf(seq, "  %lx: <%s>\n", trace, namebuf);
+	}
+
+	return 0;
+}
+
+static struct seq_operations memleak_seq_ops = {
+	.start = memleak_seq_start,
+	.next  = memleak_seq_next,
+	.stop  = memleak_seq_stop,
+	.show  = memleak_seq_show,
+};
+
+static int memleak_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &memleak_seq_ops);
+}
+
+static struct file_operations memleak_proc_fops = {
+	.owner	 = THIS_MODULE,
+	.open    = memleak_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+#endif					/* CONFIG_PROC_FS */
+
+/* KMemLeak initialisation. Set up the radix tree for the pointer
+ * aliases
+ */
+int __init memleak_init(void)
+{
+	struct memleak_offset *ml_off;
+	int aliases = 0;
+	unsigned long flags;
+
+	printk(KERN_INFO "Kernel memory leak detector\n");
+
+	pointer_cache = kmem_cache_create("kmemleak cache", sizeof(struct memleak_pointer),
+					  0, SLAB_PANIC, NULL, NULL);
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	/* primary aliases - container_of(member) */
+	for (ml_off = __memleak_offsets_start; ml_off < __memleak_offsets_end;
+	     ml_off++) {
+		/* Note that offset == size is not a bug (see
+		 * container_of usage in ipc/utils.c) but we ignore it
+		 * because the alias can overlap with valid pointers
+		 */
+		if (ml_off->offset > ml_off->size)
+			BUG();
+		else if (ml_off->offset != 0 && ml_off->offset < ml_off->size
+			 && !insert_alias(ml_off->size, ml_off->offset))
+			aliases++;
+	}
+	pr_debug("kmemleak: found %d primary aliases\n", aliases);
+
+	/* secondary aliases - container_of(container_of(member)) */
+	for (ml_off = __memleak_offsets_start; ml_off < __memleak_offsets_end;
+	     ml_off++) {
+		struct hlist_head *alias_list;
+		struct memleak_alias *alias;
+		struct hlist_node *elem;
+
+		alias_list = radix_tree_lookup(&alias_tree, ml_off->member_size);
+		if (!alias_list)
+			continue;
+
+		hlist_for_each_entry(alias, elem, alias_list, node) {
+			if (!insert_alias(ml_off->size,
+					  ml_off->offset + alias->offset))
+				aliases++;
+		}
+	}
+	pr_debug("kmemleak: found %d aliases\n", aliases);
+
+	memleak_initialised = 1;
+
+	spin_unlock_irqrestore(&memleak_lock, flags);
+
+	return 0;
+}
+
+/* Late initialisation function
+ */
+int __init memleak_late_init(void)
+{
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *entry;
+#endif
+
+	pr_debug("kmemleak: late init\n");
+
+#if 0
+	/* make some orphan pointers for testing */
+	kmalloc(32, GFP_KERNEL);
+	kmalloc(32, GFP_KERNEL);
+	kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
+	kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
+	vmalloc(64);
+	vmalloc(64);
+#endif
+
+#ifdef CONFIG_PROC_FS
+	entry = create_proc_entry("memleak", S_IRUGO, NULL);
+	if (!entry)
+		return -ENOMEM;
+	entry->proc_fops = &memleak_proc_fops;
+#endif
+
+	return 0;
+}
+late_initcall(memleak_late_init);
