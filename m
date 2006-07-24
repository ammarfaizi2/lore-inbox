Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWGXRRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWGXRRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWGXRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:17:07 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:49946 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932229AbWGXRRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:17:02 -0400
Subject: [Patch 1/2] CPU hotplug compatible alloc_percpu
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 19:16:54 +0200
Message-Id: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits alloc_percpu() up into two phases. Likewise for
free_percpu(). This allows clients to limit initial allocations to
online cpu's, and to populate or depopulate per-cpu data at run time as
needed:

  struct my_struct *obj;

  /* initial allocation for online cpu's */
  obj = percpu_alloc(sizeof(struct my_struct), GFP_KERNEL);

  ...

  /* populate per-cpu data for cpu coming online */
  ptr = percpu_populate(obj, sizeof(struct my_struct), GFP_KERNEL, cpu);

  ...

  /* access per-cpu object */
  ptr = percpu_ptr(obj, smp_processor_id());

  ...

  /* depopulate per-cpu data for cpu going offline */
  percpu_depopulate(obj, cpu);

  ...

  /* final removal */
  percpu_free(obj);


Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/percpu.h |   74 ++++++++++++++++-----
 mm/slab.c              |  165 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 162 insertions(+), 77 deletions(-)

diff -ur a/include/linux/percpu.h b/include/linux/percpu.h
--- a/include/linux/percpu.h	2006-06-18 03:49:35.000000000 +0200
+++ b/include/linux/percpu.h	2006-07-24 15:13:36.000000000 +0200
@@ -1,9 +1,12 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
+
 #include <linux/spinlock.h> /* For preempt_disable() */
 #include <linux/slab.h> /* For kmalloc() */
 #include <linux/smp.h>
 #include <linux/string.h> /* For memset() */
+#include <linux/cpumask.h>
+
 #include <asm/percpu.h>
 
 /* Enough to cover all DEFINE_PER_CPUs in kernel, including modules. */
@@ -21,39 +24,70 @@
 	void *ptrs[NR_CPUS];
 };
 
+#define __percpu_disguise(pdata) (struct percpu_data *)~(unsigned long)(pdata)
 /* 
- * Use this to get to a cpu's version of the per-cpu object allocated using
- * alloc_percpu.  Non-atomic access to the current CPU's version should
+ * Use this to get to a cpu's version of the per-cpu object dynamically
+ * allocated. Non-atomic access to the current CPU's version should
  * probably be combined with get_cpu()/put_cpu().
  */ 
-#define per_cpu_ptr(ptr, cpu)                   \
-({                                              \
-        struct percpu_data *__p = (struct percpu_data *)~(unsigned long)(ptr); \
-        (__typeof__(ptr))__p->ptrs[(cpu)];	\
+#define percpu_ptr(ptr, cpu)                              \
+({                                                        \
+        struct percpu_data *__p = __percpu_disguise(ptr); \
+        (__typeof__(ptr))__p->ptrs[(cpu)];	          \
 })
 
-extern void *__alloc_percpu(size_t size);
-extern void free_percpu(const void *);
+extern void *percpu_populate(void *__pdata, size_t size, gfp_t gfp, int cpu);
+extern void percpu_depopulate(void *__pdata, int cpu);
+extern int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
+				cpumask_t mask);
+extern void percpu_depopulate_mask(void *__pdata, cpumask_t mask);
+extern void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t map);
+extern void percpu_free(void *__pdata);
 
 #else /* CONFIG_SMP */
 
-#define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
+#define percpu_ptr(ptr, cpu) ({ (void)(cpu); (ptr); })
+
+static inline void percpu_depopulate(void *__pdata, int cpu)
+{
+}
+
+static inline void percpu_depopulate_mask(void *__pdata, cpumask_t mask)
+{
+}
 
