Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVAFQTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVAFQTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVAFQTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:19:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:49650 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262893AbVAFQR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:17:56 -0500
Date: Thu, 6 Jan 2005 10:14:47 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 1/4][RFC] Genetic Algorithm Library
Message-ID: <20050106101447.5ca4ca56@localhost>
In-Reply-To: <20050106100844.53a762a0@localhost>
References: <20050106100844.53a762a0@localhost>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the base patch for the genetic-library.

It includes generic routines for modifying and manipulating genes of
children.  If a specific routine is needed, that can be used instead.


Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN fs/proc/proc_misc.c~genetic-lib fs/proc/proc_misc.c
--- linux-2.6.9/fs/proc/proc_misc.c~genetic-lib	Wed Jan  5 15:45:54 2005
+++ linux-2.6.9-moilanen/fs/proc/proc_misc.c	Wed Jan  5 15:45:54 2005
@@ -45,6 +45,7 @@
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
 #include <linux/sched_cpustats.h>
+#include <linux/genetic.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -233,6 +234,35 @@ static int meminfo_read_proc(char *page,
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
+    int i;
+    int n = 0;
+    genetic_t * genetic = (genetic_t *)data;
+    
+    n  = sprintf(page,   "generation_number:\t%ld\n", genetic->generation_number);
+    n += sprintf(page+n, "num_children:\t\t%ld\n", genetic->num_children);
+    n += sprintf(page+n, "child_number:\t\t%ld\n", genetic->child_number);
+    n += sprintf(page+n, "num_mutations:\t\t%ld\n", genetic->num_mutations);
+    n += sprintf(page+n, "avg_fitness:\t\t%ld\n", genetic->avg_fitness);
+    n += sprintf(page+n, "last_gen_avg_fitness:\t%ld\n", genetic->last_gen_avg_fitness);
+
+    n += sprintf(page+n, "\nFitness history\n");
+
+    for (i = genetic->generation_number > GENETIC_HISTORY_SIZE ? GENETIC_HISTORY_SIZE
+	     : genetic->generation_number-1; i > 0; i--)
+	n += sprintf(page+n, "generation(%ld):\t%ld\n",
+		     genetic->generation_number - i,
+		     genetic->fitness_history[(genetic->fitness_history_index - i) & GENETIC_HISTORY_MASK]);
+
+    return proc_calc_metrics(page, start, off, count, eof, n);
+}
+#endif
 
 extern struct seq_operations fragmentation_op;
 static int fragmentation_open(struct inode *inode, struct file *file)
