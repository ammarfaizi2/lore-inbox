Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWE0MXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWE0MXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWE0MXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:23:18 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:58942 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751492AbWE0MXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:23:14 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 1/7] Base support for kmemleak
Date: Sat, 27 May 2006 13:23:07 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060527122307.21451.84934.stgit@localhost.localdomain>
In-Reply-To: <20060527120709.21451.3187.stgit@localhost.localdomain>
References: <20060527120709.21451.3187.stgit@localhost.localdomain>
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

 include/linux/kernel.h  |    7 
 include/linux/memleak.h |   72 ++++
 init/main.c             |    3 
 lib/Kconfig.debug       |   13 +
 mm/Makefile             |    2 
 mm/memleak.c            |  813 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 907 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f4fc576..9155457 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,7 @@ #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/memleak.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -284,9 +285,13 @@ #define max_t(type,x,y) \
  * @member:	the name of the member within the struct.
  *
  */
-#define container_of(ptr, type, member) ({			\
+#define __container_of(ptr, type, member) ({			\
         const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
         (type *)( (char *)__mptr - offsetof(type,member) );})
+#define container_of(ptr, type, member) ({			\
+	DECLARE_MEMLEAK_OFFSET(container_of, type, member);	\
+	__container_of(ptr, type, member);			\
+})
 
 /*
  * Check at compile time that something is of a particular type.
diff --git a/include/linux/memleak.h b/include/linux/memleak.h
new file mode 100644
index 0000000..0e46740
--- /dev/null
+++ b/include/linux/memleak.h
@@ -0,0 +1,72 @@
+/*
+ * include/linux/memleak.h
+ *
+ * Copyright (C) 2006 ARM Limited
+ * Written by Catalin Marinas <catalin.marinas@gmail.com>
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
+#include <linux/stddef.h>
+
+#ifdef CONFIG_DEBUG_MEMLEAK
+
+struct memleak_offset {
+	unsigned long offset;
+	unsigned long size;
+	unsigned long member_size;
+};
+
+/* if offsetof(type, member) is not a constant known at compile time,
+ * just use 0 instead since we cannot add it to the
+ * .init.memleak_offsets section
+ */
+#define memleak_offsetof(type, member)				\
+	(__builtin_constant_p(offsetof(type, member)) ?		\
+	 offsetof(type, member) : 0)
+
+#define DECLARE_MEMLEAK_OFFSET(name, type, member)		\
+	static const struct memleak_offset			\
+	__attribute__ ((__section__ (".init.memleak_offsets")))	\
+	__attribute_used__ __memleak_offset__##name = {		\
+		memleak_offsetof(type, member),			\
+		sizeof(type),					\
+		sizeof(((type *)0)->member)			\
+	}
+
+extern void memleak_debug_init(void);
+extern void memleak_debug_alloc(const void *ptr, size_t size, int ref_count);
+extern void memleak_debug_free(const void *ptr);
+extern void memleak_debug_resize(const void *ptr, size_t size);
+extern void memleak_debug_false_alarm(const void *ptr);
+
+#define memleak_debug_erase(ptr)	do { (ptr) = NULL; } while (0)
+
+#else
+
+#define DECLARE_MEMLEAK_OFFSET(name, type, member)
+
+#define memleak_debug_init()
+#define memleak_debug_alloc(ptr, size, ref_count)
+#define memleak_debug_free(ptr)
+#define memleak_debug_resize(ptr, size)
+#define memleak_debug_false_alarm(ptr)
+#define memleak_debug_erase(ptr)
+
+#endif	/* CONFIG_DEBUG_MEMLEAK */
+
+#endif	/* __MEMLEAK_H */
diff --git a/init/main.c b/init/main.c
index f715b9b..acc6ad2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -513,6 +513,8 @@ #endif
 	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
+	radix_tree_init();
+	memleak_debug_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	if (late_time_init)
@@ -533,7 +535,6 @@ #endif
 	key_init();
 	security_init();
 	vfs_caches_init(num_physpages);
