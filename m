Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262182AbSJJUAj>; Thu, 10 Oct 2002 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSJJUAi>; Thu, 10 Oct 2002 16:00:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47627 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262182AbSJJT6c>; Thu, 10 Oct 2002 15:58:32 -0400
Date: Thu, 10 Oct 2002 21:05:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Sampsa Ranta <sampsa@netsonic.fi>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with?2.5.40
In-Reply-To: <20021010194950.GU10722@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0210102102190.9566-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2002, William Lee Irwin III wrote:
> On Thu, Oct 10, 2002 at 10:46:02PM +0300, Sampsa Ranta wrote:
> > Call Trace:
> >  [<c013897f>]change_protection+0x1af/0x200
> >  [<c0138af3>]mprotect_attempt_merge+0x123/0x1e0
> >  [<c0138d3d>]mprotect_fixup+0x18d/0x1b0
> >  [<c0138ec4>]sys_mprotect+0x164/0x2f3
> >  [<c014d541>]sys_write+0x31/0x40
> >  [<c010786f>]syscall_call+0x7/0xb
> > Code: 23 53 7c 39 58 60 75 38 8b 40 5c 85 c0 74 08 0f 20 d8 0f 22
> >  <6>note: java[11999] exited with preempt_count 2
> 
> Fixed by Hugh in:
> 
> ChangeSet@1.750, 2002-10-10 11:03:56-07:00, akpm@digeo.com
>   [PATCH] mremap use-after-free bugfix

Actually no: similar, but this one was fixed by Hugh in 2.5.41:

--- 2.5.40/mm/mprotect.c	Fri Sep 27 23:56:45 2002
+++ 2.5.41/mm/mprotect.c	Mon Oct  7 20:37:50 2002
@@ -186,8 +186,10 @@
 		/*
 		 * Try to merge with the previous vma.
 		 */
-		if (mprotect_attempt_merge(vma, *pprev, end, newflags))
+		if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
+			vma = *pprev;
 			goto success;
+		}
 	} else {
 		error = split_vma(mm, vma, start, 1);
 		if (error)

