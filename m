Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTH2UGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbTH2UGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:06:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53899 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261823AbTH2T5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:57:16 -0400
Subject: [RFC/PATCH] CKRM memory control patch 2.6.0-test2
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: ckrm-tech <ckrm-tech@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1062186991.15245.842.camel@elinux05.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2003 15:56:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for implementing memory control in Class-based Kernel Resource
Management.
Applies over ckcore-A01-2.6.0-test2 patch posted earlier.

For more details, please refer to 
	http://ckrm.sf.net

and earlier postings on lkml.

-- Shailabh

-----------------------------------------------------------------------------------

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Aug 29 14:47:50 2003
+++ b/arch/i386/Kconfig	Fri Aug 29 14:47:50 2003
@@ -467,6 +467,61 @@
 	help
 	  This option adds CKRM support to the Kernel. Say N if you are
unsure.
 
+config CKRM_MEM
+	bool "Class based physical memory accounting"
+	default y
+	depends on CKRM
+	help
+	  Provide the basic support for collecting physical memory usage
information
+	  among classes. Say Y if you want to know the memory usage of each
class.
+
+config CKRM_MEM_DEBUG_BEANCOUNTING
+	bool "Debug bean counting of page usage"
+	default n
+	depends on CKRM_MEM
+	help
+	  We hope that all pages have already been assigned to a class before
+	  they are added to the active / inactive lists. by enabling this, you
can
+	  see whether there are pages has no class defined when inserting to
+	  or removing from the lists. Only say Y if you want to check.
+
+choice 
+	prompt "Page reclaim algorithm"
+	default CKRM_MEM_GLOBAL_LIST
+	depends on CKRM_MEM
+
+config CKRM_MEM_DEFAULT_RECLAIM
+	bool "System default reclaim way"
+	help
+	   Use this if you want the feature of counting page usage of each
class
+	   without any change to the system page reclamation behavior. 
+
+config CKRM_MEM_GLOBAL_LIST
+	bool "Using global page list"
+	help
+	   Use the global page active list and inactive list per zone with
class 
+	   information per page as perclass page lists conceptually. Say Y if
you 
+	   want the behavior to be similar to the default system behavior.
+
+config CKRM_MEM_PERCLASS_LIST
+	bool "Using per class page list"
+	help
+	   Maintain the page active and inactive lists per class in each zone.
+endchoice	   	   
+
+config CKRM_MEM_LRUORDER
+	bool "Leave unscaned page unmoved"	   
+	default y
+	depends on CKRM_MEM && CKRM_MEM_GLOBAL_LIST
+	help
+	  When scan inactive list to reclaim pages, some under-share classes
+	  are skipped. Pages belonging to those classes are checked but not 
+	  reclaimed. Say Y then those pages will stay at the tail of the list.
+	  In this case, those pages will still be checked during the next
scan.
+	  This may increase the reclaiming overhead. Say N, those pages will
be
+	  moved to the head of the list. The checking overhead is lower but it
+	  violates the appoximate LRU order.
+	  
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Fri Aug 29 14:47:50 2003
+++ b/fs/exec.c	Fri Aug 29 14:47:50 2003
@@ -46,6 +46,7 @@
 #include <linux/security.h>
 #include <linux/rmap-locking.h>
 #include <linux/ckrm.h>
+#include <linux/ckrm_mem.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -522,6 +523,16 @@
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
 	task_unlock(tsk);
