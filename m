Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVCOX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVCOX0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVCOX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:26:30 -0500
Received: from fmr21.intel.com ([143.183.121.13]:55739 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261998AbVCOXZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:25:01 -0500
Date: Tue, 15 Mar 2005 15:24:48 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>
Subject: [PATCH] Reading deterministic cache parameters and exporting it in /sysfs
Message-ID: <20050315152448.A1697@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
The attached patch adds support for using cpuid(4) instead of cpuid(2), to get 
CPU cache information in a deterministic way for Intel CPUs, whenever 
supported. The details of cpuid(4) can be found here

IA-32 Intel Architecture Software Developer's Manual (vol 2a)
(http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol2a)
and
Prescott New Instructions (PNI) Technology: Software Developer's Guide
(http://www.intel.com/cd/ids/developer/asmo-na/eng/events/43988.htm)
 
The advantage of using the cpuid(4) ('Deterministic Cache Parameters Leaf') are:
* It provides more information than the descriptors provided by cpuid(2)
* It is not table based as cpuid(2). So, we will not need changes to the 
  kernel to support new cache descriptors in the descriptor table (as is the 
  case with cpuid(2)).
 
The patch also adds a bunch of interfaces under 
/sys/devices/system/cpu/cpuX/cache, showing various information about the
caches. Most useful field being shared_cpu_map, which says what caches are 
shared among which logical cpus. 

The patch adds support for both i386 and x86-64.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>


--- linux-2.6.11/include/asm-i386/processor.h.org	2005-03-14 13:27:34.000000000 -0800
+++ linux-2.6.11/include/asm-i386/processor.h	2005-03-14 20:33:39.000000000 -0800
@@ -147,6 +147,18 @@ static inline void cpuid(int op, int *ea
 		: "0" (op), "c"(0));
 }
 
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
+	       	int *edx)
+{
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (op), "c" (count));
+}
+
 /*
  * CPUID functions returning a single datum
  */
--- linux-2.6.11/include/asm-x86_64/msr.h.org	2005-03-14 13:27:47.000000000 -0800
+++ linux-2.6.11/include/asm-x86_64/msr.h	2005-03-14 20:33:39.000000000 -0800
@@ -78,6 +78,18 @@ extern inline void cpuid(int op, unsigne
 		: "0" (op));
 }
 
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(int op, int count, int *eax, int *ebx, int *ecx,
+	       	int *edx)
+{
+	__asm__("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (op), "c" (count));
+}
+
 /*
  * CPUID functions returning a single datum
  */
--- linux-2.6.11/arch/i386/kernel/cpu/intel_cacheinfo.c.org	2005-03-14 13:27:20.000000000 -0800
+++ linux-2.6.11/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-03-15 13:57:30.000000000 -0800
@@ -1,5 +1,17 @@
+/*
+ *      Routines to indentify caches on Intel CPU.
+ *
+ *      Changes:
+ *      Venkatesh Pallipadi	: Adding cache identification through cpuid(4)
+ */
+
 #include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/compiler.h>
+
 #include <asm/processor.h>
+#include <asm/smp.h>
 
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
@@ -58,10 +70,142 @@ static struct _cache_table cache_table[]
 	{ 0x00, 0, 0}
 };
 
