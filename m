Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVCVQnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVCVQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCVQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:43:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13067 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261422AbVCVQnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:43:11 -0500
Date: Tue, 22 Mar 2005 16:37:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050322034053.311b10e6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> 
    <20050322034053.311b10e6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Andrew Morton wrote:
> 
> With these six patches the ppc64 is hitting the BUG in exit_mmap():
> 
>         BUG_ON(mm->nr_ptes);    /* This is just debugging */
> 
> fairly early in boot.

So ppc64 is in the same boat as sparc64 (yet ia64 okay so far).

Sorry, I'm still clueless.

I cannot see those arches doing pte_allocs outside their vmas,
that of course could cause it.  And nr_ptes is initialized to 0
once by memset and again by assignment, so it should be starting
out even zeroer than most fields.

I should probably be paying more attention to the repellent
notion that my code is broken.

If you and David could try the lame patch below,
it'll at least give us a slight clue of where to be looking -
every mm exiting with nr_ptes 1 means something different from
every mm exiting with nr_ptes -1 means something different from
occasional mms exiting with nr_ptes something positive.

I'm not sure whether the patch would ever get to show a more
interesting proc name than "?".

And does memory leak away into lost pagetables if you continue
running, or does it actually carry on running fine, and the
problem appear to be with the BUG_ON itself?

Thanks,
Hugh

--- freepgt6/mm/mmap.c	2005-03-22 04:28:40.000000000 +0000
+++ testing/mm/mmap.c	2005-03-22 15:45:00.000000000 +0000
@@ -1896,6 +1896,7 @@ EXPORT_SYMBOL(do_brk);
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
+	static unsigned long good_mms, bad_mms;
 	struct mmu_gather *tlb;
 	struct vm_area_struct *vma = mm->mmap;
 	unsigned long nr_accounted = 0;
@@ -1931,7 +1932,14 @@ void exit_mmap(struct mm_struct *mm)
 		vma = next;
 	}
 
-	BUG_ON(mm->nr_ptes);	/* This is just debugging */
+	if (mm->nr_ptes && bad_mms < 250) {
+		printk(KERN_ERR "exit_mmap: %s nr_ptes %ld good_mms %lu\n",
+			current->mm == mm? current->comm: "?",
+			(long)mm->nr_ptes, good_mms);
+		good_mms = 0;
+		bad_mms++;
+	} else
+		good_mms++;
 }
 
 /* Insert vm structure into process list sorted by address
