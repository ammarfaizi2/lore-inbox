Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbWF0Rqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWF0Rqd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWF0Rqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:46:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47023 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161262AbWF0RqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:46:14 -0400
Date: Tue, 27 Jun 2006 10:46:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20060627174607.11172.28265.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
References: <20060627174551.11172.49700.sendpatchset@schroedinger.engr.sgi.com>
Subject: [ZVC 4/4] Inline counters for single processor configurations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ZVC: inline counters handling on single processor systems.

Since we always use atomic operations to update counters on single
processor systems we do no need to distinguish between the case
when we have disabled interrupts or when we did not.

Each update is then only two atomic adds. Code size shrinks if we
switch to inlining instead of providing explicit functions in vmstat.c.

Inline ZVC counters:
-rw-r--r-- 1 root root 1865626 Jun 27 03:06 vmlinuz-2.6.17-mm3

Function calls:
-rw-r--r-- 1 root root 1865792 Jun 27 03:21 /boot/vmlinuz-2.6.17-mm3

Move zone_page_state() and single processor functions from vmstat.c
into vmstat.h. Remove all interrupt disable/enable for single processor.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm3/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm3.orig/include/linux/vmstat.h	2006-06-27 09:40:24.327710670 -0700
+++ linux-2.6.17-mm3/include/linux/vmstat.h	2006-06-27 10:36:46.363304430 -0700
@@ -84,6 +84,13 @@ extern void vm_events_fold_cpu(int cpu);
  */
 extern atomic_long_t vm_stat[NR_VM_ZONE_STAT_ITEMS];
 
+static inline void zone_page_state_add(long x, struct zone *zone,
+				 enum zone_stat_item item)
+{
+	atomic_long_add(x, &zone->vm_stat[item]);
+	atomic_long_add(x, &vm_stat[item]);
+}
+
 static inline unsigned long global_page_state(enum zone_stat_item item)
 {
 	long x = atomic_long_read(&vm_stat[item]);
@@ -138,19 +145,11 @@ extern void zone_statistics(struct zonel
 
 #endif /* CONFIG_NUMA */
 
-void __mod_zone_page_state(struct zone *, enum zone_stat_item item, int);
-void __inc_zone_page_state(struct page *, enum zone_stat_item);
-void __dec_zone_page_state(struct page *, enum zone_stat_item);
-
 #define __add_zone_page_state(__z, __i, __d)	\
 		__mod_zone_page_state(__z, __i, __d)
 #define __sub_zone_page_state(__z, __i, __d)	\
 		__mod_zone_page_state(__z, __i,-(__d))
 
-void mod_zone_page_state(struct zone *, enum zone_stat_item, int);
-void inc_zone_page_state(struct page *, enum zone_stat_item);
-void dec_zone_page_state(struct page *, enum zone_stat_item);
-
 #define add_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, __d)
 #define sub_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, -(__d))
 
@@ -159,12 +158,50 @@ static inline void zap_zone_vm_stats(str
 	memset(zone->vm_stat, 0, sizeof(zone->vm_stat));
 }
 
+#ifdef CONFIG_SMP
+void __mod_zone_page_state(struct zone *, enum zone_stat_item item, int);
+void __inc_zone_page_state(struct page *, enum zone_stat_item);
+void __dec_zone_page_state(struct page *, enum zone_stat_item);
+
+void mod_zone_page_state(struct zone *, enum zone_stat_item, int);
+void inc_zone_page_state(struct page *, enum zone_stat_item);
+void dec_zone_page_state(struct page *, enum zone_stat_item);
+
 extern void inc_zone_state(struct zone *, enum zone_stat_item);
 
-#ifdef CONFIG_SMP
 void refresh_cpu_vm_stats(int);
 void refresh_vm_stats(void);
-#else
+
+#else /* CONFIG_SMP */
+
+/*
+ * We do not maintain differentials in a single processor configuration.
+ * The functions directly modify the zone and global counters.
+ */
+static inline void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+				int delta)
+{
+	zone_page_state_add(delta, zone, item);
+}
+
+static inline void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	zone_page_state_add(1, page_zone(page), item);
+}
+
+static inline void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	zone_page_state_add(-1, page_zone(page), item);
+}
+
+/*
+ * We only use atomic operations to update counters. So there is no need to
+ * disable interrupts.
+ */
+#define inc_zone_page_state __inc_zone_page_state
+#define dec_zone_page_state __dec_zone_page_state
+#define mod_zone_page_state __mod_zone_page_state
+
 static inline void refresh_cpu_vm_stats(int cpu) { }
 static inline void refresh_vm_stats(void) { }
 #endif
Index: linux-2.6.17-mm3/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm3.orig/mm/vmstat.c	2006-06-27 09:40:25.632317407 -0700
+++ linux-2.6.17-mm3/mm/vmstat.c	2006-06-27 10:36:46.364280932 -0700
@@ -110,13 +110,6 @@ void vm_events_fold_cpu(int cpu)
  */
 atomic_long_t vm_stat[NR_VM_ZONE_STAT_ITEMS];
 
-static inline void zone_page_state_add(long x, struct zone *zone,
-				 enum zone_stat_item item)
-{
-	atomic_long_add(x, &zone->vm_stat[item]);
-	atomic_long_add(x, &vm_stat[item]);
-}
-
 #ifdef CONFIG_SMP
 
 #define STAT_THRESHOLD 32
@@ -303,62 +296,6 @@ void refresh_vm_stats(void)
 }
 EXPORT_SYMBOL(refresh_vm_stats);
 
-#else /* CONFIG_SMP */
-
-/*
- * We do not maintain differentials in a single processor configuration.
- * The functions directly modify the zone and global counters.
- */
-
-void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
-				int delta)
-{
-	zone_page_state_add(delta, zone, item);
-}
-EXPORT_SYMBOL(__mod_zone_page_state);
-
-void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
- 				int delta)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	zone_page_state_add(delta, zone, item);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(mod_zone_page_state);
-
-void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
-{
-	zone_page_state_add(1, page_zone(page), item);
-}
-EXPORT_SYMBOL(__inc_zone_page_state);
-
-void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
-{
-	zone_page_state_add(-1, page_zone(page), item);
-}
-EXPORT_SYMBOL(__dec_zone_page_state);
-
-void inc_zone_page_state(struct page *page, enum zone_stat_item item)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	zone_page_state_add(1, page_zone(page), item);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(inc_zone_page_state);
-
-void dec_zone_page_state(struct page *page, enum zone_stat_item item)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	zone_page_state_add( -1, page_zone(page), item);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(dec_zone_page_state);
 #endif
 
 #ifdef CONFIG_NUMA
