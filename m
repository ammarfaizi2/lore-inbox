Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269485AbUIZCbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269485AbUIZCbS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 22:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUIZCbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 22:31:18 -0400
Received: from science.horizon.com ([192.35.100.1]:15151 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S269485AbUIZCbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 22:31:15 -0400
Date: 26 Sep 2004 02:31:14 -0000
Message-ID: <20040926023114.19531.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Cc: cryptoapi@lists.logix.cz, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       tytso@mit.edu
In-Reply-To: <20040925145444.GW28317@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying to point out a flaw in Ted's logic.  He said "we've recently
> discoverd these hashes are weak because we found collsions.  Current
> /dev/random doesn't care about this."

And he's exactly right.  The only attack that would be vaguely relevant
to /dev/random's use would be a (first) preimage attack, and even that's
probably not helpful.

There *is* no flaw in his logic.  The attack we need to guard against
is, given hash(x) and a (currently mostly linear) state mixing function
mix(), one that would let you compute (partial information about)
y[i+1] = hash(x[i+1]) from y[1] = hash(x[1]) ... y[i] = hash(x[i])
where x[i] = mix(x[i-1]).

Given that y[i] is much smaller than x[i], you'd need to put together
a lot of them to derive something, and that's distinctly harder than
a single-output preimage attack.

> I certainly wasn't saying padding was a requirment.  But I was trying to
> point out that the SHA-1 implementaion crrently in /dev/random by design is
> collision vulnerable.  Collision resistance isn't a requirment for its
> purposes obviously.

No, it is, by design, 100% collision-resistant.  An attacker neither
sees nor controls the input x, so cannot use a collision attack.
Thus, it's resistant to collisions in the same way that it's resistant
to AIDS.

[There's actually a flaw in my logic.  I know Ted knows about it, because
he implemented a specific defense in the /dev/random code against it; it's
just not 100% information-theoretic ironclad.  If anyone else can spot
it, award yourself a clue point.  But it's still not a plausible attack.]

FURTHERMORE, even if an attacker *could* control the input, it's still
exactly as collision resistant as unmodified SHA-1.  Because it only
accepts fixed-size input blocks, padding is unnecessary and irrelevant
to security.  Careful padding is ONLY required if you are working with
VARIABLE-SIZED input.

The fact that collision resistance is not a security requirement is a
third point.

> Guess my pointing this out is a lost cause.

In much the same way that pointing out that the earth is flat is a
lost cause.  If you want people to believe nonsense, you need to dress
it up a lot and call it a religion.

As for Ted's words:
> Whether or not we should trust the design of something as
> critical to the security of security applications as /dev/random to
> someone who fails to grasp the difference between these two rather
> basic issues is something I will leave to the others on LKML.

Fortuna may be a good idea after all (I disagree, but I can imagine
being persuaded otherwise), but it has a very bad advocate right now.
Would anyone else like to pick up the torch?


By the way, I'd like to repeat my earlier question: you say Fortuna ia
well-regarded in crypto circles.  Can you cite a single paper to back
that conclusion?  Name a single well-known cryptographer, other than
the authors, who has looked at it in some detail?

There might be one, but I don't know of any.  I respect the authors
enough to know that even they recognize that an algorithm's designers
sometimes have blind spots.
