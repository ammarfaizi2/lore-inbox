Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270135AbRHSG2b>; Sun, 19 Aug 2001 02:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270131AbRHSG2W>; Sun, 19 Aug 2001 02:28:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:23559 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270135AbRHSG2I>;
	Sun, 19 Aug 2001 02:28:08 -0400
Date: Sun, 19 Aug 2001 03:28:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Subject: [PATCH] VM tunables
Message-ID: <Pine.LNX.4.33L.0108190318000.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes it easier for VM hackers and our
always-present benchmarkers to modify the behaviour of the
VM at run-time.  This should make it easier for us to find
out which VM behaviours are the ones we should set as the
default behaviour and which things are not worth bothering
with.

In more detail, the patch modifies the following things:

  1. the size of the inactive_target can be modified by
     the user in /proc/sys/vm/static_inactive_target,
     leaving the value at the default 0 gives us the
     current default of a dynamic inactive_target

  2. drop_behind can be switched on and off in
     /proc/sys/vm/drop_behind

  3. Page aging can be tuned to chose between 5 possible
     page aging tactics (/proc/sys/vm/page_aging_tactic):
         0 - PAGE_AGE_NULL
         1 - PAGE_AGE_SINGLEBIT
         2 - PAGE_AGE_EXPDOWN
         3 - PAGE_AGE_LINEAR
         4 - PAGE_AGE_EXPUP

     Explaining these would take a bit much space, so I've
     added a quick explanation of each to the Linux-MM Wiki
     at:
	http://linux-mm.org/wiki/moin.cgi/PageAging


Alan, could you apply this patch for -ac8 so we can do better
research into which VM strategies are worth it and which are
better avoided?   The VM seems pretty stable now, so I guess
it's about time we go research the performance side of things
a bit better ;)

regards,

Rik
--
IA64: a worthy successor to i860.


diff -dur linux-2.4.8-ac7.orig/fs/proc/proc_misc.c linux-2.4.8-ac7/fs/proc/proc_misc.c
--- linux-2.4.8-ac7.orig/fs/proc/proc_misc.c	Sun Aug 19 01:14:04 2001
+++ linux-2.4.8-ac7/fs/proc/proc_misc.c	Sun Aug 19 00:32:20 2001
@@ -173,7 +173,7 @@
 		"Active:       %8u kB\n"
 		"Inact_dirty:  %8u kB\n"
 		"Inact_clean:  %8u kB\n"
-		"Inact_target: %8lu kB\n"
+		"Inact_target: %8u kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -189,7 +189,7 @@
 		K(nr_active_pages),
 		K(nr_inactive_dirty_pages),
 		K(nr_inactive_clean_pages()),
-		K(inactive_target),
+		K(inactive_target()),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
diff -dur linux-2.4.8-ac7.orig/include/linux/mm.h linux-2.4.8-ac7/include/linux/mm.h
--- linux-2.4.8-ac7.orig/include/linux/mm.h	Sun Aug 19 01:14:10 2001
+++ linux-2.4.8-ac7/include/linux/mm.h	Sun Aug 19 01:50:34 2001
@@ -13,7 +13,6 @@
 #include <linux/swap.h>

 extern unsigned long max_mapnr;
-extern unsigned long num_physpages;
 extern void * high_memory;
 extern int page_cluster;
 /* The inactive_clean lists are per zone. */
diff -dur linux-2.4.8-ac7.orig/include/linux/swap.h linux-2.4.8-ac7/include/linux/swap.h
--- linux-2.4.8-ac7.orig/include/linux/swap.h	Sun Aug 19 01:14:10 2001
+++ linux-2.4.8-ac7/include/linux/swap.h	Sun Aug 19 01:50:34 2001
@@ -79,6 +79,7 @@
 };

 extern int nr_swap_pages;
+extern unsigned long num_physpages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_pages_zone(int);
 extern unsigned int nr_inactive_clean_pages(void);
