Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVIFV6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVIFV6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVIFV6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:58:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50331 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750995AbVIFV6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:58:08 -0400
Subject: [PATCH 1/3 htlb-get_user_pages] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1126043611.3123.55.camel@localhost.localdomain>
References: <1126043611.3123.55.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 06 Sep 2005 16:57:49 -0500
Message-Id: <1126043869.3123.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Post (Thu, 18 Aug 2005)

In preparation for hugetlb demand faulting, remove this get_user_pages()
optimization.  Since huge pages will no longer be prefaulted, we can't assume
that the huge ptes are established and hence, calling follow_hugetlb_page() is
not valid.

With the follow_hugetlb_page() call removed, the normal code path will be
triggered.  follow_page() will either use follow_huge_addr() or
follow_huge_pmd() to check for a previously faulted "page" to return.  When
this fails (ie. with demand faults), __handle_mm_fault() gets called which
invokes the hugetlb_fault() handler to instantiate the huge page.

This patch doesn't make a lot of sense by itself, but I've broken it out to
facilitate discussion on this specific element of the demand fault changes.
While coding this up, I referenced previous discussion on this topic starting
at http://lkml.org/lkml/2004/4/13/176 , which contains more opinions about the
correctness of this approach.

Diffed against 2.6.13-git6

Signed-off-by: Adam Litke <agl@us.ibm.com>

---
 memory.c |    5 -----
 1 files changed, 5 deletions(-)
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -949,11 +949,6 @@ int get_user_pages(struct task_struct *t
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			int write_access = write;


