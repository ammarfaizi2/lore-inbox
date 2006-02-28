Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWB1JWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWB1JWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 04:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWB1JWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 04:22:03 -0500
Received: from fmr19.intel.com ([134.134.136.18]:7851 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932124AbWB1JWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 04:22:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: hugepage: Strict page reservation for hugepage inodes
Date: Tue, 28 Feb 2006 17:21:16 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A43B3934@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: hugepage: Strict page reservation for hugepage inodes
Thread-Index: AcY8R5Y7sxek/nqAQ16ijXieHTBn2AAACzWg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: "Andrew Morton" <akpm@osdl.org>, "William Lee Irwin" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Feb 2006 09:21:17.0872 (UTC) FILETIME=[54723300:01C63C48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: David Gibson [mailto:david@gibson.dropbear.id.au]
>>Sent: 2006Äê2ÔÂ28ÈÕ 17:15
>>To: Zhang, Yanmin
>>Cc: Andrew Morton; William Lee Irwin; linux-kernel@vger.kernel.org
>>Subject: Re: hugepage: Strict page reservation for hugepage inodes
>>
>>On Tue, Feb 28, 2006 at 04:53:49PM +0800, Zhang, Yanmin wrote:
>>> [YM] Consider this scenario of multi-thread:
>>> One process has 2 threads. The process mmaps a hugetlb area with 1
>>> huge page and there is a free huge page. Later on, the 2 threads
>>> fault on the huge page at the same time.  The second thread would
>>> fail, and WARN_ON check is triggered, then the second thread is
>>> killed by function hugetlb_no_page.
>>
>>That's why this patch *must* go after my other patch which serializes
>>the allocation->instantiation path.
[YM] Sorry, I didn't see other patches. 


>>> >>+int hugetlb_extend_reservation(struct hugetlbfs_inode_info *info,
>>> >>+			       unsigned long atleast)
>>> >>+{
>>> >>+	struct inode *inode = &info->vfs_inode;
>>> >>+	struct address_space *mapping = inode->i_mapping;
>>> >>+	unsigned long idx;
>>> >>+	unsigned long change_in_reserve = 0;
>>> >>+	struct page *page;
>>> >>+	int ret = 0;
>>> >>+
>>> >>+	spin_lock(&hugetlb_lock);
>>> >>+	read_lock_irq(&inode->i_mapping->tree_lock);
>>> >>+
>>> >>+	if (info->prereserved_hpages >= atleast)
>>> >>+		goto out;
>>> >>+
>>> >>+	/* prereserved_hpages stores the number of pages already
>>> >>+	 * guaranteed (reserved or instantiated) for this inode.
>>> >>+	 * Count how many extra pages we need to reserve. */
>>> >>+	for (idx = info->prereserved_hpages; idx < atleast; idx++) {
>>> >>+		page = radix_tree_lookup(&mapping->page_tree, idx);
>>> >>+		if (!page)
>>> >>+			/* Pages which are already instantiated don't
>>> >>+			 * need to be reserved */
>>> >>+			change_in_reserve++;
>>> >>+	}
>>> [YM] Why always to go through the page cache? prereserved_hpages and
>>> reserved_huge_pages are protected by hugetlb_lock.
>>
>>Erm.. sorry, I don't see how that helps.  We need to go through the
>>page cache to see which pages have already been instantiated, and so
>>don't need to be reserved.
[YM] The huge pages beyond info->prereserved_hpages are always not allocated.

