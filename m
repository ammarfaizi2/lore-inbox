Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVBOTrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVBOTrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVBOTrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:47:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15295 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261840AbVBOTiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:38:52 -0500
Date: Tue, 15 Feb 2005 13:34:21 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: pwil3058@bigpond.net.au
Subject: [ANNOUNCE 1/4] Genetic-lib version 0.2
Message-Id: <20050215133421.316dcaa3.moilanen@austin.ibm.com>
In-Reply-To: <20050215132906.33f88505.moilanen@austin.ibm.com>
References: <20050215132906.33f88505.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the base patch for the genetic-library.

It includes generic routines for modifying and manipulating genes of
children.  If a specific routine is needed, that can be used instead.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>


Change Log
0.2	1/12/2004
- Added ability to run multiple fitness functions that work on
  specific genes by using phenotypes.
- Added a post calc fitness to use for normalization of various
  fitness routines.
- Restructured /proc tree.
- Made a separate snapshot call instead of doing it in set_genes.
- Rework the mutation code, to do it as a rate of the total number of
  genes instead of an arbitrary number.

0.1	1/7/2004
- Added ability for mutates to take iterative steps.
- Moved debug info to a /proc file.
- Added a mutate_rate_change.  The rate of mutation will increase when
fitness goes down.  Hopefully allowing it to optimize for new workloads.
- Added a boot option for disabling the genetic lib.
- Had it randomly determined which parent a gene came from.

---


diff -puN fs/proc/proc_misc.c~genetic-lib fs/proc/proc_misc.c
--- linux-2.6.10/fs/proc/proc_misc.c~genetic-lib	Fri Jan 28 15:49:40 2005
+++ linux-2.6.10-moilanen/fs/proc/proc_misc.c	Tue Feb 15 12:06:49 2005
@@ -38,6 +38,7 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/genetic.h>
 #include <linux/profile.h>
 #include <linux/blkdev.h>
 #include <linux/hugetlb.h>
@@ -238,6 +239,97 @@ static int meminfo_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
 }
+
+#ifdef CONFIG_GENETIC_LIB
+extern struct proc_dir_entry * genetic_root_dir;
+
+int genetic_read_proc(char *page, char **start, off_t off,
+			  int count, int *eof, void *data)
+{
+    int n = 0;
+    genetic_t * genetic = (genetic_t *)data;
+    
+    struct list_head * p;
+    phenotype_t * pt;
+
+
+    n  = sprintf(page,   "%s:\n", genetic->name);
+    n += sprintf(page+n, "generation_number:\t\t%ld\n", genetic->generation_number);
+    n += sprintf(page+n, "num_children:\t\t\t%ld\n", genetic->num_children);
+    n += sprintf(page+n, "child_life_time:\t\t%ld\n\n", genetic->child_life_time);
+    n += sprintf(page+n, "child_number:\t\t\t%ld\n\n", genetic->child_number);
+
+    n += sprintf(page+n, "Phenotypes Average Fitness\n");
+
+    list_for_each(p, &genetic->phenotype) {
+	    pt = list_entry(p, phenotype_t, phenotype);
+	    
+	    n += sprintf(page+n, "%-24s:\t\t%lld\n", pt->name, pt->avg_fitness);
+    }
+    
+    return proc_calc_metrics(page, start, off, count, eof, n);
+}
+
+int genetic_phenotype_read_proc(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+    int i;
+    int n = 0;
+    phenotype_t * pt = (phenotype_t *)data;
+
+    n = sprintf(page,    "------ %s -----\n", pt->name);	    
+    n += sprintf(page+n, "generation_number:\t%ld\n", pt->genetic->generation_number);
+    n += sprintf(page+n, "num_children:\t\t%ld\n\n", pt->num_children);
+    n += sprintf(page+n, "child_number:\t\t%ld\n", pt->child_number);
+    n += sprintf(page+n, "mutation_rate:\t\t%ld\n", pt->mutation_rate);
+    n += sprintf(page+n, "num_mutations:\t\t%ld\n", pt->num_mutations);
+    n += sprintf(page+n, "num_genes:\t\t%ld\n", pt->num_genes);
+    n += sprintf(page+n, "uid:\t\t\t%ld\n", pt->uid);
+    n += sprintf(page+n, "avg_fitness:\t\t%lld\n", pt->avg_fitness);
+    n += sprintf(page+n, "last_gen_avg_fitness:\t%lld\n", pt->last_gen_avg_fitness);
+
+    n += sprintf(page+n, "\nFitness history\n");
+
+    for (i = pt->genetic->generation_number > GENETIC_HISTORY_SIZE ? GENETIC_HISTORY_SIZE
+		 : pt->genetic->generation_number-1; i > 0; i--)
+	    n += sprintf(page+n, "%ld:\t%lld\n",
+			 pt->genetic->generation_number - i,
+			 pt->fitness_history[(pt->fitness_history_index - i) & GENETIC_HISTORY_MASK]);
+
+    return proc_calc_metrics(page, start, off, count, eof, n);
+}
+
+#if GENETIC_DEBUG
+int genetic_debug_read_proc(char *page, char **start, off_t off,
+			    int count, int *eof, void *data)
+{
+	int i, j, k;
+	int n = 0;
+	phenotype_t * pt = (phenotype_t *)data;
+    
+	n = sprintf(page, "generation_number:\t%ld\n", pt->genetic->generation_number);
+	
+	for (i = 0, j = 1; i < pt->debug_size; j++) {
+		/* print out child number, and ID */
+		n += sprintf(page+n, "%d (%lld):", j, pt->debug_history[i++]);
+		/* print out child fitness */
+		n += sprintf(page+n, " %-12lld:\t", pt->debug_history[i++]);
+
+		for (k = 0; k < pt->child_ranking[0]->num_genes; k++) {
+			n += sprintf(page+n, "%lld\t", pt->debug_history[i++]);
+		}
+		n += sprintf(page+n, "\n");
+
+		if (j == pt->num_children) {
+			n += sprintf(page+n, "\n");
+			j = 0;
+		}
+	}
+
+	return proc_calc_metrics(page, start, off, count, eof, n);
+}
+#endif /* GENETIC_DEBUG */
+#endif /* CONFIG_GENETIC_LIB */
 
 extern struct seq_operations fragmentation_op;
 static int fragmentation_open(struct inode *inode, struct file *file)
