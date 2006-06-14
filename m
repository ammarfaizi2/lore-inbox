Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWFNOPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWFNOPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWFNOPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:15:48 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:12356 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964903AbWFNOPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:15:47 -0400
Date: Wed, 14 Jun 2006 16:06:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [patch 21/24] s390: appldata enhancements.
Message-ID: <20060614140645.GV9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] appldata enhancements.

Add CPU ID and steal time, and make OS record size variable.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata.h         |   24 +++++++-
 arch/s390/appldata/appldata_base.c    |   39 ++++---------
 arch/s390/appldata/appldata_mem.c     |    5 +
 arch/s390/appldata/appldata_net_sum.c |    5 +
 arch/s390/appldata/appldata_os.c      |   98 +++++++++++++++++++++++-----------
 5 files changed, 108 insertions(+), 63 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-06-14 14:29:50.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-06-14 14:30:00.000000000 +0200
@@ -5,9 +5,9 @@
  * Exports appldata_register_ops() and appldata_unregister_ops() for the
  * data gathering modules.
  *
- * Copyright (C) 2003 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
  *
- * Author: Gerald Schaefer <geraldsc@de.ibm.com>
+ * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 #include <linux/config.h>
@@ -40,22 +40,6 @@
 
 #define TOD_MICRO	0x01000			/* nr. of TOD clock units
 						   for 1 microsecond */
-#ifndef CONFIG_64BIT
-
-#define APPLDATA_START_INTERVAL_REC 0x00   	/* Function codes for */
-#define APPLDATA_STOP_REC	    0x01	/* DIAG 0xDC	  */
-#define APPLDATA_GEN_EVENT_RECORD   0x02
-#define APPLDATA_START_CONFIG_REC   0x03
-
-#else
-
-#define APPLDATA_START_INTERVAL_REC 0x80
-#define APPLDATA_STOP_REC   	    0x81
-#define APPLDATA_GEN_EVENT_RECORD   0x82
-#define APPLDATA_START_CONFIG_REC   0x83
-
-#endif /* CONFIG_64BIT */
-
 
 /*
  * Parameter list for DIAGNOSE X'DC'
@@ -195,8 +179,8 @@ static void appldata_work_fn(void *data)
  *
  * prepare parameter list, issue DIAG 0xDC
  */
