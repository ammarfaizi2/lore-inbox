Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268628AbRGZTtR>; Thu, 26 Jul 2001 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268660AbRGZTtH>; Thu, 26 Jul 2001 15:49:07 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:3986 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268628AbRGZTtE>; Thu, 26 Jul 2001 15:49:04 -0400
Date: Thu, 26 Jul 2001 20:50:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Jeremy Linton <jlinton@interactivesi.com>
cc: mingo@elte.hu, Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: highmem-2.4.7-A0 [Re: kmap() while holding spinlock]
In-Reply-To: <00bc01c11600$4c3901a0$bef7020a@mammon>
Message-ID: <Pine.LNX.4.21.0107262012210.1120-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Jeremy Linton wrote:
> > > [...] or to do the clearing (and copying) speculatively, after
> > > allocating the page but before locking the pagetable lock. This might
> > > lead to a bit more work in the pagefault-race case, but we dont care
> > > about that window. It will on the other hand reduce pagetable_lock
> > > contention (because the clearing/copying is done outside the lock), so
> > > perhaps this solution is better.
> >
> > the attached highmem-2.4.7-A0 patch implements this method in both
> > affected functions. Comments?
>     It seems to me that the problem is more fundamental than that. Excuse my
> ignorance, but what keeps the 'old_page' (and associated pte, checked two
> lines down) from disappearing somewhere between the lock drop, alloc page
> and the copy from the old page? Normally if this happens it appears the new
> page gets dropped and the fault occurs again, and is resolved in a
> potentially different way.

I was about to answer this by pointing out that, although the pte may
change and the old_page be reused for some other purpose while we drop
the lock, the old_page won't actually "disappear".  It will remain
physically present, just containing irrelevant data: there won't be
any danger from copying the wrong data, we just notice further down
that the pte changed and discard this copy and fault again (or not).

But in writing, I realize (perhaps it's your very point, understated)
that it's conceivable (though *very* unlikely) that the old_page is
reused for some other purpose while we do the copy, then freed from
that use and reused for its original purpose by the time we regain the
lock: so that the pte_same() test succeeds yet the copied data is wrong.

Either do_wp_page() needs page_cache_get(old_page) before dropping
page_table_lock, page_cache_release(old_page) after reacquiring it;
or the kmap()s done while the lock is dropped, but copy_user_page()
and kunmap()s left until the lock has been reacquired.  Ingo?

Hugh

