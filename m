Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVLHAsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVLHAsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVLHAsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:48:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:6856 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965067AbVLHAsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:48:30 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andy Whitcroft <andyw@uk.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1133997772.21841.62.camel@localhost.localdomain>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
	 <1133997772.21841.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 16:48:08 -0800
Message-Id: <1134002888.30387.82.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 15:22 -0800, Badari Pulavarty wrote:
> BTW, the problem seems to be while dealing with shared memory areas
> that are backed by largepages.

I think this is likely not directly a sparsemem problem.  It probably
just shows symptoms earlier.

See the attached patch.  It attempts to detect and handle hugetlb pages
in the smaps code.  However, I think one of the root issues here is that
bad_pmd() triggers for hugetlb pmds.  I audited a few places where it is
called, and at least a couple of them can't have hugepages handed into
them, like fork().

-- Dave



---

 proc-dups-dave/fs/proc/task_mmu.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

diff -puN fs/proc/task_mmu.c~task_mmu_fix fs/proc/task_mmu.c
--- proc-dups/fs/proc/task_mmu.c~task_mmu_fix	2005-12-07 16:34:38.000000000 -0800
+++ proc-dups-dave/fs/proc/task_mmu.c	2005-12-07 16:34:47.000000000 -0800
@@ -245,6 +245,28 @@ static inline void smaps_pmd_range(struc
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+
+		if (pmd_huge(*pmd)) {
+			struct page *page;
+
+			page = follow_huge_pmd(vma->vm_mm, addr, pmd, 0);
+			if (!page)
+				continue;
+
+			mss->resident += HPAGE_SIZE;
+			if (page_count(page) >= 2) {
+				if (pte_dirty(*(pte_t *)pmd))
+					mss->shared_dirty += HPAGE_SIZE;
+				else
+					mss->shared_clean += HPAGE_SIZE;
+			} else {
+				if (pte_dirty(*(pte_t *)pmd))
+					mss->private_dirty += HPAGE_SIZE;
+				else
+					mss->private_clean += HPAGE_SIZE;
+			}
+			continue;
+		}
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		smaps_pte_range(vma, pmd, addr, next, mss);
_


