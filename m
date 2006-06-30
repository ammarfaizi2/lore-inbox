Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbWF3O5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWF3O5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWF3O5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:57:07 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:15276 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932749AbWF3O5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:57:04 -0400
Subject: [Patch] statistics infrastructure - update 7
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 16:57:01 +0200
Message-Id: <1151679421.2972.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a set of slimmed down add-functions as discussed:

- add statistic_add_as() as faster, less flexible alternative for
  statistic_add()
- statistic_add_as() requires type= attribute to be unalterable
- shorten constant names (for use with statistic_add_as)

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 Documentation/statistics.txt |   52 +++++++++++++++++-
 include/linux/statistic.h    |  122 +++++++++++++++++++++++++++++++++++++++----
 lib/statistic.c              |   54 ++++++++++---------
 3 files changed, 193 insertions(+), 35 deletions(-)

diff -urp a/Documentation/statistics.txt b/Documentation/statistics.txt
--- a/Documentation/statistics.txt	2006-06-30 15:57:44.000000000 +0200
+++ b/Documentation/statistics.txt	2006-06-30 16:06:19.000000000 +0200
@@ -646,6 +646,33 @@ Now, here is how to tie the knot for sta
 
 	Reporting statistics data
 
+In short, this is the complete list of function that can be used
+to update a statistic:
+
+  _statistic_add()
+  _statistic_inc()
+
+   statistic_add()
+   statistic_inc()
+
+  _statistic_add_as()
+  _statistic_inc_as()
+
+   statistic_add_as()
+   statistic_inc_as()
+
+   statistic_set()
+
+Function names starting with an "_" indicate that the function leaves it to
+the calling code to make updates smp-safe (see details below).
+
+The *statistic_*_as() functions are stripped down version that are faster and
+less flexible from the user's perspective (see details below).
+
+While the add/inc-functions are used for accumulating incremental statistics
+data, the set-function is used for storing statistics coming as total numbers
+(see details below).
+
 Add statistic_add*() or statistic_inc*() calls where appropriate for
 reporting statistics data. Data to be reported through these functions has the
 form of (X, Y) as explained above:
@@ -690,10 +717,33 @@ in one go for improved performance:
 	  local_irq_restore(flags);
   }
 
+You may use the *statistic_*_as() functions instead if you feel that - for your
+purposes - the performance gain outweighs the flexibility of statistic_add() &
+friends. The *statistic_*_as() functions do not allow user's to change the way
+data processing is done (that is the "type=" attribute), but require the client
+to provide this information through an additional parameter passed to the
+*statistic_*_as() functions. For example, the counter named MY_ENTITY_STAT_O
+can't be inflated to a histogram at run time.
+
+  {
+	  struct my_entity *one;
+	  unsigned long flags;
+	  ...
+
+	  local_irq_save(flags);
+	  _statistic_inc_as(STAT_CNTR_INC, &one->stat, MY_ENTITY_STAT_O, o);
+	  _statistic_add_as(STAT_UTIL, &one->stat, MY_ENTITY_STAT_P, p, number);
+	  ...
+	  local_irq_restore(flags);
+  }
+
+Make sure you have set the STATISTIC_FLAGS_NOFLEX flag for statistics
+which are fed through *statistic_*_as() function to prohibit the alteration
+of the "type=" attribute.
+
 The above examples show statistics that feed on incremental updates that
 get accumulated by the statistics infrastructure on top of data already
 gathered by the statistics infrastructure.
-That is why statistic_add() or statistic_inc() respectively are used.
 
 There might be statistics that come as total numbers, e.g. because they feed
 on counters already maintained by the client or some hardware feature.
diff -urp a/include/linux/statistic.h b/include/linux/statistic.h
--- a/include/linux/statistic.h	2006-06-30 15:57:44.000000000 +0200
+++ b/include/linux/statistic.h	2006-06-30 16:06:19.000000000 +0200
@@ -34,7 +34,7 @@
  * @name: pointer to name name string
  * @x_unit: pointer to string describing unit of X of (X, Y) data pair
  * @y_unit: pointer to string describing unit of Y of (X, Y) data pair
- * @flags: STATISTIC_FLAGS_NOINCR means no incremental data
+ * @flags: bits describing special settings
  * @defaults: pointer to string describing defaults setting for attributes
  *
  * Exploiters must setup an array of struct statistic_info for a
@@ -53,7 +53,8 @@ struct statistic_info {
 	char *x_unit;
 	char *y_unit;
 	int  flags;
-#define STATISTIC_FLAGS_NOINCR	0x01
+#define STATISTIC_FLAGS_NOINCR	0x01	/* no incremental data */
+#define STATISTIC_FLAGS_NOFLEX	0x02	/* type can't be altered by user */
 	char *defaults;
 };
 
