Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264096AbRGWWxX>; Mon, 23 Jul 2001 18:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264329AbRGWWxN>; Mon, 23 Jul 2001 18:53:13 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:36623 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264096AbRGWWxF>; Mon, 23 Jul 2001 18:53:05 -0400
Date: Mon, 23 Jul 2001 15:51:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
        <user-mode-linux-user@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <p05100301b78235dce19e@[10.0.0.49]>
Message-ID: <Pine.LNX.4.33.0107231546430.7916-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Jonathan Lundell wrote:
>
> If jiffies were not volatile, this initializing assignment and the
> test at the end could be optimized away, leaving an unconditional
> "return 0". A lock is of no help.

Right.

We want optimization barriers, and there's an explicit "barrier()"  thing
for Linux exactly for this reason.

For historical reasons "jiffies" is actually marked volatile, but at least
it has reasonably good semantics with a single-data item. Which is not to
say I like it. But grep for "barrier()" to see how many times we make this
explicit in the algorithms.

And really, THAT is my whole point. Notice in the previous mail how I used
"volatile" when it was part of the _algorithm_. You should not hide
algorithmic choices in your data structures. You should make them
explicit, so that when you read the code you _see_ what assumptions people
make.

For example, if you fix the code by adding an explicit barrier(), people
see that (a) you're aware of the fact that you expect the values to change
and (b) they see that it is taken care of.

In contrast, if your data structure is marked volatile, how is anybody
reading the code every going to be sure that the code is correct? You have
to look at the header file defining all the data structures. That kind of
thing is NOT GOOD.

So make the algorithm be correct. Then you will notice that there is
_never_ any reason (except for being lazy with tons of existing code) to
add "volatile" to data structures.

Ponder. Understand.

		Linus

