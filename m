Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbQJaJeS>; Tue, 31 Oct 2000 04:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbQJaJeJ>; Tue, 31 Oct 2000 04:34:09 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:27588 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129041AbQJaJdx>; Tue, 31 Oct 2000 04:33:53 -0500
To: linux-kernel@vger.kernel.org
Subject: Problems with adjtime
Date: Tue, 31 Oct 2000 09:33:52 +0000
From: Nick Maclaren <nmm1@cus.cam.ac.uk>
Message-Id: <E13qXnk-000370-00@libra.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been told that this is the right mailing list to report this
to.

I have been attempting to use my SNTP client (msntp) under Linux,
and discover that adjtime is more-or-less completely broken, so I
have to use gettimeofday+increment+settimeofday.  It is possible
that I have misconfigured, but I have failed to find anything
relevant.  And investigation indicates that the problem is definitely
beyond the adjtime interface kludge into adjtimex, as I can reproduce
it directly.

Anyway, here are the details:

The current symptoms are that the call to adjtime works, the increment
is stored and successive calls to adjtime will return it, but the
clock is not being updated.  After a while, the increment is thrown
away.  This is on a free-standing system, used for dial-up, which
is when I want to run my code.  This is for 2.0.36 and 2.2.17.

adjtime is a horrible Berkeleyism, with the usual lack of specification,
but it is the only clean way to set the clock atomically.  My SNTP client
(and other programs) use it because it means that they can synchronise
the clock without needing to run at 'real time priority' with all of
the system-dependence and serious problems that entails.  If they use
gettimeofday+increment+settimeofday, there is a race condition that can
cause the clock to be set wildly incorrectly.

Note that the essential feature of adjtime for this purpose is NOT that
it is gradual (though most systems implement it that way), but that it
is atomic.  adjtimex is not suitable for this purpose, for three reasons:
it is seriously system dependent, it introduces unnecessary kernel
knowledge and control into the application, and see below.

[ I could explain why it is desirable to be able to use an alternative
client to xtnp, but that is a little irrelevant.  Please ask me if
you want to know the details. ]

Most systems support adjtime, up to a point, though it is often pretty
grim (e.g. under Irix).  Unfortunately, Linux supports it only as hack
into adjtimex, and adjtimex works only if the clock is 'synchronised'
(which I assume means that xntp is running).  But this is entirely
wrong!  There are two options:

    1) You are using xntp to synchronise the clock, in which case you
should NOT be fiddling with the clock using any other mechanism, and
should NOT use adjtime.

    2) You are using some other mechanism to sychronise the code,
which may use adjtime, but it then needs to work without xntp running.
It doesn't really matter HOW the clock is adjusted, though retaining
monotonicity is nice.

I have chased this problem some way into the kernel, but I don't know
how its low-level scheduling works, and so the above includes a certain
amount of guesswork.  Also, I cannot see how to fix it in a simple
fashion.  Again, I can see two possibilities:

    1) To define an 'inctimeofday' function and attempt to get it
standardised.  This is confused by the fact that the X/Open bunch are
attempting to standardise a new set of names for gettimeofday and
settimeofday, and have not included an adjtime replacement.

    2) To kludge up the Linux kernel to ensure that adjtime works
even if xntp isn't running.  This is well beyond my abilities (at
least at present).



Regards,
Nick Maclaren,
University of Cambridge Computing Service,
New Museums Site, Pembroke Street, Cambridge CB2 3QG, England.
Email:  nmm1@cam.ac.uk
Tel.:  +44 1223 334761    Fax:  +44 1223 334679
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
