Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVAFQ0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVAFQ0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVAFQ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:26:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53152 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262897AbVAFQZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:25:57 -0500
Date: Thu, 6 Jan 2005 10:22:49 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 3/4][RFC] Genetic Algorithm Library
Message-ID: <20050106102249.66ef21d8@localhost>
In-Reply-To: <20050106100844.53a762a0@localhost>
References: <20050106100844.53a762a0@localhost>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the hooked anticipatory IO scheduler.  

Here is an example of the hooked scheduler.  It should optimally tweak
the tunables for the current workload.

If nothing else, hopefully the genetic-lib will help scheduler writers
find the optimal tunable settings.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN drivers/block/Kconfig.iosched~genetic-as-sched drivers/block/Kconfig.iosched
--- linux-2.6.9/drivers/block/Kconfig.iosched~genetic-as-sched	Wed Jan  5 15:46:07 2005
+++ linux-2.6.9-moilanen/drivers/block/Kconfig.iosched	Wed Jan  5 15:46:07 2005
@@ -34,3 +34,12 @@ config IOSCHED_CFQ
 	  The CFQ I/O scheduler tries to distribute bandwidth equally
 	  among all processes in the system. It should provide a fair
 	  working environment, suitable for desktop systems.
+
+config GENETIC_IOSCHED_AS
+       bool "Genetic Anticipatory I/O scheduler (EXPERIMENTAL)" 
+       depends on IOSCHED_AS && GENETIC_LIB && EXPERIMENTAL
+       default n
+       ---help---
+       This will use a genetic algorithm to tweak the tunables of the
+       anticipatory scheduler autonomically and will adapt tunables
+       depending on the present workload.  
diff -puN drivers/block/as-iosched.c~genetic-as-sched drivers/block/as-iosched.c
--- linux-2.6.9/drivers/block/as-iosched.c~genetic-as-sched	Wed Jan  5 15:46:07 2005
+++ linux-2.6.9-moilanen/drivers/block/as-iosched.c	Wed Jan  5 15:46:07 2005
@@ -20,6 +20,8 @@
 #include <linux/hash.h>
 #include <linux/rbtree.h>
 #include <linux/interrupt.h>
+#include <linux/genetic.h>
+#include <linux/random.h>
 
 #define REQ_SYNC	1
 #define REQ_ASYNC	0
@@ -67,6 +69,8 @@
  */
 #define MAX_THINKTIME (HZ/50UL)
 
