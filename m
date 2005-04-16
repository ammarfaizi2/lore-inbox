Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVDPQaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVDPQaf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 12:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVDPQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 12:30:34 -0400
Received: from science.horizon.com ([192.35.100.1]:54312 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262695AbVDPQa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 12:30:26 -0400
Date: 16 Apr 2005 16:30:25 -0000
Message-ID: <20050416163025.10962.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: Fortuna
Cc: daw@taverner.cs.berkeley.edu, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
In-Reply-To: <20050416150609.GC17029@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct me if I'm wrong here, but uniformity of the linear function isn't
> sufficent even if we implemented like this (right now it's more a+X than
> a <dot> X).
>
> The part which suggests choosing an irreducible poly and a value "a" in the
> preprocessing stage ... last I checked the value for a and the poly need to
> be secret.  How do you generate poly and a, Catch-22?  Perhaps I'm missing
> something and someone can point it out.

No, the value (the parameter pi) are specifically described as "the public
parameter".  See the "Preprocessing" paragraph at the end of section 1.2
on page 3.  "This string is then hardwired into the implementation and 
need not be kept secret."

All that's required is that the adversary can't tailor his limited
control over the input based on knowing pi.

There's a simple proof in all the papers that if an adversary knows
*everything* about the randomness extraction function, and has total
control over the input distribution, you're screwed.

Basically, suppose you have a 1024-bit input block, the attacker
is required to choose a distribution with at least 1023 bits of entropy,
and you only want 1 bit out.  Should be easy, right?
Well, with any *fixed* function, the possible inputs are divided into
those that hash to 0, and those that hash to 1.  One of those sets
must have at least 2^1023 members.  Suppose it's 0.  The attacker can
choose the input distribution to be "uniformly at random from the
>= 2^1023 inputs that hash to 0" and keep the promise while totally
breaking your extraction function.

But this paper says that if the attacker has to choose 2^t possible
input distributions (based on t bits of control over the input)
*before* the random parameter pi is chosen, then they're locked out.
*After* learning pi, they can choose *which* of the 2^t input
distributions to use.


The thing is, you need a parameterized family of hash functions.
They choose a random multiplier mod GF(2^n).  Their construction
is based on the well-known 2-universal family of hash functions
hash(x) = (a*x+b) mod p.

The /dev/random input mix is based on choosing a "random" polynomial
(since there was a lot of efficiency pressure, it isn't actually very
random; the question is, is it non-random enough to help an attacker).
Remiander modulo a uniformly chosen random irreducible polynomial is a
well-known ("division hash") family of universal hash functions, but
it's a little bit weaker than the above, and I have to figure out of
the proof extends.
