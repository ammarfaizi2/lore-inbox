Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRIZAUe>; Tue, 25 Sep 2001 20:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274747AbRIZAUY>; Tue, 25 Sep 2001 20:20:24 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:58629 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S274746AbRIZAUO>;
	Tue, 25 Sep 2001 20:20:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
Date: 26 Sep 2001 00:20:32 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9or70g$i59$1@abraham.cs.berkeley.edu>
In-Reply-To: <1001461026.9352.156.camel@phantasy>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1001463632 18601 128.32.45.153 (26 Sep 2001 00:20:32 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 26 Sep 2001 00:20:32 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm worried about the language in the configuration documentation:
  +  Some people, however, feel that network devices should not contribute to
  +  /dev/random because an external attacker could observe incoming packets
  +  in an attempt to learn the entropy pool's state. Note this is completely
  +  theoretical. 
Incrementing the entropy counter based on externally observable
values is dangerous.  Calling this risk 'completely theoretical'
is, I believe, a misrepresentation, unless I've missed something.

A failed RNG is one of the most likely -- and most devastating
-- failure modes possible for modern cryptosystems, and as such
it pays to be careful here.  Are you proposing this for inclusion
in the mainline Linux kernel?  If so, I'm concerned that this patch
could put security at risk.  What am I missing?

Here is my reasoning.  I'd like to quote drivers/char/random.c:
  * add_interrupt_randomness() uses the inter-interrupt timing as random
  * inputs to the entropy pool.  Note that not all interrupts are good
  * sources of randomness!  For example, the timer interrupts is not a
  * good choice, because the periodicity of the interrupts is too
  * regular, and hence predictable to an attacker.  Disk interrupts are
  * a better measure, since the timing of the disk interrupts are more
  * unpredictable.
  * 
  * All of these routines try to estimate how many bits of randomness a
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
This suggests that add_interrupt_randomness() should not be called
on all interrupts without discrimination.  Would it be fair to say
that your patch enables randomness collection on almost all interrupts?
If so, why is this safe to do?

I hope you agree that making this configurable does not obviate our
responsibility to make sure that the default configuration is reasonable.
This stuff is subtle, and changing it is not something I'd recommend
without a careful analysis of the impact on security.  Moreover, the
comments about 'completely theoretical' leave me concerned that any
analysis that has been done on this patch may be based on misconceptions
about cryptographic security.  Can you tell us anything about what
security analysis you've done so far?
