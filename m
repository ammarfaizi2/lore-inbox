Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWBGAEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWBGAEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWBGAEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:04:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51866 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964886AbWBGAED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:04:03 -0500
Date: Mon, 6 Feb 2006 16:03:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, agl@us.ibm.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <20060206143022.37d1781e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602061558290.19350@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <20060206131026.53dbd8d5.akpm@osdl.org> <200602062222.28630.ak@suse.de>
 <Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com>
 <20060206143022.37d1781e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andrew Morton wrote:

> The oom-killer is invoked from the page allocator.  A hugetlb pagefault
> won't use the page allocator.  So there shouldn't be an oom-killing on
> hugepage exhaustion.

Right..... and the arch specific fault code (at least ia64) does not call 
the OOM killer.

> I think this comment is just wrong:
> 
> 		/* Logically this is OOM, not a SIGBUS, but an OOM
> 		 * could cause the kernel to go killing other
> 		 * processes which won't help the hugepage situation
> 		 * at all (?) */
> 
> A VM_FAULT_OOM from there won't cause the oom-killer to do anything.  We
> should return VM_FAULT_OOM and let do_page_fault() commit suicide with
> SIGKILL.

Drop my patch that adds the comments explaining the bus error and add this 
fix instead. This will terminate an application with out of memory instead 
of bus error and remove the comment that you mentioned.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/hugetlb.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/hugetlb.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/hugetlb.c	2006-02-06 16:02:53.000000000 -0800
@@ -391,12 +391,7 @@ static int hugetlb_cow(struct mm_struct 
 
 	if (!new_page) {
 		page_cache_release(old_page);
-
-		/* Logically this is OOM, not a SIGBUS, but an OOM
-		 * could cause the kernel to go killing other
-		 * processes which won't help the hugepage situation
-		 * at all (?) */
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_OOM;
 	}
 
 	spin_unlock(&mm->page_table_lock);
@@ -444,6 +439,7 @@ retry:
 		page = alloc_huge_page(vma, address);
 		if (!page) {
 			hugetlb_put_quota(mapping);
+			ret = VM_FAULT_OOM;
 			goto out;
 		}
 
