Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTIBQMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTIBQMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:12:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58944 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263956AbTIBQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:12:42 -0400
Date: Tue, 2 Sep 2003 17:14:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
In-Reply-To: <20030902065144.GC7619@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003, Jamie Lokier wrote:
> What happens after this sequence:
> 
> 	1. process A forks, making process B
> 	2. B does FUTEX_FD, or splits into threads and one does FUTEX_WAIT,
> 	   on a private page that has not been written to since the fork
> 	3. A does FUTEX_WAIT on the same address
> 	3. The page is swapped out
> 	4. B does FUTEX_WAKE at the same address
> 
> Won't the futex be hashed on the swap entry at step 4, so that
> both processes are woken, yet only the waiter in B should be woken?

I don't see that step 3 (the second!) makes any difference:
it behaves like that whether or not the page is swapped out, doesn't it?

I agree with you that behaviour seems wrong for a private anonymous page.
And we'd agree it's right behaviour for a shared file page.  The case of
a MAP_PRIVATE or !PROT_WRITE file page may be harder to decide, but I'm
inclined to follow you and say distinction should depend on MAP_SHARED
(shm included as MAP_SHARED mapping of unnamed shmem object).

I know nothing of the user/glibc end of futexes, perhaps it makes
your case academic.  But I'd still like a consistent definition
for how sys_futex should behave.

I'd been wondering along similar lines (worried by futex on uninstantiated
anon page, which would end up on the empty zero page), thinking futex.c's
__pin_page ought to pass write flag set to follow_page and get_user_pages.

But now (and I'd like to switch to capitals, but restrain myself) I think
most of the COW/vcache/callback/swap/page/pinning stuff is just a waste
of space and time, creating its own problems which it then has to solve.

When sys_futex passes a uaddr in a VM_MAYSHARE vma, it should be handled
by mapping/index (or inode/offset).  When sys_futex passes a uaddr in a
!VM_MAYSHARE vma, it should be handled by mm/uaddr.  (If outside vma?)

That's it.  Doesn't a whole lot of code and complication fall away?
The physical page is pretty much irrelevant.

For a while I thought this would change the behaviour if futex is
mremapped.  Well, yes, but nobody has remembered to do anything
about vcache in mremap anyway, so it's already broken.

What am I missing?

Hugh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 2 Sep 2003, Jamie Lokier wrote:
> What happens after this sequence:
> 
> 	1. process A forks, making process B
> 	2. B does FUTEX_FD, or splits into threads and one does FUTEX_WAIT,
> 	   on a private page that has not been written to since the fork
> 	3. A does FUTEX_WAIT on the same address
> 	3. The page is swapped out
> 	4. B does FUTEX_WAKE at the same address
> 
> Won't the futex be hashed on the swap entry at step 4, so that
> both processes are woken, yet only the waiter in B should be woken?

I don't see that step 3 (the second!) makes any difference:
it behaves like that whether or not the page is swapped out, doesn't it?

I agree with you that behaviour seems wrong for a private anonymous page.
And we'd agree it's right behaviour for a shared file page.  The case of
a MAP_PRIVATE or !PROT_WRITE file page may be harder to decide, but I'm
inclined to follow you and say distinction should depend on MAP_SHARED
(shm included as MAP_SHARED mapping of unnamed shmem object).

I know nothing of the user/glibc end of futexes, perhaps it makes
your case academic.  But I'd still like a consistent definition
for how sys_futex should behave.

I'd been wondering along similar lines (worried by futex on uninstantiated
anon page, which would end up on the empty zero page), thinking futex.c's
__pin_page ought to pass write flag set to follow_page and get_user_pages.

But now (and I'd like to switch to capitals, but restrain myself) I think
most of the COW/vcache/callback/swap/page/pinning stuff is just a waste
of space and time, creating its own problems which it then has to solve.

When sys_futex passes a uaddr in a VM_MAYSHARE vma, it should be handled
by mapping/index (or inode/offset).  When sys_futex passes a uaddr in a
!VM_MAYSHARE vma, it should be handled by mm/uaddr.  (If outside vma?)

That's it.  Doesn't a whole lot of code and complication fall away?
The physical page is pretty much irrelevant.

For a while I thought this would change the behaviour if futex is
mremapped.  Well, yes, but nobody has remembered to do anything
about vcache in mremap anyway, so it's already broken.

What am I missing?

Hugh

