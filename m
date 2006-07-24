Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWGXRRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGXRRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWGXRRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:17:10 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:52444 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932226AbWGXRRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:17:07 -0400
Subject: [Patch 2/2] CPU hotplug compatible alloc_percpu
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 19:16:59 +0200
Message-Id: <1153761420.2986.137.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the statistics infrastructure use the enhanced
percpu_*() interface. It makes the statistic code compile for
!CONFIG_SMP.

Signed-off-by: Martin Peschke <mp3@de.ibm.com> 
---

 include/linux/statistic.h |    2
 lib/statistic.c           |  242 ++++++++++++++++++----------------------------
 2 files changed, 96 insertions(+), 148 deletions(-)

diff -ur a/include/linux/statistic.h b/include/linux/statistic.h
--- a/include/linux/statistic.h	2006-07-24 15:11:58.000000000 +0200
+++ b/include/linux/statistic.h	2006-07-24 15:13:40.000000000 +0200
@@ -83,7 +83,7 @@
 /* private: */
 	enum statistic_state	 state;
 	enum statistic_type	 type;
-	struct percpu_data	*pdata;
+	void			*data;
 	void			(*add)(struct statistic *, s64, u64);
 	u64			 started;
 	u64			 stopped;
diff -ur a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-07-24 15:11:58.000000000 +0200
+++ b/lib/statistic.c	2006-07-24 15:13:40.000000000 +0200
@@ -77,8 +77,7 @@
 /**
  * struct statistic_discipline - description of a data processing mode
  * @parse: parses additional attributes specific to this mode (if any)
- * @alloc: allocates a data area (mandatory, default routine available)
- * @free: frees a data area (mandatory, default routine available)
+ * @size: sizes a data area prior to allocation (mandatory)
  * @reset: discards content of a data area (mandatory)
  * @merge: merges content of a data area into another data area (mandatory)
  * @fdata: prints content of a data area into buffer (mandatory)
@@ -86,7 +85,6 @@
  * @add: updates a data area for a statistic fed incremental data (mandatory)
  * @set: updates a data area for a statistic fed total numbers (mandatory)
  * @name: pointer to name string (mandatory)
- * @size: base size for a data area (passed to alloc function)
  *
  * Struct statistic_discipline describes a statistic infrastructure internal
  * programming interface. Another data processing mode can be added by
@@ -103,8 +101,7 @@
 struct statistic_discipline {
 	int (*parse)(struct statistic * stat, struct statistic_info *info,
 		     int type, char *def);
-	void *(*alloc)(struct statistic *stat, size_t size, int node);
-	void (*free)(struct statistic *stat, void *ptr);
+	size_t (*size)(struct statistic * stat);
 	void (*reset)(struct statistic *stat, void *ptr);
 	void (*merge)(struct statistic *stat, void *dst, void *src);
 	int (*fdata)(struct statistic *stat, const char *name,
@@ -113,7 +110,6 @@
 	void (*add)(struct statistic *stat, s64 value, u64 incr);
 	void (*set)(struct statistic *stat, s64 value, u64 total);
 	char *name;
-	size_t size;
 };
 
 static struct statistic_discipline statistic_discs[];
@@ -139,93 +135,43 @@
 	return 0;
 }
 
-static void *statistic_alloc_generic(struct statistic *stat, size_t size,
-				     int node)
-{
-	return kmalloc_node(size, GFP_KERNEL, node);
-}
-
-static void statistic_free_generic(struct statistic *stat, void *ptr)
-{
-	kfree(ptr);
-}
-
-static void statistic_reset_ptr(struct statistic *stat, void *ptr)
-{
-	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	if (ptr)
-		disc->reset(stat, ptr);
-}
-
-static void statistic_free_ptr(struct statistic *stat, void *ptr)
-{
-	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	if (ptr)
-		disc->free(stat, ptr);
-}
-
-static void *statistic_alloc_ptr(struct statistic *stat, int node)
-{
-	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	void *ptr = disc->alloc(stat, disc->size, node);
-	if (likely(ptr))
-		statistic_reset_ptr(stat, ptr);
-	return ptr;
-}
-
-static void statistic_move_ptr(struct statistic *stat, void *src)
-{
-	struct statistic_discipline *disc = &statistic_discs[stat->type];
-	unsigned long flags;
-	if (src) {
-		local_irq_save(flags);
-		disc->merge(stat, stat->pdata->ptrs[smp_processor_id()], src);
-		local_irq_restore(flags);
-	}
-}
-
 static int statistic_free(struct statistic *stat, struct statistic_info *info)
 {
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	int cpu;
-	stat->state = STATISTIC_STATE_RELEASED;
+
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
-		statistic_free_ptr(stat, stat->pdata);
-		stat->pdata = NULL;
-		return 0;
-	}
-	for_each_possible_cpu(cpu) {
-		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
-		stat->pdata->ptrs[cpu] = NULL;
+		disc->reset(stat, stat->data);
+		kfree(stat->data);
+	} else {
+		for_each_online_cpu(cpu)
+			disc->reset(stat, percpu_ptr(stat->data, cpu));
+		percpu_free(stat->data);
 	}
-	kfree(stat->pdata);
-	stat->pdata = NULL;
+	stat->state = STATISTIC_STATE_RELEASED;
 	return 0;
 }
 
 static int statistic_alloc(struct statistic *stat,
 			   struct statistic_info *info)
 {
-	int cpu, node;
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	size_t size = disc->size(stat);
+	int cpu;
 
-	stat->age = timestamp_clock();
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
-		stat->pdata = statistic_alloc_ptr(stat, -1);
-		if (unlikely(!stat->pdata))
+		stat->data = kzalloc(size, GFP_KERNEL);
+		if (unlikely(!stat->data))
 			return -ENOMEM;
-		stat->state = STATISTIC_STATE_OFF;
-		return 0;
-	}
-	stat->pdata = kzalloc(sizeof(struct percpu_data), GFP_KERNEL);
-	if (unlikely(!stat->pdata))
-		return -ENOMEM;
-	for_each_online_cpu(cpu) {
-		node = cpu_to_node(cpu);
-		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, node);
-		if (unlikely(!stat->pdata->ptrs[cpu])) {
-			statistic_free(stat, info);
+		disc->reset(stat, stat->data);
+	} else {
+		stat->data = percpu_alloc(size, GFP_KERNEL);
+		if (unlikely(!stat->data))
 			return -ENOMEM;
-		}
+		for_each_online_cpu(cpu)
+			disc->reset(stat, percpu_ptr(stat->data, cpu));
 	}
+	stat->age = timestamp_clock();
 	stat->state = STATISTIC_STATE_OFF;
 	return 0;
 }
@@ -285,6 +231,7 @@
 
 static int statistic_reset(struct statistic *stat, struct statistic_info *info)
 {
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	enum statistic_state prev_state = stat->state;
 	int cpu;
 
@@ -292,10 +239,10 @@
 		return 0;
 	statistic_transition(stat, info, STATISTIC_STATE_OFF);
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
-		statistic_reset_ptr(stat, stat->pdata);
+		disc->reset(stat, stat->data);
 	else
-		for_each_possible_cpu(cpu)
-			statistic_reset_ptr(stat, stat->pdata->ptrs[cpu]);
+		for_each_online_cpu(cpu)
+			disc->reset(stat, percpu_ptr(stat->data, cpu));
 	stat->age = timestamp_clock();
 	statistic_transition(stat, info, prev_state);
 	return 0;
@@ -306,8 +253,10 @@
 	struct statistic_merge_private *mpriv = __mpriv;
 	struct statistic *stat = mpriv->stat;
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	void *src = percpu_ptr(stat->data, smp_processor_id());
+
 	spin_lock(&mpriv->lock);
-	disc->merge(stat, mpriv->dst, stat->pdata->ptrs[smp_processor_id()]);
+	disc->merge(stat, mpriv->dst, src);
 	spin_unlock(&mpriv->lock);
 }
 
@@ -409,20 +358,22 @@
 	struct statistic_info *info = &interface->info[i];
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	struct statistic_merge_private mpriv;
+	size_t size = disc->size(stat);
 	int retval;
 
 	if (unlikely(stat->state < STATISTIC_STATE_OFF))
 		return 0;
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
-		return disc->fdata(stat, info->name, fpriv, stat->pdata);
-	mpriv.dst = statistic_alloc_ptr(stat, -1);
+		return disc->fdata(stat, info->name, fpriv, stat->data);
+	mpriv.dst = kzalloc(size, GFP_KERNEL);
 	if (unlikely(!mpriv.dst))
 		return -ENOMEM;
+	disc->reset(stat, mpriv.dst);
 	spin_lock_init(&mpriv.lock);
 	mpriv.stat = stat;
 	on_each_cpu(statistic_merge, &mpriv, 0, 1);
 	retval = disc->fdata(stat, info->name, fpriv, mpriv.dst);
-	statistic_free_ptr(stat, mpriv.dst);
+	kfree(mpriv.dst);
 	return retval;
 }
 
@@ -433,7 +384,10 @@
 {
 	struct statistic *stat = &interface->stat[i];
 	struct statistic_info *info = &interface->info[i];
-	int node = cpu_to_node(cpu);
+	struct statistic_discipline *disc = &statistic_discs[stat->type];
+	void *src, *dst;
+	size_t size;
+	unsigned long flags;
 
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
 		return NOTIFY_OK;
@@ -441,15 +395,20 @@
 		return NOTIFY_OK;
 	switch (action) {
 	case CPU_UP_PREPARE:
-		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, node);
-		if (!stat->pdata->ptrs[cpu])
+		size = disc->size(stat);
+		dst = percpu_populate(stat->data, size, GFP_KERNEL, cpu);
+		if (!dst)
 			return NOTIFY_BAD;
+		disc->reset(stat, dst);
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_DEAD:
-		statistic_move_ptr(stat, stat->pdata->ptrs[cpu]);
-		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
-		stat->pdata->ptrs[cpu] = NULL;
+		local_irq_save(flags);
+		dst = percpu_ptr(stat->data, smp_processor_id());
+		src = percpu_ptr(stat->data, cpu);
+		disc->merge(stat, dst, src);
+		local_irq_restore(flags);
+		percpu_depopulate(stat->data, cpu);
 		break;
 	}
 	return NOTIFY_OK;
@@ -845,6 +804,11 @@
 
 /* code concerned with single value statistics */
 