+#ifdef CONFIG_CKRM_MEM
+	spin_lock(&mm->peertask_lock);
+	if (!list_empty(&tsk->peertask_list))
+		list_del_init(&tsk->peertask_list);
+	list_add_tail(&tsk->peertask_list, &mm->tasklist);
+	if (old_mm)
+		ckrm_mem_evaluate_mm(old_mm);
+	ckrm_mem_evaluate_mm(mm);
+	spin_unlock(&mm->peertask_lock);
+#endif
 	if (old_mm) {
 		if (active_mm != old_mm) BUG();
 		mmput(old_mm);
diff -Nru a/include/linux/ckrm_mem.h b/include/linux/ckrm_mem.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm_mem.h	Fri Aug 29 14:47:50 2003
@@ -0,0 +1,131 @@
+/* include/linux/ckrm_mem.h : memory control for CKRM
+ *
+ * Copyright (C) Jiantao Kong, IBM Corp. 2003
+ *           (C) Shailabh Nagar, IBM Corp. 2003
+ * 
+ * 
+ * Memory control functions of the CKRM kernel API 
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
+ * 28 Aug 2003
+ *        Created.
+ */
+
+#ifndef _LINUX_CKRM_MEM_H
+#define _LINUX_CKRM_MEM_H
+
+#ifdef CONFIG_CKRM_MEM
+
+#include <linux/ckrm.h>
+/*
+ * ! This part assume that there is only one node so that we only
maintain 
+ * MAX_NR_ZONES of page usage statistic inforamtion
+ */
+ 
+struct ckrm_mem_class;
+
+typedef struct ckrm_page_accounting {
+	unsigned long  flags; /* per zone per class flags, used for mark the
status of the list */
+	
+	unsigned long nr_active;   /* # of pages in active list, protected by
the zone's lru lock */
+	unsigned long nr_inactive; /* # of pages in active list */
+	
+	struct ckrm_mem_class* class; /* pointer to the memory share class
that owns this info */
+
+  #ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+	int shrink_max_scan;
+	int shrink_nr_pages;
+	int shrink_weight;		  /* calculated based on usage and share to choose
victims */
+	struct list_head victim_list;     /* used to chain victims together to
reclaim,
+						 protected by ACCT_VICTIM_BIT*/
+	struct list_head active_list;
+	struct list_head inactive_list;
+	atomic_t	refill_counter;
+  #endif
+}ckrm_pageusage_t;          /* per zone per class page usage statistics
*/
+
+typedef struct ckrm_mem_class {
+	struct list_head mcls_list;	/* list of all 1-level classes controlled
by reclaim arbitrator */
+
+	unsigned long        mcls_share;/* percentage of memory usage allowed
*/
+	unsigned long        nr_share;
+	unsigned long        nr_sharemax;
+	unsigned long        nr_sharemin;
+	
+	atomic_t             nr_total;  /* # of pages per class, including
active,inactive, maybe other pages*/
+	ckrm_pageusage_t     mcls_usage[MAX_NR_ZONES];
+	
+	atomic_t         mcls_count;
+	int              mcls_id;
+	void*            super; /* pointer to ckrm super class */
+} ckrm_mem_t;
+
+extern int next_memclass_index;
+
+extern spinlock_t       ckrm_memclass_lock;
+extern struct list_head ckrm_memclass_list;
+extern ckrm_mem_t  ckrm_memclass_default;
+extern ckrm_mem_t  pagecache_mem_class; 
+
+#ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+extern atomic_t nr_debug_active_inc[MAX_NR_ZONES];
+extern atomic_t nr_debug_active_dec[MAX_NR_ZONES];
+extern atomic_t nr_debug_inactive_inc[MAX_NR_ZONES];
+extern atomic_t nr_debug_inactive_dec[MAX_NR_ZONES];
+#endif
+
+/* used for shrink_zones when fail to reclaim pages from over-share
clasess*/
+extern int ckrm_memshare_disabled;
+
+extern void init_ckrm_memory_share(void);
+void ckrm_mem_set_class_share(int mcls_id, int percent, int sharemax,
int sharemin);
+struct pagevec;
+void __pagevec_lru_adjust(struct pagevec* pvec);
+void lru_cache_adjust_page(struct page *page);
+
+void ckrm_mem_evaluate_mm(struct mm_struct* mm);
+int ckrm_mem_evaluate_page(struct page* page);
+
+#define mem_class_notfreeable(cls) mem_class_get(cls)
+
+/*
+ * A class which is not kmalloced should always has one more get then
put
+ * to guarantee that kfree is not called
+ */
+
+#define page_class(page)	((ckrm_mem_t*)((page)->sharelink))
+#define
page_account(page)	((ckrm_pageusage_t*)(&(page_class(page)->mcls_usage[page->flags>>ZONE_SHIFT])))
+#define page_lrucharge(page)	((ckrm_pageusage_t*)((page)->chargelink))
+
+#define ACCT_VICTIM_BIT		24
+
+#define ACCT_READYNONE		0x00000000
+
+#define ACCT_READYSHRINK	0x00000001 /* shrink_list will try to reclaim
pages from this class */
+#define ACCT_READYSCAN_NOSHRINK 0x00000002 /* shrink_cache will scan
this class, but no reclaimable */
+#define ACCT_READYSCAN		(ACCT_READYSHRINK|ACCT_READYSCAN_NOSHRINK)
+#define ACCT_READYREFILL	0x00000004 /* refill_inactive will move page
from this class*/
+#define
ACCT_READYALL		(ACCT_READYSHRINK|ACCT_READYSCAN|ACCT_READYREFILL)
+
+#define page_readyshrink(page)	(page_account(page)->flags &
ACCT_READYSHRINK)
+#define page_readyscan(page)	(page_account(page)->flags &
ACCT_READYSCAN)
+#define page_readyrefill(page)	(page_account(page)->flags &
ACCT_READYREFILL)
+
+#define or_class_readyflag(acct,flag)  do{ (acct)->flags|=(flag);
}while(0)
+
+#else // ! CONFIG_CKRM_MEM
+
+#endif // CONFIG_CKRM_MEM
+
+#endif //_LINUX_CKRM_MEM_H
+
diff -Nru a/include/linux/ckrm_mem_inline.h
b/include/linux/ckrm_mem_inline.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ckrm_mem_inline.h	Fri Aug 29 14:47:50 2003
@@ -0,0 +1,251 @@
+/* include/linux/ckrm_mem_inline.h : memory control for CKRM
+ *
+ * Copyright (C) Jiantao Kong, IBM Corp. 2003
+ *           (C) Shailabh Nagar, IBM Corp. 2003
+ * 
+ * 
+ * Memory control functions of the CKRM kernel API 
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
+ * 28 Aug 2003
+ *        Created.
+ */
+
+
+#ifdef CONFIG_CKRM_MEM
+
+/*
+ * Currently, the class of an address is assigned to the class with max
share
+ * If 2 classes have same share, assign to the class with smaller
mcls_id.
+ * Simply replace this function for other policies.
+ */
+static inline int ckrm_mem_share_compare(ckrm_mem_t* a, ckrm_mem_t* b)
+{
+	if (a->nr_share<b->nr_share)
+		return -1;
+	else if (a->nr_share>b->nr_share)
+		return 1;
+	else {
+		if (a->mcls_id>b->mcls_id)
+			return -1;
+		else if (a->mcls_id<b->mcls_id)
+			return 1;
+		else
+			return 0;
+	}
+}
+
+static inline void mem_class_get(ckrm_mem_t* cls)
+{
+	if (cls)
+		atomic_inc(&((cls)->mcls_count));
+}
+
+static inline void mem_class_put(ckrm_mem_t* cls)
+{
+	if ( (cls) && atomic_dec_and_test(&((cls)->mcls_count)) ) {
+		printk("try to free cls %p:%d\n", cls, cls->mcls_id);
+		//kfree(cls);
+	}	
+}
+
+static inline void set_page_lrucharge(struct page* page,
ckrm_pageusage_t* acct)
+{
+        (ckrm_pageusage_t*)((page)->chargelink)=acct;
+        mem_class_get(acct->class);
+}
+
+static inline void set_page_lrucharge_byclass(struct page* page)
+{
+	ckrm_mem_t* cls = page_class(page);
+	if (cls) {
+		(page)->chargelink = &((cls)->mcls_usage[page->flags>>ZONE_SHIFT]);
+		mem_class_get(cls);
+	}
+}
+
+static inline void clear_page_lrucharge(struct page* page)
+{
+	ckrm_pageusage_t* charge = page_lrucharge(page);
+	if (charge) {
+		mem_class_put(charge->class);
+		page->chargelink = NULL;
+	}
+}
+
+static inline void set_page_account_nolock(struct page* page,
ckrm_mem_t* cls)
+{
+	if (cls) {
+		(page)->sharelink = cls;
+		mem_class_get(cls);
+		atomic_inc( &(page_class(page)->nr_total) );
+	}
+}
+
+static inline void ckrm_set_page_account(struct page* page, ckrm_mem_t*
cls)
+{
+	pte_chain_lock(page);
+	set_page_account_nolock(page,cls);
+	pte_chain_unlock(page);
+}
+
+static inline void clear_page_account_nolock(struct page* page)
+{
+	if (page->sharelink) {
+		atomic_dec(&page_class(page)->nr_total);
+		mem_class_put( page_class(page) );
+		page->sharelink=NULL;
+	}
+}
+
+static inline void clear_page_account(struct page* page)
+{
+	pte_chain_lock(page);
+	clear_page_account_nolock(page);
+	pte_chain_unlock(page);
+}
+
+static inline void reset_page_account(struct page* page, ckrm_mem_t*
newcls)
+{
+	pte_chain_lock(page);
+	clear_page_account_nolock(page);
+	ckrm_set_page_account(page,newcls);
+	pte_chain_unlock(page);
+}
+
+
+static inline void mem_class_inc_active(struct page* page)
+{
+	if (page_lrucharge(page))
+		page_lrucharge(page)->nr_active++;
+  #ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+	else
+		atomic_inc(nr_debug_active_inc+(page->flags>>ZONE_SHIFT));
+  #endif
+}
+
+static inline void mem_class_dec_active(struct page* page)
+{
+	if (page_lrucharge(page))
+		page_lrucharge(page)->nr_active--;
+  #ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+	else
+		atomic_inc(nr_debug_active_dec+(page->flags>>ZONE_SHIFT));
+  #endif
+}
+
+static inline void mem_class_inc_inactive(struct page* page)
+{
+	if (page_lrucharge(page))
+		page_lrucharge(page)->nr_inactive++;
+  #ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+	else
+		atomic_inc(nr_debug_inactive_inc+(page->flags>>ZONE_SHIFT));
+  #endif
+}
+
+static inline void mem_class_dec_inactive(struct page* page)
+{
+	if (page_lrucharge(page))
+		page_lrucharge(page)->nr_inactive--;
+  #ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+	else
+		atomic_inc(nr_debug_inactive_dec+(page->flags>>ZONE_SHIFT));
+  #endif
+}
+
+static inline unsigned long ckrm_mem_available(void)
+{
+	int i;
+	unsigned long available = 0;
+	
+	struct zone* zones = contig_page_data.node_zones;
+	for (i=0; i<MAX_NR_ZONES; i++) {
+		available += zones[i].nr_active;
+		available += zones[i].nr_inactive;
+		available += zones[i].free_pages;
+	}
+	return available;
+}
+
+static inline unsigned long ckrm_mem_total(void)
+{
+	int i;
+	unsigned long total = 0;
+
+	struct zone* zones = contig_page_data.node_zones;
+	for (i=0; i<MAX_NR_ZONES; i++) {
+		total += zones[i].present_pages;
+	}
+	return total;
+}
+
+/*
+ * FIXME:
+ *  To associate zone with the mcls_usage member in ckrm_mem_t, we may
+ *  need modify the zone struct, but now I just do a match for contig
+ */
+static inline int zone_index(struct zone* zone)
+{
+	struct zone* zones = contig_page_data.node_zones;
+	if (zone-zones<0 || zone-zones>=MAX_NR_ZONES)
+		BUG();
+	return (zone-zones);
+}
+
+static inline
+void set_class_readyflag(ckrm_pageusage_t* acct, int flag)
+{
+	(acct)->flags &= ~ACCT_READYALL;
+	(acct)->flags |= flag&ACCT_READYALL;
+}
+
+#else // !CONFIG_CKRM_MEM
+
+#define ckrm_set_page_account(a,b) do{}while(0)
+
+#endif // CONFIG_CKRM_MEM
+
+#if defined CONFIG_CKRM_MEM_GLOBAL_LIST || defined
CONFIG_CKRM_MEM_PERCLASS_LIST
+
+static inline void ckrm_mem_add_page_active(struct page* page)
+{
+	set_page_lrucharge_byclass(page);
+	mem_class_inc_active(page);
+}
+static inline void ckrm_mem_add_page_inactive(struct page* page)
+{
+	set_page_lrucharge_byclass(page);
+	mem_class_inc_inactive(page);
+}
+
+static inline void ckrm_mem_del_page_active(struct page* page)
+{
+	mem_class_dec_active(page);
+	clear_page_lrucharge(page);
+}	
+
+static inline void ckrm_mem_del_page_inactive(struct page* page)
+{
+	mem_class_dec_inactive(page);
+	clear_page_lrucharge(page);
+}
+
+#else
+
+#define  ckrm_mem_add_page_active(a) do{}while(0)
+#define  ckrm_mem_add_page_inactive(a) do{}while(0)
+#define  ckrm_mem_del_page_active(a) do{}while(0)
+#define  ckrm_mem_del_page_inactive(a) do{}while(0)
+
+#endif
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Fri Aug 29 14:47:50 2003
+++ b/include/linux/mm.h	Fri Aug 29 14:47:50 2003
@@ -196,6 +196,10 @@
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
+#ifdef CONFIG_CKRM_MEM
+	void *sharelink;	/* Don't use this ptr, use the MACRO in memshare.h */
+	void *chargelink;	/* which class's LRU list is this page charged for
*/
+#endif
 };
 
 /*
diff -Nru a/include/linux/mm_inline.h b/include/linux/mm_inline.h
--- a/include/linux/mm_inline.h	Fri Aug 29 14:47:50 2003
+++ b/include/linux/mm_inline.h	Fri Aug 29 14:47:50 2003
@@ -2,14 +2,24 @@
 static inline void
 add_page_to_active_list(struct zone *zone, struct page *page)
 {
+	ckrm_mem_add_page_active(page);
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+	list_add(&page->lru, &(page_lrucharge(page)->active_list));
+#else	
 	list_add(&page->lru, &zone->active_list);
+#endif
 	zone->nr_active++;
 }
 
 static inline void
 add_page_to_inactive_list(struct zone *zone, struct page *page)
 {
+	ckrm_mem_add_page_inactive(page);
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+	list_add(&page->lru, &(page_lrucharge(page)->inactive_list));
+#else
 	list_add(&page->lru, &zone->inactive_list);
+#endif
 	zone->nr_inactive++;
 }
 
@@ -18,6 +28,7 @@
 {
 	list_del(&page->lru);
 	zone->nr_active--;
+	ckrm_mem_del_page_active(page);
 }
 
 static inline void
@@ -25,6 +36,7 @@
 {
 	list_del(&page->lru);
 	zone->nr_inactive--;
+	ckrm_mem_del_page_inactive(page);
 }
 
 static inline void
@@ -34,7 +46,9 @@
 	if (PageActive(page)) {
 		ClearPageActive(page);
 		zone->nr_active--;
+		ckrm_mem_del_page_active(page);
 	} else {
 		zone->nr_inactive--;
+		ckrm_mem_del_page_inactive(page);
 	}
 }
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Fri Aug 29 14:47:50 2003
+++ b/include/linux/mmzone.h	Fri Aug 29 14:47:50 2003
@@ -78,10 +78,12 @@
 
 	ZONE_PADDING(_pad1_)
 
-	spinlock_t		lru_lock;	
+	spinlock_t		lru_lock;
+#ifndef CONFIG_CKRM_MEM_PERCLASS_LIST
 	struct list_head	active_list;
 	struct list_head	inactive_list;
 	atomic_t		refill_counter;
+#endif
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
 	int			all_unreclaimable; /* All pages pinned */
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Aug 29 14:47:50 2003
+++ b/include/linux/sched.h	Fri Aug 29 14:47:50 2003
@@ -222,6 +222,11 @@
 	struct kioctx		*ioctx_list;
 
 	struct kioctx		default_kioctx;
