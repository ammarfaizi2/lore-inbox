Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275593AbTHOARV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275595AbTHOARV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:17:21 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:17883 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S275593AbTHOARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:17:16 -0400
Date: Thu, 14 Aug 2003 18:17:13 -0600
From: Val Henson <val@nmt.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815001713.GD5333@speare5-1-14>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhgoj9$9ab$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 07:40:25PM +0000, David Wagner wrote:
> Val Henson  wrote:
> >Throwing away 80 bits of the 160 bit output is much better
> >than folding the two halves together.  In all the cases we've
> >discussed where folding might improve matters, throwing away half the
> >output would be even better.
> 
> I don't see where you are getting this from.  Define
>   F(x) = first80bits(SHA(x))
>   G(x) = first80bits(SHA(x)) xor last80bits(SHA(x)).
> What makes you think that F is a better (or worse) hash function than G?

See Matt Mackall's earlier post on correlation, excerpted at the end
of this message.  Basically, with two strings x and y, the entropy of
x alone or y alone is always greater than or equal to the entropy of x
xored with y.

entropy(x) >= entropy(x xor y)
entropy(y) >= entropy(x xor y)

If you have the goal of throwing away some information so that the
attacker can't guess the state of the pool (which I'm not entirely
sure I agree with), then it is better to throw away half the hash than
to xor the two halves together.

> I think there is little basis for discriminating between them.
> If SHA is cryptographically secure, both F and G are fine.
> If SHA is insecure, then all bets are off, and both F and G might be weak.

There's plenty of basis.  We have two goals:

1. Return as much random data as possible (maximize entropy).
2. Don't reveal the state of the entire pool.

Throwing away half the result is at least as good or better than
folding the result.  There is no way in which folding is better than
halving, and folding is demonstrably worse if SHA-1's output is
correlated across the two halves in any way (which is almost certainly
true).

-VAL

>From Matt Mackall:

Let's assume the simplest case of a two bit hash xy. "Patterns" here
are going to translate into a correlation between otherwise
well-distributed x and y. A perfectly uncorrelated system xy is going
to have two bits of entropy. A perfectly correlated (or
anti-correlated) system xy is going to have only 1 bit of entropy.

Now what happens when we fold these two bits together z=x^y? In the
uncorrelated case we end up with a well-distributed z. In the
correlated case, we end up with 0 or 1, that is z=x^x=0 or z=x^-x, and
we've eliminated any entropy we once had. If correlation is less than
100%, then we get somewhere between 0 and 1 bits of entropy, but
always less than if we just returned z=x or z=y. This argument
naturally scales up to larger variables x and y.
