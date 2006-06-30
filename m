Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWF3O4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWF3O4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWF3O4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:56:18 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:31496 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751789AbWF3O4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:56:17 -0400
Subject: [Patch] statistics infrastructure - update 6
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 16:56:14 +0200
Message-Id: <1151679374.2972.5.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains more cleanups:

- more C99-style initialisers
- "exploiter" -> "client"
- separate out calculation of whole.decimal
- inlining statistic_add is frowned upon
- kill useless cpu parameter of add-functions
- have programming interface function in one place
- add some missing EXPORT_SYMBOL_GPL

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 Documentation/statistics.txt |   42 ++--
 drivers/s390/scsi/zfcp_ccw.c |    8
 include/linux/statistic.h    |   95 ----------
 lib/statistic.c              |  376 +++++++++++++++++++++++++------------------
 4 files changed, 250 insertions(+), 271 deletions(-)

diff -urp a/Documentation/statistics.txt b/Documentation/statistics.txt
--- a/Documentation/statistics.txt	2006-06-30 14:58:12.000000000 +0200
+++ b/Documentation/statistics.txt	2006-06-30 15:46:40.000000000 +0200
@@ -33,7 +33,7 @@ kernel code as well as users.
  USER	       :			KERNEL
 	       :
 	  user	       statistics	     programming
-	  interface    infrastructure	     interface	  exploiter
+	  interface    infrastructure	     interface	  client
 	       :       +------------------+	  :	  +-----------------+
 	       :       | process data and |	  :	  | collect and     |
  "data"        :       | provide output   |	(X, Y)	  | report data     |
@@ -62,13 +62,13 @@ compute and store, as well as display st
 current settings.
 
 
-	The role of exploiters
+	The role of clients
 
-It is the exploiter's (e.g. device driver's) responsibility to feed the
+It is the client's (e.g. device driver's) responsibility to feed the
 statistics infrastructure with sampled data for the statistics maintained by the
-statistics infrastructure on behalf of the exploiter.
+statistics infrastructure on behalf of the client.
 
-It would be nice of any exploiter to provide a default configuration for each
+It would be nice of any client to provide a default configuration for each
 statistic that most likely works best for general purpose use.
 
 
@@ -85,7 +85,7 @@ a quantity for the main characteristic o
 or request latency, and with Y being a qualifier for that characteristic,
 i.e. the occurrence of a particular X-value.
 
-Thus, the Y-part can be seen as an optimisation that allows exploiters
+Thus, the Y-part can be seen as an optimisation that allows clients
 to report a bunch of similar measurements in one call (see statistic_add()).
 For the programmer's convenience, Y can be omitted when it would be always 1
 (see statistic_inc()).
@@ -95,7 +95,7 @@ For the programmer's convenience, Y can 
 
 There are two methods how such data can be provided to the statistics
 infrastructure, a push interface and a pull interface. Each statistic
-is either a pull-type or push-type statistic as determined by the exploiter.
+is either a pull-type or push-type statistic as determined by the client.
 
 The push-interface is suitable for data feeds that report incremental updates
 to statistics, and where actual accumulation can be left to the statistics
@@ -104,8 +104,8 @@ infrastructure. New measurements usually
 
 The pull-interface is suitable for data that already comes in an aggregated
 form, like hardware measurement data or counters already maintained and
-used by exploiters for other purposes. Reading statistics data from files
-triggers an optional callback of the exploiter, which can update pull-type
+used by clients for other purposes. Reading statistics data from files
+triggers an optional callback of the client, which can update pull-type
 statistics then (see statistic_set()).
 
 
@@ -131,7 +131,7 @@ according to their needs.
 
 	How statistics are organised
 
-Statistics are grouped within "interfaces" (debugfs entries) by exploiters,
+Statistics are grouped within "interfaces" (debugfs entries) by clients,
 in order to reflect collections of related statistics of an entity,
 which is also quite efficient with regard to memory use.
 
@@ -208,7 +208,7 @@ output of the various data processing mo
 
 	State machine
 
-Each statistic has a state that should be initialised by exploiters.
+Each statistic has a state that should be initialised by clients.
 Users probably want to adjust this state, e.g. enable
 data gathering. Defined states and transitions are:
 
