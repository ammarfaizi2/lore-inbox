Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbSJARKV>; Tue, 1 Oct 2002 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJARIy>; Tue, 1 Oct 2002 13:08:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32991 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262244AbSJARHu>; Tue, 1 Oct 2002 13:07:50 -0400
Date: Tue, 1 Oct 2002 18:14:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 
In-Reply-To: <35FD2132190@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0210011804001.1783-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Petr Vandrovec wrote:
> 
> You are my hero!

Aww, shucks!  I guess I'd better have a go at your next problem...

> Unfortunately it did not fixed another problem I have with sys_mprotect.
> If I start X, system stops to do anything useful. After SAK I could
> do remote connect and running 'w' and 'ps axf' moved them to 'D' state.

> Oct  1 17:47:55 vana kernel:  [<c0107ec9>]error_code+0x2d/0x38
> Oct  1 17:47:55 vana kernel:  [<c011216f>]flush_tlb_mm+0x1b/0x70
> Oct  1 17:47:55 vana kernel:  [<c0133ed1>]change_protection+0x1a1/0x1dc
> Oct  1 17:47:55 vana kernel:  [<c01341ed>]mprotect_fixup+0x16d/0x188

Looks to me like flush_tlb_mm is faulting on the vma->vm_mm given it.
And looks to me like mprotect_fixup, in the merge case, may be passing
an already freed vma to change_protection.  I'm not as confident about
this patch as the earlier one, but I believe it's correct: please
give it a try, and maybe Christoph will confirm or deny it.

Hugh

--- 2.5.40/mm/mprotect.c	Fri Sep 27 23:56:45 2002
+++ linux/mm/mprotect.c	Tue Oct  1 18:00:31 2002
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

