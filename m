Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUHQITm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUHQITm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUHQISN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:18:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57802 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268156AbUHQIRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:17:11 -0400
Date: Tue, 17 Aug 2004 10:18:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
Message-ID: <20040817081829.GA1977@elte.hu>
References: <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <20040817021431.169d07db@mango.fruits.de> <1092701223.13981.106.camel@krustophenia.net> <20040817073927.GA594@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817073927.GA594@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > Yes, Ingo identified an issue with copy_page_range, I don't think it's
> > fixed yet.  See the voluntary-preempt-2.6.8.1-P0 thread.
> 
> right, it's not fixed yet. It's not a trivial critical section - we
> are holding two locks and are mapping two atomic kmaps.

fortunately it's easier than i thought - neither the source pmd nor the
target pmd can go away so we can simply drop the locks, reschedule, and
remap. Does the patch below (ontop of -P3) fix the copy_page_range()
latencies you are seeing?

	Ingo

--- linux/mm/memory.c.orig	
+++ linux/mm/memory.c	
@@ -337,6 +337,15 @@ cont_copy_pte_range_noset:
 				}
 				src_pte++;
 				dst_pte++;
+				if (voluntary_need_resched()) {
+					pte_unmap_nested(src_pte);
+					pte_unmap(dst_pte);
+					spin_unlock(&src->page_table_lock);
+					cond_resched_lock(&dst->page_table_lock);
+					spin_lock(&src->page_table_lock);
+					dst_pte = pte_offset_map(dst_pmd, address);
+					src_pte = pte_offset_map_nested(src_pmd, address);
+				}
 			} while ((unsigned long)src_pte & PTE_TABLE_MASK);
 			pte_unmap_nested(src_pte-1);
 			pte_unmap(dst_pte-1);