+
+enum _cache_type
+{
+	CACHE_TYPE_NULL	= 0,
+	CACHE_TYPE_DATA = 1,
+	CACHE_TYPE_INST = 2,
+	CACHE_TYPE_UNIFIED = 3
+};
+
+union _cpuid4_leaf_eax {
+	struct {
+		enum _cache_type	type:5;
+		unsigned int		level:3;
+		unsigned int		is_self_initializing:1;
+		unsigned int		is_fully_associative:1;
+		unsigned int		reserved:4;
+		unsigned int		num_threads_sharing:12;
+		unsigned int		num_cores_on_die:6;
+	} split;
+	u32 full;
+};
+
+union _cpuid4_leaf_ebx {
+	struct {
+		unsigned int		coherency_line_size:12;
+		unsigned int		physical_line_partition:10;
+		unsigned int		ways_of_associativity:10;
+	} split;
+	u32 full;
+};
+
+union _cpuid4_leaf_ecx {
+	struct {
+		unsigned int		number_of_sets:32;
+	} split;
+	u32 full;
+};
+
+struct _cpuid4_info {
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	unsigned long size;
+	cpumask_t shared_cpu_map;
+};
+
+#define MAX_CACHE_LEAVES		4
+static unsigned short			num_cache_leaves;
+
+static int cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
+{
+	unsigned int		eax, ebx, ecx, edx;
+	union _cpuid4_leaf_eax	cache_eax;
+
+	cpuid_count(4, index, &eax, &ebx, &ecx, &edx);
+	cache_eax.full = eax;
+	if (cache_eax.split.type == CACHE_TYPE_NULL)
+		return -1;
+
+	this_leaf->eax.full = eax;
+	this_leaf->ebx.full = ebx;
+	this_leaf->ecx.full = ecx;
+	this_leaf->size = (this_leaf->ecx.split.number_of_sets + 1) *
+		(this_leaf->ebx.split.coherency_line_size + 1) *
+		(this_leaf->ebx.split.physical_line_partition + 1) *
+		(this_leaf->ebx.split.ways_of_associativity + 1);
+	return 0;
+}
+
+static int find_num_cache_leaves(void)
+{
+	unsigned int		eax, ebx, ecx, edx;
+	union _cpuid4_leaf_eax	cache_eax;
+	int 			i;
+	int 			retval;
+
+	retval = MAX_CACHE_LEAVES;
+	/* Do cpuid(4) loop to find out num_cache_leaves */
+	for (i = 0; i < MAX_CACHE_LEAVES; i++) {
+		cpuid_count(4, i, &eax, &ebx, &ecx, &edx);
+		cache_eax.full = eax;
+		if (cache_eax.split.type == CACHE_TYPE_NULL) {
+			retval = i;
+			break;
+		}
+	}
+	return retval;
+}
+
 unsigned int __init init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
+	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
+	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
+
+	if (c->cpuid_level > 4) {
+		static int is_initialized;
+
+		if (is_initialized == 0) {
+			/* Init num_cache_leaves from boot CPU */
+			num_cache_leaves = find_num_cache_leaves();
+			is_initialized++;
+		}
 
+		/*
+		 * Whenever possible use cpuid(4), deterministic cache 
+		 * parameters cpuid leaf to find the cache details
+		 */
+		for (i = 0; i < num_cache_leaves; i++) {
+			struct _cpuid4_info this_leaf;
+
+			int retval;
+
+			retval = cpuid4_cache_lookup(i, &this_leaf);
+			if (retval >= 0) {
+				switch(this_leaf.eax.split.level) {
+				    case 1:
+					if (this_leaf.eax.split.type == 
+							CACHE_TYPE_DATA)
+						new_l1d = this_leaf.size/1024;
+					else if (this_leaf.eax.split.type == 
+							CACHE_TYPE_INST)
+						new_l1i = this_leaf.size/1024;
+					break;
+				    case 2:
+					new_l2 = this_leaf.size/1024;
+					break;
+				    case 3:
+					new_l3 = this_leaf.size/1024;
+					break;
+				    default:
+					break;
+				}
+			}
+		}
+	}
 	if (c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int i, j, n;
@@ -114,6 +258,18 @@ unsigned int __init init_intel_cacheinfo
 			}
 		}
 
+		if (new_l1d)
+			l1d = new_l1d;
+
+		if (new_l1i)
+			l1i = new_l1i;
+
+		if (new_l2)
+			l2 = new_l2;
+
+		if (new_l3)
+			l3 = new_l3;
+
 		if ( trace )
 			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
 		else if ( l1i )
@@ -138,3 +294,298 @@ unsigned int __init init_intel_cacheinfo
 
 	return l2;
 }