+#ifdef CONFIG_CKRM_MEM
+	struct ckrm_mem_class*	memclass;
+	struct list_head	tasklist; /* list of all tasks sharing this address
space */
+	spinlock_t		peertask_lock; /* protect above tasklist */
+#endif
 };
 
 extern int mmlist_nr;
@@ -463,6 +468,9 @@
 	struct ckrm_net_class *net_class;
 	struct ckrm_io_class  *io_class;
 	void *ckrm_client_data;              
+#ifdef CONFIG_CKRM_MEM
+	struct list_head peertask_list; /* tasks sharing mm */
+#endif
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Fri Aug 29 14:47:50 2003
+++ b/init/main.c	Fri Aug 29 14:47:50 2003
@@ -8,7 +8,6 @@
  *  Moan early if gcc is old, avoiding bogus kernels - Paul Gortmaker,
May '96
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 
  */
-
 #define __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
@@ -37,6 +36,7 @@
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
+#include <linux/ckrm_mem.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -451,6 +451,9 @@
 #endif
 #if defined(CONFIG_SYSVIPC)
 	ipc_init();
+#endif
+#ifdef CONFIG_CKRM_MEM
+	init_ckrm_memory_share();
 #endif
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
diff -Nru a/kernel/ckrm.c b/kernel/ckrm.c
--- a/kernel/ckrm.c	Fri Aug 29 14:47:50 2003
+++ b/kernel/ckrm.c	Fri Aug 29 14:47:50 2003
@@ -49,18 +49,17 @@
 void ckrm_##res##_change_class(struct task_struct *tsk,				\
                                struct ckrm_##res##_class *cls) {		\
         tsk->res##_class = cls;							\
