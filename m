Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRABWXV>; Tue, 2 Jan 2001 17:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRABWXM>; Tue, 2 Jan 2001 17:23:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35088 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129534AbRABWXA>; Tue, 2 Jan 2001 17:23:00 -0500
Date: Tue, 2 Jan 2001 22:52:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
Message-ID: <20010102225230.D7563@athlon.random>
In-Reply-To: <20010102210949.C7563@athlon.random> <Pine.LNX.4.10.10101021250160.25414-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101021250160.25414-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 02, 2001 at 01:02:30PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 01:02:30PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 2 Jan 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Jan 02, 2001 at 11:02:41AM -0800, Linus Torvalds wrote:
> > > What does the system feel like if you just change the "sleep for bdflush"
> > > logic in wakeup_bdflush() to something like
> > > 
> > > 	wake_up_process(bdflush_tsk);
> > > 	__set_current_state(TASK_RUNNING);
> > > 	current->policy |= SCHED_YIELD;
> > > 	schedule();
> > > 
> > > instead of trying to wait for bdflush to wake us up?
> > 
> > My bet is a `VM: killing' message.
> 
> Maybe in 2.2.x, yes.
> 
> > Waiting bdflush back-wakeup is mandatory to do write throttling correctly.  The
> > above will break write throttling at least unless something foundamental is
> > changed recently and that doesn't seem the case.
> 
> page_launder() should wait for the dirty pages, and that's not something
> 2.2.x ever did.

In late 2.2.x we have sync_page_buffers too but I'm not sure how well it
behaves when the whole MM is costantly kept totally dirty and we don't have
swap. Infact also the 2.4.x implementation:

static void sync_page_buffers(struct buffer_head *bh, int wait)
{
	struct buffer_head * tmp = bh;

	do {
		struct buffer_head *p = tmp;
		tmp = tmp->b_this_page;
		if (buffer_locked(p)) {
			if (wait > 1)
				__wait_on_buffer(p);
		} else if (buffer_dirty(p))
			ll_rw_block(WRITE, 1, &p);
	} while (tmp != bh);
}

won't cope with the memory totally dirty. It will make the buffer from dirty to
locked then it will wait I/O completion at the second pass, but it
won't try again to free the page for the third time (when the page is finally
freeable):

	if (wait) {
		sync_page_buffers(bh, wait);
		/* We waited synchronously, so we can free the buffers. */
		if (wait > 1 && !loop) {
			loop = 1;
			goto cleaned_buffers_try_again;
		}

Probably not a big deal.

The real point is that even if try_to_free_buffers will deal perfectly with the
VM totally dirty we'll end waiting I/O completion in the wrong place.
setiathome will end waiting I/O completion instead of `cp`. It's not setiathome
but `cp` that should do write throttling. And `cp` will block again very soon
even if setiathome blocks too. The whole point is that the write throttling
must happen in balance_dirty(), _not_ in sync_page_buffers().

Infact from 2.2.19pre2 there's a wait_io per-bh bitflag that remembers when a
dirty bh is very old and it doesn't get flushed away automatically (from
either kupdate or kflushd). So we don't block in sync_page_buffers until it's
necessary to avoid hurting non-IO apps when I/O is going on.

> NOTE! I think that throttling writers is fine and good, but as it stands
> now, the dirty buffer balancing will throttle anybody, not just the
> writer. That's partly because of the 2.4.x mis-feature of doing the

How can it throttle everybody and not only the writers? _Only_ the
writers calls balance_dirty.

> balance_dirty call even for previously dirty buffers (fixed in my tree,
> btw).

Yes I seen, people overwriting dirty data was blocking too, that was
not necessary, but they were still writers.

> It's _really_ bad to wait for bdflush to finish if we hold on to things
> like the superblock lock - which _does_ happen right now. That's why I'm
> pretty convinced that we should NOT blindly do the dirty balance in
> "mark_buffer_dirty()", but instead at more well-defined points (in places
> like "generic_file_write()", for example).

Right way to avoid blocking with lock helds is to replace mark_buffer_dirty
with __mark_buffer_dirty() and to call balance_dirty() later when the locks are
released.  That's why it's exported to modules.  Everybody is always been
allowed to optimize away the mark_buffer_dirty(), it's just that nobody did
that yet. I think it's useful to keep providing an interface that does the
write throttling automatically.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
