Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVBWTSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVBWTSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVBWTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:18:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31223 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261540AbVBWTRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:17:31 -0500
Date: Wed, 23 Feb 2005 19:16:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <1109182061.16201.6.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Lee Revell wrote:
> 
> Did something change recently in the VM that made copy_pte_range and
> clear_page_range a lot more expensive?  I noticed a reference in the
> "Page Table Iterators" thread to excessive overhead introduced by
> aggressive page freeing.  That sure looks like what is going on in
> trace2.  trace1 and trace3 look like big fork latencies associated with
> copy_pte_range.

I'm just about to test this patch below: please give it a try: thanks...

Ingo's patch to reduce scheduling latencies, by checking for lockbreak
in copy_page_range, was in the -VP and -mm patchsets some months ago;
but got preempted by the 4level rework, and not reinstated since.
Restore it now in copy_pte_range - which mercifully makes it easier.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc4-bk9/mm/memory.c	2005-02-21 11:32:19.000000000 +0000
+++ linux/mm/memory.c	2005-02-23 18:35:28.000000000 +0000
@@ -328,6 +328,7 @@ static int copy_pte_range(struct mm_stru
 	pte_t *s, *d;
 	unsigned long vm_flags = vma->vm_flags;
 
+again:
 	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
 	if (!dst_pte)
 		return -ENOMEM;
@@ -338,11 +339,22 @@ static int copy_pte_range(struct mm_stru
 		if (pte_none(*s))
 			continue;
 		copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
+		/*
+		 * We are holding two locks at this point - either of them
+		 * could generate latencies in another task on another CPU.
+		 */
+		if (need_resched() ||
+		    need_lockbreak(&src_mm->page_table_lock) ||
+		    need_lockbreak(&dst_mm->page_table_lock))
+			break;
 	}
 	pte_unmap_nested(src_pte);
 	pte_unmap(dst_pte);
 	spin_unlock(&src_mm->page_table_lock);
+
 	cond_resched_lock(&dst_mm->page_table_lock);
+	if (addr < end)
+		goto again;
 	return 0;
 }
 
