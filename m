Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWE3THe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWE3THe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWE3THd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:07:33 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:52393 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932395AbWE3THd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:07:33 -0400
Subject: [Patch] statistics infrastructure - update 2
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 21:07:15 +0200
Message-Id: <1149016035.2937.9.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply this update, which in the main addresses
the issues pointed out by Heiko today.

changelog:
- GFP_KERNEL is fine during cpu bringup
- merge function might get called for NULL pointer and should do
  nothing then
- cleanup return values of cpu hotplug functions
- cleanup freeing of data area and achieve symmetry of alloc and free

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |    5 --
 lib/statistic.c           |  111 +++++++++++++++++++++++++---------------------
 2 files changed, 63 insertions(+), 53 deletions(-)

--- a/include/linux/statistic.h	26 May 2006 16:00:44 -0000	1.23
+++ b/include/linux/statistic.h	30 May 2006 18:45:58 -0000
@@ -133,7 +133,7 @@
  * struct statistic_discipline - description of a data processing mode
  * @parse: parses additional attributes specific to this mode (if any)
  * @alloc: allocates a data area (mandatory, default routine available)
- * @free: frees a data area (optional, kfree() is used otherwise)
+ * @free: frees a data area (mandatory, default routine available)
  * @reset: discards content of a data area (mandatory)
  * @merge: merges content of a data area into another data area (mandatory)
  * @fdata: prints content of a data area into buffer (mandatory)
@@ -158,8 +158,7 @@
 struct statistic_discipline {
 	int (*parse)(struct statistic * stat, struct statistic_info *info,
 		     int type, char *def);
-	void* (*alloc)(struct statistic *stat, size_t size, gfp_t flags,
-		       int node);
+	void *(*alloc)(struct statistic *stat, size_t size, int node);
 	void (*free)(struct statistic *stat, void *ptr);
 	void (*reset)(struct statistic *stat, void *ptr);
 	void (*merge)(struct statistic *stat, void *dst, void *src);
--- a/lib/statistic.c	29 May 2006 18:00:52 -0000	1.44
+++ b/lib/statistic.c	30 May 2006 18:45:58 -0000
@@ -85,6 +85,17 @@
 	return 0;
 }
 
+static void *statistic_alloc_generic(struct statistic *stat, size_t size,
+				     int node)
+{
+	return kmalloc_node(size, GFP_KERNEL, node);
+}
+
+static void statistic_free_generic(struct statistic *stat, void *ptr)
+{
+	kfree(ptr);
+}
+
 static void statistic_reset_ptr(struct statistic *stat, void *ptr)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
@@ -92,22 +103,30 @@
 		disc->reset(stat, ptr);
 }
 
-static void statistic_move_ptr(struct statistic *stat, void *src)
+static void statistic_free_ptr(struct statistic *stat, void *ptr)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	unsigned long flags;
-	local_irq_save(flags);
-	disc->merge(stat, stat->pdata->ptrs[smp_processor_id()], src);
-	local_irq_restore(flags);
+	if (ptr)
+		disc->free(stat, ptr);
 }
 
-static void statistic_free_ptr(struct statistic *stat, void *ptr)
+static void *statistic_alloc_ptr(struct statistic *stat, int node)
+{
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	void *ptr = disc->alloc(stat, disc->size, node);
+	if (likely(ptr))
+		statistic_reset_ptr(stat, ptr);
+	return ptr;
+}
+
+static void statistic_move_ptr(struct statistic *stat, void *src)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	if (ptr) {
-		if (unlikely(disc->free))
-			disc->free(stat, ptr);
-		kfree(ptr);
+	unsigned long flags;
+	if (src) {
+		local_irq_save(flags);
+		disc->merge(stat, stat->pdata->ptrs[smp_processor_id()], src);
+		local_irq_restore(flags);
 	}
 }
 
@@ -129,28 +148,13 @@
 	return 0;
 }
 
