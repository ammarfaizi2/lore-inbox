Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSIHSPN>; Sun, 8 Sep 2002 14:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSIHSPN>; Sun, 8 Sep 2002 14:15:13 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:63761 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S312590AbSIHSPM>; Sun, 8 Sep 2002 14:15:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: 8 Sep 2002 18:03:09 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <alg3ct$pru$1@abraham.cs.berkeley.edu>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1031508189 26494 128.32.153.211 (8 Sep 2002 18:03:09 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 8 Sep 2002 18:03:09 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hugh Redelmeier wrote:
>The Intel (and, I assume, the AMD) hardware random generator cannot be
>audited.

I disagree.  The Intel RNG can be audited, and it has been audited.

The Intel RNG works like this.  In hardware, there is a noise source,
which outputs bits that may be somewhat biased.  Then, also in hardware,
there is a von Neumann stage that does a little bit of conditioning to
reduce the bias slightly.  Finally, in software, the Intel driver applies
SHA-1 to do heavy bit-mixing and pseudorandomization.

Of course, running randomness tests after the SHA-1 stage will tell
you nothing.  You could run SHA-1 on a counter and it would pass DIEHARD.
So, don't do that.

Rather, to audit the Intel RNG, the first thing to do is to run
statistical tests on the input to SHA-1.  Ideally, you'd like to do
this before the von Neumann stage, but since the von Neumann compensator
is in hardware, that's not possible.  Fortunately, you can do the
auditing on the output of the von Neumann stage, and this is almost
as good.  Because the von Neumann filter does only very light conditioning,
any flaws in the input to the von Neumann stage are likely to be apparent
after the output stage as well, if you have a large number of samples.
Fortunately, because the SHA-1 is in software, this test is feasible.

The second thing to do is to look at the design of the hardware noise
source to see whether it looks like a reliable source of random bits.

Both of these tests have been performed.  Paul Kocher has looked
carefully at the Intel RNG, and given it high scores.  See
  http://www.cryptography.com/resources/whitepapers/IntelRNG.pdf

Of course, there are no guarantees.  But let's look at the alternatives.
If you pick software-based noise sources, there's always the risk that
they may fail to produce useful entropy.  (For instance, you sample the
soundcard, but 5% of machines have no soundcard and hence give no
entropy, or 5% of the time you get back stuff highly correlated to
60Hz AC.)  The risk that a software-based noise source fails seems much
higher than the risk that the Intel RNG has a backdoor.  And the Intel
RNG seems very unlikely to fail at random.  If you're going to rely on
any single source, the Intel RNG seems like by far the most reliable
source around.

Of course, in cryptography you should never be relying on only one noise
source anyway.  You should mix as many noise sources together as possible.
Then, as long as the hash is secure, you'll be secure as long as any
one of those noise sources is working, even if the others fail adversarially.
(At least, this should be the case for any well-designed entropy crunching
algorithm.)  Given this, there is no reason not to use the Intel RNG,
and every reason to use it.  It can only help, not hurt.

So it seems to me that using the Intel RNG is a big win, and the risk
of a backdoor is "in the noise".
