Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbTCQUs7>; Mon, 17 Mar 2003 15:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbTCQUs7>; Mon, 17 Mar 2003 15:48:59 -0500
Received: from pasky.ji.cz ([62.44.12.54]:36600 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261933AbTCQUsz>;
	Mon, 17 Mar 2003 15:48:55 -0500
Date: Mon, 17 Mar 2003 21:59:48 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org,
       arch-users@lists.fifthvision.net
Subject: Re: Thoughts about ideal kernel SCM
Message-ID: <20030317205948.GR11761@pasky.ji.cz>
Mail-Followup-To: Zack Brown <zbrown@tumblerings.org>,
	linux-kernel@vger.kernel.org, arch-users@lists.fifthvision.net
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com> <20030308225252.GA23972@renegade> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade> <20030310000233.GS3917@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310000233.GS3917@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please strip lkml from the cc list when replying.)

Dear diary, on Mon, Mar 10, 2003 at 01:02:33AM CET, I got a letter,
where Petr Baudis <pasky@ucw.cz> told me, that...
> Dear diary, on Sun, Mar 09, 2003 at 03:45:22AM CET, I got a letter,
> where Zack Brown <zbrown@tumblerings.org> told me, that...
..snip..
> >   * Merging.
> > 
> >   * The graph structure.
> 
> About these two, it could be worth noting how BK works now, how looks branching
> and merging and how could it be done internally.
> 
> When you want to branch, you just clone the repository --- each clone
> automatically creates a branch of the parent repository. Similiarly, you merge
> the branch by simply pulling the "branch repository" back. This way the
> distributed repositories concept is tightly connected with the branch&merge
> concept. When I will talk about merging below, it doesn't matter if it will
> happen from the cloned repository just one directory far away or over network
> from a different machine.
> 
> [note that the following is figured out from various resources but not from the
> documentation where I didn't find it; thus I may be well completely wrong here;
> please substitute "is" by "looks to be", "i think" etc in the following text]
> 
> BK works with a DAG (Directed Acyclic Graph) formed from the versions, however
> the graph looks differently from each repository (diagrams show ChangeSet
> numbers).
> 
>  From the imaginary Linus' branch, it looks like:
> 
> linus  1.1 -> 1.2 -> 1.3 -----> 1.4 -> 1.5 -----> 1.6 -----> 1.7
>                 \               / \                          /
> alan             \-> 1.2.1.1 --/---\-> 1.2.1.2 -> 1.2.1.3 --/
> 
> But from the Alan' branch, it looks like:
> 
> linus  1.1 -> 1.2 -> 1.2.1.1 -> 1.2.1.2 -> 1.2.1.3 -> 1.2.1.4 -> 1.2.1.5
>                 \               / \                              /
> alan             \-> 1.3 ------/---\-----> 1.4 -----> 1.5 ------/
> 
> But now, how does merging happen? One of the goals is to preserve history even
> when merging. Thus you merge individual per-file checkins of the changeset
> one-by-one, each checkin receiving own revision in the target tree as well ---
> this means the revision numbers of individual checkins change during merge if
> there were other checkins to the file between fork and merge.
> 
> But it's a bit more complicated: ChangeSet revision number is not globally
> unique neither and it changes. You cannot decide it to be globally unique
> during clone, because then you would have to increase the branch identifier
> after each clone (most of them are probably just read-only). Thus in the cloned
> repository, you work like you would continue in the branch you just cloned, and
> the branch number is assigned during merge.
> 
> A virtual branch (used only to track ChangeSets, not per-file revisions) is
> created in the parent repository during merge, where the merged changesets
> receive new numbers appropriate for the branch. However the branch is really
> only virtual and there is still only one line of development in the repository.
> If you want to see the ChangeSets in order they were applied and present in the
> files, you have not to sort them by revision, but by merge time. Thus the order
> in which they are applied to the files is (from Linus' POV):
> 
> 1.1 1.2 1.3 1.2.1.1 1.4 1.5 1.6 1.2.1.2 1.2.1.3 1.7
..snip..

I didn't explain (and get as well, in fact) this probably well enough
initially, as several people asked me about this privately. Thus I decided it
would be worth elaborating the "virtual branching" (which turns out not to be
*that* virtual after all) concept, and alternative solutions. While the current
operation may be quite obvious for the regular bk users, it probably isn't for
the others and it could be worth documenting it. And deciding (on arch-list,
please), how to actually do it for ourselves ;-).

