Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266620AbUFWTdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266620AbUFWTdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFWTdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:33:32 -0400
Received: from fmr03.intel.com ([143.183.121.5]:26496 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266628AbUFWTdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:33:02 -0400
Message-Id: <200406231931.i5NJVeY10040@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: More bug fix in mm/hugetlb.c - fix try_to_free_low()
Date: Wed, 23 Jun 2004 12:33:00 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRZWOSfZF1L1+w9Q9qh2U2PoW6zWA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it just me having bad luck with hugetlb for x86 lately?  Take base
2.6.7, turn on CONFIG_HIGHMEM and CONFIG_HUGETLBFS.  Try to config
the hugetlb pool:

[root@quokka]# echo 100 > /proc/sys/vm/nr_hugepages
[root@quokka]# grep HugePage /proc/meminfo
HugePages_Total:   100
HugePages_Free:    100

[root@quokka]# echo 20 > /proc/sys/vm/nr_hugepages
[root@quokka]# grep HugePage /proc/meminfo
HugePages_Total:     0
HugePages_Free:      0

[root@quokka]# echo 100 > /proc/sys/vm/nr_hugepages
[root@quokka]# grep HugePage /proc/meminfo
HugePages_Total:   100
HugePages_Free:    100

[root@quokka]# echo 0 > /proc/sys/vm/nr_hugepages
[root@quokka]# grep HugePage /proc/meminfo
HugePages_Total:    31
HugePages_Free:     31

The argument "count" passed to try_to_free_low() is the config parameter
for desired hugetlb page pool size.  But the implementation took that
input argument as number of pages to free. It also decrement the config
parameter as well.  All give random behavior depend on how many hugetlb
pages are in normal/highmem zone.

A two line fix in try_to_free_low() would be:

-			if (!--count)
-				return 0;
+			if (count >= nr_huge_pages)
+				return count;

But more appropriately, that function shouldn't return anything.

diff -Nurp linux-2.6.7.orig/mm/hugetlb.c linux-2.6.7/mm/hugetlb.c
--- linux-2.6.7.orig/mm/hugetlb.c	2004-06-15 22:19:37.000000000 -0700
+++ linux-2.6.7/mm/hugetlb.c	2004-06-23 12:11:31.000000000 -0700
@@ -130,7 +130,7 @@ static void update_and_free_page(struct
 }

 #ifdef CONFIG_HIGHMEM
-static int try_to_free_low(unsigned long count)
+static void try_to_free_low(unsigned long count)
 {
 	int i;
 	for (i = 0; i < MAX_NUMNODES; ++i) {
@@ -141,16 +141,14 @@ static int try_to_free_low(unsigned long
 			list_del(&page->lru);
 			update_and_free_page(page);
 			--free_huge_pages;
-			if (!--count)
-				return 0;
+			if (count >= nr_huge_pages)
+				return;
 		}
 	}
-	return count;
 }
 #else
-static inline int try_to_free_low(unsigned long count)
+static inline void try_to_free_low(unsigned long count)
 {
-	return count;
 }
 #endif

@@ -170,7 +168,8 @@ static unsigned long set_max_huge_pages(
 		return nr_huge_pages;

 	spin_lock(&hugetlb_lock);
-	for (count = try_to_free_low(count); count < nr_huge_pages; --free_huge_pages) {
+	try_to_free_low(count);
+	for (; count < nr_huge_pages; --free_huge_pages) {
 		struct page *page = dequeue_huge_page();
 		if (!page)
 			break;


