Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUGBLGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUGBLGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGBLEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:04:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50135 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261763AbUGBLBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 07:01:19 -0400
Date: Fri, 2 Jul 2004 13:02:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, "E. Gryaznova" <grev@namesys.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [patch] flexible-mmap-update.patch, 2.6.7-mm5
Message-ID: <20040702110209.GA30813@elte.hu>
References: <20040630114157.59258adf.akpm@osdl.org> <Pine.LNX.4.44.0406302049500.21421-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406302049500.21421-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Hugh Dickins <hugh@veritas.com> wrote:

> I think it's wrong to interpret a large or rlim_infinite stack rlimit
> as an inviolable request to reserve that much for the stack: it makes
> much less VM available than bottom up, not what was intended.  Perhaps
> top down should go bottom up (instead of belly up) when it fails - but
> I'd probably better leave that to Ingo.

Agreed. the attached flexible-mmap-update.patch (against 2.6.7-mm5)
implements the following changes:

- fall back to the bottom-up layout if the stack can grow unlimited
  (if the stack ulimit has been set to RLIM_INFINITY)

- try the bottom-up allocator if the top-down allocator fails - this can
  utilize the hole between the true bottom of the stack and its ulimit,
  as a last-resort effort.

i've tested a number of failure scenarios with various ulimits and mmap
sizes, and we now successfully allocate a VM area in all cases i tested.

	Ingo

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="flexible-mmap-update.patch"


- fall back to the bottom-up layout if the stack can grow unlimited
  (if the stack ulimit has been set to RLIM_INFINITY)

- try the bottom-up allocator if the top-down allocator fails - this can
  utilize the hole between the true bottom of the stack and its ulimit,
  as a last-resort effort.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/mmap.c.orig	
+++ linux/arch/i386/mm/mmap.c	
@@ -55,9 +55,10 @@ void arch_pick_mmap_layout(struct mm_str
 {
 	/*
 	 * Fall back to the standard layout if the personality
-	 * bit is set:
+	 * bit is set, or if the expected stack growth is unlimited:
 	 */
-	if (current->personality & ADDR_COMPAT_LAYOUT) {
+	if ((current->personality & ADDR_COMPAT_LAYOUT) ||
+			current->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY) {
 		mm->mmap_base = TASK_UNMAPPED_BASE;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 		mm->unmap_area = arch_unmap_area;
--- linux/mm/mmap.c.orig	
+++ linux/mm/mmap.c	
@@ -1074,13 +1074,13 @@ void arch_unmap_area(struct vm_area_stru
  * stack's low limit (the base):
  */
 unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
-			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags)
+arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
 {
 	struct vm_area_struct *vma, *prev_vma;
 	struct mm_struct *mm = current->mm;
-	unsigned long base = mm->mmap_base;
+	unsigned long base = mm->mmap_base, addr = addr0;
 	int first_time = 1;
 
 	/* requested length too big for entire address space */
@@ -1142,7 +1142,20 @@ fail:
 		first_time = 0;
 		goto try_again;
 	}
-	return -ENOMEM;
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
+	/*
+	 * Restore the topdown base:
+	 */
+	mm->free_area_cache = base;
+
+	return addr;
 }
 
 void arch_unmap_area_topdown(struct vm_area_struct *area)

--azLHFNyN32YCQGCU--
