Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274146AbRI0Xrg>; Thu, 27 Sep 2001 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274154AbRI0Xr0>; Thu, 27 Sep 2001 19:47:26 -0400
Received: from [195.223.140.107] ([195.223.140.107]:18172 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274146AbRI0XrN>;
	Thu, 27 Sep 2001 19:47:13 -0400
Date: Fri, 28 Sep 2001 01:47:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928014720.Z14277@athlon.random>
In-Reply-To: <20010928001321.L14277@athlon.random> <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Sep 27, 2001 at 04:16:11PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 04:16:11PM -0700, Linus Torvalds wrote:
> 
> On Fri, 28 Sep 2001, Andrea Arcangeli wrote:
> However, your patch is racy:
> 
> > --- 2.4.10aa2/fs/buffer.c.~1~	Wed Sep 26 18:45:29 2001
> > +++ 2.4.10aa2/fs/buffer.c	Fri Sep 28 00:04:44 2001
> > @@ -194,6 +194,7 @@
> >  		struct buffer_head * bh = *array++;
> >  		bh->b_end_io = end_buffer_io_sync;
> >  		submit_bh(WRITE, bh);
> > +		clear_bit(BH_Pending_IO, &bh->b_state);
> 
> No way can we clear the bit here, because the submit_bh() may have caused
> the buffer to be unlocked and IO to have completed, and it is no longer
> "owned" by us - somebody else might have started IO on it and we'd be
> clearing the bit for the wrong user.

Moving clear_bit just above submit_bh will fix it (please Robert make
this change before testing it), because if we block in submit_bh in the
bounce, then we won't deadlock on ourself because of the pagehighmem
check, and all previous non-pending bh are ok too, (only the next are
problematic, and they're still marked pending_IO so we can't deadlock on
them).

So you can re-consider my approch, the design of the fix was ok, it was
just a silly implementation error.

Andrea
