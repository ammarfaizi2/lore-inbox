Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266332AbUFPWIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUFPWIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUFPWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:08:18 -0400
Received: from fmr12.intel.com ([134.134.136.15]:37768 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266332AbUFPWIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:08:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Hugetlb page bug fix for i386 in PAE mode
Date: Wed, 16 Jun 2004 15:07:35 -0700
Message-ID: <B05667366EE6204181EABE9C1B1C0EB5035BF9A2@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hugetlb page bug fix for i386 in PAE mode
Thread-Index: AcRT7lQQp54uADhBQGmKZqx9t2L1Ng==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jun 2004 22:07:36.0135 (UTC) FILETIME=[54AFDD70:01C453EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a bug check when unmap a hugetlb vma in PAE mode on i386 (and
x86-64).

 Bad page state at free_hot_cold_page (in process 'a.out', page
c165cc40)
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

It turns out there is a bug in hugetlb_prefault(): with 3 level page
table,
huge_pte_alloc() might return a pmd that points to a PTE page.  It
happens
if the virtual address for hugetlb mmap is recycled from previously used
normal page mmap.  free_pgtables() might not scrub the pmd entry on
munmap
and hugetlb_prefault skips on any pmd presence regardless what type it
is.
Patch to fix the bug.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

diff -Nurp linux-2.6.7/arch/i386/mm/hugetlbpage.c
linux-2.6.7.htlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.7/arch/i386/mm/hugetlbpage.c	2004-06-16
18:32:30.000000000 -0700
+++ linux-2.6.7.htlb/arch/i386/mm/hugetlbpage.c	2004-06-16
18:34:32.000000000 -0700
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
