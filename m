Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274168AbRI1AEL>; Thu, 27 Sep 2001 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274161AbRI1AEA>; Thu, 27 Sep 2001 20:04:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48651 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274168AbRI1ADp>; Thu, 27 Sep 2001 20:03:45 -0400
Date: Thu, 27 Sep 2001 17:03:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
 2.4.9-ac14/15(+stuff)]
In-Reply-To: <20010928014720.Z14277@athlon.random>
Message-ID: <Pine.LNX.4.33.0109271700001.32086-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Andrea Arcangeli wrote:
>
> Moving clear_bit just above submit_bh will fix it (please Robert make
> this change before testing it), because if we block in submit_bh in the
> bounce, then we won't deadlock on ourself because of the pagehighmem
> check

We won't block on _ourselves_, but we can block on _two_ people doing it,
and blocking on each others requests that are blocked waiting on a bounce
buffer. Both will have one locked buffer, both will be waiting for the
other person unlocking that buffer, and neither will ever make progress.

You could clear that bit _after_ the bounce buffer allocation, I suspect.

But I also suspect that it doesn't matter much, and as I can imagine
similar problems with GFP_NOIO and loopback etc (do you see any reason why
loopback couldn't deadlock on waiting for itself?), I think the GFP_XXX
thing is the proper fix.

		Linus

