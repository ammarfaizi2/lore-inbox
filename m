Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbRABWzO>; Tue, 2 Jan 2001 17:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRABWzE>; Tue, 2 Jan 2001 17:55:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5645 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130108AbRABWyv>; Tue, 2 Jan 2001 17:54:51 -0500
Date: Tue, 2 Jan 2001 14:23:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <Pine.LNX.4.10.10101021357180.1292-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101021418090.847-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2001, Linus Torvalds wrote:
> 
> Right now, the automatic balancing only hurts. The stuff that hasn't been
> converted is probably worse off doing balancing when they don't want to,
> than we would be to leave the balancing altogether.
> 
> Which is why I don't like it.

Actually, there is right now another problem with the synchronous waiting,
which is completely different: because bdflush can be waited on
synchronously by various entities that hold various IO locks, bdflush
itself cannot do certain kinds of IO at all. In particular, it has to use
GFP_BUFFER when it calls down to page_launder(), because it cannot afford
to write out dirty pages which might deadlock on the locks that are held
by people waiting for bdflush..

The deadlock issue is the one I dislike the most: bdflush being
synchronously waited on is fundamentally always going to cripple it. In
comparison, the automatic rebalancing is just a latency issue (but the
automatic balancing _is_ the thing that brings on the fact that we call
rebalance with locks held, so they are certainly related).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
