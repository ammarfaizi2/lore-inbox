Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbUCUSSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUCUSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:18:43 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:31096 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263680AbUCUSSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:18:40 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Eli Cohen <mlxk@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com> <52u10i2lx6.fsf@topspin.com>
	<405DCDA1.3080008@colorfullife.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 21 Mar 2004 10:18:38 -0800
In-Reply-To: <405DCDA1.3080008@colorfullife.com>
Message-ID: <52ptb62hdt.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2004 18:18:38.0953 (UTC) FILETIME=[EEBFFD90:01C40F70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Manfred> I think just get_user_pages() should be sufficient: the
    Manfred> pages won't be swapped out. You don't need to set
    Manfred> VM_LOCKED in vma->vm_flags to prevent the swap out. In
    Manfred> the worst case, the pte is cleared a that will cause a
    Manfred> soft page fault, but the physical address won't
    Manfred> change. Multiple get_user_pages() calls on overlapping
    Manfred> regions are ok, the page count is an atomic_t, at least
    Manfred> 24-bit large.

    Roland> There is one case that we ran into where the physical
    Roland> address can change: if a process does a fork() and then
    Roland> triggers COW.

    Manfred> You are right.  What should happen if there are
    Manfred> registered transfers during fork()?  Copy the pages
    Manfred> during the fork() syscall?

The current Mellanox InfiniBand driver goes to some trouble to mark
the memory being registered with VM_DONTCOPY.  This means the vmas
don't get copied into the child of a fork(), so the COW doesn't
happen.  However, this certainly leads to some quirks in semantics.
In particular, an application using fork() has to be careful that
registered memory doesn't share a page with something the child
process wants to use.

I don't think copying all the registered memory on fork() is feasible,
because it's going to kill performance (especially since exec() is
likely to immediately follow the fork() in the child).  Also, there
may not be enough memory around to copy everything.

Out of curiousity, what happens if I fork with pending AIO in the
current kernel?

 - Roland

