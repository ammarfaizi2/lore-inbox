Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVKRThF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVKRThF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVKRThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:37:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40325 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932257AbVKRThA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:37:00 -0500
Message-ID: <437E2D57.9050304@us.ibm.com>
Date: Fri, 18 Nov 2005 11:36:55 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 2/8] Create emergency trigger
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090406090203010200010601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406090203010200010601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Create the in_emergency trigger.

-Matt

--------------090406090203010200010601
Content-Type: text/x-patch;
 name="emergency_trigger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emergency_trigger.patch"

Create a userspace trigger: /proc/sys/vm/in_emergency that notifies the kernel
that the system is in an emergency state, and allows the kernel to delve into
the 'critical pool' to satisfy __GFP_CRITICAL allocations.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc1+critical_pool/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/Documentation/sysctl/vm.txt	2005-11-17 16:51:19.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/Documentation/sysctl/vm.txt	2005-11-17 16:51:20.000000000 -0800
@@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/
 - laptop_mode
 - block_dump
 - critical_pages
+- in_emergency
 
 ==============================================================
 
@@ -112,3 +113,12 @@ This is used to force the Linux VM to re
 emergency (__GFP_CRITICAL) allocations.  Allocations with this flag
 MUST succeed.
 The number written into this file is the number of pages to reserve.
+
+==============================================================
+
+in_emergency:
+
+This is used to let the Linux VM know that userspace thinks that the system is
+in an emergency situation.
+Writing a non-zero value into this file tells the VM we *are* in an emergency
+situation & writing zero tells the VM we *are not* in an emergency situation.
Index: linux-2.6.15-rc1+critical_pool/include/linux/sysctl.h
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/include/linux/sysctl.h	2005-11-17 16:51:19.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/include/linux/sysctl.h	2005-11-17 16:51:20.000000000 -0800
@@ -182,6 +182,7 @@ enum
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
 	VM_CRITICAL_PAGES=30,	/* # of pages to reserve for __GFP_CRITICAL allocs */
+	VM_IN_EMERGENCY=31,	/* tell the VM if we are/aren't in an emergency */
 };
 
 
Index: linux-2.6.15-rc1+critical_pool/kernel/sysctl.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/kernel/sysctl.c	2005-11-17 16:51:19.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/kernel/sysctl.c	2005-11-17 16:51:20.000000000 -0800
@@ -859,6 +859,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+	{
+		.ctl_name	= VM_IN_EMERGENCY,
+		.procname	= "in_emergency",
+		.data		= &system_in_emergency,
+		.maxlen		= sizeof(system_in_emergency),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.15-rc1+critical_pool/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/mm/page_alloc.c	2005-11-17 16:51:19.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/mm/page_alloc.c	2005-11-18 11:24:02.024254248 -0800
@@ -53,6 +53,9 @@ unsigned long totalram_pages __read_most
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
 
+/* Is the sytem in an emergency situation? */
+int system_in_emergency = 0;
+
 /* The number of pages to maintain in the critical page pool */
 int critical_pages = 0;
 
@@ -865,7 +868,7 @@ struct page * fastcall
 __alloc_pages(gfp_t gfp_mask, unsigned int order,
 		struct zonelist *zonelist)
 {
-	const gfp_t wait = gfp_mask & __GFP_WAIT;
+	gfp_t wait = gfp_mask & __GFP_WAIT;
 	struct zone **zones, *z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
@@ -876,6 +879,16 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	int can_try_harder;
 	int did_some_progress;
 
+	if (is_emergency_alloc(gfp_mask)) {
+		/*
+		 * If the system is 'in emergency' and this is a critical
+		 * allocation, then make sure we don't sleep
+		 */
+		gfp_mask &= ~__GFP_WAIT;
+		gfp_mask |= __GFP_NORECLAIM | __GFP_HIGH;
+		wait = 0;
+	}
+
 	might_sleep_if(wait);
 
 	/*
@@ -1053,7 +1066,7 @@ nopage:
 	 * Rather than fail one of these allocations, take a page (if any)
 	 * from the critical pool.
 	 */
-	if (gfp_mask & __GFP_CRITICAL) {
+	if (is_emergency_alloc(gfp_mask)) {
 		page = get_critical_page(gfp_mask);
 		if (page) {
 			z = page_zone(page);
Index: linux-2.6.15-rc1+critical_pool/include/linux/mm.h
===================================================================
--- linux-2.6.15-rc1+critical_pool.orig/include/linux/mm.h	2005-11-17 16:51:19.000000000 -0800
+++ linux-2.6.15-rc1+critical_pool/include/linux/mm.h	2005-11-17 16:51:20.000000000 -0800
@@ -33,6 +33,12 @@ extern int sysctl_legacy_va_layout;
 #endif
 
 extern int critical_pages;
+extern int system_in_emergency;
+
+static inline int is_emergency_alloc(gfp_t gfpmask)
+{
+	return system_in_emergency && (gfpmask & __GFP_CRITICAL);
+}
 
 #include <asm/page.h>
 #include <asm/pgtable.h>

--------------090406090203010200010601--
