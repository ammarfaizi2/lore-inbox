Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVBOTuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVBOTuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVBOTtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:49:07 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24215 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261842AbVBOTnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:43:49 -0500
Date: Tue, 15 Feb 2005 13:39:22 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: pwil3058@bigpond.net.au
Subject: [ANNOUNCE 3/4] Genetic-lib version 0.2
Message-Id: <20050215133922.63a5106f.moilanen@austin.ibm.com>
In-Reply-To: <20050215132906.33f88505.moilanen@austin.ibm.com>
References: <20050215132906.33f88505.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hooked Anticipatory IO scheduler.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN drivers/block/Kconfig.iosched~genetic-as-sched drivers/block/Kconfig.iosched
--- linux-2.6.10/drivers/block/Kconfig.iosched~genetic-as-sched	Fri Jan 28 15:53:44 2005
+++ linux-2.6.10-moilanen/drivers/block/Kconfig.iosched	Fri Jan 28 15:53:44 2005
@@ -38,4 +38,13 @@ config IOSCHED_CFQ
 	  among all processes in the system. It should provide a fair
 	  working environment, suitable for desktop systems.
 
+config GENETIC_IOSCHED_AS
+        bool "Genetic Anticipatory I/O scheduler (EXPERIMENTAL)" 
+        depends on IOSCHED_AS && GENETIC_LIB && EXPERIMENTAL
+        default n
+        ---help---
+        This will use a genetic algorithm to tweak the tunables of the
+        anticipatory scheduler autonomically and will adapt tunables
+        depending on the present workload.  
+
 endmenu
diff -puN drivers/block/as-iosched.c~genetic-as-sched drivers/block/as-iosched.c
--- linux-2.6.10/drivers/block/as-iosched.c~genetic-as-sched	Fri Jan 28 15:53:44 2005
+++ linux-2.6.10-moilanen/drivers/block/as-iosched.c	Wed Feb  2 16:42:02 2005
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
@@ -83,6 +87,53 @@ enum anticipation_status {
 				 * or timed out */
 };
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+
+struct disk_stats_snapshot * as_stats_snapshot;
+
+extern void disk_stats_snapshot(phenotype_t * pt);
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
+    .take_snapshot = disk_stats_snapshot,
+};
+
+#define AS_NUM_GENES 6
+#define AS_NUM_CHILDREN 8
+
+#define AS_GENERAL_UID 1
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
+	{ HZ/4, 3*HZ/4, default_read_batch_expire, 0},	/* read_batch_expire */
+	{ HZ/16, 3*HZ/16, default_write_batch_expire, 0},/* write_batch_expire */
+	{ HZ/300, HZ/100, default_antic_expire, 0},	/* default_antic_expire */
+	{ HZ/100, 3*HZ/100, MAX_THINKTIME, 0}
+};
+
+extern void disk_stats_snapshot(phenotype_t * pt);
+extern unsigned long disk_calc_fitness(genetic_child_t * child);
+
+LIST_HEAD(as_data_list);
+#endif
+
 struct as_data {
 	/*
 	 * run time data
@@ -132,6 +183,9 @@ struct as_data {
 	unsigned long fifo_expire[2];
 	unsigned long batch_expire[2];
 	unsigned long antic_expire;
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+        struct list_head data_list;
+#endif
 };
 
 #define list_entry_fifo(ptr)	list_entry((ptr), struct as_rq, fifo)
@@ -869,7 +923,7 @@ static void as_update_iohist(struct as_d
 			if (test_bit(AS_TASK_IORUNNING, &aic->state)
 							&& in_flight == 0) {
 				thinktime = jiffies - aic->last_end_request;
-				thinktime = min(thinktime, MAX_THINKTIME-1);
+				thinktime = min(thinktime, max_thinktime-1);
 			} else
 				thinktime = 0;
 			as_update_thinktime(ad, aic, thinktime);
@@ -1854,6 +1908,11 @@ static void as_exit_queue(elevator_t *e)
 
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
@@ -1916,6 +1975,10 @@ static int as_init_queue(request_queue_t
 	if (ad->write_batch_count < 2)
 		ad->write_batch_count = 2;
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+	list_add_tail(&ad->data_list, &as_data_list);
+#endif
+
 	return 0;
 }
 
@@ -2099,6 +2162,9 @@ static struct elevator_type iosched_as =
 static int __init as_init(void)
 {
 	int ret;
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+	genetic_t * genetic = 0;
+#endif
 
 	arq_pool = kmem_cache_create("as_arq", sizeof(struct as_rq),
 				     0, 0, NULL, NULL);
@@ -2107,6 +2173,24 @@ static int __init as_init(void)
 
 	ret = elv_register(&iosched_as);
 	if (!ret) {
+
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+		as_stats_snapshot = (struct disk_stats_snapshot *)kmalloc(sizeof(struct disk_stats_snapshot), GFP_KERNEL);
+		if (!as_stats_snapshot)
+			panic("as: failed to malloc enough space");
+
+
+		ret = genetic_init(&genetic, AS_NUM_CHILDREN, 2 * HZ, "as-ioscheduler");
+		if (ret)
+			panic("as: failed to init genetic lib");
+		
+		if(genetic_register_phenotype(genetic, &as_genetic_ops, AS_NUM_CHILDREN,
+					      "general", AS_NUM_GENES, AS_GENERAL_UID))
+			panic("as: failed to register general phenotype");
+
+		genetic_start(genetic);
+#endif	
+ 
 		/*
 		 * don't allow AS to get unregistered, since we would have
 		 * to browse all tasks in the system and release their
@@ -2126,6 +2210,51 @@ static void __exit as_exit(void)
 	elv_unregister(&iosched_as);
 }
 
+#ifdef CONFIG_GENETIC_IOSCHED_AS
+
+/* need to create the genes for the child */
+static void as_create_child(genetic_child_t * child)
+{
+    BUG_ON(!child);
+
+    child->genes = (void *)kmalloc(sizeof(struct as_genes), GFP_KERNEL);
+    if (!child->genes) 
+	panic("as_create_child: error mallocing space");
+
+    child->gene_param = as_gene_param;
+    child->num_genes = AS_NUM_GENES;
+    child->stats_snapshot = as_stats_snapshot;
+
+    genetic_create_child_spread(child, AS_NUM_CHILDREN);
+//    genetic_create_child_defaults(child);
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
+}
+
+static void as_calc_fitness(genetic_child_t * child)
+{
+	child->fitness = disk_calc_fitness(child);
+}
+
+#endif
+
+ 
 module_init(as_init);
 module_exit(as_exit);
 

_
