Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUIXM5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUIXM5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268729AbUIXM5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:57:10 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:14264 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S268726AbUIXMz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:55:26 -0400
Date: Fri, 24 Sep 2004 08:54:57 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Message-ID: <20040924125457.GO28317@certainkey.com>
References: <20040923234340.GF28317@certainkey.com> <20040924043851.GA3611@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924043851.GA3611@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 12:38:51AM -0400, Theodore Ts'o wrote:
> I've taken a quick look at your patch, and here are some problems with it.
> 
> 
> 0.  Code style issues
> 
> Take a look at /usr/src/linux/Documentation/CodingStyle, ...

Will-do.  My bad.


> 1.  Don't leave out-of-date comments behind.  
> 
> Your patch makes significant changes, but you haven't updated the
> comments to reflect all of your changes. ...

> 
> 2.  The kernel will break if CONFIG_CRYPTO is false
> matter what.  This was a design decision that was made long ago, to
> simplify user space applications that could count on /dev/random ...

My naive point of view tells me either this design decision from days of
yore was not thought out properly (blasphemy!), or the cryptoapi needs to
be in kernel.

A compromise would be to have a primitive PRNG in random.c is no
CONFIG_CRYRPTO is present to keep things working.

> 3.  The TCP sequence numbers are broken

I see.  I'll make the change.  Thank you.

> As far as the Fortuna generator being "better", it really represents a
> philosophical divide between what I call Crypto academics" and "Crypto
> engineers".  I won't go into that whole debate here, except to note
> that the current /dev/random was designed with close consultation with
> Colin Plumb, who wrote the random number generator found in PGP, and
> indeed /dev/random is very close to that used in PGP.  In discussions
> on sci.crypt, there were those who argued on both side of this issue,
> with such notables as Peter Gutmann lining up against Jean-Luc.

Agreed.  This is why I've been dreading in posting the patch here.  The
current /dev/random is good, possibly the best OS-level RNG out there
right now.  Ted, if I've never said it before or ever again, you've done
a great job.  But my first impressions when I dove in were:
 - gah!  Why did someone go through so much trouble to make this hard to
   analyse?
 - humm, why not use the cryptoapi if we want random data?
 - why do linux users want information secure random numbers?  Wouldn't
   crypto-secure random numbers be what they really want?
  + this, I've learned, is not something you can argue well against.  It's
    a matter of taste ... like Brittany Spears.

I wanted something more structured running on my machines so I re-wrote
random.c to use Fortuna, no entropy estimators, and uses the cryptoapi.

For the record, I believe David Wagner saw the case for replacing the PRNG
with Fortuna holding water.  Even removing the entropy estimator.  But
coneeded that some people will want /dev/random to block, so let them eat
cake.

> >   + Removed entropy estimation
> >    - Fortuna doesn't need it, vanilla-/dev/random and other Yarrow-like
> >      PRNGs do to survive state compromise and other attacks.
> 
> Entropy estimation is a useful concept in that it attempts to limit
> possible attacks caused by weaknesses in the crypto algorithms (such
> what happened at this year's Crypto's conference, where MD4, MD5,
> HAVAL, and SHA-0 were all weakened).  The designed used by PGP and
> /dev/random both limit the amount of reliance placed in the crypto
> algorithms, where as Fortuna and Yarrow both assume that crypto
> primitives are 100% strong.  This is again a philosophical divide;
> given that we have access to unpredicitability based on hardware
> timings, we should limit the dependence on crypto algorithsm and to
> design a system that is closer to "true randomness" as possible.  

What if I told the SHA-1 implementation in random.c right now is weaker
than those hashs in terms of collisions?  The lack of padding in the
implementation is the cause.  HASH("a\0\0\0\0...") == HASH("a") There
are billions of other examples.

The academic vs. engineer analogy works the other way as well.  Fortuna's
security can be directly reduced to the security of the underlying
algorithms.  This is a good thing.  If the security of all applications
were reduced in the same way, the world would be a safer place (political
discussions not withstanding).

Vanilla random.c depends on SHA-1 be to be resistant to 1-st pre-image
attacks.  Fortuna depends on this as well with SHA-256 (or whatever
other hash you put in there).  The "folding over with XOR" method you
use to make random.c stronger can work against you as well.  It comes
down to "I've changed SHA-1 to make it stronger".  The logic question
becomes: "Then why doesn't everyone use it?"

JLC
