Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSHREYU>; Sun, 18 Aug 2002 00:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSHREYU>; Sun, 18 Aug 2002 00:24:20 -0400
Received: from waste.org ([209.173.204.2]:61408 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318844AbSHREYT>;
	Sun, 18 Aug 2002 00:24:19 -0400
Date: Sat, 17 Aug 2002 23:28:18 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818042818.GG21643@waste.org>
References: <20020818021522.GA21643@waste.org> <Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:05:55PM -0700, Linus Torvalds wrote:
> 
> On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> 
> >  To protect against back to back measurements and userspace
> >  observation, we insist that at least one context switch has occurred
> >  since we last sampled before we trust a sample.
> 
> This sounds particularly obnoxious, since it is entirely possible to have 
> an idle machine that is just waiting for more entropy, and this will mean 
> (for example) that such an idle machine will effectively never get any 
> more entropy simply because your context switch counting will not work.

My presumption here is that entropy sources such as mouse and keyboard
will trigger plenty of context switches. I did in fact instrument
this, and cases where samples were not accounted as entropy were less
than 1%. But they were still mixed in.

> This is particularly true on things like embedded routers, where the 
> machine usually doesn't actually _run_ much user-level software, but is 
> just shuffling packets back and forth. Your logic seems to make it not add 
> any entropy from those packets, which can be _deadly_ if then the router 
> is also used for occasionally generating some random numbers for other 
> things.

This analysis actually all stems from some work I did for an embedded
(non-Linux) router.

Note that we currently don't use network traffic for entropy except
for a few MCA cards. 

> Explain to me why I should consider these kinds of draconian measures 
> acceptable? It seems to be just fascist and outright stupid: avoiding 
> randomness just because you think you can't prove that it is random is not 
> very productive.

This approach still mixes in the very same data, regardless of whether
it decided to trust it or not. So it's not avoiding randomness, it's
just being picky about accounting it.
 
Let's be clear what entropy measurement is useful for. In the case
where your PRNG's initial state is as hard to guess as inverting the
hash function its using or breaking the cipher you're using it for,
reseeding with entropy is just icing on the cake. Given that we've got
up to 4kbits of initial state, a 160-bit+ hashing function, and are
generally using this with 128-bit keys, or generating 30 odd bits of
sequence number, it buys us nothing. Where it buys us something is
generating large public keys.

Now there's currently an orthogonal problem that /dev/urandom can
deplete /dev/random's entropy pool entirely and things like generating
sequence numbers get in the way. I intend to fix that separately. 

> We might as well get rid of /dev/random altogether if it is not useful. 

If it's not accounting properly, it's not useful.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
