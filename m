Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290370AbSA3S0G>; Wed, 30 Jan 2002 13:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSA3SYh>; Wed, 30 Jan 2002 13:24:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290343AbSA3SYG>; Wed, 30 Jan 2002 13:24:06 -0500
Date: Wed, 30 Jan 2002 10:23:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130092529.O23269@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0201301005260.1989-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Larry McVoy wrote:
>
> There is a way to do this in BK that would work just fine.  It pushes some
> work back onto the developer, but if you are willing to do it, we have no
> problem doing what you want with BK in its current form and I suspect that
> the work is very similar to what you are already doing.

The thing is, bk should be able to do this on its own.

The rule on check-in should be: if the resultant changeset can be
automatically merged with an earlier changeset, it should be _parallel_ to
that changeset, not linear.

And note the "automatically merged" part. That still guarantees your
database consistency at all levels.

Let us assume that you have a tree that looks like

	a -> b -> c

together with modifications "d". Now, "bk ci" (or, because this is more
expensive than a plain "ci", you can call it "bk backmerge" or something,
and all sane people will just stop using "ci") should instead of doing a
plain

	a -> b -> c -> d

it would see how far back it can go with an automatic merge and add "d" at
the _furthest_ point possible. So let's assume that "d" really cannot be
merged with "b" but doesn't clash with "c", so what you'd create with "bk
backmerge" is the "maximally parallel version:

	a -> b -> c
		\
		 > d

Now, you'll say that this is exponentially expensive to do, and I agree.
But CPU-time is cheap, and notice that this "backmerge" would be done not
in one centralized location, but in parallel at different developers.

(Yeah, my example may look "cheap", but if you do exclusively backmerging,
then after a while your trees will have lots of very wide development, and
the m,ore interesting backmerge is when you already have

	a -> b -> c -> f

		-> d

		-> e

and you're adding "g", and it doesn't merge with "c" but not with "d" and
"e", so you have to test every path backwards to see where you can push
it. In this case you'd end up with

	a -> b  -> c -> f

		     -> g

		-> d

		-> e

kind of tree.)

Just how expensive would that be? I'd be willing to make my machine sweat
a bit, if it would just automatically generate the most parallel
changesets possible.. And I bet you could do _this_ fairly easily if you
didn't care too much about trying to be too efficient.

You're saying your merges are perfect. USE that knowledge, and make it do
"bk backmerge".

(Once you do backmerge, the false dependencies no longer exist, AND
suddenly "bk" actually gives people information that they didn't have
before: the revision history actually tells you the _true_ dependencies in
the tree, not some stupid "this is the order in which things were checked
in" stuff that doesn't add any value that can't be seen from the changeset
directly)

Larry, give me that, and I'll promise to use bk exclusively for two months
to shake it out..

		Linus

