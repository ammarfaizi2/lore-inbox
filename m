Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269257AbUINLAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269257AbUINLAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269266AbUINLAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:00:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62433 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269257AbUINK7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:59:47 -0400
Date: Tue, 14 Sep 2004 12:56:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched, mm: fix scheduling latencies in unmap_vmas()
Message-ID: <20040914105634.GA31370@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20040914105048.GA31238@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The attached patch fixes long latencies in unmap_vmas(). We had
lockbreak code in that function already but it did not take delayed
effects of TLB-gather into account.

has been tested as part of the -VP patchset.

	Ingo

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-unmap_vmas.patch"


The attached patch fixes long latencies in unmap_vmas(). We had
lockbreak code in that function already but it did not take delayed
effects of TLB-gather into account.

has been tested as part of the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -497,19 +497,15 @@ static void unmap_page_range(struct mmu_
 	tlb_end_vma(tlb, vma);
 }
 
-/* Dispose of an entire struct mmu_gather per rescheduling point */
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-#define ZAP_BLOCK_SIZE	(FREE_PTE_NR * PAGE_SIZE)
-#endif
-
-/* For UP, 256 pages at a time gives nice low latency */
-#if !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-#define ZAP_BLOCK_SIZE	(256 * PAGE_SIZE)
-#endif
-
+#ifdef CONFIG_PREEMPT
+/*
+ * It's not an issue to have a small zap block size - TLB flushes
+ * only happen once normally, due to the tlb->need_flush optimization.
+ */
+# define ZAP_BLOCK_SIZE	(8 * PAGE_SIZE)
+#else
 /* No preempt: go for improved straight-line efficiency */
-#if !defined(CONFIG_PREEMPT)
-#define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
+# define ZAP_BLOCK_SIZE	(1024 * PAGE_SIZE)
 #endif
 
 /**
@@ -584,15 +580,15 @@ int unmap_vmas(struct mmu_gather **tlbp,
 
 			start += block;
 			zap_bytes -= block;
-			if ((long)zap_bytes > 0)
-				continue;
-			if (!atomic && need_resched()) {
+			if (!atomic) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched_lock(&mm->page_table_lock);
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
 			}
+			if ((long)zap_bytes > 0)
+				continue;
 			zap_bytes = ZAP_BLOCK_SIZE;
 		}
 	}

--r5Pyd7+fXNt84Ff3--
