Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTIXUSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 16:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTIXUSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 16:18:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53401 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261447AbTIXUSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 16:18:18 -0400
Subject: [RFC/Patch] CKRM I/O controller with equal bandwidth
From: Shailabh Nagar <nagar@watson.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Cc: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1064434656.6355.16.camel@elinux03.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Sep 2003 16:17:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the first version of the Class-based Resource Management (CKRM) I/O
controller. Applies over the CKRM core patch for the -mm tree, available from
http://ckrm.sourceforge.net/downloads/ckcore-A01-2.6.0-test5-mm2


The I/O controller is based on Jens' CFQ I/O scheduler which is currently in the 
-mm tree and provides equal I/O bandwidth to each class. CFQ is very modular so 
the changes needed to enable CKRM I/O are quite small. Providing proportional 
instead of equal bandwidth will need more substantial changes to CFQ.

Only minimal testing has been done on a uniprocessor with an IDE disk using 
tiobench. Complete testing package and module providing /proc interface to 
monitor per-class I/O bandwidth will be provided shortly.

More information on CKRM and all patches are available from
	http://ckrm.sf.net

-- Shailabh




diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Wed Sep 24 14:47:35 2003
+++ b/arch/i386/Kconfig	Wed Sep 24 14:47:35 2003
@@ -530,6 +530,18 @@
 	help
 	  This option adds CKRM support to the Kernel. Say N if you are unsure.
 
+config CKRM_IO
+	bool "Class Based I/O bandwidth controller"
+	default n
+	depends on CKRM
+	help
+	   Provide per-class control over per-blockdevice I/O bandwidth. 
+	   I/O requests from each class (collection of tasks) are submitted to
+	   the block device driver in proportion of the class's share.
+	   More information on classes, shares and CKRM at <http://ckrm.sf.net>
+	   
+	   Say N if unsure about what CKRM does. 	  	
+
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -Nru a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	Wed Sep 24 14:47:35 2003
+++ b/drivers/block/Makefile	Wed Sep 24 14:47:35 2003
@@ -40,3 +40,4 @@
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
+obj-$(CONFIG_CKRM_IO) 		+= ckrm_io.o
diff -Nru a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c	Wed Sep 24 14:47:35 2003
+++ b/drivers/block/cfq-iosched.c	Wed Sep 24 14:47:35 2003
@@ -22,6 +22,11 @@
 #include <linux/rbtree.h>
 #include <linux/mempool.h>
 
+#ifdef CONFIG_CKRM_IO
+#include <linux/ckrm_io.h>
+#endif
+
+
 /*
  * tunables
  */
@@ -65,7 +70,8 @@
 	struct list_head cfq_hash;
 	struct list_head cfq_list;
 	struct rb_root sort_list;
-	int pid;
+	int iogrp;  /* could either be tgid for regular cfq or 
+                       an ioclass id for CKRM_IO */
 	int queued[2];
 #if 0
 	/*
@@ -88,9 +94,23 @@
 };
 
 static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq);
-static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid);
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int iogrp);
 static void cfq_dispatch_sort(struct list_head *head, struct cfq_rq *crq);
 
+
+static int cfq_iogrp(struct task_struct *tsk)
+{
+#ifdef CONFIG_CKRM_IO
+	if (icls_valid(tsk->io_class))
+		return tsk->io_class->icls_id ;
+	else
+		return ckrm_icls_dflt.icls_id ;
+#else
+
+	return tsk->tgid ;
+#endif
+}		
+
 /*
  * lots of deadline iosched dupes, can be abstracted later...
  */
@@ -214,7 +234,7 @@
 static struct request *
 cfq_find_rq_rb(struct cfq_data *cfqd, sector_t sector)
 {
-	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, current->tgid);
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, cfq_iogrp(current));
 	struct rb_node *n;
 
 	if (!cfqq)
@@ -416,7 +436,7 @@
 }
 
 static inline struct cfq_queue *
