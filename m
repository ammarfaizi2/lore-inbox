Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWB1IzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWB1IzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 03:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWB1IzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 03:55:00 -0500
Received: from fmr18.intel.com ([134.134.136.17]:7901 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750796AbWB1IzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 03:55:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: hugepage: Strict page reservation for hugepage inodes
Date: Tue, 28 Feb 2006 16:53:49 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A43B3904@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hugepage: Strict page reservation for hugepage inodes
Thread-Index: AcY8Nq1Q+/Uq+KadRY+OXNMi0yU61wACSSEA
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "William Lee Irwin" <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Feb 2006 08:53:50.0946 (UTC) FILETIME=[7ECD3C20:01C63C44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of David Gibson
>>Sent: 2006Äê2ÔÂ28ÈÕ 15:12
>>To: Andrew Morton
>>Cc: William Lee Irwin; linux-kernel@vger.kernel.org
>>Subject: hugepage: Strict page reservation for hugepage inodes
>>
>>This applies on top of my patch
>>hugepage-serialize-hugepage-allocation-and-instantiation.patch from
>>-mm, and akpm's associated tidying patches.
>>Signed-off-by: David Gibson <dwg@au1.ibm.com>
>>
>>Index: working-2.6/mm/hugetlb.c
>>===================================================================
>>--- working-2.6.orig/mm/hugetlb.c	2006-02-28 18:03:25.000000000 +1100
>>+++ working-2.6/mm/hugetlb.c	2006-02-28 18:03:37.000000000 +1100
>>@@ -21,7 +21,7 @@
>> #include <linux/hugetlb.h>
>>
>> const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
>>-static unsigned long nr_huge_pages, free_huge_pages;
>>+static unsigned long nr_huge_pages, free_huge_pages, reserved_huge_pages;
>> unsigned long max_huge_pages;
>> static struct list_head hugepage_freelists[MAX_NUMNODES];
>> static unsigned int nr_huge_pages_node[MAX_NUMNODES];
>>@@ -119,17 +119,146 @@ void free_huge_page(struct page *page)
>>
>> struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
>> {
>>+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
>> 	struct page *page;
>>+	int use_reserve = 0;
>>+	unsigned long idx;
>>
>> 	spin_lock(&hugetlb_lock);
>>-	page = dequeue_huge_page(vma, addr);
>>-	if (!page) {
>>-		spin_unlock(&hugetlb_lock);
>>-		return NULL;
>>+
>>+	if (vma->vm_flags & VM_MAYSHARE) {
>>+
>>+		/* idx = radix tree index, i.e. offset into file in
>>+		 * HPAGE_SIZE units */
>>+		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
>>+			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
>>+
>>+		/* The hugetlbfs specific inode info stores the number
>>+		 * of "guaranteed available" (huge) pages.  That is,
>>+		 * the first 'prereserved_hpages' pages of the inode
>>+		 * are either already instantiated, or have been
>>+		 * pre-reserved (by hugetlb_reserve_for_inode()). Here
>>+		 * we're in the process of instantiating the page, so
>>+		 * we use this to determine whether to draw from the
>>+		 * pre-reserved pool or the truly free pool. */
>>+		if (idx < HUGETLBFS_I(inode)->prereserved_hpages)
>>+			use_reserve = 1;
>>+	}
>>+
>>+	if (!use_reserve) {
>>+		if (free_huge_pages <= reserved_huge_pages)
>>+			goto fail;
>>+	} else {
>>+		BUG_ON(reserved_huge_pages == 0);
>>+		reserved_huge_pages--;
[YM] Consider this scenario of multi-thread:
One process has 2 threads. The process mmaps a hugetlb area with 1 huge page and
there is a free huge page. Later on, the 2 threads fault on the huge page at the same time.
The second thread would fail, and WARN_ON check is triggered, then the second thread is killed
by function hugetlb_no_page.



>> 	}
>>+
>>+	page = dequeue_huge_page(vma, addr);
>>+	if (!page)
>>+		goto fail;
>>+
>> 	spin_unlock(&hugetlb_lock);
>> 	set_page_count(page, 1);
>> 	return page;
>>+
>>+ fail:
>>+	WARN_ON(use_reserve); /* reserved allocations shouldn't fail */
>>+	spin_unlock(&hugetlb_lock);
>>+	return NULL;
>>+}
>>+
>>+/* hugetlb_extend_reservation()
>>+ *
>>+ * Ensure that at least 'atleast' hugepages are, and will remain,
>>+ * available to instantiate the first 'atleast' pages of the given
>>+ * inode.  If the inode doesn't already have this many pages reserved
>>+ * or instantiated, set aside some hugepages in the reserved pool to
>>+ * satisfy later faults (or fail now if there aren't enough, rather
>>+ * than getting the SIGBUS later).
>>+ */
>>+int hugetlb_extend_reservation(struct hugetlbfs_inode_info *info,
>>+			       unsigned long atleast)
>>+{
>>+	struct inode *inode = &info->vfs_inode;
>>+	struct address_space *mapping = inode->i_mapping;
>>+	unsigned long idx;
>>+	unsigned long change_in_reserve = 0;
>>+	struct page *page;
>>+	int ret = 0;
>>+
>>+	spin_lock(&hugetlb_lock);
>>+	read_lock_irq(&inode->i_mapping->tree_lock);
>>+
>>+	if (info->prereserved_hpages >= atleast)
>>+		goto out;
>>+
>>+	/* prereserved_hpages stores the number of pages already
>>+	 * guaranteed (reserved or instantiated) for this inode.
>>+	 * Count how many extra pages we need to reserve. */
>>+	for (idx = info->prereserved_hpages; idx < atleast; idx++) {
>>+		page = radix_tree_lookup(&mapping->page_tree, idx);
>>+		if (!page)
>>+			/* Pages which are already instantiated don't
>>+			 * need to be reserved */
>>+			change_in_reserve++;
>>+	}
[YM] Why always to go through the page cache? prereserved_hpages and reserved_huge_pages are protected by
hugetlb_lock.