-static inline void *__alloc_percpu(size_t size)
+static inline void *percpu_populate(void *__pdata, size_t size, gfp_t gfp,
+				    int cpu)
 {
-	void *ret = kmalloc(size, GFP_KERNEL);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-static inline void free_percpu(const void *ptr)
-{	
-	kfree(ptr);
+	return percpu_ptr(__pdata, cpu);
+}
+
+static inline int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
+				       int cpu)
+{
+	return 0;
+}
+
+static inline void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t map)
+{
+	return kzalloc(size, gfp);
+}
+
+static inline void percpu_free(void *__pdata)
+{
+	kfree(__pdata);
 }
 
 #endif /* CONFIG_SMP */
 
-/* Simple wrapper for the common case: zeros memory. */
-#define alloc_percpu(type)	((type *)(__alloc_percpu(sizeof(type))))
+#define percpu_alloc(size, gfp) percpu_alloc_mask((size), (gfp), cpu_online_map)
+
+/* (legacy) interface for use without CPU hotplug handling */
+
+#define __alloc_percpu(size)	percpu_alloc_mask((size), GFP_KERNEL, \
+						  cpu_possible_map)
+#define alloc_percpu(type)	(type *)__alloc_percpu(sizeof(type))
+#define free_percpu(ptr)	percpu_free((ptr))
+#define per_cpu_ptr(ptr, cpu)	percpu_ptr((ptr), (cpu))
 
 #endif /* __LINUX_PERCPU_H */
diff -ur a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	2006-07-24 15:11:58.000000000 +0200
+++ b/mm/slab.c	2006-07-24 15:13:36.000000000 +0200
@@ -3374,52 +3374,126 @@
 
 #ifdef CONFIG_SMP
 /**
- * __alloc_percpu - allocate one copy of the object for every present
- * cpu in the system, zeroing them.
- * Objects should be dereferenced using the per_cpu_ptr macro only.
+ * percpu_depopulate - depopulate per-cpu data for given cpu
+ * @__pdata: per-cpu data to depopulate
+ * @cpu: depopulate per-cpu data for this cpu
  *
- * @size: how many bytes of memory are required.
+ * Depopulating per-cpu data for a cpu going offline would be a typical
+ * use case. You need to register a cpu hotplug handler for that purpose.
  */