diff -puN /dev/null include/linux/genetic.h
--- /dev/null	Fri Mar 14 06:52:15 2003
+++ linux-2.6.9-moilanen/include/linux/genetic.h	Wed Jan  5 15:45:54 2005
@@ -0,0 +1,103 @@
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
+#define GENETIC_DEFAULT_NUM_MUTATIONS 	8
+#define GENETIC_HISTORY_SIZE		0x10
+#define GENETIC_HISTORY_MASK		(GENETIC_HISTORY_SIZE - 1)
+
+#define GENETIC_DEBUG			0
+
+#define gen_dbg(format, arg...) do { if (GENETIC_DEBUG) printk(KERN_EMERG __FILE__ ": " format "\n" , ## arg); } while (0)
+#define gen_trc(format, arg...) do { if (GENETIC_DEBUG) printk(KERN_EMERG __FILE__ ":%s:%d\n" , __FUNCTION__, __LINE__); } while (0)
+
+struct gene_param_s;
+
+struct genetic_child_s {
+	struct list_head 	child;
+	long			fitness;
+	unsigned long		num_genes;
+	void			*genes;
+	struct gene_param_s	*gene_param;
+	void			*stats_snapshot;
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
+struct genetic_s {
+    struct list_head	children_queue[2];
+    struct list_head	*run_queue;
+    struct list_head	*finished_queue;
+    unsigned long	child_life_time;
+    unsigned long 	num_children;		/* Must be power of 2 */
+    unsigned long	natural_selection_cutoff; /* How many children
+						   * will survive
+						   */
+    unsigned long 	num_mutations;
+    
+    void 		(*natural_selection)(struct genetic_s *);
+    
+    char 		*name;
+    struct timer_list	timer;
+    struct genetic_ops	*ops;
+
+    genetic_child_t 	**child_ranking;
+
+    /* performance metrics */
+    long		avg_fitness;
+    long		last_gen_avg_fitness;
+
+    unsigned long	generation_number;
+    unsigned long	child_number;
+
+    unsigned long	fitness_history_index;
+    long		fitness_history[GENETIC_HISTORY_SIZE];
+
+};
+
+typedef struct genetic_s genetic_t;
+
+struct genetic_ops {
+    void		(*create_child)(genetic_child_t *);
+    void		(*set_child_genes)(void *);
+    void		(*calc_fitness)(genetic_child_t *);
+    void 		(*combine_genes)(genetic_child_t *, genetic_child_t *,
+					 genetic_child_t *, genetic_child_t *);
+    void		(*mutate_child)(genetic_child_t *);
+};
+
+extern int __init genetic_init(genetic_t * genetic, struct genetic_ops * ops, unsigned long num_children, unsigned long child_life_time, char * name);
+extern void genetic_generic_mutate_child(genetic_child_t * child);
+extern void genetic_generic_combine_genes(genetic_child_t * parent_a,
+					  genetic_child_t * parent_b,
+					  genetic_child_t * child_a,
+					  genetic_child_t * child_b);
+
+
+#endif
diff -puN lib/Kconfig~genetic-lib lib/Kconfig
--- linux-2.6.9/lib/Kconfig~genetic-lib	Wed Jan  5 15:45:54 2005
+++ linux-2.6.9-moilanen/lib/Kconfig	Wed Jan  5 15:45:54 2005
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
--- linux-2.6.9/lib/Makefile~genetic-lib	Wed Jan  5 15:45:54 2005
+++ linux-2.6.9-moilanen/lib/Makefile	Wed Jan  5 15:45:54 2005
@@ -18,6 +18,7 @@ endif
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
+obj-$(CONFIG_GENETIC_LIB) += genetic.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff -puN /dev/null lib/genetic.c
--- /dev/null	Fri Mar 14 06:52:15 2003
+++ linux-2.6.9-moilanen/lib/genetic.c	Wed Jan  5 15:45:54 2005
@@ -0,0 +1,429 @@
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
+static void genetic_ns_top_parents(genetic_t * genetic);
+static void genetic_ns_award_top_parents(genetic_t * genetic);
+static void genetic_create_children(genetic_t * genetic);
+static void genetic_split_performers(genetic_t * genetic);
+static void genetic_mutate(genetic_t * genetic);
+static void genetic_run_child(genetic_t * genetic);
+static void genetic_new_generation(genetic_t * genetic);
+
+void genetic_switch_child(unsigned long data);
+struct proc_dir_entry * genetic_root_dir = 0;
+extern int genetic_read_proc(char *page, char **start, off_t off,
+		      int count, int *eof, void *data);
+
+int __init genetic_init(genetic_t * genetic, struct genetic_ops * ops,
+			unsigned long num_children, unsigned long child_life_time,
+			char * name)
+{
+    struct proc_dir_entry *entry;
+	    
+    genetic = (genetic_t *)kmalloc(sizeof(genetic_t), GFP_KERNEL);
+    if (!genetic) {
+	printk(KERN_ERR "genetic_init: not enough memory\n");
+	return -ENOMEM;
+    }
+
+    genetic->name = (char *)kmalloc(strlen(name), GFP_KERNEL);
+    if (!genetic->name) {
+	kfree(genetic);
+	return -ENOMEM;
+    }
+
+    genetic->child_ranking = (genetic_child_t **)kmalloc(num_children * sizeof(genetic_child_t *), GFP_KERNEL);
+    if (!genetic->child_ranking) {
+	kfree(genetic->name);
+	kfree(genetic);
+	return -ENOMEM;
+    }
+
+    /* Init some of our values */
+    strcpy(genetic->name, name);
+
+    INIT_LIST_HEAD(&genetic->children_queue[0]);
+    INIT_LIST_HEAD(&genetic->children_queue[1]);
+
+    genetic->run_queue = &genetic->children_queue[0];
+    genetic->finished_queue = &genetic->children_queue[1];    
+
+    genetic->ops = ops;
+    genetic->num_children = num_children;
+    genetic->child_life_time = child_life_time;
+
+    genetic->generation_number = 1;
+    genetic->child_number = 0;
+    genetic->num_mutations = GENETIC_DEFAULT_NUM_MUTATIONS;
+    genetic->natural_selection = genetic_ns_top_parents;
+    genetic->natural_selection_cutoff = num_children / 2;
+    genetic->avg_fitness = 0;
+    genetic->last_gen_avg_fitness = 0;    
+    
+    /* Create some children */
+    genetic_create_children(genetic);
+
+    /* Setup how long each child has to live */
+    init_timer(&genetic->timer);
+    genetic->timer.function = genetic_switch_child;
+    genetic->timer.data = (unsigned long)genetic;
+
+#ifdef CONFIG_PROC_FS
+
+    /* Setup proc structure to monitor */
+    if (!genetic_root_dir)
+	genetic_root_dir = proc_mkdir("genetic", 0);
+
+    entry = create_proc_entry(name, 0644, genetic_root_dir);
+
+    if (entry) {
+	entry->nlink = 1;
+	entry->data = genetic;
+	entry->read_proc = genetic_read_proc;
+    }
+#endif    
+
+    genetic_run_child(genetic);
+
+    printk(KERN_INFO "%ld children started in %s genetic library\n", num_children, name);
+
+    return 0;
+}
+
+/* create some children, it is up to the lib user to come up w/ a good
+   distro of genes for it's children */
+static void genetic_create_children(genetic_t * genetic)
+{
+    unsigned long i;
+    genetic_child_t * child;
+
+    for (i = 0; i < genetic->num_children; i++) {
+	genetic->child_ranking[i] = (genetic_child_t *)kmalloc(sizeof(genetic_child_t), GFP_KERNEL);
+	child = genetic->child_ranking[i];
+
+	genetic->ops->create_child(child);
+
+	list_add_tail(&child->child, genetic->run_queue->next);
+    }
+}
+
+/* See how well child did and run the next one */
+void genetic_switch_child(unsigned long data)
+{
+    genetic_t * genetic = (genetic_t *)data;
+    genetic_child_t * child;
+
+    child = list_entry(genetic->run_queue->next, genetic_child_t, child);
+
+    list_del(&child->child);
+
+    list_add_tail(&child->child, genetic->finished_queue->next);
+
+    genetic->ops->calc_fitness(child);
+
+    genetic->child_ranking[genetic->child_number++] = child;
+
+    /* See if need more children */
+    if (list_empty(genetic->run_queue->next)) 
+	genetic_new_generation(genetic);
+
+    genetic_run_child(genetic);
+}
+
+/* Set the childs genes for run */
+void genetic_run_child(genetic_t * genetic)
+{
+    genetic_child_t * child = list_entry(genetic->run_queue->next, genetic_child_t, child);
+    void * genes = child->genes;
+
+    BUG_ON(!genes);
+
+    genetic->ops->set_child_genes(genes);
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
+static void genetic_ns_top_parents(genetic_t * genetic)
+{
+    unsigned long i,j,k = 0;
+    unsigned long num_children = genetic->num_children;
+    unsigned long cutoff = num_children - genetic->natural_selection_cutoff;
+
+    for (i = cutoff, j = num_children - 1; i < j; i++, j--, k += 2) {
+	genetic->ops->combine_genes(genetic->child_ranking[i],
+				    genetic->child_ranking[j],
+				    genetic->child_ranking[k],
+				    genetic->child_ranking[k+1]);
+    }
+}
+
+static void genetic_ns_clone_top_parents(genetic_t * genetic)
+{
+    unsigned long i,j,k = 0;
+    unsigned long num_children = genetic->num_children;
+    unsigned long cutoff = num_children - genetic->natural_selection_cutoff;
+
+    for (i = cutoff, j = num_children - 1; i < j; i++, j--, k += 2) {
+	genetic->ops->combine_genes(genetic->child_ranking[i],
+				    genetic->child_ranking[j],
+				    genetic->child_ranking[k],
+				    genetic->child_ranking[k+1]);
+    }
+}
+
+/* This natural selection routine just has top parents populating
+   bottom performers. */
+static void genetic_ns_award_top_parents(genetic_t * genetic)
+{
+	unsigned long i;
+	unsigned long num_children = genetic->num_children;
+	unsigned long cutoff = num_children - genetic->natural_selection_cutoff;
+	
+	for (i = 0; i < cutoff; i += 2) {
+		genetic->ops->combine_genes(genetic->child_ranking[num_children - 1],
+					    genetic->child_ranking[num_children - 2],
+					    genetic->child_ranking[i],
+					    genetic->child_ranking[i+1]);
+	}
+}
+
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
+static void genetic_split_performers(genetic_t * genetic)
+{
+    int i, j;
+
+    for (i = genetic->num_children; i > 1; i--)
+	for (j = 0; j < i - 1; j++)
+	    if (genetic->child_ranking[j]->fitness > genetic->child_ranking[j+1]->fitness) 
+		genetic_swap(&genetic->child_ranking[j], &genetic->child_ranking[j+1]);
+}
+
+static void genetic_mutate(genetic_t * genetic)
+{
+    long child_entry = -1;
+    int i;
+
+    for (i = 0; i < genetic->num_mutations; i++) {
+	get_random_bytes(&child_entry, sizeof(child_entry));
+	child_entry = child_entry % genetic->num_children;
+
+	genetic->ops->mutate_child(genetic->child_ranking[child_entry]);
+    }
+}
+
+static void genetic_calc_stats(genetic_t * genetic)
+{
+    long total_fitness = 0;
+    int i;
+
+    /* calculate the avg fitness for this generation and avg fitness
+     * so far */
+    for (i = 0; i < genetic->num_children; i++) 
+	total_fitness += genetic->child_ranking[i]->fitness;
+
+    genetic->last_gen_avg_fitness = total_fitness / (long)genetic->num_children;
+
+    genetic->avg_fitness = ((genetic->avg_fitness * (long)(genetic->generation_number - 1)) +
+			    genetic->last_gen_avg_fitness) / (long)genetic->generation_number;
+
+    genetic->fitness_history[genetic->fitness_history_index++ & GENETIC_HISTORY_MASK] =
+	genetic->last_gen_avg_fitness;
+
+}    
+
+void dump_children(genetic_t * genetic)
+{
+	int i, j;
+	long * genes;
+	for (i = 0; i < genetic->num_children; i++) {
+		printk(KERN_EMERG "%d: %-8ld:\t", i, genetic->child_ranking[i]->fitness); 
+
+		for (j = 0; j < genetic->child_ranking[i]->num_genes; j++) {
+			genes = (long *)genetic->child_ranking[i]->genes;
+			printk("%ld\t", genes[j]);
+		}
+		printk("\n");
+	}
+
+	printk("\n");
+}
+
+void genetic_new_generation(genetic_t * genetic)
+{
+    struct list_head * tmp;
+
+#if GENETIC_DEBUG
+    printk(KERN_EMERG "-------------------------\n");
+    printk(KERN_EMERG "new generation performers: \n");
+    dump_children(genetic);
+#endif
+    
+    /* figure out top performers */
+    genetic_split_performers(genetic);
+
+#if GENETIC_DEBUG
+    printk(KERN_EMERG "split performers: \n");
+    dump_children(genetic);
+#endif
+    
+    /* calc stats */
+    genetic_calc_stats(genetic);
+
+    /* make some new children */
+    genetic->natural_selection(genetic);
+
+#if GENETIC_DEBUG
+    printk(KERN_EMERG "selected: \n");
+    dump_children(genetic);
+#endif
+
+    /* mutate a couple of the next generation */
+    genetic_mutate(genetic);
+
+#if GENETIC_DEBUG
+    printk(KERN_EMERG "mutated: \n");
+    dump_children(genetic);
+#endif
+
+    /* Move the new children still sitting in the finished queue to
+       the run queue */
+    tmp = genetic->run_queue;
+    genetic->run_queue = genetic->finished_queue;
+    genetic->finished_queue = tmp;
+
+    genetic->child_number = 0;
+    genetic->generation_number++;
+
+}
+
+void genetic_generic_mutate_gene(genetic_child_t * child, long gene_num)
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
+#if 0
+	/* XXX we shouldn't need this now that it's unsigned */
+	if (gene_value < 0)
+	    gene_value = -gene_value;
+#endif
+
+	gene_value = gene_value % range;
+	
+	genes[gene_num] = min + gene_value;
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
+		genetic_generic_mutate_gene(child, gene_num);
+}
+
+
+/* combine the genes by randomly take a portion of A's and B's to make
+ * C.  Then flip that portion of B and A to make D */
+void genetic_generic_combine_genes(genetic_child_t * parent_a,
+				   genetic_child_t * parent_b,
+				   genetic_child_t * child_a,
+				   genetic_child_t * child_b)
+{
+	unsigned long * genes_a = (unsigned long *)parent_a->genes;
+	unsigned long * genes_b = (unsigned long *)parent_b->genes;
+	unsigned long * genes_c = (unsigned long *)child_a->genes;
+	unsigned long * genes_d = (unsigned long *)child_b->genes;	
+	/* Assume parent_a and parent_b have same num_genes */
+	unsigned long num_genes = parent_a->num_genes;
+	int combine_point;
+	int i;
+
+	get_random_bytes(&combine_point, sizeof(combine_point));
+
+	if (combine_point < 0)
+	    combine_point = -combine_point;
+
+	combine_point = combine_point % num_genes;
+
+	for (i = combine_point; i < num_genes; i++)
+	    genes_c[i] = genes_a[i];
+
+	for (i = 0; i < combine_point; i++)
+	    genes_c[i] = genes_b[i];
+
+	for (i = combine_point; i < num_genes; i++)
+	    genes_d[i] = genes_b[i];
+
+	for (i = 0; i < combine_point; i++)
+	    genes_d[i] = genes_a[i];
+}

_

