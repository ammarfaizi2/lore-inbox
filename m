Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWAKWCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWAKWCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWAKWCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:02:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41359 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751049AbWAKWCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:02:44 -0500
Subject: [PATCH 1/2] hugetlb: Delay page zeroing for faulted pages
From: Adam Litke <agl@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1136920951.23288.5.camel@localhost.localdomain>
References: <1136920951.23288.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Wed, 11 Jan 2006 16:02:40 -0600
Message-Id: <1137016960.9672.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've come up with a much better idea to resolve the issue I mention
below.  The attached patch changes hugetlb_no_page to allocate unzeroed
huge pages initially.  For shared mappings, we wait until after
inserting the page into the page_cache succeeds before we zero it.  This
has a side benefit of preventing the wasted zeroing that happened often
in the original code.  The page_lock should guard against someone else
using the page before it has been zeroed (but correct me if I am wrong
here).  The patch doesn't completely close the race (there is a much
smaller window without the zeroing though).  The next patch should close
the race window completely.

On Tue, 2006-01-10 at 13:22 -0600, Adam Litke wrote: 
> The race occurs when multiple threads shmat a hugetlb area and begin
> faulting in it's pages.  During a hugetlb fault, hugetlb_no_page checks
> for the page in the page cache.  If not found, it allocates (and zeroes)
> a new page and tries to add it to the page cache.  If this fails, the
> huge page is freed and we retry the page cache lookup (assuming someone
> else beat us to the add_to_page_cache call).
> 
> The above works fine, but due to the large window (while zeroing the
> huge page) it is possible that many threads could be "borrowing" pages
> only to return them later.  This causes free_hugetlb_pages to be lower
> than the logical number of free pages and some threads trying to shmat
> can falsely fail the accounting check.

Signed-off-by: Adam Litke <agl@us.ibm.com>

 hugetlb.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)
diff -upN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c
+++ current/mm/hugetlb.c
@@ -92,10 +92,10 @@ void free_huge_page(struct page *page)
 	spin_unlock(&hugetlb_lock);
 }
 
-struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
+struct page *alloc_unzeroed_huge_page(struct vm_area_struct *vma,
+					unsigned long addr)
 {
 	struct page *page;
-	int i;
 
 	spin_lock(&hugetlb_lock);
 	page = dequeue_huge_page(vma, addr);
@@ -106,8 +106,26 @@ struct page *alloc_huge_page(struct vm_a
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	page[1].mapping = (void *)free_huge_page;
+
+	return page;
+}
+	
+void zero_huge_page(struct page *page)
+{
+	int i;
+	
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_highpage(&page[i]);
+}
+
+struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct page *page;
+
+	page = alloc_unzeroed_huge_page(vma, addr);
+	if (page)
+		zero_huge_page(page);
+	
 	return page;
 }
 
@@ -441,7 +459,7 @@ retry:
 	if (!page) {
 		if (hugetlb_get_quota(mapping))
 			goto out;
-		page = alloc_huge_page(vma, address);
+		page = alloc_unzeroed_huge_page(vma, address);
 		if (!page) {
 			hugetlb_put_quota(mapping);
 			goto out;
@@ -460,6 +478,8 @@ retry:
 			}
 		} else
 			lock_page(page);
+
+		zero_huge_page(page);
 	}
 
 	spin_lock(&mm->page_table_lock);


-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