+size_t statistic_size_counter(struct statistic *stat)
+{
+	return sizeof(u64);
+}
+
 static void statistic_reset_counter(struct statistic *stat, void *ptr)
 {
 	*(u64*)ptr = 0;
@@ -852,7 +816,7 @@
 
 void statistic_add_counter_inc(struct statistic *stat, s64 value, u64 incr)
 {
-	*(u64*)stat->pdata->ptrs[smp_processor_id()] += incr;
+	*(u64*)percpu_ptr(stat->data, smp_processor_id()) += incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_counter_inc);
 
@@ -860,14 +824,14 @@
 {
 	if (unlikely(value < 0))
 		value = -value;
-	*(u64*)stat->pdata->ptrs[smp_processor_id()] += value * incr;
+	*(u64*)percpu_ptr(stat->data, smp_processor_id()) += value * incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_counter_prod);
 
 static void statistic_set_counter_inc(struct statistic *stat,
 				      s64 value, u64 total)
 {
-	*(u64*)stat->pdata = total;
+	*(u64*)stat->data = total;
 }
 
 static void statistic_set_counter_prod(struct statistic *stat,
@@ -875,7 +839,7 @@
 {
 	if (unlikely(value < 0))
 		value = -value;
-	*(u64*)stat->pdata = value * total;
+	*(u64*)stat->data = value * total;
 }
 
 static void statistic_merge_counter(struct statistic *stat,
@@ -908,6 +872,11 @@
 	s64 max;
 };
 
+size_t statistic_size_util(struct statistic *stat)
+{
+	return sizeof(struct statistic_entry_util);
+}
+
 static void statistic_reset_util(struct statistic *stat, void *ptr)
 {
 	struct statistic_entry_util *util = ptr;
@@ -920,8 +889,8 @@
 
 void statistic_add_util(struct statistic *stat, s64 value, u64 incr)
 {
-	int cpu = smp_processor_id();
-	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
+	struct statistic_entry_util *util;
+	util = percpu_ptr(stat->data, smp_processor_id());
 	util->num += incr;
 	util->acc += value * incr;
 	util->sqr += value * value * incr;
@@ -934,8 +903,7 @@
 
 static void statistic_set_util(struct statistic *stat, s64 value, u64 total)
 {
-	struct statistic_entry_util *util;
-	util = (struct statistic_entry_util *) stat->pdata;
+	struct statistic_entry_util *util = stat->data;
 	util->num = total;
 	util->acc = value * total;
 	util->sqr = value * value * total;
@@ -997,11 +965,9 @@
 
 /* code concerned with histogram statistics */
 
-static void *statistic_alloc_histogram(struct statistic *stat, size_t size,
-				       int node)
+size_t statistic_size_histogram(struct statistic *stat)
 {
-	return kmalloc_node(size * (stat->u.histogram.last_index + 1),
-			    GFP_KERNEL, node);
+	return sizeof(u64) * (stat->u.histogram.last_index + 1);
 }
 
 static inline s64 statistic_histogram_calc_value_lin(struct statistic *stat,
@@ -1052,14 +1018,14 @@
 void statistic_add_histogram_lin(struct statistic *stat, s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_lin(stat, value);
-	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
+	((u64*)percpu_ptr(stat->data, smp_processor_id()))[i] += incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_histogram_lin);
 
 void statistic_add_histogram_log2(struct statistic *stat, s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_log2(stat, value);
-	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
+	((u64*)percpu_ptr(stat->data, smp_processor_id()))[i] += incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_histogram_log2);
 
@@ -1067,14 +1033,14 @@
 					s64 value, u64 total)
 {
 	int i = statistic_histogram_calc_index_lin(stat, value);
-	((u64*)stat->pdata)[i] = total;
+	((u64*)stat->data)[i] = total;
 }
 
 static void statistic_set_histogram_log2(struct statistic *stat,
 					 s64 value, u64 total)
 {
 	int i = statistic_histogram_calc_index_log2(stat, value);
-	((u64*)stat->pdata)[i] = total;
+	((u64*)stat->data)[i] = total;
 }
 
 static void statistic_merge_histogram(struct statistic *stat,
@@ -1189,40 +1155,35 @@
 	u64 hits_missed;
 };
 
-static void *statistic_alloc_sparse(struct statistic *stat, size_t size,
-				    int node)
+size_t statistic_size_sparse(struct statistic *stat)
 {
-	struct statistic_sparse_list *slist;
-	slist = kmalloc_node(size, GFP_KERNEL, node);
-	INIT_LIST_HEAD(&slist->entry_lh);
-	slist->entries_max = stat->u.sparse.entries_max;
-	return slist;
+	return sizeof(struct statistic_sparse_list);
 }
 
 static void statistic_reset_sparse(struct statistic *stat, void *ptr)
 {
 	struct statistic_entry_sparse *entry, *tmp;
 	struct statistic_sparse_list *slist = ptr;
-	list_for_each_entry_safe(entry, tmp, &slist->entry_lh, list) {
-		list_del(&entry->list);
-		kfree(entry);
+
+	if (!slist->entries) {
+		INIT_LIST_HEAD(&slist->entry_lh);
+		slist->entries_max = stat->u.sparse.entries_max;
+	} else {
+		list_for_each_entry_safe(entry, tmp, &slist->entry_lh, list) {
+			list_del(&entry->list);
+			kfree(entry);
+		}
+		slist->entries = 0;
 	}
 	slist->hits_missed = 0;
-	slist->entries = 0;
-}
-
-static void statistic_free_sparse(struct statistic *stat, void *ptr)
-{
-	statistic_reset_sparse(stat, ptr);
-	kfree(ptr);
 }
 
 static void statistic_add_sparse_sort(struct list_head *head,
 				      struct statistic_entry_sparse *entry)
 {
-	struct statistic_entry_sparse *sort =
-		list_prepare_entry(entry, head, list);
+	struct statistic_entry_sparse *sort;
 
+	sort = list_prepare_entry(entry, head, list);
 	list_for_each_entry_continue_reverse(sort, head, list)
 		if (likely(sort->hits >= entry->hits))
 			break;
@@ -1267,16 +1228,15 @@
 
 void statistic_add_sparse(struct statistic *stat, s64 value, u64 incr)
 {
-	int cpu = smp_processor_id();
-	struct statistic_sparse_list *slist = stat->pdata->ptrs[cpu];
+	struct statistic_sparse_list *slist;
+	slist = percpu_ptr(stat->data, smp_processor_id());
 	_statistic_add_sparse(slist, value, incr);
 }
 EXPORT_SYMBOL_GPL(statistic_add_sparse);
 
 static void statistic_set_sparse(struct statistic *stat, s64 value, u64 total)
 {
-	struct statistic_sparse_list *slist = (struct statistic_sparse_list *)
-						stat->pdata;
+	struct statistic_sparse_list *slist = stat->data;
 	struct list_head *head = &slist->entry_lh;
 	struct statistic_entry_sparse *entry;
 
@@ -1360,42 +1320,35 @@
 
 static struct statistic_discipline statistic_discs[] = {
 	[STAT_CNTR_INC] = {
-		.alloc	= statistic_alloc_generic,
-		.free	= statistic_free_generic,
+		.size	= statistic_size_counter,
 		.reset	= statistic_reset_counter,
 		.merge	= statistic_merge_counter,
 		.fdata	= statistic_fdata_counter,
 		.add	= statistic_add_counter_inc,
 		.set	= statistic_set_counter_inc,
 		.name	= "counter_inc",
-		.size	= sizeof(u64)
 	},
 	[STAT_CNTR_PROD] = {
-		.alloc	= statistic_alloc_generic,
-		.free	= statistic_free_generic,
+		.size	= statistic_size_counter,
 		.reset	= statistic_reset_counter,
 		.merge	= statistic_merge_counter,
 		.fdata	= statistic_fdata_counter,
 		.add	= statistic_add_counter_prod,
 		.set	= statistic_set_counter_prod,
 		.name	= "counter_prod",
-		.size	= sizeof(u64)
 	},
 	[STAT_UTIL] = {
-		.alloc	= statistic_alloc_generic,
-		.free	= statistic_free_generic,
+		.size	= statistic_size_util,
 		.reset	= statistic_reset_util,
 		.merge	= statistic_merge_util,
 		.fdata	= statistic_fdata_util,
 		.add	= statistic_add_util,
 		.set	= statistic_set_util,
 		.name	= "utilisation",
-		.size	= sizeof(struct statistic_entry_util)
 	},
 	[STAT_HGRAM_LIN] = {
 		.parse	= statistic_parse_histogram,
-		.alloc	= statistic_alloc_histogram,
-		.free	= statistic_free_generic,
+		.size	= statistic_size_histogram,
 		.reset	= statistic_reset_histogram,
 		.merge	= statistic_merge_histogram,
 		.fdata	= statistic_fdata_histogram,
@@ -1403,12 +1356,10 @@
 		.add	= statistic_add_histogram_lin,
 		.set	= statistic_set_histogram_lin,
 		.name	= "histogram_lin",
-		.size	= sizeof(u64)
 	},
 	[STAT_HGRAM_LOG2] = {
 		.parse	= statistic_parse_histogram,
-		.alloc	= statistic_alloc_histogram,
-		.free	= statistic_free_generic,
+		.size	= statistic_size_histogram,
 		.reset	= statistic_reset_histogram,
 		.merge	= statistic_merge_histogram,
 		.fdata	= statistic_fdata_histogram,
@@ -1416,12 +1367,10 @@
 		.add	= statistic_add_histogram_log2,
 		.set	= statistic_set_histogram_log2,
 		.name	= "histogram_log2",
-		.size	= sizeof(u64)
 	},
 	[STAT_SPARSE] = {
 		.parse	= statistic_parse_sparse,
-		.alloc	= statistic_alloc_sparse,
-		.free	= statistic_free_sparse,
+		.size	= statistic_size_sparse,
 		.reset	= statistic_reset_sparse,
 		.merge	= statistic_merge_sparse,
 		.fdata	= statistic_fdata_sparse,
@@ -1429,7 +1378,6 @@
 		.add	= statistic_add_sparse,
 		.set	= statistic_set_sparse,
 		.name	= "sparse",
-		.size	= sizeof(struct statistic_sparse_list)
 	},
 	[STAT_NONE] = {}
 };