-static int appldata_diag(char record_nr, u16 function, unsigned long buffer,
-			u16 length)
+int appldata_diag(char record_nr, u16 function, unsigned long buffer,
+			u16 length, char *mod_lvl)
 {
 	unsigned long ry;
 	struct appldata_product_id {
@@ -214,7 +198,7 @@ static int appldata_diag(char record_nr,
 		.record_nr  = record_nr,
 		.version_nr = {0xF2, 0xF6},		/* "26" */
 		.release_nr = {0xF0, 0xF1},		/* "01" */
-		.mod_lvl    = {0xF0, 0xF0},		/* "00" */
+		.mod_lvl    = {mod_lvl[0], mod_lvl[1]},
 	};
 	struct appldata_parameter_list appldata_parameter_list = {
 				.diag = 0xDC,
@@ -467,24 +451,25 @@ appldata_generic_handler(ctl_table *ctl,
 			module_put(ops->owner);
 			return -ENODEV;
 		}
-		ops->active = 1;
 		ops->callback(ops->data);	// init record
 		rc = appldata_diag(ops->record_nr,
 					APPLDATA_START_INTERVAL_REC,
-					(unsigned long) ops->data, ops->size);
+					(unsigned long) ops->data, ops->size,
+					ops->mod_lvl);
 		if (rc != 0) {
 			P_ERROR("START DIAG 0xDC for %s failed, "
 				"return code: %d\n", ops->name, rc);
 			module_put(ops->owner);
-			ops->active = 0;
 		} else {
 			P_INFO("Monitoring %s data enabled, "
 				"DIAG 0xDC started.\n", ops->name);
+			ops->active = 1;
 		}
 	} else if ((buf[0] == '0') && (ops->active == 1)) {
 		ops->active = 0;
 		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
-				(unsigned long) ops->data, ops->size);
+				(unsigned long) ops->data, ops->size,
+				ops->mod_lvl);
 		if (rc != 0) {
 			P_ERROR("STOP DIAG 0xDC for %s failed, "
 				"return code: %d\n", ops->name, rc);
@@ -710,7 +695,8 @@ static void __exit appldata_exit(void)
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
 		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
-				(unsigned long) ops->data, ops->size);
+				(unsigned long) ops->data, ops->size,
+				ops->mod_lvl);
 		if (rc != 0) {
 			P_ERROR("STOP DIAG 0xDC for %s failed, "
 				"return code: %d\n", ops->name, rc);
@@ -739,6 +725,7 @@ MODULE_DESCRIPTION("Linux-VM Monitor Str
 
 EXPORT_SYMBOL_GPL(appldata_register_ops);
 EXPORT_SYMBOL_GPL(appldata_unregister_ops);
+EXPORT_SYMBOL_GPL(appldata_diag);
 
 #ifdef MODULE
 /*
diff -urpN linux-2.6/arch/s390/appldata/appldata.h linux-2.6-patched/arch/s390/appldata/appldata.h
--- linux-2.6/arch/s390/appldata/appldata.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata.h	2006-06-14 14:30:00.000000000 +0200
@@ -3,9 +3,9 @@
  *
  * Definitions and interface for Linux - z/VM Monitor Stream.
  *
- * Copyright (C) 2003 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
  *
- * Author: Gerald Schaefer <geraldsc@de.ibm.com>
+ * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 //#define APPLDATA_DEBUG			/* Debug messages on/off */
@@ -29,6 +29,22 @@
 #define CTL_APPLDATA_NET_SUM	2125
 #define CTL_APPLDATA_PROC	2126
 
+#ifndef CONFIG_64BIT
+
+#define APPLDATA_START_INTERVAL_REC 0x00	/* Function codes for */
+#define APPLDATA_STOP_REC	    0x01	/* DIAG 0xDC	  */
+#define APPLDATA_GEN_EVENT_RECORD   0x02
+#define APPLDATA_START_CONFIG_REC   0x03
+
+#else
+
+#define APPLDATA_START_INTERVAL_REC 0x80
+#define APPLDATA_STOP_REC	    0x81
+#define APPLDATA_GEN_EVENT_RECORD   0x82
+#define APPLDATA_START_CONFIG_REC   0x83
+
+#endif /* CONFIG_64BIT */
+
 #define P_INFO(x...)	printk(KERN_INFO MY_PRINT_NAME " info: " x)
 #define P_ERROR(x...)	printk(KERN_ERR MY_PRINT_NAME " error: " x)
 #define P_WARNING(x...)	printk(KERN_WARNING MY_PRINT_NAME " status: " x)
@@ -53,7 +69,11 @@ struct appldata_ops {
 	void *data;				/* record data */
 	unsigned int size;			/* size of record */
 	struct module *owner;			/* THIS_MODULE */
+	char mod_lvl[2];			/* modification level, EBCDIC */
 };
 
 extern int appldata_register_ops(struct appldata_ops *ops);
 extern void appldata_unregister_ops(struct appldata_ops *ops);
+extern int appldata_diag(char record_nr, u16 function, unsigned long buffer,
+			 u16 length, char *mod_lvl);
+
diff -urpN linux-2.6/arch/s390/appldata/appldata_mem.c linux-2.6-patched/arch/s390/appldata/appldata_mem.c
--- linux-2.6/arch/s390/appldata/appldata_mem.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_mem.c	2006-06-14 14:30:00.000000000 +0200
@@ -4,9 +4,9 @@
  * Data gathering module for Linux-VM Monitor Stream, Stage 1.
  * Collects data related to memory management.
  *
- * Copyright (C) 2003 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
  *
- * Author: Gerald Schaefer <geraldsc@de.ibm.com>
+ * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 #include <linux/config.h>
@@ -152,6 +152,7 @@ static struct appldata_ops ops = {
 	.callback  = &appldata_get_mem_data,
 	.data      = &appldata_mem_data,
 	.owner     = THIS_MODULE,
+	.mod_lvl   = {0xF0, 0xF0},		/* EBCDIC "00" */
 };
 
 
diff -urpN linux-2.6/arch/s390/appldata/appldata_net_sum.c linux-2.6-patched/arch/s390/appldata/appldata_net_sum.c
--- linux-2.6/arch/s390/appldata/appldata_net_sum.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_net_sum.c	2006-06-14 14:30:00.000000000 +0200
@@ -5,9 +5,9 @@
  * Collects accumulated network statistics (Packets received/transmitted,
  * dropped, errors, ...).
  *
- * Copyright (C) 2003 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
  *
- * Author: Gerald Schaefer <geraldsc@de.ibm.com>
+ * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 #include <linux/config.h>
@@ -152,6 +152,7 @@ static struct appldata_ops ops = {
 	.callback  = &appldata_get_net_sum_data,
 	.data      = &appldata_net_sum_data,
 	.owner     = THIS_MODULE,
+	.mod_lvl   = {0xF0, 0xF0},		/* EBCDIC "00" */
 };
 
 
diff -urpN linux-2.6/arch/s390/appldata/appldata_os.c linux-2.6-patched/arch/s390/appldata/appldata_os.c
--- linux-2.6/arch/s390/appldata/appldata_os.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_os.c	2006-06-14 14:30:00.000000000 +0200
@@ -4,9 +4,9 @@
  * Data gathering module for Linux-VM Monitor Stream, Stage 1.
  * Collects misc. OS related data (CPU utilization, running processes).
  *
- * Copyright (C) 2003 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
  *
- * Author: Gerald Schaefer <geraldsc@de.ibm.com>
+ * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
 #include <linux/config.h>
@@ -44,11 +44,14 @@ struct appldata_os_per_cpu {
 	u32 per_cpu_system;	/* ... spent in kernel mode         */
 	u32 per_cpu_idle;	/* ... spent in idle mode           */
 
-// New in 2.6 -->
+	/* New in 2.6 */
 	u32 per_cpu_irq;	/* ... spent in interrupts          */
 	u32 per_cpu_softirq;	/* ... spent in softirqs            */
 	u32 per_cpu_iowait;	/* ... spent while waiting for I/O  */
-// <-- New in 2.6
+
+	/* New in modification level 01 */
+	u32 per_cpu_steal;	/* ... stolen by hypervisor	    */
+	u32 cpu_id;		/* number of this CPU		    */
 } __attribute__((packed));
 
 struct appldata_os_data {
@@ -68,10 +71,9 @@ struct appldata_os_data {
 	u32 avenrun[3];		/* average nr. of running processes during */
 				/* the last 1, 5 and 15 minutes */
 
-// New in 2.6 -->
+	/* New in 2.6 */
 	u32 nr_iowait;		/* number of blocked threads
 				   (waiting for I/O)               */
-// <-- New in 2.6
 
 	/* per cpu data */
 	struct appldata_os_per_cpu os_cpu[0];
@@ -79,6 +81,14 @@ struct appldata_os_data {
 
 static struct appldata_os_data *appldata_os_data;
 
+static struct appldata_ops ops = {
+	.ctl_nr    = CTL_APPLDATA_OS,
+	.name	   = "os",
+	.record_nr = APPLDATA_RECORD_OS_ID,
+	.owner	   = THIS_MODULE,
+	.mod_lvl   = {0xF0, 0xF1},		/* EBCDIC "01" */
+};
+
 
 static inline void appldata_print_debug(struct appldata_os_data *os_data)
 {
@@ -100,15 +110,17 @@ static inline void appldata_print_debug(
 	P_DEBUG("nr_cpus = %u\n", os_data->nr_cpus);
 	for (i = 0; i < os_data->nr_cpus; i++) {
 		P_DEBUG("cpu%u : user = %u, nice = %u, system = %u, "
-			"idle = %u, irq = %u, softirq = %u, iowait = %u\n",
-				i,
+			"idle = %u, irq = %u, softirq = %u, iowait = %u, "
+			"steal = %u\n",
+				os_data->os_cpu[i].cpu_id,
 				os_data->os_cpu[i].per_cpu_user,
 				os_data->os_cpu[i].per_cpu_nice,
 				os_data->os_cpu[i].per_cpu_system,
 				os_data->os_cpu[i].per_cpu_idle,
 				os_data->os_cpu[i].per_cpu_irq,
 				os_data->os_cpu[i].per_cpu_softirq,
-				os_data->os_cpu[i].per_cpu_iowait);
+				os_data->os_cpu[i].per_cpu_iowait,
+				os_data->os_cpu[i].per_cpu_steal);
 	}
 
 	P_DEBUG("sync_count_1 = %u\n", os_data->sync_count_1);
@@ -123,14 +135,13 @@ static inline void appldata_print_debug(
  */
 static void appldata_get_os_data(void *data)
 {
-	int i, j;
+	int i, j, rc;
 	struct appldata_os_data *os_data;
+	unsigned int new_size;
 
 	os_data = data;
 	os_data->sync_count_1++;
 
-	os_data->nr_cpus = num_online_cpus();
-
 	os_data->nr_threads = nr_threads;
 	os_data->nr_running = nr_running();
 	os_data->nr_iowait  = nr_iowait();
@@ -154,9 +165,44 @@ static void appldata_get_os_data(void *d
 			cputime_to_jiffies(kstat_cpu(i).cpustat.softirq);
 		os_data->os_cpu[j].per_cpu_iowait =
 			cputime_to_jiffies(kstat_cpu(i).cpustat.iowait);
+		os_data->os_cpu[j].per_cpu_steal =
+			cputime_to_jiffies(kstat_cpu(i).cpustat.steal);
+		os_data->os_cpu[j].cpu_id = i;
 		j++;
 	}
 
+	os_data->nr_cpus = j;
+
+	new_size = sizeof(struct appldata_os_data) +
+		   (os_data->nr_cpus * sizeof(struct appldata_os_per_cpu));
+	if (ops.size != new_size) {
+		if (ops.active) {
+			rc = appldata_diag(APPLDATA_RECORD_OS_ID,
+					   APPLDATA_START_INTERVAL_REC,
+					   (unsigned long) ops.data, new_size,
+					   ops.mod_lvl);
+			if (rc != 0) {
+				P_ERROR("os: START NEW DIAG 0xDC failed, "
+					"return code: %d, new size = %i\n", rc,
+					new_size);
+				P_INFO("os: stopping old record now\n");
+			} else
+				P_INFO("os: new record size = %i\n", new_size);
+
+			rc = appldata_diag(APPLDATA_RECORD_OS_ID,
+					   APPLDATA_STOP_REC,
+					   (unsigned long) ops.data, ops.size,
+					   ops.mod_lvl);
+			if (rc != 0)
+				P_ERROR("os: STOP OLD DIAG 0xDC failed, "
+					"return code: %d, old size = %i\n", rc,
+					ops.size);
+			else
+				P_INFO("os: old record size = %i stopped\n",
+					ops.size);
+		}
+		ops.size = new_size;
+	}
 	os_data->timestamp = get_clock();
 	os_data->sync_count_2++;
 #ifdef APPLDATA_DEBUG
@@ -165,15 +211,6 @@ static void appldata_get_os_data(void *d
 }
 
 
-static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_OS,
-	.name	   = "os",
-	.record_nr = APPLDATA_RECORD_OS_ID,
-	.callback  = &appldata_get_os_data,
-	.owner     = THIS_MODULE,
-};
-
-
 /*
  * appldata_os_init()
  *
@@ -181,26 +218,25 @@ static struct appldata_ops ops = {
  */
 static int __init appldata_os_init(void)
 {
-	int rc, size;
+	int rc, max_size;
 
-	size = sizeof(struct appldata_os_data) +
-		(NR_CPUS * sizeof(struct appldata_os_per_cpu));
-	if (size > APPLDATA_MAX_REC_SIZE) {
-		P_ERROR("Size of record = %i, bigger than maximum (%i)!\n",
-			size, APPLDATA_MAX_REC_SIZE);
+	max_size = sizeof(struct appldata_os_data) +
+		   (NR_CPUS * sizeof(struct appldata_os_per_cpu));
+	if (max_size > APPLDATA_MAX_REC_SIZE) {
+		P_ERROR("Max. size of OS record = %i, bigger than maximum "
+			"record size (%i)\n", max_size, APPLDATA_MAX_REC_SIZE);
 		rc = -ENOMEM;
 		goto out;
 	}
-	P_DEBUG("sizeof(os) = %i, sizeof(os_cpu) = %lu\n", size,
+	P_DEBUG("max. sizeof(os) = %i, sizeof(os_cpu) = %lu\n", max_size,
 		sizeof(struct appldata_os_per_cpu));
 
-	appldata_os_data = kmalloc(size, GFP_DMA);
+	appldata_os_data = kzalloc(max_size, GFP_DMA);
 	if (appldata_os_data == NULL) {
 		P_ERROR("No memory for %s!\n", ops.name);
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(appldata_os_data, 0, size);
 
 	appldata_os_data->per_cpu_size = sizeof(struct appldata_os_per_cpu);
 	appldata_os_data->cpu_offset   = offsetof(struct appldata_os_data,
@@ -208,7 +244,7 @@ static int __init appldata_os_init(void)
 	P_DEBUG("cpu offset = %u\n", appldata_os_data->cpu_offset);
 
 	ops.data = appldata_os_data;
-	ops.size = size;
+	ops.callback  = &appldata_get_os_data;
 	rc = appldata_register_ops(&ops);
 	if (rc != 0) {
 		P_ERROR("Error registering ops, rc = %i\n", rc);