-__cfq_find_cfq_hash(struct cfq_data *cfqd, int pid, const int hashval)
+__cfq_find_cfq_hash(struct cfq_data *cfqd, int iogrp, const int hashval)
 {
 	struct list_head *hash_list = &cfqd->cfq_hash[hashval];
 	struct list_head *entry;
@@ -424,18 +444,18 @@
 	list_for_each(entry, hash_list) {
 		struct cfq_queue *__cfqq = list_entry_qhash(entry);
 
-		if (__cfqq->pid == pid)
+		if (__cfqq->iogrp == iogrp)
 			return __cfqq;
 	}
 
 	return NULL;
 }
 
-static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid)
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int iogrp)
 {
-	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
+	const int hashval = hash_long(cfq_iogrp(current), CFQ_QHASH_SHIFT);
 
-	return __cfq_find_cfq_hash(cfqd, pid, hashval);
+	return __cfq_find_cfq_hash(cfqd, iogrp, hashval);
 }
 
 static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
@@ -446,10 +466,10 @@
 	mempool_free(cfqq, cfq_mpool);
 }
 
-static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int pid)
+static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int iogrp)
 {
-	const int hashval = hash_long(current->tgid, CFQ_QHASH_SHIFT);
-	struct cfq_queue *cfqq = __cfq_find_cfq_hash(cfqd, pid, hashval);
+	const int hashval = hash_long(cfq_iogrp(current), CFQ_QHASH_SHIFT);
+	struct cfq_queue *cfqq = __cfq_find_cfq_hash(cfqd, iogrp, hashval);
 
 	if (!cfqq) {
 		cfqq = mempool_alloc(cfq_mpool, GFP_NOIO);
@@ -458,7 +478,7 @@
 		INIT_LIST_HEAD(&cfqq->cfq_list);
 		RB_CLEAR_ROOT(&cfqq->sort_list);
 
-		cfqq->pid = pid;
+		cfqq->iogrp = iogrp;
 		cfqq->queued[0] = cfqq->queued[1] = 0;
 		list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
 	}
@@ -470,7 +490,7 @@
 {
 	struct cfq_queue *cfqq;
 
-	cfqq = cfq_get_queue(cfqd, current->tgid);
+	cfqq = cfq_get_queue(cfqd, cfq_iogrp(current));
 
 	cfq_add_crq_rb(cfqd, cfqq, crq);
 
diff -Nru a/drivers/block/ckrm_io.c b/drivers/block/ckrm_io.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/block/ckrm_io.c	Wed Sep 24 14:47:35 2003
@@ -0,0 +1,230 @@
+/* linux/drivers/block/ckrm_io.c : io control for CKRM
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2003
+ * 
+ * 
+ * I/O control functions of the CKRM kernel API 
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 24 Sept 2003
+ *        Initial version with equal shares for all classes. 
+ *        Needs CFQ I/O scheduler.
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/unistd.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/cache.h>
+#include <linux/percpu.h>
+#include <linux/pagevec.h>
+#include <linux/rmap-locking.h>
+
+#include <linux/ckrm_io.h>
+
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+
+
+/* default class */
+int next_icls_id = 1 ;
+
+struct list_head  ckrm_icls_list = LIST_HEAD_INIT(ckrm_icls_list);
+spinlock_t ckrm_icls_lock = SPIN_LOCK_UNLOCKED;
+
+EXPORT_SYMBOL(ckrm_icls_list);
+EXPORT_SYMBOL(ckrm_icls_lock);
+
+ckrm_icls_t  ckrm_icls_dflt = {
+	.icls_list    =  LIST_HEAD_INIT(ckrm_icls_dflt.icls_list),
+	.icls_share   =  DFLT_ICLS_SHARE,
+} ;
+
+
+
+/* DEBUGGING ONLY */
+
+int iclsdebug = 10;
+#define cprintk(lvl,x) if ((lvl) <= iclsdebug) printk x
+
+
+/* HELPER FUNCTIONS */
+
+static inline
+int ckrm_validate_icls(ckrm_icls_t* cls)
+{
+	ckrm_icls_t *validcls ;
+
+	list_for_each_entry(validcls, &ckrm_icls_list, icls_list) {
+		if (validcls == cls) {
+			cprintk(5,("cki: validated cls %p [%d]\n",
+				cls,cls->icls_id));
+			return 1 ;
+		}
+	}
+	return 0;
+}
+
+
+static inline
+void __init_ckrm_io_class(ckrm_icls_t* cls, void* super)
+{
+	/* Called with ckrm_icls_lock acquired */
+
+	memset(cls, 0, sizeof(ckrm_icls_t));
+
+	cls->icls_share = 10;
+
+	do_gettimeofday(&cls->icls_usage.epochstart);
+	cls->icls_usage.blksize = CKI_IOUSAGE_UNIT;
+
+	cls->icls_id = next_icls_id++; 
+        cls->super = super;
+
+	cprintk(5,("cki: __init_ckrm_ioclass cls %p [%d] \n",
+		cls,cls->icls_id));
+	cprintk(5,("cki: default cls %p [%d] share %lu\n",
+		&ckrm_icls_dflt,ckrm_icls_dflt.icls_id,ckrm_icls_dflt.icls_share));
+
+
+}
+	
+
+inline void cki_cls_get(ckrm_icls_t* cls)
+{
+	if (cls)
+		atomic_inc(&((cls)->icls_count));
+}
+
+inline void cki_cls_put(ckrm_icls_t* cls)
+{
+	/* FIXME - to really remove a class, we need to ensure all 
+           outstanding I/O's complete - for now just leave the class alone */
+
+	if ( (cls) && atomic_dec_and_test(&((cls)->icls_count))) {
+		printk("try to free cls %p:%d\n", cls, cls->icls_id);
+	}
+}
+
+
+/* 
+ * CKRM Core API functions for I/O classes.
+ */
+
+struct ckrm_io_class* ckrm_alloc_io_class(void* obj)
+{
+	ckrm_icls_t* cls = kmalloc(sizeof(ckrm_icls_t), GFP_KERNEL);
+	if (!cls)
+		return NULL;
+		
+	spin_lock(&ckrm_icls_lock);
+	__init_ckrm_io_class(cls, obj);
+	list_add(&(cls->icls_list), &ckrm_icls_list);
+	cki_cls_get(cls);
+	spin_unlock(&ckrm_icls_lock);
+
+	cprintk(5,("ckrm_alloc_io_class cls %p [%d] \n",
+		cls,cls->icls_id));
+
+	return cls;
+}
+
+int ckrm_free_io_class(struct ckrm_io_class* cls)
+{
+	if (cls->icls_id==ckrm_icls_dflt.icls_id) {
+		printk("Error: attempt to free default io class\n");
+		return -1;
+	}    
+	
+	/* FIXME - what happens to outstanding I/O */
+	cki_cls_put(cls);
+
+	cprintk(5,("ckrm_free_io_class cls %p [%d] \n",
+		cls,cls->icls_id));
+	return 0;
+}
+
+int ckrm_io_set_share(struct ckrm_io_class *cls, ulong share)
+{
+	/* strictly speaking, all the other io class shares should also be 
+	   checked for consistency with the new value here 
+	   e.g. all add up to 100
+	*/
+	if ((share < 0) || (share > 100))
+		return -1 ;
+	
+	cls->icls_share = share;
+
+	cprintk(5,("ckrm_io_set_share %ld cls %p [%d] \n",
+		share, cls,cls->icls_id));
+
+	return 0;
+}
+
+ulong ckrm_io_get_usage(struct ckrm_io_class *cls)
+{
+	/* FIXME - handle overflow of 24bit atomic_t */
+	/* not exact but good enough - keep total in atomic variable in
+	   ckrm_iousage to get an exact value */
+	
+	return (ulong) atomic_read(&cls->icls_usage.blkread)+
+		+ atomic_read(&cls->icls_usage.blkwrite);
+}
+
+struct ckrm_io_class *ckrm_dflt_io_class(void *obj) 
+{
+	ckrm_icls_dflt.super = obj;
+	return &ckrm_icls_dflt;
+}
+
+void ckrm_io_change_class(struct task_struct *tsk, 
+			  struct ckrm_io_class *newclass)
+{
+	if (newclass == tsk->io_class)
+		return ;
+
+	/* Could set tsk's class to ckrm_icls_dflt instead */
+	if (!ckrm_validate_icls(newclass))
+		return ;
+	
+	if (tsk->io_class)
+		cki_cls_put(tsk->io_class);
+		
+	cki_cls_get(newclass);
+	tsk->io_class = newclass ;
+
+	/* No reclassification of previously submitted io requests needed */
+
+	cprintk(5,("ckrm_io_change_class to %p [%d]\n",
+		newclass,newclass->icls_id));
+
+	return ;
+}
+
+
+
+
+
+EXPORT_SYMBOL(ckrm_alloc_io_class);
+EXPORT_SYMBOL(ckrm_free_io_class);
+EXPORT_SYMBOL(ckrm_io_set_share);
+EXPORT_SYMBOL(ckrm_io_get_usage);
+EXPORT_SYMBOL(ckrm_dflt_io_class);
+EXPORT_SYMBOL(ckrm_io_change_class);
+
+
diff -Nru a/include/linux/ckrm_io.h b/include/linux/ckrm_io.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm_io.h	Wed Sep 24 14:47:35 2003
@@ -0,0 +1,88 @@
+/* include/linux/ckrm_io.h : io control for CKRM
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2003
+ * 
+ * 
+ * I/O control functions of the CKRM kernel API 
+ *
+ * Latest version, more details at http://ckrm.sf.net
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+/* Changes
+ *
+ * 24 Sept 2003
+ *        Initial version with equal shares for all classes. 
+ *        Needs CFQ I/O scheduler.
+ */
+
+
+#ifndef _LINUX_CKRM_IO_H
+#define _LINUX_CKRM_IO_H
+
+#ifdef CONFIG_CKRM_IO
+
+#include <linux/ckrm.h>
+
+struct ckrm_io_class;
+
+#define CKI_IOUSAGE_UNIT  512
+#define DFLT_ICLS_SHARE   50
+
+typedef struct ckrm_iousage {
+	struct timeval       epochstart ; /* all measurements relative to this 
+					     start time */
+	unsigned long        blksize;  /* size of bandwidth unit */
+	atomic_t             blkread;  /* read units submitted to DD */
+	atomic_t             blkwrite; /* write units submitted to DD */
+	
+} ckrm_icls_usage_t;          /* per class I/O usage statistics */
+
+
+typedef struct ckrm_io_class {
+
+	struct list_head  icls_list ; /* links all io classes */
+	
+	/* percentage of io submitted may not translate to percentage of 
+	   delivered I/O bandwidth */
+
+	unsigned long    icls_share; /* percentage of all io submitted to 
+					DDs by io scheduler. */
+	ckrm_icls_usage_t   icls_usage;
+	 
+	atomic_t         icls_count; /* #tasks in this class */
+	int              icls_id;    
+	void*            super;      /* pointer to ckrm super class */
+					   
+}  ckrm_icls_t ;
+
+extern struct list_head ckrm_icls_list;
+extern spinlock_t  ckrm_icls_lock;
+extern ckrm_icls_t  ckrm_icls_dflt;
+
+
+extern void init_ckrm_icls_share(void);
+extern void ckrm_icls_set_share(int icls_id, int percent);
+
+#define icls_valid(cls)    (cls)
+#define io_class_notfreeable(cls) cki_cls_get(cls)
+
+/*
+ * A class which is not kmalloced should always have one more get then put
+ * to guarantee that kfree is not called
+ */
+
+
+
+
+#else // ! CONFIG_CKRM_IO
+
+#endif // CONFIG_CKRM_IO
+
+#endif //_LINUX_CKRM_IO_H
+
diff -Nru a/kernel/ckrm.c b/kernel/ckrm.c
--- a/kernel/ckrm.c	Wed Sep 24 14:47:35 2003
+++ b/kernel/ckrm.c	Wed Sep 24 14:47:35 2003
@@ -87,7 +87,7 @@
 DEF_CKRM_CLASS(cpu);
 DEF_CKRM_CLASS(mem);
 DEF_CKRM_CLASS(net);
-DEF_CKRM_CLASS(io);
+/* DEF_CKRM_CLASS(io); */
 
 
 struct ckrm_callbacks ckrm_callbacks;

 