-}			                                                        \	
+}										\
 EXPORT_SYMBOL(ckrm_##res##_change_class);					\
 EXPORT_SYMBOL(ckrm_alloc_##res##_class);					\
 EXPORT_SYMBOL(ckrm_free_##res##_class);						\
 EXPORT_SYMBOL(ckrm_##res##_set_share);						\
 EXPORT_SYMBOL(ckrm_##res##_get_usage);						\
-EXPORT_SYMBOL(ckrm_dflt_##res##_class)                                        
-
+EXPORT_SYMBOL(ckrm_dflt_##res##_class)
 
 
 DEF_CKRM_CLASS(cpu);
-DEF_CKRM_CLASS(mem);
+/*DEF_CKRM_CLASS(mem);*/
 DEF_CKRM_CLASS(net);
 DEF_CKRM_CLASS(io);
 
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Fri Aug 29 14:47:50 2003
+++ b/kernel/exit.c	Fri Aug 29 14:47:50 2003
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/ckrm.h>
+#include <linux/ckrm_mem.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -444,6 +445,12 @@
 	/* more a memory barrier than a real lock */
 	task_lock(tsk);
 	tsk->mm = NULL;
+#ifdef CONFIG_CKRM_MEM
+	spin_lock(&mm->peertask_lock);
+	list_del_init(&tsk->peertask_list);
+	ckrm_mem_evaluate_mm(mm);
+	spin_unlock(&mm->peertask_lock);
+#endif
 	enter_lazy_tlb(mm, current);
 	task_unlock(tsk);
 	mmput(mm);
@@ -567,6 +574,7 @@
 	struct task_struct *t;
 
 	ckrm_cb_exit(tsk);
+	ckrm_mem_change_class(tsk, NULL);
 
 	if (signal_pending(tsk) && !tsk->signal->group_exit
 	    && !thread_group_empty(tsk)) {
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Aug 29 14:47:50 2003
+++ b/kernel/fork.c	Fri Aug 29 14:47:50 2003
@@ -31,6 +31,9 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/ckrm.h>
+#include <linux/ckrm_mem.h>
+#include <linux/rmap-locking.h>
+#include <linux/ckrm_mem_inline.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -216,6 +219,9 @@
 
 	/* One for us, one for whoever does the "release_task()" (usually
parent) */
 	atomic_set(&tsk->usage,2);
+#ifdef CONFIG_CKRM_MEM	
+	INIT_LIST_HEAD(&tsk->peertask_list);
+#endif
 	return tsk;
 }
 
@@ -347,6 +353,12 @@
 	mm->ioctx_list = NULL;
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx,
*mm);
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
+#ifdef CONFIG_CKRM_MEM
+	INIT_LIST_HEAD(&mm->tasklist);
+	mm->memclass = &ckrm_memclass_default;
+	mem_class_get(&ckrm_memclass_default);
+	mm->peertask_lock = SPIN_LOCK_UNLOCKED;
+#endif
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
@@ -381,6 +393,13 @@
 	BUG_ON(mm == &init_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
+#ifdef CONFIG_CKRM_MEM
+	/* class can be null and mm's tasklist can be empty here */
+	if (mm->memclass) {
+		mem_class_put(mm->memclass);
+		mm->memclass = NULL;
+	}
+#endif
 	free_mm(mm);
 }
 
@@ -491,6 +510,17 @@
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
+#ifdef CONFIG_CKRM_MEM
+	spin_lock(&mm->peertask_lock);
+	if (!list_empty(&tsk->peertask_list)) {
+		printk("Should not happen here, check it\n");
+		list_del_init(&tsk->peertask_list);
+	}
+	list_add_tail(&tsk->peertask_list, &mm->tasklist);
+	if (tsk->mem_class && mm->memclass != tsk->mem_class) 
+		ckrm_mem_evaluate_mm(mm);
+	spin_unlock(&mm->peertask_lock);
+#endif
 	return 0;
 
 free_pt:
diff -Nru a/mm/Makefile b/mm/Makefile
--- a/mm/Makefile	Fri Aug 29 14:47:50 2003
+++ b/mm/Makefile	Fri Aug 29 14:47:50 2003
@@ -12,3 +12,5 @@
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+
+obj-$(CONFIG_CKRM_MEM)	+= ckrm_mem.o
diff -Nru a/mm/ckrm_mem.c b/mm/ckrm_mem.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/mm/ckrm_mem.c	Fri Aug 29 14:47:50 2003
@@ -0,0 +1,359 @@
+/* linux/mm/ckrm_mem.c : memory control for CKRM
+ *
+ * Copyright (C) Jiantao Kong, IBM Corp. 2003
+ *           (C) Shailabh Nagar, IBM Corp. 2003
+ * 
+ * 
+ * Memory control functions of the CKRM kernel API 
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
+ * 28 Aug 2003
+ *        Created.
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
+#include <linux/ckrm.h>
+#include <linux/ckrm_mem.h>
+#include <linux/ckrm_mem_inline.h>
+
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+
+int next_memclass_index = 0;
+
+/* all 1-level memory_share_class are chained together for reclaim
arbitrator control */
+struct list_head  ckrm_memclass_list =
LIST_HEAD_INIT(ckrm_memclass_list);
+spinlock_t ckrm_memclass_lock = SPIN_LOCK_UNLOCKED;
+
+EXPORT_SYMBOL(ckrm_memclass_list);
+EXPORT_SYMBOL(ckrm_memclass_lock);
+
+/*
+ * All processes which are not explicitly classfied are in default
class, 
+ */
+ckrm_mem_t  ckrm_memclass_default;
+
+#ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+/*
+ * Record per zone information about how many pages have no class info
when insert to/remove from
+ * the active/inactive list.
+ */
+atomic_t nr_debug_active_inc[MAX_NR_ZONES];
+atomic_t nr_debug_active_dec[MAX_NR_ZONES];
+atomic_t nr_debug_inactive_inc[MAX_NR_ZONES];
+atomic_t nr_debug_inactive_dec[MAX_NR_ZONES];
+
+EXPORT_SYMBOL(nr_debug_active_inc);
+EXPORT_SYMBOL(nr_debug_active_dec);
+EXPORT_SYMBOL(nr_debug_inactive_inc);
+EXPORT_SYMBOL(nr_debug_inactive_dec);
+
+#endif
+
+int ckrm_memshare_disabled = 0;
+
+/* default init give each class 10% of zone memory, 0 for min, and
total for max */
+static inline 
+void __init_ckrm_mem_class(ckrm_mem_t* cls, void* super)
+{
+	int i;
+	memset(cls, 0, sizeof(ckrm_mem_t));
+
+	cls->mcls_share = 10;
+	cls->nr_share = ckrm_mem_available()*cls->mcls_share/100;
+	cls->nr_sharemax = ckrm_mem_total();
+	cls->nr_sharemin = 0;
+
+	cls->mcls_id = next_memclass_index++;
+        cls->super = super;
+
+	for (i=0; i<MAX_NR_ZONES; i++) {
+		cls->mcls_usage[i].class = cls;
+  #ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+		INIT_LIST_HEAD(&cls->mcls_usage[i].active_list); 
+		INIT_LIST_HEAD(&cls->mcls_usage[i].inactive_list);
+		atomic_set(&cls->mcls_usage[i].refill_counter,0); 
+  #endif
+	}
+}
+
+/*
+ * Calling from the init process. 
+ */
+void init_ckrm_memory_share(void)
+{
+	int i;
+	spin_lock(&ckrm_memclass_lock);
+	__init_ckrm_mem_class(&ckrm_memclass_default, NULL);
+	mem_class_notfreeable( &ckrm_memclass_default );
+	list_add(&ckrm_memclass_default.mcls_list, &ckrm_memclass_list);
+	spin_unlock(&ckrm_memclass_lock);
+
+  #ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+	for (i=0; i<MAX_NR_ZONES; i++) {
+		atomic_set(nr_debug_active_inc+i,0);
+		atomic_set(nr_debug_active_dec+i,0);
+		atomic_set(nr_debug_inactive_inc+i,0);
+		atomic_set(nr_debug_inactive_dec+i,0);
+	}
+  #endif
+}
+
+/* 
+ * Interface for the CKRM Classification engine including memory class
allocation/free
+ * setshare, getusage, and so on.
+ */
+struct ckrm_mem_class* ckrm_alloc_mem_class(void* obj)
+{
+	ckrm_mem_t* cls = kmalloc(sizeof(ckrm_mem_t), GFP_KERNEL);
+	if (!cls)
+		return NULL;
+		
+	spin_lock(&ckrm_memclass_lock);
+	__init_ckrm_mem_class(cls, obj);
+	list_add(&(cls->mcls_list), &ckrm_memclass_list);
+	mem_class_get(cls);
+	spin_unlock(&ckrm_memclass_lock);
+
+	return cls;
+}
+
+int ckrm_free_mem_class(struct ckrm_mem_class* cls)
+{
+	if (cls->mcls_id==ckrm_memclass_default.mcls_id) {
+		printk("Try to free the default class\n");
+		return -1;
+	}    
+	mem_class_put(cls);
+	return 0;
+}
+
+int ckrm_mem_set_share(struct ckrm_mem_class *cls, ulong share)
+{
+	cls->mcls_share = share;
+	cls->nr_share = ckrm_mem_available()*cls->mcls_share/100;
+	if (cls->nr_share<cls->nr_sharemin)
+		cls->nr_share=cls->nr_sharemin+SWAP_CLUSTER_MAX;
+	return 0;
+}
+
+ulong ckrm_mem_get_usage(struct ckrm_mem_class *cls)
+{
+	return (ulong)atomic_read(&cls->nr_total);
+}
+
+struct ckrm_mem_class *ckrm_dflt_mem_class(void *obj) 
+{
+	ckrm_memclass_default.super = obj;
+	return &ckrm_memclass_default;
+}
+
+static inline 
+int class_migrate_pmd(struct mm_struct* mm, struct vm_area_struct* vma,
pmd_t* pmdir, 
+		unsigned long address, unsigned long end)
+{
+	pte_t* pte;
+	unsigned long pmd_end;
+	
+	if (pmd_none(*pmdir))
+		return 0;
+	BUG_ON(pmd_bad(*pmdir));
+	
+	pte = pte_offset_map(pmdir,address);
+	pmd_end = (address+PMD_SIZE)&PMD_MASK;
+	if (end>pmd_end)
+		end = pmd_end;
+	
+	do {
+		if (pte_present(*pte)) {
+			ckrm_mem_t* orgcls;
+			struct page* page = pte_page(*pte);
+			
+			orgcls = page_class(page);
+			ckrm_mem_evaluate_page(page);
+			if(orgcls != page_class(page))
+				lru_cache_adjust_page(page);
+		}
+		address += PAGE_SIZE;
+		pte++;
+	} while(address && (address<end));
+	return 0;
+}
+
+static inline 
+int class_migrate_pgd(struct mm_struct* mm, struct vm_area_struct* vma,
pgd_t* pgdir, 
+		unsigned long address, unsigned long end)
+{
+	pmd_t* pmd;
+	unsigned long pgd_end;
+	
+	if (pgd_none(*pgdir))
+		return 0;
+	BUG_ON(pgd_bad(*pgdir));
+	
+	pmd = pmd_offset(pgdir,address);
+	pgd_end = (address+PGDIR_SIZE)&PGDIR_MASK;
+	
+	if (pgd_end && (end>pgd_end))
+		end = pgd_end;
+	
+	do {
+		class_migrate_pmd(mm,vma,pmd,address,end);
+		address =  (address+PMD_SIZE)&PMD_MASK;
+		pmd++;
+	} while (address && (address<end));
+	return 0;
+}
+
+static inline
+int class_migrate_vma(struct mm_struct* mm, struct vm_area_struct* vma)
+{
+	pgd_t* pgdir;
+	unsigned long address, end;
+	
+	address = vma->vm_start;
+	end = vma->vm_end;
+	
+	pgdir = pgd_offset(vma->vm_mm, address);
+	do {
+		class_migrate_pgd(mm,vma,pgdir,address,end);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		pgdir++;
+	}while( address && (address<end) );
+	return 0;
+}
+
+void ckrm_mem_change_class(struct task_struct *tsk, struct
ckrm_mem_class *newclass)
+{
+	struct mm_struct* mm;
+	struct vm_area_struct* vma;
+	ckrm_mem_t* prev_mmcls;
+	
+	if ( !tsk->mm || newclass==tsk->mem_class )
+		return;
+
+	if (tsk->mem_class)
+		mem_class_put(tsk->mem_class);
+	tsk->mem_class = newclass;
+	if (!newclass)
+		newclass = &ckrm_memclass_default;
+	mem_class_get(newclass);
+
+	mm = tsk->active_mm;
+	prev_mmcls = mm->memclass;
+	
+	spin_lock(&mm->peertask_lock);
+	ckrm_mem_evaluate_mm(mm);
+	spin_unlock(&mm->peertask_lock);	
+
+	if (mm->memclass!=prev_mmcls) {
+		/* Go through all VMA to migrate pages */
+		down_read(&mm->mmap_sem);
+		vma = mm->mmap;
+		while(vma) {
+			class_migrate_vma(mm, vma);
+			vma = vma->vm_next;
+		}
+		up_read(&mm->mmap_sem);
+	}
+	return;
+}
+
+void ckrm_mem_set_class_share(int mcls_id, int percent, int sharemax,
int sharemin)
+{
+	ckrm_mem_t* cls;
+	if (sharemax-sharemin<2*SWAP_CLUSTER_MAX)
+		return;
+
+	spin_lock(&ckrm_memclass_lock);
+	list_for_each_entry(cls, &ckrm_memclass_list, mcls_list) {
+		if (cls->mcls_id==mcls_id) {
+			/* FIXME: check the data consistency*/
+			cls->mcls_share = percent;
+			cls->nr_share = ckrm_mem_available()*cls->mcls_share/100;
+			cls->nr_sharemax = sharemax;
+			cls->nr_sharemin = sharemin;
+			if (cls->nr_share<cls->nr_sharemin)
+				cls->nr_share=cls->nr_sharemin+SWAP_CLUSTER_MAX;
+			break;
+		}
+	}
+	spin_unlock(&ckrm_memclass_lock);
+	return;
+}
+
+/* this function is called with mm->peertask_lock hold */
+void ckrm_mem_evaluate_mm(struct mm_struct* mm)
+{
+	struct task_struct* task;
+	ckrm_mem_t* maxshareclass = NULL;
+	struct vm_area_struct* vma;
+	
+	if (list_empty(&mm->tasklist)) {
+		/* We leave the mm->memclass untouched since we believe that one mm
with 
+		 * no task associated will be deleted soon or attach with anothe task
later
+		 */
+		return; 
+	}
+
+	list_for_each_entry(task, &mm->tasklist, peertask_list) {
+		ckrm_mem_t* cls = task->mem_class;
+		if (!cls)
+			continue;
+		if (!maxshareclass || ckrm_mem_share_compare(maxshareclass,cls)<0 ) 
+			maxshareclass = cls;
+	}
+	
+	if (!maxshareclass) {
+		maxshareclass = &ckrm_memclass_default;
+	}	
+	if (mm->memclass != maxshareclass ) {
+		mem_class_get(maxshareclass);
+		if (mm->memclass)
+			mem_class_put(mm->memclass);
+		mm->memclass = maxshareclass;
+		
+		/* Go through all VMA to migrate pages */
+		down_read(&mm->mmap_sem);
+		vma = mm->mmap;
+		while(vma) {
+			class_migrate_vma(mm, vma);
+			vma = vma->vm_next;
+		}
+		up_read(&mm->mmap_sem);
+	}
+	return;
+}
+
+EXPORT_SYMBOL(ckrm_alloc_mem_class);
+EXPORT_SYMBOL(ckrm_free_mem_class);
+EXPORT_SYMBOL(ckrm_mem_set_share);
+EXPORT_SYMBOL(ckrm_mem_get_usage);
+EXPORT_SYMBOL(ckrm_dflt_mem_class);
+EXPORT_SYMBOL(ckrm_mem_change_class);
+
+EXPORT_SYMBOL(ckrm_mem_set_class_share);
+
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Fri Aug 29 14:47:50 2003
+++ b/mm/filemap.c	Fri Aug 29 14:47:50 2003
@@ -36,6 +36,9 @@
  * FIXME: remove all knowledge of the buffer layer from the core VM
  */
 #include <linux/buffer_head.h> /* for generic_osync_inode */
+#include <linux/ckrm_mem.h>
+#include <linux/rmap-locking.h>
+#include <linux/ckrm_mem_inline.h>
 
 #include <asm/uaccess.h>
 #include <asm/mman.h>
@@ -229,6 +232,16 @@
 		if (!error) {
 			SetPageLocked(page);
 			___add_to_page_cache(page, mapping, offset);
+#ifdef CONFIG_CKRM_MEM
+			pte_chain_lock(page);
+			if ( !page_mapped(page) && !page_class(page) ) {
+				if (current->mem_class)
+					set_page_account_nolock(page, current->mem_class);
+				else
+					set_page_account_nolock(page, &ckrm_memclass_default);
+			}		
+			pte_chain_unlock(page);
+#endif
 		} else {
 			page_cache_release(page);
 		}
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Fri Aug 29 14:47:50 2003
+++ b/mm/memory.c	Fri Aug 29 14:47:50 2003
@@ -45,6 +45,8 @@
 #include <linux/pagemap.h>
 #include <linux/vcache.h>
 #include <linux/rmap-locking.h>
+#include <linux/ckrm_mem.h>
+#include <linux/ckrm_mem_inline.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -1306,6 +1308,12 @@
 		}
 		mm->rss++;
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+if (!mm->memclass) {
+	printk("Aa In Do no page, mm->memclass=NULL\n");
+	mm->memclass = &ckrm_memclass_default;
+	mem_class_get( &ckrm_memclass_default);
+}	
+                ckrm_set_page_account(page, mm->memclass);
 		lru_cache_add_active(page);
 		mark_page_accessed(page);
 	}
@@ -1378,6 +1386,12 @@
 		}
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
+if (!mm->memclass) {
+	printk("In Do no page, mm->memclass=NULL\n");
+	mm->memclass = &ckrm_memclass_default;
+	mem_class_get( &ckrm_memclass_default);
+}	
+                ckrm_set_page_account(page, mm->memclass);
 		lru_cache_add_active(page);
 		new_page = page;
 	}
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Fri Aug 29 14:47:50 2003
+++ b/mm/page_alloc.c	Fri Aug 29 14:47:50 2003
@@ -31,6 +31,9 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/ckrm_mem.h>
+#include <linux/rmap-locking.h>
+#include <linux/ckrm_mem_inline.h>
 
 #include <asm/tlbflush.h>
 
@@ -447,6 +450,9 @@
 	unsigned long flags;
 
 	kernel_map_pages(page, 1, 0);
+#ifdef CONFIG_CKRM_MEM
+	clear_page_account_nolock(page);
+#endif
 	inc_page_state(pgfree);
 	free_pages_check(__FUNCTION__, page);
 	pcp = &zone->pageset[get_cpu()].pcp[cold];
@@ -1270,9 +1276,11 @@
 		}
 		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
