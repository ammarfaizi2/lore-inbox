Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319014AbSIJCqx>; Mon, 9 Sep 2002 22:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSIJCqx>; Mon, 9 Sep 2002 22:46:53 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:41668 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319014AbSIJCqu>;
	Mon, 9 Sep 2002 22:46:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Tue, 10 Sep 2002 04:53:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17oa11-0006ww-00@starship> <20020910025602.A6343@kushida.apsleyroad.org>
In-Reply-To: <20020910025602.A6343@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ob9w-0006xb-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 03:56, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > > ...  Once it begins unregistering
> > > resources, it's pretty committed to unregistering them all and saying it
> > > exited ok.
> > 
> > And failing silently if it can't?
> 
> It could make a noise, but it will still be a failure.  Once you've
> unregistered one of the module's resources (e.g. a PCI device
> registration), there is no turning back.  If the next thing you
> unregister (e.g. a filesystem) fails, what are you going to do?  Try to
> re-register the PCI device?

The module unloader is going to look at the error code and decide if it can 
do something about it (it probably can't).  Otherwise, it will report the 
error in a standard, sane way, and the deluxe version will attempt to wall 
off the damage.  What would you prefer, that __exit should fail silently, 
leaving various resources in random states, and that the remaining, 
functional part of the system should never be told about it?  Granted, 
that's a time-honored approach to error handling, but it falls far short
of adequate.

> Basically, once you've started unregistering resources, if there's an
> error you're left in an inconsistent state.  You can try to get back to
> one of the states "module installed" or "module removed", but there's no
> guarantee of either -- and trying to do that would certainly complicated
> cleanup_module() functions.

I'm not advocating that somebody solve the whole 'how to we recover' problem 
this week.  That's the kind of trouble IBM would go to on a mainframe, and
they'd get it right, but we have lots more low hanging fruit before we get
to that level of detail.

> > > Unfortunately, once it has the lock, and the reference counts are all
> > > zero, it's still _not_ generally safe to cleanup up a module.
> > > 
> > > This is because any other function, for example a release() op on a
> > > file, or a remove() op on a PCI device, can't take a module's private
> > > lock, decrement the private reference count, release the lock and
> > > return.  There's a race between releasing the lock and returning, where
> > > it still isn't safe to remove the module's memory.
> > >
> > > Even waiting for a schedule to happen won't help if CONFIG_PREEMPT is
> > > enabled. 
> > 
> > That's exactly the race that is removed by having the module subsystem call 
> > __exit to remove the module.  Since the module subsystem checks the __exit's 
> > flag on return and releases the lock, so there is no window after releasing 
> > the lock when the releasor is still executing in the module.
> 
> Please say if you mean "cleanup_module()" when you say "__exit".

Yes, I mean:

-void cleanup_module(void)
+int cleanup_module(void)

Or possibly:

+int cleanup_module(struct module *module, int funny_flags)

> Assuming you do, how can __exit safely decide whether to return 0 or -1?

Well, I'd suggest negative for an error code, or positive if the error is
simply "this module still seems to have this many users".  For filesystems
it simply looks at the use count, which Al maintains appropriately.  Locking
has been arranged by module.c such that this won't increase during the
course of the cleanup_module call.  The module exit routine does:

	if (module->count)
		return module->count;

	return clean_up_whatever();

For more difficult cases, such as SCM where we can't know so easily if there
are tasks executing in the module, it has to be more like:

	if (module->count)
		return module->count;

	if ((howmany = there_are_still_users_magic_test()))
		return howmany;

	return clean_up_whatever();

> > > In other words, the module's idea of whether it's own resources are no
> > > longer in use _must_ be released by code outside the module - or at
> > > very least, locks protecting that information must be released outside
> > > the module.
> > 
> > Yup, that's exactly what I've proposed, in the simplest way possible.
> 
> Then you've completely confused me, because you seem to be saying that a
> module's own cleanup function returns a success/failure result to the
> module subsystem.

That's exactly what I'm saying.

> > Silent failure is about the worst thing that we could possibly design into 
> > the system, but that's not even the issue I'm going on about - because I 
> > think it's so appallingly obvious it's wrong, I assume everybody can
> > see that.
> 
> I'm sure there would be no harm in cleanup_module() returning an error
> code, but if it did all we could do is log it.

That's a start.  If we were IBM, writing a mainframe executive, we'd also
clean up all the resources, which we'd have kept track of carefully.
But that's a little ambitious for us at the moment, given that we don't
even have clear agreement that errors should be reported.

> > Rather, it's the simple fact that this is the obvious interface a naive 
> > person would expect, and nobody has presented a rational argument for not 
> > using it.
> 
> Well it's not obvious, because either I don't understand what you are
> describing, or you don't understand when I explain that it doesn't work :-)

Eh.  You now have sufficient data to explain to me why it doesn't work,
if it really doesn't.

> > [...] we have to do cute things to be sure that all threads are out of
> > the module, however, that is an othogonal issue, and when last
> > sighted, it had a workable solution on the table, which requires each
> > task to schedule once.  Config_preempt is a trivial issue: just
> > increment the preempt counter and nobody will preempt on you while you
> > run the magic quiescence test.
> 
> You have to increment the preempt counter in the threads, not in the
> path that's testing for a quiescent state, so that when a thread does
> set_finished_flag/dec_ref_count -> unlock -> exit, there can be no
> preempt between the unlock and the exit.
> 
> This is all made simpler by using complete_and_exit() these days.

Hmm, lovely documentation there.  Different rant, calm down, ignore ;-)

It's not just the little detail of how you get out crashlessly after
the test, the hard part is proving no other threads are in the
module.  And yes, you have to increment *all* the preempt counts,
I did indeed omit that detail, nonetheless, it's just a detail.  I'm
willing to believe the scheduling crew have the there_are_still_users
magic test problem under control, at least they seemed to be headed in
that direction last time it got beaten to death on the list.

> If so then I maintain there are non-trivial races that bite nearly every
> use of MOD_DEC_USE_COUNT from within the module.

Let's see if you can find one in the above.

-- 
Daniel
