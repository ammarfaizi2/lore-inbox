Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318749AbSHSMfk>; Mon, 19 Aug 2002 08:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSHSMfk>; Mon, 19 Aug 2002 08:35:40 -0400
Received: from waste.org ([209.173.204.2]:28902 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318749AbSHSMfi>;
	Mon, 19 Aug 2002 08:35:38 -0400
Date: Mon, 19 Aug 2002 07:39:37 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020819123937.GA14427@waste.org>
References: <1029642713.863.2.camel@phantasy> <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com> <20020818053859.GM21643@waste.org> <20020819042141.GA26519@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020819042141.GA26519@think.thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 12:21:41AM -0400, Theodore Ts'o wrote:
> On Sun, Aug 18, 2002 at 12:38:59AM -0500, Oliver Xymoron wrote:
> > On Sat, Aug 17, 2002 at 09:01:20PM -0700, Linus Torvalds wrote:
> > > 
> > > On 17 Aug 2002, Robert Love wrote:
> > > > 
> > > > [1] this is why I wrote my netdev-random patches.  some machines just
> > > >     have to take the entropy from the network card... there is nothing
> > > >     else.
> > > 
> > > I suspect that Oliver is 100% correct in that the current code is just
> > > _too_ trusting. And parts of his patches seem to be in the "obviously
> > > good" category (ie the xor'ing of the buffers instead of overwriting).
> > 
> > Make sure you don't miss this bit, I should have sent it
> > separately. This is a longstanding bug that manufactures about a
> > thousand bits out of thin air when the pool runs dry.
> 
> There's a reason why I did what I did here, and it has to do with an
> attack which Bruce Schneier describes in his Yarrow paper:
> 
> 	http://www.counterpane.com/yarrow-notes.html
> 
> called the "iterative guessing attack".  Assume that the adversary has
> somehow knows the current state of the pool.

Yes, I understand the catastrophic reseeding, I've read that and a
few other of his papers on PRNGs.

> I tried to take a bit more of a moderate position between relying
> solely on crypgraphic randomness and a pure absolute randomness model.
> So we use large pools for mixing, and a catastrophic reseeding policy.
> 
> >From a pure theory point of view, I can see where this might be quite
> bothersome.  On the other hand, practically, I think what we're doing
> is justifiable, and not really a secucity problem.

That's certainly a reasonable approach (to the extent that all the
attacks we know of are purely theoretical), but a) it's not the
impression one gets from the docs and b) I think we can easily do better.
 
> That being said, if you really want to use your patch, please do it
> differently.  In order to avoid the iterative guessing attack
> described by Bruce Schneier, it is imperative that you extract
> r->poolinfo.poolwirds - r->entropy_count/32 words of randomness from
> the primary pool, and mix it into the secondary.

Ah, I thought we were relying on the extract_count clause of the xfer
function to handle this, the first clause just seemed buggy. I'm not
quite convinced that this isn't sufficient. Do you see a theoretical
problem with that?

It certainly doesn't hurt to transfer a larger chunk of data from the
primary pool (and I'll update my patch to reflect this), but if it
says there are only 8 bits of entropy there, we should only tally 8
bits of credit in the secondary pool. With the current behavior, you
can do 'cat /dev/random | hexdump', wait for it to block, hit a key or
two, and have it spew out another K of data. I think this goes against
everyone's expectations of how this should work.

> P.S.  /dev/urandom should probably also be changed to use an entirely
> separate pool, which then periodically pulls a small amount of entropy
> from the priamry pool as necessary.  That would make /dev/urandom
> slightly more dependent on the strength of SHA, while causing it to
> not draw down as heavily on the entropy stored in /dev/random, which
> would be a good thing.

Indeed - I intend to take advantage of the multiple pool flexibility
in the current code. I'll have a third pool that's allowed to draw
from the primary whenever it's more than half full. Assuming input
entropy rate > output entropy rate, this will make it exactly as
strong as /dev/random, while not starving /dev/random when there's a
shortage.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
