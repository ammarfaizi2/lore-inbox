Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVBWUIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVBWUIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVBWUHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:07:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31442 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261547AbVBWUH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:07:28 -0500
Date: Wed, 23 Feb 2005 20:06:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <1109187381.3174.5.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com> 
    <1109187381.3174.5.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Lee Revell wrote:
> On Wed, 2005-02-23 at 19:16 +0000, Hugh Dickins wrote:
> > 
> > I'm just about to test this patch below: please give it a try: thanks...

I'm very sorry, there's two things wrong with that version: _must_
increment addr before breaking out, and better to check after pte_none
too (we can question whether it might be checking too often, but this
replicates what Ingo was doing).  Please replace by new patch below,
which I'm now running through lmbench.

> Aha, that explains why all the latency regressions involve the VM
> subsystem. 
> 
> Thanks, your patch fixes the copy_pte_range latency.

Great, if the previous patch fixed that latency then this new one
will too, no need to report on that; but please get rid of the old
patch before it leaks too many of your pages.

> Now zap_pte_range,
> which Ingo also fixed a few months ago, is the worst offender.  Can this
> fix be easily ported too?

That surprises me: all the zap_pte_range latency fixes I know of
are in 2.6.11-rc, perhaps Ingo knows of something missing there?

Hugh

Ingo's patch to reduce scheduling latencies, by checking for lockbreak
in copy_page_range, was in the -VP and -mm patchsets some months ago;
but got preempted by the 4level rework, and not reinstated since.
Restore it now in copy_pte_range - which mercifully makes it easier.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc4-bk/mm/memory.c	2005-02-21 11:32:19.000000000 +0000
+++ linux/mm/memory.c	2005-02-23 19:46:40.000000000 +0000
@@ -328,21 +328,33 @@ static int copy_pte_range(struct mm_stru
 	pte_t *s, *d;
 	unsigned long vm_flags = vma->vm_flags;
 
+again:
 	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
 	if (!dst_pte)
 		return -ENOMEM;
 
 	spin_lock(&src_mm->page_table_lock);
 	s = src_pte = pte_offset_map_nested(src_pmd, addr);
-	for (; addr < end; addr += PAGE_SIZE, s++, d++) {
-		if (pte_none(*s))
-			continue;
-		copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
+	for (; addr < end; s++, d++) {
+		if (!pte_none(*s))
+			copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
+		addr += PAGE_SIZE;
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
 
