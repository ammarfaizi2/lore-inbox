Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRABWdn>; Tue, 2 Jan 2001 17:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRABWdb>; Tue, 2 Jan 2001 17:33:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12300 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130017AbRABWdT>; Tue, 2 Jan 2001 17:33:19 -0500
Date: Tue, 2 Jan 2001 14:01:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <20010102225230.D7563@athlon.random>
Message-ID: <Pine.LNX.4.10.10101021357180.1292-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Andrea Arcangeli wrote:
> 
> > NOTE! I think that throttling writers is fine and good, but as it stands
> > now, the dirty buffer balancing will throttle anybody, not just the
> > writer. That's partly because of the 2.4.x mis-feature of doing the
> 
> How can it throttle everybody and not only the writers? _Only_ the
> writers calls balance_dirty.

A lot of people call mark_buffer_dirty() on one or two buffers. Things
like file creation etc. Think about inode bitmap blocks that are marked
dirty with the superblock held.. Ugh.

> Right way to avoid blocking with lock helds is to replace mark_buffer_dirty
> with __mark_buffer_dirty() and to call balance_dirty() later when the locks are
> released.

The point being that because _everybody_ should do this, we shouldn't have
the "mark_buffer_dirty()" that we have. There are no really valid uses of
the automatic rebalancing: either we're writing meta-data (which
definitely should balance on its own _after_ the fact), or we're writing
normal data (which already _does_ balance after the fact).

Right now, the automatic balancing only hurts. The stuff that hasn't been
converted is probably worse off doing balancing when they don't want to,
than we would be to leave the balancing altogether.

Which is why I don't like it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
