Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316927AbSE3XUm>; Thu, 30 May 2002 19:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSE3XUl>; Thu, 30 May 2002 19:20:41 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:24541 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316927AbSE3XUi>;
	Thu, 30 May 2002 19:20:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: KBuild 2.5 Impressions
Date: Fri, 31 May 2002 01:19:27 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200205302155.g4ULtEb09500@buggy.badula.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DZCa-0007hI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 May 2002 23:55, Ion Badulescu wrote:
> On Thu, 30 May 2002 11:45:14 +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > I have only one point on the curve, but it confirms what Keith has
> > been saying.  The incremental build speed is especially important to
> > me.  If I were working all the time on 2.5 - sadly, I'm not - I would
> > without question be using kbuild 2.5 simply by reason of the fast
> > incremental builds.
> 
> There _are_ good things in kbuild25, no question about it, but that's
> not a good enough reason to import it wholesale. Especially since Kai
> has proven (and continues to do so) that it's possible to improve the
> existing build system, to cherry-pick good features from kbuild2.5 
> and add them to kbuild24.
> 
> > There is no Python anywhere to be seen in kbuild 2.5, for those who
> > worry about that.  It is coded in C, about 10,000 lines it seems.
> > It has a simple built in database which I suppose accounts for some
> > of that.  For what it does, it seems quite reasonable.
> 
> Are YOU willing to maintain it if Keith abandons it, though?

That is pure FUD, shame on you.

> That's the biggest problem of kbuild25: maintainability of the
> configure+make replacement that Keith is using. Enough people know
> make and makefiles that the existing system can be fixed or at least
> made to work reasonably well. Not the same thing can be said about
> the 10000-line brand-new make augmenter in kbuild25.

It's quite readable and understandable.  I must say I find it easier
to comprehend than the current system.  Part of that is the extensive
documentation and another part is that appears to be well thought out
and constructed according to sound software engineering principles.

> > The output that kbuild 2.5 generates is a vast improvment over old
> > make.  It's enough to see the progress of the make, while not
> > obscuring the warnings.  This by itself should help in cleaning up
> > the tree.
> 
> If you read Kai's mail, he was actually asking whether this is a
> desirable feature to add to kbuild. You don't need kbuild25 for it.

It is one of many things that are improved in kbuild 2.5.  What about
the speed and reliability?  Old kbuild has got so far to go there,
are we supposed to wait while more years pass in the hope that it will
ever catch up to what already exists in kbuild 2.5?

What I do not appreciate about Kai's effort is that it is divisive.
We already have a clearly better solution, and Kai is holding out the
hope that somehow the old ugly duckling will turn into a beautiful
swan.  Meanwhile, countless hours of build time alone are going
straight down the drain.  Did you see the part in my previous post
about the 41% improvement in incremental build speed?  Do you think
Kai has any chance of achieving that?  Or are you willing to wait
years while he builds kbuild 2.5 all over again?

Let me put this bluntly: holding back kbuild 2.5 is slowing down
Linux development.

> Everything that kbuild25 can be done with regular makefiles. You can
> get out-of-tree builds, you can get correct dependencies, you can get
> a non-recursive make process. At that point, timings will be _better_
> than those of kbuild25.

You hope they will, and when will that be?  Two years from now?  If
ever, because you might be wrong?  And do you expect that no further
improvements will be made in kbuild 2.5?

> Also, for those who can't read between the lines: Linus is taking 
> (lots of) patches for kbuild24 and is ignoring kbuild25. This should
> signal something to people, methinks...

Yes, it shows 1) that old kbuild needs a lot of maintainance and 2) not
many have taken time to look at kbuild 2.5.  I highly recommed doing
so now.  The time needed to download and install will be paid back the
first day.

There is exactly one valid objection I've seen to kbuild 2.5 inclusion,
and that is the matter of breaking up the patch.  Having done a quick
tour through the whole patch set, I now know that there are some
easy places to break it up:

  - Documentation is a large part of the patch and can be easily
    broken out.

  - The makefile parser, complete with state transition tables etc,
    lexer, and so on, breaks out cleanly (sits on top of the db
    utilities).

  - Executable programs written in C.  Each one ends with a
    'main' function, and there is the natural division.

  - The remaining C code breaks out into a number of separable
    components:

      - Utilities such as environment variable parsing, canonical
        name generation, line reading, line editing etc.
      - The database 
      - File utilities that use the database (e.g., walk_fs_db)
      - Dependency generation
      - Global Makefile construction (command generation etc)

    These tend to be common to a number of the executable programs,
    and so have the nature of library components.  They can all go
    under the heading 'lib', and further breakdown is probably not
    necessary.

  - The Makefile.in patches seem to be about 30-40% of the whole
    thing, and imho must be applied all at the same time.  However,
    they break up nicely across subsystem lines (drivers, fs, etc)

  - The per-arch patches are already broken out, and are short.

I think that with these breakups done the thing would be sufficiently
digestible to satisfy Linus.  Now that I think of it, Linus's request
for a breakup is really an endorsement, and quite possibly Keith took
it the wrong way.  (Keith, by the way, how did I do on the structural
breakdown?  Sorry, I really couldn't spend as much time on it as it
deserves.)

A general comment: the c code is a pleasure to read.  It is written
in exactly the 'Linus' style, that is, it follows the proper
formatting conventions, it is internally commented only where needed,
and each nontrivial component comes with a substantial introductory
comment.

Let's see if we can get this thing back on track.  The payoff is an
immediate and substantial improvement in speed and reliability of
system building, and in my opinion, a build system that is far easier
to read and understand than the old one.  We really owe it to
ourselves and Linux users in general to take advantage of this
superior work.

-- 
Daniel
