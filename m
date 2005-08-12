Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVHLOtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVHLOtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVHLOry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21915 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750719AbVHLOrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:32 -0400
Subject: [RFC][PATCH 08/12] memory hotplug: sysfs and add/remove functions
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:28 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144728.74B3689B@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds generic memory add/remove and supporting functions 
for memory hotplug into a new file as well as a memory hotplug
kernel config option.

Individual architecture patches will follow.

For now, disable memory hotplug when swsusp is enabled.  There's
a lot of churn there right now.  We'll fix it up properly once
it calms down.

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/drivers/base/Makefile          |    1 
 memhotplug-dave/drivers/base/init.c            |    2 
 memhotplug-dave/drivers/base/memory.c          |  455 +++++++++++++++++++++++++
 memhotplug-dave/include/linux/memory.h         |   94 +++++
 memhotplug-dave/include/linux/memory_hotplug.h |   35 +
 memhotplug-dave/include/linux/mm.h             |    1 
 memhotplug-dave/mm/Kconfig                     |    8 
 memhotplug-dave/mm/Makefile                    |    2 
 memhotplug-dave/mm/memory_hotplug.c            |  178 +++++++++
 memhotplug-dave/mm/page_alloc.c                |    4 
 mm/sparse.c                                    |    0 
 11 files changed, 777 insertions(+), 3 deletions(-)

diff -puN drivers/base/Makefile~D0-sysfs-memory-class drivers/base/Makefile
--- memhotplug/drivers/base/Makefile~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/drivers/base/Makefile	2005-08-12 07:43:48.000000000 -0700
@@ -7,6 +7,7 @@ obj-y			:= core.o sys.o bus.o dd.o \
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
+obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -puN drivers/base/init.c~D0-sysfs-memory-class drivers/base/init.c
--- memhotplug/drivers/base/init.c~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/drivers/base/init.c	2005-08-12 07:43:48.000000000 -0700
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/memory.h>
 
 extern int devices_init(void);
 extern int buses_init(void);
@@ -39,5 +40,6 @@ void __init driver_init(void)
 	platform_bus_init();
 	system_bus_init();
 	cpu_dev_init();
+	memory_dev_init();
 	attribute_container_init();
 }
