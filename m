Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWAJTaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWAJTaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWAJTaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:30:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbWAJTaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:30:11 -0500
Date: Tue, 10 Jan 2006 11:28:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Martin Langhoff <martin.langhoff@gmail.com>,
       Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: git pull on Linux/ACPI release tree
In-Reply-To: <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601101111110.4939@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jan 2006, Linus Torvalds wrote:
> 
> Now, the git history is _not_ really a two-dimensional surface, so it's 
> just an analogy, not an exact identity. But from a visualization 
> standpoint, it's a good way to think of each "git bisect" as adding a 
> _line_ on the surface rather than a point on a linear line.

Actually, the way I think of it is akin to the "light cones" in physics. A 
point in space-time doesn't define a fully ordered "before and after": but 
it _does_ describe a "light cone" which tells you what is reachable from 
that point, and what that point reaches. Within those cones, that 
particular point ("commit") has a strict ordering.

And exactly as in physics, in git there's a lot of space that is _not_ 
ordered by that commit. And the way to bisect is basically to find the 
right points in "git space" to create the right "light cone" that you 
find the point where the git space that is reachable from that commit has 
the same volume as the git space that isn't reachable.

And maybe that makes more sense to you (if you're into physics), or maybe 
it makes less sense to you.

Now, since we always search the "git space" in the cone that is defined by 
"reachable from the bad commit, but not reachable from any good commit", 
the way we handle "bad" and "good" is actually not a mirror-image. If we 
fine a new _bad_ commit, we know that it was reachable from the old bad 
commit, and thus the old bad commit is now uninteresting: the new bad 
commit forms a "past light cone" that is a strict subset of the old one, 
so we can totally discard the old bad commit from any future 
consideration. It doesn't tell us anything new.

In contrast, if we find a new _good_ commit, the "past light cone" (aka 
"set of commits reachable from it") is -not- necessarily a proper superset 
of the previous set of good commits, so when we find a good commit, we 
still need to carry the _other_ good commits around, and the "known good" 
universe is the _union_ of all the "good commit past lightcones".

Then the "unknown space" is the set difference of the "past lightcone of 
the bad commit" and of this "union of past lightcones of good commits". 
It's the space that is reachable from the known-bad commit, but not 
reachable from any known-good commit.

So this means that when doing bisection, what we want to do is find the 
point in git space that has _new_ "reachability" within that unknown space 
that is as close to half that volume as space as possible. And that's 
exactly what "git-rev-list --bisect" calculates.

So every time, we try to either move the "known bad" light-cone down in 
time in the unknown space, _or_ we add a new "known good" light-cone. In 
either case, the "unknown git space" keeps shrinking by half each time.

("by half" is not exact, because git space is not only quanticized, it 
also has a rather strange "distance function". In other words, we're 
talking about a rather strange space. The good news is that the space is 
small enough that we can just enumerate every quantum and simply 
calculate the volume it defines in that space. IOW, we do a very 
brute-force thing, and it works fine).

			Linus
