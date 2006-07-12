Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWGLM1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWGLM1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGLM1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:27:47 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47572 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750755AbWGLM1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:27:46 -0400
Subject: [Patch] statistics infrastructure - update 10
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 14:27:39 +0200
Message-Id: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lib/statistics.c didn't compile if CONFIG_SMP wasn't defined,
because struct percpu_data was used without precautions.

lib/statistic.c: In function 'statistic_move_ptr':
lib/statistic.c:182: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_free':
lib/statistic.c:197: error: dereferencing pointer to incomplete type
lib/statistic.c:198: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_alloc':
lib/statistic.c:217: error: invalid application of 'sizeof' to
incomplete
type 'struct percpu_data'
lib/statistic.c:222: error: dereferencing pointer to incomplete type
lib/statistic.c:223: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_reset':
lib/statistic.c:297: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_merge':
lib/statistic.c:309: error: dereferencing pointer to incomplete type
lib/statistic.c: In function '_statistic_hotcpu':
lib/statistic.c:443: error: dereferencing pointer to incomplete type
lib/statistic.c:444: error: dereferencing pointer to incomplete type
lib/statistic.c:449: error: dereferencing pointer to incomplete type
lib/statistic.c:450: error: dereferencing pointer to incomplete type
lib/statistic.c:451: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_add_counter_inc':
lib/statistic.c:854: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_add_counter_prod':
lib/statistic.c:862: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_add_util':
lib/statistic.c:923: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_add_histogram_lin':
lib/statistic.c:1054: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_add_histogram_log2':
lib/statistic.c:1061: error: dereferencing pointer to incomplete type
lib/statistic.c: In function 'statistic_add_sparse':
lib/statistic.c:1270: error: dereferencing pointer to incomplete type
make[1]: *** [lib/statistic.o] Error 1
make: *** [lib] Error 2

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/statistic.h |    2
 lib/statistic.c           |  146 ++++++++++++++++++++++++++++------------------
 2 files changed, 92 insertions(+), 56 deletions(-)

--- a/include/linux/statistic.h	2006-07-12 13:04:47.000000000 +0200
+++ b/include/linux/statistic.h	2006-07-12 13:07:12.000000000 +0200
@@ -83,7 +83,7 @@
 /* private: */
 	enum statistic_state	 state;
 	enum statistic_type	 type;
-	struct percpu_data	*pdata;
+	void			*data;
 	void			(*add)(struct statistic *, s64, u64);
 	u64			 started;
 	u64			 stopped;
--- a/lib/statistic.c	2006-07-12 13:04:48.000000000 +0200
+++ b/lib/statistic.c	2006-07-12 13:07:14.000000000 +0200
@@ -62,6 +62,13 @@
 #include <asm/bug.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_SMP
+#define statistic_ptr(stat, cpu) \
+	((struct percpu_data*)((stat)->data))->ptrs[(cpu)]
+#else
+#define statistic_ptr(stat, cpu) (stat)->data
+#endif
+
 struct statistic_file_private {
 	struct list_head read_seg_lh;
 	struct list_head write_seg_lh;
@@ -179,56 +186,87 @@
 	unsigned long flags;
 	if (src) {
 		local_irq_save(flags);
-		disc->merge(stat, stat->pdata->ptrs[smp_processor_id()], src);
+		disc->merge(stat, statistic_ptr(stat, smp_processor_id()), src);
 		local_irq_restore(flags);
 	}
 }
 
-static int statistic_free(struct statistic *stat, struct statistic_info *info)
+static void statistic_free_1(struct statistic *stat)
+{
+	statistic_free_ptr(stat, stat->data);
+	stat->data = NULL;
+}
+
+#ifdef CONFIG_SMP
+static void statistic_free_n(struct statistic *stat)
 {
 	int cpu;
-	stat->state = STATISTIC_STATE_RELEASED;
-	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
-		statistic_free_ptr(stat, stat->pdata);
-		stat->pdata = NULL;
-		return 0;
-	}
 	for_each_possible_cpu(cpu) {
-		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
-		stat->pdata->ptrs[cpu] = NULL;
+		statistic_free_ptr(stat, statistic_ptr(stat, cpu));
+		statistic_ptr(stat, cpu) = NULL;
 	}
