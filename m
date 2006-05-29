Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWE2WRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWE2WRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWE2WRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:17:53 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:58755 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751432AbWE2WRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:17:51 -0400
Subject: [Patch] statistics infrastructure - update 1
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060524155735.04ed777a.akpm@osdl.org>
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060524155735.04ed777a.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 00:17:35 +0200
Message-Id: <1148941055.3005.73.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

changelog:
- nsec_to_timestamp: u64 is preferred type for kernel's nanoseconds
- improve readability of function prototypes
- fail cpu bringup if out of memory
- use LLONG* constants and fix off-by-one
- nifty list head initialisation
- remove unneeded cast
- remove unneeded parenthesis
- remove unwelcome spaces
- be more careful with inlining
- for_each_cpu() is on death row

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/jiffies.h   |    2
 include/linux/statistic.h |   22 ++++----
 lib/statistic.c           |  122 +++++++++++++++++++++-------------------------
 3 files changed, 71 insertions(+), 75 deletions(-)

--- a/include/linux/jiffies.h	24 May 2006 09:28:36 -0000	1.12
+++ b/include/linux/jiffies.h	26 May 2006 15:35:47 -0000	1.13
@@ -447,7 +447,7 @@
 	return x;
 }
 
-static inline int nsec_to_timestamp(char *s, unsigned long long t)
+static inline int nsec_to_timestamp(char *s, u64 t)
 {
 	unsigned long nsec_rem = do_div(t, NSEC_PER_SEC);
 	return sprintf(s, "[%5lu.%06lu]", (unsigned long)t,
--- a/include/linux/statistic.h	19 May 2006 11:08:16 -0000	1.22
+++ b/include/linux/statistic.h	29 May 2006 20:12:42 -0000
@@ -156,16 +156,18 @@
  * A data area of a data processing mode always has to look the same.
  */
 struct statistic_discipline {
-	int (*parse)(struct statistic *, struct statistic_info *, int, char *);
-	void* (*alloc)(struct statistic *, size_t, gfp_t, int);
-	void (*free)(struct statistic *, void *);
-	void (*reset)(struct statistic *, void *);
-	void (*merge)(struct statistic *, void *, void*);
-	int (*fdata)(struct statistic *, const char *,
-		     struct statistic_file_private *, void *);
-	int (*fdef)(struct statistic *, char *);
-	void (*add)(struct statistic *, int, s64, u64);
-	void (*set)(struct statistic *, s64, u64);
+	int (*parse)(struct statistic * stat, struct statistic_info *info,
+		     int type, char *def);
+	void* (*alloc)(struct statistic *stat, size_t size, gfp_t flags,
+		       int node);
+	void (*free)(struct statistic *stat, void *ptr);
+	void (*reset)(struct statistic *stat, void *ptr);
+	void (*merge)(struct statistic *stat, void *dst, void *src);
+	int (*fdata)(struct statistic *stat, const char *name,
+		     struct statistic_file_private *fpriv, void *data);
+	int (*fdef)(struct statistic *stat, char *line);
+	void (*add)(struct statistic *stat, int cpu, s64 value, u64 incr);
+	void (*set)(struct statistic *stat, s64 value, u64 total);
 	char *name;
 	size_t size;
 };
--- a/lib/statistic.c	19 May 2006 14:12:58 -0000	1.36
+++ b/lib/statistic.c	29 May 2006 20:12:42 -0000
@@ -64,20 +64,20 @@
 
 static struct statistic_discipline statistic_discs[];
 
-static inline int statistic_initialise(struct statistic *stat)
+static int statistic_initialise(struct statistic *stat)
 {
 	stat->type = STATISTIC_TYPE_NONE;
 	stat->state = STATISTIC_STATE_UNCONFIGURED;
 	return 0;
 }
 
-static inline int statistic_uninitialise(struct statistic *stat)
+static int statistic_uninitialise(struct statistic *stat)
 {
 	stat->state = STATISTIC_STATE_INVALID;
 	return 0;
 }
 
-static inline int statistic_define(struct statistic *stat)
+static int statistic_define(struct statistic *stat)
 {
 	if (stat->type == STATISTIC_TYPE_NONE)
 		return -EINVAL;
@@ -85,14 +85,14 @@
 	return 0;
 }
 
-static inline void statistic_reset_ptr(struct statistic *stat, void *ptr)
+static void statistic_reset_ptr(struct statistic *stat, void *ptr)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	if (ptr)
 		disc->reset(stat, ptr);
 }
 
-static inline void statistic_move_ptr(struct statistic *stat, void *src)
+static void statistic_move_ptr(struct statistic *stat, void *src)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	unsigned long flags;
@@ -101,7 +101,7 @@
 	local_irq_restore(flags);
 }
 
