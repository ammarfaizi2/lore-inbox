Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751892AbWCVCjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbWCVCjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWCVCjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:39:25 -0500
Received: from fmr20.intel.com ([134.134.136.19]:63981 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751892AbWCVCjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:39:25 -0500
Subject: [PATCH] less tlb flush in unmap_vmas
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:38:08 +0800
Message-Id: <1142995088.11430.34.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In unmaping region, if current task doesn't need reschedule, don't do a
tlb_finish_mmu. This can reduce some tlb flushes.

In the lmbench tests, this patch gives 2.1% improvement on exec proc
item and 4.2% on sh proc item.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.16-rc5-root/mm/memory.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN mm/memory.c~less_flush mm/memory.c
--- linux-2.6.16-rc5/mm/memory.c~less_flush	2006-03-21 07:22:47.000000000 +0800
+++ linux-2.6.16-rc5-root/mm/memory.c	2006-03-21 07:26:51.000000000 +0800
@@ -837,19 +837,18 @@ unsigned long unmap_vmas(struct mmu_gath
 				break;
 			}
 
-			tlb_finish_mmu(*tlbp, tlb_start, start);
-
 			if (need_resched() ||
 				(i_mmap_lock && need_lockbreak(i_mmap_lock))) {
+				tlb_finish_mmu(*tlbp, tlb_start, start);
 				if (i_mmap_lock) {
 					*tlbp = NULL;
 					goto out;
 				}
 				cond_resched();
+				tlb_start_valid = 0;
+				*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
 			}
 
-			*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
-			tlb_start_valid = 0;
 			zap_work = ZAP_BLOCK_SIZE;
 		}
 	}
_


