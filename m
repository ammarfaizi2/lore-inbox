Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbTIDSAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbTIDSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:00:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:46476 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265383AbTIDSAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:00:08 -0400
Date: Thu, 4 Sep 2003 18:59:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030904175939.GD30394@mail.jlokier.co.uk>
References: <20030903144045.GC21530@mail.jlokier.co.uk> <Pine.LNX.4.44.0309041644450.3962-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309041644450.3962-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> In sys_remap_file_pages, you set the VM_NONLINEAR flag, then clear
> it if this particular population matches the vma.  No, you cannot
> clear that flag once set, without checking every page and pte_file
> already set within the vma.  Check if population matches vma first,
> and if it doesn't match just set the VM_NONLINEAR flag in that case.
> (Andrew already mentioned locking: I'd have said page_table_lock,
> but his mmap_sem is also appropriate: it's an odd case.)

I don't see why you can't clear the flag: the call to ->populate will
change every page and pte_file to correspond with the linear page
offsets, which is all that !VM_NONLINEAR indicates.

However, it _is_ wrong to clear VM_NONLINEAR before the call to
->populate() has finished, with Andrew's patch which uses
downgrade_write().  Instead, the clear must come after ->populate()
has finished.

> I think rip out the FIXADDR_USER_START bit, it's rather over-the-top,
> ugly: and that area is readonly, so not a useful place for a futex.

Agreed.  I put it because the old futex has it as a side effect of
get_user_pages().  It can go.

> The units of keys[1]: bytes if private but pages if shared.
> That's okay for now I think, but if a hashing expert comes along
> later s/he'll probably want to change it.  The current hash does
> add key1 to offset, which is okay: if it xor'ed you'd lose the
> the offset bits in the private case.

Feel free to think up a better hash that isn't slow.  Two iterations
of hash_long() would be a good hash, but slower.

> Those keys[1] pages: in units of PAGE_SIZE in the linear case,
> of PAGE_CACHE_SIZE in the nonlinear case.  Oh well, this is far
> from the only place with such an inconsistency, let's worry
> about that when never comes.

Ew.

> The err at the end of __get_page_keys would be 1 from successful
> get_user_pages, treated as error by the callers: need to make it 0.

Well spotted.

> futex_wait: I didn't get around to it in my version, so haven't
> thought through the issues, but I'm a bit worried that you get
> curval for -EWOULDBLOCK check without holding the futex_lock.
> That looks suspicious to me, but I'm going to be lazy and not
> try to think about it, because Rusty is sure to understand the
> races there.  If that code is insufficient as you have it, may
> need __pin_page reinstated for just that case (hmm, was that
> get_user right before? I'd expect it to kmap_atomic pinned page.)

The important things are that the futex is queued prior to checking
curval, the requested page won't change (it's protected by mmap_sem),
and any parallel waker changes the word prior to waking us.

You made me notice a rather subtle memory ordering condition, though.

We must issue the read after queuing the futex.  There needs to be a
smp_rmb() after queuing and before the read, because the spin_unlock()
barrier only constrains earlier reads, not later ones.

Thanks for all your great insights,
-- Jamie
