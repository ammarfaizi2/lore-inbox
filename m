Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAKNUW>; Thu, 11 Jan 2001 08:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRAKNUN>; Thu, 11 Jan 2001 08:20:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130006AbRAKNUG>;
	Thu, 11 Jan 2001 08:20:06 -0500
Date: Wed, 10 Jan 2001 21:19:41 -0800
Message-Id: <200101110519.VAA02784@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andrewm@uow.edu.au
CC: jayts@bigfoot.com, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca, xpert@xfree86.org,
        mcrichto@mpp.ecs.umass.edu
In-Reply-To: <3A5D994A.1568A4D5@uow.edu.au> (message from Andrew Morton on
	Thu, 11 Jan 2001 22:30:18 +1100)
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> from "Andrew Morton" at Jan 07, 2001 01:53:50 PM <200101110312.UAA06343@toltec.metran.cx> <3A5D994A.1568A4D5@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just some commentary and a bug report on your patch Andrew:

Opinion: Personally, I think the approach in Andrew's patch
	 is the way to go.

	 Not because it can give the absolute best results.
	 But rather, it is because it says "here is where a lot
         of time is spent".

	 This has two huge benefits:
	 1) It tells us where possible algorithmic improvements may
	    be possible.  In some cases we may be able to improve the
	    code to the point where the pre-emption points are no
	    longer necessary and can thus be removed.
	 2) It affects only code which can burn a lot of cpu without
	    scheduling.  Compare this to schemes which make the kernel
	    fully pre-emptable, causing _EVERYONE_ to pay the price of
	    low-latency.  If we were to later fine algorithmic
	    improvements to the high-latency pieces of code, we
            couldn't then just "undo" support for pre-emption because
	    dependencies will have swept across the whole kernel
	    already.

            Pre-emption, by itself, also doesn't help in situations
	    where lots of time is spent while holding spinlocks.
	    There are several other operating systems which support
	    pre-emption where you will find hard coded calls to the
	    scheduler in time-consuming code.  Heh, it's almost like,
	    "what's the frigging point of pre-emption then if you
	    still have to manually check in some spots?"

Bug:	In the tcp_minisock.c changes, if you bail out of the loop
	early (ie. max_killed=1) you do not decrement tcp_tw_count
	by killed, which corrupts the state of the TIME_WAIT socket
	reaper.  The fix is simple, just duplicate the tcp_tw_count
	decrement into the "if (max_killed)" code block.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
