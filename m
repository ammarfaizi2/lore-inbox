Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWHCS63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWHCS63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWHCS63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:58:29 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:50000 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964860AbWHCS61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:58:27 -0400
Subject: [Patch] percpu_alloc: pass cpumask by reference
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 20:58:20 +0200
Message-Id: <1154631500.2963.17.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the percpu_alloc() functions pass (possibly large)
cpumasks by reference, while it still looks like 'pass by value' for
users (in the style of include/linux/cpumask.h).

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/percpu.h |   23 +++++++++++++++--------
 mm/slab.c              |   23 ++++++++++++-----------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff -ur a/include/linux/percpu.h b/include/linux/percpu.h
--- a/include/linux/percpu.h	29 Jul 2006 13:13:09 -0000	1.11
+++ b/include/linux/percpu.h	29 Jul 2006 22:13:29 -0000	1.12
@@ -38,10 +38,10 @@
 
 extern void *percpu_populate(void *__pdata, size_t size, gfp_t gfp, int cpu);
 extern void percpu_depopulate(void *__pdata, int cpu);
-extern int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
-				cpumask_t mask);
-extern void percpu_depopulate_mask(void *__pdata, cpumask_t mask);
-extern void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t mask);
+extern int __percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
+				  cpumask_t *mask);
+extern void __percpu_depopulate_mask(void *__pdata, cpumask_t *mask);
+extern void *__percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t *mask);
 extern void percpu_free(void *__pdata);
 
 #else /* CONFIG_SMP */
@@ -52,7 +52,7 @@
 {
 }
 
-static inline void percpu_depopulate_mask(void *__pdata, cpumask_t mask)
+static inline void __percpu_depopulate_mask(void *__pdata, cpumask_t *mask)
 {
 }
 
@@ -62,13 +62,13 @@
 	return percpu_ptr(__pdata, cpu);
 }
 
-static inline int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
-				       cpumask_t mask)
+static inline int __percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
+					 cpumask_t *mask)
 {
 	return 0;
 }
 
-static inline void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t mask)
+static inline void *__percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t *mask)
 {
 	return kzalloc(size, gfp);
 }
@@ -80,6 +80,13 @@
 
 #endif /* CONFIG_SMP */
 
+#define percpu_populate_mask(__pdata, size, gfp, mask) \
+	__percpu_populate_mask((__pdata), (size), (gfp), &(mask))
+#define percpu_depopulate_mask(__pdata, mask) \
+	__percpu_depopulate_mask((__pdata), &(mask))
+#define percpu_alloc_mask(size, gfp, mask) \
+	__percpu_alloc_mask((size), (gfp), &(mask))
+
 #define percpu_alloc(size, gfp) percpu_alloc_mask((size), (gfp), cpu_online_map)
 
 /* (legacy) interface for use without CPU hotplug handling */
diff -ur a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	29 Jul 2006 11:38:25 -0000	1.59
+++ b/mm/slab.c	29 Jul 2006 22:13:29 -0000	1.60
@@ -3396,13 +3396,13 @@
  * @__pdata: per-cpu data to depopulate
  * @mask: depopulate per-cpu data for cpu's selected through mask bits
  */
-void percpu_depopulate_mask(void *__pdata, cpumask_t mask)
+void __percpu_depopulate_mask(void *__pdata, cpumask_t *mask)
 {
 	int cpu;
-	for_each_cpu_mask(cpu, mask)
+	for_each_cpu_mask(cpu, *mask)
 		percpu_depopulate(__pdata, cpu);
 }
-EXPORT_SYMBOL_GPL(percpu_depopulate_mask);
+EXPORT_SYMBOL_GPL(__percpu_depopulate_mask);
 
 /**
  * percpu_populate - populate per-cpu data for given cpu
@@ -3441,20 +3441,21 @@
  *
  * Per-cpu objects are populated with zeroed buffers.
  */
-int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp, cpumask_t mask)
+int __percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
+			   cpumask_t *mask)
 {
 	cpumask_t populated = CPU_MASK_NONE;
 	int cpu;
 
-	for_each_cpu_mask(cpu, mask)
+	for_each_cpu_mask(cpu, *mask)
 		if (unlikely(!percpu_populate(__pdata, size, gfp, cpu))) {
-			percpu_depopulate_mask(__pdata, populated);
+			__percpu_depopulate_mask(__pdata, &populated);
 			return -ENOMEM;
 		} else
 			cpu_set(cpu, populated);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(percpu_populate_mask);
+EXPORT_SYMBOL_GPL(__percpu_populate_mask);
 
 /**
  * percpu_alloc_mask - initial setup of per-cpu data
@@ -3466,19 +3467,19 @@
  * which is simplified by the percpu_alloc() wrapper.
  * Per-cpu objects are populated with zeroed buffers.
  */
-void *percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t mask)
+void *__percpu_alloc_mask(size_t size, gfp_t gfp, cpumask_t *mask)
 {
 	void *pdata = kzalloc(sizeof(struct percpu_data), gfp);
 	void *__pdata = __percpu_disguise(pdata);
 
 	if (unlikely(!pdata))
 		return NULL;
-	if (likely(!percpu_populate_mask(__pdata, size, gfp, mask)))
+	if (likely(!__percpu_populate_mask(__pdata, size, gfp, mask)))
 		return __pdata;
 	kfree(pdata);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(percpu_alloc_mask);
+EXPORT_SYMBOL_GPL(__percpu_alloc_mask);
 
 /**
  * percpu_free - final cleanup of per-cpu data
@@ -3489,7 +3490,7 @@
  */
 void percpu_free(void *__pdata)
 {
-	percpu_depopulate_mask(__pdata, cpu_possible_map);
+	__percpu_depopulate_mask(__pdata, &cpu_possible_map);
 	kfree(__percpu_disguise(__pdata));
 }
 EXPORT_SYMBOL_GPL(percpu_free);


