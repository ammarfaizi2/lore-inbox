Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286691AbRL1C1h>; Thu, 27 Dec 2001 21:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286693AbRL1C11>; Thu, 27 Dec 2001 21:27:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35313 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286691AbRL1C1R>;
	Thu, 27 Dec 2001 21:27:17 -0500
Date: Thu, 27 Dec 2001 21:27:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
In-Reply-To: <20011227123344.H25698@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0112272026390.1324-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Dec 2001, Larry McVoy wrote:

> But this didn't answer my question at all.  My question was why is this a 
> problem related to a source management system?  I can see how to exactly
> mimic what described Al doing in BK so if that is the definition of goodness,
> the addition (or absence) of a SCM doesn't seem to change the answer.

Urgh.  Let me describe what I'm using internally:

	a) main object is mutating tree of changesets.
	b) each changeset is either very local or a global search-and-replace
job _and_ _nothing_ _else_.
	c) main operations: insert empty changeset, modify changeset and
ripple the changes forth, collapse changeset.
	d) changesets are stored as patches _and_ set of trees cp -rl'ed
and patched from the baseline.  Patches are the stable form.  Trees are created
from them by a script, another one rediffs the trees.
	e) for obvious reasons these trees are never edited.  cp -a, edit
the copy, diff and possibly apply it (or its pieces) to original trees.
Then recreate changesets.
	f) when it's time to port to new baseline, I drop the applied
changesets and recreate the trees from the rest.  Then rediff.  Notice
that due to (b) it's _easy_.

	And yes, I deliberately avoid mixing global changes with local ones.
To the point of massaging the code with small changes so that the rest could
be done as a global replacement.  Do one thing and do it well, and all such...

	It's extra work, but it makes both testing and merges trivial. And
that work includes reordering changesets/massaging them (BTW, reordering is
done as adding empty changeset, pulling changes I want into it and rippling
them forth; then collapsing the old one).

	The real difference from BK is that history and tree of changesets
are independent things.  It's not a "growing tree", it's "changing tree of
changesets and its previous forms".  

	Frankly, I'm not too interested in making merges easy.  They _are_
easy if you follow a pretty simple self-discipline.  And following it has
a lot of very obvious benefits.

	BTW, stuff usually goes to Linus in series of 5-10 changesets.
I've put the 2.4 backport of 2.5.0--2.5.1 stuff on ftp.math.psu.edu/pub/viro -
S17-rc1*.tar.gz (three groups).  That's how it looks like - backporting
changesets was damn trivial and they _are_ 2.4-mergable.  Yup, 34 chunks.
When I will be able to do that with BK (both backport _and_ get them into
the form when they are obviously correct; the latter took a lot of PITA, esp.
the last 14 chunks) - you've got one more user.  What's more, the rest of
namespaces patch (things that went into 2.5.2-pre{1,2}) is also 2.4-mergable.
In the peak the damn thing gave 200-odd kilobytes of combined patch.  It
got gradually merged into -STABLE, for fsck sake.  With no public casualties
(iput fuckup in 2.4.15 was an unrelated patch, but there was an idiotic bug
that slipped into the patches sent to Linus and ate his tree - missed
list_del() in a bad place ;-)  And it involved complete rewrite of fs/super.c -
including change of allocation rules, locking, etc.  The worst part was
~20 changesets with size of combined patch ~20Kb and sum of individual patch
sizes - about 3 times more than that.  Live neurosurgery on core code with
no breakage in process...  The only reason why I was able to pull that off
was the changeset massage/reordering/etc. - I'm no fscking genius and no
merge helpers in the world would help here.

	If you can split your patch into sequence of obvious changesets -
merge will be easy.  If you can't - you are fucked anyway.

PS: before anybody[1] starts whining about extra work - too soddin' bad,
it _is_ part of job, as far as I'm concerned.  Avoiding it invariably gives
us a mess - it's not like it never happened [2]

[1] names withheld to protect the guilty
[2] patch names <<--->>