-static inline void statistic_free_ptr(struct statistic *stat, void *ptr)
+static void statistic_free_ptr(struct statistic *stat, void *ptr)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	if (ptr) {
@@ -120,7 +120,7 @@
 		stat->pdata = NULL;
 		return 0;
 	}
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		statistic_free_ptr(stat, stat->pdata->ptrs[cpu]);
 		stat->pdata->ptrs[cpu] = NULL;
 	}
@@ -129,13 +129,13 @@
 	return 0;
 }
 
-static void * statistic_alloc_generic(struct statistic *stat, size_t size,
-				      gfp_t flags, int node)
+static void *statistic_alloc_generic(struct statistic *stat, size_t size,
+				     gfp_t flags, int node)
 {
 	return kmalloc_node(size, flags, node);
 }
 
-static void * statistic_alloc_ptr(struct statistic *stat, gfp_t flags, int node)
+static void *statistic_alloc_ptr(struct statistic *stat, gfp_t flags, int node)
 {
 	struct statistic_discipline *disc = &statistic_discs[stat->type];
 	void *buf = disc->alloc(stat, disc->size, flags, node);
@@ -171,7 +171,7 @@
 	return 0;
 }
 
-static inline int statistic_start(struct statistic *stat)
+static int statistic_start(struct statistic *stat)
 {
 	stat->started = sched_clock();
 	stat->state = STATISTIC_STATE_ON;
@@ -182,7 +182,7 @@
 {
 }
 
-static inline int statistic_stop(struct statistic *stat)
+static int statistic_stop(struct statistic *stat)
 {
 	stat->stopped = sched_clock();
 	stat->state = STATISTIC_STATE_OFF;
@@ -196,28 +196,28 @@
 				struct statistic_info *info,
 				enum statistic_state requested_state)
 {
-	int z = (requested_state < stat->state ? 1 : 0);
+	int z = requested_state < stat->state ? 1 : 0;
 	int retval = -EINVAL;
 
 	while (stat->state != requested_state) {
 		switch (stat->state) {
 		case STATISTIC_STATE_INVALID:
-			retval = ( z ? -EINVAL : statistic_initialise(stat) );
+			retval = z ? -EINVAL : statistic_initialise(stat);
 			break;
 		case STATISTIC_STATE_UNCONFIGURED:
-			retval = ( z ? statistic_uninitialise(stat)
-				     : statistic_define(stat) );
+			retval = z ? statistic_uninitialise(stat)
+				   : statistic_define(stat);
 			break;
 		case STATISTIC_STATE_RELEASED:
-			retval = ( z ? statistic_initialise(stat)
-				     : statistic_alloc(stat, info) );
+			retval = z ? statistic_initialise(stat)
+				   : statistic_alloc(stat, info);
 			break;
 		case STATISTIC_STATE_OFF:
-			retval = ( z ? statistic_free(stat, info)
-				     : statistic_start(stat) );
+			retval = z ? statistic_free(stat, info)
+				   : statistic_start(stat);
 			break;
 		case STATISTIC_STATE_ON:
-			retval = ( z ? statistic_stop(stat) : -EINVAL );
+			retval = z ? statistic_stop(stat) : -EINVAL;
 			break;
 		}
 		if (unlikely(retval))
@@ -237,7 +237,7 @@
 	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
 		statistic_reset_ptr(stat, stat->pdata);
 	else
-		for_each_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			statistic_reset_ptr(stat, stat->pdata->ptrs[cpu]);
 	stat->age = sched_clock();
 	statistic_transition(stat, info, prev_state);
@@ -279,7 +279,7 @@
 		disc->set(&stat[i], value, total);
 }
 
-static struct sgrb_seg * sgrb_seg_find(struct list_head *lh, int size)
+static struct sgrb_seg *sgrb_seg_find(struct list_head *lh, int size)
 {
 	struct sgrb_seg *seg;
 
@@ -313,7 +313,7 @@
 	}
 }
 
-static char * statistic_state_strings[] = {
+static char *statistic_state_strings[] = {
 	"undefined(BUG)",
 	"unconfigured",
 	"released",
@@ -360,8 +360,8 @@
 	return 0;
 }
 
-static inline int statistic_fdata(struct statistic_interface *interface, int i,
-				  struct statistic_file_private *fpriv)
+static int statistic_fdata(struct statistic_interface *interface, int i,
+			   struct statistic_file_private *fpriv)
 {
 	struct statistic *stat = &interface->stat[i];
 	struct statistic_info *info = &interface->info[i];
@@ -386,8 +386,8 @@
 
 /* cpu hotplug handling for per-cpu data */
 
-static inline int _statistic_hotcpu(struct statistic_interface *interface,
-				    int i, unsigned long action, int cpu)
+static int _statistic_hotcpu(struct statistic_interface *interface,
+			     int i, unsigned long action, int cpu)
 {
 	struct statistic *stat = &interface->stat[i];
 	struct statistic_info *info = &interface->info[i];
@@ -400,6 +400,8 @@
 	case CPU_UP_PREPARE:
 		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_ATOMIC,
 							     cpu_to_node(cpu));
+		if (!stat->pdata->ptrs[cpu])
+			return -ENOMEM;
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_DEAD:
@@ -417,15 +419,19 @@
 static int __cpuinit statistic_hotcpu(struct notifier_block *notifier,
 				      unsigned long action, void *__cpu)
 {
-	int cpu = (unsigned long)__cpu, i;
+	int cpu = (unsigned long)__cpu, i, retval = 0;
 	struct statistic_interface *interface;
 
 	mutex_lock(&statistic_list_mutex);
 	list_for_each_entry(interface, &statistic_list, list)
-		for (i = 0; i < interface->number; i++)
-			_statistic_hotcpu(interface, i, action, cpu);
+		for (i = 0; i < interface->number; i++) {
+			retval = _statistic_hotcpu(interface, i, action, cpu);
+			if (retval)
+				goto unlock;
+		}
+unlock:
 	mutex_unlock(&statistic_list_mutex);
-	return NOTIFY_OK;
+	return (retval ? NOTIFY_BAD : NOTIFY_OK);
 }
 
 static struct notifier_block statistic_hotcpu_notifier =
@@ -702,11 +708,10 @@
 	struct statistic_file_private *private = file->private_data;
 	struct sgrb_seg *seg, *seg_nl;
 	int offset;
-	struct list_head line_lh;
+	LIST_HEAD(line_lh);
 	char *nl;
 	size_t line_size = 0;
 
-	INIT_LIST_HEAD(&line_lh);
 	list_for_each_entry(seg, &private->write_seg_lh, list) {
 		for (offset = 0; offset < seg->offset; offset += seg_nl->size) {
 			seg_nl = kmalloc(sizeof(struct sgrb_seg), GFP_KERNEL);
@@ -896,7 +901,7 @@
 }
 
 static void statistic_add_counter_inc(struct statistic *stat, int cpu,
-				     s64 value, u64 incr)
+				      s64 value, u64 incr)
 {
 	*(u64*)stat->pdata->ptrs[cpu] += incr;
 }
@@ -949,8 +954,8 @@
 	struct statistic_entry_util *util = ptr;
 	util->num = 0;
 	util->acc = 0;
-	util->min = (~0ULL >> 1) - 1;
-	util->max = -(~0ULL >> 1) + 1;
+	util->min = LLONG_MAX;
+	util->max = LLONG_MIN;
 }
 
 static void statistic_add_util(struct statistic *stat, int cpu,
@@ -1020,15 +1025,14 @@
 	seg->offset += sprintf(seg->address + seg->offset,
 			       "%s %Lu %Ld %Ld.%03lld %Ld\n", name,
 			       (unsigned long long)util->num,
-			       (signed long long)min, whole, decimal,
-			       (signed long long)max);
+			       min, whole, decimal, max);
 	return 0;
 }
 
 /* code concerned with histogram statistics */
 
-static void * statistic_alloc_histogram(struct statistic *stat, size_t size,
-					gfp_t flags, int node)
+static void *statistic_alloc_histogram(struct statistic *stat, size_t size,
+				       gfp_t flags, int node)
 {
 	return kmalloc_node(size * (stat->u.histogram.last_index + 1),
 			    flags, node);
@@ -1048,7 +1052,7 @@
 		(i ? (stat->u.histogram.base_interval << (i - 1)) : 0);
 }
 
-static inline s64 statistic_histogram_calc_value(struct statistic *stat, int i)
+static s64 statistic_histogram_calc_value(struct statistic *stat, int i)
 {
 	if (stat->type == STATISTIC_TYPE_HISTOGRAM_LIN)
 		return statistic_histogram_calc_value_lin(stat, i);
@@ -1056,16 +1060,15 @@
 		return statistic_histogram_calc_value_log2(stat, i);
 }
 
-static inline int statistic_histogram_calc_index_lin(struct statistic *stat,
-						 s64 value)
+static int statistic_histogram_calc_index_lin(struct statistic *stat, s64 value)
 {
 	unsigned long long i = value - stat->u.histogram.range_min;
 	do_div(i, stat->u.histogram.base_interval);
 	return i;
 }
 
-static inline int statistic_histogram_calc_index_log2(struct statistic *stat,
-						      s64 value)
+static int statistic_histogram_calc_index_log2(struct statistic *stat,
+					       s64 value)
 {
 	unsigned long long i;
 	for (i = 0;
@@ -1075,15 +1078,6 @@
 	return i;
 }
 
-static inline int statistic_histogram_calc_index(struct statistic *stat,
-						 s64 value)
-{
-	if (stat->type == STATISTIC_TYPE_HISTOGRAM_LIN)
-		return statistic_histogram_calc_index_lin(stat, value);
-	else
-		return statistic_histogram_calc_index_log2(stat, value);
-}
-
 static void statistic_reset_histogram(struct statistic *stat, void *ptr)
 {
 	memset(ptr, 0, (stat->u.histogram.last_index + 1) * sizeof(u64));
@@ -1126,7 +1120,7 @@
 		dst[i] += src[i];
 }
 
-static inline int statistic_fdata_histogram_line(const char *name,
+static int statistic_fdata_histogram_line(const char *name,
 					struct statistic_file_private *private,
 					const char *prefix, s64 bound, u64 hits)
 {
@@ -1216,8 +1210,8 @@
 
 /* code concerned with histograms (discrete value) statistics */
 
-static void * statistic_alloc_sparse(struct statistic *stat, size_t size,
-				     gfp_t flags, int node)
+static void *statistic_alloc_sparse(struct statistic *stat, size_t size,
+				    gfp_t flags, int node)
 {
 	struct statistic_sparse_list *slist = kmalloc_node(size, flags, node);
 	INIT_LIST_HEAD(&slist->entry_lh);
@@ -1237,8 +1231,8 @@
 	slist->entries = 0;
 }
 
-static inline void statistic_add_sparse_sort(struct list_head *head,
-					struct statistic_entry_sparse *entry)
+static void statistic_add_sparse_sort(struct list_head *head,
+				      struct statistic_entry_sparse *entry)
 {
 	struct statistic_entry_sparse *sort =
 		list_prepare_entry(entry, head, list);
@@ -1251,8 +1245,8 @@
 		list_move(&entry->list, &sort->list);
 }
 
-static inline int statistic_add_sparse_new(struct statistic_sparse_list *slist,
-					   s64 value, u64 incr)
+static int statistic_add_sparse_new(struct statistic_sparse_list *slist,
+				    s64 value, u64 incr)
 {
 	struct statistic_entry_sparse *entry;
 
@@ -1268,8 +1262,8 @@
 	return 0;
 }
 
-static inline void _statistic_add_sparse(struct statistic_sparse_list *slist,
-					 s64 value, u64 incr)
+static void _statistic_add_sparse(struct statistic_sparse_list *slist,
+				  s64 value, u64 incr)
 {
 	struct list_head *head = &slist->entry_lh;
 	struct statistic_entry_sparse *entry;




