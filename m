Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUHXRFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUHXRFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268125AbUHXRFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:05:55 -0400
Received: from holomorphy.com ([207.189.100.168]:34692 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266680AbUHXRFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:05:53 -0400
Date: Tue, 24 Aug 2004 10:05:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: fix text reporting in O(1) proc_pid_statm()
Message-ID: <20040824170547.GP2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040823202158.GJ4418@holomorphy.com> <20040823231454.62734afb.akpm@osdl.org> <20040824075539.GA2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824075539.GA2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 12:55:39AM -0700, William Lee Irwin III wrote:
> Merely removing down_read(&mm->mmap_sem) from task_vsize() is too
> half-assed to let stand. The following patch removes the vma iteration
> as well as the down_read(&mm->mmap_sem) from both task_mem() and
> task_statm() and callers for the CONFIG_MMU=y case in favor of
> accounting the various stats reported at the times of vma creation,
> destruction, and modification. Unlike the 2.4.x patches of the same
> name, this has no per-pte-modification overhead whatsoever.
> This patch quashes end user complaints of top(1) being slow as well as
> kernel hacker complaints of per-pte accounting overhead simultaneously.
> Incremental atop the task_vsize() de-mmap_sem-ification of 2.6.8.1-mm4:

Some kind of brainfart happened here, though it's not visible on the
default display from top(1) etc. This patch fixes up the gibberish I
mistakenly put down for text with the proper text size, and subtracts
it from data as per the O(vmas) code beforehand.


Index: mm4-2.6.8.1/fs/proc/task_mmu.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/task_mmu.c	2004-08-23 18:29:33.000000000 -0700
+++ mm4-2.6.8.1/fs/proc/task_mmu.c	2004-08-24 10:00:21.530755896 -0700
@@ -36,8 +36,8 @@
 	       int *data, int *resident)
 {
 	*shared = mm->shared_vm;
-	*text = mm->exec_vm - ((mm->end_code - mm->start_code) >> PAGE_SHIFT);
-	*data = mm->total_vm - mm->shared_vm;
+	*text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
+	*data = mm->total_vm - mm->shared_vm - *text;
 	*resident = mm->rss;
 	return mm->total_vm;
 }
