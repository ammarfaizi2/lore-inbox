Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbTCIXwA>; Sun, 9 Mar 2003 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbTCIXwA>; Sun, 9 Mar 2003 18:52:00 -0500
Received: from pasky.ji.cz ([62.44.12.54]:40689 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262681AbTCIXv4>;
	Sun, 9 Mar 2003 18:51:56 -0500
Date: Mon, 10 Mar 2003 01:02:33 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Zack Brown <zbrown@tumblerings.org>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Thoughts about ideal kernel SCM
Message-ID: <20030310000233.GS3917@pasky.ji.cz>
Mail-Followup-To: Zack Brown <zbrown@tumblerings.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com> <20030308225252.GA23972@renegade> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309024522.GA25121@renegade>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Mar 09, 2003 at 03:45:22AM CET, I got a letter,
where Zack Brown <zbrown@tumblerings.org> told me, that...
> On Sat, Mar 08, 2003 at 04:05:14PM -0800, Larry McVoy wrote:
> > Zack Brown wrote:
> > > Linus Torvalds wrote:
> > > > Give it up.  BitKeeper is simply superior to CVS/SVN, and will stay that
> > > > way indefinitely since most people don't seem to even understand _why_
> > > > it is superior. 
> > > 
> > > You make it sound like no one is even interested ;-). But it's not true! A
> > > lot of people currently working on alternative version control systems would
> > > like very much to know what it would take to satisfy the needs of kernel
> > > development.
> > 
> > [Long rant, summary: it's harder than you think, read on for the details]
> [skipping long description]
> 
> OK, so here is my distillation of Larry's post.

I've decided to elaborate a little more how BK in fact works for those who
don't use it and don't want to read over all the documentation, and also share
some thoughts and possible solutions of the individual problems.

All this is derived from various LKML threads and BK.com's documentation as I'm
not permitted to use BK myself, corrections are more than welcome.

>   Basic summary: a distributed, replicated, version controlled user level file
>   system with no limits on any of the file system events which may happened
>   in parallel. All changes must be put correctly back together, no matter how
>   much parallelism there has been.

[in the following text, "checkin" and "commit" are not inter-exchangable;
"checkin" means to one-time get some changes to one file, "commit" means to
form a changeset from several checked in changes in several files; this mirrors
BK's semantics]

I'd add

  * ChangeSets.

at the top. Unlike ie. SVN, changes checkins and changesets commits are
separated in BK and that sounds as a good thing to do --- it encourages people
to checkin more frequently and group a changeset from the uncommitted changes
when the changes are finished and good enough. See also
http://www.bitkeeper.com/UG/Getting.Working.Checking.html. Basically, you
checkin files as you want and the checkins to individual files are independent.
When you finish some logical change over several files, you use bk commit and
the checkins which aren't part of any changeset yet are automagically grouped
to one, you write a summary comment of the changeset and then ChangeSet
revision number will increase and somewhere will be written down which checkins
are part of this ChangeSet. One changeset is then an atomic unit when sharing
the changes with others, that is you must form one in order to make the changes
available.

The more-or-less opposite concept is to have each checkin(s, when you checking
multiple files at once) as a changeset (this is what SVN does) --- then you
don't need per-file revision numbers but just one per-repository revision
number which is increased by each checkin (which is also commit in SVN). This
can seem more elegant and generic, but I personally believe that it's better to
have release checkins and changeset commits separated. Then per-repository
revision numbers should obviously increase by each commit, not checkin.

In BK, you usually work with the changeset numbers, but for the internal
structure the revision numbers are also important. Since changeset number can
be taken as revision number of the ChangeSet metafile, I will operate mostly
with revision numbers below.

>   * Merging.
> 
>   * The graph structure.

About these two, it could be worth noting how BK works now, how looks branching
and merging and how could it be done internally.

When you want to branch, you just clone the repository --- each clone
automatically creates a branch of the parent repository. Similiarly, you merge
the branch by simply pulling the "branch repository" back. This way the
distributed repositories concept is tightly connected with the branch&merge
concept. When I will talk about merging below, it doesn't matter if it will
happen from the cloned repository just one directory far away or over network
from a different machine.

[note that the following is figured out from various resources but not from the
documentation where I didn't find it; thus I may be well completely wrong here;
please substitute "is" by "looks to be", "i think" etc in the following text]

BK works with a DAG (Directed Acyclic Graph) formed from the versions, however
the graph looks differently from each repository (diagrams show ChangeSet
numbers).

 From the imaginary Linus' branch, it looks like:

linus  1.1 -> 1.2 -> 1.3 -----> 1.4 -> 1.5 -----> 1.6 -----> 1.7
                \               / \                          /
alan             \-> 1.2.1.1 --/---\-> 1.2.1.2 -> 1.2.1.3 --/

But from the Alan' branch, it looks like:

linus  1.1 -> 1.2 -> 1.2.1.1 -> 1.2.1.2 -> 1.2.1.3 -> 1.2.1.4 -> 1.2.1.5
                \               / \                              /
alan             \-> 1.3 ------/---\-----> 1.4 -----> 1.5 ------/

But now, how does merging happen? One of the goals is to preserve history even
when merging. Thus you merge individual per-file checkins of the changeset
one-by-one, each checkin receiving own revision in the target tree as well ---
this means the revision numbers of individual checkins change during merge if
there were other checkins to the file between fork and merge.

But it's a bit more complicated: ChangeSet revision number is not globally
unique neither and it changes. You cannot decide it to be globally unique
during clone, because then you would have to increase the branch identifier
after each clone (most of them are probably just read-only). Thus in the cloned
repository, you work like you would continue in the branch you just cloned, and
the branch number is assigned during merge.

A virtual branch (used only to track ChangeSets, not per-file revisions) is
created in the parent repository during merge, where the merged changesets
receive new numbers appropriate for the branch. However the branch is really
only virtual and there is still only one line of development in the repository.
If you want to see the ChangeSets in order they were applied and present in the
files, you have not to sort them by revision, but by merge time. Thus the order
in which they are applied to the files is (from Linus' POV):

1.1 1.2 1.3 1.2.1.1 1.4 1.5 1.6 1.2.1.2 1.2.1.3 1.7

>   * Distributed rename handling. Centralized systems like Subversion don't
>   have as many problems with this because you can only create one file in
>   one directory entry because there is only one directory entry available.
>   In distributed rename handling, there can be an infinite number of different
>   files which all want to be src/foo.c. There are also many rename corner-cases.

One obvious solution is hitting me here. First, you virtualize files to inodes
and give them numbers (in practice it's not necessary and in fact it could be
better not to do that, but it can be much easier to think about it as if it
would be this way) --- the numbers don't have to be globally unique, they are
just convience abstraction; they are inherited upon clone, though. Then in
repository you have each file name being just that inode number, and for each
inode you keep history of names it had and in which revision the name was
assigned (thus you also know in what changeset it was assigned).

When you are merging an "inode", you just go back to the last common ChangeSet
revision in the names history and look what the name is. If there's no name for
that changeset yet, it's a new file and if there's filename conflict, you
cannot do much with it. Otherwise you know that the inode number has to be same
for both repositories. Then you just do the rename of inode in the target
repository to the current name in the source repository. If there is a
conflict, you check if you can't repeat this whole operation on the file in the
way in the target repository --- if not (or you can but the conflict was not
solved anyway), you again probably cannot do much with this again and you have
to let the user decide.

What am I missing?

>   * Symbolic tags. This is adding a symbolic label on a revision. A distributed
>   system must handle the fact that the same symbol can be put on multiple
>   revisions. This is a variation of file renaming. One important thing to
>   consider is that time can go forward or backward.

You remap the tags when you remap the changeset numbers, and? BK seems to allow
one tag to be on multiple changesets and I presume that then the latest one is
normally used --- you can do the similiar here, the latest such-named tag is
used normally, the merged ones are just preserved in the history.

>   * Security semantics. Where should they go? How can they be integrated
>   into the system? How are hostile users handled when there is no central
>   server to lock down?

I'm not sure which points exactly this attempts to bring up. Which particular
issues are open here? This is mostly question of configuration of individual
repositories (if you allow push and from who) and trust (if you will do pull
and from who), isn't it?

>   * Time semantics. A distributed system cannot depend on reported time
>   being correct. It can go forward or backward at any rate.

Yes, then let's not depend on the time ;-).

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
When in doubt, use brute force.
		-- Ken Thompson
.
Crap: http://pasky.ji.cz/
