Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUI0E7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUI0E7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 00:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUI0E7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 00:59:17 -0400
Received: from [69.25.196.29] ([69.25.196.29]:49086 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265909AbUI0E7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 00:59:12 -0400
Date: Mon, 27 Sep 2004 00:58:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040927045828.GA13887@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	linux-kernel@vger.kernel.org
References: <20040923234340.GF28317@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923234340.GF28317@certainkey.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently posted the following article on sci.crypt, which has a more
detailed analysis of the design of JLC's proposed patch to random.c

					- Ted


From: tytso@mit.edu (Theodore Y. Ts'o)
Subject: Re: new /dev/random
Newsgroups: sci.crypt
Date: 27 Sep 2004 00:05:32 -0400
Organization: Massachusetts Institute of Technology

Paul Rubin <http://phr.cx@NOSPAM.invalid> writes:
>Huh?  JLC's patch *is* Fortuna.  

Actually, it isn't Fortuna.  But more on that in a moment....

>However, IMO, JLC's patch (Fortuna)
>should not go into the kernel in its present form, and the kernel
>maintainers should reject it.  It should not be a configuration
>option.  It has too much potential of screwing the user, until the
>entropy accounting is restored.

The problem is that Fortuna's design isn't really particularly
compatible with entropy accounting.  Each pool only contains 256 bits,
and by definition, the pool can not possibly store more entropy than
that.  Once you extract 256 bits, you have to wait a second before you
can drain whatever entropy might be in pool #1, then two seconds
before you can drain whatever entropy might be in pool #2, then four
seconds before you can drain whataver might be in pool #3, and so on.
This means that even if all of the pools are completely filled, in
order to extract 2048 bits of entropy (for an long-term RSA key pair,
for example), this would require waiting for a little over 4 minutes
(255 seconds, to be precise).  To extract 4096 bits of entropy, we
would have to wait 18 hours, 12 minutes, and 15 seconds (65535 seconds).

Indeed, one of the complaints that I have about the whole Fortuna
design is that from the entropy perspective, 25% of the entropy is
stashed away in pools that will never be used for over six *months*,
with 50% of the pools never getting used until after 18 hours or more.
Of course in that time, those pools will get filled, refilled and
overfilled, many times over, uselessly wasting entropy.  Entropy is a
precious resource; it should not be so thoughtlessly squandered.

.... but of course, waiting over 18 hours to before sufficient amounts
of entropy cascades through the pool structure in order to generate a
4096-bit RSA key isn't a problem with JLC's patch, because it doesn't
implement the 2^k second delay for each pool, as specified by the
Fortuna design.  Instead, it reseeds at every call to extract_entropy,
and every 2^k reseeds, it uses a particular pool.  But in order to
provide resistance to the state-extension attack --- which is the only
justification for replacing /dev/random's current algorithm with
Fortuna, and Fortuna's raison de etre --- you have to wait until a
pool has a sufficient amount of entropy in order to provide for a
catastrophic reseeding.  Because the rate at which the pools are drawn
down is dependent on the extraction rate, not based on a time basis,
or based on some estimate of the amount of entropy collected in each
of the pools, JLC's proposed patch is vulnerable to state extension
attack.  In other words, the proposed patch doesn't even do what it
sets out to do!!

P.S.  Despite the fact that JLC's patch is vulnerable to the state
extension attack, because it does not faithfully implement the Fortuna
design, it still squanders entropy.  In fact, because under normal
operations, reads to /dev/random are happen even less frequently than
once a second, over 50% of the collected entropy could be stored for
**years** before it is ever used, with the net result that the
high-level entropy pools will get overfilled, and the entropy wasted.
This is despite the fact that in the attack scenario, the attacker can
still force the high-order pools to be used before sufficient entropy
can be stored.  So with respect to these two defects, it is the worst
of both worlds.

P.P.S.  Despite the fact that JLC's patch defines a #define
RANDOM_RESEED_INTERVAL, which might lead one to believe that it is
using a time-based cascading, in fact, that #define is never used in
his patch.  Despite the fact that a certain party has been seen
whining about "obfuscated" code being hard being "rude", I won't go
down that particular path.  Nevertheless, the JLC's patch, with a
profusion of unsued #define's, and dead code from the original
/dev/random that is incompletely removed, has obfuscation not from the
subtle design standpoint, but from the sloppy coding perspective,
which IMHO is far worse (although of course, this can be corrected).
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Theodore Ts'o			http://web.mit.edu/user/tytso/www/
   Everybody's playing the game, but nobody's rules are the same!
