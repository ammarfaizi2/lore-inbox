Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVFVDXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVFVDXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVFVDV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:21:58 -0400
Received: from fmr21.intel.com ([143.183.121.13]:50392 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262699AbVFVDTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:19:31 -0400
Message-Id: <200506220319.j5M3JRg30716@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: Variation in measure_migration_cost() with scheduler-cache-hot-autodetect.patch in -mm
Date: Tue, 21 Jun 2005 20:19:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV22TLEFdKtCI6xSZCyAOFjzvSYuQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm consistently getting a smaller than expected cache migration cost
as measured by Ingo's scheduler-cache-hot-autodetect.patch currently
in -mm tree.  In this patch, the memory used to calibrate migration
cost is obtained by vmalloc call.  Would it make sense to use
__get_free_pages() instead?  I did the following experiments on a
variety of machines I have access to:

				migration cost		migration cost
				with vmalloc mem		with __get_free_pages
3.0GHz Xeon, 8MB cache		6.23 ms		6.32 ms
3.4GHz Xeon, 2MB cache		1.62 ms		2.00 ms
1.6GHz Itanium2, 9MB		9.2 ms		10.2 ms
1.4GHz Itanium2, 4MB		4.2 ms		 4.4 ms

Why the discrepancy?  Possible cache coloring issue?



--- linux-2.6.12/kernel/sched.c.orig	2005-06-21 19:42:45.067876790 -0700
+++ linux-2.6.12/kernel/sched.c	2005-06-21 19:43:42.580571398 -0700
@@ -5420,7 +5420,7 @@ measure_cost(int cpu1, int cpu2, void *c
 __init static unsigned long long measure_migration_cost(int cpu1, int cpu2)
 {
 	unsigned long long max_cost = 0, fluct = 0, avg_fluct = 0;
-	unsigned int max_size, size, size_found = 0;
+	unsigned int order, max_size, size, size_found = 0;
 	long long cost = 0, prev_cost;
 	void *cache;
 
@@ -5448,7 +5448,10 @@ __init static unsigned long long measure
 	/*
 	 * Allocate the working set:
 	 */
-	cache = vmalloc(max_size);
+	for (order = 0; PAGE_SIZE << order < max_size; order++)
+		;
+	cache = (void *) __get_free_pages(GFP_KERNEL, order);
+
 	if (!cache) {
 		printk("could not vmalloc %d bytes for cache!\n", 2*max_size);
 		return 1000000; // return 1 msec on very small boxen
@@ -5508,7 +5511,7 @@ __init static unsigned long long measure
 		printk("[%d][%d] working set size found: %d, cost: %Ld\n",
 			cpu1, cpu2, size_found, max_cost);
 
-	vfree(cache);
+	free_pages((unsigned long) cache, order);
 
 	/*
 	 * A task is considered 'cache cold' if at least 2 times

