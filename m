Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274164AbRI1ALU>; Thu, 27 Sep 2001 20:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274900AbRI1ALK>; Thu, 27 Sep 2001 20:11:10 -0400
Received: from [195.223.140.107] ([195.223.140.107]:32252 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274164AbRI1AK7>;
	Thu, 27 Sep 2001 20:10:59 -0400
Date: Fri, 28 Sep 2001 02:11:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928021115.D14277@athlon.random>
In-Reply-To: <20010928014720.Z14277@athlon.random> <Pine.LNX.4.33.0109271700001.32086-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109271700001.32086-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Sep 27, 2001 at 05:03:49PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 05:03:49PM -0700, Linus Torvalds wrote:
> 
> On Fri, 28 Sep 2001, Andrea Arcangeli wrote:
> >
> > Moving clear_bit just above submit_bh will fix it (please Robert make
> > this change before testing it), because if we block in submit_bh in the
> > bounce, then we won't deadlock on ourself because of the pagehighmem
> > check
> 
> We won't block on _ourselves_, but we can block on _two_ people doing it,

If other people waits for us it's ok (if they waits it means they're not
using GFP_NOIO and they're also not using GFP_NOHIGHIO).

We cannot wait on other two people doing it since they would be highmem
pages and the pagehighmem check forbids that.

> and blocking on each others requests that are blocked waiting on a bounce
> buffer. Both will have one locked buffer, both will be waiting for the
> other person unlocking that buffer, and neither will ever make progress.
> 
> You could clear that bit _after_ the bounce buffer allocation, I suspect.

I don't think it's necessary.

> But I also suspect that it doesn't matter much, and as I can imagine
> similar problems with GFP_NOIO and loopback etc (do you see any reason why
> loopback couldn't deadlock on waiting for itself?), I think the GFP_XXX
> thing is the proper fix.

GFP_NOIO is a no brainer, it cannot go wrong see the other email.

Andrea