+#ifndef CONFIG_CKRM_MEM_PERCLASS_LIST
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		atomic_set(&zone->refill_counter, 0);
+#endif
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
 		if (!size)
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Fri Aug 29 14:47:50 2003
+++ b/mm/rmap.c	Fri Aug 29 14:47:50 2003
@@ -29,6 +29,8 @@
 #include <linux/rmap-locking.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
+#include <linux/ckrm_mem.h>
+#include <linux/ckrm_mem_inline.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -80,6 +82,77 @@
 	return (unsigned long)pte_chain | idx;
 }
 
+#ifdef CONFIG_CKRM_MEM
+
+/* this function is called with pte_chain_lock hold */
+static int ckrm_mem_evaluate_page_byadd(struct page* page, pte_t *ptep)
+{
+	ckrm_mem_t* pgcls = page_class(page);
+	struct mm_struct* mm =ptep_to_mm(ptep);
+	BUG_ON(!mm->memclass);
+
+	if (pgcls==mm->memclass)
+		return 0;
+	if (!pgcls || page->pte.direct==0) {
+		clear_page_account_nolock(page);
+		set_page_account_nolock(page, mm->memclass);
+		return 0;
+	}
+	if (ckrm_mem_share_compare(pgcls,mm->memclass)<0) {
+		clear_page_account_nolock(page);
+		set_page_account_nolock(page, mm->memclass);
+		return 1;
+	}
+	return 0;
+}
+
+int ckrm_mem_evaluate_page(struct page* page)
+{
+	struct pte_chain *pc;
+	struct pte_chain *start;
+	struct pte_chain *next;
+	ckrm_mem_t* pgcls = page_class(page);
+	ckrm_mem_t* maxshareclass = NULL;
+
+	if (page->pte.direct == 0) {
+		clear_page_account_nolock(page);
+		set_page_account_nolock(page, &ckrm_memclass_default);
+		return 1;
+	}
+	if (PageDirect(page)) {
+		struct mm_struct* mm =ptep_to_mm(page->pte.direct);
+		if (pgcls==mm->memclass)
+			return 0;
+		clear_page_account_nolock(page);
+		set_page_account_nolock(page, mm->memclass);
+		return 1;
+	}
+
+	start = page->pte.chain;
+
+	for (pc = start; pc; pc = next) {
+		int i;
+		next = pte_chain_next(pc);
+		if (next)
+			prefetch(next);
+		for (i = pte_chain_idx(pc); i < NRPTE; i++) {
+			pte_t* ptep = rmap_ptep_map(pc->ptes[i]);
+			struct mm_struct* mm =ptep_to_mm(ptep);
+			if (!maxshareclass ||
ckrm_mem_share_compare(maxshareclass,mm->memclass)<0)
+				maxshareclass = mm->memclass;
+		}
+	}
+
+	if (!maxshareclass)
+		maxshareclass = &ckrm_memclass_default;
+	if (pgcls != maxshareclass ) {
+		clear_page_account_nolock(page);
+		set_page_account_nolock(page, maxshareclass);
+		return 1;
+	}
+	return 0;
+}
+#endif
 /*
  * pte_chain list management policy:
  *
@@ -169,12 +242,18 @@
 {
 	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
 	struct pte_chain *cur_pte_chain;
+#ifdef CONFIG_CKRM_MEM
+	int needadjust;
+#endif
 
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return pte_chain;
 
 	pte_chain_lock(page);
 
+#ifdef CONFIG_CKRM_MEM
+	needadjust = ckrm_mem_evaluate_page_byadd(page,ptep);
+#endif	
 	if (page->pte.direct == 0) {
 		page->pte.direct = pte_paddr;
 		SetPageDirect(page);
@@ -207,6 +286,10 @@
 	cur_pte_chain->next_and_idx--;
 out:
 	pte_chain_unlock(page);
+#ifdef CONFIG_CKRM_MEM
+	if (needadjust)
+		lru_cache_adjust_page(page);
+#endif
 	return pte_chain;
 }
 
@@ -224,6 +307,9 @@
 {
 	pte_addr_t pte_paddr = ptep_to_paddr(ptep);
 	struct pte_chain *pc;
+#ifdef CONFIG_CKRM_MEM
+	int needadjust;
+#endif
 
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
 		return;
@@ -274,7 +360,14 @@
 	if (!page_mapped(page))
 		dec_page_state(nr_mapped);
 out_unlock:
+#ifdef CONFIG_CKRM_MEM
+	needadjust = (page_class(page)==ptep_to_mm(ptep)->memclass) ?
0:ckrm_mem_evaluate_page(page);
+	pte_chain_unlock(page);
+	if (needadjust)
+		lru_cache_adjust_page(page);
+#else	
 	pte_chain_unlock(page);
+#endif
 	return;
 }
 
diff -Nru a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	Fri Aug 29 14:47:50 2003
+++ b/mm/swap.c	Fri Aug 29 14:47:50 2003
@@ -21,6 +21,9 @@
 #include <linux/pagevec.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/ckrm_mem.h>
+#include <linux/rmap-locking.h>
+#include <linux/ckrm_mem_inline.h>
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/percpu.h>
@@ -61,7 +64,11 @@
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
 		list_del(&page->lru);
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+		list_add_tail(&page->lru, &(page_lrucharge(page)->inactive_list));
+#else
 		list_add_tail(&page->lru, &zone->inactive_list);
+#endif
 		inc_page_state(pgrotated);
 	}
 	if (!TestClearPageWriteback(page))
@@ -131,6 +138,62 @@
 	put_cpu_var(lru_add_active_pvecs);
 }
 
+#ifdef CONFIG_CKRM_MEM
+
+static DEFINE_PER_CPU(struct pagevec, lru_adjust_pvecs) = {0,};
+
+void __pagevec_lru_adjust(struct pagevec* pvec)
+{
+	int i;
+	struct zone* zone = NULL;
+	ckrm_pageusage_t* acct;
+	ckrm_pageusage_t* lrucharge;
+
+	for (i=0; i<pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
+
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
+
+		acct = page_account(page);
+		lrucharge = page_lrucharge(page);
+		if ( lrucharge && acct && lrucharge!=acct ) {
+
+			if (PageLRU(page)) {
+				if (PageActive(page)) {
+					lrucharge->nr_active--;
+					acct->nr_active++;
+				}
+				else {
+					lrucharge->nr_inactive--;
+					acct->nr_inactive++;
+				}
+				set_page_lrucharge(page,acct);
+			}
+		}
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
+void lru_cache_adjust_page(struct page *page)
+{
+	struct pagevec* pvec = &per_cpu(lru_adjust_pvecs, get_cpu());
+	page_cache_get(page);
+	if (!pagevec_add(pvec,page))
+		__pagevec_lru_adjust(pvec);
+	put_cpu();
+}
+
+#endif
+
 void lru_add_drain(void)
 {
 	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
@@ -140,6 +203,11 @@
 	pvec = &__get_cpu_var(lru_add_active_pvecs);
 	if (pagevec_count(pvec))
 		__pagevec_lru_add_active(pvec);
+#ifdef CONFIG_CKRM_MEM
+	pvec = &__get_cpu_var(lru_adjust_pvecs);
+	if (pagevec_count(pvec))
+		__pagevec_lru_adjust(pvec);
+#endif
 	put_cpu_var(lru_add_pvecs);
 }
 
diff -Nru a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	Fri Aug 29 14:47:50 2003
+++ b/mm/swap_state.c	Fri Aug 29 14:47:50 2003
@@ -13,6 +13,9 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
+#include <linux/ckrm_mem.h>
+#include <linux/rmap-locking.h>
+#include <linux/ckrm_mem_inline.h>
 
 #include <asm/pgtable.h>
 
@@ -201,6 +204,16 @@
 	if (!err) {
 		__remove_from_page_cache(page);
 		___add_to_page_cache(page, &swapper_space, entry.val);
+#ifdef CONFIG_CKRM_MEM
+		pte_chain_lock(page);
+		if ( !page_mapped(page) && !page_class(page) ) {
+			if(current->mem_class)
+				set_page_account_nolock(page, current->mem_class);
+			else
+				set_page_account_nolock(page, &ckrm_memclass_default);
+		}
+		pte_chain_unlock(page);
+#endif
 	}
 
 	spin_unlock(&mapping->page_lock);
@@ -237,6 +250,16 @@
 	if (!err) {
 		__delete_from_swap_cache(page);
 		___add_to_page_cache(page, mapping, index);
+#ifdef CONFIG_CKRM_MEM
+		pte_chain_lock(page);
+		if ( !page_mapped(page) && !page_class(page) ) {
+			if(current->mem_class)
+				set_page_account_nolock(page, current->mem_class);
+			else
+				set_page_account_nolock(page, &ckrm_memclass_default);
+		}
+		pte_chain_unlock(page);
+#endif
 	}
 
 	spin_unlock(&mapping->page_lock);
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri Aug 29 14:47:50 2003
+++ b/mm/vmscan.c	Fri Aug 29 14:47:50 2003
@@ -24,10 +24,12 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page(),
 					buffer_heads_over_limit */
