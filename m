Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbTCLDhJ>; Tue, 11 Mar 2003 22:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263010AbTCLDhJ>; Tue, 11 Mar 2003 22:37:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3259 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S263009AbTCLDhE>;
	Tue, 11 Mar 2003 22:37:04 -0500
Message-Id: <200303120347.h2C3loEG002703@eeyore.valparaiso.cl>
To: Zack Brown <zbrown@tumblerings.org>
cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Tue, 11 Mar 2003 10:40:43 PST."
             <20030311184043.GA24925@renegade> 
Date: Tue, 11 Mar 2003 23:47:50 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown <zbrown@tumblerings.org> said:
> --------------------------------- cut here ---------------------------------
> 
>            Linux Kernel Requirements For A Version Control System    
> 
> Document version 0.0.1

[...]

>                                  Changesets
> 
>   1. Introduction
> 
> A changeset is a group of files in a repository, that have been tagged by
> the developer, as being logical parts of a patch dealing with a single
> feature or fix. A developer working on multiple aspects of a repository, may
> create one changeset for each aspect, in which each changeset consists of
> the files relevant to that aspect.

Nope. A changeset is (roughly) what was traded as a patch before. I.e., a
coordinated _change_ to a set of files. The RCS problem (inherited by lots
of systems) is that it handles only a diff to _one_ file at a time.

> In the context of sharing changesets between repositories, a changeset
> consists of a diff between the set of files in the local and remote
> repositories.

I don't think it is a good idea to handle differences _between_
repositories, as they could be arbitrary and change in time. A change
_within_ a repository is well defined.

>   2. Behavior
> 
>     2.1 Tagging
> 
> It must be trivial for a developer to tag a file as part of a given
> changeset.

An individual change, not a file. You need to focus on changes to files,
not files. I.e., file appeared/dissapeared/changed name/was edited by
altering lines so and so. 

The bk method of accepting individual changes, and then bundling them up
should be enough, people tend to work at one problem at a time. It might be
possible to take a bunch of changes and slice&dice them into changesets
later, but that could create changesets that interdigitate and interdepend
(i.e., changeset 13 has edits that depend on changeset 14 having been
applied, and 14 similarly depends on 13 in other areas; also called
"deadlock" when talking about locking ;).

> It must be possible to reorganize changesets, so that a given changeset may
> be split up into more manageable pieces.

I don't see this as very useful. The user should take care to make changes
to foo.c and foo.h that touch one aspect into a changeset, and unrelated
changes (even touching the same files) into others.  Break a changeset up
might break dependencies between changes. It might make sense to group
changesets into larger changes, i.e., changesets 12-25 are move to new
driver model in /net, sets for /net, /block, /char are move to new driver
model, and so on upwards. Then 2.8.15 to 2.8.16 would be "just" a
(super)changeset. Such a (super)changeset would make sense to break up into
its parts, not individual ones.

[...]

>   3. Problems For Clarification
> 
> If a file is tagged as being part of two different changesets, then changes
> to that file should be associated with which changeset???

Individual changes to files can't belong to more than one changeset, AFAICS.

[...]

>                                    Merging

[...]

> It should be possible to mark a file as private to a local repository, so
> that a merge will never try to commit that file's changes to a remote
> repository.

Gets hairy... what if I create file foo as private, and later try to
integrate stuff that creates the same file? Better keep this out of the
repository in the first place.

>     2.2 Preserving History

[...]

> Even if no history is available for a given patch, it should be easy to
> checkin and merge that patch.

Just take that patch as a local edit, and make it a changeset.

> The implementation must not depend on time being accurately reported by any
> of the repositories.

It is more complicated than that. On a distributed system without some form
of shared clock it might be impossible (== nonsense, like in relativity
theory) to talk of a global "before" and "after"

[...]

>                          Distributed Rename Handling
> 
>   1. Introduction
> 
> This consists of allowing developers to rename files and directories, and
> have all repository operations properly recognize and handle this.

And create and destroy. Note "rename" must include moving directories
around, and moving stuff from one directory to another, etc.

[...]

>       2.2.1 Conflicts
> 
> An arbitrary number of repositories cloned from either a single remote
> repository or from each other may attempt to change the name of a single
> file to arbitrary other names and then merge that change back to a single
> remote repository or to each other.

Or several create the same file, or rename random files to the same name,
or even create and then destroy a file created somewhere else. Or create a
file in a directory that was just destroyed or moved locally, etc. I'm sure
this is one of the rat's nests of hairy special cases noone has thought
through Larry is so fond mentioning.

[...]

>                * * * Not Required For Kernel Development * * *
> 
>                                  Changesets
> 
> It should be possible to exchange changesets via email.

I'd say this is mandatory.

>                                  File Types
> 
> The system should support symlinks, device special files, fifos, etc. (i.e.
> inode metadata)

Urgh. If possible/convenient, yes. If not, leave it out. [I fail to see any
use for this, but that might just be lack of immagination on my side]

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> This document is copyright Zack Brown and released under the terms of the
> GNU General Public License, version 2.0.
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Why not the documentation license? Just curious.
> 
> --------------------------------- cut here ---------------------------------
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
