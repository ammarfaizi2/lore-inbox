Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbRGWVLg>; Mon, 23 Jul 2001 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbRGWVL0>; Mon, 23 Jul 2001 17:11:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:3960 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267922AbRGWVLP>; Mon, 23 Jul 2001 17:11:15 -0400
Date: Mon, 23 Jul 2001 23:11:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723231136.E16919@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <3B5C8C96.FE53F5BA@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B5C8C96.FE53F5BA@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Mon, Jul 23, 2001 at 04:44:06PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 04:44:06PM -0400, Chris Friesen wrote:
> Linus Torvalds wrote:
> > 
> > On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
> > >
> > > gcc can assume 'state' stays constant in memory not just during the
> > > 'case'.
> > 
> > The point is that if the kernel has _any_ algorithm where it cares, it's a
> > kernel bug. With volatile or without.
> > 
> > SHOW ME THE CASE WHERE IT CARES. Let's fix it. Let's not just hide it with
> > "volatile".
> 
> If I understand correctly, xtime is updated asynchronously.  If it isn't, then
> ignore this message totally.  However, if it is, then *not* specifying it as
> volatile could easily cause problems in technically correct but poorly written
> code.
> 
> Suppose I loop against xtime reaching a particular value.  While this is
> definately not good practice, if xtime is not specified as volatile then since I
> never modify it within the loop the compiler is free to move the initial load
> out of the loop when optimizing.  In this example the case where it is marked as
> volatile will run (though inefficiently), but the non-volatile case can hang
> totally.
> 
> Do we want to get ourselves into something like this?

This is actually another issue, not really the problem I was talking
about. The problem I was talking about was just about the C language and
about writing correct C code (whith correct C code I mean something that
cannot break by using a future release of gcc). Without my patch you
never know. About the loop problem you mentioned you can know it won't
break instead if you write it carefully. Of course I understand in most
cases if the code breaks in the actual usages of xtime it is likely that
gcc is doing something stupid in terms of performance. but GCC if it
wants to is allowed to compile this code:

	printf("%lx\n", xtime.tv_sec);

as:

	unsigned long sec = xtime.tv_sec;
	if (sec != xtime.tv_sec)
		BUG();
	printf("%lx\n", sec);

Andrea
