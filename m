Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272225AbRIPBVj>; Sat, 15 Sep 2001 21:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273136AbRIPBVU>; Sat, 15 Sep 2001 21:21:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:8201 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272225AbRIPBVN>; Sat, 15 Sep 2001 21:21:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>
Subject: Re: Feedback on preemptible kernel patch
Date: Sun, 16 Sep 2001 03:28:37 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Chris Mason <mason@suse.com>
In-Reply-To: <1000581501.32705.46.camel@phantasy>
In-Reply-To: <1000581501.32705.46.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010916012129Z16244-2758+66@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 15, 2001 09:18 pm, Robert Love wrote:
> On Sun, 2001-09-09 at 23:24, Daniel Phillips wrote:
> > This may not be your fault.  It's a GFP_NOFS recursive allocation - this
> > comes either from grow_buffers or ReiserFS, probably the former.  In
> > either case, it means we ran completely out of free pages, even though
> > the caller is willing to wait.  Hmm.  It smells like a loophole in vm
> > scanning.
> 
> Hi, Daniel.  If you remember, a few users of the preemption patch
> reported instability and/or syslog messages such as:
> 
> Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> Sep  9 23:08:02 sjoerd last message repeated 93 times
> Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
> Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> Sep  9 23:08:02 sjoerd last message repeated 281 times
> 
> It now seems that all of them are indeed using ReiserFS.  There are no
> other reported problems with the preemption patch, except from those
> users...
> 
> I am beginning to muse over the source, looking at when kmalloc is
> called with GFP_NOFS in ReiserFS, and then the path that code takes in
> the VM source.
> 
> I assume the kernel VM code has a hole somewhere, and the request is
> falling through?  It should wait, even if no pages were free so, right? 
> 
> Where should I begin looking?  How does it relate to ReiserFS?  

The only other path that uses NO_FS is grow_buffers.  But the page probably 
got dirtied in generic_file_write, which already put buffers on it.  A NOFS 
allocation could also be triggered by Ext2 (and other filesystems) by having 
lots of dirty mmaps: when page_launder calls page->writepage then the page
won't have buffers on it.  That's probably not what's happening though.

I don't think NOFS is causing the problem by the way, it's just a convenient 
marker to recognize where the allocation is coming from.

What happens is, page_launder calls reseiserfs_writepage which for some 
reason recursively allocates a page (I don't have time to look for the exact 
path - it's probably for the journal - but whoever has the problem can check 
it via show_trace).  We now are in a recursive allocation situation (with 
PF_MEMALLOC) so page_launder doesn't get called and we drop through to get 
the "failed" message.

It's not nice for __alloc_pages to fail back to a caller that's willing to
wait.  See below for one idea about what to do about it.

> How is preemption related?

I'll speculate: page_launder is now yielding to other tasks when it releases
spinlocks to do a writepage.  One of them is likely to come back in and
attempt another allocation while we're at rock bottom.

If that's true then I think we should consider something I've wanted to try:
make callers block on a wait queue in __alloc_pages when memory is really
tight.

Hmm.  We could do that just in this specific case of PF_MEMALLOC+GFP_WAIT.
Semaphores work well for this kind of thing, something like:

	if (!(current->flags & PF_MEMALLOC)) {
		<the existing reclaim/launder logic>
	} else
		if (gfp_mask & __GFP_WAIT) {
			wakeup_kswapd();
			atomic_inc(&memwaiters);
			down(&memwait);
			goto try_again;
		}

Then in kswapd:

        waiters = atomic_read(&memwaiters);
        atomic_sub(waiters, &memwaiters);
	while (waiters--)
		up(&memwaiter);

when we detect that free memory is restored to something reasonable.  This
won't deadlock on memwait because kswapd doesn't use __GFP_WAIT.

We also have to make kswapd count wakeups so we can be sure it doesn't sleep
while somebody is waiting in __alloc_pages.  The only way I know to do this
reliably is with another semaphore:

	void wakeup_kswapd() {
		up(&kswapd_sleep);
	}

and kswapd downs that semaphore instead of doing interruptible_sleep_on_timeout.
Additionally, a timer has to up() the semaphore periodically, to recover the
sleep_on_timeout behaviour.

Sound like overkill?  The alternative is to let GFP_WAIT allocations fail which
forces users like journalling filesystems to busy wait and load up the runqueue.

Sorry I don't have time to code this just now, but I'd like to give this a try
if the problem's still there next week though.  Or if you're in the mood...

--
Daniel