@@ -93,6 +94,11 @@
 extern spinlock_t pagecache_lock;
 extern void __remove_inode_page(struct page *);

+/* Sysctl tunables. */
+extern int vm_page_aging_tactic;
+extern int vm_static_inactive_target;
+extern int vm_drop_behind;
+
 /* Incomplete types for prototype declarations: */
 struct task_struct;
 struct vm_area_struct;
@@ -102,11 +108,6 @@

 /* linux/mm/swap.c */
 extern int memory_pressure;
-extern void age_page_up(struct page *);
-extern void age_page_up_nolock(struct page *);
-extern void age_page_down(struct page *);
-extern void age_page_down_nolock(struct page *);
-extern void age_page_down_ageonly(struct page *);
 extern void deactivate_page(struct page *);
 extern void deactivate_page_nolock(struct page *);
 extern void activate_page(struct page *);
@@ -198,6 +199,7 @@
  */
 #define PAGE_AGE_START 2
 #define PAGE_AGE_ADV 3
+#define PAGE_AGE_DECL 1
 #define PAGE_AGE_MAX 64

 /*
@@ -268,9 +270,27 @@
  * 64 (1 << INACTIVE_SHIFT) seconds.
  */
 #define INACTIVE_SHIFT 6
-#define inactive_min(a,b) ((a) < (b) ? (a) : (b))
-#define inactive_target inactive_min((memory_pressure >> INACTIVE_SHIFT), \
-		(num_physpages / 4))
+
+/*
+ * The target size for the inactive list, in pages.
+ *
+ * If the user specified a target in /proc/sys/vm/static_inactive_target
+ * we use that, otherwise we calculate one second of page replacement
+ * activity (memory pressure) capped to 1/4th of physical memory.
+ */
+static inline int inactive_target(void)
+{
+	int target;
+
+	if (vm_static_inactive_target)
+		return vm_static_inactive_target;
+
+	target = memory_pressure >> INACTIVE_SHIFT;
+	if (target > num_physpages / 4)
+		target = num_physpages / 4;
+
+	return target;
+}

 /*
  * Ugly ugly ugly HACK to make sure the inactive lists
diff -dur linux-2.4.8-ac7.orig/include/linux/sysctl.h linux-2.4.8-ac7/include/linux/sysctl.h
--- linux-2.4.8-ac7.orig/include/linux/sysctl.h	Sun Aug 19 01:14:10 2001
+++ linux-2.4.8-ac7/include/linux/sysctl.h	Sun Aug 19 01:55:37 2001
@@ -138,7 +138,10 @@
 	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
         VM_MIN_READAHEAD=12,    /* Min file readahead */
-        VM_MAX_READAHEAD=13     /* Max file readahead */
+        VM_MAX_READAHEAD=13,    /* Max file readahead */
+	VM_AGING_TACTIC=14,	/* Page aging strategy */
+	VM_INACTIVE_TARGET=15,	/* Static inactive target, zero for dynamic */
+	VM_DROP_BEHIND=16,	/* Turn drop-behind hack on/off */
 };


diff -dur linux-2.4.8-ac7.orig/kernel/sysctl.c linux-2.4.8-ac7/kernel/sysctl.c
--- linux-2.4.8-ac7.orig/kernel/sysctl.c	Sun Aug 19 01:14:10 2001
+++ linux-2.4.8-ac7/kernel/sysctl.c	Sun Aug 19 01:15:37 2001
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/swapctl.h>
+#include <linux/swap.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
@@ -259,7 +260,7 @@

 static ctl_table vm_table[] = {
 	{VM_FREEPG, "freepages",
-	 &freepages, sizeof(freepages_t), 0444, NULL, &proc_dointvec},
+	 &freepages, sizeof(freepages_t), 0644, NULL, &proc_dointvec},
 	{VM_BDFLUSH, "bdflush", &bdf_prm, 9*sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
 	 &bdflush_min, &bdflush_max},
