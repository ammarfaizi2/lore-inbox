Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281881AbRKSCH2>; Sun, 18 Nov 2001 21:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281882AbRKSCHT>; Sun, 18 Nov 2001 21:07:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33799 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281881AbRKSCHO>; Sun, 18 Nov 2001 21:07:14 -0500
Date: Sun, 18 Nov 2001 18:02:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <E165QhG-00035D-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111181756260.7482-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Nov 2001, Alan Cox wrote:
>
> Why is it a compiler bug. You've not declared that variable to be volatile
> therefore it is only touched in the code flow the compiler is analysing.

Even without volatile, the compiler is very arguably buggy if it writes
values to your variables that were never supposed to be there.

Take this, for example:

	sig_atomic_t value = 1;

	int fn()
	{
		value = 2;
	}

And a signal comes in. Even without the volatile, if gcc has written
_anything_ else than 1 or 2 into the variable, gcc is BROKEN.

There's no point being a language lawyer and saying that gcc "could write
anything to value before it writes the final 2". Tha's not true. A compile
rthat does that is

 (a) buggy as hell from a POSIX standpoint
 (b) even apart from POSIX, from a Q-of-I standpoint complete and utter
     crap.

And yes, the argument for "page->flags" is _exactly_ the same. Writing
intermediate values to "page->flags" that were never referenced by the
programmer is clearly such a violation of QoI that it is a bug even if
"sig_atomic_t" happens to be "int", and "page->flags" happens to be
"unsigned int".

		Linus

