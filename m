Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbTIBTzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTIBTzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 15:55:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:46986 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261333AbTIBTzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 15:55:07 -0400
Date: Tue, 2 Sep 2003 20:54:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030902195427.GA15262@mail.jlokier.co.uk>
References: <20030902065144.GC7619@mail.jlokier.co.uk> <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> > 	1. process A forks, making process B
> > 	2. B does FUTEX_FD, or splits into threads and one does FUTEX_WAIT,
> > 	   on a private page that has not been written to since the fork
> > 	3. A does FUTEX_WAIT on the same address
> > 	3. The page is swapped out
> > 	4. B does FUTEX_WAKE at the same address
> > 
> > Won't the futex be hashed on the swap entry at step 4, so that
> > both processes are woken, yet only the waiter in B should be woken?
> 
> I don't see that step 3 (the second!) makes any difference:
> it behaves like that whether or not the page is swapped out, doesn't it?

You're right.

I had assumed that the reformed futex keyed on (mapping, offset) for
shared pages and (mm, page) for private anonymous pages.  But I see it
only keys on (page) in the latter case.

Now I see that it _ought_ to key on (mapping, index, offset) for
shared mappings, (mm, uaddr) for private mappings.

> I agree with you that behaviour seems wrong for a private anonymous page.
> And we'd agree it's right behaviour for a shared file page.

Yes.

> The case of a MAP_PRIVATE or !PROT_WRITE file page may be harder to
> decide, but I'm inclined to follow you and say distinction should
> depend on MAP_SHARED (shm included as MAP_SHARED mapping of unnamed
> shmem object).

Yes, absolutely.

> I know nothing of the user/glibc end of futexes, perhaps it makes
> your case academic.  But I'd still like a consistent definition
> for how sys_futex should behave.

Futexes are actually a very nice primitive, and used by more than
glibc already.  In particular, they are used inside database files and
similar things.

> I'd been wondering along similar lines (worried by futex on uninstantiated
> anon page, which would end up on the empty zero page), thinking futex.c's
> __pin_page ought to pass write flag set to follow_page and get_user_pages.

Shared read-only mappings should be futexable too.  Also, there is no
need to clone a page at __pin_page() time, because the vcache should
take care of any subsequent COW.  (Also it wouldn't work because the
page can become a COW page after the futex is established, due to a
subsequent fork).

> But now (and I'd like to switch to capitals, but restrain myself) I think
> most of the COW/vcache/callback/swap/page/pinning stuff is just a waste
> of space and time, creating its own problems which it then has to solve.

Not pinning pages fixes a real resource leak problem, and is obviously
the right thing to do - lots of threads queued up on futexes in a
database file, for example, should still be pageable as much as possible.

> When sys_futex passes a uaddr in a VM_MAYSHARE vma, it should be handled
> by mapping/index (or inode/offset).  When sys_futex passes a uaddr in a
> !VM_MAYSHARE vma, it should be handled by mm/uaddr.  (If outside vma?)
> 
> That's it.  Doesn't a whole lot of code and complication fall away?
> The physical page is pretty much irrelevant.
> 
> For a while I thought this would change the behaviour if futex is
> mremapped.  Well, yes, but nobody has remembered to do anything
> about vcache in mremap anyway, so it's already broken.

I have thought it over and I agree.

Keying on (mm,uaddr) instead of (page) does solve the problem of
private mappings and COW.  It also removes the need for the page to be
in memory (a minor bonus, not an important reason).

The vcache is horribly broken with mremap().  If vcache is fixed to
rehash vcache entries on mremap, that could rehash the futexes too.

Rusty, I see that futex.c does a vcache lookup for every wait and wake
at the moment.

That means every wait and wake does two hash lookups at the moment.
We can reduce that to one :)

I think this solves the COW incorrect/spurious wakeups problem _and_
removes page pinning (without mm hooks) _and_ makes futex_rehash _and_
speeds up futex operations.  Credit for the idea goes to Hugh:

	1. Remove all references to struct page from futex.c (!)

	2. Call find_extend_vma instead of get_user_pages,
	   and decide how to look up the futex_q based on
	   (vma & VM_SHARED).

	3. For (vma & VM_SHARED), look up futex_qs keyed on
	   (vma->vm_file, vma->vm_pgoff + (uaddr - vma->vm_start) >>
	   PAGE_SHIFT, offset).

	4. For !(vma & VM_SHARED), look up futex_qs keyed on
	   (mm, uaddr).

Note how pages aren't pinned by this, vcache isn't needed, it is fine
with swapping, and works correctly with COW pages.  tmpfs & shared
memory (all 3 kinds) are also correct: if they are mapped privately,
(mm, uaddr) is a fine key, and if they are mapped shared, (file,
offset) is a correct key at all times whether swapped or not.

mremap does not work with the above, but mremap is broken anyway, as
all futexes use the vcache at present which is broken by mremap.  When
mremap is fixed to rehash a vcache address range, it can be fixed to
rehash a futex address range too.

The more I think about it, the better it looks.  So sure, I am, that I
must have missed something.  What do you think, Rusty?

-- Jamie
