Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282654AbRL0VkO>; Thu, 27 Dec 2001 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRL0VkE>; Thu, 27 Dec 2001 16:40:04 -0500
Received: from bitmover.com ([192.132.92.2]:43422 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S282707AbRL0Vjw>;
	Thu, 27 Dec 2001 16:39:52 -0500
Date: Thu, 27 Dec 2001 13:39:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Larry McVoy'" <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: BK stuff [was Re: The direction linux is taking]
Message-ID: <20011227133951.M25698@work.bitmover.com>
Mail-Followup-To: Dana Lacoste <dana.lacoste@peregrine.com>,
	'Larry McVoy' <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A3B@ottonexc1.ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A3B@ottonexc1.ottawa.loran.com>; from dana.lacoste@peregrine.com on Thu, Dec 27, 2001 at 01:24:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies to the list if this is considered off topic.  I changed the 
subject so you can kill this thread if you like.  I know how popular BK
discussions are :-)

On Thu, Dec 27, 2001 at 01:24:27PM -0800, Dana Lacoste wrote:
> Mostly playing devil's advocate here :)
> 
> > Merging is much easier.
> 
> how exactly?  

It's probably an off topic conversation, but in the interesting case (i.e.,
it won't patch cleanly), both text based and GUI based tools are available
to help with the merge.  They are better than anything you're used to or
I'll eat my hat.  For example, if you are a CVS user, you are used to this:

    <<<<<<< local slib.c 1.645
                  sc = sccs_init(file, INIT_NOCKSUM|INIT_SAVEPROJ, s->proj);
                  assert(HASGRAPH(sc));
                  sccs_sdelta(sc, sccs_ino(sc), file);
    <<<<<<< remote slib.c 1.642.2.1
                  sc = sccs_init(file, INIT_NOCKSUM|INIT_SAVEPROJ, p);
                  assert(sc->tree);
                  sccs_sdelta(sc, sc->tree, file);
    >>>>>>>

but we can give you this:

    <<<<<<< local slib.c 1.642.1.6 vs 1.645
                  sc = sccs_init(file, INIT_NOCKSUM|INIT_SAVEPROJ, s->proj);
    -             assert(sc->tree);
    -             sccs_sdelta(sc, sc->tree, file);
    +             assert(HASGRAPH(sc));
    +             sccs_sdelta(sc, sccs_ino(sc), file);
    <<<<<<< remote slib.c 1.642.1.6 vs 1.642.2.1
    -             sc = sccs_init(file, INIT_NOCKSUM|INIT_SAVEPROJ, s->proj);
    +             sc = sccs_init(file, INIT_NOCKSUM|INIT_SAVEPROJ, p);
                  assert(sc->tree);
                  sccs_sdelta(sc, sc->tree, file);
    >>>>>>>

Why is that better?  It's essentially two inline context diffs, so you can
see what each side did.  Much easier to merge when you can tell what is 
going on.

The GUI tools give you the second style as well as some extra windows
so you can see the checkin comments associated with both the deleted and
the added lines, which gives you yet more information.

> (on the other hand SCM makes it MUCH easier
> to deal with the 'cleanly applied' part :)
> 
> > Tracking of patches is much easier.
> 
> not really : how do you make sure that all the
> correct patches have been applied?  All SCM
> lets you gain is knowing what patches have
> been applied, not what patches were NOT applied.

You're assuming the common denominator of SCM systems.  That's not BK.
The easiest way to see if your patch is in Linus's BK tree is this:

	bk push -nl bk://bk.kernel.org/released

That will list everything in your tree which is not in his tree.  There are
other ways to do it as well, but you get the idea.

> > Access control is much easier.
> 
> but if it's only Linus, then this is a moot point :)

But it isn't only Linus.  Again, you are assuming a CVS/Perforce/etc style
SCM system.  BK isn't like that.  Each workspace is a repository and you
can move data between them in any way that you want.  That's the whole
point, you can put staging areas between Linus and the unwashed masses.
And if the structure you come up with turns out to be wrong, hey, no
worries, just change it.  BK does the right thing.

> ok, i have to go learn bitkeeper now so i can answer this
> intelligently, but i'll give some examples from perforce

I strongly urge you to go to www.bitkeeper.com, click on Test Drive,
download BK, and try it.  It walks you through all the basics as well
as a merge, demo-ing the GUI file merge.

> Common task 1 : usability
> perforce tracks what everyone has.  this means that if you want
> to do a sync to current, it only gives you what's changed since
> your last sync, because it knows, and you didn't do anything
> without telling it, right?

Right.

> well, what if i'm working on 2.5 stuff for my magical danaDriver?
> It's really intense, has a lot of files all over the place, and I
> don't want to hurt anything.  Then someone asks me about the
> interaction between danaDriver and reiserFS in 2.4.17 and I want
> to make sure I can see exactly what they're talking about.
> 
> so what i want to do (and i can't do in perforce, well, not easily)
> is to make a clean checkout of the last 'official release' of the
> whole project from SCM _without_ affecting my workspace.
> 
> i.e. i do NOT want to create a new workspace, i do not want to create
> a special directory, i just want to do :
> 	mkdir linux
> 	cvs checkout linux -tag 2.4.17
> and get the whole linux-2.4.17 source code, without affecting my working
> directory 'linux-2.5' which also has the linux/* (main)branch checked out.

Trivial in bk, do a "bk help clone".  And it doesn't have to be a tagged
release either, all changes (aka cvs commits) are reproducible snapshots
of the tree.  It's like you followed every cvs commit with a cvs tag 
except lots lots faster.

> This is something perforce does REALLY well.
> I can do this :
> - set it up so anyone can submit a change request [patch] but it has
>   to be approved by the directory/file's owner first.  if it's not
>   approved, it can't be submitted.

bk help triggers

>   this means that ANYONE can submit a patch, and everyone gets to
>   participate, and accountability is maintained.

Yup.

> - set it up so that interested parties get notified of every change
>   that is submitted, including a web link to the full diffs of that
>   change.  notification is file/directory based, and can have 'excludes'
>   so rik can get notified every time 'virtualmemory.c' is changed so
>   that way he can start flaming andrea right away :) :) :) :) :)

bk help triggers
http://linux.bkbits.net
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