-#include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/ckrm_mem.h>
+#include <linux/ckrm_mem_inline.h>
+#include <linux/mm_inline.h>
 #include <linux/topology.h>
 
 #include <asm/pgalloc.h>
@@ -260,6 +262,12 @@
 			goto activate_locked;
 		}
 
+#if defined CONFIG_CKRM_MEM_GLOBAL_LIST
+		if (!page_readyshrink(page)) {
+			pte_chain_unlock(page);
+			goto activate_locked;
+		}
+#endif
 		mapping = page->mapping;
 
 #ifdef CONFIG_SWAP
@@ -295,7 +303,6 @@
 			}
 		}
 		pte_chain_unlock(page);
-
 		/*
 		 * If the page is dirty, only perform writeback if that write
 		 * will be non-blocking.  To prevent this allocation from being
@@ -448,14 +455,24 @@
  * For pagecache intensive workloads, the first loop here is the
hottest spot
  * in the kernel (apart from the copy_*_user functions).
  */
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+static int
+shrink_cache(const int nr_pages, struct zone *zone, ckrm_pageusage_t*
mem_acct,
+		unsigned int gfp_mask, int max_scan, int *nr_mapped)
+#else
 static int
 shrink_cache(const int nr_pages, struct zone *zone,
 		unsigned int gfp_mask, int max_scan, int *nr_mapped)
+#endif
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
 	int nr_to_process;
 	int ret = 0;
+#ifdef CONFIG_CKRM_MEM_GLOBAL_LIST
+	int nr_pass = 0;
+	LIST_HEAD(hold);
+#endif
 
 	/*
 	 * Try to ensure that we free `nr_pages' pages in one pass of the
loop.
@@ -474,6 +491,22 @@
 		int nr_scan = 0;
 		int nr_freed;
 
+#if defined CONFIG_CKRM_MEM_GLOBAL_LIST
+		nr_pass = zone->nr_inactive;
+		while ( nr_pass>0 && nr_scan<nr_to_process &&
+				!list_empty(&zone->inactive_list)) {
+			page = list_entry(zone->inactive_list.prev,
+						struct page, lru);
+			prefetchw_prev_lru_page(page,
+						&zone->inactive_list, flags);
+#elif defined CONFIG_CKRM_MEM_PERCLASS_LIST
+		while (nr_scan++ < nr_to_process &&
+				!list_empty(&mem_acct->inactive_list)) {
+			page = list_entry(mem_acct->inactive_list.prev,
+						struct page, lru);
+			prefetchw_prev_lru_page(page,
+						&mem_acct->inactive_list, flags);
+#else
 		while (nr_scan++ < nr_to_process &&
 				!list_empty(&zone->inactive_list)) {
 			page = list_entry(zone->inactive_list.prev,
@@ -481,22 +514,62 @@
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
+#endif
+#ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+			BUG_ON(!page_class(page));
+#endif
 
 			if (!TestClearPageLRU(page))
 				BUG();
 			list_del(&page->lru);
+#ifdef CONFIG_CKRM_MEM_GLOBAL_LIST
+	#ifdef CONFIG_CKRM_MEM_LRUORDER
+			if (!page_readyscan(page)) {
+				list_add(&page->lru, &hold);
+				continue;
+			}
+	#else
+			if (!page_readyscan(page)) {
+				SetPageLRU(page);
+				list_add(&page->lru, &zone->inactive_list);
+				continue;
+			}
+	#endif
+			nr_scan++;
+#endif
 			if (page_count(page) == 0) {
 				/* It is currently in pagevec_release() */
 				SetPageLRU(page);
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+				list_add(&page->lru, &mem_acct->inactive_list);
+#else
 				list_add(&page->lru, &zone->inactive_list);
+#endif
 				continue;
 			}
 			list_add(&page->lru, &page_list);
 			page_cache_get(page);
 			nr_taken++;
