Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSHSERq>; Mon, 19 Aug 2002 00:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSHSERq>; Mon, 19 Aug 2002 00:17:46 -0400
Received: from THANK.THUNK.ORG ([216.175.175.163]:34734 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S317742AbSHSERp>;
	Mon, 19 Aug 2002 00:17:45 -0400
Date: Mon, 19 Aug 2002 00:21:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020819042141.GA26519@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1029642713.863.2.camel@phantasy> <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com> <20020818053859.GM21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818053859.GM21643@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 12:38:59AM -0500, Oliver Xymoron wrote:
> On Sat, Aug 17, 2002 at 09:01:20PM -0700, Linus Torvalds wrote:
> > 
> > On 17 Aug 2002, Robert Love wrote:
> > > 
> > > [1] this is why I wrote my netdev-random patches.  some machines just
> > >     have to take the entropy from the network card... there is nothing
> > >     else.
> > 
> > I suspect that Oliver is 100% correct in that the current code is just
> > _too_ trusting. And parts of his patches seem to be in the "obviously
> > good" category (ie the xor'ing of the buffers instead of overwriting).
> 
> Make sure you don't miss this bit, I should have sent it
> separately. This is a longstanding bug that manufactures about a
> thousand bits out of thin air when the pool runs dry.

There's a reason why I did what I did here, and it has to do with an
attack which Bruce Schneier describes in his Yarrow paper:

	http://www.counterpane.com/yarrow-notes.html

called the "iterative guessing attack".  Assume that the adversary has
somehow knows the current state of the pool.  This could because the
initial state was known to the attacker, either because it was in a
known, initialized state (this could happen if the distribution
doesn't save the state of the pool via an /etc/init.d/random script),
or because the attacker managed to capture the initial seed file used
by the /etc/init.d/random script.  Now what the attacker can do is
periodically sample the pool, and attempt to explore all possible
values which have been mixed into the pool that would result in the
value which he/she read out of /dev/random.   

So in fact, by being more selective about which values get mixed into
the pool, you can actually help the iterative guessing attack!  That's
why the current code tries to mix in sufficient randomness to
completely reseed the secondary extraction pool, and not just enough
randomness for the number of bytes required.  This was a deliberate
design decision to try to get the benefits of Yarrow's "catastrophic
reseeding".

Your complaint in terms of "manufacturing about a thousand bits out of
thin air" is a fair one, but it depends on how you view things.  From
the point of view of absolute randomness, you're of course right.  If
the primary pool only has 100 bits of randomness, and
xfer_secondary_pool attempts to transfer 1100 bits of randomness, it
drains the primary pool down to 0, but credits the secondary pool with
1100 bits of randomness, and yes, we have "created" a thousand bits of
randomness.  

That being said though, from the adversary only gets to see results
pulled out of the secondary pool, and the primary pool is completely
hidden from the adversary.  So when xfer_secondary_pool extracts a
large amount of randomness from the primary pool, it's doing so using
extract_entropy(), which uses SHA to extract randomness from the
primary pool.  Significant amounts of cryptographic analysis (which
would also as a side effect break the SHA hash) would be required in
order to figure out information in the primary pool based solely on
the outputs that are being fed into the secondary pool.

So is it legitimate to credit the secondary pool with 1100 bits of
randomness even though the primary pool only had 100 bits of
randomness in it?  Maybe.  It depends on whether you care more about
"absolute randomness", or "cryptographic randomness".  Yarrow relies
entirely on cryptographic randomness; the effective size of its
primary and secondary pools are 160 bits and 112 bits, respectively. 

I tried to take a bit more of a moderate position between relying
solely on crypgraphic randomness and a pure absolute randomness model.
So we use large pools for mixing, and a catastrophic reseeding policy.

>From a pure theory point of view, I can see where this might be quite
bothersome.  On the other hand, practically, I think what we're doing
is justifiable, and not really a secucity problem.

That being said, if you really want to use your patch, please do it
differently.  In order to avoid the iterative guessing attack
described by Bruce Schneier, it is imperative that you extract
r->poolinfo.poolwirds - r->entropy_count/32 words of randomness from
the primary pool, and mix it into the secondary.  However, if you want
to save the entropy count from the primary pool, and use that to cap
the amount of entropy which is credited into the secondary pool, so
that entropy credits aren't "manufacturered", that's certainly
accepted.  It would make /dev/random much more conservative about its
entropy count, which might not be a bad thing from the point of view
of encouraging people to use it only for the creation of long-term
keys, and not to use it for generation of session keys.

						- Ted

P.S.  /dev/urandom should probably also be changed to use an entirely
separate pool, which then periodically pulls a small amount of entropy
from the priamry pool as necessary.  That would make /dev/urandom
slightly more dependent on the strength of SHA, while causing it to
not draw down as heavily on the entropy stored in /dev/random, which
would be a good thing.
