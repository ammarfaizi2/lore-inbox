Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWEIHBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWEIHBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWEIHBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:01:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:24973 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751433AbWEIHBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:01:32 -0400
Date: Tue, 9 May 2006 12:31:06 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 2/6] Kprobes: Get one pagetable entry
Message-ID: <20060509070106.GB22493@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509065917.GA22493@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provide a wrapper routine to allocate one page
table entry for a given virtual address address. Kprobe's
user-space probe mechanism uses this routine to get one
page table entry. As Nick Piggin suggested, this generic
routine can be used by routines like get_user_pages,
find_*_page, and other standard APIs.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 mm/memory.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+)

diff -puN mm/memory.c~kprobes_userspace_probes-get-one-pagetable-entry mm/memory.c
--- linux-2.6.17-rc3-mm1/mm/memory.c~kprobes_userspace_probes-get-one-pagetable-entry	2006-05-09 10:08:44.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/mm/memory.c	2006-05-09 10:08:44.000000000 +0530
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kprobes.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -417,6 +418,34 @@ struct page *vm_normal_page(struct vm_ar
 }
 
 /*
+ * This routines get the pte of the page containing the specified address.
+ */
+pte_t  __kprobes *get_one_pte(unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte = NULL;
+
+	pgd = pgd_offset(current->mm, address);
+	if (!pgd)
+		goto out;
+
+	pud = pud_offset(pgd, address);
+	if (!pud)
+		goto out;
+
+	pmd = pmd_offset(pud, address);
+	if (!pmd)
+		goto out;
+
+	pte = pte_alloc_map(current->mm, pmd, address);
+
+out:
+	return pte;
+}
+
+/*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
