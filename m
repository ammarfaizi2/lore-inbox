Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUKRUAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUKRUAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKRTyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:54:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:27582 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262957AbUKRTxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:53:30 -0500
Date: Thu, 18 Nov 2004 19:52:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>,
       "David S. Miller" <davem@davemloft.net>,
       Terence Ripperda <tripperda@nvidia.com>,
       William Irwin <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: loops in get_user_pages() for VM_IO
In-Reply-To: <Pine.LNX.4.44.0411171841190.1767-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0411181943110.4027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Hugh Dickins wrote:
> 
> I love the void make_pages_present(): at present it returns 0,
> error code or -1 - was that really supposed to mean -EPERM?
> What happens if someone tries to make_pages_present() more than
> is physically available?  I think get_user_pages() returns -ENOMEM,
> the intervening levels ignore that, the process then gets OOM-killed.
> If that's acceptable, then I'd think just go with the simple patch,
> void make_pages_present(), for 2.6.10.

Well, no.  wli specifically added mlock's check for get_user_pages
error in 2.6.0-test6; and I'd be reluctant to hide the -EFAULT from
trying to lock down pages beyond end of file.  So here's the fairly
minimal patch I now suggest for 2.6.10....


Whereas get_user_pages simply fails (or stops early) on a VM_IO area
when filling a page vector, it currently proceeds to the follow_page/
handle_mm_fault loop when not passed a vector (by make_pages_present):
which may loop forever with follow_page failing on out-of-range pfn
and handle_mm_fault succeeding on pte already present.

This would already have been a problem for mlock, but I've made it worse
in 2.4.10-rc by updating vm_flags from driver's vma->vm_flags at the end
of do_mmap_pgoff (to avoid possible vma mismerge): if the driver sets
VM_LOCKED|VM_IO (not a recommended combination, but still done), then
make_pages_present is now called and a hang results.

We've removed VM_LOCKED from some of the drivers in question.  But it's
surely unacceptable for an mlockall to hang or fail just because there
happens to be a VM_IO area somewhere in the address space.

We can argue whether VM_IO areas should be counted in locked_vm, but
go with a minimal fix for now: get_user_pages fail or stop on VM_IO
whether or not it's filling a page vector; but mlock_fixup (the only
place which checks for error from make_pages_present) skip VM_IO.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-bk3/mm/memory.c	2004-11-17 14:47:01.000000000 +0000
+++ linux/mm/memory.c	2004-11-18 18:00:04.204306016 +0000
@@ -761,7 +761,7 @@ int get_user_pages(struct task_struct *t
 			continue;
 		}
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
+		if (!vma || (vma->vm_flags & VM_IO)
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
--- 2.6.10-bk3/mm/mlock.c	2004-11-15 16:21:24.000000000 +0000
+++ linux/mm/mlock.c	2004-11-18 18:12:03.688927728 +0000
@@ -47,7 +47,8 @@ static int mlock_fixup(struct vm_area_st
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
 		pages = -pages;
-		ret = make_pages_present(start, end);
+		if (!(newflags & VM_IO))
+			ret = make_pages_present(start, end);
 	}
 
 	vma->vm_mm->locked_vm -= pages;

