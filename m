Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290640AbSA3V7X>; Wed, 30 Jan 2002 16:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290641AbSA3V7P>; Wed, 30 Jan 2002 16:59:15 -0500
Received: from zeke.inet.com ([199.171.211.198]:3281 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S290640AbSA3V6z>;
	Wed, 30 Jan 2002 16:58:55 -0500
Message-ID: <3C586C8D.2C100509@inet.com>
Date: Wed, 30 Jan 2002 15:58:37 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Georg Nikodym <georgn@somanetworks.com>, Larry McVoy <lm@bitmover.com>,
        Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201301258180.2449-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
[snip]
> Now, after those arguments, I'll just finish off with saying that I
> actually agree with you to some degree - as I already said in private
> email to Larry, I would definitely also want to have a way of stopping
> back-merging at some point. In particular, when I'd tag a relase (ie
> something like Linux-2.5.3, I would potentially also want to set a
> "backmerge marker tag" which basically tells the backmerge logic that it's
> not worth it to try to backmerge past that version tag.
> 
> That would decrease the chance of confusion considerably, and it would
> also avoid the exponential complexity problem. Let's face it, exponential
> algorithms can be really useful, but you do want to have some way of
> making sure that the bad behaviour never happens in practice. A way of
> limiting the set of changelogs to be considered for backmerging not only
> means that humans don't get as confused, the computer also won't have to
> work insanely to try to go back to Linux version 0.01 if a small patch
> happened to apply all the way back.
> 
>                 Linus
[and earlier...]
> However, you are obviously correct that any changes are inherently
> dependent on the context those changes are in. And there are multiple
> contexts.

What about the design context?

I'm a bit concerned about the design-level inter-dependencies of
changesets that don't result in source-level dependencies.

Hypothetical situation:
Changeset adds driver for device Q.  Now, let's further suppose that in
2.5.x we have perfect modularity for drivers and at that time Q is
added... we just add a directory, linux/drivers/Qdrv.  It won't conflict
with 2.5, 2.4.x, 2.2.x, etc..  However, because 2.2.x does not have the
hooks necesary to see it, Q won't work on those kernels.  There is a
design-level dependency in changeset q.

This would be indirectly addressed with the 'backmerg marker tag', but I
have a nagging doubt.

Maybe a better example:
What about changing a global variable (say, from 'events' to
'global_events')?  You change it in the global place, yielding a
changeset.  Later, the individual users change the name.  But if an
individual user has seen very little change in the time before the
global_events change (and the global location has been changing a lot),
that patchset could backmerge beyond the global change.

Say 'f' was the global change, and 'g' was an individual change. 
Backmerge could yield:

        a -> b -> c -> f

                -> d

                -> e
          -> g

even though 'g' really depends on 'f'.

Thoughts?

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