-void *__alloc_percpu(size_t size)
+void percpu_depopulate(void *__pdata, int cpu)
 {
-	int i;
-	struct percpu_data *pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+	struct percpu_data *pdata = __percpu_disguise(__pdata);
+	if (pdata->ptrs[cpu]) {
+		kfree(pdata->ptrs[cpu]);
+		pdata->ptrs[cpu] = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(percpu_depopulate);
 
-	if (!pdata)
-		return NULL;
+/**
+ * percpu_depopulate_mask - depopulate per-cpu data for some cpu's
+ * @__pdata: per-cpu data to depopulate
+ * @mask: depopulate per-cpu data for cpu's selected through mask bits
+ */
+void percpu_depopulate_mask(void *__pdata, cpumask_t mask)
+{
+	int cpu;
+	for_each_cpu_mask(cpu, mask)
+		percpu_depopulate(__pdata, cpu);
+}
+EXPORT_SYMBOL_GPL(percpu_depopulate_mask);
 
-	/*
-	 * Cannot use for_each_online_cpu since a cpu may come online
-	 * and we have no way of figuring out how to fix the array
-	 * that we have allocated then....
-	 */
-	for_each_possible_cpu(i) {
-		int node = cpu_to_node(i);
+/**
+ * percpu_populate - populate per-cpu data for given cpu
+ * @__pdata: per-cpu data to populate further
+ * @size: size of per-cpu object
+ * @gfp: may sleep or not etc.
+ * @cpu: populate per-data for this cpu
+ *
+ * Populating per-cpu data for a cpu coming online would be a typical
+ * use case. You need to register a cpu hotplug handler for that purpose.
+ * Per-cpu object is populated with zeroed buffer.
+ */
+void *percpu_populate(void *__pdata, size_t size, gfp_t gfp, int cpu)
+{
+	struct percpu_data *pdata = __percpu_disguise(__pdata);
+	int node = cpu_to_node(cpu);
 
-		if (node_online(node))
-			pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL, node);
-		else
-			pdata->ptrs[i] = kmalloc(size, GFP_KERNEL);
+	BUG_ON(pdata->ptrs[cpu]);
+	if (node_online(node)) {
+		/* FIXME: kzalloc_node(size, gfp, node) */
+		pdata->ptrs[cpu] = kmalloc_node(size, gfp, node);
+		if (pdata->ptrs[cpu])
+			memset(pdata->ptrs[cpu], 0, size);
+	} else
+		pdata->ptrs[cpu] = kzalloc(size, gfp);
+	return pdata->ptrs[cpu];
+}
+EXPORT_SYMBOL_GPL(percpu_populate);
 
-		if (!pdata->ptrs[i])
-			goto unwind_oom;
-		memset(pdata->ptrs[i], 0, size);
-	}
+/**
+ * percpu_populate_mask - populate per-cpu data for more cpu's
+ * @__pdata: per-cpu data to populate further
+ * @size: size of per-cpu object
+ * @gfp: may sleep or not etc.
+ * @mask: populate per-cpu data for cpu's selected through mask bits
+ *
+ * Per-cpu objects are populated with zeroed buffers.
+ */
+int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp, cpumask_t mask)
+{
+	cpumask_t populated = CPU_MASK_NONE;
+	int cpu;
 
-	/* Catch derefs w/o wrappers */
-	return (void *)(~(unsigned long)pdata);
+	for_each_cpu_mask(cpu, mask)
+		if (unlikely(!percpu_populate(__pdata, size, gfp, cpu))) {
+			percpu_depopulate_mask(__pdata, populated);
+			return -ENOMEM;
+		} else
+			cpu_set(cpu, populated);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(percpu_populate_mask);
 
-unwind_oom:
-	while (--i >= 0) {
-		if (!cpu_possible(i))
-			continue;
-		kfree(pdata->ptrs[i]);
-	}
+/**
+ * percpu_alloc_mask - initial setup of per-cpu data
+ * @size: size of per-cpu object
+ * @gfp: may sleep or not etc.
+ * @mask: populate per-data for cpu's selected through mask bits
+ *
+ * Populating per-cpu data for all online cpu's would be a typical use case,
+ * which is simplified by the percpu_alloc() wrapper.
+ * Per-cpu objects are populated with zeroed buffers.
+ */
+void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t mask)
+{
+	void *pdata = kzalloc(sizeof(struct percpu_data), gfp);
+	void *__pdata = __percpu_disguise(pdata);
+
+	if (unlikely(!pdata))
+		return NULL;
+	if (likely(!percpu_populate_mask(__pdata, size, gfp, mask)))
+		return __pdata;
 	kfree(pdata);
 	return NULL;
 }
-EXPORT_SYMBOL(__alloc_percpu);
-#endif
+EXPORT_SYMBOL_GPL(percpu_alloc_mask);
+
+/**
+ * percpu_free - final cleanup of per-cpu data
+ * @__pdata: object to clean up
+ *
+ * We simply clean up any per-cpu object left. No need for the client to
+ * track and specify through a bis mask which per-cpu objects are to free.
+ */
+void percpu_free(void *__pdata)
+{
+	percpu_depopulate_mask(__pdata, cpu_possible_map);
+	kfree(__percpu_disguise(__pdata));
+}
+EXPORT_SYMBOL_GPL(percpu_free);
+#endif	/* CONFIG_SMP */
 
 /**
  * kmem_cache_free - Deallocate an object
@@ -3466,29 +3540,6 @@
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
-void free_percpu(const void *objp)
-{
-	int i;
-	struct percpu_data *p = (struct percpu_data *)(~(unsigned long)objp);
-
-	/*
-	 * We allocate for all cpus so we cannot use for online cpu here.
-	 */
-	for_each_possible_cpu(i)
-	    kfree(p->ptrs[i]);
-	kfree(p);
-}
-EXPORT_SYMBOL(free_percpu);
-#endif
-
 unsigned int kmem_cache_size(struct kmem_cache *cachep)
 {
 	return obj_size(cachep);


