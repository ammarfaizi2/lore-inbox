Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267511AbRGWSNC>; Mon, 23 Jul 2001 14:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268325AbRGWSMw>; Mon, 23 Jul 2001 14:12:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267511AbRGWSMj>; Mon, 23 Jul 2001 14:12:39 -0400
Date: Mon, 23 Jul 2001 11:11:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Dike <jdike@karaya.com>, <user-mode-linux-user@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010723195055.A16919@athlon.random>
Message-ID: <Pine.LNX.4.33.0107231103570.13272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
>
> GCC internally is allowed to generate code that relies on the contents
> of the memory to stay constant, this because of the C standard, the
> usual example is a fast path jump table for the "case" statement.

Bah.

If we have a case where we _really_ care about the value being stable, I
_still_ claim that that is the one that we need to protect. Not waving
some magic wand over the thing, and saying that "volatile" makes an
unstable value ok.

"volatile" (in the data sense, not the "asm volatile" sense) is almost
always a sign of a bug. If you have an algorithm that depends on the
(compiler-specifi) behaviour of "volatile", you need to change the
algorithm, not try to hide the fact that you have a bug.

Now, the change of algorithm might be something like

	/*
	 * We need to get _one_ value here, because our
	 * state machine ....
	 */
	unsigned long stable = *(volatile unsigned long *)ptr;

	switch (stable) {
	....
	}

where the volatile is in the place where we care, and the volatile is
commented on WHY it actually is the correct thing to do.

The C standard doesn't say crap about volatile. It leaves it up to the
compiler to do something about it.

This is _doubly_ true of multi-word data structures like "xtime". The
meaning of "volatile" on the data structure is so unclear that it's not
even funny.

		Linus