diff -puN /dev/null include/linux/genetic.h
--- /dev/null	Fri Mar 14 06:52:15 2003
+++ linux-2.6.10-moilanen/include/linux/genetic.h	Wed Feb  2 16:26:35 2005
@@ -0,0 +1,232 @@
+#ifndef __LINUX_GENETIC_H
+#define __LINUX_GENETIC_H
+/*
+ * include/linux/genetic.h
+ *
+ * Jake Moilanen <moilanen@austin.ibm.com>
+ * Copyright (C) 2004 IBM
+ *
+ * Genetic algorithm library
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+
+
+#define GENETIC_HISTORY_SIZE		0x8
+#define GENETIC_HISTORY_MASK		(GENETIC_HISTORY_SIZE - 1)
+
+/* percentage of total number genes to mutate */
+#define GENETIC_DEFAULT_MUTATION_RATE 	15
+
+/* XXX TODO Make this an adjustable runtime variable */
+/* Percentage that an iteration can jump within the range */
+#define GENETIC_ITERATIVE_MUTATION_RANGE 30
+
+/* the rate that GENETIC_DEFAULT_MUTATION_RATE itself can change */
+#define GENETIC_DEFAULT_MUTATION_RATE_CHANGE 4
+#define GENETIC_MAX_MUTATION_RATE	45
+#define GENETIC_MIN_MUTATION_RATE	10
+
+#define GENETIC_DEBUG			1
+#define GENETIC_NUM_DEBUG_POINTS	4
+
+#define GENETIC_PRINT_DEBUG		0
+#define gen_dbg(format, arg...) do { if (GENETIC_PRINT_DEBUG) printk(KERN_EMERG __FILE__ ": " format "\n" , ## arg); } while (0)
+#define gen_trc(format, arg...) do { if (GENETIC_PRINT_DEBUG) printk(KERN_EMERG __FILE__ ":%s:%d\n" , __FUNCTION__, __LINE__); } while (0)
+
+struct gene_param_s;
+struct genetic_s;
+struct phenotype_s;
+
+struct genetic_child_s {
+	struct list_head 	list;
+	long long		fitness;
+	unsigned long		num_genes;
+	void			*genes;
+	struct gene_param_s	*gene_param;
+	void			*stats_snapshot;
+	int 			id;
+};
+
+typedef struct genetic_child_s genetic_child_t;
+
+/* Here's a generic idea of what it the genes could look like */
+struct gene_param_s {
+	unsigned long	min;
+	unsigned long	max;
+	unsigned long	initial;
+	void	 	(*mutate_gene)(genetic_child_t *, unsigned long);
+};
+
+typedef struct gene_param_s gene_param_t;
+
+struct phenotype_s {
+	struct list_head	phenotype;
+	
+	struct list_head	children_queue[2];
+	struct list_head	*run_queue;
+	struct list_head	*finished_queue;
+	struct genetic_ops	*ops;
+	
+	char			*name;
+
+	struct genetic_s	*genetic;		/* point back
+							 * to genetic
+							 * struct
+							 */
+	
+	unsigned long 		num_children;		  /* Must be power of 2 */
+	unsigned long		natural_selection_cutoff; /* How many children
+							   * will survive
+							   */
+	void			*stats_snapshot;
+	unsigned long		child_number;
+
+	/* percentage of total number of genes to mutate */
+	long	 		mutation_rate;
+	unsigned long 		num_mutations;
+	unsigned long		num_genes;
+    
+	genetic_child_t 	**child_ranking;
+	
+	void 			(*natural_selection)(struct phenotype_s *);
+    
+	/* This UID is bitmap comprised of other phenotypes that contribute
+	   to the genes */
+	unsigned long		uid;	       
+
+	/* performance metrics */
+	long long		avg_fitness;
+	long long		last_gen_avg_fitness;
+	
+	unsigned long		fitness_history_index;
+	long long		fitness_history[GENETIC_HISTORY_SIZE];
+
+#if GENETIC_DEBUG
+	unsigned long		debug_size;	/* number of longs in
+						   debug history */
+	unsigned long		debug_index;
+	long long		*debug_history;
+#endif	
+};
+
+typedef struct phenotype_s phenotype_t;
+
+struct genetic_s {
+	char 			*name;
+	struct timer_list	timer;
+
+	struct list_head	phenotype;
+
+	unsigned long		child_number;
+	unsigned long		child_life_time;
+	unsigned long 		num_children;		  /* Must be power of 2 */
+
+	struct proc_dir_entry   *dir;
+	struct proc_dir_entry   *debug_dir;
+	unsigned long		generation_number;
+
+};
+
+typedef struct genetic_s genetic_t;
+
+struct genetic_ops {
+	void			(*create_child)(genetic_child_t *);
+	void			(*set_child_genes)(void *);
+	void			(*calc_fitness)(genetic_child_t *);
+	void 			(*combine_genes)(genetic_child_t *, genetic_child_t *,
+						 genetic_child_t *);
+	void			(*mutate_child)(genetic_child_t *);
+	void			(*calc_post_fitness)(phenotype_t *); /* Fitness routine used when
+								      * need to take into account
+								      * other phenotype fitness
+								      * results after they ran
+								      */
+	void			(*take_snapshot)(phenotype_t *);
+	void			(*shift_mutation_rate)(phenotype_t *);
+};
+
+/* Setup routines */
+int __init genetic_init(genetic_t ** in_genetic, unsigned long num_children,
+			unsigned long child_life_time,
+			char * name);
+int __init genetic_register_phenotype(genetic_t * genetic, struct genetic_ops * ops,
+				      unsigned long num_children, char * name,
+				      unsigned long num_genes, unsigned long uid);
+void __init genetic_start(genetic_t * genetic);
+
+/* Generic helper functions */
+void genetic_generic_mutate_child(genetic_child_t * child);
+void genetic_generic_iterative_mutate_gene(genetic_child_t * child, long gene_num);
+void genetic_generic_combine_genes(genetic_child_t * parent_a,
+				   genetic_child_t * parent_b,
+				   genetic_child_t * child);
+void genetic_create_child_spread(genetic_child_t * child, unsigned long num_children);
+void genetic_create_child_defaults(genetic_child_t * child);
+void genetic_general_shift_mutation_rate(phenotype_t * in_pt);
+
+#if BITS_PER_LONG >= 64
+
+static inline void divll(long long *n, long div, long *rem)
+{
+        *rem = *n % div;
+        *n /= div;
+}
+
+#else
+
+static inline void divl(int32_t high, int32_t low,
+                        int32_t div,
+                        int32_t *q, int32_t *r)
+{
+        int64_t n = (u_int64_t)high << 32 | low;
+        int64_t d = (u_int64_t)div << 31;
+        int32_t q1 = 0;
+        int c = 32;
+        while (n > 0xffffffff) {
+                q1 <<= 1;
+                if (n >= d) {
+                        n -= d;
+                        q1 |= 1;
+                }
+                d >>= 1;
+                c--;
+        }
+        q1 <<= c;
+        if (n) {
+                low = n;
+                *q = q1 | (low / div);
+                *r = low % div;
+        } else {
+                *r = 0;
+                *q = q1;
+        }
+        return;
+}
+
+static inline void divll(long long *n, long div, long *rem)
+{
+        int32_t low, high;
+        low = *n & 0xffffffff;
+        high = *n >> 32;
+        if (high) {
+                int32_t high1 = high % div;
+                int32_t low1 = low;
+                high /= div;
+                divl(high1, low1, div, &low, (int32_t *)rem);
+                *n = (int64_t)high << 32 | low;
+        } else {
+                *n = low / div;
+                *rem = low % div;
+        }
+}
+#endif
+
+#endif
diff -puN lib/Kconfig~genetic-lib lib/Kconfig
--- linux-2.6.10/lib/Kconfig~genetic-lib	Fri Jan 28 15:49:40 2005
+++ linux-2.6.10-moilanen/lib/Kconfig	Tue Feb 15 12:06:46 2005
@@ -30,6 +30,12 @@ config LIBCRC32C
 	  require M here.  See Castagnoli93.
 	  Module will be libcrc32c.
 