-	radix_tree_init();
 	signals_init();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ccb0c1f..c109dae 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -89,6 +89,19 @@ config DEBUG_SLAB_LEAK
 	bool "Memory leak debugging"
 	depends on DEBUG_SLAB
 
+config DEBUG_MEMLEAK
+	bool "Kernel memory leak detector"
+	default n
+	depends on EXPERIMENTAL && DEBUG_KERNEL && SLAB
+	depends on !NUMA
+	help
+	  Say Y here if you want to enable the memory leak
+	  detector. The memory allocation/freeing is traced in a way
+	  similar to the Boehm's conservative garbage collector, the
+	  difference being that the orphan pointers are not freed but
+	  only shown in /sys/kernel/debug/memleak. Enabling this
+	  feature will introduce an overhead to memory allocations.
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
index 0000000..c90c679
--- /dev/null
+++ b/mm/memleak.c
@@ -0,0 +1,813 @@
+/*
+ * mm/memleak.c
+ *
+ * Copyright (C) 2006 ARM Limited
+ * Written by Catalin Marinas <catalin.marinas@gmail.com>
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
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include <linux/mutex.h>
+#include <linux/cpumask.h>
+
+#include <asm/bitops.h>
+#include <asm/sections.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+
+#include <linux/memleak.h>
+
+#ifdef CONFIG_FRAME_POINTER
+#define MAX_TRACE	4
+#else
+#define MAX_TRACE	1
+#endif
+
+#define PREINIT_POINTERS	1024
+#define BYTES_PER_WORD		sizeof(void *)
+
+/* define this if you want the task stacks to be scanned (with an
+ * increased chance of false negatives) */
+/* #define TASK_STACK_SCAN */
+
+extern struct memleak_offset __memleak_offsets_start[];
+extern struct memleak_offset __memleak_offsets_end[];
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
+	int ref_count;			/* the minimum encounters of the value */
+	int count;			/* the ecounters of the value */
+	struct hlist_head *alias_list;
+	unsigned long trace[MAX_TRACE];
+};
+
+typedef enum {
+	MEMLEAK_ALLOC,
+	MEMLEAK_FREE,
+	MEMLEAK_RESIZE,
+	MEMLEAK_FALSE_ALARM
+} memleak_action_t;
+
+struct memleak_preinit_pointer {
+	memleak_action_t type;
+	const void *pointer;
+	size_t size;
+	int ref_count;
+};
+
+#define COLOR_WHITE(pointer)	((pointer)->count != -1 && (pointer)->count < (pointer)->ref_count)
+#define COLOR_GREY(pointer)	((pointer)->count >= (pointer)->ref_count)
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
+static cpumask_t memleak_cpu_mask = CPU_MASK_NONE;
+static DEFINE_MUTEX(memleak_mutex);
+static int memleak_initialized = 0;
+static int __initdata preinit_pos = 0;
+static struct memleak_preinit_pointer __initdata preinit_pointers[PREINIT_POINTERS];
+
+static void dump_pointer_info(struct memleak_pointer *pointer)
+{
+#ifdef CONFIG_KALLSYMS
+	char namebuf[KSYM_NAME_LEN + 1] = "";
+	char *modname;
+	unsigned long symsize;
+	unsigned long offset = 0;
+#endif
+#ifdef DEBUG
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+#endif
+	int i;
+
+	printk(KERN_NOTICE "kmemleak: pointer 0x%08lx:\n", pointer->pointer);
+#ifdef DEBUG
+	printk(KERN_NOTICE "  size = %d\n", pointer->size);
+	printk(KERN_NOTICE "  ref_count = %d\n", pointer->ref_count);
+	printk(KERN_NOTICE "  count = %d\n", pointer->count);
+	printk(KERN_NOTICE "  aliases:\n");
+	if (pointer->alias_list)
+		hlist_for_each_entry(alias, elem, pointer->alias_list, node)
+			printk(KERN_NOTICE "    0x%lx\n", alias->offset);
+	printk(KERN_NOTICE "  trace:\n");
+#endif
+	for (i = 0; i < MAX_TRACE; i++) {
+		unsigned long trace = pointer->trace[i];
+
+		if (!trace)
+			break;
+#ifdef CONFIG_KALLSYMS
+		kallsyms_lookup(trace, &symsize, &offset, &modname, namebuf);
+		printk(KERN_NOTICE "    %lx: <%s>\n", trace, namebuf);
+#else
+		printk(KERN_NOTICE "    %lx\n", trace);
+#endif
+	}
+}
+
+/* Insert an element into the aliases radix tree.
+ * Return 0 on success.
+ */
+static int __init insert_alias(unsigned long size, unsigned long offset)
+{
+	int ret = 0;
+	struct hlist_head *alias_list;
+	struct memleak_alias *alias;
+
+	/* Note that offset == size is not a bug (see
+	 * container_of usage in ipc/utils.c) but we ignore it
+	 * because the alias can overlap with valid pointers
+	 */
+	if (offset > size)
+		BUG();
+	else if (offset == 0 || offset == size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	offset &= ~(BYTES_PER_WORD - 1);
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
+/* Insert a pointer and its aliases into the pointer radix tree */
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
+		void *stack = task_stack_page(current);
+
+		if (frame < stack || frame > stack + THREAD_SIZE - BYTES_PER_WORD) {
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
+	pointer->trace[0] = (unsigned long)__builtin_return_address(0);
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
+	list_add_tail_rcu(&pointer->pointer_list, &pointer_list);
+}
+
+/* Remove a pointer and its aliases from the pointer radix tree */
+static inline void delete_pointer(unsigned long ptr)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+	struct memleak_pointer *pointer;
+
+	pointer = radix_tree_delete(&pointer_tree, ptr);
+	if (!pointer) {
+		dump_stack();
+		printk(KERN_WARNING "kmemleak: freeing unknown pointer value 0x%08lx\n", ptr);
+		return;
+	}
+	if (pointer->pointer != ptr) {
+		dump_stack();
+		dump_pointer_info(pointer);
+		panic("kmemleak: freeing pointer by alias 0x%08lx\n", ptr);
+	}
+	if (COLOR_WHITE(pointer)) {
+		dump_stack();
+		dump_pointer_info(pointer);
+		printk(KERN_WARNING "kmemleak: freeing orphan pointer 0x%08lx\n", ptr);
+	}
+
+	if (pointer->alias_list) {
+		hlist_for_each_entry(alias, elem, pointer->alias_list, node) {
+			if (!radix_tree_delete(&pointer_tree, ptr + alias->offset)) {
+				dump_stack();
+				dump_pointer_info(pointer);
+				panic("kmemleak: cannot find pointer alias 0x%08lx, 0x%lx\n",
+				      ptr, alias->offset);
+			}
+		}
+	}
+
+	list_del_rcu(&pointer->pointer_list);
+
+	kmem_cache_free(pointer_cache, pointer);
+}
+
+/* Re-create the pointer aliases according to the new size information */
+static inline void resize_pointer(unsigned long ptr, size_t size)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+	struct memleak_pointer *pointer;
+	int err;
+
+	pointer = radix_tree_lookup(&pointer_tree, ptr);
+	if (!pointer) {
+		dump_stack();
+		panic("kmemleak: resizing unknown pointer value 0x%08lx\n", ptr);
+	}
+	if (pointer->pointer != ptr) {
+		dump_stack();
+		dump_pointer_info(pointer);
+		panic("kmemleak: resizing pointer by alias 0x%08lx\n", ptr);
+	}
+
+	/* remove old aliases */
+	if (pointer->alias_list) {
+		hlist_for_each_entry(alias, elem, pointer->alias_list, node) {
+			if (!radix_tree_delete(&pointer_tree, ptr + alias->offset)) {
+				dump_stack();
+				dump_pointer_info(pointer);
+				panic("kmemleak: cannot find pointer alias 0x%08lx, 0x%lx\n",
+				      ptr, alias->offset);
+			}
+		}
+	}
+
+	/* add the new aliases. We don't update the pointer->size
+	 * because the real block size should be scanned */
+	pointer->alias_list = radix_tree_lookup(&alias_tree, size);
+	if (pointer->alias_list) {
+		hlist_for_each_entry(alias, elem, pointer->alias_list, node) {
+			if (alias->offset >= size)
+				BUG();
+
+			err = radix_tree_insert(&pointer_tree, ptr + alias->offset, pointer);
+			if (err) {
+				dump_stack();
+				dump_pointer_info(pointer);
+				panic("kmemleak: cannot insert alias into the pointer radix tree: %d\n", err);
+			}
+		}
+	}
+}
+
+/* Make a pointer permanently grey (false positive) */
+static inline void make_grey_pointer(unsigned long ptr)
+{
+	struct memleak_pointer *pointer;
+
+	pointer = radix_tree_lookup(&pointer_tree, ptr);
+	if (!pointer) {
+		dump_stack();
+		panic("kmemleak: greying unknown pointer value 0x%08lx\n", ptr);
+	}
+	if (pointer->pointer != ptr) {
+		dump_stack();
+		dump_pointer_info(pointer);
+		panic("kmemleak: greying pointer by alias 0x%08lx\n", ptr);
+	}
+
+	pointer->ref_count = 0;
+}
+
+/* Allocation function hook */
+void memleak_debug_alloc(const void *ptr, size_t size, int ref_count)
+{
+	unsigned long flags;
+	unsigned int cpu_id = smp_processor_id();
+
+	if (!ptr)
+		return;
+
+	local_irq_save(flags);
+
+	if (!memleak_initialized) {
+		/* no need for SMP locking since this block is
+		 * executed before the other CPUs are started */
+		struct memleak_preinit_pointer *pointer;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos >= PREINIT_POINTERS)
+			panic("kmemleak: preinit pointers buffer overflow\n");
+		pointer = &preinit_pointers[preinit_pos++];
+
+		pointer->type = MEMLEAK_ALLOC;
+		pointer->pointer = ptr;
+		pointer->size = size;
+		pointer->ref_count = ref_count;
+
+		goto out;
+	}
+
+	/* avoid recursive calls. After disabling the interrupts, the
+	 * only calls to this function on the same CPU should be from
+	 * kmemleak itself and we ignore them. Calls from other CPU's
+	 * would wait on the spin_lock.
+	 */
+	if (!cpu_test_and_set(cpu_id, memleak_cpu_mask)) {
+		pr_debug("%s(0x%p, %d, %d)\n", __FUNCTION__, ptr, size, ref_count);
+
+		spin_lock(&memleak_lock);
+		insert_pointer((unsigned long)ptr, size, ref_count);
+		spin_unlock(&memleak_lock);
+
+		cpu_clear(cpu_id, memleak_cpu_mask);
+	}
+
+ out:
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(memleak_debug_alloc);
+
+/* Freeing function hook */
+void memleak_debug_free(const void *ptr)
+{
+	unsigned long flags;
+	unsigned int cpu_id = smp_processor_id();
+
+	if (!ptr)
+		return;
+
+	local_irq_save(flags);
+
+	if (!memleak_initialized) {
+		struct memleak_preinit_pointer *pointer;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos >= PREINIT_POINTERS)
+			panic("kmemleak: preinit pointers buffer overflow\n");
+		pointer = &preinit_pointers[preinit_pos++];
+
+		pointer->type = MEMLEAK_FREE;
+		pointer->pointer = ptr;
+
+		goto out;
+	}
+
+	/* avoid recursive calls. See memleak_debug_alloc() for an explanation */
+	if (!cpu_test_and_set(cpu_id, memleak_cpu_mask)) {
+		pr_debug("%s(0x%p)\n", __FUNCTION__, ptr);
+
+		spin_lock(&memleak_lock);
+		delete_pointer((unsigned long)ptr);
+		spin_unlock(&memleak_lock);
+
+		cpu_clear(cpu_id, memleak_cpu_mask);
+	}
+
+ out:
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(memleak_debug_free);
+
+/* Change the size information of an allocated memory block */
+void memleak_debug_resize(const void *ptr, size_t size)
+{
+	unsigned long flags;
+	unsigned int cpu_id = smp_processor_id();
+
+	if (!ptr)
+		return;
+
+	local_irq_save(flags);
+
+	if (!memleak_initialized) {
+		struct memleak_preinit_pointer *pointer;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos >= PREINIT_POINTERS)
+			panic("kmemleak: preinit pointers buffer overflow\n");
+		pointer = &preinit_pointers[preinit_pos++];
+
+		pointer->type = MEMLEAK_RESIZE;
+		pointer->pointer = ptr;
+		pointer->size = size;
+
+		goto out;
+	}
+
+	/* avoid recursive calls. See memleak_debug_alloc() for an explanation */
+	if (!cpu_test_and_set(cpu_id, memleak_cpu_mask)) {
+		pr_debug("%s(0x%p, %d)\n", __FUNCTION__, ptr, size);
+
+		spin_lock(&memleak_lock);
+		resize_pointer((unsigned long)ptr, size);
+		spin_unlock(&memleak_lock);
+
+		cpu_clear(cpu_id, memleak_cpu_mask);
+	}
+
+ out:
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(memleak_debug_resize);
+
+/* Mark a pointer as a false positive */
+void memleak_debug_false_alarm(const void *ptr)
+{
+	unsigned long flags;
+	unsigned int cpu_id = smp_processor_id();
+
+	if (!ptr)
+		return;
+
+	local_irq_save(flags);
+
+	if (!memleak_initialized) {
+		struct memleak_preinit_pointer *pointer;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos >= PREINIT_POINTERS)
+			panic("kmemleak: preinit pointers buffer overflow\n");
+		pointer = &preinit_pointers[preinit_pos++];
+
+		pointer->type = MEMLEAK_FALSE_ALARM;
+		pointer->pointer = ptr;
+
+		goto out;
+	}
+
+	/* avoid recursive calls. See memleak_debug_alloc() for an explanation */
+	if (!cpu_test_and_set(cpu_id, memleak_cpu_mask)) {
+		pr_debug("%s(0x%p)\n", __FUNCTION__, ptr);
+
+		spin_lock(&memleak_lock);
+		make_grey_pointer((unsigned long)ptr);
+		spin_unlock(&memleak_lock);
+
+		cpu_clear(cpu_id, memleak_cpu_mask);
+	}
+
+ out:
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(memleak_debug_false_alarm);
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
+			radix_tree_lookup(&pointer_tree,
+					  (*ptr) & ~(BYTES_PER_WORD - 1));
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
+/* Scan the memory and print the orphan pointers */
+static void memleak_scan(void)
+{
+	unsigned long flags;
+	struct memleak_pointer *pointer;
+#ifdef TASK_STACK_SCAN
+	struct task_struct *task;
+#endif
+	int i;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	list_for_each_entry_rcu(pointer, &pointer_list, pointer_list) {
+		pointer->count = 0;
+		if (COLOR_GREY(pointer))
+			list_add_tail_rcu(&pointer->grey_list, &grey_list);
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
+	for_each_online_node(i) {
+		struct page *page, *end;
+
+		page = NODE_MEM_MAP(i);
+		end  = page + NODE_DATA(i)->node_spanned_pages;
+
+		memleak_scan_block(page, end);
+	}
+
+#ifdef TASK_STACK_SCAN
+	for_each_process(task)
+		memleak_scan_block(task_stack_page(task),
+				   task_stack_page(task) + THREAD_SIZE);
+#endif
+
+	/* grey_list scanning */
+	list_for_each_entry_rcu(pointer, &grey_list, grey_list) {
+		memleak_scan_block((void *)pointer->pointer,
+				   (void *)(pointer->pointer + pointer->size));
+		list_del_rcu(&pointer->grey_list);
+	}
+
+	spin_unlock_irqrestore(&memleak_lock, flags);
+}
+
+#ifdef CONFIG_DEBUG_FS
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
+	struct list_head *n = ((struct memleak_pointer *)v)->pointer_list.next;
+
+	++(*pos);
+
+	if (n != &pointer_list)
+		return list_entry(n, struct memleak_pointer, pointer_list);
+	return NULL;
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
+#ifdef CONFIG_KALLSYMS
+	char namebuf[KSYM_NAME_LEN + 1] = "";
+	char *modname;
+	unsigned long symsize;
+	unsigned long offset = 0;
+#endif
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
+		seq_printf(seq, "  %lx: <%s>\n", trace, namebuf);
+#else
+		seq_printf(seq, "  %lx\n", trace);
+#endif
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
+static struct file_operations memleak_fops = {
+	.owner	 = THIS_MODULE,
+	.open    = memleak_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+#endif					/* CONFIG_DEBUG_FS */
+
+/* KMemLeak initialization. Set up the radix tree for the pointer aliases */
+void __init memleak_debug_init(void)
+{
+	struct memleak_offset *ml_off;
+	int i = 0;
+	unsigned long flags;
+
+	pointer_cache = kmem_cache_create("pointer_cache", sizeof(struct memleak_pointer),
+					  0, SLAB_PANIC, NULL, NULL);
+	if (!pointer_cache)
+		panic("kmemleak: cannot create the pointer cache\n");
+
+	/* no need to hold the spinlock as SMP is not initialized yet
+	 * and memleak_initialized is 0 */
+
+	/* primary aliases - container_of(member) */
+	for (ml_off = __memleak_offsets_start; ml_off < __memleak_offsets_end; ml_off++)
+		if (!insert_alias(ml_off->size, ml_off->offset))
+			i++;
+	pr_debug("kmemleak: found %d primary aliases\n", i);
+
+	/* secondary aliases - container_of(container_of(member)) */
+	for (ml_off = __memleak_offsets_start; ml_off < __memleak_offsets_end; ml_off++) {
+		struct hlist_head *alias_list;
+		struct memleak_alias *alias;
+		struct hlist_node *elem;
+
+		alias_list = radix_tree_lookup(&alias_tree, ml_off->member_size);
+		if (!alias_list)
+			continue;
+
+		hlist_for_each_entry(alias, elem, alias_list, node)
+			if (!insert_alias(ml_off->size, ml_off->offset + alias->offset))
+				i++;
+	}
+	pr_debug("kmemleak: found %d aliases\n", i);
+	pr_debug("kmemleak: %d preinit actions\n", preinit_pos);
+
+	local_irq_save(flags);
+
+	memleak_initialized = 1;
+
+	/* execute the buffered memleak actions */
+	for (i = 0; i < preinit_pos; i++) {
+		struct memleak_preinit_pointer *pointer = &preinit_pointers[i];
+
+		switch (pointer->type) {
+		case MEMLEAK_ALLOC:
+			memleak_debug_alloc(pointer->pointer, pointer->size,
+					    pointer->ref_count);
+			break;
+		case MEMLEAK_FREE:
+			memleak_debug_free(pointer->pointer);
+			break;
+		case MEMLEAK_RESIZE:
+			memleak_debug_resize(pointer->pointer, pointer->size);
+			break;
+		case MEMLEAK_FALSE_ALARM:
+			memleak_debug_false_alarm(pointer->pointer);
+			break;
+		default:
+			BUG();
+		}
+	}
+
+	local_irq_restore(flags);
+
+	printk(KERN_INFO "Kernel memory leak detector initialized\n");
+}
+
+/* Late initialization function */
+int __init memleak_late_init(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+
+	dentry = debugfs_create_file("memleak", S_IRUGO, NULL, NULL,
+				     &memleak_fops);
+	if (!dentry)
+		return -ENOMEM;
+#endif
+	pr_debug("kmemleak: late initialization completed\n");
+
+	return 0;
+}
+late_initcall(memleak_late_init);
