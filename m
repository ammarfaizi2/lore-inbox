Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSGWWnm>; Tue, 23 Jul 2002 18:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSGWWnm>; Tue, 23 Jul 2002 18:43:42 -0400
Received: from bitmover.com ([192.132.92.2]:37559 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318222AbSGWWnl>;
	Tue, 23 Jul 2002 18:43:41 -0400
Date: Tue, 23 Jul 2002 15:46:48 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Roger Gammans <roger@computer-surgery.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020723154648.A27617@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Larry McVoy <lm@bitmover.com>,
	Roger Gammans <roger@computer-surgery.co.uk>,
	linux-kernel@vger.kernel.org
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas> <20020722152031.GB692@opus.bloom.county> <20020722232941.A10083@computer-surgery.co.uk> <20020722154443.E19057@work.bitmover.com> <m1y9c2mgqp.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1y9c2mgqp.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, Jul 23, 2002 at 12:38:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 12:38:54PM -0600, Eric W. Biederman wrote:
> > > With all due respect to Larry and the bk team, I think you'll
> > > find determining 'needed changesets' in this case is a _hard_ problem.
> > 
> > Thanks, we agree completely.  It's actually an impossible problem
> > for a program since it requires semantic knowledge of the content
> > under revision control.  And even then the program can get it wrong
> > (think about a change which shortens the depth of the stack followed by
> > a change that won't work with the old stack depth, now you export that
> > to the other tree and it breaks yet it worked in the first tree).
> 
> The last time this was suggested, the idea was to look how far back into
> the repository  (up to a given limit) a current changeset could apply, with all
> of it's current dependencies. 
> 
> But beyond that I suspect it would be easier to declare lack of dependencies.

[I'm going to argue with you up here, mostly to just explanations of how/why
BK works, but you can skip down to the next section and you'll see we have
a fair amount of agreement]

All of what you are saying makes perfect sense in a centralized system
like CVS, Perforce, Subversion, whatever.  The reason it makes sense is
that there is exactly one copy of the truth, you can manipulate it in
the one location which has it, and that's that.  

Sort of sounds like all those tools are better than BitKeeper, given
that description, right?  Because BitKeeper is distributed, there is no
one place that you can do anything and force it upon everyone else.
You can only do things to your local revision history in a recorded
way and propogate that to anyone else that wants it.

Again, sounds like the distributed nature of BK is causing all sorts
of problems, so why not just toss it, centralized systems manage 99.9%
or more of the world's source, so they must be good enough.  Maybe not.
It is the peer to peer nature of BK which allows all sorts of things to
work, from mundane stuff like performance (you operate against a local
copy of the history) to more complex things like work flow (it's trivial
to mimic Rational's unified change management system with a series of
repositories) to practical things like working both at home and at
work and not losing data.

Whether you agree or disagree with the value of the distributed nature
of BitKeeper, that's a basic part of how it works and it can be tweaked
but not thrown out.  Consider it a "limitation" of the BitKeeper design.

OK, so now think about what you are asking.  You want to move
changesets around out of order.  Please explain to me how you are
going to synchronize two trees when you've done that.  Right now,
we can use the fact that there is a strong ordering to do fast and
lightweight synchronization.  Do an strace of a pull from bkbits.net when
there is nothing to pull and count the bytes that go across the wire.
It's tiny, probably about 5-6KB.  Now do the same thing with CVS, the
amount of data is proportional to the number of files in the tree, i.e.,
dramatically more.

The reason we can do what we do is that a changeset actually implies the
existence of all the changesets which came before it.  As soon as we do
the out of order stuff, we can no longer depend on that.  The openlogging
kernel tree has 12,000 changesets in it.  If I can't depend on ordering,
do you want me to compare all 12,000 to see if I need to update anything?
Or should I start doing the file by file comparison that CVS does?
No thanks, that sucks, we can quantify exactly how much it sucks and it
is too much.

I'm not saying "no, we won't fix it", I'm saying "understand why it is
the way it is and then suggest a fix".  In other words, don't throw
the baby out with the bath water.

> drivers/net and drivers/ide are completely separate subtrees.  At
> least not until you get ATA over ip.  And even then the dependencies
> is with the ip layer.  
> 
> Maybe independence should be shown by putting each independent chunk
> into it's own repository.  And then building a working kernel tree 
> would just be a matter of checking out all of the parallel
> repositories, into the appropriate location.  Then the global tree
> can just remember which version of all of the subtrees it was
> tested with last.

Whoohoo!  Agree completely, and we're building this, we call them nested
repositories and they work pretty much exactly as you describe.  However,
even there we do get into problems.  Here's how: suppose that you have a
nested repo for include/ppc and another for arch/ppc.  You make a change
in both and you commit a sort of "super changeset" which binds those
changes together because one won't work without the other.  Now you go
to pull the include/ppc directory for some reason and it will force you
to pull the arch/ppc directory.  So the dependencies are reduced but
can still creep across the boundaries.  Not doing so isn't an option
because we can all agree we have to have some way to say "these changes
which span these subrepositories must move as a unit".

> Given that a fully independent program is likely to break because of
> a buggy libc (which I have no business depending upon the exact
> version), I think the insistence on global dependencies is just plain
> silly, you can never find the entire set of dependencies.  

Agreed.  And it's unlikely anyone would take explicit actions to bind
their app to libc unless for some reason they really did need at least
glibc2.3 for some (probably bad, IMHO) reason.  So you'd be OK there.

By the way, we have customers who maintain (large) embedded Linux
distributions in BitKeeper with literally hundreds of unrelated
repositories, i.e., one for the kernel, one for gcc, one for make,
etc.  They are the motivation behind the nested stuff so they don't
have to do scripts which do things like

	for i in `cat list_of_repos`
	do	cd ~/ws/$i && bk pull
	done

> So Larry please cope with the fact that perfect dependency modeling is
> impossible, and setup a method that works in the real world.  

It's high on our list and we are working on it.  I get a little touchy
about it because some of what people say they want just won't work in
a distributed system, but as you suggested, there is more than one way
to do it and the nested stuff is a good start.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
