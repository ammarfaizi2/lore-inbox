Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUFPWOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUFPWOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266338AbUFPWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:14:10 -0400
Received: from fmr04.intel.com ([143.183.121.6]:20191 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264262AbUFPWNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:13:35 -0400
Message-Id: <200406162212.i5GMChY25634@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Hugetlb page bug fix for i386 in PAE mode
Date: Wed, 16 Jun 2004 15:13:33 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRT7lQQp54uADhBQGmKZqx9t2L1NgAAIERQ
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB58022A3@scsmsx401.amr.corp.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hate my email client, just about to throw my *&^%$ out of the windows.
Resent with no line wrap, etc.

-----Original Message-----

Hit a bug check when unmap a hugetlb vma in PAE mode on i386 (and x86-64).

 Bad page state at free_hot_cold_page (in process 'a.out', page c165cc40)
 flags:0x20000000 mapping:f75e1d00 mapped:0 count:0
 Backtrace:
 Call Trace:
  [<c0133e0d>] bad_page+0x79/0x9e
  [<c0134550>] free_hot_cold_page+0x71/0xfa
  [<c0115d60>] unmap_hugepage_range+0xa3/0xbf
  [<c013d375>] unmap_vmas+0xac/0x252
  [<c0117691>] default_wake_function+0x0/0xc
  [<c0140bea>] unmap_region+0xd8/0x145
  [<c0140f2d>] do_munmap+0xfc/0x14d
  [<c01b8a56>] sys_shmdt+0xa5/0x126
  [<c010a2ad>] sys_ipc+0x23c/0x27f
  [<c014a85e>] sys_write+0x38/0x59
  [<c0103e1b>] syscall_call+0x7/0xb

It turns out there is a bug in hugetlb_prefault(): with 3 level page table,
huge_pte_alloc() might return a pmd that points to a PTE page.  It happens
if the virtual address for hugetlb mmap is recycled from previously used
normal page mmap.  free_pgtables() might not scrub the pmd entry on munmap
and hugetlb_prefault skips on any pmd presence regardless what type it is.
Patch to fix the bug.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

diff -Nurp linux-2.6.7/arch/i386/mm/hugetlbpage.c linux-2.6.7.htlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.7/arch/i386/mm/hugetlbpage.c	2004-06-16 18:32:30.000000000 -0700
+++ linux-2.6.7.htlb/arch/i386/mm/hugetlbpage.c	2004-06-16 18:34:32.000000000 -0700
@@ -244,8 +244,15 @@ int hugetlb_prefault(struct address_spac
 			ret = -ENOMEM;
 			goto out;
 		}
-		if (!pte_none(*pte))
-			continue;
+
+		if (!pte_none(*pte)) {
+			pmd_t *pmd = (pmd_t *) pte;
+
+			page = pmd_page(*pmd);
+			pmd_clear(pmd);
+			dec_page_state(nr_page_table_pages);
+			page_cache_release(page);
+		}

 		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
 			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));


