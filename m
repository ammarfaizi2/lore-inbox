Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265529AbSKFCZ6>; Tue, 5 Nov 2002 21:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSKFCY4>; Tue, 5 Nov 2002 21:24:56 -0500
Received: from holomorphy.com ([66.224.33.161]:64667 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265536AbSKFCYk>;
	Tue, 5 Nov 2002 21:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [6/7] hugetlb: remove /proc/ intrusion
Message-Id: <E189Fwj-0002YW-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:29:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes hugetlb's intrusion into /proc/

 arch/i386/mm/hugetlbpage.c |   11 +++++++++++
 fs/proc/proc_misc.c        |   15 ++-------------
 include/linux/hugetlb.h    |    2 ++
 3 files changed, 15 insertions(+), 13 deletions(-)


diff -urpN hugetlbfs-2.5.46-4a/arch/i386/mm/hugetlbpage.c hugetlbfs-2.5.46-5a/arch/i386/mm/hugetlbpage.c
--- hugetlbfs-2.5.46-4a/arch/i386/mm/hugetlbpage.c	2002-11-05 17:31:39.000000000 -0800
+++ hugetlbfs-2.5.46-5a/arch/i386/mm/hugetlbpage.c	2002-11-05 17:45:53.000000000 -0800
@@ -549,6 +549,17 @@ static int __init hugetlb_init(void)
 }
 module_init(hugetlb_init);
 
+int hugetlb_report_meminfo(char *buf)
+{
+	return sprintf(buf,
+			"HugePages_Total: %5lu\n"
+			"HugePages_Free:  %5lu\n"
+			"Hugepagesize:    %5lu kB\n",
+			htlbzone_pages,
+			htlbpagemem,
+			HPAGE_SIZE/1024);
+}
+
 static struct page * hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
 {
 	BUG();
diff -urpN hugetlbfs-2.5.46-4a/fs/proc/proc_misc.c hugetlbfs-2.5.46-5a/fs/proc/proc_misc.c
--- hugetlbfs-2.5.46-4a/fs/proc/proc_misc.c	2002-11-05 08:26:06.000000000 -0800
+++ hugetlbfs-2.5.46-5a/fs/proc/proc_misc.c	2002-11-05 17:49:06.000000000 -0800
@@ -40,7 +40,7 @@
 #include <linux/times.h>
 #include <linux/profile.h>
 #include <linux/blkdev.h>
-
+#include <linux/hugetlb.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -199,19 +199,8 @@ static int meminfo_read_proc(char *page,
 		ps.nr_reverse_maps
 		);
 
-#ifdef CONFIG_HUGETLB_PAGE
-	{
-		extern unsigned long htlbpagemem, htlbzone_pages;
-		len += sprintf(page + len,
-				"HugePages_Total: %5lu\n"
-				"HugePages_Free:  %5lu\n"
-				"Hugepagesize:    %5lu kB\n",
-				htlbzone_pages,
-				htlbpagemem,
-				HPAGE_SIZE/1024);
-	}
+		len += hugetlb_report_meminfo(page + len);
 
-#endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
 }
diff -urpN hugetlbfs-2.5.46-4a/include/linux/hugetlb.h hugetlbfs-2.5.46-5a/include/linux/hugetlb.h
--- hugetlbfs-2.5.46-4a/include/linux/hugetlb.h	2002-11-05 17:31:39.000000000 -0800
+++ hugetlbfs-2.5.46-5a/include/linux/hugetlb.h	2002-11-05 17:45:53.000000000 -0800
@@ -17,6 +17,7 @@ void zap_hugepage_range(struct vm_area_s
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 void huge_page_release(struct page *);
+int hugetlb_report_meminfo(char *);
 
 extern int htlbpage_max;
 
@@ -32,6 +33,7 @@ static inline int is_vm_hugetlb_page(str
 #define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define huge_page_release(page)			BUG()
+#define hugetlb_report_meminfo(buf)		0
 
 #endif /* !CONFIG_HUGETLB_PAGE */
 
