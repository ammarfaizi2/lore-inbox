Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUDDFXC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 00:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUDDFXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 00:23:02 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9861
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262175AbUDDFW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 00:22:58 -0500
Date: Sun, 4 Apr 2004 07:22:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-aa1
Message-ID: <20040404052256.GA2164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a tiny race in the recent mprotect merging code, here's the
intradiff for review, plus it merges some nice lowlatency improvement
from Takashi.

--- x/mm/mprotect.c.~1~	2004-04-04 06:26:09.226033712 +0200
+++ x/mm/mprotect.c	2004-04-04 06:29:37.165422120 +0200
@@ -196,12 +196,18 @@ mprotect_attempt_merge(struct vm_area_st
 
 	/*
 	 * Otherwise extend it.
+	 * We need the anon_vma_lock only for "vma" since it's changing
+	 * vma->vm_start and vma->vm_pgoff. prev->vm_start and
+	 * prev->vm_pgoff are unchanged so the race on prev->vm_end
+	 * is controlled w/o explicit anon-vma locking.
 	 */
 	if (file)
 		down(i_shared_sem);
+	anon_vma_lock(vma);
 	__vma_modify(root, prev, prev->vm_start, end, prev->vm_pgoff);
 	__vma_modify(root, vma, end, vma->vm_end,
 		     vma->vm_pgoff + ((end - vma->vm_start) >> PAGE_SHIFT));
+	anon_vma_unlock(vma);
 	if (file)
 		up(i_shared_sem);
 	return 1;
@@ -264,6 +270,7 @@ mprotect_attempt_merge_final(struct vm_a
 
 	if (file)
 		down(i_shared_sem);
+	/* no need of anon_vma_lock for any "vm_end" extension */
 	__vma_modify(root, prev, prev->vm_start,
 		     next->vm_end, prev->vm_pgoff);
 

I didn't yet merge the ppc patch because I'm not really sure it's
necessary (how can it not oops in the first place, if that patch was
needed? OTOH certainly that patch cannot hurt either but I'll wait
feedback from the testing first).  The only pending bug at the moment is
the gfp-no-compound related crash from Christoph on ppc showing
page->private corrupted. I currently doubt it's a bug in my changes,
though I cannot exclude it either. As soon as I get the results from the
three debugging patches I will know more about it. I definitely cannot
reproduce anything wrong here, and the gfp-no-compound fixed the last
swap-suspend related glitch plus it makes the interface with the drivers
more robust.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-aa1/

Changelog diff between 2.6.5-rc3-aa3 and 2.6.5-aa1:

Files 2.6.5-rc3-aa3/disable-cap-mlock and 2.6.5-aa1/disable-cap-mlock differ
Files 2.6.5-rc3-aa3/extraversion and 2.6.5-aa1/extraversion differ
Files 2.6.5-rc3-aa3/prio-tree.gz and 2.6.5-aa1/prio-tree.gz differ

	Rediffed due rejects.

Files 2.6.5-rc3-aa3/mprotect-vma-merging and 2.6.5-aa1/mprotect-vma-merging differ

	Fixed race condition in mprotect, must hold the anon_vma_lock()
	while moving either ->vm_start or ->vm_pgoff (extending the vm_end
	doesn't need it instead since the race is controlled w/o explicit
	locking).

Only in 2.6.5-aa1: unmap_vmas-lat

	Don't threat no-preempt differently from -preempt w.r.t. worst case
	latencies.

Only in 2.6.5-aa1: writeback-lat

	Merged Takashi Iwai's lowlatency fixes adding missing schedule points,
	reducing greatly the worst case latency with preempt disabled.