@@ -219,7 +219,7 @@ data gathering. Defined states and trans
 	V
   state=released	(mode of data processing has been defined, but memory
 	A		 required for data gathering has not yet been allocated
-	|		 - would be a good default setup provided by exploiters)
+	|		 - would be a good default setup provided by clients)
 	|
 	V
   state=off		(all memory required for the defined mode of data
@@ -245,7 +245,7 @@ FIXME
 
 	Per-CPU data
 
-Measurements reported by exploiters are accumulated into per-CPU data areas
+Measurements reported by clients are accumulated into per-CPU data areas
 in order to avoid the introduction of serialisation during the
 execution of statistic_add(). Locking of per-CPU data is done by disabling
 preemption and interrupts per CPU for the short time of a statistic update.
@@ -400,7 +400,7 @@ in the source code:
 The statistics infrastructure's user interface is in the
 /sys/kernel/debug/statistics directory, assuming debugfs has been mounted at
 /sys/kernel/debug.  The "statistics" directory holds interface subdirectories
-created on the behalf of exploiters, for example:
+created on the behalf of clients, for example:
 
   drwxr-xr-x 2 root root 0 Jul 28 02:16 zfcp-0.0.50d4
 
@@ -606,13 +606,13 @@ programming interface. An array of struc
 array of struct statistic.
 
   struct statistic_info[] {
-	  { /* MY_ENTITY_STAT_REFUND */
+	  [MY_ENTITY_STAT_REFUND] = {
 		  .name     = "refund",
 		  .x_unit   = "cent",
 		  .y_unit   = "bottle",
 		  .defaults = "type=counter_prod"
 	  },
-	  { /* MY_ENTITY_STAT_FILL */
+	  [MY_ENTITY_STAT_FILL] = {
 		  .name     = "fill_level",
 		  .x_unit   = "millilitre",
 		  .y_unit   = "bottle",
@@ -674,7 +674,7 @@ Of course, this example is not optimal. 
 statistic_inc() compare. Sometimes statistic_inc() might be just what you need.
 
 If there is a bunch of statistics to be updated in one go, consider these
-flavours of statistic_add() which require the exploiter to lock per-CPU data
+flavours of statistic_add() which require the client to lock per-CPU data
 in one go for improved performance:
 
   {
@@ -683,9 +683,9 @@ in one go for improved performance:
 	  ...
 
 	  local_irq_save(flags);
-	  statistic_inc_nolock(&one->stat, MY_ENTITY_STAT_X, x);
-	  statistic_inc_nolock(&one->stat, MY_ENTITY_STAT_Y, y);
-	  statistic_add_nolock(&one->stat, MY_ENTITY_STAT_Z, z, number);
+	  _statistic_inc(&one->stat, MY_ENTITY_STAT_X, x);
+	  _statistic_inc(&one->stat, MY_ENTITY_STAT_Y, y);
+	  _statistic_add(&one->stat, MY_ENTITY_STAT_Z, z, number);
 	  ...
 	  local_irq_restore(flags);
   }
@@ -696,7 +696,7 @@ gathered by the statistics infrastructur
 That is why statistic_add() or statistic_inc() respectively are used.
 
 There might be statistics that come as total numbers, e.g. because they feed
-on counters already maintained by the exploiter or some hardware feature.
+on counters already maintained by the client or some hardware feature.
 These numbers can be exported through the statistics infrastructure along
 with any other statistic. In this case, use statistic_set() to report data.
 Usually it is sufficient to do so when the user opens the corresponding
diff -urp a/drivers/s390/scsi/zfcp_ccw.c b/drivers/s390/scsi/zfcp_ccw.c
--- a/drivers/s390/scsi/zfcp_ccw.c	2006-06-30 14:58:16.000000000 +0200
+++ b/drivers/s390/scsi/zfcp_ccw.c	2006-06-30 15:48:07.000000000 +0200
@@ -133,25 +133,25 @@ zfcp_ccw_remove(struct ccw_device *ccw_d
 }
 
 static struct statistic_info zfcp_statinfo_a[] = {
-	{ /* ZFCP_STAT_A_QOF */
+	[ZFCP_STAT_A_QOF] = {
 		.name	  = "qdio_outb_full",
 		.x_unit	  = "sbals_left",
 		.y_unit	  = "",
 		.defaults = "type=counter_inc"
 	},
-	{ /* ZFCP_STAT_A_QO */
+	[ZFCP_STAT_A_QO] = {
 		.name	  = "qdio_outb",
 		.x_unit	  = "sbals_used",
 		.y_unit	  = "",
 		.defaults = "type=utilisation"
 	},
-	{ /* ZFCP_STAT_A_QI */
+	[ZFCP_STAT_A_QI] = {
 		.name	  = "qdio_inb",
 		.x_unit	  = "sbals_used",
 		.y_unit	  = "",
 		.defaults = "type=utilisation"
 	},
-	{ /* ZFCP_STAT_A_ERP */
+	[ZFCP_STAT_A_ERP] = {
 		.name	  = "erp",
 		.x_unit	  = "",
 		.y_unit	  = "",
diff -urp a/include/linux/statistic.h b/include/linux/statistic.h
--- a/include/linux/statistic.h	2006-06-30 14:58:21.000000000 +0200
+++ b/include/linux/statistic.h	2006-06-30 15:53:51.000000000 +0200
@@ -45,7 +45,7 @@
  * the lifetime of corresponding statistics created with statistic_create().
  *
  * Except for the name string, all other members may be left blank.
- * It would be nice of exploiters to fill it out completely, though.
+ * It would be nice of clients to fill it out completely, though.
  */
 struct statistic_info {
 /* public: */
@@ -83,7 +83,7 @@ struct statistic {
 	enum statistic_state	 state;
 	enum statistic_type	 type;
 	struct percpu_data	*pdata;
-	void			(*add)(struct statistic *, int, s64, u64);
+	void			(*add)(struct statistic *, s64, u64);
 	u64			 started;
 	u64			 stopped;
 	u64			 age;
@@ -124,100 +124,17 @@ struct statistic_interface {
 	void			*pull_private;
 };
 
-#ifdef CONFIG_STATISTICS
-
 extern int statistic_create(struct statistic_interface *, const char *);
 extern int statistic_remove(struct statistic_interface *);
 
-/**
- * statistic_add - update statistic with incremental data in (X, Y) pair
- * @stat: struct statistic array
- * @i: index of statistic to be updated
- * @value: X
- * @incr: Y
- *
- * The actual processing of the (X, Y) data pair is determined by the current
- * the definition applied to the statistic. See Documentation/statistics.txt.
- *
- * This variant takes care of protecting per-cpu data. It is preferred whenever
- * exploiters don't update several statistics of the same entity in one go.
- *
- * You may want to use statistic_inc() for (X, 1) data pairs.
- */
-static inline void statistic_add(struct statistic *stat, int i,
-				 s64 value, u64 incr)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	if (stat[i].state == STATISTIC_STATE_ON)
-		stat[i].add(&stat[i], smp_processor_id(), value, incr);
-	local_irq_restore(flags);
-}
-
-/**
- * statistic_add_nolock - update statistic with incremental data in (X, Y) pair
- * @stat: struct statistic array
- * @i: index of statistic to be updated
- * @value: X
- * @incr: Y
- *
- * The actual processing of the (X, Y) data pair is determined by the current
- * definition applied to the statistic. See Documentation/statistics.txt.
- *
- * This variant leaves protecting per-cpu data to exploiters. It is preferred
- * whenever exploiters update several statistics of the same entity in one go.
- *
- * You may want to use statistic_inc_nolock() for (X, 1) data pairs.
- */
-static inline void statistic_add_nolock(struct statistic *stat, int i,
-					s64 value, u64 incr)
-{
-	if (stat[i].state == STATISTIC_STATE_ON)
-		stat[i].add(&stat[i], smp_processor_id(), value, incr);
-}
-
+extern void _statistic_add(struct statistic *, int, s64, u64);
+extern void statistic_add(struct statistic *, int, s64, u64);
 extern void statistic_set(struct statistic *, int, s64, u64);
 
-#else /* CONFIG_STATISTICS */
-
-/*
- * Providing such NOP-functions we unburden exploiters from paying attention
- * to CONFIG_STATISTICS.
- */
-
-static inline int statistic_create(struct statistic_interface *interface,
-				   const char *name)
-{
-	return 0;
-}
-
-static inline int statistic_remove(
-				struct statistic_interface *interface_ptr)
-{
-	return 0;
-}
-
-static inline void statistic_add(struct statistic *stat, int i,
-				 s64 value, u64 incr)
-{
-}
-
-static inline void statistic_add_nolock(struct statistic *stat, int i,
-					s64 value, u64 incr)
-{
-}
-
-static inline void statistic_set(struct statistic *stat, int i,
-				 s64 value, u64 total)
-{
-}
-
-#endif /* CONFIG_STATISTICS */
+#define _statistic_inc(stat, i, value) \
+	_statistic_add(stat, i, value, 1)
 
 #define statistic_inc(stat, i, value) \
 	statistic_add(stat, i, value, 1)
 
-#define statistic_inc_nolock(stat, i, value) \
-	statistic_add_nolock(stat, i, value, 1)
-
 #endif /* STATISTIC_H */
diff -urp a/lib/statistic.c b/lib/statistic.c
--- a/lib/statistic.c	2006-06-30 14:58:22.000000000 +0200
+++ b/lib/statistic.c	2006-06-30 15:46:38.000000000 +0200
@@ -24,7 +24,7 @@
  *
  *    another bunch of ideas being pondered:
  *	- define a set of agreed names or a naming scheme for
- *	  consistency and comparability across exploiters;
+ *	  consistency and comparability across clients;
  *	  this entails an agreement about granularities
  *	  as well (e.g. separate statistic for read/write/no-data commands);
  *	  a common set of unit strings would be nice then, too, of course
@@ -110,7 +110,7 @@ struct statistic_discipline {
 	int (*fdata)(struct statistic *stat, const char *name,
 		     struct statistic_file_private *fpriv, void *data);
 	int (*fdef)(struct statistic *stat, char *line);
-	void (*add)(struct statistic *stat, int cpu, s64 value, u64 incr);
+	void (*add)(struct statistic *stat, s64 value, u64 incr);
 	void (*set)(struct statistic *stat, s64 value, u64 total);
 	char *name;
 	size_t size;
@@ -311,31 +311,6 @@ static void statistic_merge(void *__mpri
 	spin_unlock(&mpriv->lock);
 }
 
-/**
- * statistic_set - set statistic using total numbers in (X, Y) data pair
- * @stat: struct statistic array
- * @i: index of statistic to be updated
- * @value: X
- * @total: Y
- *
- * The actual processing of the (X, Y) data pair is determined by the current
- * definition applied to the statistic. See Documentation/statistics.txt.
- *
- * There is no distinction between a concurrency protected and unprotected
- * statistic_set() flavour needed. statistic_set() may only
- * be called when we pull statistic updates from exploiters. The statistics
- * infrastructure guarantees serialisation for that. Exploiters must not
- * intermix statistic_set() and statistic_add/inc() anyway. That is why,
- * concurrent updates won't happen and there is no additional protection
- * required for statistics fed through statistic_set().
- */
-void statistic_set(struct statistic *stat, int i, s64 value, u64 total)
-{
-	struct statistic_discipline *disc = &statistic_discs[stat[i].type];
-	if (stat[i].state == STATISTIC_STATE_ON)
-		disc->set(&stat[i], value, total);
-}
-
 struct sgrb_seg {
 	struct list_head list;
 	char *address;
@@ -862,97 +837,6 @@ static struct file_operations statistic_
 	.release	= statistic_generic_close,
 };
 
-/**
- * statistic_create - setup statistics and create debugfs files
- * @interface: struct statistic_interface provided by exploiter
- * @name: name of debugfs directory to be created
- *
- * Creates a debugfs directory in "statistics" as well as the "data" and
- * "definition" files. Then we attach setup statistics according to the
- * definition provided by exploiter through struct statistic_interface.
- *
- * struct statistic_interface must have been set up prior to calling this.
- *
- * On success, 0 is returned.
- *
- * If some required memory could not be allocated, or the creation
- * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
- */
-int statistic_create(struct statistic_interface *interface, const char *name)
-{
-	struct statistic *stat = interface->stat;
-	struct statistic_info *info = interface->info;
-	int i;
-
-	BUG_ON(!stat || !info || !interface->number);
-
-	interface->debugfs_dir =
-		debugfs_create_dir(name, statistic_root_dir);
-	if (unlikely(!interface->debugfs_dir))
-		return -ENOMEM;
-
-	interface->data_file = debugfs_create_file(
-		"data", S_IFREG | S_IRUSR, interface->debugfs_dir,
-		(void*)interface, &statistic_data_fops);
-	if (unlikely(!interface->data_file)) {
-		debugfs_remove(interface->debugfs_dir);
-		return -ENOMEM;
-	}
-
-	interface->def_file = debugfs_create_file(
-		"definition", S_IFREG | S_IRUSR | S_IWUSR,
-		interface->debugfs_dir, (void*)interface, &statistic_def_fops);
-	if (unlikely(!interface->def_file)) {
-		debugfs_remove(interface->data_file);
-		debugfs_remove(interface->debugfs_dir);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < interface->number; i++, stat++, info++) {
-		statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
-		statistic_parse_match(stat, info, NULL);
-	}
-
-	mutex_lock(&statistic_list_mutex);
-	list_add(&interface->list, &statistic_list);
-	mutex_unlock(&statistic_list_mutex);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(statistic_create);
-
-/**
- * statistic_remove - remove unused statistics
- * @interface: struct statistic_interface to clean up
- *
- * Remove a debugfs directory in "statistics" along with its "data" and
- * "definition" files. Removing this user interface also causes the removal
- * of all statistics attached to the interface.
- *
- * The exploiter must have ceased reporting statistic data.
- *
- * Returns -EINVAL for attempted double removal, 0 otherwise.
- */
-int statistic_remove(struct statistic_interface *interface)
-{
-	struct statistic *stat = interface->stat;
-	struct statistic_info *info = interface->info;
-	int i;
-
-	if (unlikely(!interface->debugfs_dir))
-		return -EINVAL;
-	mutex_lock(&statistic_list_mutex);
-	list_del(&interface->list);
-	mutex_unlock(&statistic_list_mutex);
-	for (i = 0; i < interface->number; i++, stat++, info++)
-		statistic_transition(stat, info, STATISTIC_STATE_INVALID);
-	debugfs_remove(interface->data_file);
-	debugfs_remove(interface->def_file);
-	debugfs_remove(interface->debugfs_dir);
-	interface->debugfs_dir = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(statistic_remove);
-
 /* code concerned with single value statistics */
 
 static void statistic_reset_counter(struct statistic *stat, void *ptr)
@@ -960,18 +844,18 @@ static void statistic_reset_counter(stru
 	*(u64*)ptr = 0;
 }
 
-static void statistic_add_counter_inc(struct statistic *stat, int cpu,
+static void statistic_add_counter_inc(struct statistic *stat,
 				      s64 value, u64 incr)
 {
-	*(u64*)stat->pdata->ptrs[cpu] += incr;
+	*(u64*)stat->pdata->ptrs[smp_processor_id()] += incr;
 }
 
-static void statistic_add_counter_prod(struct statistic *stat, int cpu,
+static void statistic_add_counter_prod(struct statistic *stat,
 				       s64 value, u64 incr)
 {
 	if (unlikely(value < 0))
 		value = -value;
-	*(u64*)stat->pdata->ptrs[cpu] += value * incr;
+	*(u64*)stat->pdata->ptrs[smp_processor_id()] += value * incr;
 }
 
 static void statistic_set_counter_inc(struct statistic *stat,
@@ -1026,9 +910,10 @@ static void statistic_reset_util(struct 
 	util->max = LLONG_MIN;
 }
 
-static void statistic_add_util(struct statistic *stat, int cpu,
+static void statistic_add_util(struct statistic *stat,
 			       s64 value, u64 incr)
 {
+	int cpu = smp_processor_id();
 	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
 	util->num += incr;
 	util->acc += value * incr;
@@ -1061,39 +946,40 @@ static void statistic_merge_util(struct 
 		dst->max = src->max;
 }
 
+static int statistic_div(signed long long *whole, unsigned long long *decimal,
+			 signed long long a, signed long b, int precision)
+{
+	unsigned long long p, rem, _decimal, _whole = a >= 0 ? a : -a;
+	unsigned long _b = b > 0 ? b : -b;
+	signed int sign = (a ^ (signed long long)b) & ~LLONG_MAX ? -1 : 1;
+	if (!b)
+		return -EINVAL;
+	for (p = 1; precision; precision--, p *= 10);
+	_decimal = do_div(_whole, _b) * p;
+	rem = do_div(_decimal, _b) << 2;
+	*whole = sign * _whole;
+	*decimal = _decimal + (rem >= _b ? 1 : 0);
+	return 0;
+}
+
 static int statistic_fdata_util(struct statistic *stat, const char *name,
 				struct statistic_file_private *fpriv,
 				void *data)
 {
 	struct sgrb_seg *seg;
 	struct statistic_entry_util *util = data;
-	unsigned long long whole = 0;
-	signed long long min = 0, max = 0, decimal = 0, last_digit;
+	unsigned long long mean_w = 0, mean_d = 0,
+			   num = util->num, acc = util->acc;
+	signed long long min = num ? util->min : 0,
+			 max = num ? util->max : 0;
 
 	seg = sgrb_seg_find(&fpriv->read_seg_lh, 128);
 	if (unlikely(!seg))
 		return -ENOMEM;
-	if (likely(util->num)) {
-		whole = util->acc;
-		do_div(whole, util->num);
-		decimal = util->acc * 10000;
-		do_div(decimal, util->num);
-		decimal -= whole * 10000;
-		if (decimal < 0)
-			decimal = -decimal;
-		last_digit = decimal;
-		do_div(last_digit, 10);
-		last_digit = decimal - last_digit * 10;
-		if (last_digit >= 5)
-			decimal += 10;
-		do_div(decimal, 10);
-		min = util->min;
-		max = util->max;
-	}
+	statistic_div(&mean_w, &mean_d, acc, num, 3);
 	seg->offset += sprintf(seg->address + seg->offset,
-			       "%s %Lu %Ld %Ld.%03lld %Ld\n", name,
-			       (unsigned long long)util->num,
-			       min, whole, decimal, max);
+			       "%s %Lu %Ld %Ld.%03Ld %Ld\n", name,
+			       num, min, mean_w, mean_d, max);
 	return 0;
 }
 
@@ -1151,18 +1037,18 @@ static void statistic_reset_histogram(st
 	memset(ptr, 0, (stat->u.histogram.last_index + 1) * sizeof(u64));
 }
 
-static void statistic_add_histogram_lin(struct statistic *stat, int cpu,
+static void statistic_add_histogram_lin(struct statistic *stat,
 					s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_lin(stat, value);
-	((u64*)stat->pdata->ptrs[cpu])[i] += incr;
+	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
 }
 
-static void statistic_add_histogram_log2(struct statistic *stat, int cpu,
+static void statistic_add_histogram_log2(struct statistic *stat,
 					 s64 value, u64 incr)
 {
 	int i = statistic_histogram_calc_index_log2(stat, value);
-	((u64*)stat->pdata->ptrs[cpu])[i] += incr;
+	((u64*)stat->pdata->ptrs[smp_processor_id()])[i] += incr;
 }
 
 static void statistic_set_histogram_lin(struct statistic *stat,
@@ -1367,9 +1253,10 @@ static void _statistic_add_sparse(struct
 		slist->hits_missed += incr;
 }
 
-static void statistic_add_sparse(struct statistic *stat, int cpu,
+static void statistic_add_sparse(struct statistic *stat,
 				 s64 value, u64 incr)
 {
+	int cpu = smp_processor_id();
 	struct statistic_sparse_list *slist = stat->pdata->ptrs[cpu];
 	_statistic_add_sparse(slist, value, incr);
 }
@@ -1460,7 +1347,7 @@ static int statistic_parse_sparse(struct
 /* code mostly concerned with managing statistics */
 
 static struct statistic_discipline statistic_discs[] = {
-	{ /* STATISTIC_TYPE_COUNTER_INC */
+	[STATISTIC_TYPE_COUNTER_INC] = {
 		.alloc	= statistic_alloc_generic,
 		.free	= statistic_free_generic,
 		.reset	= statistic_reset_counter,
@@ -1471,7 +1358,7 @@ static struct statistic_discipline stati
 		.name	= "counter_inc",
 		.size	= sizeof(u64)
 	},
-	{ /* STATISTIC_TYPE_COUNTER_PROD */
+	[STATISTIC_TYPE_COUNTER_PROD] = {
 		.alloc	= statistic_alloc_generic,
 		.free	= statistic_free_generic,
 		.reset	= statistic_reset_counter,
@@ -1482,7 +1369,7 @@ static struct statistic_discipline stati
 		.name	= "counter_prod",
 		.size	= sizeof(u64)
 	},
-	{ /* STATISTIC_TYPE_UTIL */
+	[STATISTIC_TYPE_UTIL] = {
 		.alloc	= statistic_alloc_generic,
 		.free	= statistic_free_generic,
 		.reset	= statistic_reset_util,
@@ -1493,7 +1380,7 @@ static struct statistic_discipline stati
 		.name	= "utilisation",
 		.size	= sizeof(struct statistic_entry_util)
 	},
-	{ /* STATISTIC_TYPE_HISTOGRAM_LIN */
+	[STATISTIC_TYPE_HISTOGRAM_LIN] = {
 		.parse	= statistic_parse_histogram,
 		.alloc	= statistic_alloc_histogram,
 		.free	= statistic_free_generic,
@@ -1506,7 +1393,7 @@ static struct statistic_discipline stati
 		.name	= "histogram_lin",
 		.size	= sizeof(u64)
 	},
-	{ /* STATISTIC_TYPE_HISTOGRAM_LOG2 */
+	[STATISTIC_TYPE_HISTOGRAM_LOG2] = {
 		.parse	= statistic_parse_histogram,
 		.alloc	= statistic_alloc_histogram,
 		.free	= statistic_free_generic,
@@ -1519,7 +1406,7 @@ static struct statistic_discipline stati
 		.name	= "histogram_log2",
 		.size	= sizeof(u64)
 	},
-	{ /* STATISTIC_TYPE_SPARSE */
+	[STATISTIC_TYPE_SPARSE] = {
 		.parse	= statistic_parse_sparse,
 		.alloc	= statistic_alloc_sparse,
 		.free	= statistic_free_sparse,
@@ -1532,9 +1419,184 @@ static struct statistic_discipline stati
 		.name	= "sparse",
 		.size	= sizeof(struct statistic_sparse_list)
 	},
-	{ /* STATISTIC_TYPE_NONE */ }
+	[STATISTIC_TYPE_NONE] = {}
 };
 
+/* programming interface functions */
+
+/**
+ * statistic_create - setup statistics and create debugfs files
+ * @interface: struct statistic_interface provided by client
+ * @name: name of debugfs directory to be created
+ *
+ * Creates a debugfs directory in "statistics" as well as the "data" and
+ * "definition" files. Then we attach setup statistics according to the
+ * definition provided by client through struct statistic_interface.
+ *
+ * struct statistic_interface must have been set up prior to calling this.
+ *
+ * On success, 0 is returned.
+ *
+ * If some required memory could not be allocated, or the creation
+ * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
+ */
+int statistic_create(struct statistic_interface *interface, const char *name)
+{
+#ifdef CONFIG_STATISTICS
+	struct statistic *stat = interface->stat;
+	struct statistic_info *info = interface->info;
+	int i;
+
+	BUG_ON(!stat || !info || !interface->number);
+
+	interface->debugfs_dir =
+		debugfs_create_dir(name, statistic_root_dir);
+	if (unlikely(!interface->debugfs_dir))
+		return -ENOMEM;
+
+	interface->data_file = debugfs_create_file(
+		"data", S_IFREG | S_IRUSR, interface->debugfs_dir,
+		(void*)interface, &statistic_data_fops);
+	if (unlikely(!interface->data_file)) {
+		debugfs_remove(interface->debugfs_dir);
+		return -ENOMEM;
+	}
+
+	interface->def_file = debugfs_create_file(
+		"definition", S_IFREG | S_IRUSR | S_IWUSR,
+		interface->debugfs_dir, (void*)interface, &statistic_def_fops);
+	if (unlikely(!interface->def_file)) {
+		debugfs_remove(interface->data_file);
+		debugfs_remove(interface->debugfs_dir);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < interface->number; i++, stat++, info++) {
+		statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
+		statistic_parse_match(stat, info, NULL);
+	}
+
+	mutex_lock(&statistic_list_mutex);
+	list_add(&interface->list, &statistic_list);
+	mutex_unlock(&statistic_list_mutex);
+#endif
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statistic_create);
+
+/**
+ * statistic_remove - remove unused statistics
+ * @interface: struct statistic_interface to clean up
+ *
+ * Remove a debugfs directory in "statistics" along with its "data" and
+ * "definition" files. Removing this user interface also causes the removal
+ * of all statistics attached to the interface.
+ *
+ * The client must have ceased reporting statistic data.
+ *
+ * Returns -EINVAL for attempted double removal, 0 otherwise.
+ */
+int statistic_remove(struct statistic_interface *interface)
+{
+#ifdef CONFIG_STATISTICS
+	struct statistic *stat = interface->stat;
+	struct statistic_info *info = interface->info;
+	int i;
+
+	if (unlikely(!interface->debugfs_dir))
+		return -EINVAL;
+	mutex_lock(&statistic_list_mutex);
+	list_del(&interface->list);
+	mutex_unlock(&statistic_list_mutex);
+	for (i = 0; i < interface->number; i++, stat++, info++)
+		statistic_transition(stat, info, STATISTIC_STATE_INVALID);
+	debugfs_remove(interface->data_file);
+	debugfs_remove(interface->def_file);
+	debugfs_remove(interface->debugfs_dir);
+	interface->debugfs_dir = NULL;
+#endif
+	return 0;
+}
+EXPORT_SYMBOL_GPL(statistic_remove);
+
+/**
+ * _statistic_add - update statistic with incremental data in (X, Y) pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @incr: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This variant leaves protecting per-cpu data to clients. It is preferred
+ * whenever clients update several statistics of the same entity in one go.
+ *
+ * You may want to use _statistic_inc() for (X, 1) data pairs.
+ */
+void _statistic_add(struct statistic *stat, int i, s64 value, u64 incr)
+{
+#ifdef CONFIG_STATISTICS
+	if (stat[i].state == STATISTIC_STATE_ON)
+		stat[i].add(&stat[i], value, incr);
+#endif
+}
+EXPORT_SYMBOL_GPL(_statistic_add);
+
+/**
+ * statistic_add - update statistic with incremental data in (X, Y) pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @incr: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * the definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * This variant takes care of protecting per-cpu data. It is preferred whenever
+ * clients don't update several statistics of the same entity in one go.
+ *
+ * You may want to use statistic_inc() for (X, 1) data pairs.
+ */
+void statistic_add(struct statistic *stat, int i, s64 value, u64 incr)
+{
+#ifdef CONFIG_STATISTICS
+	unsigned long flags;
+	local_irq_save(flags);
+	_statistic_add(stat, i, value, incr);
+	local_irq_restore(flags);
+#endif
+}
+EXPORT_SYMBOL_GPL(statistic_add);
+
+/**
+ * statistic_set - set statistic using total numbers in (X, Y) data pair
+ * @stat: struct statistic array
+ * @i: index of statistic to be updated
+ * @value: X
+ * @total: Y
+ *
+ * The actual processing of the (X, Y) data pair is determined by the current
+ * definition applied to the statistic. See Documentation/statistics.txt.
+ *
+ * There is no distinction between a concurrency protected and unprotected
+ * statistic_set() flavour needed. statistic_set() may only
+ * be called when we pull statistic updates from clients. The statistics
+ * infrastructure guarantees serialisation for that. Exploiters must not
+ * intermix statistic_set() and statistic_add/inc() anyway. That is why,
+ * concurrent updates won't happen and there is no additional protection
+ * required for statistics fed through statistic_set().
+ */
+void statistic_set(struct statistic *stat, int i, s64 value, u64 total)
+{
+#ifdef CONFIG_STATISTICS
+	struct statistic_discipline *disc = &statistic_discs[stat[i].type];
+	if (stat[i].state == STATISTIC_STATE_ON)
+		disc->set(&stat[i], value, total);
+#endif
+}
+EXPORT_SYMBOL_GPL(statistic_set);
+
 postcore_initcall(statistic_init);
 module_exit(statistic_exit);
 