+unsigned long max_thinktime = MAX_THINKTIME;
+
 /* Bits in as_io_context.state */
 enum as_io_states {
 	AS_TASK_RUNNING=0,	/* Process has not exitted */
@@ -83,6 +87,47 @@ enum anticipation_status {
 				 * or timed out */
 };
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+
+static void as_create_child(genetic_child_t * child);
+static void as_set_child_genes(void * in_genes);
+static void as_calc_fitness(genetic_child_t * child);
+
+struct genetic_ops as_genetic_ops = {
+    .create_child = as_create_child,
+    .set_child_genes = as_set_child_genes,
+    .calc_fitness = as_calc_fitness,
+    .combine_genes = genetic_generic_combine_genes,
+    .mutate_child = genetic_generic_mutate_child,
+};
+
+#define AS_NUM_GENES 6
+#define AS_NUM_CHILDREN 8
+
+struct as_genes {
+    unsigned long read_expire;
+    unsigned long write_expire;
+    unsigned long read_batch_expire;
+    unsigned long write_batch_expire;
+    unsigned long antic_expire;
+    unsigned long max_thinktime;
+};
+
+gene_param_t as_gene_param[AS_NUM_GENES] = {
+	{ HZ/16, 3*HZ/16, default_read_expire, 0},	/* read_expire */
+	{ HZ/8, 3*HZ/8, default_write_expire, 0},    	/* write_expire */
+	{ HZ/16, 3*HZ/16, default_write_batch_expire, 0},/* write_batch_expire */
+	{ HZ/4, 3*HZ/4, default_read_batch_expire, 0},	/* read_batch_expire */
+	{ HZ/300, HZ/100, default_antic_expire, 0},	/* default_antic_expire */
+	{ HZ/100, 3*HZ/100, MAX_THINKTIME, 0}
+};
+
+extern void disk_stats_snapshot(void);
+extern unsigned long disk_calc_fitness(void);
+
+LIST_HEAD(as_data_list);
+#endif
+
 struct as_data {
 	/*
 	 * run time data
@@ -132,6 +177,9 @@ struct as_data {
 	unsigned long fifo_expire[2];
 	unsigned long batch_expire[2];
 	unsigned long antic_expire;
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+        struct list_head data_list;
+#endif
 };
 
 #define list_entry_fifo(ptr)	list_entry((ptr), struct as_rq, fifo)
@@ -869,7 +917,7 @@ static void as_update_iohist(struct as_d
 			if (test_bit(AS_TASK_IORUNNING, &aic->state)
 							&& in_flight == 0) {
 				thinktime = jiffies - aic->last_end_request;
-				thinktime = min(thinktime, MAX_THINKTIME-1);
+				thinktime = min(thinktime, max_thinktime-1);
 			} else
 				thinktime = 0;
 			as_update_thinktime(ad, aic, thinktime);
@@ -1854,6 +1902,11 @@ static void as_exit(request_queue_t *q, 
 
 	mempool_destroy(ad->arq_pool);
 	put_io_context(ad->io_context);
+
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+	list_del(&ad->data_list);
+#endif
+
 	kfree(ad->hash);
 	kfree(ad);
 }
@@ -1916,6 +1969,10 @@ static int as_init(request_queue_t *q, e
 	if (ad->write_batch_count < 2)
 		ad->write_batch_count = 2;
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+	list_add_tail(&ad->data_list, &as_data_list);
+#endif
+
 	return 0;
 }
 
@@ -2072,12 +2129,20 @@ static struct kobj_type as_ktype = {
 
 static int __init as_slab_setup(void)
 {
+	int rc;
+    
 	arq_pool = kmem_cache_create("as_arq", sizeof(struct as_rq),
 				     0, 0, NULL, NULL);
 
 	if (!arq_pool)
 		panic("as: can't init slab pool\n");
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+	rc = genetic_init(0, &as_genetic_ops, AS_NUM_CHILDREN, 2 * HZ, "as-ioscheduler");
+	if (rc)
+	    panic("as: failed to init genetic lib");
+#endif	
+
 	return 0;
 }
 
@@ -2106,3 +2171,70 @@ elevator_t iosched_as = {
 };
 
 EXPORT_SYMBOL(iosched_as);
+
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+
+/* need to create the genes for the child */
+static void as_create_child(genetic_child_t * child)
+{
+    int i;
+    static int child_num = 0;
+    unsigned long range;
+    int range_incr;
+    unsigned long * genes;
+
+    BUG_ON(!child);
+
+    child->genes = (void *)kmalloc(sizeof(struct as_genes), GFP_KERNEL);
+    if (!child->genes) 
+	panic("as_create_child: error mallocing space");
+
+    child->gene_param = as_gene_param;
+
+    genes = (unsigned long *)child->genes;
+
+    for (i = 0; i < AS_NUM_GENES; i++) {
+	    range = child->gene_param[i].max - child->gene_param[i].min + 1;
+	    range_incr = range / AS_NUM_CHILDREN;
+	    if (range_incr)
+		    genes[i] = child->gene_param[i].min +
+			    (range_incr * child_num);
+	    else
+		    genes[i] = child->gene_param[i].min +
+			    (child_num / (AS_NUM_CHILDREN / range));
+    }
+
+    child->num_genes = AS_NUM_GENES;
+
+    child_num++;
+}
+
+static void as_set_child_genes(void * in_genes)
+{
+    struct as_genes * genes = (struct as_genes *)in_genes;
+    struct list_head * d;
+    struct as_data * ad;
+    
+    list_for_each(d, &as_data_list) {
+	ad = list_entry(d, struct as_data, data_list);
+	ad->fifo_expire[REQ_SYNC] = genes->read_expire;
+	ad->fifo_expire[REQ_ASYNC] = genes->write_expire;
+	ad->antic_expire = genes->antic_expire;
+	ad->batch_expire[REQ_SYNC] = genes->read_batch_expire;
+	ad->batch_expire[REQ_ASYNC] = genes->write_batch_expire;
+    }
+    max_thinktime = genes->max_thinktime;
+
+    /* Set a mark for the start of this child to help calculate
+       fitness */
+    disk_stats_snapshot();
+}
+
+static void as_calc_fitness(genetic_child_t * child)
+{
+	child->fitness = disk_calc_fitness();
+}
+
+#endif
+
+

_
