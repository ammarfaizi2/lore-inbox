Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUDDB4A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 20:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUDDB4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 20:56:00 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33995
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262106AbUDDBz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 20:55:58 -0500
Date: Sun, 4 Apr 2004 03:55:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging [Re:    2.6.5-rc2-aa vma merging]
Message-ID: <20040404015559.GU2307@dualathlon.random>
References: <20040403184639.GN2307@dualathlon.random> <Pine.LNX.4.44.0404031954250.10509-100000@localhost.localdomain> <20040404010147.GS2307@dualathlon.random> <20040403171358.5dec3987.akpm@osdl.org> <20040404013245.GT2307@dualathlon.random> <20040403174312.16e4537d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403174312.16e4537d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 05:43:12PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Sat, Apr 03, 2004 at 05:13:58PM -0800, Andrew Morton wrote:
> > > That change was made for scheduling latency reasons, mainly due to huge
> > > pagetable walks in zap_page_range():
> > > 
> > >     i_shared_lock is held for a very long time during vmtruncate() and
> > >     causes high scheduling latencies when truncating a file which is
> > >     mmapped.  I've seen 100 milliseconds.
> > > 
> > >     So turn it into a semaphore.  It nests inside mmap_sem.  This
> > >     change is also needed by the shared pagetable patch, which needs to
> > >     unshare pte's on the vmtruncate path - lots of pagetable pages need to
> > >     be allocated and they are using __GFP_WAIT.
> > > 
> > > If we no longer hold that lock during pte takedown then sure, it would
> > > be better if we had a spinlock in there.
> > 
> > agreed, vmtruncate may still be very costly due the pte scan, so
> > I was probably wrong about not needing the semaphore anymore with
> > prio-tree (I was too objrmap centric, and after all objrmap with the
> > trylocks threats it like a spinlock anyways), though the semaphore
> > cannot help the latency of the non-contention case (I mean with preempt
> > disabled), that seem to have room for improvements with a cond_sched()
> > before returning from invalidate_mmap_range_list not present yet.
> 
> <looks>

ok so it's implemented already, actually w/o prio-tree you'd waste some
cpu w/o schedule points if all vmas are out of range, with prio-tree
that's fixed.

> 
> Actually I was a bit harsh to the !CONFIG_PREEMPT case in unmap_vmas():
> 
> /* No preempt: go for the best straight-line efficiency */
> #if !defined(CONFIG_PREEMPT)
> #define ZAP_BLOCK_SIZE	(~(0UL))
> #endif
> 
> We should probably make that 1024*PAGE_SIZE or something like that.

agreed, more specifically we shouldn't differentiate the preempt from
non-preempt case, I'd suggest removing those CONFIG_PREEMPT there, it's
a misconception to think people disabling preempt cares about worst case
latencies less than people enabling preempt, infact the people disabling
preempt _only_ cares about the worst case latency ;)
