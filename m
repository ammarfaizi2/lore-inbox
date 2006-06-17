Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWFQJvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWFQJvd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 05:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFQJvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 05:51:33 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:29922 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751054AbWFQJvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 05:51:32 -0400
Subject: [Resend] [Patch] statistics infrastructure - update 5
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 11:51:21 +0200
Message-Id: <1150537881.2924.8.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry for the meagre changelog in my previous posting.
This is the same patch with a more detailed changelog.
Please apply.

This patch contains cleanups suggested by Greg KH.
No functional changes.

- C99 field initializers in structures
- simplify loop in statistic_transition()
- slim down header file
- fix description of CONFIG_STATISTICS
- simplify statistic_inc() and statistic_inc_nolock()
- add a comment about the non-CONFIG_STATISTICS stuff in header file

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 Documentation/statistics.txt |   33 +++--
 drivers/s390/scsi/zfcp_ccw.c |   24 +++-
 include/linux/statistic.h    |  238 ++++++++++---------------------------------
 lib/Kconfig.statistic        |    8 -
 lib/statistic.c              |  218 ++++++++++++++++++++++++++-------------
 5 files changed, 251 insertions(+), 270 deletions(-)

--- a/lib/statistic.c	13 Jun 2006 15:23:19 -0000	1.50
+++ b/lib/statistic.c	16 Jun 2006 22:49:17 -0000	1.54
@@ -62,6 +62,60 @@
 #include <asm/bug.h>
 #include <asm/uaccess.h>
 
+struct statistic_file_private {
+	struct list_head read_seg_lh;
+	struct list_head write_seg_lh;
+	size_t write_seg_total_size;
+};
+
+struct statistic_merge_private {
+	struct statistic *stat;
+	spinlock_t lock;
+	void *dst;
+};
+
+/**
+ * struct statistic_discipline - description of a data processing mode
+ * @parse: parses additional attributes specific to this mode (if any)
+ * @alloc: allocates a data area (mandatory, default routine available)
+ * @free: frees a data area (mandatory, default routine available)
+ * @reset: discards content of a data area (mandatory)
+ * @merge: merges content of a data area into another data area (mandatory)
+ * @fdata: prints content of a data area into buffer (mandatory)
+ * @fdef: prints additional attributes specific to this mode (if any)
+ * @add: updates a data area for a statistic fed incremental data (mandatory)
+ * @set: updates a data area for a statistic fed total numbers (mandatory)
+ * @name: pointer to name string (mandatory)
+ * @size: base size for a data area (passed to alloc function)
+ *
+ * Struct statistic_discipline describes a statistic infrastructure internal
+ * programming interface. Another data processing mode can be added by
+ * implementing these routines and appending an entry to the
+ * statistic_discs array.
+ *
+ * "Data area" in te above description usually means a chunk of memory,
+ * may it be allocated for data gathering per CPU, or be shared by all
+ * CPUs, or used for other purposes, like merging per-CPU data when
+ * users read data from files. Implementers of data processing modes
+ * don't need to worry about the designation of a particular chunk of memory.
+ * A data area of a data processing mode always has to look the same.
+ */
+struct statistic_discipline {
+	int (*parse)(struct statistic * stat, struct statistic_info *info,
+		     int type, char *def);
+	void *(*alloc)(struct statistic *stat, size_t size, int node);
+	void (*free)(struct statistic *stat, void *ptr);
+	void (*reset)(struct statistic *stat, void *ptr);
+	void (*merge)(struct statistic *stat, void *dst, void *src);
+	int (*fdata)(struct statistic *stat, const char *name,
+		     struct statistic_file_private *fpriv, void *data);
+	int (*fdef)(struct statistic *stat, char *line);
+	void (*add)(struct statistic *stat, int cpu, s64 value, u64 incr);
+	void (*set)(struct statistic *stat, s64 value, u64 total);
+	char *name;
+	size_t size;
+};
+
 static struct statistic_discipline statistic_discs[];
 
 static int statistic_initialise(struct statistic *stat)
