Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269575AbTHOWCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTHOWCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:02:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56705 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S269575AbTHOWCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:02:33 -0400
Date: Fri, 15 Aug 2003 23:02:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Val Henson <val@nmt.edu>,
       David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815220211.GA19707@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815150324.GX325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815150324.GX325@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> Val left out the assumption that x and y are already perfectly
> distributed, in and of themselves.

That is equivalent to saying all the bits in x are independent of each
other, and the same for y.

It is not correct to assume that, and at the same time consider a
non-zero correlation between specific pairs of bits in x and y to
prove your result.

This is why:

There may be correlation between different bits of SHA output, but if
so they are a just as likely, a priori, between any pairs of bits.

Your assumption is that bits in x are independent of each other, and
unpredictable, and the same for y, yet there may be correlations
between the n'th bit of x and n'th bit of y for 0<=n<=79.

Given that, and the existence of a non-zero correlation:

    entropy(x xor y) < entropy(x)
    entropy(x xor y) < entropy(y)

Which justifies dropping half the bits instead of folding.

But wait!

Why should we drop the second 80 bits, instead of (say) every other bit?
All the bits from SHA are equivalent, right?

So, let's define some permutations.  Remember, x and y are 80 bits wide.

    a = [ x[ 0..39], y[ 0..39] ]
    b = [ x[40..79], y[40..79] ]

Now, making exactly the same assumptions (x is perfectly distributed,
y the same), considering the same possible non-zero correlation (n'th
bit of x with n'th bit of y for any 0<=n<=79), we see it is _possible_
for the following to be true, although these assumptions alone don't
make it so:

    entropy(a xor b) > entropy(a)    (is possible)
    entropy(a xor b) > entropy(b)    (is possible)

This is because of the dependence between bits _within_ a or b,
causing entropy(a) < entropy(x) or entropy(b) < entropy(x).  Whereas
entropy(a xor b) = entropy(x) if x[n] is independent of y[n'] for
40<=n<=79 and 40<=n'<=79, which is one additional assumption that can
make the above statement true.

Having just shown that, within the assumptions which prove entropy(x
xor y) < entropy(x), it is possible to have entropy(a xor b) >
entropy(a), where [a,b] is a permutation of [x,y], we see:

  Your assumptions imply you should drop certain bits instead of other
  bits, otherwise dropping can be worse than folding.

This is clearly absurd :)


Eh?
---

The reasoning error is to assume that certain pairs of bits are
independent and entertain the possibility of certain other pairs of
bits being dependent.

Of course bias in choosing those pairs favours one way of reducing the
hash output compared with another.

When you remove the bias?  Now that is a more interesting question.

Perhaps you can show that dropping is better than folding, given no
bias in your correlation assumptions, but I don't see that in the
claim quoted at the start of this message.


Enjoy,
-- Jamie