-static void *statistic_alloc_generic(struct statistic *stat, size_t size,
-				     gfp_t flags, int node)
-{
-	return kmalloc_node(size, flags, node);
-}
-
-static void *statistic_alloc_ptr(struct statistic *stat, gfp_t flags, int node)
-{
-	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	void *buf = disc->alloc(stat, disc->size, flags, node);
-	if (likely(buf))
-		statistic_reset_ptr(stat, buf);
-	return buf;
-}
-
 static int statistic_alloc(struct statistic *stat,
 			   struct statistic_info *info)
 {
-	int cpu;
+	int cpu, node;
 	stat->age = sched_clock();
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
-		stat->pdata = statistic_alloc_ptr(stat, GFP_KERNEL, -1);
+		stat->pdata = statistic_alloc_ptr(stat, -1);
 		if (unlikely(!stat->pdata))
 			return -ENOMEM;
 		stat->state = STATISTIC_STATE_OFF;
@@ -160,8 +164,8 @@
 	if (unlikely(!stat->pdata))
 		return -ENOMEM;
 	for_each_online_cpu(cpu) {
-		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_KERNEL,
-							     cpu_to_node(cpu));
+		node = cpu_to_node(cpu);
+		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, node);
 		if (unlikely(!stat->pdata->ptrs[cpu])) {
 			statistic_free(stat, info);
 			return -ENOMEM;
@@ -373,7 +377,7 @@
 		return 0;
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
 		return disc->fdata(stat, info->name, fpriv, stat->pdata);
-	mpriv.dst = statistic_alloc_ptr(stat, GFP_KERNEL, -1);
+	mpriv.dst = statistic_alloc_ptr(stat, -1);
 	if (unlikely(!mpriv.dst))
 		return -ENOMEM;
 	spin_lock_init(&mpriv.lock);
@@ -391,17 +395,17 @@
 {
 	struct statistic *stat = &interface->stat[i];
 	struct statistic_info *info = &interface->info[i];
+	int node = cpu_to_node(cpu);
 
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
-		return 0;
+		return NOTIFY_OK;
 	if (stat->state < STATISTIC_STATE_OFF)
-		return 0;
+		return NOTIFY_OK;
 	switch (action) {
 	case CPU_UP_PREPARE:
-		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_ATOMIC,
-							     cpu_to_node(cpu));
+		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, node);
 		if (!stat->pdata->ptrs[cpu])
-			return -ENOMEM;
+			return NOTIFY_BAD;
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_DEAD:
@@ -410,7 +414,7 @@
 		stat->pdata->ptrs[cpu] = NULL;
 		break;
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct list_head statistic_list;
@@ -419,19 +423,19 @@
 static int __cpuinit statistic_hotcpu(struct notifier_block *notifier,
 				      unsigned long action, void *__cpu)
 {
-	int cpu = (unsigned long)__cpu, i, retval = 0;
+	int cpu = (unsigned long)__cpu, i, retval = NOTIFY_OK;
 	struct statistic_interface *interface;
 
 	mutex_lock(&statistic_list_mutex);
 	list_for_each_entry(interface, &statistic_list, list)
 		for (i = 0; i < interface->number; i++) {
 			retval = _statistic_hotcpu(interface, i, action, cpu);
-			if (retval)
+			if (retval == NOTIFY_BAD)
 				goto unlock;
 		}
 unlock:
 	mutex_unlock(&statistic_list_mutex);
-	return (retval ? NOTIFY_BAD : NOTIFY_OK);
+	return retval;
 }
 
 static struct notifier_block statistic_hotcpu_notifier =
@@ -1032,10 +1036,10 @@
 /* code concerned with histogram statistics */
 
 static void *statistic_alloc_histogram(struct statistic *stat, size_t size,
-				       gfp_t flags, int node)
+				       int node)
 {
 	return kmalloc_node(size * (stat->u.histogram.last_index + 1),
-			    flags, node);
+			    GFP_KERNEL, node);
 }
 
 static inline s64 statistic_histogram_calc_value_lin(struct statistic *stat,
@@ -1211,15 +1215,16 @@
 /* code concerned with histograms (discrete value) statistics */
 
 static void *statistic_alloc_sparse(struct statistic *stat, size_t size,
-				    gfp_t flags, int node)
+				    int node)
 {
-	struct statistic_sparse_list *slist = kmalloc_node(size, flags, node);
+	struct statistic_sparse_list *slist;
+	slist = kmalloc_node(size, GFP_KERNEL, node);
 	INIT_LIST_HEAD(&slist->entry_lh);
 	slist->entries_max = stat->u.sparse.entries_max;
 	return slist;
 }
 
-static void statistic_free_sparse(struct statistic *stat, void *ptr)
+static void statistic_reset_sparse(struct statistic *stat, void *ptr)
 {
 	struct statistic_entry_sparse *entry, *tmp;
 	struct statistic_sparse_list *slist = ptr;
@@ -1231,6 +1236,12 @@
 	slist->entries = 0;
 }
 
+static void statistic_free_sparse(struct statistic *stat, void *ptr)
+{
+	statistic_reset_sparse(stat, ptr);
+	kfree(ptr);
+}
+
 static void statistic_add_sparse_sort(struct list_head *head,
 				      struct statistic_entry_sparse *entry)
 {
@@ -1375,7 +1386,7 @@
 	{ /* STATISTIC_TYPE_COUNTER_INC */
 	  NULL,
 	  statistic_alloc_generic,
-	  NULL,
+	  statistic_free_generic,
 	  statistic_reset_counter,
 	  statistic_merge_counter,
 	  statistic_fdata_counter,
@@ -1387,7 +1398,7 @@
 	{ /* STATISTIC_TYPE_COUNTER_PROD */
 	  NULL,
 	  statistic_alloc_generic,
-	  NULL,
+	  statistic_free_generic,
 	  statistic_reset_counter,
 	  statistic_merge_counter,
 	  statistic_fdata_counter,
@@ -1399,7 +1410,7 @@
 	{ /* STATISTIC_TYPE_UTIL */
 	  NULL,
 	  statistic_alloc_generic,
-	  NULL,
+	  statistic_free_generic,
 	  statistic_reset_util,
 	  statistic_merge_util,
 	  statistic_fdata_util,
@@ -1411,7 +1422,7 @@
 	{ /* STATISTIC_TYPE_HISTOGRAM_LIN */
 	  statistic_parse_histogram,
 	  statistic_alloc_histogram,
-	  NULL,
+	  statistic_free_generic,
 	  statistic_reset_histogram,
 	  statistic_merge_histogram,
 	  statistic_fdata_histogram,
@@ -1423,7 +1434,7 @@
 	{ /* STATISTIC_TYPE_HISTOGRAM_LOG2 */
 	  statistic_parse_histogram,
 	  statistic_alloc_histogram,
-	  NULL,
+	  statistic_free_generic,
 	  statistic_reset_histogram,
 	  statistic_merge_histogram,
 	  statistic_fdata_histogram,
@@ -1436,7 +1447,7 @@
 	  statistic_parse_sparse,
 	  statistic_alloc_sparse,
 	  statistic_free_sparse,
-	  statistic_free_sparse,	/* reset equals free */
+	  statistic_reset_sparse,
 	  statistic_merge_sparse,
 	  statistic_fdata_sparse,
 	  statistic_fdef_sparse,