+#ifdef CONFIG_CKRM_MEM
+			mem_class_dec_inactive(page);
+			clear_page_lrucharge(page);
+#endif
 		}
 		zone->nr_inactive -= nr_taken;
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+		/* we disable the pages_scanned for per class list */
+#else
 		zone->pages_scanned += nr_taken;
+#endif		
+#ifdef CONFIG_CKRM_MEM_LRUORDER
+		while (!list_empty(&hold)) {
+			page = list_entry(hold.next, struct page, lru);
+			if (TestSetPageLRU(page))
+				BUG();
+			list_del(&page->lru);
+			list_add_tail(&page->lru, &zone->inactive_list);
+		}
+#endif
 		spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
@@ -553,9 +626,15 @@
  * The downside is that we have to touch page->count against each page.
  * But we had to alter page->flags anyway.
  */
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+static void
+refill_inactive_zone(struct zone *zone, ckrm_pageusage_t* mem_acct,
const int nr_pages_in,
+			struct page_state *ps, int priority)
+#else
 static void
 refill_inactive_zone(struct zone *zone, const int nr_pages_in,
 			struct page_state *ps, int priority)
+#endif
 {
 	int pgmoved;
 	int pgdeactivate = 0;
@@ -569,26 +648,57 @@
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+#ifdef CONFIG_CKRM_MEM_GLOBAL_LIST
+	int nr_pass = 0;
+#endif
 
 	lru_add_drain();
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
+#if defined CONFIG_CKRM_MEM_GLOBAL_LIST
+	nr_pass = zone->nr_active;
+	while (nr_pages && nr_pass>0 && !list_empty(&zone->active_list)) {
+		page = list_entry(zone->active_list.prev, struct page, lru);
+		prefetchw_prev_lru_page(page, &zone->active_list, flags);
+#elif defined CONFIG_CKRM_MEM_PERCLASS_LIST
+	while (nr_pages && !list_empty(&mem_acct->active_list)) {
+		page = list_entry(mem_acct->active_list.prev, struct page, lru);
+		prefetchw_prev_lru_page(page, &mem_acct->active_list, flags);
+#else
 	while (nr_pages && !list_empty(&zone->active_list)) {
 		page = list_entry(zone->active_list.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
+#endif
+
+#ifdef CONFIG_CKRM_MEM_DEBUG_BEANCOUNTING
+		BUG_ON(!page_class(page));
+#endif
 		if (!TestClearPageLRU(page))
 			BUG();
 		list_del(&page->lru);
 		if (page_count(page) == 0) {
 			/* It is currently in pagevec_release() */
 			SetPageLRU(page);
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+			list_add(&page->lru, &mem_acct->active_list);
+#else
 			list_add(&page->lru, &zone->active_list);
+#endif			
 		} else {
 			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
 			pgmoved++;
+#ifdef CONFIG_CKRM_MEM
+			mem_class_dec_active(page);
+#endif
 		}
+#ifdef CONFIG_CKRM_MEM_GLOBAL_LIST
+		nr_pass--;
+		if ( page_readyrefill(page) )
+			nr_pages--;
+#else
 		nr_pages--;
+#endif
 	}
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
@@ -662,8 +772,15 @@
 			BUG();
 		if (!TestClearPageActive(page))
 			BUG();
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+		list_move(&page->lru, &mem_acct->inactive_list);
+#else
 		list_move(&page->lru, &zone->inactive_list);
+#endif		
 		pgmoved++;
+#ifdef CONFIG_CKRM_MEM
+		mem_class_inc_inactive(page);
+#endif
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
@@ -690,8 +807,15 @@
 		if (TestSetPageLRU(page))
 			BUG();
 		BUG_ON(!PageActive(page));
+#ifdef CONFIG_CKRM_MEM_PERCLASS_LIST
+		list_move(&page->lru, &mem_acct->active_list);
+#else
 		list_move(&page->lru, &zone->active_list);
+#endif
 		pgmoved++;
+#ifdef CONFIG_CKRM_MEM
+		mem_class_inc_active(page);
+#endif
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_active += pgmoved;
 			pgmoved = 0;
@@ -708,6 +832,8 @@
 	mod_page_state(pgdeactivate, pgdeactivate);
 }
 
+#ifndef CONFIG_CKRM_MEM  /* Original implementation of shrink_zone */
+
 /*
  * Try to reclaim `nr_pages' from this zone.  Returns the number of
reclaimed
  * pages.  This is a basic per-zone page freer.  Used by both kswapd
and
@@ -751,6 +877,288 @@
 				max_scan, nr_mapped);
 }
 
+#elif defined CONFIG_CKRM_MEM_GLOBAL_LIST
+/*
+ * Shrink_zone for class-based memory control using global lru list.
+ */
+static int
+shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
+	const int nr_pages, int *nr_mapped, struct page_state *ps, int
priority)
+{
+	unsigned long ratio;
+
+	ckrm_mem_t* cls;
+	int  zoneindex = zone_index(zone);
+	int  nr_active = 0;
+	int  nr_inactive=0;
+
+	if (!ckrm_memshare_disabled) {
+		int  nr_victims =0;
+		unsigned long mem_available = ckrm_mem_available();
+
+		spin_lock(&ckrm_memclass_lock);
+		list_for_each_entry(cls, &ckrm_memclass_list, mcls_list) {
+			cls->nr_share = mem_available * cls->mcls_share/100;
+			if ( cls->nr_share < atomic_read(&cls->nr_total) &&
(SWAP_CLUSTER_MAX<<2) <
+				cls->mcls_usage[zoneindex].nr_active+cls->mcls_usage[zoneindex].nr_active) {
+				nr_active += cls->mcls_usage[zoneindex].nr_active;
+				nr_inactive += cls->mcls_usage[zoneindex].nr_inactive;
+				nr_victims++;
+				set_class_readyflag(cls->mcls_usage+zoneindex,ACCT_READYALL);
+			}
+			else {
+				set_class_readyflag(cls->mcls_usage+zoneindex,ACCT_READYNONE);
+			}
+		}
+		if (!nr_victims) {
+			list_for_each_entry(cls, &ckrm_memclass_list, mcls_list) 
+				set_class_readyflag(cls->mcls_usage+zoneindex,ACCT_READYALL);
+			nr_active = zone->nr_active;
+			nr_inactive = zone->nr_inactive;
+		}
+		spin_unlock(&ckrm_memclass_lock);
+	}
+	else {
+		spin_lock(&ckrm_memclass_lock);
+		list_for_each_entry(cls, &ckrm_memclass_list, mcls_list)
+			set_class_readyflag(cls->mcls_usage+zoneindex,ACCT_READYALL);
+		nr_active = zone->nr_active;
+		nr_inactive = zone->nr_inactive;
+		spin_unlock(&ckrm_memclass_lock);
+	}
+	ratio = (unsigned long)nr_pages * nr_active /
+				((nr_inactive | 1) * 2);
+	atomic_add(ratio+1, &zone->refill_counter);
+
+	if (atomic_read(&zone->refill_counter) > SWAP_CLUSTER_MAX) {
+		int count;
+
+		/*
+		 * Don't try to bring down too many pages in one attempt.
+		 * But we modified it increase the page number based on priority
+		 * This is for those extremely active applications.
+		 */
+		count = atomic_read(&zone->refill_counter);
+		if (count > (SWAP_CLUSTER_MAX*4)<<(DEF_PRIORITY-priority))
+			count = (SWAP_CLUSTER_MAX*4)<<(DEF_PRIORITY-priority);
+		atomic_set(&zone->refill_counter,0);
+		refill_inactive_zone(zone, count, ps, priority);
+	}
+	return shrink_cache(nr_pages, zone, gfp_mask,
+				max_scan, nr_mapped);
+}
+
+#else
+/*
+ * shrink_zone for class-based memory control using separated lru
lists.
+ * shrink_class is almost the original shrink_zone function
+ */
+static int
+shrink_class(struct zone *zone, ckrm_pageusage_t* acct, unsigned int
gfp_mask,
+	int *nr_mapped, struct page_state *ps, int priority)
+{
+	unsigned long ratio;
+	int max_scan = acct->shrink_max_scan;
+	int nr_pages = acct->shrink_nr_pages;
+
+	ratio = (unsigned long)nr_pages * acct->nr_active /
+				((acct->nr_inactive | 1) * 2);
+	atomic_add(ratio+1, &acct->refill_counter);
+	if (atomic_read(&acct->refill_counter) > SWAP_CLUSTER_MAX) {
+		int count;
+
+		/*
+		 * Don't try to bring down too many pages in one attempt.
+		 * But we modified it increase the page number based on priority
+		 * This is for those extremely active applications.
+		 */
+		count = atomic_read(&acct->refill_counter);
+		if (count > (SWAP_CLUSTER_MAX*4)<<(DEF_PRIORITY-priority))
+			count = (SWAP_CLUSTER_MAX*4)<<(DEF_PRIORITY-priority);
+		atomic_set(&acct->refill_counter,0);
+		refill_inactive_zone(zone, acct, count, ps, priority);
+	}
+	return shrink_cache(nr_pages, zone, acct, gfp_mask,
+				max_scan, nr_mapped);
+}
+
+/*
+ * FIXME:
+ *   The victim choosing algorithm here is just a raw sort algorithm,
+ *   there are a lot of spaces to improve it/or replace it.
+ */
+#define __LAMDA_    1000
+
+static inline
+int shrink_weight(ckrm_pageusage_t* acct)
+{
+	int nr_total, nr_share, nr_sharemax, nr_sharemin;
+	ckrm_mem_t* cls = acct->class;
+
+	nr_total = atomic_read(&cls->nr_total);
+	nr_share = cls->nr_share;
+
+	/* FIXME: Should have a better way there.
+	 * If the page # is this zone is less then .., don't reclaim,
+	 * It is used to deal with the case that one class has high usage in
total
+	 * but use small # of pages in some zones
+	 */
+	if ( acct->nr_active+acct->nr_inactive<SWAP_CLUSTER_MAX*4 )
+		return -(__LAMDA);
+	
+	if (nr_total>nr_share) {
+		if (cls->nr_sharemax<(cls->nr_share+SWAP_CLUSTER_MAX))
+			nr_sharemax = cls->nr_share+SWAP_CLUSTER_MAX;
+		else
+			nr_sharemax = cls->nr_sharemax;
+		return (nr_total - nr_share)*__LAMDA_/(nr_sharemax - nr_share);
+	}
+	else {
+		if (cls->nr_sharemin>(cls->nr_share-SWAP_CLUSTER_MAX))
+			nr_sharemin = cls->nr_share-SWAP_CLUSTER_MAX;
+		else
+			nr_sharemin = cls->nr_sharemin;
+		return -(int)((nr_share-nr_total)*__LAMDA_/(nr_share-nr_sharemin));
+	}
+}
+
+/* insert an entry to the list and sort decendently*/
+static void list_add_sort(struct list_head* entry, struct list_head*
head)
+{
+	ckrm_pageusage_t* acct;
+	ckrm_pageusage_t* new = list_entry(entry, ckrm_pageusage_t,
victim_list);
+	struct list_head* pos = head->next;
+
+	while (pos!=head) {
+		acct = list_entry(pos, ckrm_pageusage_t, victim_list);
+		if (new->shrink_weight>acct->shrink_weight) {
+			__list_add(entry, pos->prev, pos);
+			return;
+		}
+		pos = pos->next;
+	}
+	list_add_tail(entry,head);
+	return;	
+}
+
+static void shrink_set_victim(struct list_head* head, int nr_cluster,
int scan_unit)
+{
+	ckrm_pageusage_t* acct;
+	struct list_head *pos, *prev, *next;
+
+	pos = head->next;
+	while (pos!=head) {
+		acct = list_entry(pos, ckrm_pageusage_t, victim_list);
+		prev = pos->prev;
+		
+		nr_cluster--;
+		acct->shrink_nr_pages += SWAP_CLUSTER_MAX;
+		acct->shrink_max_scan += scan_unit;
+		acct->shrink_weight = shrink_weight(acct);
+		list_del(pos);
+		list_add_sort(pos,head);
+		
+		if (nr_cluster<=0) 
+			break;
+		pos = prev->next;	
+	}
+
+	pos = head->next;
+	while (pos!=head) {
+		acct = list_entry(pos, ckrm_pageusage_t, victim_list);
+		next = pos->next;
+		if ( acct->shrink_nr_pages<=0 ) {
+			list_del(pos);
+			clear_bit(ACCT_VICTIM_BIT, &acct->flags);
+		}
+		pos = next;
+	}	
+	return;
+}
+
+static int shrink_choose_victim(struct zone* zone, int max_scan, int
nr_pages,
+	struct list_head* list)
+{
+	ckrm_mem_t* cls;
+	int zoneindex = zone_index(zone);
+	int nr_cluster = (nr_pages+SWAP_CLUSTER_MAX-1)/SWAP_CLUSTER_MAX;
+	
+	spin_lock(&ckrm_memclass_lock);
+	list_for_each_entry(cls, &ckrm_memclass_list, mcls_list) {
+		ckrm_pageusage_t* acct = cls->mcls_usage + zoneindex;
+		if (test_and_set_bit(ACCT_VICTIM_BIT, &acct->flags))
+			continue;
+		acct->shrink_nr_pages = 0;
+		acct->shrink_max_scan = 0;
+		acct->shrink_weight = shrink_weight(acct);
+		list_add_sort(&acct->victim_list, list);
+	}
+	shrink_set_victim(list, nr_cluster, max_scan/nr_cluster);
+	spin_unlock(&ckrm_memclass_lock);
+	return 0;
+}
+
+static int
+shrink_zone(struct zone *zone, int max_scan, unsigned int gfp_mask,
+	const int nr_pages, int *nr_mapped, struct page_state *ps, int
priority)
+{
+	int ret = 0;
+	ckrm_pageusage_t *acct;
+	struct list_head *pos, *next;
+	struct list_head victims = LIST_HEAD_INIT(victims);
+	if (!ckrm_memshare_disabled) {
+
+		shrink_choose_victim(zone, max_scan, nr_pages, &victims);
+		pos = victims.next;
+		while (pos != &victims) {
+			acct = list_entry(pos, ckrm_pageusage_t, victim_list);
+			next = pos->next;
+			list_del(pos);
+
+			ret += shrink_class(zone,acct,gfp_mask,nr_mapped,ps,priority);
+			clear_bit(ACCT_VICTIM_BIT,&acct->flags);
+
+			pos = next;
+		}
+	}
+	else {
+		/*
+		 * In this case, the victims wouldn't give up their pages, to avoid
+		 * the dead loop, we try to reclaim pages in RR way.
+		 */
+		ckrm_mem_t* cls;
+		int zoneindex = zone_index(zone);
+		int nr_cluster = (nr_pages+SWAP_CLUSTER_MAX-1)/SWAP_CLUSTER_MAX;
+		int scan_unit = max_scan/nr_cluster;
+
+		spin_lock(&ckrm_memclass_lock);
+		list_for_each_entry(cls, &ckrm_memclass_list, mcls_list) {
+			ckrm_pageusage_t* acct = cls->mcls_usage + zoneindex;
+			if (test_and_set_bit(ACCT_VICTIM_BIT, &acct->flags))
+				continue;
+			acct->shrink_nr_pages = SWAP_CLUSTER_MAX;
+			acct->shrink_max_scan = scan_unit;
+			list_add(&acct->victim_list, &victims);
+		}
+		spin_unlock(&ckrm_memclass_lock);
+
+		pos = victims.next;
+		while (pos != &victims) {
+			acct = list_entry(pos, ckrm_pageusage_t, victim_list);
+			next = pos->next;
+			list_del(pos);
+
+			ret += shrink_class(zone,acct,gfp_mask,nr_mapped,ps,priority);
+			clear_bit(ACCT_VICTIM_BIT,&acct->flags);
+
+			pos = next;
+		}
+	}	
+	return ret;
+}
+
+#endif
+
 /*
  * This is the direct reclaim path, for page-allocating processes.  We
only
  * try to reclaim pages from zones which will satisfy the caller's
allocation
@@ -835,10 +1243,22 @@
 		get_page_state(&ps);
 		nr_reclaimed += shrink_caches(cz, priority, &total_scanned,
 						gfp_mask, nr_pages, &ps);
+#if defined (CONFIG_CKRM_MEM_GLOBAL_LIST) || defined
(CONFIG_CKRM_MEM_PERCLASS_LIST)
 		if (nr_reclaimed >= nr_pages) {
+			ckrm_memshare_disabled = 0;
 			ret = 1;
 			goto out;
+		}	
+		if ( !priority && !ckrm_memshare_disabled) {
+			ckrm_memshare_disabled = 1;
+			priority = DEF_PRIORITY+1;
 		}
+#else
+		if (nr_reclaimed >= nr_pages) {
+			ret = 1;
+			goto out;
+		}
+#endif
 		if (!(gfp_mask & __GFP_FS))
 			break;		/* Let the caller handle it */
 		/*
@@ -931,7 +1351,21 @@
 		if (all_zones_ok)
 			break;
 		blk_congestion_wait(WRITE, HZ/10);
+#if defined (CONFIG_CKRM_MEM_GLOBAL_LIST) ||
defined(CONFIG_CKRM_MEM_PERCLASS_LIST)
+		/*
+		 * Why the condition for loop is 'priority' not 'priority>=0'
+		 * like in try_to_free_pages?
+		 */
+		if (priority==1 && !ckrm_memshare_disabled) {
+			ckrm_memshare_disabled = 1;
+			priority = DEF_PRIORITY+1;
+		}
+	}
+	ckrm_memshare_disabled = 0;
+#else
 	}
+#endif
+
 	return nr_pages - to_free;
 }
 