@@ -281,6 +282,12 @@
 	&vm_min_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAX_READAHEAD, "max-readahead",
 	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_AGING_TACTIC, "page_aging_tactic",
+	 &vm_page_aging_tactic, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_INACTIVE_TARGET, "static_inactive_target",
+	 &vm_static_inactive_target, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_DROP_BEHIND, "drop_behind",
+	 &vm_drop_behind, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };

diff -dur linux-2.4.8-ac7.orig/mm/filemap.c linux-2.4.8-ac7/mm/filemap.c
--- linux-2.4.8-ac7.orig/mm/filemap.c	Sun Aug 19 01:14:10 2001
+++ linux-2.4.8-ac7/mm/filemap.c	Sun Aug 19 01:27:45 2001
@@ -816,6 +816,7 @@
  *
  * Rik van Riel, 2000
  */
+int vm_drop_behind = 1;
 static void drop_behind(struct file * file, unsigned long index)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -823,6 +824,10 @@
 	struct page *page;
 	unsigned long start;

+	/* If drop-behind was disabled in /proc ... */
+	if (!vm_drop_behind)
+		return;
+
 	/* Nothing to drop-behind if we're on the first page. */
 	if (!index)
 		return;
@@ -2691,7 +2696,7 @@
 unlock:
 		/* Mark it unlocked again and drop the page.. */
 		UnlockPage(page);
-		if (deactivate)
+		if (deactivate && vm_drop_behind)
 			deactivate_page(page);
 		page_cache_release(page);

