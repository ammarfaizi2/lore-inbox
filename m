Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbTIHRbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIHRbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:31:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54534 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263097AbTIHRba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:31:30 -0400
Date: Mon, 8 Sep 2003 18:33:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes 
In-Reply-To: <20030908102309.0AC4E2C013@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0309081746180.7008-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Rusty Russell wrote:
> OK, I've updated my patch on top of this.  Mainly cosmetic, please
> review.
> 
> Name: Minor Tweaks To Jamie Lokier's Futex Patch
> Author: Rusty Russell
> Status: Booted on 2.6.0-test4-bk9
> Depends: Misc/futex-hugh.patch.gz
> 
> D: Minor changes to Jamie's excellent futex patch.
> D: 1) Remove obsolete comment above hash array decl.
> D: 2) Semantics of futex on read-only pages unclear: require write perm.
> D: 3) Clarify comment about TASK_INTERRUPTIBLE.
> D: 4) Andrew Morton says spurious wakeup is a bug.  Catch it.
> D: 5) Use Jenkins hash.

Most of it (the futex_wait tweaks) looked fine to me -
though I look forward to the first report of that BUG().

Part 2, requiring VM_WRITE and removing the comment on VM_MAYSHARE,
seems a regression to me.  Perhaps I misinterpreted Linus' action in
taking Jamie's patch: I took that to mean he relented a little on his
hardline position about VM_SHARED, and now accepts that in this context
VM_MAYSHARE is more appropriate (easier to document).  I know I argued
that readonly futices are pointless, but I thought Jamie gave a good
picture of how a readonly view could still be used.  I'd rather that
part were a separate patch, so Linus can merge or not as he wishes.

In part 5, the Jenkins hashing, I was puzzled by the "/4" in
+			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,

both.ptr would be a multiple of 32 (? seems to be that way on PIII
and P4, though I gave up trying to work out quite how slab.c aligns),
and both.word would be a multiple of 1 in the shared.pgoff case, or
a multiple of PAGE_SIZE in the private.uaddr case (private.uaddr =
uaddr >> PAGE_SHIFT might make more sense).  Whereas both.offset
would be a multiple of 4.  I don't suppose Mr Jenkins will mind,
but I did find the "/4" puzzling in that context.

Hugh

