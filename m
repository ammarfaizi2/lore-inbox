Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbRGXQGk>; Tue, 24 Jul 2001 12:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267825AbRGXQGa>; Tue, 24 Jul 2001 12:06:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14856 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267776AbRGXQGQ>; Tue, 24 Jul 2001 12:06:16 -0400
Date: Tue, 24 Jul 2001 09:04:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010724020413.A29561@athlon.random>
Message-ID: <Pine.LNX.4.33.0107240849240.29354-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 24 Jul 2001, Andrea Arcangeli wrote:
> On Mon, Jul 23, 2001 at 05:47:04PM -0600, Richard Gooch wrote:
> > I don't think it should be allowed to do that. That's a whipping
>
> it is allowed to do that, period. This is not your choice or my choice.
> You may ask gcc folks not to do that and I think they just do.

Stop this stupid argument.

A C compiler is "allowed" to do just about anything. The introduction of
"volatile" does not change that in any really meaningful way. It doesn't
change the fact that gcc is "allowed" to do a really shitty job on _any_
code it is given.

>From a pure standards standpoint, gcc can change something like

	int i = *int_ptr;

into the equivalent of (assuming a little-endian machine with only byte
load/store instructions)

	unsigned char *tmp = (unsigned char *)int_ptr + 3;
	int j = 4;
	int i = 0;

	do {
		i <<= 8;
		i += *tmp;
		tmp--;
	} while (--j);

The fact that a C compiler is _allowed_ to create code like just about
anything is not an argument at all.

The above, btw, is NOT as ridiculous as it sounds. We've had the exact
opposite problem on alpha: byte stores are not "atomic", and would
"corrupt" the bytes around it due to the non-atomic nature of having to do

	load word
	mask value
	insert byte
	store word

Did it help to mark things "volatile" there? No. We had to change the code
to (a) either use locking so that nobody would ever touch adjacent bytes
concurrently or (b) stop using byte values.

			Linus