+config GENETIC_LIB
+	bool "Genetic Library"
+	help
+	  This option will build in a genetic library that will tweak
+	  kernel parameters autonomically to improve performance.
+
 #
 # compression support is select'ed if needed
 #
diff -puN lib/Makefile~genetic-lib lib/Makefile
--- linux-2.6.10/lib/Makefile~genetic-lib	Fri Jan 28 15:49:40 2005
+++ linux-2.6.10-moilanen/lib/Makefile	Fri Jan 28 15:49:40 2005
@@ -23,6 +23,7 @@ endif
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
+obj-$(CONFIG_GENETIC_LIB) += genetic.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff -puN /dev/null lib/genetic.c
--- /dev/null	Fri Mar 14 06:52:15 2003
+++ linux-2.6.10-moilanen/lib/genetic.c	Wed Feb  2 16:34:07 2005
@@ -0,0 +1,734 @@
+/*
+ * Genetic Algorithm Library
+ *
+ * Jake Moilanen <moilanen@austin.ibm.com>
+ * Copyright (C) 2004 IBM
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * Life cycle
+ * 
+ * 1.) Create random children
+ * 2.) Run tests
+ * 3.) Calculate fitness
+ * 4.) Take top preformers
+ * 5.) Make children
+ * 6.) Mutate
+ * 7.) Goto step 2
+ */
+
+#include <linux/genetic.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/random.h>
+
+#include <asm/uaccess.h>
+#include <asm/string.h>
+#include <asm/bug.h>
+
+char genetic_lib_version[] = "0.2";
+
+int mutation_rate_change = GENETIC_DEFAULT_MUTATION_RATE_CHANGE;
+int genetic_lib_enabled = 1;
+
+static void genetic_ns_top_parents(phenotype_t *);
+static void genetic_ns_award_top_parents(phenotype_t *);
+static int  genetic_create_children(phenotype_t *);
+static void genetic_split_performers(phenotype_t *);
+static void genetic_mutate(phenotype_t *);
+static void genetic_run_child(genetic_t * genetic);
+static void genetic_new_generation(genetic_t * genetic);
+
+void genetic_switch_child(unsigned long data);
+struct proc_dir_entry * genetic_root_dir = 0;
+
+extern int genetic_read_proc(char *page, char **start, off_t off,
+		      int count, int *eof, void *data);
+extern int genetic_phenotype_read_proc(char *page, char **start, off_t off,
+		      int count, int *eof, void *data);
+
+#if GENETIC_DEBUG
+extern int genetic_debug_read_proc(char *page, char **start, off_t off,
+		      int count, int *eof, void *data);
+#endif
+
+
+int __init genetic_init(genetic_t ** in_genetic, unsigned long num_children,
+			unsigned long child_life_time,
+			char * name)
+{
+    struct proc_dir_entry *entry;
+    genetic_t * genetic;
+
+    if (!genetic_lib_enabled)
+	    return 0;
+
+    printk(KERN_INFO "Initializing Genetic Library - version %s\n", genetic_lib_version);
+
+    genetic = (genetic_t *)kmalloc(sizeof(genetic_t), GFP_KERNEL);
+    if (!genetic) {
+	    printk(KERN_ERR "genetic_init: not enough memory\n");
+	    return -ENOMEM;
+    }
+
+    *in_genetic = genetic;
+
+    genetic->name = (char *)kmalloc(strlen(name), GFP_KERNEL);
+    if (!genetic->name) {
+	    printk(KERN_ERR "genetic_init: not enough memory\n");
+	    kfree(genetic);
+	    return -ENOMEM;
+    }
+
+    /* Init some of our values */
+    strcpy(genetic->name, name);
+
+    genetic->num_children = num_children;
+    genetic->child_life_time = child_life_time;
+
+    genetic->generation_number = 1;
+    genetic->child_number = 0;
+
+    /* Setup how long each child has to live */
+    init_timer(&genetic->timer);
+    genetic->timer.function = genetic_switch_child;
+    genetic->timer.data = (unsigned long)genetic;
+
+#ifdef CONFIG_PROC_FS
+    /* Setup proc structure to monitor */
+    if (!genetic_root_dir)
+	    genetic_root_dir = proc_mkdir("genetic", 0);
+
+    genetic->dir = proc_mkdir(name, genetic_root_dir);
+
+    entry = create_proc_entry("stats", 0644, genetic->dir);
+
+    if (entry) {
+	    entry->nlink = 1;
+	    entry->data = genetic;
+	    entry->read_proc = genetic_read_proc;
+    }
+
+#ifdef GENETIC_DEBUG
+    genetic->debug_dir = proc_mkdir("debug", genetic->dir);
+#endif /* GENETIC_DEBUG */
+
+
+#endif /* CONFIG_PROC_FS */
+
+    INIT_LIST_HEAD(&genetic->phenotype);
+    
+    return 0;
+}
+
+int __init genetic_register_phenotype(genetic_t * genetic, struct genetic_ops * ops,
+				      unsigned long num_children, char * name,
+				      unsigned long num_genes, unsigned long uid)
+{
+	struct proc_dir_entry *entry;
+	phenotype_t * pt;
+	int rc;
+	
+	if (!genetic_lib_enabled)
+		return 0;
+
+	printk(KERN_INFO "Initializing %s's phenotype %s\n", genetic->name, name);
+
+	pt = (phenotype_t *)kmalloc(sizeof(phenotype_t), GFP_KERNEL);
+	if (!genetic) {
+		printk(KERN_ERR "genetic_register_phenotype: not enough memory\n");
+		return -ENOMEM;
+	}
+
+	pt->name = (char *)kmalloc(strlen(name), GFP_KERNEL);
+	if (!pt->name) {
+		printk(KERN_ERR "genetic_register_phenotype: not enough memory\n");
+		kfree(pt);
+		return -ENOMEM;
+	}
+
+	pt->child_ranking = (genetic_child_t **)kmalloc(num_children * sizeof(genetic_child_t *), GFP_KERNEL);
+	if (!pt->child_ranking) {
+		printk(KERN_ERR "genetic_register_phenotype: not enough memory\n");
+		kfree(pt->name);
+		kfree(pt);
+		return -ENOMEM;
+	}
+
+	strcpy(pt->name, name);
+    
+	INIT_LIST_HEAD(&pt->children_queue[0]);
+	INIT_LIST_HEAD(&pt->children_queue[1]);
+
+	pt->run_queue = &pt->children_queue[0];
+	pt->finished_queue = &pt->children_queue[1];    
+	
+	pt->ops = ops;
+	pt->num_children = num_children;
+	
+	pt->mutation_rate = GENETIC_DEFAULT_MUTATION_RATE;
+	pt->natural_selection = genetic_ns_top_parents;
+	pt->natural_selection_cutoff = num_children / 2;
+	pt->avg_fitness = 0;
+	pt->last_gen_avg_fitness = 0;    
+	pt->child_number = 0;
+	
+	pt->genetic = genetic;
+	pt->uid = uid;
+	pt->num_genes = num_genes;
+	
+	/* Create some children */
+	rc = genetic_create_children(pt);
+	if (rc)
+		return rc;
+	
+#ifdef CONFIG_PROC_FS
+	entry = create_proc_entry(name, 0644, genetic->dir);
+
+	if (entry) {
+		entry->nlink = 1;
+		entry->data = pt;
+		entry->read_proc = genetic_phenotype_read_proc;
+	}
+	
+#endif	
+
+#if GENETIC_DEBUG
+	pt->debug_index = 0;
+	/* create array for history.  The +2 on num_genes is for the
+	   fitness and child id */
+	pt->debug_size = num_children * (num_genes + 2) * GENETIC_NUM_DEBUG_POINTS;
+
+	pt->debug_history = (long long *) kmalloc(pt->debug_size * sizeof(long long), GFP_KERNEL);
+
+#ifdef CONFIG_PROC_FS
+	entry = create_proc_entry(name, 0644, genetic->debug_dir);
+
+	if (entry) {
+		entry->nlink = 1;
+		entry->data = pt;
+		entry->read_proc = genetic_debug_read_proc;
+	}
+
+#endif /* CONFIG_PROC_FS */
+#endif /* GENETIC_DEBUG */
+
+
+	list_add_tail(&pt->phenotype, &genetic->phenotype);
+	
+	return 0;
+}
+
+void __init genetic_start(genetic_t * genetic)
+{
+	if (!genetic_lib_enabled)
+		return;
+	
+	genetic_run_child(genetic);
+	printk(KERN_INFO "%ld children started in %s genetic library\n", genetic->num_children, genetic->name);
+}
+	    
+
+
+/* create some children, it is up to the lib user to come up w/ a good
+   distro of genes for it's children */
+static int genetic_create_children(phenotype_t * pt)
+{
+    unsigned long i;
+    genetic_child_t * child;
+
+    for (i = 0; i < pt->num_children; i++) {
+	    pt->child_ranking[i] = (genetic_child_t *)kmalloc(sizeof(genetic_child_t), GFP_KERNEL);
+	    if (!pt->child_ranking[i]) {
+		    printk(KERN_ERR "genetic_create_child: not enough memory\n");
+		    for (i = i - 1; i >= 0; i--)
+			    kfree(pt->child_ranking[i]);
+
+		    return -ENOMEM;
+	    }
+
+	    child = pt->child_ranking[i];
+
+	    child->id = i;
+
+	    pt->ops->create_child(child);
+
+	    list_add_tail(&child->list, pt->run_queue);
+    }
+
+    return 0;
+}
+
+/* See how well child did and run the next one */
+void genetic_switch_child(unsigned long data)
+{
+    genetic_t * genetic = (genetic_t *)data;
+    genetic_child_t * child;
+
+    struct list_head * p;
+    phenotype_t * pt;
+
+    int new_generation = 0;
+
+    list_for_each(p, &genetic->phenotype) {
+	    pt = list_entry(p, phenotype_t, phenotype);
+	    
+	    child = list_entry(pt->run_queue->next, genetic_child_t, list);
+
+	    list_del(&child->list);
+
+	    list_add_tail(&child->list, pt->finished_queue);
+
+	    if (pt->ops->calc_fitness) 
+		    pt->ops->calc_fitness(child);
+
+	    pt->child_ranking[pt->child_number++] = child;
+
+	    /* See if need more children */
+	    if (list_empty(pt->run_queue)) 
+		    new_generation = 1;
+    }
+
+    genetic->child_number++;
+
+    if (new_generation)
+	    genetic_new_generation(genetic);
+
+    genetic_run_child(genetic);
+
+}
+
+/* Set the childs genes for run */
+void genetic_run_child(genetic_t * genetic)
+{
+    struct list_head * p;
+    phenotype_t * pt;
+
+    genetic_child_t * child;
+    void * genes;
+
+    list_for_each(p, &genetic->phenotype) {
+	    pt = list_entry(p, phenotype_t, phenotype);
+	    
+	    child = list_entry(pt->run_queue->next, genetic_child_t, list);
+
+	    genes = child->genes;
+
+	    if (pt->ops->set_child_genes)
+		    pt->ops->set_child_genes(genes);
+
+	    if (pt->ops->take_snapshot)
+		    pt->ops->take_snapshot(pt);
+    }
+
+    /* set a timer interrupt */
+    genetic->timer.expires = jiffies + genetic->child_life_time;
+    add_timer(&genetic->timer);
+
+}
+
+/* This natural selection routine will take the top
+ * natural_select_cutoff and use them to make children for the next
+ * generation and keep the top half perfomers
+ *
+ * This assumes natural_select_cutoff is exactly half of num_children
+ * and num_children is a multable of 4.
+ */
+static void genetic_ns_top_parents(phenotype_t * pt)
+{
+    unsigned long i,j,k = 0;
+    unsigned long num_children = pt->num_children;
+    unsigned long cutoff = num_children - pt->natural_selection_cutoff;
+
+    for (i = cutoff, j = num_children - 1; i < j; i++, j--, k += 2) {
+	/* create child A */
+	pt->ops->combine_genes(pt->child_ranking[i],
+				    pt->child_ranking[j],
+				    pt->child_ranking[k]);
+	
+	/* create child B */
+	pt->ops->combine_genes(pt->child_ranking[i],
+				    pt->child_ranking[j],
+				    pt->child_ranking[k+1]);
+    }
+}
+
+/* This natural selection routine just has top parents populating
+   bottom performers. */
+static void genetic_ns_award_top_parents(phenotype_t * pt)
+{
+	unsigned long i;
+	unsigned long num_children = pt->num_children;
+	unsigned long cutoff = num_children - pt->natural_selection_cutoff;
+	
+	for (i = 0; i < cutoff; i += 2) {
+		pt->ops->combine_genes(pt->child_ranking[num_children - 1],
+					    pt->child_ranking[num_children - 2],
+					    pt->child_ranking[i]);
+
+		pt->ops->combine_genes(pt->child_ranking[num_children - 1],
+					    pt->child_ranking[num_children - 2],
+					    pt->child_ranking[i+1]);
+	}
+}
+
+static inline void genetic_swap(genetic_child_t ** a, genetic_child_t ** b)
+{
+    genetic_child_t * tmp = *a;
+
+    *a = *b;
+    *b = tmp;
+}
+
+/* bubble sort */
+/* XXX change this to quick sort */
+static void genetic_split_performers(phenotype_t * pt)
+{
+    int i, j;
+
+    for (i = pt->num_children; i > 1; i--)
+	for (j = 0; j < i - 1; j++)
+	    if (pt->child_ranking[j]->fitness > pt->child_ranking[j+1]->fitness) 
+		genetic_swap(&pt->child_ranking[j], &pt->child_ranking[j+1]);
+}
+
+static void genetic_mutate(phenotype_t * pt)
+{
+    long child_entry = -1;
+    int i;
+
+    if (!pt->num_genes)
+	    return;
+
+    for (i = 0; i < pt->num_mutations; i++) {
+	get_random_bytes(&child_entry, sizeof(child_entry));
+	child_entry = child_entry % pt->num_children;
+
+	pt->ops->mutate_child(pt->child_ranking[child_entry]);
+    }
+}
+
+/* XXX This will either aid in handling new workloads, or send us on a
+   downward spiral */
+static void genetic_shift_mutation_rate(phenotype_t * pt, long long prev_gen_avg_fitness, long long avg_fitness)
+{ 
+    if (mutation_rate_change && pt->genetic->generation_number > 1) {
+
+	    if (pt->ops->shift_mutation_rate) {
+		    pt->ops->shift_mutation_rate(pt);
+	    } else {
+
+		    if (avg_fitness > prev_gen_avg_fitness)
+			    pt->mutation_rate -= mutation_rate_change;
+		    else if (avg_fitness < prev_gen_avg_fitness)
+			    pt->mutation_rate += mutation_rate_change;
+
+		    if (pt->mutation_rate > GENETIC_MAX_MUTATION_RATE)
+			    pt->mutation_rate = GENETIC_MAX_MUTATION_RATE;
+		    else if (pt->mutation_rate < GENETIC_MIN_MUTATION_RATE)
+			    pt->mutation_rate = GENETIC_MIN_MUTATION_RATE;
+	    }
+    }
+}
+
+void genetic_general_shift_mutation_rate(phenotype_t * in_pt)
+{
+	struct list_head * p;
+	phenotype_t * pt;
+	int count = 0;
+	long rate = 0;
+
+	list_for_each(p, &in_pt->genetic->phenotype) {
+		pt = list_entry(p, phenotype_t, phenotype);
+
+		if (in_pt->uid & pt->uid && in_pt->uid != pt->uid) {
+			rate += pt->mutation_rate;
+			count++;
+		}
+	}
+	
+	/* If we are a general phenotype that is made up of other
+	   phenotypes then we take the average */
+	if (count)
+		in_pt->mutation_rate = (rate / count);
+	else 
+		in_pt->mutation_rate = mutation_rate_change;
+}
+
+static void genetic_calc_stats(phenotype_t * pt)
+{
+	long long total_fitness = 0;
+	long long prev_gen_avg_fitness = pt->last_gen_avg_fitness;
+	long long tmp_fitness;
+	long dummy;
+	int i;
+
+	/* calculate the avg fitness for this generation and avg fitness
+	 * so far */
+	for (i = 0; i < pt->num_children; i++) 
+		total_fitness += pt->child_ranking[i]->fitness;
+
+	pt->last_gen_avg_fitness = total_fitness >> long_log2(pt->num_children);
+
+	/* Mutation rate calibration */
+	genetic_shift_mutation_rate(pt, prev_gen_avg_fitness, pt->last_gen_avg_fitness);
+
+	pt->num_mutations = ((pt->num_children * pt->num_genes) * pt->mutation_rate) / 100;
+
+	/* calc new avg fitness */
+        tmp_fitness = pt->last_gen_avg_fitness - pt->avg_fitness;
+        divll(&tmp_fitness, pt->genetic->generation_number, &dummy);
+	pt->avg_fitness += tmp_fitness;
+	
+	pt->fitness_history[pt->fitness_history_index++ & GENETIC_HISTORY_MASK] =
+		pt->last_gen_avg_fitness;
+
+}    
+
+#if GENETIC_DEBUG
+/* Stores attributes into an array in the following format 
+ * child_num fitness gene[0] gene[1] .... gene[num_genes-1]
+ * Add +1 to GENETIC_NUM_DEBUG_POINTS if add another dump_children
+ * call 
+ */
+void dump_children(phenotype_t * pt)
+{
+	int i, j;
+	long * genes;
+	unsigned long debug_size = pt->debug_size;
+
+	for (i = 0; i < pt->num_children; i++) {
+		pt->debug_history[pt->debug_index++ % debug_size] = pt->child_ranking[i]->id;
+		pt->debug_history[pt->debug_index++ % debug_size] = pt->child_ranking[i]->fitness;
+
+		genes = (long *)pt->child_ranking[i]->genes;
+		
+		for (j = 0; j < pt->child_ranking[i]->num_genes; j++) {
+			pt->debug_history[pt->debug_index++ % debug_size] = genes[j];
+		}
+	}
+}
+#else
+void dump_children(genetic_t * genetic) { return; }
+#endif
+
+void genetic_new_generation(genetic_t * genetic)
+{
+	struct list_head * tmp;
+
+	struct list_head * p;
+	phenotype_t * pt;
+
+	list_for_each(p, &genetic->phenotype) {
+		pt = list_entry(p, phenotype_t, phenotype);
+
+		/* Check to see if need to recalibrate fitness to take
+		   other phenotypes' rankings into account.  This
+		   should be ran after all phenotypes that have input
+		   have been ran. */
+		if (pt->ops->calc_post_fitness)
+			pt->ops->calc_post_fitness(pt);
+
+		dump_children(pt);
+		
+		/* figure out top performers */
+		genetic_split_performers(pt);
+
+		/* calc stats */
+		genetic_calc_stats(pt);
+
+		dump_children(pt);
+
+		/* make some new children */
+		if (pt->num_genes)
+			pt->natural_selection(pt);
+
+		dump_children(pt);
+		
+		/* mutate a couple of the next generation */
+		genetic_mutate(pt);
+
+		dump_children(pt);
+		
+		/* Move the new children still sitting in the finished queue to
+		   the run queue */
+		tmp = pt->run_queue;
+		pt->run_queue = pt->finished_queue;
+		pt->finished_queue = tmp;
+
+		pt->child_number = 0;
+		pt->debug_index = 0;
+
+	}
+	
+	genetic->child_number = 0;
+	genetic->generation_number++;
+
+}
+
+/* Mutate a gene picking a random value within the gene range */
+void genetic_generic_random_mutate_gene(genetic_child_t * child, long gene_num)
+{
+	unsigned long *genes = (unsigned long *)child->genes;
+	unsigned long min = child->gene_param[gene_num].min;
+	unsigned long max = child->gene_param[gene_num].max;
+	unsigned long gene_value;
+	unsigned long range = max - min + 1;
+
+    	/* create a mutation value */
+	get_random_bytes(&gene_value, sizeof(gene_value));
+
+	gene_value = gene_value % range;
+	
+	genes[gene_num] = min + gene_value;
+}
+
+void genetic_generic_iterative_mutate_gene(genetic_child_t * child, long gene_num)
+{
+	unsigned long *genes = (unsigned long *)child->genes;
+	long min = child->gene_param[gene_num].min;
+	long max = child->gene_param[gene_num].max;
+	long change;
+	long old_value = genes[gene_num];
+	long new_value;
+	unsigned long range = max - min + 1;
+	
+	/* If under 5, random might work better */
+	if (range < 5)
+		return genetic_generic_random_mutate_gene(child, gene_num);
+
+    	/* get the % of change */
+	get_random_bytes(&change, sizeof(change));
+
+	change = change % GENETIC_ITERATIVE_MUTATION_RANGE;
+
+
+	new_value = ((long)(change * range) / (long)100) + old_value;
+
+	if (new_value > max)
+		new_value = max;
+	else if (new_value < min)
+		new_value = min;
+
+	genes[gene_num] = new_value;
+}
+
+/* This assumes that all genes are a unsigned long array of size
+   num_genes */
+void genetic_generic_mutate_child(genetic_child_t * child)
+{
+	long gene_num = -1;
+
+	/* pick a random gene */
+	get_random_bytes(&gene_num, sizeof(gene_num));
+
+	if (gene_num < 0)
+	    gene_num = -gene_num;
+
+	gene_num = gene_num % child->num_genes;
+
+	if (child->gene_param[gene_num].mutate_gene)
+		child->gene_param[gene_num].mutate_gene(child, gene_num);
+	else 
+		genetic_generic_random_mutate_gene(child, gene_num);
+}
+
+void genetic_create_child_defaults(genetic_child_t * child)
+{
+	int i;
+	unsigned long * genes = child->genes;
+	
+	for (i = 0; i < child->num_genes; i++) {
+		genes[i] = child->gene_param[i].initial;
+	}
+}
+
+void genetic_create_child_spread(genetic_child_t * child, unsigned long num_children)
+{
+	int i;
+	unsigned long range;
+	int range_incr;
+	int child_num = child->id;
+	long num_genes = child->num_genes; 
+	unsigned long * genes = child->genes;
+	
+	for (i = 0; i < num_genes; i++) {
+		range = child->gene_param[i].max - child->gene_param[i].min + 1;
+		range_incr = range / num_children;
+		if (range_incr)
+			genes[i] = child->gene_param[i].min +
+				(range_incr * child_num);
+		else
+			genes[i] = child->gene_param[i].min +
+				(child_num / (num_children / range));
+	}
+
+}
+
+/* Randomly pick which parent to use for each gene to create a child */
+void genetic_generic_combine_genes(genetic_child_t * parent_a,
+				   genetic_child_t * parent_b,
+				   genetic_child_t * child)
+{
+	unsigned long * genes_a = (unsigned long *)parent_a->genes;
+	unsigned long * genes_b = (unsigned long *)parent_b->genes;
+	unsigned long * child_genes = (unsigned long *)child->genes;
+
+	/* Assume parent_a and parent_b have same num_genes */
+	unsigned long num_genes = parent_a->num_genes;
+	int parent_selector;
+	int i, j;
+
+	for (i = 0; i < num_genes; i++) {
+		get_random_bytes(&parent_selector, sizeof(parent_selector));
+		
+		/* Look at each bit to determine which parent to use */
+		for (j = 0; j < (sizeof(parent_selector) * 8); j++) {
+			if (parent_selector & 1) {
+				child_genes[i] = genes_a[i];
+			} else {
+				child_genes[i] = genes_b[i];
+			}
+			parent_selector >>= 1;
+		}
+	}
+}
+
+static int __init genetic_boot_setup(char *str)
+{
+	if (strcmp(str, "on") == 0)
+		genetic_lib_enabled = 1;
+	else if (strcmp(str, "off") == 0)
+		genetic_lib_enabled = 0;
+
+	return 1;
+}
+
+
+static int __init genetic_mutation_rate_change_setup(char *str)
+{
+	int i;
+
+	if (get_option(&str,&i)) {
+
+		if (i > GENETIC_MAX_MUTATION_RATE)
+			i = GENETIC_MAX_MUTATION_RATE;
+		else if (i < 0)
+			i = 0;
+		
+		mutation_rate_change = i;
+	}
+
+	return 1;
+
+}
+__setup("genetic=", genetic_boot_setup);
+__setup("genetic_mutate_rate=", genetic_mutation_rate_change_setup);

_
