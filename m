Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbRASG4t>; Fri, 19 Jan 2001 01:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRASG4k>; Fri, 19 Jan 2001 01:56:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38149 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129757AbRASG4a>; Fri, 19 Jan 2001 01:56:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Date: 18 Jan 2001 22:55:59 -0800
Organization: Transmeta Corporation
Message-ID: <948odv$963$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101171659160.10878-100000@penguin.transmeta.com> <200101182112.f0ILCmZ113705@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101182112.f0ILCmZ113705@saturn.cs.uml.edu>,
Albert D. Cahalan <acahalan@cs.uml.edu> wrote:
>
>What about getting rid of both that and the pointer, and just
>hanging that data on the end as a variable length array?
>
>struct kiovec2{
>  int nbufs;
>  /* ... */
>  struct kiobuf[0];
>}

If the struct ends up having lots of other fields, yes.

On the other hand, if one basic form of kiobuf's ends up being really
just the array and the number of elements, there are reasons not to do
this. One is that you can "peel" off parts of the buffer, and split it
up if (for example) your driver has some limitation to the number of
scatter-gather requests it can make. For example, you may have code that
looks roughly like

	.. int nr, struct kibuf *buf ..

	while (nr > MAX_SEGMENTS) {
		lower_level(MAX_SEGMENTS, buf);
		nr -= MAX_SEGMENTS;
		buf += MAX_SEGMENTS;
	}
	lower_level(nr, buf);

which is rather awkward to do if you tie "nr" and the array too closely
together. 

(Of course, the driver could just split them up - take it from the
structure and pass them down in the separated manner. I don't know which
level the separation is worth doing at, but I have this feeling that if
the structure ends up being _only_ the nbufs and bufs, they should not
be tied together.)

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
