Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSHRCzQ>; Sat, 17 Aug 2002 22:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSHRCzP>; Sat, 17 Aug 2002 22:55:15 -0400
Received: from waste.org ([209.173.204.2]:46809 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318806AbSHRCzP>;
	Sat, 17 Aug 2002 22:55:15 -0400
Date: Sat, 17 Aug 2002 21:59:13 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818025913.GF21643@waste.org>
References: <20020818021522.GA21643@waste.org> <Pine.LNX.4.44.0208171923330.1310-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208171923330.1310-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 07:30:02PM -0700, Linus Torvalds wrote:
> 
> On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> > 
> > Net effect: a typical box will claim to generate 2-5 _orders of magnitude_
> > more entropy than it actually does. 
> 
> On the other hand, if you are _too_ anal you won't consider _anything_ 
> "truly random", and /dev/random becomes practically useless on things that 
> don't have special randomness hardware.
> 
> To me it sounds from your description that you may well be on the edge of 
> "too anal". Real life _has_ to be taken into account, and not accepting 
> entropy because of theoretical issues is _not_ a good idea.

There are exactly two cases:

a) you care about entropy accounting being done right
b) /dev/urandom is good enough

Note that these patches allow you to satisfy folks in a) while mixing
in _more_ data for b).
 
> Quite frankly, I'd rather have a usable /dev/random than one that runs out
> so quickly that it's unreasonable to use it for things like generating
> 4096-bit host keys for sshd etc.

Let me clarify that 2-5 orders thing. The kernel trusts about 10 times
as many samples as it should, and overestimates each samples' entropy
by about a factor of 10 (on x86 with TSC) or 1.3 (using 1kHz jiffies).

The 5 orders comes in when the pool is exhausted and the pool xfer
function magically manufactures 1024 bits or more the next time an
entropy bit (or .1 or 0 entropy bits, see above) comes in.

> In particular, if a machine needs to generate a strong random number, and 
> /dev/random cannot give that more than once per day because it refuses to 
> use things like bits from the TSC on network packets, then /dev/random is 
> no longer practically useful.

My box has been up for about the time it's taken to write this email
and it's already got a full entropy pool. A 4096-bit public key has
significantly less than that many bits of entropy in it (primes thin
out in approximate proportion to log2(n)). 

> So please also do a writeup on whether your patches are _practical_. I 
> will not apply them otherwise.

The patches will be a nuisance for anyone who's currently using
/dev/random to generate session keys on busy SSL servers. But again,
with the old code, they were fooling themselves anyway. /dev/urandom
is appropriate for such applications, and this patch allows giving it
more data without sacrificing /dev/random.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
