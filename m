Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSGYU2B>; Thu, 25 Jul 2002 16:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSGYU2A>; Thu, 25 Jul 2002 16:28:00 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20120 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S316322AbSGYU16>; Thu, 25 Jul 2002 16:27:58 -0400
Date: Thu, 25 Jul 2002 21:31:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM accounting 1/3 trivial
In-Reply-To: <1027560714.6456.43.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0207252037160.1669-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 2002, Alan Cox wrote:
> On Wed, 2002-07-24 at 15:48, Hugh Dickins wrote:
> > Thank you, it is surely incorrect (in the case where the do_munmap does
> > not cover the whole vma, leaving one or two pieces behind: I think that
> > must be the case you're remembering).  Would a patch which (if necessary)
> > reapplies VM_ACCOUNT to the leftover piece(s) be welcome, or would it
> > just look like an ugly face-saving exercise?
> 
> I went around this about five times before changing do_munmap having
> failed dismally on each case. I wouldnt worry about face saving, I made
> the same mistake and spent a couple of days debugging it.

Sounds like we're both keen to do without the extra argument.
Trial patch below (against rc3-ac3, do_munmap still with extra arg,
but set 1 as elsewhere) looks right to me and tests right for me.
Reasonable, or just too anxious to avoid the arg, or wrong again?
- or, you've got a lot better things to do than revisit this!

> > But I'll still have a consistency problem with MAP_NORESERVE versus
> > sysctl_overcommit_memory, when the latter is changed (> 1 or <= 1).
> 
> Its very simple. If you have said "no overcommit" you cannot allow
> anyone to violate the rule because any reservation could cause someone
> who didnt NORESERVE to get killed off.

We're in full agreement about the system brought up in no-overcommit
mode (or switched into no-overcommit mode before any MAP_NORESERVEs can
be made), and left in no-overcommit mode.  But as things stand, the system
can be brought up in overcommit mode, large MAP_NORESERVEs made, then the
system switched to no-overcommit; or switched (by root) into overcommit
to make a MAP_NORESERVE and then switched back.

You have no protection against the earlier NORESERVEs, and I'm unclear
whether or not you want that additional protection: it's a little like
"Tainted", you won't want people raising bugs against no-overcommit when
in fact they've been switching around.  We could (but it's an extra arg
to vm_enough_memory and vm_unacct_memory, which of course I'd prefer not)
tally even the MAP_NORESERVEs, adding them also into vm_committed_space
while no-overcommit, leaving them out while overcommit (and probably
tiresome locking issues for the transition).  I think it's not worth
that effort; in which case, it doesn't much matter how we treat any
existing MAP_NORESERVEs while in no-overcommit mode, since we're
really assuming there are none.

> Secondly on my test runs, no process on a standard distro seems to use
> NORESERVE anyway 8)

I am glad to hear that!

Hugh

--- 2.4.19-rc3-ac3/mm/mremap.c	Tue Jul 23 16:47:21 2002
+++ vmacct/mm/mremap.c	Thu Jul 25 20:17:05 2002
@@ -152,7 +152,7 @@
 	struct mm_struct * mm = vma->vm_mm;
 	struct vm_area_struct * new_vma, * next, * prev;
 	int allocated_vma;
-
+	int split = 0;
 
 	new_vma = NULL;
 	next = find_vma_prev(mm, new_addr, &prev);
@@ -213,8 +213,26 @@
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
-		/* The old VMA has been accounted for, don't double account */
-		do_munmap(current->mm, addr, old_len, 0);
+
+		/* Conceal VM_ACCOUNT so old reservation is not undone */
+		if (vma->vm_flags & VM_ACCOUNT) {
+			vma->vm_flags &= ~VM_ACCOUNT;
+			if (addr > vma->vm_start) {
+				if (addr + old_len < vma->vm_end)
+					split = 1;
+			} else if (addr + old_len == vma->vm_end)
+				vma = NULL;	/* it will be removed */
+		} else
+			vma = NULL;		/* nothing more to do */
+
+		do_munmap(current->mm, addr, old_len, 1);
+
+		/* Restore VM_ACCOUNT if one or two pieces of vma left */
+		if (vma) {
+			vma->vm_flags |= VM_ACCOUNT;
+			if (split)
+				vma->vm_next->vm_flags |= VM_ACCOUNT;
+		}
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
 		if (new_vma->vm_flags & VM_LOCKED) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;

