Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUBBNex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 08:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUBBNex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 08:34:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5584 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265275AbUBBNev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 08:34:51 -0500
Date: Mon, 2 Feb 2004 13:29:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: j-nomura@ce.jp.nec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040202.191242.278747628.nomura@linux.bs1.fc.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0402021326170.16097-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004 j-nomura@ce.jp.nec.com wrote:
> 
> swap_out() seems always trying scan even if there are no swap space available.
> This keeps CPU(s) busy with rare successful page-out and may cause lock
> contention in big smp system.
>... 
> How about checking nr_swap_pages first and giving up if it's 0?

Sorry, no.  Don't be misled by the name, swap_out() is used to free
all kinds of mapped pages, not just those which would end up on swap.
Your patch just disables freeing mapped pages under memory pressure.

You could try the untested patch below to swap_out_vma(), but I don't
really recommend it: it still skips freeing up a less common category
of clean pages, just when you'd most like to free them.

Hugh

--- 2.4.25-pre8/mm/vmscan.c	2004-01-30 13:41:14.000000000 +0000
+++ linux/mm/vmscan.c	2004-02-02 13:01:28.067918544 +0000
@@ -263,6 +263,14 @@
 	if (vma->vm_flags & VM_RESERVED)
 		return count;
 
+	/* If no swap, don't waste time on areas which need it */
+	if (nr_swap_pages <= 0) {
+		if (!vma->vm_ops ||
+		    !vma->vm_ops->nopage ||
+		    vma->vm_ops->nopage == shmem_nopage)
+			return count;
+	}
+
 	pgdir = pgd_offset(mm, address);
 
 	end = vma->vm_end;

