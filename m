Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSIJBwC>; Mon, 9 Sep 2002 21:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSIJBwC>; Mon, 9 Sep 2002 21:52:02 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:49319 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S315762AbSIJBwB>; Mon, 9 Sep 2002 21:52:01 -0400
Date: Tue, 10 Sep 2002 02:56:03 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020910025602.A6343@kushida.apsleyroad.org>
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17oUnq-0006tg-00@starship> <20020910014459.B5875@kushida.apsleyroad.org> <E17oa11-0006ww-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17oa11-0006ww-00@starship>; from phillips@arcor.de on Tue, Sep 10, 2002 at 03:40:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> > ...  Once it begins unregistering
> > resources, it's pretty committed to unregistering them all and saying it
> > exited ok.
> 
> And failing silently if it can't?

It could make a noise, but it will still be a failure.  Once you've
unregistered one of the module's resources (e.g. a PCI device
registration), there is no turning back.  If the next thing you
unregister (e.g. a filesystem) fails, what are you going to do?  Try to
re-register the PCI device?

Basically, once you've started unregistering resources, if there's an
error you're left in an inconsistent state.  You can try to get back to
one of the states "module installed" or "module removed", but there's no
guarantee of either -- and trying to do that would certainly complicated
cleanup_module() functions.

> > Unfortunately, once it has the lock, and the reference counts are all
> > zero, it's still _not_ generally safe to cleanup up a module.
> > 
> > This is because any other function, for example a release() op on a
> > file, or a remove() op on a PCI device, can't take a module's private
> > lock, decrement the private reference count, release the lock and
> > return.  There's a race between releasing the lock and returning, where
> > it still isn't safe to remove the module's memory.
> >
> > Even waiting for a schedule to happen won't help if CONFIG_PREEMPT is
> > enabled. 
> 
> That's exactly the race that is removed by having the module subsystem call 
> __exit to remove the module.  Since the module subsystem checks the __exit's 
> flag on return and releases the lock, so there is no window after releasing 
> the lock when the releasor is still executing in the module.

Please say if you mean "cleanup_module()" when you say "__exit".
Assuming you do, how can __exit safely decide whether to return 0 or -1?

> > In other words, the module's idea of whether it's own resources are no
> > longer in use _must_ be released by code outside the module - or at
> > very least, locks protecting that information must be released outside
> > the module.
> 
> Yup, that's exactly what I've proposed, in the simplest way possible.

Then you've completely confused me, because you seem to be saying that a
module's own cleanup function returns a success/failure result to the
module subsystem.  Or is that not what you mean when you say __exit?
(Which isn't the name of a function, btw).

> Silent failure is about the worst thing that we could possibly design into 
> the system, but that's not even the issue I'm going on about - because I 
> think it's so appallingly obvious it's wrong, I assume everybody can
> see that.

I'm sure there would be no harm in cleanup_module() returning an error
code, but if it did all we could do is log it.

> Rather, it's the simple fact that this is the obvious interface a naive 
> person would expect, and nobody has presented a rational argument for not 
> using it.

Well it's not obvious, because either I don't understand what you are
describing, or you don't understand when I explain that it doesn't work :-)

> [...] we have to do cute things to be sure that all threads are out of
> the module, however, that is an othogonal issue, and when last
> sighted, it had a workable solution on the table, which requires each
> task to schedule once.  Config_preempt is a trivial issue: just
> increment the preempt counter and nobody will preempt on you while you
> run the magic quiescence test.

You have to increment the preempt counter in the threads, not in the
path that's testing for a quiescent state, so that when a thread does
set_finished_flag/dec_ref_count -> unlock -> exit, there can be no
preempt between the unlock and the exit.

This is all made simpler by using complete_and_exit() these days.

> Of course we can design a more complex method for accomplishing the same 
> thing, but why?

Well, first can you please explain what you mean by "calling __exit"?
Do you mean "calling cleanup_module()", which is the the function in a
module that's declared using the `module_exit' macro?

If so then I maintain there are non-trivial races that bite nearly every
use of MOD_DEC_USE_COUNT from within the module.

-- Jamie
