Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVJYCpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVJYCpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 22:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbVJYCpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 22:45:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:1719 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751417AbVJYCpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 22:45:33 -0400
Date: Mon, 24 Oct 2005 22:45:04 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
In-reply-to: <20051022170240.GA10631@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
 <20051022170240.GA10631@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2005, Russell King wrote:

> On Sat, Oct 22, 2005 at 05:22:20PM +0100, Hugh Dickins wrote:
> > Signal handling's preserve and restore of iwmmxt context currently
> > involves reading and writing that context to and from user space, while
> > holding page_table_lock to secure the user page(s) against kswapd.  If
> > we split the lock, then the structure might span two pages, secured by
> > different locks.  That would be manageable; but it seems simpler just
> > to read into and write from a kernel stack buffer, copying that out and
> > in without locking (the structure is 160 bytes in size, and here we're
> > near the top of the kernel stack).  Or would the overhead be noticeable?
> 
> Please contact Nicolas Pitre about that - that was my suggestion,
> but ISTR apparantly the overhead is too high.

Going through a kernel buffer will simply double the overhead.  Let's 
suppose it should not be a big enough issue to stop the patch from being 
merged though (and it looks cleaner that way). However I'd like for the 
WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user 
buffers should be 64-bit aligned.

> > arm_syscall's cmpxchg emulation use pte_offset_map_lock, instead of
> > pte_offset_map and mm-wide page_table_lock; and strictly, it should now
> > also take mmap_sem before descending to pmd, to guard against another
> > thread munmapping, and the page table pulled out beneath this thread.
> 
> Now that I look at it, it's probably buggy - if the page isn't already
> dirty, it will modify without the COW action.  Again, please contact
> Nicolas about this.

I don't see how standard COW could not happen.  The only difference with 
a true write fault as if we used put_user() is that we bypassed the data 
abort vector and the code to get the FAR value.  Or am I missing 
something?


Nicolas