@@ -202,9 +256,9 @@
 				enum statistic_state requested_state)
 {
 	int z = requested_state < stat->state ? 1 : 0;
-	int retval = -EINVAL;
+	int retval = 0;
 
-	while (stat->state != requested_state) {
+	while (!retval && stat->state != requested_state) {
 		switch (stat->state) {
 		case STATISTIC_STATE_INVALID:
 			retval = z ? -EINVAL : statistic_initialise(stat);
@@ -225,10 +279,8 @@
 			retval = z ? statistic_stop(stat) : -EINVAL;
 			break;
 		}
-		if (unlikely(retval))
-			return retval;
 	}
-	return 0;
+	return retval;
 }
 
 static int statistic_reset(struct statistic *stat, struct statistic_info *info)
@@ -284,6 +336,13 @@
 		disc->set(&stat[i], value, total);
 }
 
+struct sgrb_seg {
+	struct list_head list;
+	char *address;
+	int offset;
+	int size;
+};
+
 static struct sgrb_seg *sgrb_seg_find(struct list_head *lh, int size)
 {
 	struct sgrb_seg *seg;
@@ -450,7 +509,7 @@
 
 int __init statistic_init(void)
 {
-	statistic_root_dir = debugfs_create_dir(STATISTIC_ROOT_DIR, NULL);
+	statistic_root_dir = debugfs_create_dir("statistics", NULL);
 	if (unlikely(!statistic_root_dir))
 		return -ENOMEM;
 	INIT_LIST_HEAD(&statistic_list);
@@ -833,15 +892,15 @@
 		return -ENOMEM;
 
 	interface->data_file = debugfs_create_file(
-		STATISTIC_FILENAME_DATA, S_IFREG | S_IRUSR,
-		interface->debugfs_dir, (void*)interface, &statistic_data_fops);
+		"data", S_IFREG | S_IRUSR, interface->debugfs_dir,
+		(void*)interface, &statistic_data_fops);
 	if (unlikely(!interface->data_file)) {
 		debugfs_remove(interface->debugfs_dir);
 		return -ENOMEM;
 	}
 
 	interface->def_file = debugfs_create_file(
-		STATISTIC_FILENAME_DEF, S_IFREG | S_IRUSR | S_IWUSR,
+		"definition", S_IFREG | S_IRUSR | S_IWUSR,
 		interface->debugfs_dir, (void*)interface, &statistic_def_fops);
 	if (unlikely(!interface->def_file)) {
 		debugfs_remove(interface->data_file);
@@ -950,6 +1009,14 @@
 
 /* code concerned with utilisation indicator statistic */
 
+struct statistic_entry_util {
+	u32 res;
+	u32 num;	/* FIXME: better 64 bit; do_div can't deal with it) */
+	s64 acc;
+	s64 min;
+	s64 max;
+};
+
 static void statistic_reset_util(struct statistic *stat, void *ptr)
 {
 	struct statistic_entry_util *util = ptr;
@@ -1211,6 +1278,19 @@
 
 /* code concerned with histograms (discrete value) statistics */
 
+struct statistic_entry_sparse {
+	struct list_head list;
+	s64 value;
+	u64 hits;
+};
+
+struct statistic_sparse_list {
+	struct list_head entry_lh;
+	u32 entries;
+	u32 entries_max;
+	u64 hits_missed;
+};
+
 static void *statistic_alloc_sparse(struct statistic *stat, size_t size,
 				    int node)
 {
@@ -1381,76 +1461,76 @@
 
 static struct statistic_discipline statistic_discs[] = {
 	{ /* STATISTIC_TYPE_COUNTER_INC */
-	  NULL,
-	  statistic_alloc_generic,
-	  statistic_free_generic,
-	  statistic_reset_counter,
-	  statistic_merge_counter,
-	  statistic_fdata_counter,
-	  NULL,
-	  statistic_add_counter_inc,
-	  statistic_set_counter_inc,
-	  "counter_inc", sizeof(u64)
+		.alloc	= statistic_alloc_generic,
+		.free	= statistic_free_generic,
+		.reset	= statistic_reset_counter,
+		.merge	= statistic_merge_counter,
+		.fdata	= statistic_fdata_counter,
+		.add	= statistic_add_counter_inc,
+		.set	= statistic_set_counter_inc,
+		.name	= "counter_inc",
+		.size	= sizeof(u64)
 	},
 	{ /* STATISTIC_TYPE_COUNTER_PROD */
-	  NULL,
-	  statistic_alloc_generic,
-	  statistic_free_generic,
-	  statistic_reset_counter,
-	  statistic_merge_counter,
-	  statistic_fdata_counter,
-	  NULL,
-	  statistic_add_counter_prod,
-	  statistic_set_counter_prod,
-	  "counter_prod", sizeof(u64)
+		.alloc	= statistic_alloc_generic,
+		.free	= statistic_free_generic,
+		.reset	= statistic_reset_counter,
+		.merge	= statistic_merge_counter,
+		.fdata	= statistic_fdata_counter,
+		.add	= statistic_add_counter_prod,
+		.set	= statistic_set_counter_prod,
+		.name	= "counter_prod",
+		.size	= sizeof(u64)
 	},
 	{ /* STATISTIC_TYPE_UTIL */
-	  NULL,
-	  statistic_alloc_generic,
-	  statistic_free_generic,
-	  statistic_reset_util,
-	  statistic_merge_util,
-	  statistic_fdata_util,
-	  NULL,
-	  statistic_add_util,
-	  statistic_set_util,
-	  "utilisation", sizeof(struct statistic_entry_util)
+		.alloc	= statistic_alloc_generic,
+		.free	= statistic_free_generic,
+		.reset	= statistic_reset_util,
+		.merge	= statistic_merge_util,
+		.fdata	= statistic_fdata_util,
+		.add	= statistic_add_util,
+		.set	= statistic_set_util,
+		.name	= "utilisation",
+		.size	= sizeof(struct statistic_entry_util)
 	},
 	{ /* STATISTIC_TYPE_HISTOGRAM_LIN */
-	  statistic_parse_histogram,
-	  statistic_alloc_histogram,
-	  statistic_free_generic,
-	  statistic_reset_histogram,
-	  statistic_merge_histogram,
-	  statistic_fdata_histogram,
-	  statistic_fdef_histogram,
-	  statistic_add_histogram_lin,
-	  statistic_set_histogram_lin,
-	  "histogram_lin", sizeof(u64)
+		.parse	= statistic_parse_histogram,
+		.alloc	= statistic_alloc_histogram,
+		.free	= statistic_free_generic,
+		.reset	= statistic_reset_histogram,
+		.merge	= statistic_merge_histogram,
+		.fdata	= statistic_fdata_histogram,
+		.fdef	= statistic_fdef_histogram,
+		.add	= statistic_add_histogram_lin,
+		.set	= statistic_set_histogram_lin,
+		.name	= "histogram_lin",
+		.size	= sizeof(u64)
 	},
 	{ /* STATISTIC_TYPE_HISTOGRAM_LOG2 */
-	  statistic_parse_histogram,
-	  statistic_alloc_histogram,
-	  statistic_free_generic,
-	  statistic_reset_histogram,
-	  statistic_merge_histogram,
-	  statistic_fdata_histogram,
-	  statistic_fdef_histogram,
-	  statistic_add_histogram_log2,
-	  statistic_set_histogram_log2,
-	  "histogram_log2", sizeof(u64)
+		.parse	= statistic_parse_histogram,
+		.alloc	= statistic_alloc_histogram,
+		.free	= statistic_free_generic,
+		.reset	= statistic_reset_histogram,
+		.merge	= statistic_merge_histogram,
+		.fdata	= statistic_fdata_histogram,
+		.fdef	= statistic_fdef_histogram,
+		.add	= statistic_add_histogram_log2,
+		.set	= statistic_set_histogram_log2,
+		.name	= "histogram_log2",
+		.size	= sizeof(u64)
 	},
 	{ /* STATISTIC_TYPE_SPARSE */
-	  statistic_parse_sparse,
-	  statistic_alloc_sparse,
-	  statistic_free_sparse,
-	  statistic_reset_sparse,
-	  statistic_merge_sparse,
-	  statistic_fdata_sparse,
-	  statistic_fdef_sparse,
-	  statistic_add_sparse,
-	  statistic_set_sparse,
-	  "sparse", sizeof(struct statistic_sparse_list)
+		.parse	= statistic_parse_sparse,
+		.alloc	= statistic_alloc_sparse,
+		.free	= statistic_free_sparse,
+		.reset	= statistic_reset_sparse,
+		.merge	= statistic_merge_sparse,
+		.fdata	= statistic_fdata_sparse,
+		.fdef	= statistic_fdef_sparse,
+		.add	= statistic_add_sparse,
+		.set	= statistic_set_sparse,
+		.name	= "sparse",
+		.size	= sizeof(struct statistic_sparse_list)
 	},
 	{ /* STATISTIC_TYPE_NONE */ }
 };
--- a/include/linux/statistic.h	13 Jun 2006 15:14:26 -0000	1.25
+++ b/include/linux/statistic.h	16 Jun 2006 14:21:49 -0000	1.28
@@ -29,41 +29,12 @@
 #include <linux/types.h>
 #include <linux/percpu.h>
 
-#define STATISTIC_ROOT_DIR	"statistics"
-
-#define STATISTIC_FILENAME_DATA	"data"
-#define STATISTIC_FILENAME_DEF	"definition"
-
-#define STATISTIC_NEED_BARRIER	1
-
-struct statistic;
-
-enum statistic_state {
-	STATISTIC_STATE_INVALID,
-	STATISTIC_STATE_UNCONFIGURED,
-	STATISTIC_STATE_RELEASED,
-	STATISTIC_STATE_OFF,
-	STATISTIC_STATE_ON
-};
-
-enum statistic_type {
-	STATISTIC_TYPE_COUNTER_INC,
-	STATISTIC_TYPE_COUNTER_PROD,
-	STATISTIC_TYPE_UTIL,
-	STATISTIC_TYPE_HISTOGRAM_LIN,
-	STATISTIC_TYPE_HISTOGRAM_LOG2,
-	STATISTIC_TYPE_SPARSE,
-	STATISTIC_TYPE_NONE
-};
-
-#define STATISTIC_FLAGS_NOINCR	0x01
-
 /**
  * struct statistic_info - description of a class of statistics
  * @name: pointer to name name string
  * @x_unit: pointer to string describing unit of X of (X, Y) data pair
  * @y_unit: pointer to string describing unit of Y of (X, Y) data pair
- * @flags: only flag so far (distinction of incremental and other statistic)
+ * @flags: STATISTIC_FLAGS_NOINCR means no incremental data
  * @defaults: pointer to string describing defaults setting for attributes
  *
  * Exploiters must setup an array of struct statistic_info for a
@@ -82,114 +53,26 @@
 	char *x_unit;
 	char *y_unit;
 	int  flags;
+#define STATISTIC_FLAGS_NOINCR	0x01
 	char *defaults;
 };
 
-/**
- * struct statistic_interface - collection of statistics for an entity
- * @stat: a struct statistic array
- * @info: a struct statistic_info array describing the struct statistic array
- * @number: number of entries in both arrays
- * @pull: an optional function called when user reads data from file
- * @pull_private: optional data pointer passed to pull function
- *
- * Exploiters must setup a struct statistic_interface prior to calling
- * statistic_create().
- */
-struct statistic_interface {
-/* private: */
-	struct list_head	 list;
-	struct dentry		*debugfs_dir;
-	struct dentry		*data_file;
-	struct dentry		*def_file;
-/* public: */
-	struct statistic	*stat;
-	struct statistic_info	*info;
-	int			 number;
-	int			(*pull)(void*);
-	void			*pull_private;
-};
-
-struct sgrb_seg {
-	struct list_head list;
-	char *address;
-	int offset;
-	int size;
-};
-
-struct statistic_file_private {
-	struct list_head read_seg_lh;
-	struct list_head write_seg_lh;
-	size_t write_seg_total_size;
-};
-
-struct statistic_merge_private {
-	struct statistic *stat;
-	spinlock_t lock;
-	void *dst;
-};
-
-/**
- * struct statistic_discipline - description of a data processing mode
- * @parse: parses additional attributes specific to this mode (if any)
- * @alloc: allocates a data area (mandatory, default routine available)
- * @free: frees a data area (mandatory, default routine available)
- * @reset: discards content of a data area (mandatory)
- * @merge: merges content of a data area into another data area (mandatory)
- * @fdata: prints content of a data area into buffer (mandatory)
- * @fdef: prints additional attributes specific to this mode (if any)
- * @add: updates a data area for a statistic fed incremental data (mandatory)
- * @set: updates a data area for a statistic fed total numbers (mandatory)
- * @name: pointer to name string (mandatory)
- * @size: base size for a data area (passed to alloc function)
- *
- * Struct statistic_discipline describes a statistic infrastructure internal
- * programming interface. Another data processing mode can be added by
- * implementing these routines and appending an entry to the
- * statistic_discs array.
- *
- * "Data area" in te above description usually means a chunk of memory,
- * may it be allocated for data gathering per CPU, or be shared by all
- * CPUs, or used for other purposes, like merging per-CPU data when
- * users read data from files. Implementers of data processing modes
- * don't need to worry about the designation of a particular chunk of memory.
- * A data area of a data processing mode always has to look the same.
- */
-struct statistic_discipline {
-	int (*parse)(struct statistic * stat, struct statistic_info *info,
-		     int type, char *def);
-	void *(*alloc)(struct statistic *stat, size_t size, int node);
-	void (*free)(struct statistic *stat, void *ptr);
-	void (*reset)(struct statistic *stat, void *ptr);
-	void (*merge)(struct statistic *stat, void *dst, void *src);
-	int (*fdata)(struct statistic *stat, const char *name,
-		     struct statistic_file_private *fpriv, void *data);
-	int (*fdef)(struct statistic *stat, char *line);
-	void (*add)(struct statistic *stat, int cpu, s64 value, u64 incr);
-	void (*set)(struct statistic *stat, s64 value, u64 total);
-	char *name;
-	size_t size;
-};
-
-struct statistic_entry_util {
-	u32 res;
-	u32 num;	/* FIXME: better 64 bit; do_div can't deal with it) */
-	s64 acc;
-	s64 min;
-	s64 max;
-};
-
-struct statistic_entry_sparse {
-	struct list_head list;
-	s64 value;
-	u64 hits;
+enum statistic_state {
+	STATISTIC_STATE_INVALID,
+	STATISTIC_STATE_UNCONFIGURED,
+	STATISTIC_STATE_RELEASED,
+	STATISTIC_STATE_OFF,
+	STATISTIC_STATE_ON
 };
 
-struct statistic_sparse_list {
-	struct list_head entry_lh;
-	u32 entries;
-	u32 entries_max;
-	u64 hits_missed;
+enum statistic_type {
+	STATISTIC_TYPE_COUNTER_INC,
+	STATISTIC_TYPE_COUNTER_PROD,
+	STATISTIC_TYPE_UTIL,
+	STATISTIC_TYPE_HISTOGRAM_LIN,
+	STATISTIC_TYPE_HISTOGRAM_LOG2,
+	STATISTIC_TYPE_SPARSE,
+	STATISTIC_TYPE_NONE
 };
 
 /**
@@ -216,6 +99,31 @@
 	} u;
 };
 
+/**
+ * struct statistic_interface - collection of statistics for an entity
+ * @stat: a struct statistic array
+ * @info: a struct statistic_info array describing the struct statistic array
+ * @number: number of entries in both arrays
+ * @pull: an optional function called when user reads data from file
+ * @pull_private: optional data pointer passed to pull function
+ *
+ * Exploiters must setup a struct statistic_interface prior to calling
+ * statistic_create().
+ */
+struct statistic_interface {
+/* private: */
+	struct list_head	 list;
+	struct dentry		*debugfs_dir;
+	struct dentry		*data_file;
+	struct dentry		*def_file;
+/* public: */
+	struct statistic	*stat;
+	struct statistic_info	*info;
+	int			 number;
+	int			(*pull)(void*);
+	void			*pull_private;
+};
+
 #ifdef CONFIG_STATISTICS
 
 extern int statistic_create(struct statistic_interface *, const char *);
@@ -233,6 +141,8 @@
  *
  * This variant takes care of protecting per-cpu data. It is preferred whenever
  * exploiters don't update several statistics of the same entity in one go.
+ *
+ * You may want to use statistic_inc() for (X, 1) data pairs.
  */
 static inline void statistic_add(struct statistic *stat, int i,
 				 s64 value, u64 incr)
@@ -256,6 +166,8 @@
  *
  * This variant leaves protecting per-cpu data to exploiters. It is preferred
  * whenever exploiters update several statistics of the same entity in one go.
+ *
+ * You may want to use statistic_inc_nolock() for (X, 1) data pairs.
  */
 static inline void statistic_add_nolock(struct statistic *stat, int i,
 					s64 value, u64 incr)
@@ -264,50 +176,15 @@
 		stat[i].add(&stat[i], smp_processor_id(), value, incr);
 }
 
-/**
- * statistic_inc - update statistic with incremental data in (X, 1) pair
- * @stat: struct statistic array
- * @i: index of statistic to be updated
- * @value: X
- *
- * The actual processing of the (X, Y) data pair is determined by the current
- * definition applied to the statistic. See Documentation/statistics.txt.
- *
- * This variant takes care of protecting per-cpu data. It is preferred whenever
- * exploiters don't update several statistics of the same entity in one go.
- */
-static inline void statistic_inc(struct statistic *stat, int i, s64 value)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	if (stat[i].state == STATISTIC_STATE_ON)
-		stat[i].add(&stat[i], smp_processor_id(), value, 1);
-	local_irq_restore(flags);
-}
-
-/**
- * statistic_inc_nolock - update statistic with incremental data in (X, 1) pair
- * @stat: struct statistic array
- * @i: index of statistic to be updated
- * @value: X
- *
- * The actual processing of the (X, Y) data pair is determined by the current
- * definition applied to the statistic. See Documentation/statistics.txt.
- *
- * This variant leaves protecting per-cpu data to exploiters. It is preferred
- * whenever exploiters update several statistics of the same entity in one go.
- */
-static inline void statistic_inc_nolock(struct statistic *stat, int i,
-					s64 value)
-{
-	if (stat[i].state == STATISTIC_STATE_ON)
-		stat[i].add(&stat[i], smp_processor_id(), value, 1);
-}
-
 extern void statistic_set(struct statistic *, int, s64, u64);
 
 #else /* CONFIG_STATISTICS */
 
+/*
+ * Providing such NOP-functions we unburden exploiters from paying attention
+ * to CONFIG_STATISTICS.
+ */
+
 static inline int statistic_create(struct statistic_interface *interface,
 				   const char *name)
 {
@@ -330,15 +207,6 @@
 {
 }
 
-static inline void statistic_inc(struct statistic *stat, int i, s64 value)
-{
-}
-
-static inline void statistic_inc_nolock(struct statistic *stat, int i,
-					s64 value)
-{
-}
-
 static inline void statistic_set(struct statistic *stat, int i,
 				 s64 value, u64 total)
 {
@@ -346,4 +214,10 @@
 
 #endif /* CONFIG_STATISTICS */
 
+#define statistic_inc(stat, i, value) \
+	statistic_add(stat, i, value, 1)
+
+#define statistic_inc_nolock(stat, i, value) \
+	statistic_add_nolock(stat, i, value, 1)
+
 #endif /* STATISTIC_H */
--- a/lib/Kconfig.statistic	4 May 2006 16:20:55 -0000	1.6
+++ b/lib/Kconfig.statistic	16 Jun 2006 14:30:46 -0000	1.8
@@ -2,10 +2,10 @@
 	bool "Statistics infrastructure"
 	depends on DEBUG_FS
 	help
-	  The statistics infrastructure provides a debug-fs based user interface
-	  for statistics of kernel components, that is, usually device drivers.
-	  Statistics are available for components that have been instrumented to
-	  feed data into the statistics infrastructure.
+	  The statistics infrastructure provides a debugfs based user interface
+	  for statistics of kernel components. Statistics are available for
+	  components that have been instrumented to feed data into the
+	  statistics infrastructure.
 	  This feature is useful for performance measurements or performance
 	  debugging.
 	  If in doubt, say "N".
--- a/Documentation/statistics.txt	18 May 2006 14:36:26 -0000	1.10
+++ b/Documentation/statistics.txt	16 Jun 2006 22:49:17 -0000	1.12
@@ -590,6 +590,15 @@
 
 stat is an array of N statistics of various sorts.
 
+An enum that helps addressing individual statistics of an array comes in handy:
+
+  enum my_entitiy_stat_num {
+	  MY_ENTITY_STAT_REFUND,
+	  MY_ENTITY_STAT_FILL,
+	  ...
+	  N
+  };
+
 Since one might want to create several instances of struct my_entity
 each coming with its own set of statistics (stat[N]) setup using the
 same template, provisions for such a template have been made as part of the
@@ -597,20 +606,22 @@
 array of struct statistic.
 
   struct statistic_info[] {
-	  { "refund", "cent", "bottle", 0, "type=counter_prod" },
-	  { "fill_level", "millilitre", "bottle", 1, "type=utilisation" },
+	  { /* MY_ENTITY_STAT_REFUND */
+		  .name     = "refund",
+		  .x_unit   = "cent",
+		  .y_unit   = "bottle",
+		  .defaults = "type=counter_prod"
+	  },
+	  { /* MY_ENTITY_STAT_FILL */
+		  .name     = "fill_level",
+		  .x_unit   = "millilitre",
+		  .y_unit   = "bottle",
+		  .flags    = STATISTIC_FLAGS_NOINCR,
+		  .defaults = "type=utilisation"
+	  },
 	  ...
   } my_entity_stat_info;
 
-An enum that helps addressing individual statistics of an array comes in handy:
-
-  enum my_entitiy_stat_num {
-	  MY_ENTITY_STAT_REFUND,
-	  MY_ENTITY_STAT_FILL,
-	  ...
-	  N
-  };
-
 Now, here is how to tie the knot for statistics and templates:
 
   {
--- a/drivers/s390/scsi/zfcp_ccw.c	12 May 2006 09:37:33 -0000	1.65
+++ b/drivers/s390/scsi/zfcp_ccw.c	16 Jun 2006 23:37:12 -0000	1.68
@@ -134,13 +134,29 @@
 
 static struct statistic_info zfcp_statinfo_a[] = {
 	{ /* ZFCP_STAT_A_QOF */
-	  "qdio_outb_full", "sbals_left", "", 0, "type=counter_inc" },
+		.name	  = "qdio_outb_full",
+		.x_unit	  = "sbals_left",
+		.y_unit	  = "",
+		.defaults = "type=counter_inc"
+	},
 	{ /* ZFCP_STAT_A_QO */
-	  "qdio_outb", "sbals_used", "", 0, "type=utilisation" },
+		.name	  = "qdio_outb",
+		.x_unit	  = "sbals_used",
+		.y_unit	  = "",
+		.defaults = "type=utilisation"
+	},
 	{ /* ZFCP_STAT_A_QI */
-	  "qdio_inb", "sbals_used", "", 0, "type=utilisation" },
+		.name	  = "qdio_inb",
+		.x_unit	  = "sbals_used",
+		.y_unit	  = "",
+		.defaults = "type=utilisation"
+	},
 	{ /* ZFCP_STAT_A_ERP */
-	  "erp", "", "", 0, "type=counter_inc" }
+		.name	  = "erp",
+		.x_unit	  = "",
+		.y_unit	  = "",
+		.defaults = "type=counter_inc"
+	}
 };
 
 /**


