Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTICLSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTICLSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:18:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40452 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261891AbTICLSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:18:10 -0400
Date: Wed, 3 Sep 2003 12:19:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <20030903073628.GA19920@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309031141310.1273-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Jamie Lokier wrote:
> 
> You will be please to know I have written a complete patch :)

Me too, well, mine wasn't quite complete yet, so I'll switch to
reviewing yours later instead.  I've not glanced at it so far, but
what you've said about it leaves no doubt that you got my point.

> That way, there is no need to walk the page table at all unless it's a
> non-linear mapping (which my patch does handle).

Gosh, I thought it was just a bit of one-up-man-ship from Andrew,
futex on non-linear!  I doubt anyone really cares about that case.

> Good question.  No kernel code seems to check VM_MAYSHARE - the one to
> check is VM_SHARED.

No, it should be VM_MAYSHARE (if the behaviour is to depend on
whether user said MAP_SHARED or not: which is a good starting point,
but if odd readonly compatibility issues force us away from that
position, perhaps VM_MAYSHARE won't in the end be the right test).

I agree it's peculiar, I agree (search LKML archives for VM_MAYSHARE)
that again and again I'm having to make the distinction (I can't pretend
to explain it, just indicate it), which strongly suggests it should be
done better.  But that's some other patch, some other time,
for now use VM_MAYSHARE.

Observe fs/procfs/task_mmu.c show_map checking VM_MAYSHARE for 's'.
Observe mm/mmap.c do_mmap_pgoff vm_flags &= ~(VM_MAYWRITE | VM_SHARED).
VM_MAYSHARE reflects whether user chose MAP_SHARED, VM_SHARED may not.

> I added a flag VM_NONLINEAR to distinguish them.

Yes, I had that flag removed while it served no purpose,
but I'm happy to have it back once it's useful for efficiency.

> I have an obvious fix for mremap(): rehash all the futexes in its
> range.  That's not in the attached patch, but it will be in the next one.

Will it be worth the code added to handle it?  I wonder the same of
non-linear (sys_mremap and sys_remap_file_pages, familiar troublemakers).
But all credit for handling them, good to reduce "undefined behaviour"s.

Hugh

