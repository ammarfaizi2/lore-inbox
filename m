Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUJLSsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUJLSsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUJLSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:48:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:12526 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266582AbUJLSso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:48:44 -0400
Subject: Re: 4level page tables for Linux
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@digeo.com
In-Reply-To: <20041012135919.GB20992@wotan.suse.de>
References: <20041012135919.GB20992@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1097606902.10652.203.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 11:48:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

@@ -110,13 +115,18 @@ int install_file_pte(struct mm_struct *m
                unsigned long addr, unsigned long pgoff, pgprot_t prot)
 {
...
+       pml4 = pml4_offset(mm, addr);
+
+       spin_lock(&mm->page_table_lock);
+       pgd = pgd_alloc(mm, pml4, addr);
+       if (!pgd)
+               goto err_unlock;

Locking isn't needed for access to the pml4?  This is a wee bit
different from pgd's and I didn't see any documentation about it
anywhere.  Could be confusing.

+++ linux-2.6.9rc4-4level/mm/memory.c 
...
+#undef inline
+#define inline
+unsigned long caddr;

Is this just for debugging?

+static inline void free_one_pml4(struct mmu_gather *tlb, pml4_t *pml4,
+                                unsigned long addr, unsigned long end)
+{
...
+       do {
+               caddr = addr;
+               free_one_pgd(tlb, pgd);
+               free++;
+               addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
+               pgd++;
+       } while (addr && addr < end);

If someone attempts to clear an address which is in the top PGDIR_SIZE
bytes of memory, this will overflow.  Is that an issue?

There also seems to be quite a bit of churn in the copy_*_range()
functions that isn't completely related to the pml4 changes.  Should
that get broken out?

-- Dave

