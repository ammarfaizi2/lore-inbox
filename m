Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272695AbRHaOGT>; Fri, 31 Aug 2001 10:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272696AbRHaOF7>; Fri, 31 Aug 2001 10:05:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11534 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272695AbRHaOFw>; Fri, 31 Aug 2001 10:05:52 -0400
Date: Fri, 31 Aug 2001 07:02:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108311322.PAA12269@nbd.it.uc3m.es>
Message-ID: <Pine.LNX.4.33.0108310655590.15502-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Aug 2001, Peter T. Breuer wrote:
>
> On doing a make bzImage no errors showed. On make modules, 4 errors
> showed, one in tun.c and 3 in pagebuf_io.c (I presume that's from
> xfs).
>
> I probably covered about 25% of the kernel code in that trial.

Good. This implies that the test itself is "reasonable and safe" - it
doesn't get nasty false positives, and assuming people en dup being happy
about it never causing surprising sign changes, I think this is a good
idea.

I _would_ suggest that you change the MIN_BUG() thing to the traditional

	#define compile_time_assert(x) \
		do { switch (0) { case 0: case (x) != 0: ; } } while (0)

which gives the error from the compiler, and does not depend on the
assembler.

(Admittedly the error message isn't the nicest in the world, but it gives
file and line number and include depth etc.. )

> The tun.c one was safe as it was .. the signed value was always
> positive at the point where the macro was applied.

Note that a _few_ false positives are fine - we can fix them up, and
people will be happy. The problems happen if the false positives are so
numerous that it makes common code uglier and harder to read because of
work-arounds for checkers.

So adding a cast or using an unsigned constant or whatever is fine.

> One thing that worries me is that these should have triggered on
> the signed/unsigned char comparisons that you were worried about in
> -Wsigned-compare, and no, they didn't. They did find other
> signed/unsigned mixes, but not char.

What I _really_ think might be interesting is a

	-Wsign-promote

warnign that hits outside compares (at any implicit promotion that
changes the sign - ie exactly the cases where K&R v1 and v2 differ), but I
suspect that it will have even _more_ problems than -Wsign-compare in the
sense that it probably really needs the compiler to do range analysis for
any amount of sane output..

		Linus

