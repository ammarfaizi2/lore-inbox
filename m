Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265539AbSKFCZw>; Tue, 5 Nov 2002 21:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSKFCYr>; Tue, 5 Nov 2002 21:24:47 -0500
Received: from holomorphy.com ([66.224.33.161]:64155 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265529AbSKFCYk>;
	Tue, 5 Nov 2002 21:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [5/7] hugetlb: remove sysctl.c intrusion
Message-Id: <E189Fwj-0002YT-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:29:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes hugetlb's intrusion into kernel/sysctl.c

 arch/i386/mm/hugetlbpage.c |    7 +++++++
 include/linux/hugetlb.h    |    7 +++++++
 kernel/sysctl.c            |   14 ++------------
 3 files changed, 16 insertions(+), 12 deletions(-)


diff -urpN hugetlbfs-2.5.46-3/arch/i386/mm/hugetlbpage.c hugetlbfs-2.5.46-4a/arch/i386/mm/hugetlbpage.c
--- hugetlbfs-2.5.46-3/arch/i386/mm/hugetlbpage.c	2002-11-05 17:27:30.000000000 -0800
+++ hugetlbfs-2.5.46-4a/arch/i386/mm/hugetlbpage.c	2002-11-05 17:31:39.000000000 -0800
@@ -513,6 +513,13 @@ int set_hugetlb_mem_size(int count)
 	return (int) htlbzone_pages;
 }
 
+int hugetlb_sysctl_handler(ctl_table *table, int write, struct file *file, void *buffer, size_t *length)
+{
+	proc_dointvec(table, write, file, buffer, length);
+	htlbpage_max = set_hugetlb_mem_size(htlbpage_max);
+	return 0;
+}
+
 static int __init hugetlb_setup(char *s)
 {
 	if (sscanf(s, "%d", &htlbpage_max) <= 0)
diff -urpN hugetlbfs-2.5.46-3/include/linux/hugetlb.h hugetlbfs-2.5.46-4a/include/linux/hugetlb.h
--- hugetlbfs-2.5.46-3/include/linux/hugetlb.h	2002-11-04 14:30:27.000000000 -0800
+++ hugetlbfs-2.5.46-4a/include/linux/hugetlb.h	2002-11-05 17:31:39.000000000 -0800
@@ -2,17 +2,24 @@
 #define _LINUX_HUGETLB_H
 
 #ifdef CONFIG_HUGETLB_PAGE
+
+struct ctl_table;
+
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_HUGETLB;
 }
 
+int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void *, size_t *);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
 int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 void huge_page_release(struct page *);
+
+extern int htlbpage_max;
+
 #else /* !CONFIG_HUGETLB_PAGE */
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
diff -urpN hugetlbfs-2.5.46-3/kernel/sysctl.c hugetlbfs-2.5.46-4a/kernel/sysctl.c
--- hugetlbfs-2.5.46-3/kernel/sysctl.c	2002-11-04 14:30:06.000000000 -0800
+++ hugetlbfs-2.5.46-4a/kernel/sysctl.c	2002-11-05 17:31:39.000000000 -0800
@@ -31,7 +31,7 @@
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
 #include <linux/writeback.h>
-
+#include <linux/hugetlb.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS
@@ -99,11 +99,6 @@ int proc_dol2crvec(ctl_table *table, int
 extern int acct_parm[];
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-extern int htlbpage_max;
-extern int set_hugetlb_mem_size(int);
-#endif
-
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -315,8 +310,7 @@ static ctl_table vm_table[] = {
 	 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL, &zero,
 	 &one_hundred },
 #ifdef CONFIG_HUGETLB_PAGE
-	 {VM_HUGETLB_PAGES, "nr_hugepages", &htlbpage_max, sizeof(int), 0644, NULL, 
-	  &proc_dointvec},
+	 {VM_HUGETLB_PAGES, "nr_hugepages", &htlbpage_max, sizeof(int), 0644, NULL, &hugetlb_sysctl_handler},
 #endif
 	{0}
 };
@@ -907,10 +901,6 @@ static int do_proc_dointvec(ctl_table *t
 				val = -val;
 			buffer += len;
 			left -= len;
-#ifdef CONFIG_HUGETLB_PAGE
-			if (i == &htlbpage_max)
-				val = set_hugetlb_mem_size(val);
-#endif
 			switch(op) {
 			case OP_SET:	*i = val; break;
 			case OP_AND:	*i &= val; break;
