Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSKFCZ5>; Tue, 5 Nov 2002 21:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265529AbSKFCYw>; Tue, 5 Nov 2002 21:24:52 -0500
Received: from holomorphy.com ([66.224.33.161]:64411 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265532AbSKFCYk>;
	Tue, 5 Nov 2002 21:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [4/7] hugetlb: internalize hugetlb init
Message-Id: <E189Fwj-0002YQ-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:29:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch internalizes hugetlb initialization, implementing a command-line
option in the process.

 hugetlbpage.c |   40 ++++++++++++++++++++++++++++++++++++----
 init.c        |   31 -------------------------------
 2 files changed, 36 insertions(+), 35 deletions(-)


diff -urpN hugetlbfs-2.5.46-2/arch/i386/mm/hugetlbpage.c hugetlbfs-2.5.46-3/arch/i386/mm/hugetlbpage.c
--- hugetlbfs-2.5.46-2/arch/i386/mm/hugetlbpage.c	2002-11-05 11:07:53.000000000 -0800
+++ hugetlbfs-2.5.46-3/arch/i386/mm/hugetlbpage.c	2002-11-05 17:27:30.000000000 -0800
@@ -12,16 +12,19 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
-
+#include <linux/module.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
+long    htlbpagemem = 0;
+int     htlbpage_max;
+long    htlbzone_pages;
+
 struct vm_operations_struct hugetlb_vm_ops;
-struct list_head htlbpage_freelist;
-spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
-extern long htlbpagemem;
+static LIST_HEAD(htlbpage_freelist);
+static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
 #define MAX_ID 	32
 struct htlbpagekey {
@@ -510,6 +513,35 @@ int set_hugetlb_mem_size(int count)
 	return (int) htlbzone_pages;
 }
 
+static int __init hugetlb_setup(char *s)
+{
+	if (sscanf(s, "%d", &htlbpage_max) <= 0)
+		htlbpage_max = 0;
+	return 1;
+}
+__setup("hugepages=", hugetlb_setup);
+
+static int __init hugetlb_init(void)
+{
+	int i, j;
+	struct page *page;
+
+	for (i = 0; i < htlbpage_max; ++i) {
+		page = alloc_pages(__GFP_HIGHMEM, HUGETLB_PAGE_ORDER);
+		if (!page)
+			break;
+		for (j = 0; j < HPAGE_SIZE/PAGE_SIZE; ++j)
+			SetPageReserved(&page[j]);
+		spin_lock(&htlbpage_lock);
+		list_add(&page->list, &htlbpage_freelist);
+		spin_unlock(&htlbpage_lock);
+	}
+	htlbpage_max = htlbpagemem = htlbzone_pages = i;
+	printk("Total HugeTLB memory allocated, %ld\n", htlbpagemem);
+	return 0;
+}
+module_init(hugetlb_init);
+
 static struct page * hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
 {
 	BUG();
diff -urpN hugetlbfs-2.5.46-2/arch/i386/mm/init.c hugetlbfs-2.5.46-3/arch/i386/mm/init.c
--- hugetlbfs-2.5.46-2/arch/i386/mm/init.c	2002-11-04 14:30:46.000000000 -0800
+++ hugetlbfs-2.5.46-3/arch/i386/mm/init.c	2002-11-05 11:30:45.000000000 -0800
@@ -422,13 +422,6 @@ static void __init set_max_mapnr_init(vo
 extern void set_max_mapnr_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
-#ifdef CONFIG_HUGETLB_PAGE
-long    htlbpagemem = 0;
-int     htlbpage_max;
-long    htlbzone_pages;
-extern struct list_head htlbpage_freelist;
-#endif
-
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -497,30 +490,6 @@ void __init mem_init(void)
 #ifndef CONFIG_SMP
 	zap_low_mappings();
 #endif
-#ifdef CONFIG_HUGETLB_PAGE
-	{
-		long	i, j;
-		struct	page	*page, *map;
-		/*For now reserve quarter for hugetlb_pages.*/
-		htlbzone_pages = (max_low_pfn >> ((HPAGE_SHIFT - PAGE_SHIFT) + 2)) ;
-		/*Will make this kernel command line. */
-		INIT_LIST_HEAD(&htlbpage_freelist);
-		for (i=0; i<htlbzone_pages; i++) {
-			page = alloc_pages(__GFP_HIGHMEM, HUGETLB_PAGE_ORDER);
-			if (page == NULL)
-				break;
-			map = page;
-			for (j=0; j<(HPAGE_SIZE/PAGE_SIZE); j++) {
-				SetPageReserved(map);
-				map++;
-			}
-			list_add(&page->list, &htlbpage_freelist);
-		}
-		printk("Total Huge_TLB_Page memory pages allocated %ld\n", i);
-		htlbzone_pages = htlbpagemem = i;
-		htlbpage_max = i;
-	}
-#endif
 }
 
 #if CONFIG_X86_PAE