diff -puN /dev/null drivers/base/memory.c
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ memhotplug-dave/drivers/base/memory.c	2005-08-12 07:43:48.000000000 -0700
@@ -0,0 +1,455 @@
+/*
+ * drivers/base/memory.c - basic Memory class support
+ *
+ * Written by Matt Tolentino <matthew.e.tolentino@intel.com>
+ *            Dave Hansen <haveblue@us.ibm.com>
+ *
+ * This file provides the necessary infrastructure to represent
+ * a SPARSEMEM-memory-model system's physical memory in /sysfs.
+ * All arch-independent code that assumes MEMORY_HOTPLUG requires
+ * SPARSEMEM should be contained here, or in mm/memory_hotplug.c.
+ */
+
+#include <linux/sysdev.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>	/* capable() */
+#include <linux/topology.h>
+#include <linux/device.h>
+#include <linux/memory.h>
+#include <linux/kobject.h>
+#include <linux/memory_hotplug.h>
+#include <linux/mm.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#define MEMORY_CLASS_NAME	"memory"
+
+struct sysdev_class memory_sysdev_class = {
+	set_kset_name(MEMORY_CLASS_NAME),
+};
+EXPORT_SYMBOL(memory_sysdev_class);
+
+static char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
+{
+	return MEMORY_CLASS_NAME;
+}
+
+static int memory_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+			int num_envp, char *buffer, int buffer_size)
+{
+	int retval = 0;
+
+	return retval;
+}
+
+static struct kset_hotplug_ops memory_hotplug_ops = {
+	.name		= memory_hotplug_name,
+	.hotplug	= memory_hotplug,
+};
+
+static struct notifier_block *memory_chain;
+
+int register_memory_notifier(struct notifier_block *nb)
+{
+        return notifier_chain_register(&memory_chain, nb);
+}
+
+void unregister_memory_notifier(struct notifier_block *nb)
+{
+        notifier_chain_unregister(&memory_chain, nb);
+}
+
+/*
+ * register_memory - Setup a sysfs device for a memory block
+ */
+int
+register_memory(struct memory_block *memory, struct mem_section *section,
+		struct node *root)
+{
+	int error;
+
+	memory->sysdev.cls = &memory_sysdev_class;
+	memory->sysdev.id = __section_nr(section);
+
+	error = sysdev_register(&memory->sysdev);
+
+	if (root && !error)
+		error = sysfs_create_link(&root->sysdev.kobj,
+					  &memory->sysdev.kobj,
+					  kobject_name(&memory->sysdev.kobj));
+
+	return error;
+}
+
+void
+unregister_memory(struct memory_block *memory, struct mem_section *section,
+		struct node *root)
+{
+	BUG_ON(memory->sysdev.cls != &memory_sysdev_class);
+	BUG_ON(memory->sysdev.id != __section_nr(section));
+
+	sysdev_unregister(&memory->sysdev);
+	if (root)
+		sysfs_remove_link(&root->sysdev.kobj,
+				  kobject_name(&memory->sysdev.kobj));
+}
+
+/*
+ * use this as the physical section index that this memsection
+ * uses.
+ */
+
+static ssize_t show_mem_phys_index(struct sys_device *dev, char *buf)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	return sprintf(buf, "%08lx\n", mem->phys_index);
+}
+
+/*
+ * online, offline, going offline, etc.
+ */
+static ssize_t show_mem_state(struct sys_device *dev, char *buf)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	ssize_t len = 0;
+
+	/*
+	 * We can probably put these states in a nice little array
+	 * so that they're not open-coded
+	 */
+	switch (mem->state) {
+		case MEM_ONLINE:
+			len = sprintf(buf, "online\n");
+			break;
+		case MEM_OFFLINE:
+			len = sprintf(buf, "offline\n");
+			break;
+		case MEM_GOING_OFFLINE:
+			len = sprintf(buf, "going-offline\n");
+			break;
+		default:
+			len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
+					mem->state);
+			WARN_ON(1);
+			break;
+	}
+
+	return len;
+}
+
+static inline int memory_notify(unsigned long val, void *v)
+{
+	return notifier_call_chain(&memory_chain, val, v);
+}
+
+/*
+ * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
+ * OK to have direct references to sparsemem variables in here.
+ */
+static int
+memory_block_action(struct memory_block *mem, unsigned long action)
+{
+	int i;
+	unsigned long psection;
+	unsigned long start_pfn, start_paddr;
+	struct page *first_page;
+	int ret;
+	int old_state = mem->state;
+
+	psection = mem->phys_index;
+	first_page = pfn_to_page(psection << PFN_SECTION_SHIFT);
+
+	/*
+	 * The probe routines leave the pages reserved, just
+	 * as the bootmem code does.  Make sure they're still
+	 * that way.
+	 */
+	if (action == MEM_ONLINE) {
+		for (i = 0; i < PAGES_PER_SECTION; i++) {
+			if (PageReserved(first_page+i))
+				continue;
+
+			printk(KERN_WARNING "section number %ld page number %d "
+				"not reserved, was it already online? \n",
+				psection, i);
+			return -EBUSY;
+		}
+	}
+
+	switch (action) {
+		case MEM_ONLINE:
+			start_pfn = page_to_pfn(first_page);
+			ret = online_pages(start_pfn, PAGES_PER_SECTION);
+			break;
+		case MEM_OFFLINE:
+			mem->state = MEM_GOING_OFFLINE;
+			memory_notify(MEM_GOING_OFFLINE, NULL);
+			start_paddr = page_to_pfn(first_page) << PAGE_SHIFT;
+			ret = remove_memory(start_paddr,
+					    PAGES_PER_SECTION << PAGE_SHIFT);
+			if (ret) {
+				mem->state = old_state;
+				break;
+			}
+			memory_notify(MEM_MAPPING_INVALID, NULL);
+			break;
+		default:
+			printk(KERN_WARNING "%s(%p, %ld) unknown action: %ld\n",
+					__FUNCTION__, mem, action, action);
+			WARN_ON(1);
+			ret = -EINVAL;
+	}
+	/*
+	 * For now, only notify on successful memory operations
+	 */
+	if (!ret)
+		memory_notify(action, NULL);
+
+	return ret;
+}
+
+static int memory_block_change_state(struct memory_block *mem,
+		unsigned long to_state, unsigned long from_state_req)
+{
+	int ret = 0;
+	down(&mem->state_sem);
+
+	if (mem->state != from_state_req) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = memory_block_action(mem, to_state);
+	if (!ret)
+		mem->state = to_state;
+
+out:
+	up(&mem->state_sem);
+	return ret;
+}
+
+static ssize_t
+store_mem_state(struct sys_device *dev, const char *buf, size_t count)
+{
+	struct memory_block *mem;
+	unsigned int phys_section_nr;
+	int ret = -EINVAL;
+
+	mem = container_of(dev, struct memory_block, sysdev);
+	phys_section_nr = mem->phys_index;
+
+	if (!valid_section_nr(phys_section_nr))
+		goto out;
+
+	if (!strncmp(buf, "online", min((int)count, 6)))
+		ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
+	else if(!strncmp(buf, "offline", min((int)count, 7)))
+		ret = memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
+out:
+	if (ret)
+		return ret;
+	return count;
+}
+
+/*
+ * phys_device is a bad name for this.  What I really want
+ * is a way to differentiate between memory ranges that
+ * are part of physical devices that constitute
+ * a complete removable unit or fru.
+ * i.e. do these ranges belong to the same physical device,
+ * s.t. if I offline all of these sections I can then
+ * remove the physical device?
+ */
+static ssize_t show_phys_device(struct sys_device *dev, char *buf)
+{
+	struct memory_block *mem =
+		container_of(dev, struct memory_block, sysdev);
+	return sprintf(buf, "%d\n", mem->phys_device);
+}
+
+SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
+SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
+SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
+
+#define mem_create_simple_file(mem, attr_name)	\
+	sysdev_create_file(&mem->sysdev, &attr_##attr_name)
+#define mem_remove_simple_file(mem, attr_name)	\
+	sysdev_remove_file(&mem->sysdev, &attr_##attr_name)
+
+/*
+ * Block size attribute stuff
+ */
+static ssize_t
+print_block_size(struct class *class, char *buf)
+{
+	return sprintf(buf, "%lx\n", (unsigned long)PAGES_PER_SECTION * PAGE_SIZE);
+}
+
+static CLASS_ATTR(block_size_bytes, 0444, print_block_size, NULL);
+
+static int block_size_init(void)
+{
+	sysfs_create_file(&memory_sysdev_class.kset.kobj,
+		&class_attr_block_size_bytes.attr);
+	return 0;
+}
+
+/*
+ * Some architectures will have custom drivers to do this, and
+ * will not need to do it from userspace.  The fake hot-add code
+ * as well as ppc64 will do all of their discovery in userspace
+ * and will require this interface.
+ */
+#ifdef CONFIG_ARCH_MEMORY_PROBE
+static ssize_t
+memory_probe_store(struct class *class, const char __user *buf, size_t count)
+{
+	u64 phys_addr;
+	int ret;
+
+	phys_addr = simple_strtoull(buf, NULL, 0);
+
+	ret = add_memory(phys_addr, PAGES_PER_SECTION << PAGE_SHIFT);
+
+	if (ret)
+		count = ret;
+
+	return count;
+}
+static CLASS_ATTR(probe, 0700, NULL, memory_probe_store);
+
+static int memory_probe_init(void)
+{
+	sysfs_create_file(&memory_sysdev_class.kset.kobj,
+		&class_attr_probe.attr);
+	return 0;
+}
+#else
+#define memory_probe_init(...)	do {} while (0)
+#endif
+
+/*
+ * Note that phys_device is optional.  It is here to allow for
+ * differentiation between which *physical* devices each
+ * section belongs to...
+ */
+
+int add_memory_block(unsigned long node_id, struct mem_section *section,
+		     unsigned long state, int phys_device)
+{
+	size_t size = sizeof(struct memory_block);
+	struct memory_block *mem = kmalloc(size, GFP_KERNEL);
+	int ret = 0;
+
+	if (!mem)
+		return -ENOMEM;
+
+	memset(mem, 0, size);
+
+	mem->phys_index = __section_nr(section);
+	mem->state = state;
+	init_MUTEX(&mem->state_sem);
+	mem->phys_device = phys_device;
+
+	ret = register_memory(mem, section, NULL);
+	if (!ret)
+		ret = mem_create_simple_file(mem, phys_index);
+	if (!ret)
+		ret = mem_create_simple_file(mem, state);
+	if (!ret)
+		ret = mem_create_simple_file(mem, phys_device);
+
+	return ret;
+}
+
+/*
+ * For now, we have a linear search to go find the appropriate
+ * memory_block corresponding to a particular phys_index. If
+ * this gets to be a real problem, we can always use a radix
+ * tree or something here.
+ *
+ * This could be made generic for all sysdev classes.
+ */
+struct memory_block *find_memory_block(struct mem_section *section)
+{
+	struct kobject *kobj;
+	struct sys_device *sysdev;
+	struct memory_block *mem;
+	char name[sizeof(MEMORY_CLASS_NAME) + 9 + 1];
+
+	/*
+	 * This only works because we know that section == sysdev->id
+	 * slightly redundant with sysdev_register()
+	 */
+	sprintf(&name[0], "%s%d", MEMORY_CLASS_NAME, __section_nr(section));
+
+	kobj = kset_find_obj(&memory_sysdev_class.kset, name);
+	if (!kobj)
+		return NULL;
+
+	sysdev = container_of(kobj, struct sys_device, kobj);
+	mem = container_of(sysdev, struct memory_block, sysdev);
+
+	return mem;
+}
+
+int remove_memory_block(unsigned long node_id, struct mem_section *section,
+		int phys_device)
+{
+	struct memory_block *mem;
+
+	mem = find_memory_block(section);
+	mem_remove_simple_file(mem, phys_index);
+	mem_remove_simple_file(mem, state);
+	mem_remove_simple_file(mem, phys_device);
+	unregister_memory(mem, section, NULL);
+
+	return 0;
+}
+
+/*
+ * need an interface for the VM to add new memory regions,
+ * but without onlining it.
+ */
+int register_new_memory(struct mem_section *section)
+{
+	return add_memory_block(0, section, MEM_OFFLINE, 0);
+}
+
+int unregister_memory_section(struct mem_section *section)
+{
+	if (!valid_section(section))
+		return -EINVAL;
+
+	return remove_memory_block(0, section, 0);
+}
+
+/*
+ * Initialize the sysfs support for memory devices...
+ */
+int __init memory_dev_init(void)
+{
+	unsigned int i;
+	int ret;
+
+	memory_sysdev_class.kset.hotplug_ops = &memory_hotplug_ops;
+	ret = sysdev_class_register(&memory_sysdev_class);
+
+	/*
+	 * Create entries for memory sections that were found
+	 * during boot and have been initialized
+	 */
+	for (i = 0; i < NR_MEM_SECTIONS; i++) {
+		if (!valid_section_nr(i))
+			continue;
+		add_memory_block(0, __nr_to_section(i), MEM_ONLINE, 0);
+	}
+
+	memory_probe_init();
+	block_size_init();
+
+	return ret;
+}
diff -puN include/asm-i386/highmem.h~D0-sysfs-memory-class include/asm-i386/highmem.h
diff -puN /dev/null include/linux/memory.h
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ memhotplug-dave/include/linux/memory.h	2005-08-12 07:43:48.000000000 -0700
@@ -0,0 +1,94 @@
+/*
+ * include/linux/memory.h - generic memory definition
+ *
+ * This is mainly for topological representation. We define the
+ * basic "struct memory_block" here, which can be embedded in per-arch
+ * definitions or NUMA information.
+ *
+ * Basic handling of the devices is done in drivers/base/memory.c
+ * and system devices are handled in drivers/base/sys.c.
+ *
+ * Memory block are exported via sysfs in the class/memory/devices/
+ * directory.
+ *
+ */
+#ifndef _LINUX_MEMORY_H_
+#define _LINUX_MEMORY_H_
+
+#include <linux/sysdev.h>
+#include <linux/node.h>
+#include <linux/compiler.h>
+
+#include <asm/semaphore.h>
+
+struct memory_block {
+	unsigned long phys_index;
+	unsigned long state;
+	/*
+	 * This serializes all state change requests.  It isn't
+	 * held during creation because the control files are
+	 * created long after the critical areas during
+	 * initialization.
+	 */
+	struct semaphore state_sem;
+	int phys_device;		/* to which fru does this belong? */
+	void *hw;			/* optional pointer to fw/hw data */
+	int (*phys_callback)(struct memory_block *);
+	struct sys_device sysdev;
+};
+
+/* These states are exposed to userspace as text strings in sysfs */
+#define	MEM_ONLINE		(1<<0) /* exposed to userspace */
+#define	MEM_GOING_OFFLINE	(1<<1) /* exposed to userspace */
+#define	MEM_OFFLINE		(1<<2) /* exposed to userspace */
+
+/*
+ * All of these states are currently kernel-internal for notifying
+ * kernel components and architectures.
+ *
+ * For MEM_MAPPING_INVALID, all notifier chains with priority >0
+ * are called before pfn_to_page() becomes invalid.  The priority=0
+ * entry is reserved for the function that actually makes
+ * pfn_to_page() stop working.  Any notifiers that want to be called
+ * after that should have priority <0.
+ */
+#define	MEM_MAPPING_INVALID	(1<<3)
+
+#ifndef CONFIG_MEMORY_HOTPLUG
+static inline int memory_dev_init(void)
+{
+	return 0;
+}
+static inline int register_memory_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline void unregister_memory_notifier(struct notifier_block *nb)
+{
+}
+#else
+extern int register_memory(struct memory_block *, struct mem_section *section, struct node *);
+extern int register_new_memory(struct mem_section *);
+extern int unregister_memory_section(struct mem_section *);
+extern int memory_dev_init(void);
+extern int register_memory_notifier(struct notifier_block *nb);
+extern void unregister_memory_notifier(struct notifier_block *nb);
+
+#define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
+
+extern int invalidate_phys_mapping(unsigned long, unsigned long);
+struct notifier_block;
+
+extern int register_memory_notifier(struct notifier_block *nb);
+extern void unregister_memory_notifier(struct notifier_block *nb);
+
+extern struct sysdev_class memory_sysdev_class;
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
+#define hotplug_memory_notifier(fn, pri) {			\
+	static struct notifier_block fn##_mem_nb =		\
+		{ .notifier_call = fn, .priority = pri };	\
+	register_memory_notifier(&fn##_mem_nb);			\
+}
+
+#endif /* _LINUX_MEMORY_H_ */
diff -puN include/linux/memory_hotplug.h~D0-sysfs-memory-class include/linux/memory_hotplug.h
--- memhotplug/include/linux/memory_hotplug.h~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/include/linux/memory_hotplug.h	2005-08-12 07:43:48.000000000 -0700
@@ -3,6 +3,8 @@
 
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/mmzone.h>
+#include <linux/notifier.h>
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
@@ -46,6 +48,19 @@ static inline void zone_seqlock_init(str
 {
 	seqlock_init(&zone->span_seqlock);
 }
+extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
+extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
+extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
+/* need some defines for these for archs that don't support it */
+extern void online_page(struct page *page);
+/* VM interface that may be used by firmware interface */
+extern int add_memory(u64 start, u64 size);
+extern int remove_memory(u64 start, u64 size);
+extern int online_pages(unsigned long, unsigned long);
+
+/* reasonably generic interface to expand the physical pages in a zone  */
+extern int __add_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages);
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off
@@ -65,5 +80,25 @@ static inline int zone_span_seqretry(str
 static inline void zone_span_writelock(struct zone *zone) {}
 static inline void zone_span_writeunlock(struct zone *zone) {}
 static inline void zone_seqlock_init(struct zone *zone) {}
+
+static inline int mhp_notimplemented(const char *func)
+{
+	printk(KERN_WARNING "%s() called, with CONFIG_MEMORY_HOTPLUG disabled\n", func);
+	dump_stack();
+	return -ENOSYS;
+}
+
+static inline int __add_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages)
+{
+	return mhp_notimplemented(__FUNCTION__);
+}
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
+static inline int __remove_pages(struct zone *zone, unsigned long start_pfn,
+	unsigned long nr_pages)
+{
+	printk(KERN_WARNING "%s() called, not yet supported\n", __FUNCTION__);
+	dump_stack();
+	return -ENOSYS;
+}
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff -puN mm/Kconfig~D0-sysfs-memory-class mm/Kconfig
--- memhotplug/mm/Kconfig~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-08-12 07:43:48.000000000 -0700
@@ -111,3 +111,11 @@ config SPARSEMEM_STATIC
 config SPARSEMEM_EXTREME
 	def_bool y
 	depends on SPARSEMEM && !SPARSEMEM_STATIC
+
+# eventually, we can have this option just 'select SPARSEMEM'
+config MEMORY_HOTPLUG
+	bool "Allow for memory hot-add"
+	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
+
+comment "Memory hotplug is currently incompatible with Software Suspend"
+	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND
diff -puN mm/Makefile~D0-sysfs-memory-class mm/Makefile
--- memhotplug/mm/Makefile~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/mm/Makefile	2005-08-12 07:43:48.000000000 -0700
@@ -18,5 +18,5 @@ obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
-
+obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
diff -puN /dev/null mm/memory_hotplug.c
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ memhotplug-dave/mm/memory_hotplug.c	2005-08-12 07:43:48.000000000 -0700
@@ -0,0 +1,178 @@
+/*
+ *  linux/mm/memory_hotplug.c
+ *
+ *  Copyright (C)
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/interrupt.h>
+#include <linux/pagemap.h>
+#include <linux/bootmem.h>
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/pagevec.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/cpu.h>
+#include <linux/memory.h>
+#include <linux/memory_hotplug.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+
+#include <asm/tlbflush.h>
+
+static struct page *__kmalloc_section_memmap(unsigned long nr_pages)
+{
+	struct page *page, *ret;
+	unsigned long memmap_size = sizeof(struct page) * nr_pages;
+
+	page = alloc_pages(GFP_KERNEL, get_order(memmap_size));
+	if (page)
+		goto got_map_page;
+
+	ret = vmalloc(memmap_size);
+	if (ret)
+		goto got_map_ptr;
+
+	return NULL;
+got_map_page:
+	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
+got_map_ptr:
+	memset(ret, 0, memmap_size);
+
+	return ret;
+}
+
+extern void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
+			  unsigned long size);
+static void __add_zone(struct zone *zone, unsigned long phys_start_pfn)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	int nr_pages = PAGES_PER_SECTION;
+	int nid = pgdat->node_id;
+	int zone_type;
+
+	zone_type = zone - pgdat->node_zones;
+	memmap_init_zone(nr_pages, nid, zone_type, phys_start_pfn);
+	zonetable_add(zone, nid, zone_type, phys_start_pfn, nr_pages);
+}
+
+extern int sparse_add_one_section(struct zone *, unsigned long,
+				  struct page *mem_map);
+int __add_section(struct zone *zone, unsigned long phys_start_pfn)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	int nr_pages = PAGES_PER_SECTION;
+	struct page *memmap;
+	int ret;
+
+	/*
+	 * This can potentially allocate memory, and does its own
+	 * internal locking.
+	 */
+	sparse_index_init(pfn_to_section_nr(phys_start_pfn), pgdat->node_id);
+
+	pgdat_resize_lock(pgdat, &flags);
+	memmap = __kmalloc_section_memmap(nr_pages);
+	ret = sparse_add_one_section(zone, phys_start_pfn, memmap);
+	pgdat_resize_unlock(pgdat, &flags);
+
+	if (ret <= 0) {
+		/* the mem_map didn't get used */
+		if (memmap >= (struct page *)VMALLOC_START &&
+		    memmap < (struct page *)VMALLOC_END)
+			vfree(memmap);
+		else
+			free_pages((unsigned long)memmap,
+				   get_order(sizeof(struct page) * nr_pages));
+	}
+
+	if (ret < 0)
+		return ret;
+
+	__add_zone(zone, phys_start_pfn);
+	return register_new_memory(__pfn_to_section(phys_start_pfn));
+}
+
+/*
+ * Reasonably generic function for adding memory.  It is
+ * expected that archs that support memory hotplug will
+ * call this function after deciding the zone to which to
+ * add the new pages.
+ */
+int __add_pages(struct zone *zone, unsigned long phys_start_pfn,
+		 unsigned long nr_pages)
+{
+	unsigned long i;
+	int err = 0;
+
+	for (i = 0; i < nr_pages; i += PAGES_PER_SECTION) {
+		err = __add_section(zone, phys_start_pfn + i);
+
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static void grow_zone_span(struct zone *zone,
+		unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long old_zone_end_pfn;
+
+	zone_span_writelock(zone);
+
+	old_zone_end_pfn = zone->zone_start_pfn + zone->spanned_pages;
+	if (start_pfn < zone->zone_start_pfn)
+		zone->zone_start_pfn = start_pfn;
+
+	if (end_pfn > old_zone_end_pfn)
+		zone->spanned_pages = end_pfn - zone->zone_start_pfn;
+
+	zone_span_writeunlock(zone);
+}
+
+static void grow_pgdat_span(struct pglist_data *pgdat,
+		unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long old_pgdat_end_pfn =
+		pgdat->node_start_pfn + pgdat->node_spanned_pages;
+
+	if (start_pfn < pgdat->node_start_pfn)
+		pgdat->node_start_pfn = start_pfn;
+
+	if (end_pfn > old_pgdat_end_pfn)
+		pgdat->node_spanned_pages = end_pfn - pgdat->node_spanned_pages;
+}
+
+int online_pages(unsigned long pfn, unsigned long nr_pages)
+{
+	unsigned long i;
+	unsigned long flags;
+	unsigned long onlined_pages = 0;
+	struct zone *zone;
+
+	/*
+	 * This doesn't need a lock to do pfn_to_page().
+	 * The section can't be removed here because of the
+	 * memory_block->state_sem.
+	 */
+	zone = page_zone(pfn_to_page(pfn));
+	pgdat_resize_lock(zone->zone_pgdat, &flags);
+	grow_zone_span(zone, pfn, pfn + nr_pages);
+	grow_pgdat_span(zone->zone_pgdat, pfn, pfn + nr_pages);
+	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page = pfn_to_page(pfn + i);
+		online_page(page);
+		onlined_pages++;
+	}
+	zone->present_pages += onlined_pages;
+
+	return 0;
+}
diff -puN mm/page_alloc.c~D0-sysfs-memory-class mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-12 07:43:48.000000000 -0700
@@ -1663,7 +1663,7 @@ static void __init calculate_zone_totalp
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
-void __init memmap_init_zone(unsigned long size, int nid, unsigned long zone,
+void __devinit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn)
 {
 	struct page *page;
@@ -2386,7 +2386,7 @@ static void setup_per_zone_lowmem_reserv
  *	that the pages_{min,low,high} values for each zone are set correctly 
  *	with respect to min_free_kbytes.
  */
-static void setup_per_zone_pages_min(void)
+void setup_per_zone_pages_min(void)
 {
 	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
diff -puN include/linux/mm.h~D0-sysfs-memory-class include/linux/mm.h
--- memhotplug/include/linux/mm.h~D0-sysfs-memory-class	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/include/linux/mm.h	2005-08-12 07:43:48.000000000 -0700
@@ -791,6 +791,7 @@ extern void free_area_init_node(int nid,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
 	unsigned long *zholes_size);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
+extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
diff -puN mm/sparse.c~D0-sysfs-memory-class mm/sparse.c
_
