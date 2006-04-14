Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWDNCkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWDNCkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWDNCkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:40:09 -0400
Received: from fmr18.intel.com ([134.134.136.17]:56738 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965097AbWDNCkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:40:07 -0400
Subject: Re: [PATCH 7/8] IA64 various hugepage size - Add proc control to
	reserve and free
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Tony <tony.luck@intel.com>,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144975953.5817.102.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
	 <1144974667.5817.51.camel@linux-znh>  <1144974881.5817.59.camel@linux-znh>
	 <1144975292.5817.74.camel@linux-znh>  <1144975523.5817.84.camel@linux-znh>
	 <1144975746.5817.94.camel@linux-znh>  <1144975953.5817.102.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144976261.5817.114.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:57:41 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proc control to reserve and free various sized hugepages

cat /proc/hugetlb/hugepages will show huge pages information

echo "size nr" > /proc/hugetlb/hugepages will modify the page number for size.

e.g 
echo "64k 1000" > /proc/hugetlb/hugepages will allocate 1000 pages of 64k page.

echo "64k 0" > /proc/hugetlb/hugepages will free all the 64k pages

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>


diff -Nraup a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c	2006-04-13 08:36:16.000000000 +0800
+++ b/mm/hugetlb.c	2006-04-13 08:31:38.000000000 +0800
@@ -15,6 +15,9 @@
 #include <linux/cpuset.h>
 #include <linux/mutex.h>
 
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
@@ -259,38 +262,6 @@ void hugetlb_truncate_reservation(struct
 	spin_unlock(&hugetlb_lock);
 }
 
-static int __init hugetlb_init(void)
-{
-	unsigned long i, j;
-
-#ifndef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
-	if (HPAGE_SHIFT(0) == 0)
-		return 0;
-#endif
-
-	for (i = 0; i < MAX_NUMNODES; ++i)
-		for (j = 0; j < MAX_ORDER; ++j)
-			INIT_LIST_HEAD(&hugepage_freelists[i][j]);
-
-	for (i = 0; i < max_huge_pages; ++i) {
-		if (!alloc_fresh_huge_page(HUGETLB_INIT_PAGE_ORDER))
-			break;
-	}
-	max_huge_pages = free_huge_pages[HUGETLB_INIT_PAGE_ORDER] =
nr_huge_pages[HUGETLB_INIT_PAGE_ORDER] = i;
-	printk("Total HugeTLB memory allocated, %ld\n", 
-		free_huge_pages[HUGETLB_INIT_PAGE_ORDER]);
-	return 0;
-}
-module_init(hugetlb_init);
-
-static int __init hugetlb_setup(char *s)
-{
-	if (sscanf(s, "%lu", &max_huge_pages) <= 0)
-		max_huge_pages = 0;
-	return 1;
-}
-__setup("hugepages=", hugetlb_setup);
-
 #ifdef CONFIG_SYSCTL
 static void update_and_free_page(struct page *page, int order)
 {
@@ -364,8 +335,120 @@ int hugetlb_sysctl_handler(struct ctl_ta
 		HUGETLB_INIT_PAGE_ORDER);
 	return 0;
 }
+#ifdef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+static char *
+bitvector_process(char *p, unsigned long vector)
+{
+	int i,j;
+	const char *units[]={ "", "K", "M", "G", "T" };
+
+	for (i=0, j=0; i < 64; i++ , j=i/10) {
+		if (vector & 0x1) {
+			p += sprintf(p, "%d%s ", 1 << (i-j*10), units[j]);
+		}
+		vector >>= 1;
+	}
+	return p;
+}
+
+static int proc_hugetlb_pagesizes_show(struct seq_file *s, void *p)
+{
+	int order;
+	char buf[32];
+	for (order = 0; order < MAX_ORDER; order++) {
+		if (!is_valid_hpage_size(1UL<<(order+PAGE_SHIFT)))
+			continue;
+		bitvector_process(buf, (1UL<<(order+PAGE_SHIFT)));
+		seq_printf(s, "%s\t%ld\t%ld\t%ld\n",
+				buf, nr_huge_pages[order],
+				free_huge_pages[order],
+				reserved_huge_pages[order]);
+	}
+
+	return 0;
+}
+
+static ssize_t proc_hugetlb_pagesizes_write(struct file *file,
+	const char __user *buffer, size_t length, loff_t *ppos)
+{
+	char buf[64];
+	unsigned long nr, order;
+	unsigned long long size;
+	char *rest;
+	if (!buffer || length >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(buf, buffer, length))
+		return -EFAULT;
+	buf[length] = 0;
+
+	size = memparse(buf, &rest);
+	order = __ffs(size) - PAGE_SHIFT;
+	if (order >= MAX_ORDER || !is_valid_hpage_size(size))
+		return -EINVAL;
+	if (sscanf(rest, "%ld", &nr) != 1)
+		return -EINVAL;
+	set_max_huge_pages(nr, order);
+	return length;
+}
+
+static int proc_hugetlb_pagesizes_open(struct inode *inode, struct file
*file)
+{
+	return single_open(file, proc_hugetlb_pagesizes_show, NULL);
+}
+
+static struct file_operations proc_hugetlb_pagesizes_operations = {
+        .open           = proc_hugetlb_pagesizes_open,
+        .read           = seq_read,
+        .write          = proc_hugetlb_pagesizes_write,
+        .llseek         = seq_lseek,
+        .release        = single_release,
+};
+#endif /* ARCH_HAS_VARIABLE_HUGEPAGE_SIZE */
 #endif /* CONFIG_SYSCTL */
 
+static int __init hugetlb_init(void)
+{
+	unsigned long i, j;
+	struct proc_dir_entry *pde;
+
+#ifndef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+	if (HPAGE_SHIFT(0) == 0)
+		return 0;
+#endif
+
+	for (i = 0; i < MAX_NUMNODES; ++i)
+		for (j = 0; j < MAX_ORDER; ++j)
+			INIT_LIST_HEAD(&hugepage_freelists[i][j]);
+
+	for (i = 0; i < max_huge_pages; ++i) {
+		if (!alloc_fresh_huge_page(HUGETLB_INIT_PAGE_ORDER))
+			break;
+	}
+	max_huge_pages = free_huge_pages[HUGETLB_INIT_PAGE_ORDER] =
nr_huge_pages[HUGETLB_INIT_PAGE_ORDER] = i;
+	printk("Total HugeTLB memory allocated, %ld\n",
+		free_huge_pages[HUGETLB_INIT_PAGE_ORDER]);
+
+#ifdef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+        if (!proc_mkdir("hugetlb", NULL))
+		return 1;
+        pde = create_proc_entry("hugetlb/hugepages", 0, NULL);
+        if (!pde)
+                return 1;
+        pde->proc_fops = &proc_hugetlb_pagesizes_operations;
+#endif
+	return 0;
+}
+module_init(hugetlb_init);
+
+static int __init hugetlb_setup(char *s)
+{
+	if (sscanf(s, "%lu", &max_huge_pages) <= 0)
+		max_huge_pages = 0;
+	return 1;
+}
+__setup("hugepages=", hugetlb_setup);
+
+
 int hugetlb_report_meminfo(char *buf)
 {
 	return sprintf(buf,