diff -dur linux-2.4.8-ac7.orig/mm/swap.c linux-2.4.8-ac7/mm/swap.c
--- linux-2.4.8-ac7.orig/mm/swap.c	Sun Aug 19 01:14:10 2001
+++ linux-2.4.8-ac7/mm/swap.c	Sun Aug 19 00:32:20 2001
@@ -75,82 +75,6 @@
 };

 /**
- * age_page_{up,down} -	page aging helper functions
- * @page - the page we want to age
- * @nolock - are we already holding the pagelist_lru_lock?
- *
- * If the page is on one of the lists (active, inactive_dirty or
- * inactive_clean), we will grab the pagelist_lru_lock as needed.
- * If you're already holding the lock, call this function with the
- * nolock argument non-zero.
- */
-void age_page_up_nolock(struct page * page)
-{
-	/*
-	 * We're dealing with an inactive page, move the page
-	 * to the active list.
-	 */
-	if (!page->age)
-		activate_page_nolock(page);
-
-	/* The actual page aging bit */
-	page->age += PAGE_AGE_ADV;
-	if (page->age > PAGE_AGE_MAX)
-		page->age = PAGE_AGE_MAX;
-}
-
-/*
- * We use this (minimal) function in the case where we
- * know we can't deactivate the page (yet).
- */
-void age_page_down_ageonly(struct page * page)
-{
-	page->age /= 2;
-}
-
-void age_page_down_nolock(struct page * page)
-{
-	/* The actual page aging bit */
-	page->age /= 2;
-
-	/*
-	 * The page is now an old page. Move to the inactive
-	 * list (if possible ... see below).
-	 */
-	if (!page->age)
-	       deactivate_page_nolock(page);
-}
-
-void age_page_up(struct page * page)
-{
-	/*
-	 * We're dealing with an inactive page, move the page
-	 * to the active list.
-	 */
-	if (!page->age)
-		activate_page(page);
-
-	/* The actual page aging bit */
-	page->age += PAGE_AGE_ADV;
-	if (page->age > PAGE_AGE_MAX)
-		page->age = PAGE_AGE_MAX;
-}
-
-void age_page_down(struct page * page)
-{
-	/* The actual page aging bit */
-	page->age /= 2;
-
-	/*
-	 * The page is now an old page. Move to the inactive
-	 * list (if possible ... see below).
-	 */
-	if (!page->age)
-	       deactivate_page(page);
-}
-
-
-/**
  * (de)activate_page - move pages from/to active and inactive lists
  * @page: the page we want to move
  * @nolock - are we already holding the pagemap_lru_lock?
diff -dur linux-2.4.8-ac7.orig/mm/vmscan.c linux-2.4.8-ac7/mm/vmscan.c
--- linux-2.4.8-ac7.orig/mm/vmscan.c	Sun Aug 19 01:14:11 2001
+++ linux-2.4.8-ac7/mm/vmscan.c	Sun Aug 19 01:54:57 2001
@@ -25,6 +25,73 @@
 #include <asm/pgalloc.h>

 #define MAX(a,b) ((a) > (b) ? (a) : (b))
+int vm_static_inactive_target;
+
+/*
+ * Helper functions for page aging. You can tune the page
+ * aging policy in /proc/sys/vm/page_aging_tactic.
+ *
+ * These tunable is here mainly for the VM developers to
+ * do tests with. Some documentation can be found at:
+ *
+ * http://linux-mm.org/wiki/moin.cgi/PageAging
+ */
+#define	PAGE_AGE_NULL		0
+#define	PAGE_AGE_SINGLEBIT	1
+#define	PAGE_AGE_EXPDOWN	2
+#define	PAGE_AGE_LINEAR		3
+#define	PAGE_AGE_EXPUP		4
+
+/*
+ * We don't know if this is a good default, but it's what
+ * all the 2.4 kernels have been using up to now.
+ */
+int vm_page_aging_tactic = PAGE_AGE_EXPDOWN;
+
+static inline void age_page_up(struct page *page)
+{
+	unsigned long age;
+	switch (vm_page_aging_tactic) {
+		case PAGE_AGE_NULL:
+			page->age = 0;
+			break;
+		case PAGE_AGE_EXPUP:
+			age = page->age;
+			age *= 2;
+			if (!age)
+				age = 1;
+			goto max_age_check;
+		case PAGE_AGE_SINGLEBIT:
+		case PAGE_AGE_EXPDOWN:
+		case PAGE_AGE_LINEAR:
+		default:
+			age = page->age + PAGE_AGE_ADV;
+max_age_check:
+			if (age > PAGE_AGE_MAX)
+				age = PAGE_AGE_MAX;
+			page->age = age;
+			break;
+	}
+}
+
+static inline void age_page_down(struct page *page)
+{
+	switch (vm_page_aging_tactic) {
+		case PAGE_AGE_LINEAR:
+		case PAGE_AGE_EXPUP:
+			if (page->age)
+				page->age -= PAGE_AGE_DECL;
+			break;
+		case PAGE_AGE_EXPDOWN:
+		default:
+			page->age /= 2;
+			break;
+		case PAGE_AGE_NULL:
+		case PAGE_AGE_SINGLEBIT:
+			page->age = 0;
+			break;
+	}
+}

 /*
  * Estimate whether a zone has enough inactive or free pages..
@@ -77,10 +144,9 @@

 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
-		page->age += PAGE_AGE_ADV;
-		if (page->age > PAGE_AGE_MAX)
-			page->age = PAGE_AGE_MAX;
-		return;
+		age_page_up(page);
+		if (vm_page_aging_tactic != PAGE_AGE_NULL)
+			return;
 	}

 	if (TryLockPage(page))
@@ -763,10 +829,10 @@

 		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {
-			age_page_up_nolock(page);
-			page_active = 1;
+			age_page_up(page);
+			page_active = vm_page_aging_tactic; /* subtle */
 		} else {
-			age_page_down_ageonly(page);
+			age_page_down(page);
 			/*
 			 * Since we don't hold a reference on the page
 			 * ourselves, we have to do our test a bit more
@@ -858,7 +924,7 @@
 int inactive_shortage(void)
 {
 	pg_data_t *pgdat;
-	unsigned int global_target = freepages.high + inactive_target;
+	unsigned int global_target = freepages.high + inactive_target();
 	unsigned int global_inactive = 0;

 	pgdat = pgdat_list;