@@ -66,13 +67,13 @@ enum statistic_state {
 };
 
 enum statistic_type {
-	STATISTIC_TYPE_COUNTER_INC,
-	STATISTIC_TYPE_COUNTER_PROD,
-	STATISTIC_TYPE_UTIL,
-	STATISTIC_TYPE_HISTOGRAM_LIN,
-	STATISTIC_TYPE_HISTOGRAM_LOG2,
-	STATISTIC_TYPE_SPARSE,
-	STATISTIC_TYPE_NONE
+	STAT_CNTR_INC,
+	STAT_CNTR_PROD,
+	STAT_UTIL,
+	STAT_HGRAM_LIN,
+	STAT_HGRAM_LOG2,
+	STAT_SPARSE,
+	STAT_NONE
 };
 
 /**
@@ -127,9 +128,10 @@ struct statistic_interface {
 extern int statistic_create(struct statistic_interface *, const char *);
 extern int statistic_remove(struct statistic_interface *);
 
+extern void statistic_set(struct statistic *, int, s64, u64);
+
 extern void _statistic_add(struct statistic *, int, s64, u64);
 extern void statistic_add(struct statistic *, int, s64, u64);
-extern void statistic_set(struct statistic *, int, s64, u64);
 
 #define _statistic_inc(stat, i, value) \
 	_statistic_add(stat, i, value, 1)
@@ -137,4 +139,104 @@ extern void statistic_set(struct statist
 #define statistic_inc(stat, i, value) \
 	statistic_add(stat, i, value, 1)
 
+/*
+ * Clients are not supposed to call these directly.
+ * The declarations are needed to allow optimisation of _statistic_add_as()
+ * at compile time.
+ */
+extern void statistic_add_counter_inc(struct statistic *, s64, u64);
+extern void statistic_add_counter_prod(struct statistic *, s64, u64);
+extern void statistic_add_util(struct statistic *, s64, u64);
+extern void statistic_add_histogram_lin(struct statistic *, s64, u64);
+extern void statistic_add_histogram_log2(struct statistic *, s64, u64);
+extern void statistic_add_sparse(struct statistic *, s64, u64);
+
+/**
+ * _statistic_add_as - update statistic with incremental data in (X, Y) pair
+ * @type: data proessing mode to be used (must match statistic_info::defaults)
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @incr: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This function is faster than _statistic_add() because the data
+ * processing mode is already determined at compile time.
+ * Use this when you feel that the perfomance gain outweighs the loss
+ * of flexibility for your particular statistic.
+ *
+ * This variant leaves protecting per-cpu data to clients. It is preferred
+ * whenever clients update several statistics of the same entity in one go.
+ *
+ * You may want to use _statistic_inc_as() for (X, 1) data pairs.
+ */
+static inline void _statistic_add_as(int type, struct statistic *stat, int i,
+		       s64 value, u64 incr)
+{
+#ifdef CONFIG_STATISTICS
+	if (stat[i].state == STATISTIC_STATE_ON) {
+		switch (type) {
+		case STAT_CNTR_INC:
+			statistic_add_counter_inc(&stat[i], value, incr);
+			break;
+		case STAT_CNTR_PROD:
+			statistic_add_counter_prod(&stat[i], value, incr);
+			break;
+		case STAT_UTIL:
+			statistic_add_util(&stat[i], value, incr);
+			break;
+		case STAT_HGRAM_LIN:
+			statistic_add_histogram_lin(&stat[i], value, incr);
+			break;
+		case STAT_HGRAM_LOG2:
+			statistic_add_histogram_log2(&stat[i], value, incr);
+			break;
+		case STAT_SPARSE:
+			statistic_add_sparse(&stat[i], value, incr);
+			break;
+		}
+	}
+#endif
+}
+
+/**
+ * statistic_add_as - update statistic with incremental data in (X, Y) pair
+ * @type: data proessing mode to be used (must match statistic_info::defaults)
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @incr: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * the definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This function is faster than statistic_add() because the data
+ * processing mode is already determined at compile time.
+ * Use this when you feel that the perfomance gain outweighs the loss
+ * of flexibility for your particular statistic.
+ *
+ * This variant takes care of protecting per-cpu data. It is preferred whenever
+ * clients don't update several statistics of the same entity in one go.
+ *
+ * You may want to use statistic_inc() for (X, 1) data pairs.
+ */
+static inline void statistic_add_as(int type, struct statistic *stat, int i,
+		      s64 value, u64 incr)
+{
+#ifdef CONFIG_STATISTICS
+	unsigned long flags;
+	local_irq_save(flags);
+	_statistic_add_as(type, stat, i, value, incr);
+	local_irq_restore(flags);
+#endif
+}
+
+#define _statistic_inc_as(type, stat, i, value) \
+	_statistic_add_as(type, stat, i, value, 1)
+
+#define statistic_inc_as(type, stat, i, value) \
+	statistic_add_as(type, stat, i, value, 1)
+
 #endif /* STATISTIC_H */
