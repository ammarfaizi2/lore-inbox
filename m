Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265304AbTIDQni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265308AbTIDQnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:43:37 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42160 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S265304AbTIDQn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:43:28 -0400
Date: Thu, 4 Sep 2003 17:45:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <20030903144045.GC21530@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309041644450.3962-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Jamie Lokier wrote:
> Patch name: futex-nonlinear-2.6.0-test4-02jl
> Depends on: futex-fixes-2.6.0-test4-01jl

I've now read your patches, they look good to me:
I particularly like the way you divided up the locking.

In sys_remap_file_pages, you set the VM_NONLINEAR flag, then clear
it if this particular population matches the vma.  No, you cannot
clear that flag once set, without checking every page and pte_file
already set within the vma.  Check if population matches vma first,
and if it doesn't match just set the VM_NONLINEAR flag in that case.
(Andrew already mentioned locking: I'd have said page_table_lock,
but his mmap_sem is also appropriate: it's an odd case.)

I think rip out the FIXADDR_USER_START bit, it's rather over-the-top,
ugly: and that area is readonly, so not a useful place for a futex.

The units of keys[1]: bytes if private but pages if shared.
That's okay for now I think, but if a hashing expert comes along
later s/he'll probably want to change it.  The current hash does
add key1 to offset, which is okay: if it xor'ed you'd lose the
the offset bits in the private case.

Those keys[1] pages: in units of PAGE_SIZE in the linear case,
of PAGE_CACHE_SIZE in the nonlinear case.  Oh well, this is far
from the only place with such an inconsistency, let's worry
about that when never comes.

The err at the end of __get_page_keys would be 1 from successful
get_user_pages, treated as error by the callers: need to make it 0.

futex_wait: I didn't get around to it in my version, so haven't
thought through the issues, but I'm a bit worried that you get
curval for -EWOULDBLOCK check without holding the futex_lock.
That looks suspicious to me, but I'm going to be lazy and not
try to think about it, because Rusty is sure to understand the
races there.  If that code is insufficient as you have it, may
need __pin_page reinstated for just that case (hmm, was that
get_user right before? I'd expect it to kmap_atomic pinned page.)

Hugh

