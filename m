Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUCYRIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbUCYRH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:07:58 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:56841 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263429AbUCYQ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:59:28 -0500
Date: Thu, 25 Mar 2004 17:02:49 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] [5/6] HUGETLB memory commitment
Message-ID: <18926564.1080234169@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[075-mem_acctdom_hugetlb_arch]

Convert hugetlb to accounting domains (arch)

---
 i386/mm/hugetlbpage.c    |   16 +++++++++++++---
 ia64/mm/hugetlbpage.c    |   16 +++++++++++++---
 ppc64/mm/hugetlbpage.c   |   16 +++++++++++++---
 sparc64/mm/hugetlbpage.c |   16 +++++++++++++---
 4 files changed, 52 insertions(+), 12 deletions(-)

diff -upN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c	2004-01-09 07:00:02.000000000 +0000
+++ current/arch/i386/mm/hugetlbpage.c	2004-03-25 15:03:27.000000000 +0000
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -513,13 +513,17 @@ module_init(hugetlb_init);
 
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed = atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB\n",
 			htlbzone_pages,
 			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(committed));
 }
 
 int is_hugepage_mem_enough(size_t size)
@@ -527,6 +531,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem;
 }
 
+/* Return the number pages of memory we physically have, in PAGE_SIZE units. */
+unsigned long hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
diff -upN reference/arch/ia64/mm/hugetlbpage.c current/arch/ia64/mm/hugetlbpage.c
--- reference/arch/ia64/mm/hugetlbpage.c	2004-03-11 20:47:12.000000000 +0000
+++ current/arch/ia64/mm/hugetlbpage.c	2004-03-25 15:03:27.000000000 +0000
@@ -17,7 +17,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -576,13 +576,17 @@ __initcall(hugetlb_init);
 
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed = atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB\n",
 			htlbzone_pages,
 			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(committed));
 }
 
 int is_hugepage_mem_enough(size_t size)
@@ -592,6 +596,12 @@ int is_hugepage_mem_enough(size_t size)
 	return 1;
 }
 
+/* Return the number pages of memory we physically have, in PAGE_SIZE units. */
+unsigned long hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int *unused)
 {
 	BUG();
diff -upN reference/arch/ppc64/mm/hugetlbpage.c current/arch/ppc64/mm/hugetlbpage.c
--- reference/arch/ppc64/mm/hugetlbpage.c	2004-03-11 20:47:14.000000000 +0000
+++ current/arch/ppc64/mm/hugetlbpage.c	2004-03-25 15:03:27.000000000 +0000
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysctl.h>
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -896,13 +896,17 @@ module_init(hugetlb_init);
 
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed = atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5d\n"
 			"HugePages_Free:  %5d\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB",
 			htlbpage_total,
 			htlbpage_free,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(commited));
 }
 
 /* This is advisory only, so we can get away with accesing
@@ -912,6 +916,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpage_free;
 }
 
+/* Return the number pages of memory we physically have, in PAGE_SIZE units. */
+int hugetlb_total_pages(void)
+{
+	return htlbpage_total * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
diff -upN reference/arch/sparc64/mm/hugetlbpage.c current/arch/sparc64/mm/hugetlbpage.c
--- reference/arch/sparc64/mm/hugetlbpage.c	2004-01-09 06:59:45.000000000 +0000
+++ current/arch/sparc64/mm/hugetlbpage.c	2004-03-25 15:03:27.000000000 +0000
@@ -13,8 +13,8 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/mman.h>
 
-#include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
@@ -483,13 +483,17 @@ module_init(hugetlb_init);
 
 int hugetlb_report_meminfo(char *buf)
 {
+	int committed = atomic_read(&vm_committed_space[VM_AD_HUGETLB]);
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"Hugepagesize:    %5lu kB\n"
+			"HugeCommited_AS: %8u kB\n",
 			htlbzone_pages,
 			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			K(committed));
 }
 
 int is_hugepage_mem_enough(size_t size)
@@ -497,6 +501,12 @@ int is_hugepage_mem_enough(size_t size)
 	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem;
 }
 
+/* Return the number pages of memory we physically have, in PAGE_SIZE units. */
+int hugetlb_total_pages(void)
+{
+	return htlbzone_pages * (HPAGE_SIZE / PAGE_SIZE);
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the

