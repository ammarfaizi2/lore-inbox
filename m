Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLNHyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLNHyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVLNHyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:54:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:6118 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932089AbVLNHyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:54:45 -0500
Message-ID: <439FCFC1.4040905@us.ibm.com>
Date: Tue, 13 Dec 2005 23:54:41 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrea@suse.de, Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 2/6] in_emergency Trigger
References: <439FCECA.3060909@us.ibm.com>
In-Reply-To: <439FCECA.3060909@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000701030503020306030708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000701030503020306030708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Create the 'in_emergency' trigger, to allow userspace to turn access to the
critical pool on and off.  The rationale behind this is to ensure that the
critical pool stays full for *actual* emergency situations, and isn't used
for transient, low-mem situations.

-Matt

--------------000701030503020306030708
Content-Type: text/x-patch;
 name="emergency_trigger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emergency_trigger.patch"

Create a userspace trigger: /proc/sys/vm/in_emergency that notifies the kernel
that the system is in an emergency state, and allows the kernel to delve into
the 'critical pool' to satisfy __GFP_CRITICAL allocations.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc5+critical_pool/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/Documentation/sysctl/vm.txt	2005-12-13 16:01:57.783326968 -0800
+++ linux-2.6.15-rc5+critical_pool/Documentation/sysctl/vm.txt	2005-12-13 16:02:40.935766800 -0800
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
Index: linux-2.6.15-rc5+critical_pool/include/linux/sysctl.h
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/include/linux/sysctl.h	2005-12-13 16:02:13.757898464 -0800
+++ linux-2.6.15-rc5+critical_pool/include/linux/sysctl.h	2005-12-13 16:02:40.937766496 -0800
@@ -181,6 +181,7 @@ enum
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
 	VM_CRITICAL_PAGES=29,	/* # of pages to reserve for __GFP_CRITICAL allocs */
+	VM_IN_EMERGENCY=30,	/* tell the VM if we are/aren't in an emergency */
 };
 
 
Index: linux-2.6.15-rc5+critical_pool/kernel/sysctl.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/kernel/sysctl.c	2005-12-13 16:01:57.784326816 -0800
+++ linux-2.6.15-rc5+critical_pool/kernel/sysctl.c	2005-12-13 16:02:40.942765736 -0800
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
 
Index: linux-2.6.15-rc5+critical_pool/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/mm/page_alloc.c	2005-12-13 16:01:57.810322864 -0800
+++ linux-2.6.15-rc5+critical_pool/mm/page_alloc.c	2005-12-13 16:02:40.946765128 -0800
@@ -53,6 +53,10 @@ unsigned long totalram_pages __read_most
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
 
+/* Is the sytem in an emergency situation? */
+int system_in_emergency = 0;
+EXPORT_SYMBOL(system_in_emergency);
+
 /* The number of pages to maintain in the critical page pool */
 int critical_pages = 0;
 
@@ -927,7 +931,7 @@ struct page * fastcall
 __alloc_pages(gfp_t gfp_mask, unsigned int order,
 		struct zonelist *zonelist)
 {
-	const gfp_t wait = gfp_mask & __GFP_WAIT;
+	gfp_t wait = gfp_mask & __GFP_WAIT;
 	struct zone **z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
@@ -936,6 +940,16 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	int alloc_flags;
 	int did_some_progress;
 
+	if (is_emergency_alloc(gfp_mask)) {
+		/*
+		 * If the system is 'in emergency' and this is a critical
+		 * allocation, then make sure we don't sleep
+		 */
+		gfp_mask &= ~__GFP_WAIT;
+		gfp_mask |= __GFP_HIGH;
+		wait = 0;
+	}
+
 	might_sleep_if(wait);
 
 restart:
@@ -1070,7 +1084,7 @@ nopage:
 	 * Rather than fail one of these allocations, take a page,
 	 * if there are any, from the critical pool.
 	 */
-	if ((gfp_mask & __GFP_CRITICAL) && !order) {
+	if (is_emergency_alloc(gfp_mask) && !order) {
 		page = get_critical_page(gfp_mask);
 		if (page)
 			goto got_pg;
Index: linux-2.6.15-rc5+critical_pool/include/linux/mm.h
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/include/linux/mm.h	2005-12-13 16:01:57.783326968 -0800
+++ linux-2.6.15-rc5+critical_pool/include/linux/mm.h	2005-12-13 16:02:40.950764520 -0800
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

--------------000701030503020306030708--
