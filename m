Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVBJUU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVBJUU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVBJUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:20:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:51420 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261695AbVBJUU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:20:27 -0500
Date: Thu, 10 Feb 2005 20:19:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
In-Reply-To: <20050210190521.GN18573@opteron.random>
Message-ID: <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> 
    <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> 
    <20050210190521.GN18573@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005, Andrea Arcangeli wrote:
> 
> The reason pinned pages cannot be unmapped is that if they're being
> unmapped while a rawio read is in progress, a cow on some shared
> swapcache under I/O could happen.
> 
> If a try_to_unmap + COW over a shared swapcache happens during a rawio
> read, then the rawio reads will get lost generating data corruption.

Yes, but...

get_user_pages broke COW in advance of the I/O.  The reason for
subsequent COW if the page gets unmapped is precisely because
can_share_swap_page used page_count to judge exclusivity, and
get_user_pages has bumped that up, so the page appears (in danger
of being) non-exclusive when actually it is exclusive.  By changing
can_share_swap_page to use page_mapcount, that frustration vanishes.

(Of course, if the process forks while async I/O is in progress,
these I/O pages could still get COWed, and either parent or child
lose some of the data being read - but behaviour in that case is
anyway undefined, isn't it?  Just so long as kernel doesn't crash.)

> I had not much time to check the patch yet, but it's quite complex and
> could you explain again how do you prevent a cow to happen while the
> rawio is in flight if you don't pin the pte? The PG_locked bitflag
> cannot matter at all because the rawio read won't lock the page. What
> you have to prevent is the pte to be zeroed out, it must be kept
> writeable during the whole I/O. I don't see how you can allow unmapping
> without running into COWs later on.

The page_mapcount+page_swapcount test for exclusivity is simply a
better test for exclusivity than the page_count test.  Since it says
exclusive when the page is exclusive, no COW occurs (and I've just
remembered that we're actually talking of the odd case where the
process itself writes into another portion of the page under I/O,
to get that write fault: but that still works).

page_count does still play a vital role, in ensuring that the page
stays held in the swapcache, cannot actually be reused for something
else while it's unmapped.

> This is the only thing I care to understand really, since it's the only
> case that the pte pinning was fixing.
> 
> Overall I see nothing wrong in preventing memory removal while rawio is
> in flight. rawio cannot be in flight forever (ptrace and core dump as
> well should complete eventually). Why can't you simply drop pages from
> the freelist one by one until all of them are removed from the freelist?

I did ask Toshihiro about that earlier in the thread.  Best look up his
actual reply, but as I understand it, his test is sufficiently thorough
that it's actually doing direct I/Os in parallel, so there's never a
moment when the page is free.  He believes that an unprivileged process
should not be allowed to hold pages indefinitely unmigratable.

I have little appreciation of the hotplug/memmigration issues here.
But whatever the merits of that, I do think the new can_share_swap_page
is an improvement over the old (written in the days before page_mapcount
existed), and that it's preferable to remove the page_count heuristic
from try_to_unmap_one.

Hugh
