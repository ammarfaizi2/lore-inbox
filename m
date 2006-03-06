Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCFGYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCFGYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 01:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWCFGYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 01:24:12 -0500
Received: from fmr23.intel.com ([143.183.121.15]:46013 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751378AbWCFGYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 01:24:11 -0500
Subject: [PATCH] hugetlb_no_page might break hugetlb quota
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, kenneth.w.chen@intel.com
Content-Type: text/plain
Message-Id: <1141626096.29825.13.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 06 Mar 2006 14:21:36 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yanmin <yanmin.zhang@intel.com>

In function hugetlb_no_page, backout path always calls hugetlb_put_quota.
It's incorrect when find_lock_page gets the page or the new page is added
into page cache.

In addition, if the vma->vm_flags doesn't include VM_SHARED, the quota
shouldn't be decreased.

My patch against 2.6.16-rc5-mm2 fixes it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.16-rc5-mm2/mm/hugetlb.c linux-2.6.16-rc5-mm2_quota/mm/hugetlb.c
--- linux-2.6.16-rc5-mm2/mm/hugetlb.c	2006-03-06 18:48:18.000000000 +0800
+++ linux-2.6.16-rc5-mm2_quota/mm/hugetlb.c	2006-03-06 18:48:58.000000000 +0800
@@ -562,11 +562,12 @@ int hugetlb_no_page(struct mm_struct *mm
 retry:
 	page = find_lock_page(mapping, idx);
 	if (!page) {
-		if (hugetlb_get_quota(mapping))
+		if (vma->vm_flags & VM_SHARED && hugetlb_get_quota(mapping))
 			goto out;
 		page = alloc_huge_page(vma, address);
 		if (!page) {
-			hugetlb_put_quota(mapping);
+			if (vma->vm_flags & VM_SHARED)
+				hugetlb_put_quota(mapping);
 			ret = VM_FAULT_OOM;
 			goto out;
 		}
@@ -613,7 +614,6 @@ out:
 
 backout:
 	spin_unlock(&mm->page_table_lock);
-	hugetlb_put_quota(mapping);
 	unlock_page(page);
 	put_page(page);
 	goto out;