-	kfree(stat->pdata);
-	stat->pdata = NULL;
+	kfree(stat->data);
+	stat->data = NULL;
+}
+#endif
+
+static int statistic_free(struct statistic *stat, struct statistic_info *info)
+{
+#ifdef CONFIG_SMP
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
+		statistic_free_1(stat);
+	else
+		statistic_free_n(stat);
+#else
+	statistic_free_1(stat);
+#endif
+	stat->state = STATISTIC_STATE_RELEASED;
 	return 0;
 }
 
-static int statistic_alloc(struct statistic *stat,
-			   struct statistic_info *info)
+static int statistic_alloc_1(struct statistic *stat)
 {
-	int cpu, node;
+	stat->data = statistic_alloc_ptr(stat, -1);
+	return (likely(stat->data) ? 0 : -ENOMEM);
+}
 
-	stat->age = timestamp_clock();
-	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
-		stat->pdata = statistic_alloc_ptr(stat, -1);
-		if (unlikely(!stat->pdata))
-			return -ENOMEM;
-		stat->state = STATISTIC_STATE_OFF;
-		return 0;
-	}
-	stat->pdata = kzalloc(sizeof(struct percpu_data), GFP_KERNEL);
-	if (unlikely(!stat->pdata))
+#ifdef CONFIG_SMP
+static int statistic_alloc_n(struct statistic *stat)
+{
+	int cpu, node;
+	stat->data = kzalloc(sizeof(struct percpu_data), GFP_KERNEL);
+	if (unlikely(!stat->data))
 		return -ENOMEM;
 	for_each_online_cpu(cpu) {
 		node = cpu_to_node(cpu);
-		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, node);
-		if (unlikely(!stat->pdata->ptrs[cpu])) {
-			statistic_free(stat, info);
+		statistic_ptr(stat, cpu) = statistic_alloc_ptr(stat, node);
+		if (unlikely(!statistic_ptr(stat, cpu)))
 			return -ENOMEM;
-		}
 	}
-	stat->state = STATISTIC_STATE_OFF;
 	return 0;
 }
+#endif
+
+static int statistic_alloc(struct statistic *stat,
+			   struct statistic_info *info)
+{
+	int retval;
+#ifdef CONFIG_SMP
+	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
+		retval = statistic_alloc_1(stat);
+	else
+		retval = statistic_alloc_n(stat);
+#else
+	retval = statistic_alloc_1(stat);
+#endif
+	if (likely(!retval)) {
+		stat->state = STATISTIC_STATE_OFF;
+		stat->age = timestamp_clock();
+	} else
+		statistic_free(stat, info);
+	return retval;
+
+}
 
 static int statistic_start(struct statistic *stat)
 {
@@ -292,10 +330,10 @@
 		return 0;
 	statistic_transition(stat, info, STATISTIC_STATE_OFF);
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
-		statistic_reset_ptr(stat, stat->pdata);
+		statistic_reset_ptr(stat, stat->data);
 	else
 		for_each_possible_cpu(cpu)
-			statistic_reset_ptr(stat, stat->pdata->ptrs[cpu]);
+			statistic_reset_ptr(stat, statistic_ptr(stat, cpu));
 	stat->age = timestamp_clock();
 	statistic_transition(stat, info, prev_state);
 	return 0;
@@ -307,7 +345,7 @@
 	struct statistic *stat = mpriv->stat;
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	spin_lock(&mpriv->lock);
-	disc->merge(stat, mpriv->dst, stat->pdata->ptrs[smp_processor_id()]);
+	disc->merge(stat, mpriv->dst, statistic_ptr(stat, smp_processor_id()));
 	spin_unlock(&mpriv->lock);
 }
 