diff -urp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-06-30 15:57:44.000000000 +0200
+++ b/lib/statistic.c	2006-06-30 16:06:19.000000000 +0200
@@ -120,7 +120,7 @@ static struct statistic_discipline stati
 
 static int statistic_initialise(struct statistic *stat)
 {
-	stat->type = STATISTIC_TYPE_NONE;
+	stat->type = STAT_NONE;
 	stat->state = STATISTIC_STATE_UNCONFIGURED;
 	return 0;
 }
@@ -133,7 +133,7 @@ static int statistic_uninitialise(struct
 
 static int statistic_define(struct statistic *stat)
 {
-	if (stat->type == STATISTIC_TYPE_NONE)
+	if (stat->type == STAT_NONE)
 		return -EINVAL;
 	stat->state = STATISTIC_STATE_RELEASED;
 	return 0;
@@ -384,6 +384,9 @@ static int statistic_fdef(struct statist
 
 	seg->offset += sprintf(seg->address + seg->offset, " type=%s",
 			       disc->name);
+	if (info->flags & STATISTIC_FLAGS_NOFLEX)
+		seg->offset += sprintf(seg->address + seg->offset, "(fix)");
+
 	if (disc->fdef)
 		seg->offset += disc->fdef(stat, seg->address + seg->offset);
 	if (stat->state == STATISTIC_STATE_RELEASED) {
@@ -509,6 +512,9 @@ static int statistic_parse_single(struct
 	int prev_state = stat->state, retval = 0;
 	char *copy;
 
+	if (info->flags & STATISTIC_FLAGS_NOFLEX && stat->type != type &&
+	    def != info->defaults)
+		return -EINVAL;
 	if (disc->parse) {
 		copy = kstrdup(def, GFP_KERNEL);
 		if (unlikely(!copy))
@@ -550,7 +556,7 @@ static int statistic_parse_match(struct 
 		if (match_token(p, statistic_match_type, args) != 1)
 			continue;
 		len = (args[0].to - args[0].from) + 1;
-		for (type = 0; type < STATISTIC_TYPE_NONE; type++) {
+		for (type = 0; type < STAT_NONE; type++) {
 			disc = &statistic_discs[type];
 			if (unlikely(strncmp(disc->name, args[0].from, len)))
 				continue;
@@ -559,7 +565,7 @@ static int statistic_parse_match(struct 
 		}
 	}
 	kfree(copy);
-	if (unlikely(stat->type == STATISTIC_TYPE_NONE))
+	if (unlikely(stat->type == STAT_NONE))
 		return -EINVAL;
 	return statistic_parse_single(stat, info, def, stat->type);
 }
@@ -844,19 +850,19 @@ static void statistic_reset_counter(stru
 	*(u64*)ptr = 0;
 }
 
-static void statistic_add_counter_inc(struct statistic *stat,
-				      s64 value, u64 incr)
+void statistic_add_counter_inc(struct statistic *stat, s64 value, u64 incr)
 {
 	*(u64*)stat->pdata->ptrs[smp_processor_id()] += incr;
 }
+EXPORT_SYMBOL_GPL(statistic_add_counter_inc);
 
-static void statistic_add_counter_prod(struct statistic *stat,
-				       s64 value, u64 incr)
+void statistic_add_counter_prod(struct statistic *stat, s64 value, u64 incr)
 {
 	if (unlikely(value < 0))
 		value = -value;
 	*(u64*)stat->pdata->ptrs[smp_processor_id()] += value * incr;
 }
+EXPORT_SYMBOL_GPL(statistic_add_counter_prod);
 
 static void statistic_set_counter_inc(struct statistic *stat,
 				      s64 value, u64 total)
@@ -910,8 +916,7 @@ static void statistic_reset_util(struct 
 	util->max = LLONG_MIN;
 }
 
-static void statistic_add_util(struct statistic *stat,
-			       s64 value, u64 incr)
+void statistic_add_util(struct statistic *stat, s64 value, u64 incr)
 {
 	int cpu = smp_processor_id();
 	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
@@ -922,6 +927,7 @@ static void statistic_add_util(struct st
 	if (unlikely(value > util->max))
 		util->max = value;
 }
+EXPORT_SYMBOL_GPL(statistic_add_util);
 
 static void statistic_set_util(struct statistic *stat, s64 value, u64 total)
 {
@@ -1008,7 +1014,7 @@ static inline s64 statistic_histogram_ca
 
 static s64 statistic_histogram_calc_value(struct statistic *stat, int i)
 {
-	if (stat->type == STATISTIC_TYPE_HISTOGRAM_LIN)
+	if (stat->type == STAT_HGRAM_LIN)
 		return statistic_histogram_calc_value_lin(stat, i);
 	else
 		return statistic_histogram_calc_value_log2(stat, i);
@@ -1037,19 +1043,19 @@ static void statistic_reset_histogram(st
 	memset(ptr, 0, (stat->u.histogram.last_index + 1) * sizeof(u64));
 }
 
-static void statistic_add_histogram_lin(struct statistic *stat,
-					s64 value, u64 incr)
+void statistic_add_histogram_lin(struct statistic *stat, s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_lin(stat, value);
 	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
 }
+EXPORT_SYMBOL_GPL(statistic_add_histogram_lin);
 
-static void statistic_add_histogram_log2(struct statistic *stat,
-					 s64 value, u64 incr)
+void statistic_add_histogram_log2(struct statistic *stat, s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_log2(stat, value);
 	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
 }
+EXPORT_SYMBOL_GPL(statistic_add_histogram_log2);
 
 static void statistic_set_histogram_lin(struct statistic *stat,
 					s64 value, u64 total)
@@ -1253,13 +1259,13 @@ static void _statistic_add_sparse(struct
 		slist->hits_missed += incr;
 }
 
-static void statistic_add_sparse(struct statistic *stat,
-				 s64 value, u64 incr)
+void statistic_add_sparse(struct statistic *stat, s64 value, u64 incr)
 {
 	int cpu = smp_processor_id();
 	struct statistic_sparse_list *slist = stat->pdata->ptrs[cpu];
 	_statistic_add_sparse(slist, value, incr);
 }
+EXPORT_SYMBOL_GPL(statistic_add_sparse);
 
 static void statistic_set_sparse(struct statistic *stat, s64 value, u64 total)
 {
@@ -1347,7 +1353,7 @@ static int statistic_parse_sparse(struct
 /* code mostly concerned with managing statistics */
 
 static struct statistic_discipline statistic_discs[] = {
-	[STATISTIC_TYPE_COUNTER_INC] = {
+	[STAT_CNTR_INC] = {
 		.alloc	= statistic_alloc_generic,
 		.free	= statistic_free_generic,
 		.reset	= statistic_reset_counter,
@@ -1358,7 +1364,7 @@ static struct statistic_discipline stati
 		.name	= "counter_inc",
 		.size	= sizeof(u64)
 	},
-	[STATISTIC_TYPE_COUNTER_PROD] = {
+	[STAT_CNTR_PROD] = {
 		.alloc	= statistic_alloc_generic,
 		.free	= statistic_free_generic,
 		.reset	= statistic_reset_counter,
@@ -1369,7 +1375,7 @@ static struct statistic_discipline stati
 		.name	= "counter_prod",
 		.size	= sizeof(u64)
 	},
-	[STATISTIC_TYPE_UTIL] = {
+	[STAT_UTIL] = {
 		.alloc	= statistic_alloc_generic,
 		.free	= statistic_free_generic,
 		.reset	= statistic_reset_util,
@@ -1380,7 +1386,7 @@ static struct statistic_discipline stati
 		.name	= "utilisation",
 		.size	= sizeof(struct statistic_entry_util)
 	},
-	[STATISTIC_TYPE_HISTOGRAM_LIN] = {
+	[STAT_HGRAM_LIN] = {
 		.parse	= statistic_parse_histogram,
 		.alloc	= statistic_alloc_histogram,
 		.free	= statistic_free_generic,
@@ -1393,7 +1399,7 @@ static struct statistic_discipline stati
 		.name	= "histogram_lin",
 		.size	= sizeof(u64)
 	},
-	[STATISTIC_TYPE_HISTOGRAM_LOG2] = {
+	[STAT_HGRAM_LOG2] = {
 		.parse	= statistic_parse_histogram,
 		.alloc	= statistic_alloc_histogram,
 		.free	= statistic_free_generic,
@@ -1406,7 +1412,7 @@ static struct statistic_discipline stati
 		.name	= "histogram_log2",
 		.size	= sizeof(u64)
 	},
-	[STATISTIC_TYPE_SPARSE] = {
+	[STAT_SPARSE] = {
 		.parse	= statistic_parse_sparse,
 		.alloc	= statistic_alloc_sparse,
 		.free	= statistic_free_sparse,
@@ -1419,7 +1425,7 @@ static struct statistic_discipline stati
 		.name	= "sparse",
 		.size	= sizeof(struct statistic_sparse_list)
 	},
-	[STATISTIC_TYPE_NONE] = {}
+	[STAT_NONE] = {}
 };
 
 /* programming interface functions */


