Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290615AbSA3VS7>; Wed, 30 Jan 2002 16:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290611AbSA3VSy>; Wed, 30 Jan 2002 16:18:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52486 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290606AbSA3VS3>; Wed, 30 Jan 2002 16:18:29 -0500
Date: Wed, 30 Jan 2002 13:17:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Georg Nikodym <georgn@somanetworks.com>
cc: Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <1012419503.1460.68.camel@keller>
Message-ID: <Pine.LNX.4.33.0201301258180.2449-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Jan 2002, Georg Nikodym wrote:
>
> The thing that's missing here is that 'g' (or 1.7) doesn't just refer to
> the change that is 'g'.  It's actually a label that implies a point in
> time as well as all the change that came before it.  Stated differently,
> it is a set.

I disagree.

"g" is really just one thing: it is "the changes".

However, you are obviously correct that any changes are inherently
dependent on the context those changes are in. And there are multiple
contexts.

One context is simply the "when in time" context, which is interesting, as
when you serialize all changesets you see the time-wise development. And
this is really the _only_ context that BK (and most other source control
tools) really think about.

However, in another sense, the "when in time" context is completely
meaningless. Should you care what the _temporal_ relationship between two
independent patches is? I say "Absolutely not!". The temporal relationship
only hides the _real_ revision information, which is what the patch
actually depends on.

And note that my suggestion to have a "bk backmerge" does not remove the
temporal relationships. All changesets already have a timestamp (they
clearly have to have it, just so that you can see when they happened and
say "what did this tree look like one month ago?"). So we already _have_
the temporal information, and encoding that temporal information into the
"relationship" information actually ends up costing you quite dearly.

I'd say that most (maybe all) of the complaints about not being able to
apply changesets in any random order comes exactly from the fact that
developers _know_ that temporal relationships are often not relevant. From
a development standpoint, temporal relationships are only relevant if they
match the _causal_ relationships, and even then you can often find patches
that are _caused_ by previous patches, but that are valid on their own
(and can indeed be more important, or even completely obviate the need for
the original patch).

So what I'm saying is that from a patch revision standpoint, temporal
information is useless. You still have enough information to recreate the
tree "at time 'g'" by just doing the equivalent of "bk get -c<date-of-g>".

See?

> You, as the center of the known universe may not need to concern
> yourself with such trifles, but speaking as one of those fabled
> commercial customers, the ability to say unambiguously say what's been
> changed (read: fixed) is really important.

But you don't lose that ability. You still have all the information you
used to have, you just have even _more_ information. You have the
information on notjust when the change was checked in (temporal), you have
the information on what files/changes it really _depended_ on.

Now, after those arguments, I'll just finish off with saying that I
actually agree with you to some degree - as I already said in private
email to Larry, I would definitely also want to have a way of stopping
back-merging at some point. In particular, when I'd tag a relase (ie
something like Linux-2.5.3, I would potentially also want to set a
"backmerge marker tag" which basically tells the backmerge logic that it's
not worth it to try to backmerge past that version tag.

That would decrease the chance of confusion considerably, and it would
also avoid the exponential complexity problem. Let's face it, exponential
algorithms can be really useful, but you do want to have some way of
making sure that the bad behaviour never happens in practice. A way of
limiting the set of changelogs to be considered for backmerging not only
means that humans don't get as confused, the computer also won't have to
work insanely to try to go back to Linux version 0.01 if a small patch
happened to apply all the way back.

		Linus

