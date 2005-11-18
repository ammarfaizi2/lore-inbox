Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbVKRRv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbVKRRv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVKRRv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:51:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161006AbVKRRvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:51:55 -0500
Subject: [PATCH] Fix race in set_max_huge_pages for multiple updaters of
	nr_huge_pages
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, wli@holomorphy.com
Content-Type: text/plain
Date: Fri, 18 Nov 2005 12:51:40 -0500
Message-Id: <1132336300.5151.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple updaters to /proc/sys/vm/nr_hugepages
simultaneously it is possible for the nr_huge_pages variable to become
incorrect.  There is no locking in the set_max_huge_pages function
around alloc_fresh_huge_page which is able to update nr_huge_pages.  Two
callers to alloc_fresh_huge_page could race against each other as could
a call to alloc_fresh_huge_page and a call to update_and_free_page.
This patch just expands the area covered by the hugetlb_lock to cover
the call into alloc_fresh_huge_page.  I'm not sure how we could say that
a sysctl section is performance critical where more specific locking
would be needed.

My reproducer was to run a couple copies of the following script
simultaneously

while [ true ]; do
	echo 1000 > /proc/sys/vm/nr_hugepages
	echo 500 > /proc/sys/vm/nr_hugepages
	echo 750 > /proc/sys/vm/nr_hugepages
	echo 100 > /proc/sys/vm/nr_hugepages
	echo 0 > /proc/sys/vm/nr_hugepages
done

and then watch /proc/meminfo and eventually you will see things like

HugePages_Total:     100
HugePages_Free:      109

After applying the patch all seemed well.

Signed-off-by: Eric Paris <eparis@redhat.com>
----

 hugetlb.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6.14.2/mm/hugetlb.c.old
+++ linux-2.6.14.2/mm/hugetlb.c
@@ -22,6 +22,7 @@
 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static unsigned int nr_huge_pages_node[MAX_NUMNODES];
 static unsigned int free_huge_pages_node[MAX_NUMNODES];
+/* This lock protects updates to hugepage_freelists, nr_huge_pages, and free_huge_pages */
 static DEFINE_SPINLOCK(hugetlb_lock);
 
 static void enqueue_huge_page(struct page *page)
@@ -172,10 +173,13 @@
 static unsigned long set_max_huge_pages(unsigned long count)
 {
 	while (count > nr_huge_pages) {
-		struct page *page = alloc_fresh_huge_page();
-		if (!page)
-			return nr_huge_pages;
+		struct page *page;
 		spin_lock(&hugetlb_lock);
+		page = alloc_fresh_huge_page();
+		if (!page) {
+			spin_unlock(&hugetlb_lock);
+			return nr_huge_pages;
+		}
 		enqueue_huge_page(page);
 		spin_unlock(&hugetlb_lock);
 	}

