Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbTCHXyo>; Sat, 8 Mar 2003 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTCHXyo>; Sat, 8 Mar 2003 18:54:44 -0500
Received: from bitmover.com ([192.132.92.2]:55179 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262314AbTCHXyl>;
	Sat, 8 Mar 2003 18:54:41 -0500
Date: Sat, 8 Mar 2003 16:05:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: Zack Brown <zbrown@tumblerings.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030309000514.GB1807@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Zack Brown <zbrown@tumblerings.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com> <20030308225252.GA23972@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308225252.GA23972@renegade>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Give it up.  BitKeeper is simply superior to CVS/SVN, and will stay that
> > way indefinitely since most people don't seem to even understand _why_
> > it is superior. 
> 
> You make it sound like no one is even interested ;-). But it's not true! A
> lot of people currently working on alternative version control systems would
> like very much to know what it would take to satisfy the needs of kernel
> development. Maybe, being on the inside of the process and well aware of
> your own needs, you don't realize how difficult it is to figure these things
> out from the outside. I think only very few people (perhaps only one) really
> understand this issue, and they aren't communicating with the horde of people
> who really want to help, if only they knew how.

[Long rant, summary: it's harder than you think, read on for the details]

There are parts of BitKeeper which required multiple years of thought by
people a lot smarter than me.  You guys are under the mistaken impression
that BitKeeper is my doing; it's not.  There are a lot of people who
work here and they have some amazing brains.  To create something like
BK is actually more difficult than creating a kernel.

To understand why, think of BK as a distributed, replicated, version
controlled user level file system with no limits on any of the file system
events which may happened in parallel.  Now put the changes back together,
correctly, no matter how much parallelism there has been.  Pavel hasn't
understood anything but a tiny fraction of the problem space yet, he
just doesn't realize it.  Even Linus doesn't know how BitKeeper works,
we haven't told him and I can tell from his explanations that he gets
part of it but not most of it.  That's not a slam on Linus or Pavel or
anyone else.  I'm just trying to tell you guys that this stuff is a lot
harder than you think.  I've told people that before, like the SVN and
OpenCM guys, and the leaders of both those efforts showed up later and
said "yup, you're right, it is a hell of a lot harder than it looks".
And they are nowhere near being able to do what BK does.  Ask them if
you have doubts about what I am saying.

Merging is just one of the complex areas.  It gets all the attention
because it is hard enough but easy enough that people like to work on it.
It's actually fun to work on merging.  Ditto for the graph structure,
that's trivial.  The other parts aren't fun and they are more difficult
so they don't get talked about.  But they are more important because
the user has no idea how to deal with them and users do know how to deal
with merge problems, lots of you understand patch rejects.

Rename handling in a distributed system is actually much harder than
getting the merging done.  It doesn't seem like it is, but we've rewritten
how we do it 3 times and are working on a 4th all because we've been
forced to learn about all the different ways that people move things
around.  CVS doesn't have any of the rename problems because it doesn't
do them, and SVN doesn't have 1/1000th of the problems we do because it
is centralized.  Centralized means that there is never any confusion
about where something should go, you can only create one file in one
directory entry because there is only one directory entry available.
In BK's case, there can be an infinite number of different files which
all want to be src/foo.c.

Symbolic tags are really hard.  What?!?  What could be easier than adding
a symbolic label on a revision?  Well, in a centralized system it is
trivial but in a distributed system you have to handle the fact that
the same symbol can be put on multiple revs.  It's the same problem as
the file names, just a variation.  Add to that the fact that time can
march forward or backwards in a distributed system, even if all the
events were marching forward, and the fun really starts.  I personally
have redone the tags support about 6 times and it still isn't right.

Security semantics are hard in a distributed system.  Where do you
put them, how do you integrate them into the system, what happens when
people try and work around them?  In CVS or SVN you can simply lock down
the server and not worry about it, but in BK, the user has the revision
history and they are root, they can do whatever they want.

Time semantics are the hardest of all.  You simply can't depend on time
being correct.  It goes forwards, backwards, and sideways on you and
if you think you can use time you don't have the slightest idea of the
scope of the problem.  Again, not a problem for CVS/SVN/whatever, all the
deltas are made against the same clock.  Not true in a distributed system.

That's a taste of what it is like.  You have to get all of those right
and the many other ones that I didn't tell you about or you might as
well not bother.  Why?  Because the problems are very subtle and there
isn't any hope of getting an end user to figure out a subtle problem,
they don't have the time or the inclination.  We've seen users throw away
weeks of work just because they didn't understand the merge conflict so
they start over on an updated tree.  And those people will understand
the rename corner cases?  Not a chance.

The main point here is that if you think that BK happened quickly,
by one guy, you are nuts.  It started in May of 1997, that's almost 6
years ago, not the 2 years that Pavel thinks, and I had already written
a complete version control system prior to that, so this was round two.
Even with that knowledge, I wasn't near enough to get BK to where it is
today, there is more than 40 man years of effort in BK so far.  A bunch
of people, working 60-90 hour weeks, for almost 6 years.  Not average
people, either, any one of these people would be a staff engineer or
better at Sun (salaries for those people are in the $115K - $140K range).

The disbelievers think that I'm out here waving the "it's too hard"
flag so you'll go away.  And the arrogant people think that they are
smarter than us and can do it quicker.  I doubt it but by all means go
for it and see what you can do.  Just file away a copy of this and let
me know what you think three or four years from now.  

Oh, by the way, you'll need a business model, I found that out 2 or 3
years into it when my savings ran out.  Oh, my, you might not be able
to GPL it!  Why it might even end up being just like BitKeeper with
an evil corporate dude named Pavel running the show.  Believe me, if
that happens, I'll be here to rake him over the coals on a daily basis
for being such an evil person who doesn't understand the point of free
software.  I can't wait.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
