Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVD0CNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVD0CNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 22:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVD0CNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 22:13:32 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:53573 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261885AbVD0CNZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 22:13:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com>
	<52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org>
	<5264y9s3bs.fsf@topspin.com> <20050426133229.416a5e66.akpm@osdl.org>
	<521x8xs04v.fsf@topspin.com> <20050426170513.33b81f76.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 26 Apr 2005 19:13:24 -0700
In-Reply-To: <20050426170513.33b81f76.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 26 Apr 2005 17:05:13 -0700")
Message-ID: <521x8xq857.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Apr 2005 02:13:24.0312 (UTC) FILETIME=[B0FE9580:01C54ACE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> The kernel can simply register and unregister ranges for
    Andrew> RDMA.  So effectively a particular page is in either the
    Andrew> registered or unregistered state.  Kernel accounting
    Andrew> counts the number of registered pages and compares this
    Andrew> with rlimits.

    Andrew> On top of all that, your userspace library needs to keep
    Andrew> track of when pages should really be registered and
    Andrew> unregistered with the kernel.  Using overlap logic and
    Andrew> per-page refcounting or whatever.

This is OK as long as userspace is trusted.  However I don't see how
this works when we don't trust userspace.  The problem is that for an
RDMA device (IB HCA or iWARP RNIC), a process can create many memory
regions, each of which a separate virtual to physical translation
map.  For example, an app can do:

    a) register 0x0000 through 0xffff and get memory handle 1
    b) register 0x0000 through 0xffff and get memory handle 2
    c) use memory handle 1 for communication with remote app A
    d) use memory handle 2 for communication with remote app B

Even though memory handles 1 and 2 both refer to exactly the same
memory, they may have different lifetimes, might be attached to
different connections, and so on.

Clearly the memory at 0x0000 must stay pinned as long as the RDMA
device thinks either memory handle 1 or memory handle 2 is valid.
Furthermore, the kernel must be the one keeping track of how many
regions refer to a given page because we can't allow userspace to be
able to tell a device to go DMA to memory it doesn't own any more.

Creation and destruction of these memory handles will always go
through the kernel driver, so this isn't so bad.  And get_user_pages()
is almost exactly what we need: it stacks perfectly, since it operates
on the page_count rather than just setting a bit in vm_flags.  The
main problem is that it doesn't check against RLIMIT_MEMLOCK.

The most reasonable thing to do would seem to be having the IB kernel
memory region code update current->mm->locked_vm and check it against
RLIMIT_MEMLOCK.  I guess it would be good to figure out an appropriate
abstraction to export rather than monkeying with current->mm directly.
We could also put this directly in get_user_pages(), but I'd be
worried about messing with current users.

I just don't see a way to make VM_KERNEL_LOCKED work.

It would also be nice to have a way for apps to set VM_DONTCOPY
appropriately.  Christoph's suggestion of extending mmap() and
mprotect() with PROT_DONTCOPY seems good to me, especially since it
means we don't have to export do_mlock() functionality to modules.

 - R.
