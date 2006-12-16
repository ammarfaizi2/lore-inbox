Return-Path: <linux-kernel-owner+w=401wt.eu-S1161076AbWLPPri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWLPPri (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWLPPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:38 -0500
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:42406 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161076AbWLPPrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:32 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 01/10] Base support for kmemleak
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:34:22 +0000
Message-ID: <20061216153421.18200.88285.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the base support for the kernel memory leak
detector. It traces the memory allocation/freeing in a way similar to
the Boehm's conservative garbage collector, the difference being that
the unreferenced objects are not freed but only shown in
/sys/kernel/debug/memleak. Enabling this feature introduces an
overhead to memory allocations.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 include/linux/kernel.h  |    7 
 include/linux/memleak.h |  111 ++++
 init/main.c             |    3 
 lib/Kconfig.debug       |  114 ++++
 mm/Makefile             |    1 
 mm/memleak.c            | 1478 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1712 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b0c4a05..2fca6bf 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/memleak.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -285,9 +286,13 @@ static inline int __attribute__ ((format
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
index 0000000..39669bf
--- /dev/null
+++ b/include/linux/memleak.h
@@ -0,0 +1,111 @@
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
+struct memleak_offset {
+	unsigned long type_id;
+	unsigned long member_type_id;
+	unsigned long offset;
+};
+
+/* type id approximation */
+#define ml_guess_typeid(size)	((unsigned long)(size))
+#define ml_typeid(type)		ml_guess_typeid(sizeof(type))
+#define ml_sizeof(typeid)	((size_t)(typeid))
+
+#ifdef CONFIG_DEBUG_MEMLEAK
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
+		ml_typeid(type),				\
+		ml_typeid(typeof(((type *)0)->member)),		\
+		memleak_offsetof(type, member)			\
+	}
+
+extern void memleak_init(void);
+extern void memleak_alloc(const void *ptr, size_t size, int ref_count);
+extern void memleak_free(const void *ptr);
+extern void memleak_padding(const void *ptr, unsigned long offset, size_t size);
+extern void memleak_not_leak(const void *ptr);
+extern void memleak_ignore(const void *ptr);
+extern void memleak_scan_area(const void *ptr, unsigned long offset, size_t length);
+extern void memleak_insert_aliases(struct memleak_offset *ml_off_start,
+				   struct memleak_offset *ml_off_end);
+
+static inline void memleak_erase(void **ptr)
+{
+	*ptr = NULL;
+}
+
+#define memleak_container(type, member)	{			\
+	DECLARE_MEMLEAK_OFFSET(container_of, type, member);	\
+}
+
+extern void memleak_typeid_raw(const void *ptr, unsigned long type_id);
+#define memleak_typeid(ptr, type) \
+	memleak_typeid_raw(ptr, ml_typeid(type))
+
+#else
+
+#define DECLARE_MEMLEAK_OFFSET(name, type, member)
+
+static inline void memleak_init(void)
+{ }
+static inline void memleak_alloc(const void *ptr, size_t size, int ref_count)
+{ }
+static inline void memleak_free(const void *ptr)
+{ }
+static inline void memleak_padding(const void *ptr, unsigned long offset, size_t size)
+{ }
+static inline void memleak_not_leak(const void *ptr)
+{ }
+static inline void memleak_ignore(const void *ptr)
+{ }
+static inline void memleak_scan_area(const void *ptr, unsigned long offset, size_t length)
+{ }
+static inline void memleak_insert_aliases(struct memleak_offset *ml_off_start,
+					  struct memleak_offset *ml_off_end)
+{ }
+static inline void memleak_erase(void **ptr)
+{ }
+
+#define memleak_container(type, member)
+
+static inline void memleak_typeid_raw(const void *ptr, unsigned long type_id)
+{ }
+#define memleak_typeid(ptr, type)
+
+#endif	/* CONFIG_DEBUG_MEMLEAK */
+
+#endif	/* __MEMLEAK_H */
diff --git a/init/main.c b/init/main.c
index e3f0bb2..c5cdc87 100644
--- a/init/main.c
+++ b/init/main.c
@@ -584,6 +584,8 @@ asmlinkage void __init start_kernel(void
 	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
+	radix_tree_init();
+	memleak_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	if (late_time_init)
@@ -604,7 +606,6 @@ asmlinkage void __init start_kernel(void
 	key_init();
 	security_init();
 	vfs_caches_init(num_physpages);
-	radix_tree_init();
 	signals_init();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 818e458..42f60fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -137,6 +137,120 @@ config DEBUG_SLAB_LEAK
 	bool "Memory leak debugging"
 	depends on DEBUG_SLAB
 
+menuconfig DEBUG_MEMLEAK
+	bool "Kernel memory leak detector"
+	default n
+	depends on EXPERIMENTAL && DEBUG_SLAB
+	select DEBUG_FS
+	select STACKTRACE
+	select FRAME_POINTER
+	select KALLSYMS
+	help
+	  Say Y here if you want to enable the memory leak
+	  detector. The memory allocation/freeing is traced in a way
+	  similar to the Boehm's conservative garbage collector, the
+	  difference being that the orphan objects are not freed but
+	  only shown in /sys/kernel/debug/memleak. Enabling this
+	  feature will introduce an overhead to memory
+	  allocations. See Documentation/kmemleak.txt for more
+	  details.
+
+	  In order to access the memleak file, debugfs needs to be
+	  mounted (usually at /sys/kernel/debug).
+
+config DEBUG_MEMLEAK_HASH_BITS
+	int "Pointer hash bits"
+	default 16
+	depends on DEBUG_MEMLEAK
+	help
+	  This option sets the number of bits used for the pointer
+	  hash table. Higher values give better memory scanning
+	  performance but also lead to bigger RAM usage. The size of
+	  the allocated hash table is (sizeof(void*) * 2^hash_bits).
+
+	  The minimum recommended value is 16. A maximum value of
+	  around 20 should be sufficient.
+
+config DEBUG_MEMLEAK_TRACE_LENGTH
+	int "Stack trace length"
+	default 4
+	depends on DEBUG_MEMLEAK && FRAME_POINTER
+	help
+	  This option sets the length of the stack trace for the
+	  allocated objects tracked by kmemleak.
+
+config DEBUG_MEMLEAK_PREINIT_OBJECTS
+	int "Pre-init actions buffer size"
+	default 512
+	depends on DEBUG_MEMLEAK
+	help
+	  This is the buffer for storing the memory allocation/freeing
+	  calls before kmemleak is fully initialized. Each element in
+	  the buffer takes 24 bytes on a 32 bit architecture. This
+	  buffer will be freed once the system initialization is
+	  completed.
+
+config DEBUG_MEMLEAK_SECONDARY_ALIASES
+	bool "Create secondary level pointer aliases"
+	default y
+	depends on DEBUG_MEMLEAK
+	help
+	  This option creates aliases for container_of(container_of(member))
+	  access to objects. Disabling this option reduces the chances of
+	  false negatives but it can slightly increase the number of false
+	  positives.
+
+config DEBUG_MEMLEAK_TASK_STACKS
+	bool "Scan task kernel stacks"
+	default y
+	depends on DEBUG_MEMLEAK
+	help
+	  This option enables the scanning of the task kernel
+	  stacks. This option can introduce false negatives because of
+	  the randomness of stacks content.
+
+	  If unsure, say Y.
+
+config DEBUG_MEMLEAK_ORPHAN_FREEING
+	bool "Notify when freeing orphan objects"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  This option enables the notification when objects
+	  considered leaks are freed. The stack dump and the object
+	  information displayed allow an easier identification of
+	  false positives. Use this mainly for debugging kmemleak.
+
+	  If unsure, say N.
+
+config DEBUG_MEMLEAK_REPORT_THLD
+	int "Unreferenced reporting threshold"
+	default 1
+	depends on DEBUG_MEMLEAK
+	help
+	  This option sets the number of times an object needs to be
+	  detected as unreferenced before being reported as a memory
+	  leak. A value of 0 means that the object will be reported
+	  the first time it is found as unreferenced. Other positive
+	  values mean that the object needs to be found as
+	  unreferenced a specified number of times prior to being
+	  reported.
+
+	  This is useful to avoid the reporting of transient false
+	  positives where the pointers might be held in CPU registers,
+	  especially on SMP systems, or on the stack when the stack
+	  scanning option is disabled.
+
+config DEBUG_MEMLEAK_REPORTS_NR
+	int "Maximum number of reported leaks"
+	default 100
+	depends on DEBUG_MEMLEAK
+	help
+	  This option sets the maximum number of leaks reported. If
+	  this number is too big and there are leaks to be reported,
+	  reading the /sys/kernel/debug/memleak file could lead to
+	  some soft-locks.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
diff --git a/mm/Makefile b/mm/Makefile
index f3c077e..aafe03f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
+obj-$(CONFIG_DEBUG_MEMLEAK) += memleak.o
diff --git a/mm/memleak.c b/mm/memleak.c
new file mode 100644
index 0000000..41d5c95
--- /dev/null
+++ b/mm/memleak.c
@@ -0,0 +1,1478 @@
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
+ *
+ *
+ * Notes on locking
+ *
+ * Kmemleak needs to allocate/free memory for its own data structures:
+ * the memleak_object, the pointer hash and aliases radix trees. The
+ * memleak_free hook can be called from mm/slab.c with the list_lock
+ * held (i.e. when releasing off-slab management structures) and it
+ * will ackquire the memleak_lock. To avoid deadlocks caused by
+ * locking dependency, the list_lock must not be acquired while
+ * memleak_lock is held. This is ensured by not allocating/freeing
+ * memory while any of the kmemleak locks are held.
+ *
+ * The kmemleak hooks cannot be called concurrently on the same
+ * memleak_object (this is due to the way they were inserted in the
+ * kernel).
+ *
+ * The following locks are present in kmemleak:
+ *
+ * - alias_tree_lock - rwlock for accessing the radix tree holding the
+ *   objects type information
+ *
+ * - memleak_lock - global kmemleak lock; protects object_list,
+ *   last_object, pointer_hash and memleak_object structures
+ *
+ * Locking dependencies:
+ *
+ * - alias_tree_lock --> l3->list_lock
+ * - l3->list_lock --> memleak_lock
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
+#include <linux/cpumask.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+#include <linux/hash.h>
+#include <linux/stacktrace.h>
+
+#include <asm/bitops.h>
+#include <asm/sections.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+#include <asm/atomic.h>
+
+#include <linux/memleak.h>
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define BUG_ON_LOCKING(cond)	BUG_ON(cond)
+#else
+#define BUG_ON_LOCKING(cond)
+#endif
+
+#define MAX_TRACE		CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH
+#define SCAN_BLOCK_SIZE		4096		/* maximum scan length with interrupts disabled */
+#define PREINIT_OBJECTS		CONFIG_DEBUG_MEMLEAK_PREINIT_OBJECTS
+#define HASH_BITS		CONFIG_DEBUG_MEMLEAK_HASH_BITS
+#define BYTES_PER_WORD		sizeof(void *)
+
+extern struct memleak_offset __memleak_offsets_start[];
+extern struct memleak_offset __memleak_offsets_end[];
+
+struct memleak_alias {
+	struct hlist_node node;
+	unsigned long offset;
+};
+
+struct memleak_scan_area {
+	struct hlist_node node;
+	unsigned long offset;
+	size_t length;
+};
+
+struct memleak_object {
+	unsigned long flags;
+	struct list_head object_list;
+	struct list_head gray_list;
+	struct rcu_head rcu;
+	int use_count;
+	unsigned long pointer;
+	unsigned long offset;		/* padding */
+	size_t size;
+	unsigned long type_id;
+	int ref_count;			/* the minimum encounters of the value */
+	int count;			/* the ecounters of the value */
+	int report_thld;		/* the unreferenced reporting threshold */
+	struct hlist_head *alias_list;
+	struct hlist_head area_list;	/* areas to be scanned (or empty for all) */
+	unsigned long trace[MAX_TRACE];
+	unsigned int trace_len;
+};
+
+struct hash_node {
+	struct hlist_node node;
+	unsigned long val;
+	void *object;
+};
+
+enum memleak_action {
+	MEMLEAK_ALLOC,
+	MEMLEAK_FREE,
+	MEMLEAK_PADDING,
+	MEMLEAK_NOT_LEAK,
+	MEMLEAK_IGNORE,
+	MEMLEAK_SCAN_AREA,
+	MEMLEAK_TYPEID
+};
+
+struct memleak_preinit_object {
+	enum memleak_action type;
+	const void *pointer;
+	unsigned long offset;
+	size_t size;
+	unsigned long type_id;
+	int ref_count;
+};
+
+/* Tree storing the pointer aliases indexed by size */
+static RADIX_TREE(alias_tree, GFP_ATOMIC);
+static DEFINE_RWLOCK(alias_tree_lock);
+/* Hash storing all the possible objects, indexed by the pointer value */
+static struct hlist_head *pointer_hash;
+/* The list of all allocated objects */
+static LIST_HEAD(object_list);
+/* The list of the gray objects */
+static LIST_HEAD(gray_list);
+
+static struct kmem_cache *object_cache;
+/* The main lock for protecting the object lists and radix trees */
+static DEFINE_SPINLOCK(memleak_lock);
+static cpumask_t memleak_cpu_mask = CPU_MASK_NONE;
+static atomic_t memleak_initialized = ATOMIC_INIT(0);
+static int __initdata preinit_pos;
+static struct memleak_preinit_object __initdata preinit_objects[PREINIT_OBJECTS];
+/* last allocated object (optimization); protected by memleak_lock */
+static struct memleak_object *last_object;
+static int reported_leaks;
+
+/* object flags */
+#define OBJECT_ALLOCATED	0x1
+#define OBJECT_TYPE_GUESSED	0x2
+
+/* Hash functions */
+static void hash_init(void)
+{
+	unsigned int i;
+	unsigned int hash_size = sizeof(*pointer_hash) * (1 << HASH_BITS);
+	unsigned int hash_order = fls(hash_size) - 1;
+
+	/* hash_size not a power of 2 */
+	if (hash_size & ((1 << hash_order) - 1))
+		hash_order += 1;
+	if (hash_order < PAGE_SHIFT)
+		hash_order = PAGE_SHIFT;
+
+	pointer_hash = (struct hlist_head *)
+		__get_free_pages(GFP_ATOMIC, hash_order - PAGE_SHIFT);
+	if (!pointer_hash)
+		panic("kmemleak: cannot allocate the pointer hash\n");
+
+	for (i = 0; i < (1 << HASH_BITS); i++)
+		INIT_HLIST_HEAD(&pointer_hash[i]);
+}
+
+static struct hash_node *__hash_lookup_node(unsigned long val)
+{
+	struct hlist_node *elem;
+	struct hash_node *hnode;
+	unsigned long index = hash_long(val, HASH_BITS);
+
+	hlist_for_each_entry(hnode, elem, &pointer_hash[index], node) {
+		if (hnode->val == val)
+			return hnode;
+	}
+	return NULL;
+}
+
+static int hash_insert(unsigned long val, void *object)
+{
+	unsigned long flags;
+	unsigned long index = hash_long(val, HASH_BITS);
+	struct hash_node *hnode = kmalloc(sizeof(*hnode), GFP_ATOMIC);
+
+	if (!hnode)
+		return -ENOMEM;
+	INIT_HLIST_NODE(&hnode->node);
+	hnode->val = val;
+	hnode->object = object;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+	hlist_add_head(&hnode->node, &pointer_hash[index]);
+	spin_unlock_irqrestore(&memleak_lock, flags);
+
+	return 0;
+}
+
+static void *hash_delete(unsigned long val)
+{
+	unsigned long flags;
+	void *object = NULL;
+	struct hash_node *hnode;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+	hnode = __hash_lookup_node(val);
+	if (hnode) {
+		object = hnode->object;
+		hlist_del(&hnode->node);
+	}
+	spin_unlock_irqrestore(&memleak_lock, flags);
+
+	kfree(hnode);
+	return object;
+}
+
+/* memleak_lock held by the calling function and interrupts disabled */
+static void *hash_lookup(unsigned long val)
+{
+	struct hash_node *hnode;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+	BUG_ON_LOCKING(!spin_is_locked(&memleak_lock));
+
+	hnode = __hash_lookup_node(val);
+	if (hnode)
+		return hnode->object;
+	return NULL;
+}
+
+/* helper macros to avoid recursive calls. After disabling the
+ * interrupts, the only calls to this function on the same CPU should
+ * be from kmemleak itself and we can either ignore them or
+ * panic. Calls from other CPU's should be protected by spinlocks */
+#define recursive_enter(cpu_id, flags)	({		\
+	local_irq_save(flags);				\
+	cpu_id = get_cpu();				\
+	cpu_test_and_set(cpu_id, memleak_cpu_mask);	\
+})
+
+#define recursive_clear(cpu_id)		do {		\
+	cpu_clear(cpu_id, memleak_cpu_mask);		\
+} while (0)
+
+#define recursive_exit(flags)		do {		\
+	put_cpu_no_resched();				\
+	local_irq_restore(flags);			\
+} while (0)
+
+/* Object colors, encoded with count and ref_count:
+ *   - white - orphan object, i.e. not enough references to it (ref_count >= 1)
+ *   - gray  - referred at least once and therefore non-orphan (ref_count == 0)
+ *   - black - ignore; it doesn't contain references (text section) (ref_count == -1) */
+static inline int color_white(const struct memleak_object *object)
+{
+	return object->count != -1 && object->count < object->ref_count;
+}
+
+static inline int color_gray(const struct memleak_object *object)
+{
+	return object->ref_count != -1 && object->count >= object->ref_count;
+}
+
+static inline int color_black(const struct memleak_object *object)
+{
+	return object->ref_count == -1;
+}
+
+#ifdef DEBUG
+static inline void dump_object_internals(struct memleak_object *object)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+
+	printk(KERN_NOTICE "  size = %d\n", object->size);
+	printk(KERN_NOTICE "  ref_count = %d\n", object->ref_count);
+	printk(KERN_NOTICE "  count = %d\n", object->count);
+	printk(KERN_NOTICE "  aliases:\n");
+	if (object->alias_list) {
+		hlist_for_each_entry(alias, elem, object->alias_list, node)
+			printk(KERN_NOTICE "    0x%lx\n", alias->offset);
+	}
+}
+#else
+static inline void dump_object_internals(struct memleak_object *object)
+{ }
+#endif
+
+static void dump_object_info(struct memleak_object *object)
+{
+	struct stack_trace trace;
+
+	trace.nr_entries = object->trace_len;
+	trace.entries = object->trace;
+
+	printk(KERN_NOTICE "kmemleak: object 0x%08lx:\n", object->pointer);
+	dump_object_internals(object);
+	printk(KERN_NOTICE "  trace:\n");
+	print_stack_trace(&trace, 4);
+}
+
+/* Insert an element into the aliases radix tree.
+ * Return 0 on success. */
+static int insert_alias(unsigned long type_id, unsigned long offset)
+{
+	int ret = 0;
+	struct hlist_head *alias_list;
+	struct hlist_node *elem;
+	struct memleak_alias *alias;
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (type_id == 0 || offset == 0 || offset >= ml_sizeof(type_id))
+		return -EINVAL;
+
+	if (recursive_enter(cpu_id, flags))
+		BUG();
+	write_lock(&alias_tree_lock);
+
+	offset &= ~(BYTES_PER_WORD - 1);
+
+	alias_list = radix_tree_lookup(&alias_tree, type_id);
+	if (!alias_list) {
+		/* no alias list for this type id. Allocate list_head
+		 * and insert into the radix tree */
+		alias_list = kmalloc(sizeof(*alias_list), GFP_ATOMIC);
+		if (!alias_list)
+			panic("kmemleak: cannot allocate alias_list\n");
+		INIT_HLIST_HEAD(alias_list);
+
+		ret = radix_tree_insert(&alias_tree, type_id, alias_list);
+		if (ret)
+			panic("kmemleak: cannot insert into the aliases radix tree: %d\n", ret);
+	}
+
+	hlist_for_each_entry(alias, elem, alias_list, node) {
+		if (alias->offset == offset) {
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+
+	alias = kmalloc(sizeof(*alias), GFP_ATOMIC);
+	if (!alias)
+		panic("kmemleak: cannot allocate initial memory\n");
+	INIT_HLIST_NODE(&alias->node);
+	alias->offset = offset;
+
+	hlist_add_head_rcu(&alias->node, alias_list);
+
+ out:
+	write_unlock(&alias_tree_lock);
+	recursive_clear(cpu_id);
+	recursive_exit(flags);
+
+	return ret;
+}
+
+/* Insert pointer aliases from the given array */
+void memleak_insert_aliases(struct memleak_offset *ml_off_start,
+			    struct memleak_offset *ml_off_end)
+{
+	struct memleak_offset *ml_off;
+	int i = 0;
+#ifdef CONFIG_DEBUG_MEMLEAK_SECONDARY_ALIASES
+	unsigned long flags;
+#endif
+
+	pr_debug("%s(0x%p, 0x%p)\n", __FUNCTION__, ml_off_start, ml_off_end);
+
+	/* primary aliases - container_of(member) */
+	for (ml_off = ml_off_start; ml_off < ml_off_end; ml_off++)
+		if (!insert_alias(ml_off->type_id, ml_off->offset))
+			i++;
+	pr_debug("kmemleak: found %d primary alias(es)\n", i);
+
+#ifdef CONFIG_DEBUG_MEMLEAK_SECONDARY_ALIASES
+	/* secondary aliases - container_of(container_of(member)) */
+	for (ml_off = ml_off_start; ml_off < ml_off_end; ml_off++) {
+		struct hlist_head *alias_list;
+		struct memleak_alias *alias;
+		struct hlist_node *elem;
+
+		/* with imprecise type identification, if the member
+		 * id is the same as the outer structure id, just
+		 * ignore as any potential aliases are already in the
+		 * tree */
+		if (ml_off->member_type_id == ml_off->type_id)
+			continue;
+
+		read_lock_irqsave(&alias_tree_lock, flags);
+		alias_list = radix_tree_lookup(&alias_tree, ml_off->member_type_id);
+		read_unlock_irqrestore(&alias_tree_lock, flags);
+		if (!alias_list)
+			continue;
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(alias, elem, alias_list, node)
+			if (!insert_alias(ml_off->type_id, ml_off->offset + alias->offset))
+				i++;
+		rcu_read_unlock();
+	}
+	pr_debug("kmemleak: found %d alias(es)\n", i);
+#endif
+}
+EXPORT_SYMBOL_GPL(memleak_insert_aliases);
+
+/* called with interrupts disabled */
+static inline struct memleak_object *get_cached_object(unsigned long ptr)
+{
+	struct memleak_object *object;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	spin_lock(&memleak_lock);
+	if (!last_object || ptr != last_object->pointer)
+		last_object = hash_lookup(ptr);
+	object = last_object;
+	spin_unlock(&memleak_lock);
+
+	return object;
+}
+
+/* no need for atomic operations since memleak_lock is already held
+ * and interrupts disabled. Return 1 if successful or 0 otherwise */
+static inline int get_object(struct memleak_object *object)
+{
+	BUG_ON_LOCKING(!irqs_disabled());
+	BUG_ON_LOCKING(!spin_is_locked(&memleak_lock));
+
+	if (object->use_count != 0)
+		object->use_count++;
+	return object->use_count != 0;
+}
+
+static void free_object_rcu(struct rcu_head *rcu)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+	struct hlist_node *elem, *tmp;
+	struct memleak_scan_area *area;
+	struct memleak_object *object =
+		container_of(rcu, struct memleak_object, rcu);
+
+	if (recursive_enter(cpu_id, flags))
+		BUG();
+
+	/* once use_count is 0, there is no code accessing the object */
+	hlist_for_each_entry_safe(area, elem, tmp, &object->area_list, node) {
+		hlist_del(elem);
+		kfree(area);
+	}
+	kmem_cache_free(object_cache, object);
+
+	recursive_clear(cpu_id);
+	recursive_exit(flags);
+}
+
+/* called without memleak_lock held */
+static void put_object(struct memleak_object *object)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	if (--object->use_count > 0)
+		goto out;
+
+	/* should only get here after delete_object was called */
+	BUG_ON(object->flags & OBJECT_ALLOCATED);
+
+	/* the last reference to this object */
+	list_del_rcu(&object->object_list);
+	call_rcu(&object->rcu, free_object_rcu);
+
+ out:
+	spin_unlock_irqrestore(&memleak_lock, flags);
+}
+
+/* called with interrupts disabled (no need to hold the memleak_lock
+ * as the the pointer aliases functions cannot be called concurrently
+ * on the same object) */
+static void delete_pointer_aliases(struct memleak_object *object)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	if (object->offset)
+		hash_delete(object->pointer + object->offset);
+
+	if (object->alias_list) {
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(alias, elem, object->alias_list, node)
+			hash_delete(object->pointer
+				    + object->offset + alias->offset);
+		rcu_read_unlock();
+		object->alias_list = NULL;
+	}
+}
+
+/* called with interrupts disabled (see above for why memleak_lock
+ * doesn't need to be held) */
+static void create_pointer_aliases(struct memleak_object *object)
+{
+	struct memleak_alias *alias;
+	struct hlist_node *elem;
+	int err;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	if (object->offset) {
+		err = hash_insert(object->pointer + object->offset, object);
+		if (err) {
+			dump_stack();
+			panic("kmemleak: cannot insert offset into the pointer hash table: %d\n", err);
+		}
+	}
+
+	read_lock(&alias_tree_lock);
+	object->alias_list = radix_tree_lookup(&alias_tree, object->type_id);
+	read_unlock(&alias_tree_lock);
+
+	if (object->alias_list) {
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(alias, elem, object->alias_list, node) {
+			err = hash_insert(object->pointer + object->offset
+					  + alias->offset, object);
+			if (err) {
+				dump_stack();
+				panic("kmemleak: cannot insert alias into the pointer hash table: %d\n", err);
+			}
+		}
+		rcu_read_unlock();
+	}
+}
+
+/* Insert a pointer and its aliases into the pointer hash table */
+static inline void create_object(unsigned long ptr, size_t size, int ref_count)
+{
+	struct memleak_object *object;
+	int err;
+	struct stack_trace trace;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	object = kmem_cache_alloc(object_cache, GFP_ATOMIC);
+	if (!object)
+		panic("kmemleak: cannot allocate a memleak_object structure\n");
+
+	INIT_LIST_HEAD(&object->object_list);
+	INIT_LIST_HEAD(&object->gray_list);
+	INIT_HLIST_HEAD(&object->area_list);
+	object->flags = OBJECT_TYPE_GUESSED;
+	object->use_count = 1;
+	object->pointer = ptr;
+	object->offset = 0;
+	object->size = size;
+	object->type_id = ml_guess_typeid(size);	/* type id approximation */
+	object->ref_count = ref_count;
+	object->count = -1;
+	object->report_thld = CONFIG_DEBUG_MEMLEAK_REPORT_THLD;
+	object->alias_list = NULL;
+
+	trace.max_entries = MAX_TRACE;
+	trace.nr_entries = 0;
+	trace.entries = object->trace;
+	trace.skip = 2;
+	trace.all_contexts = 0;
+	save_stack_trace(&trace, NULL);
+
+	object->trace_len = trace.nr_entries;
+
+	spin_lock(&memleak_lock);
+	/* object->use_count already set to 1 */
+	list_add_tail_rcu(&object->object_list, &object_list);
+	spin_unlock(&memleak_lock);
+
+	err = hash_insert(ptr, object);
+	if (err) {
+		dump_stack();
+		if (err == -EEXIST) {
+			printk(KERN_NOTICE "Existing pointer:\n");
+			spin_lock(&memleak_lock);
+			object = hash_lookup(ptr);
+			dump_object_info(object);
+			spin_unlock(&memleak_lock);
+		}
+		panic("kmemleak: cannot insert 0x%lx into the pointer hash table: %d\n",
+		      ptr, err);
+	}
+
+	create_pointer_aliases(object);
+
+	/* everything completed fine, just mark the object as allocated */
+	spin_lock(&memleak_lock);
+	object->flags |= OBJECT_ALLOCATED;
+	last_object = object;
+	spin_unlock(&memleak_lock);
+}
+
+/* Remove a pointer and its aliases from the pointer hash table */
+static inline void delete_object(unsigned long ptr)
+{
+	struct memleak_object *object;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	object = hash_delete(ptr);
+	if (!object) {
+		dump_stack();
+		printk(KERN_WARNING "kmemleak: freeing unknown object at 0x%08lx\n", ptr);
+		return;
+	}
+
+	spin_lock(&memleak_lock);
+
+	if (object->pointer != ptr) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: freeing object by alias 0x%08lx\n", ptr);
+	}
+	BUG_ON(!(object->flags & OBJECT_ALLOCATED));
+
+	object->flags &= ~OBJECT_ALLOCATED;
+
+	/* deleting the cached object */
+	if (last_object && ptr == last_object->pointer)
+		last_object = NULL;
+
+#ifdef CONFIG_DEBUG_MEMLEAK_ORPHAN_FREEING
+	if (color_white(object)) {
+		dump_stack();
+		dump_object_info(object);
+		printk(KERN_WARNING "kmemleak: freeing orphan object 0x%08lx\n", ptr);
+	}
+#endif
+
+	spin_unlock(&memleak_lock);
+
+	delete_pointer_aliases(object);
+	object->pointer = 0;
+	put_object(object);
+}
+
+/* Re-create the pointer aliases according to the new size/offset
+ * information */
+static inline void unpad_object(unsigned long ptr, unsigned long offset,
+				size_t size)
+{
+	struct memleak_object *object;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	object = get_cached_object(ptr);
+	if (!object) {
+		dump_stack();
+		panic("kmemleak: resizing unknown object at 0x%08lx\n", ptr);
+	}
+	if (object->pointer != ptr) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: resizing object by alias 0x%08lx\n", ptr);
+	}
+	if (offset + size > object->size) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: new boundaries exceed object 0x%08lx\n", ptr);
+	}
+
+	/* nothing changed */
+	if (offset == object->offset && size == object->size)
+		return;
+
+	/* re-create the pointer aliases */
+	delete_pointer_aliases(object);
+
+	spin_lock(&memleak_lock);
+	object->offset = offset;
+	object->size = size;
+	if (object->flags & OBJECT_TYPE_GUESSED)
+		object->type_id = ml_guess_typeid(size);
+	spin_unlock(&memleak_lock);
+
+	create_pointer_aliases(object);
+}
+
+/* Make a object permanently gray (false positive) */
+static inline void make_gray_object(unsigned long ptr)
+{
+	struct memleak_object *object;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	object = get_cached_object(ptr);
+	if (!object) {
+		dump_stack();
+		panic("kmemleak: graying unknown object at 0x%08lx\n", ptr);
+	}
+	if (object->pointer != ptr) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: graying object by alias 0x%08lx\n", ptr);
+	}
+
+	spin_lock(&memleak_lock);
+	object->ref_count = 0;
+	spin_unlock(&memleak_lock);
+}
+
+/* Mark the object as black */
+static inline void make_black_object(unsigned long ptr)
+{
+	struct memleak_object *object;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	object = get_cached_object(ptr);
+	if (!object) {
+		dump_stack();
+		panic("kmemleak: blacking unknown object at 0x%08lx\n", ptr);
+	}
+	if (object->pointer != ptr) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: blacking object by alias 0x%08lx\n", ptr);
+	}
+
+	spin_lock(&memleak_lock);
+	object->ref_count = -1;
+	spin_unlock(&memleak_lock);
+}
+
+/* Add a scanning area to the object */
+static inline void add_scan_area(unsigned long ptr, unsigned long offset, size_t length)
+{
+	struct memleak_object *object;
+	struct memleak_scan_area *area;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	area = kmalloc(sizeof(*area), GFP_ATOMIC);
+	if (!area)
+		panic("kmemleak: cannot allocate a scan area\n");
+
+	INIT_HLIST_NODE(&area->node);
+	area->offset = offset;
+	area->length = length;
+
+	object = get_cached_object(ptr);
+	if (!object) {
+		dump_stack();
+		panic("kmemleak: adding scan area to unknown object at 0x%08lx\n", ptr);
+	}
+	if (object->pointer != ptr) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: adding scan area to object by alias 0x%08lx\n", ptr);
+	}
+	if (offset + length > object->size) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: scan area larger than object 0x%08lx\n", ptr);
+	}
+
+	spin_lock(&memleak_lock);
+	hlist_add_head(&area->node, &object->area_list);
+	spin_unlock(&memleak_lock);
+}
+
+/* Re-create the pointer aliases according to the new type id */
+static inline void change_type_id(unsigned long ptr, unsigned long type_id)
+{
+	struct memleak_object *object;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+
+	object = get_cached_object(ptr);
+	if (!object) {
+		dump_stack();
+		panic("kmemleak: changing type of unknown object at 0x%08lx\n", ptr);
+	}
+	if (object->pointer != ptr) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: changing type of object by alias 0x%08lx\n", ptr);
+	}
+	if (ml_sizeof(type_id) > object->size) {
+		dump_stack();
+		dump_object_info(object);
+		panic("kmemleak: new type larger than object 0x%08lx\n", ptr);
+	}
+
+	spin_lock(&memleak_lock);
+	object->type_id = type_id;
+	object->flags &= ~OBJECT_TYPE_GUESSED;
+	spin_unlock(&memleak_lock);
+
+	if (type_id == object->type_id)
+		return;
+
+	delete_pointer_aliases(object);
+	create_pointer_aliases(object);
+}
+
+/* Allocation function hook */
+void memleak_alloc(const void *ptr, size_t size, int ref_count)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p, %d, %d)\n", __FUNCTION__, ptr, size, ref_count);
+
+	if (!atomic_read(&memleak_initialized)) {
+		/* no need for SMP locking since this object is
+		 * executed before the other CPUs are started */
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_ALLOC;
+			object->pointer = ptr;
+			object->size = size;
+			object->ref_count = ref_count;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	create_object((unsigned long)ptr, size, ref_count);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL_GPL(memleak_alloc);
+
+/* Freeing function hook */
+void memleak_free(const void *ptr)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p)\n", __FUNCTION__, ptr);
+
+	if (!atomic_read(&memleak_initialized)) {
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_FREE;
+			object->pointer = ptr;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	delete_object((unsigned long)ptr);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL_GPL(memleak_free);
+
+/* Change the size and location information of an allocated memory
+ * object (this is needed for allocations padding the object) */
+void memleak_padding(const void *ptr, unsigned long offset, size_t size)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p, %d)\n", __FUNCTION__, ptr, size);
+
+	if (!atomic_read(&memleak_initialized)) {
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_PADDING;
+			object->pointer = ptr;
+			object->offset = offset;
+			object->size = size;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	unpad_object((unsigned long)ptr, offset, size);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL(memleak_padding);
+
+/* Mark a object as a false positive */
+void memleak_not_leak(const void *ptr)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p)\n", __FUNCTION__, ptr);
+
+	if (!atomic_read(&memleak_initialized)) {
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_NOT_LEAK;
+			object->pointer = ptr;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	make_gray_object((unsigned long)ptr);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL(memleak_not_leak);
+
+/* Ignore this memory object */
+void memleak_ignore(const void *ptr)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p)\n", __FUNCTION__, ptr);
+
+	if (!atomic_read(&memleak_initialized)) {
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_IGNORE;
+			object->pointer = ptr;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	make_black_object((unsigned long)ptr);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL(memleak_ignore);
+
+/* Add a scanning area to a object */
+void memleak_scan_area(const void *ptr, unsigned long offset, size_t length)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p)\n", __FUNCTION__, ptr);
+
+	if (!atomic_read(&memleak_initialized)) {
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_SCAN_AREA;
+			object->pointer = ptr;
+			object->offset = offset;
+			object->size = length;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	add_scan_area((unsigned long)ptr, offset, length);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL(memleak_scan_area);
+
+/* Change the type id of an allocated memory object */
+void memleak_typeid_raw(const void *ptr, unsigned long type_id)
+{
+	unsigned long flags;
+	unsigned int cpu_id;
+
+	if (!ptr)
+		return;
+	if (!type_id)
+		return;
+
+	if (recursive_enter(cpu_id, flags))
+		goto out;
+
+	pr_debug("%s(0x%p, %ld)\n", __FUNCTION__, ptr, type_id);
+
+	if (!atomic_read(&memleak_initialized)) {
+		struct memleak_preinit_object *object;
+
+		BUG_ON(cpu_id != 0);
+
+		if (preinit_pos < PREINIT_OBJECTS) {
+			object = &preinit_objects[preinit_pos];
+
+			object->type = MEMLEAK_TYPEID;
+			object->pointer = ptr;
+			object->type_id = type_id;
+		}
+		preinit_pos++;
+
+		goto clear;
+	}
+
+	change_type_id((unsigned long)ptr, type_id);
+
+ clear:
+	recursive_clear(cpu_id);
+ out:
+	recursive_exit(flags);
+}
+EXPORT_SYMBOL(memleak_typeid_raw);
+
+/* Scan a block of memory (exclusive range) for pointers and move
+ * those found to the gray list. This function is called with
+ * memleak_lock held and interrupts disabled */
+static void __scan_block(void *_start, void *_end)
+{
+	unsigned long *ptr;
+	unsigned long *start = (unsigned long *)ALIGN((unsigned long)_start,
+						      BYTES_PER_WORD);
+	unsigned long *end = _end;
+
+	BUG_ON_LOCKING(!irqs_disabled());
+	BUG_ON_LOCKING(!spin_is_locked(&memleak_lock));
+
+	for (ptr = start; ptr < end; ptr++) {
+		struct memleak_object *object =
+			hash_lookup((*ptr) & ~(BYTES_PER_WORD - 1));
+		if (!object)
+			continue;
+		if (!color_white(object))
+			continue;
+
+		object->count++;
+		/* this can also happen during the gray_list traversal */
+		if (color_gray(object)) {
+			/* found in the hash, get_object() returns 1 */
+			get_object(object);
+			object->report_thld++;
+			list_add_tail(&object->gray_list, &gray_list);
+		}
+	}
+}
+
+static void scan_block(void *start, void *end)
+{
+	unsigned long flags;
+	void *s, *e;
+
+	s = start;
+	while (s < end) {
+		e = s + SCAN_BLOCK_SIZE;
+
+		spin_lock_irqsave(&memleak_lock, flags);
+		__scan_block(s, e < end ? e : end);
+		spin_unlock_irqrestore(&memleak_lock, flags);
+
+		s = e;
+	}
+}
+
+/* Scan a memory block represented by a memleak_object */
+static inline void scan_object(struct memleak_object *object)
+{
+	struct memleak_scan_area *area;
+	struct hlist_node *elem;
+	unsigned long flags;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	/* freed object */
+	if (!(object->flags & OBJECT_ALLOCATED))
+		goto out;
+
+	if (hlist_empty(&object->area_list))
+		__scan_block((void *)(object->pointer + object->offset),
+			     (void *)(object->pointer + object->offset
+				      + object->size));
+	else
+		hlist_for_each_entry(area, elem, &object->area_list, node)
+			__scan_block((void *)(object->pointer + area->offset),
+				     (void *)(object->pointer + area->offset
+					      + area->length));
+
+ out:
+	spin_unlock_irqrestore(&memleak_lock, flags);
+}
+
+/* Scan the memory and print the orphan objects */
+static void memleak_scan(void)
+{
+	unsigned long flags;
+	struct memleak_object *object, *tmp;
+#ifdef CONFIG_DEBUG_MEMLEAK_TASK_STACKS
+	struct task_struct *task;
+#endif
+	int i;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(object, &object_list, object_list) {
+		spin_lock_irqsave(&memleak_lock, flags);
+
+		/* there should be a maximum of 1 reference to any
+		 * object at this point */
+		BUG_ON(object->use_count > 1);
+
+		/* reset the reference count (whiten the object) */
+		object->count = 0;
+		if (color_gray(object) && get_object(object))
+			list_add_tail(&object->gray_list, &gray_list);
+		else
+			object->report_thld--;
+
+		spin_unlock_irqrestore(&memleak_lock, flags);
+	}
+	rcu_read_unlock();
+
+	/* data/bss scanning */
+	scan_block(_sdata, _edata);
+	scan_block(__bss_start, __bss_stop);
+
+#ifdef CONFIG_SMP
+	/* per-cpu scanning */
+	for_each_possible_cpu(i)
+		scan_block(__per_cpu_start + per_cpu_offset(i),
+			   __per_cpu_end + per_cpu_offset(i));
+#endif
+
+	/* mem_map scanning */
+	for_each_online_node(i) {
+		struct page *page, *end;
+
+		page = NODE_MEM_MAP(i);
+		end  = page + NODE_DATA(i)->node_spanned_pages;
+
+		scan_block(page, end);
+	}
+
+#ifdef CONFIG_DEBUG_MEMLEAK_TASK_STACKS
+	read_lock(&tasklist_lock);
+	for_each_process(task)
+		scan_block(task_stack_page(task),
+			   task_stack_page(task) + THREAD_SIZE);
+	read_unlock(&tasklist_lock);
+#endif
+
+	/* scan the objects already referenced. More objects will be
+	 * referenced and, if there are no memory leaks, all the
+	 * objects will be scanned. The list traversal is safe for
+	 * both tail additions and removals from inside the loop. The
+	 * memleak objects cannot be freed from outside the loop
+	 * because their use_count was increased */
+	object = list_entry(gray_list.next, typeof(*object), gray_list);
+	while (&object->gray_list != &gray_list) {
+		/* may add new objects to the list */
+		scan_object(object);
+
+		tmp = list_entry(object->gray_list.next, typeof(*object),
+				 gray_list);
+
+		/* remove the object from the list and release it */
+		list_del(&object->gray_list);
+		put_object(object);
+
+		object = tmp;
+	}
+	BUG_ON(!list_empty(&gray_list));
+}
+
+static void *memleak_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct memleak_object *object;
+	loff_t n = *pos;
+	unsigned long flags;
+
+	if (!n) {
+		memleak_scan();
+		reported_leaks = 0;
+	}
+	if (reported_leaks >= CONFIG_DEBUG_MEMLEAK_REPORTS_NR)
+		return NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(object, &object_list, object_list) {
+		if (n-- > 0)
+			continue;
+
+		spin_lock_irqsave(&memleak_lock, flags);
+		if (get_object(object)) {
+			spin_unlock_irqrestore(&memleak_lock, flags);
+			goto out;
+		}
+		spin_unlock_irqrestore(&memleak_lock, flags);
+	}
+	object = NULL;
+ out:
+	rcu_read_unlock();
+	return object;
+}
+
+static void *memleak_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct list_head *n;
+	struct memleak_object *next = NULL;
+	unsigned long flags;
+
+	++(*pos);
+	if (reported_leaks >= CONFIG_DEBUG_MEMLEAK_REPORTS_NR)
+		goto out;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	n = ((struct memleak_object *)v)->object_list.next;
+	if (n != &object_list) {
+		next = list_entry(n, struct memleak_object, object_list);
+		/* still in the object_list, get_object() returns 1 */
+		get_object(next);
+	}
+
+	spin_unlock_irqrestore(&memleak_lock, flags);
+
+ out:
+	put_object(v);
+	return next;
+}
+
+static void memleak_seq_stop(struct seq_file *seq, void *v)
+{
+	if (v)
+		put_object(v);
+}
+
+static int memleak_seq_show(struct seq_file *seq, void *v)
+{
+	const struct memleak_object *object = v;
+	unsigned long flags;
+	char namebuf[KSYM_NAME_LEN + 1] = "";
+	char *modname;
+	unsigned long symsize;
+	unsigned long offset = 0;
+	int i;
+
+	spin_lock_irqsave(&memleak_lock, flags);
+
+	if (!color_white(object))
+		goto out;
+	/* freed in the meantime (false positive) or just allocated */
+	if (!(object->flags & OBJECT_ALLOCATED))
+		goto out;
+	if (object->report_thld >= 0)
+		goto out;
+
+	reported_leaks++;
+	seq_printf(seq, "unreferenced object 0x%08lx (size %d):\n",
+		   object->pointer, object->size);
+
+	for (i = 0; i < object->trace_len; i++) {
+		unsigned long trace = object->trace[i];
+
+		kallsyms_lookup(trace, &symsize, &offset, &modname, namebuf);
+		seq_printf(seq, "  [<%08lx>] %s\n", trace, namebuf);
+	}
+
+ out:
+	spin_unlock_irqrestore(&memleak_lock, flags);
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
+
+/* KMemLeak initialization. Set up the radix tree for the pointer aliases */
+void __init memleak_init(void)
+{
+	int i;
+	unsigned long flags;
+
+	hash_init();
+
+	object_cache = kmem_cache_create("memleak_object_cache", sizeof(struct memleak_object),
+					 0, SLAB_PANIC, NULL, NULL);
+	if (!object_cache)
+		panic("kmemleak: cannot create the object cache\n");
+
+	memleak_insert_aliases(__memleak_offsets_start, __memleak_offsets_end);
+
+	/* no need to hold the spinlock as SMP is not initialized
+	 * yet. Holding it here would lead to a deadlock */
+	local_irq_save(flags);
+
+	atomic_set(&memleak_initialized, 1);
+
+	if (preinit_pos >= PREINIT_OBJECTS)
+		panic("kmemleak: preinit objects buffer overflow: %d\n",
+		      preinit_pos);
+
+	/* execute the buffered memleak actions */
+	pr_debug("kmemleak: %d preinit actions\n", preinit_pos);
+	for (i = 0; i < preinit_pos; i++) {
+		struct memleak_preinit_object *object = &preinit_objects[i];
+
+		switch (object->type) {
+		case MEMLEAK_ALLOC:
+			memleak_alloc(object->pointer, object->size,
+				      object->ref_count);
+			break;
+		case MEMLEAK_FREE:
+			memleak_free(object->pointer);
+			break;
+		case MEMLEAK_PADDING:
+			memleak_padding(object->pointer, object->offset,
+					object->size);
+			break;
+		case MEMLEAK_NOT_LEAK:
+			memleak_not_leak(object->pointer);
+			break;
+		case MEMLEAK_IGNORE:
+			memleak_ignore(object->pointer);
+			break;
+		case MEMLEAK_SCAN_AREA:
+			memleak_scan_area(object->pointer,
+					  object->offset, object->size);
+			break;
+		case MEMLEAK_TYPEID:
+			memleak_typeid_raw(object->pointer, object->type_id);
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
+	struct dentry *dentry;
+
+	dentry = debugfs_create_file("memleak", S_IRUGO, NULL, NULL,
+				     &memleak_fops);
+	if (!dentry)
+		return -ENOMEM;
+
+	pr_debug("kmemleak: late initialization completed\n");
+
+	return 0;
+}
+late_initcall(memleak_late_init);