+
+#ifdef CONFIG_SYSFS
+
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/cpu.h>
+
+extern struct sysdev_class cpu_sysdev_class; /* from drivers/base/cpu.c */
+
+/* pointer to _cpuid4_info array (for each cache leaf) */
+static struct _cpuid4_info *cpuid4_info[NR_CPUS];
+#define CPUID4_INFO_IDX(x,y)    (&((cpuid4_info[x])[y]))
+
+/* pointer to kobject for cpuX/cache */ 
+static struct kobject * cache_kobject[NR_CPUS];
+
+struct _index_kobject {
+	struct kobject kobj;
+	unsigned int cpu;
+	unsigned short index;
+};
+
+/* pointer to array of kobjects for cpuX/cache/indexY */ 
+static struct _index_kobject *index_kobject[NR_CPUS];
+#define INDEX_KOBJECT_PTR(x,y)    (&((index_kobject[x])[y]))
+
+#define show_one_plus(file_name, object, val)				\
+static ssize_t show_##file_name						\
+			(struct _cpuid4_info *this_leaf, char *buf)	\
+{									\
+	return sprintf (buf, "%lu\n", (unsigned long)this_leaf->object + val); \
+}
+
+show_one_plus(level, eax.split.level, 0);
+show_one_plus(coherency_line_size, ebx.split.coherency_line_size, 1);
+show_one_plus(physical_line_partition, ebx.split.physical_line_partition, 1);
+show_one_plus(ways_of_associativity, ebx.split.ways_of_associativity, 1);
+show_one_plus(number_of_sets, ecx.split.number_of_sets, 1);
+
+static ssize_t show_size (struct _cpuid4_info *this_leaf, char *buf)
+{
+	return sprintf (buf, "%luK\n", this_leaf->size / 1024);
+}
+
+static ssize_t show_shared_cpu_map (struct _cpuid4_info *this_leaf, char *buf)
+{
+	char mask_str[NR_CPUS];
+	cpumask_scnprintf(mask_str, NR_CPUS, this_leaf->shared_cpu_map);
+	return sprintf (buf, "%s\n", mask_str);
+}
+
+static ssize_t show_type (struct _cpuid4_info *this_leaf, char *buf) {
+	switch(this_leaf->eax.split.type) {
+	    case CACHE_TYPE_DATA:
+		return sprintf (buf, "Data\n");
+		break;
+	    case CACHE_TYPE_INST:
+		return sprintf (buf, "Instruction\n");
+		break;
+	    case CACHE_TYPE_UNIFIED:
+		return sprintf (buf, "Unified\n");
+		break;
+	    default:
+		return sprintf (buf, "Unknown\n");
+		break;
+	}
+}
+
+struct _cache_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct _cpuid4_info *, char *);
+	ssize_t (*store)(struct _cpuid4_info *, const char *, size_t count);
+};
+
+#define define_one_ro(_name) \
+static struct _cache_attr _name = \
+	__ATTR(_name, 0444, show_##_name, NULL)
+
+define_one_ro(level);
+define_one_ro(type);
+define_one_ro(coherency_line_size);
+define_one_ro(physical_line_partition);
+define_one_ro(ways_of_associativity);
+define_one_ro(number_of_sets);
+define_one_ro(size);
+define_one_ro(shared_cpu_map);
+
+static struct attribute * default_attrs[] = {
+	&type.attr,
+	&level.attr,
+	&coherency_line_size.attr,
+	&physical_line_partition.attr,
+	&ways_of_associativity.attr,
+	&number_of_sets.attr,
+	&size.attr,
+	&shared_cpu_map.attr,
+	NULL
+};
+
+#define to_object(k) container_of(k, struct _index_kobject, kobj)
+#define to_attr(a) container_of(a, struct _cache_attr, attr)
+
+static ssize_t show(struct kobject * kobj, struct attribute * attr, char * buf)
+{
+	struct _cache_attr *fattr = to_attr(attr);
+	struct _index_kobject *this_leaf = to_object(kobj);
+	ssize_t ret;
+
+	ret = fattr->show ? 
+		fattr->show(CPUID4_INFO_IDX(this_leaf->cpu, this_leaf->index), 
+			buf) :
+	       	0;
+	return ret;
+}
+
+static ssize_t store(struct kobject * kobj, struct attribute * attr, 
+		     const char * buf, size_t count)
+{
+	return 0;
+}
+
+static struct sysfs_ops sysfs_ops = {
+	.show   = show,
+	.store  = store,
+};
+
+static struct kobj_type ktype_cache = {
+	.sysfs_ops	= &sysfs_ops,
+	.default_attrs	= default_attrs,
+};
+
+static struct kobj_type ktype_percpu_entry = {
+	.sysfs_ops	= &sysfs_ops,
+};
+
+#ifdef CONFIG_SMP
+static void cache_shared_cpu_map_setup(unsigned int cpu, int index)
+{
+	struct _cpuid4_info	*this_leaf;
+	unsigned long num_threads_sharing;
+
+	this_leaf = CPUID4_INFO_IDX(cpu, index);
+	num_threads_sharing = 1 + this_leaf->eax.split.num_threads_sharing;
+
+	if (num_threads_sharing == 1)
+		cpu_set(cpu, this_leaf->shared_cpu_map);
+	else if (num_threads_sharing == smp_num_siblings)
+		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
+	else
+		printk(KERN_INFO "Number of CPUs sharing cache didn't match "
+				"any known set of CPUs\n");
+}
+#else
+static void cache_shared_cpu_map_setup(unsigned int cpu, int index) {}
+#endif
+
+static int cpuid4_cache_sysfs_init(unsigned int cpu)
+{
+	struct _cpuid4_info	*this_leaf;
+	unsigned long 		i, j;
+	int 			retval;
+
+	if (num_cache_leaves == 0)
+		return -ENOENT;
+
+	/* Allocate all required memory */
+	cpuid4_info[cpu] = (struct _cpuid4_info *)kmalloc(
+	    sizeof(struct _cpuid4_info) * num_cache_leaves, GFP_KERNEL);
+	if (unlikely(cpuid4_info[cpu] == NULL))
+		goto err_out;
+	memset(cpuid4_info[cpu], 0, sizeof(struct _cpuid4_info) * num_cache_leaves);
+
+	cache_kobject[cpu] = (struct kobject *)kmalloc(
+			sizeof(struct kobject), GFP_KERNEL);
+	if (unlikely(cache_kobject[cpu] == NULL))
+		goto err_out;
+	memset(cache_kobject[cpu], 0, sizeof(struct kobject));
+
+	index_kobject[cpu] = (struct _index_kobject *)kmalloc(
+	    sizeof(struct _index_kobject ) * num_cache_leaves, GFP_KERNEL);
+	if (unlikely(index_kobject[cpu] == NULL))
+		goto err_out;
+	memset(index_kobject[cpu], 0, 
+	    sizeof(struct _index_kobject) * num_cache_leaves);
+
+	/* Do cpuid and store the results */
+	for (j = 0; j < num_cache_leaves; j++) {
+		this_leaf = CPUID4_INFO_IDX(cpu, j);
+		retval = cpuid4_cache_lookup(j, this_leaf);
+		if (unlikely(retval < 0))
+			goto err_out;
+		cache_shared_cpu_map_setup(cpu, j);
+	}
+	return 0;
+
+err_out:
+	for (i = 0; i < NR_CPUS; i++) {
+		if(cpuid4_info[i])
+			kfree(cpuid4_info[i]);
+		if(cache_kobject[i])
+			kfree(cache_kobject[i]);
+		if(index_kobject[i])
+			kfree(index_kobject[i]);
+
+		cpuid4_info[i] = NULL;
+		cache_kobject[i] = NULL;
+		index_kobject[i] = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static int cpuid4_cache_sysfs_exit(unsigned int i)
+{
+	if(cpuid4_info[i])
+		kfree(cpuid4_info[i]);
+	if(cache_kobject[i])
+		kfree(cache_kobject[i]);
+	if(index_kobject[i])
+		kfree(index_kobject[i]);
+
+	cpuid4_info[i] = NULL;
+	cache_kobject[i] = NULL;
+	index_kobject[i] = NULL;
+	return 0;
+}
+
+/* Add/Remove cache interface for CPU device */
+static int cache_add_dev(struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+	unsigned long i, j;
+	struct _index_kobject *this_object;
+	int retval = 0;
+
+	retval = cpuid4_cache_sysfs_init(cpu);
+	if (unlikely(retval < 0))
+		return retval;
+
+	cache_kobject[cpu]->parent = &sys_dev->kobj;
+	kobject_set_name(cache_kobject[cpu], "%s", "cache");
+	cache_kobject[cpu]->ktype = &ktype_percpu_entry;
+	retval = kobject_register(cache_kobject[cpu]);
+
+	for (i = 0; i < num_cache_leaves; i++) {
+		this_object = INDEX_KOBJECT_PTR(cpu,i);
+		this_object->cpu = cpu;
+		this_object->index = i;
+		this_object->kobj.parent = cache_kobject[cpu];
+		kobject_set_name(&(this_object->kobj), "index%1lu", i);
+		this_object->kobj.ktype = &ktype_cache;
+		retval = kobject_register(&(this_object->kobj));
+		if (unlikely(retval)) {
+			for (j = 0; j < i; j++) {
+				kobject_unregister(
+					&(INDEX_KOBJECT_PTR(cpu,j)->kobj));
+			}
+			kobject_unregister(cache_kobject[cpu]);
+			cpuid4_cache_sysfs_exit(cpu);
+			break;
+		}
+	}
+	return retval;
+}
+
+static int cache_remove_dev(struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+	unsigned long i;
+
+	for (i = 0; i < num_cache_leaves; i++)
+		kobject_unregister(&(INDEX_KOBJECT_PTR(cpu,i)->kobj));
+	kobject_unregister(cache_kobject[cpu]);
+	cpuid4_cache_sysfs_exit(cpu);
+	return 0;
+}
+
+static struct sysdev_driver cache_sysdev_driver = {
+	.add = cache_add_dev,
+	.remove = cache_remove_dev,
+};
+
+/* Register/Unregister the cpu_cache driver */
+static int cache_register_driver(void)
+{
+	if (num_cache_leaves == 0)
+		return 0;
+
+	return sysdev_driver_register(&cpu_sysdev_class,&cache_sysdev_driver);
+}
+
+device_initcall(cache_register_driver);
+
+#endif
+
