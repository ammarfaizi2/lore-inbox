Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270835AbTHKCJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270846AbTHKCJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:09:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22405 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270835AbTHKCJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:09:47 -0400
Date: Mon, 11 Aug 2003 03:09:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com, tytso@mit.edu
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030811020919.GD10446@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810174528.GZ31810@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Ted T'so added to recipients because he wrote this thing :)]

Matt Mackall wrote:
> The idea with the folding was that we can cover up any systemic
> patterns in the returned hash by xoring the first half of the hash
> with the second half of the hash. While this might seem like a good
> technique intuitively, it's mathematically flawed.
> 
> Let's assume the simplest case of a two bit hash xy. "Patterns" here
> are going to translate into a correlation between otherwise
> well-distributed x and y. A perfectly uncorrelated system xy is going
> to have two bits of entropy. A perfectly correlated (or
> anti-correlated) system xy is going to have only 1 bit of entropy.
> 
> Now what happens when we fold these two bits together z=x^y? In the
> uncorrelated case we end up with a well-distributed z. In the
> correlated case, we end up with 0 or 1, that is z=x^x=0 or z=x^-x, and
> we've eliminated any entropy we once had. If correlation is less than
> 100%, then we get somewhere between 0 and 1 bits of entropy, but
> always less than if we just returned z=x or z=y. This argument
> naturally scales up to larger variables x and y.
> 
> Ok, so that explains taking out the xor. But I also return xy and not
> just x. With the former, every bit of input goes through SHA1 twice,
> once in the input pool, and once in the output pool, along with lots
> of feedback to foil backtracking attacks. In the latter, every output
> bit is going through SHA four times, which is just overkill. If we
> don't trust our hash to generate uniform, non-self-correlating output,
> running additional rounds does not guarantee that we aren't magnifying
> the problem. And it is of course making everything twice as expensive.

If you return xy, you are returning a strong digest of the pool state.
Even with the backtrack-prevention, if the attacker reads 20 bytes
from /dev/random and sees a _recognised_ pattern, they immediately
know the entire state of the secondary pool.

This can happen if, for example, a machine has just rebooted and
hasn't had time to collect much entropy since the initial state.

(In general, recognising the output of a cryptographic hash tells you
the input, because even though there are many possible inputs for that
output, it's far more likely that a systemic error is the cause of the
recognised output, rather than the cause being randomness).

This means that, for a short time after, they can predict further
output bits exactly.  "Catastrophic reseeding" from the primary pool
limits how many bits they can predict like this - unless, if they're
lucky, it tells them the state of the primary pool too.

When you output less of the hash, this reduces the information
available to predict the state of the pool.  However, SHA1 is large
enough that even half of the hash is a strong predictor, so returning
half of the hash still has this weakness.

(Ironically, a much weaker hash would prevent this mode of data leakage).

As far as I can tell, folding the hash result doesn't help, because
that simply creates a different kind of hash which can also be
recognised, and which is large enough to predict the pool state.

Which leaves...

I have just convinced myself of a flaw in the existing random.c -
which still holds in your patched version.  Folding the result of the
strong hash is useless.  Instead, the _input_ to the strong hash
should be folded, so that a single hash result (whether folded or not)
doesn't reveal the pool state even when it is recognised.

In other words, the hash should be calculated over fewer than all of
the pool bits each time.  The set of pool bits used, or how multiple
bits are folded, needs to be varied in such a way that many hash
results would need to be all recognised to determine the pool state.

I think this equivalent to saying that the effective hash function
needs to be weak enough not to reveal the pool state when it is
recognised, due to the pool state being recognisably "special"
(e.g. limited time after booting), while at the same time the hash
needs to be strong enough that it does not reveal the pool state when
the pool is random.

Enjoy,
-- Jamie