Let's sketch some really very simple example of DAG here, but much more
detailed about revisions. First, the basic situation:

          Linus +-----+     +-----+     +-----+
  BASE      ,-->| 1.2 |---->| 1.3 |---->| 1.4 |--.
 +-----+   /    +-----+     +-----+     +-----+   \   +-------+
 | 1.1 |--<                                        >--| MERGE |
 +-----+   \        +-----+         +-----+       /   +-------+
            `------>| 1.2 |-------->| 1.3 |------'
           Alan     +-----+         +-----+

At the merge point, Linus will merge the Alan's changesets committed after the
fork.  However, do we want to do a flat-merge, cummulating the changesets to
one big ball and placing it as a 1.5 ? Or rather take the changesets and commit
them separately ?

Let's see what Bitkeeper appears to do. It will take the common ancestors of
the branches, that is 1.1 here. Then, it will pull from the branch being
merged, fork an internal branch at 1.1 and stuff the pulled changesets there.
Thus the result will be the classical image of brances in RCS-alike systems
(Linus' perspective):

          Linus +-----+     +-----+     +-----+
  BASE      ,-->| 1.2 |---->| 1.3 |---->| 1.4 |--.
 +-----+   /    +-----+     +-----+     +-----+   \   +-------+
 | 1.1 |--<                                        >--| MERGE |
 +-----+   \     +---------+       +---------+    /   +-------+
            `--->| 1.1.1.1 |------>| 1.1.1.2 |---'
           Alan  +---------+       +---------+

So BK *appears* to _do_ have a "classical branching" capability, despite the
impression, although it seems not to be available for regular usage but rather
only for internal purposes.

After this, the merge itself (done by "bk resolve", looking from the
documentation) will do some magical operation, which _probably_ looks like:

* combine all these changesets to one big diff (note that in practice you don't
probably do such a silly things but just hijack the development line to include
the branched changesets at the right point and only skip the conflicting delta
fragments; however it is best to illustrate as if we would do it this way ;)

* apply this big diff on the top of 1.4

* check it in and hide it to some eyes (it certainly doesn't appear in the
mails which are emitted by bk to our popular mailing lists, I didn't check how
exactly are these merges presented on the web interface and have zero clue
about how are they being presented by "bk log"-alikes; I'd say that it is
sorted by the date of merge, thus it is in that order "1.1 1.2 1.3 1.4 1.1.1.1
1.1.1.2" being presented in the previous mail; also the merge changeset
certainly has to contain information about the branch being merged there, so
the log can have inserted info about 1.1.1.1 and 1.1.1.2 between 1.4 and 1.5).

* note that at some conditions the file revision numbers are branchized as
well, it probably happens when merging branches, I didn't investigate this yet

* don't check in the parts which were conflicting, leave them and let the user
resolve them --- these changes won't be hidden and they will appear as the diff
being attached to the "merge changeset"

* bundle all these changes and present them as changeset 1.5, called "Merge
alan with linus" or so ;) :

          Linus +-----+     +-----+     +-----+
  BASE      ,-->| 1.2 |---->| 1.3 |---->| 1.4 |--.     MERGE
 +-----+   /    +-----+     +-----+     +-----+   \   +-----+
 | 1.1 |--<                          1.4 + 1.1.1.2 >--| 1.5 |
 +-----+   \     +---------+       +---------+    /   +-----+
            `--->| 1.1.1.1 |------>| 1.1.1.2 |---'
           Alan  +---------+       +---------+


Now this is certainly an interesting concept, and it is nice to users
especially because they have to solve conflicts _once_, when applying the
combined delta.

However, it is next to impossible to so-called "cherrypick changes", thus
select only some changesets which to merge. The problem is that you have to
spawn the branch with this one changeset, but what if you will later want to
import a changeset being _before_ this one? In order to preserve the order of
things, you will have to move the changeset on the branch forward to a next
revision number and push the new one at that place. Aside of revision numbers
being changed in frame of one repository is a weird thought, not only backwards
but even _forward_ conflicts could happen. So, the question is, is it mandatory
to preserve order of changesets? If the changesets would appear in the branch
in the order as they would be merged, the cherrypicking shouldn't be a problem,
IMHO.

Another thing is that the merging procedure is kind of weird, there has to be
some "hijacking" of the development line to get the order right. Otherwise,
however, the concept is not all that bad and it is full of nice ideas. Can we
do better?


There can be an alterantive approach, which picks the changesets from the
mergee one by one and apply them one by one, stopping at the moment when there
is a conflict.  Then it will be let to user to solve and then the step-by-step
merge can continue. This will result in merged changesets being directly
committed to the tree as regular changesets, only with some additional info
that they are merged:

          Linus +-----+     +-----+     +-----+
  BASE      ,-->| 1.2 |---->| 1.3 |---->| 1.4 |--.
 +-----+   /    +-----+     +-----+     +-----+   )
 | 1.1 |--' ,------------------------------------' .-- . . .
 +-----+   (        +-----+         +-----+       /
            `------>| 1.5 |-------->| 1.6 |------'
           Alan     +-----+         +-----+

Note that there is no special changeset dedicated to the merge, all the
conflicts are resolved in the individual changesets, thus all the diffs there
are "real"; also, you do no hijacking of the line and all the changesets are
ordinary general ones, with almost no special attributes. The underlying
versioning system doesn't even have to know about branches ;-). However the
changesets are already mirrored modified, you have to possibly resolve
conflicts multiple times during a merge and it is not clear from the revision
number what the originating branch is forked from.

Which model do you think is better? Or do you have yet another idea how to do
this? (given that we _do_ have to do this somehow)

Have fun,

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/