@@ -414,7 +452,7 @@
 	if (unlikely(stat->state < STATISTIC_STATE_OFF))
 		return 0;
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
-		return disc->fdata(stat, info->name, fpriv, stat->pdata);
+		return disc->fdata(stat, info->name, fpriv, stat->data);
 	mpriv.dst = statistic_alloc_ptr(stat, -1);
 	if (unlikely(!mpriv.dst))
 		return -ENOMEM;
@@ -441,15 +479,15 @@
 		return NOTIFY_OK;
 	switch (action) {
 	case CPU_UP_PREPARE:
-		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, node);
-		if (!stat->pdata->ptrs[cpu])
+		statistic_ptr(stat, cpu) = statistic_alloc_ptr(stat, node);
+		if (!statistic_ptr(stat, cpu))
 			return NOTIFY_BAD;
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_DEAD:
-		statistic_move_ptr(stat, stat->pdata->ptrs[cpu]);
-		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
-		stat->pdata->ptrs[cpu] = NULL;
+		statistic_move_ptr(stat, statistic_ptr(stat, cpu));
+		statistic_free_ptr(stat, statistic_ptr(stat, cpu));
+		statistic_ptr(stat, cpu) = NULL;
 		break;
 	}
 	return NOTIFY_OK;
@@ -852,7 +890,7 @@
 
 void statistic_add_counter_inc(struct statistic *stat, s64 value, u64 incr)
 {
-	*(u64*)stat->pdata->ptrs[smp_processor_id()] += incr;
+	*(u64*)statistic_ptr(stat, smp_processor_id()) += incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_counter_inc);
 
@@ -860,14 +898,14 @@
 {
 	if (unlikely(value < 0))
 		value = -value;
-	*(u64*)stat->pdata->ptrs[smp_processor_id()] += value * incr;
+	*(u64*)statistic_ptr(stat, smp_processor_id()) += value * incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_counter_prod);
 
 static void statistic_set_counter_inc(struct statistic *stat,
 				      s64 value, u64 total)
 {
-	*(u64*)stat->pdata = total;
+	*(u64*)stat->data = total;
 }
 
 static void statistic_set_counter_prod(struct statistic *stat,
@@ -875,7 +913,7 @@
 {
 	if (unlikely(value < 0))
 		value = -value;
-	*(u64*)stat->pdata = value * total;
+	*(u64*)stat->data = value * total;
 }
 
 static void statistic_merge_counter(struct statistic *stat,
@@ -920,8 +958,8 @@
 
 void statistic_add_util(struct statistic *stat, s64 value, u64 incr)
 {
-	int cpu = smp_processor_id();
-	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
+	struct statistic_entry_util *util;
+	util = statistic_ptr(stat, smp_processor_id());
 	util->num += incr;
 	util->acc += value * incr;
 	util->sqr += value * value * incr;
@@ -934,8 +972,7 @@
 
 static void statistic_set_util(struct statistic *stat, s64 value, u64 total)
 {
-	struct statistic_entry_util *util;
-	util = (struct statistic_entry_util *) stat->pdata;
+	struct statistic_entry_util *util = stat->data;
 	util->num = total;
 	util->acc = value * total;
 	util->sqr = value * value * total;
@@ -1052,14 +1089,14 @@
 void statistic_add_histogram_lin(struct statistic *stat, s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_lin(stat, value);
-	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
+	((u64*)statistic_ptr(stat, smp_processor_id()))[i] += incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_histogram_lin);
 
 void statistic_add_histogram_log2(struct statistic *stat, s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_log2(stat, value);
-	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
+	((u64*)statistic_ptr(stat, smp_processor_id()))[i] += incr;
 }
 EXPORT_SYMBOL_GPL(statistic_add_histogram_log2);
 
@@ -1067,14 +1104,14 @@
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
@@ -1267,16 +1304,15 @@
 
 void statistic_add_sparse(struct statistic *stat, s64 value, u64 incr)
 {
-	int cpu = smp_processor_id();
-	struct statistic_sparse_list *slist = stat->pdata->ptrs[cpu];
+	struct statistic_sparse_list *slist;
+	slist = statistic_ptr(stat, smp_processor_id());
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
 



