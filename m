Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWDNCRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWDNCRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWDNCRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:17:11 -0400
Received: from mga03.intel.com ([143.182.124.21]:55635 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965075AbWDNCRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:17:09 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23045557:sNHT1038763985"
Subject: Re: [PATCH 2/8] IA64 various hugepage size - Add the
	is_valid_hpage_size function
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Luck@vger.kernel.org,
       Tony <tony.luck@intel.com>, Chen@vger.kernel.org,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144974667.5817.51.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
	 <1144974667.5817.51.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144974881.5817.59.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:34:42 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function is_valid_hpage_size 
Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

diff -Nraup a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	2006-04-11 08:52:02.000000000 +0800
+++ b/arch/ia64/mm/hugetlbpage.c	2006-04-11 09:00:37.000000000 +0800
@@ -159,28 +159,15 @@ unsigned long hugetlb_get_unmapped_area(
 
 static int __init hugetlb_setup_sz(char *str)
 {
-	u64 tr_pages;
 	unsigned long long size;
 
-	if (ia64_pal_vm_page_size(&tr_pages, NULL) != 0)
-		/*
-		 * shouldn't happen, but just in case.
-		 */
-		tr_pages = 0x15557000UL;
-
 	size = memparse(str, &str);
-	if (*str || (size & (size-1)) || !(tr_pages & size) ||
-		size <= PAGE_SIZE ||
-		size >= (1UL << PAGE_SHIFT << MAX_ORDER)) {
+	if (*str || !is_valid_hpage_size(size)) {
 		printk(KERN_WARNING "Invalid huge page size specified\n");
 		return 1;
 	}
 
 	hpage_shift = __ffs(size);
-	/*
-	 * boot cpu already executed ia64_mmu_init, and has HPAGE_SHIFT_DEFAULT
-	 * override here with new page shift.
-	 */
 	ia64_set_rr(HPAGE_REGION_BASE, hpage_shift << 2);
 	return 1;
 }
@@ -191,3 +178,18 @@ void hugepage_size_init(struct mm_struct
   mm->hugepage_shift = hpage_shift;
 }
 
+int is_valid_hpage_size(unsigned long long size)
+{
+        u64 tr_pages;
+        if (ia64_pal_vm_page_size(&tr_pages, NULL) != 0)
+                /*
+                 * shouldn't happen, but just in case.
+                 */
+                tr_pages = 0x15557000UL;
+        if((size & (size-1)) || !(tr_pages & size) ||
+                size <= PAGE_SIZE ||
+                size >= (1UL << PAGE_SHIFT << MAX_ORDER))
+                return 0;
+        return 1;
+}
+
diff -Nraup a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2006-04-11 08:52:00.000000000 +0800
+++ b/include/linux/mm.h	2006-04-11 09:17:36.000000000 +0800
@@ -1061,8 +1061,13 @@ extern int randomize_va_space;
 
 #ifndef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
 #define hugepage_size_init(mm)
+static inline int is_valid_hpage_size(unsigned long long size)
+{
+	return 1;
+}
 #else
 extern void hugepage_size_init(struct mm_struct *mm);
+extern int is_valid_hpage_size(unsigned long long size);
 #endif
 
 #endif /* __KERNEL__ */

