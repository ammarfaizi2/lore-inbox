Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264955AbSJPIMJ>; Wed, 16 Oct 2002 04:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSJPIMJ>; Wed, 16 Oct 2002 04:12:09 -0400
Received: from dp.samba.org ([66.70.73.150]:38120 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264955AbSJPIMH>;
	Wed, 16 Oct 2002 04:12:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Wed, 16 Oct 2002 04:59:10 +0200."
             <E181eOt-00044e-00@starship> 
Date: Wed, 16 Oct 2002 16:11:08 +1000
Message-Id: <20021016081803.A69AC2C09F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E181eOt-00044e-00@starship> you write:
> > Definitely.  We could simply allow schedule() to be called when
> > preempt is disabled, but it's a useful debugging tool to not do that.
> 
> It doesn't strike me as difficult or costly to accomodate this.

It's possible, of course.

> > And, of course, disabling preemption widely kind of defeats the point
> > of having a preemptive kernel 8(
> 
> It only needs to be turned off when unloading one of the "hard" modules.
> This would be an incrementing disable to accodate simultaneous unloads.
> During the unload your desktop might get a little bit less interactive,
> but that's better than not being able to unload at all.

It needs to be turned off when dealing with any interface which might
be used by one of the hard modules.  Which is pretty bad.

> > I really wish the security guys had gone down the macro path, with
> > something like
> > 
> > #define security_check(func, default_val, ...)
> > 	({ if (try_inc_mod_count(security_ops->owner))
> > 		security_ops->func(__VA_ARGS__);
> > 	   else
> > 		default_val;
> > 	})
> Then everybody would complain about the extra overhead, no matter how
> small it is.

These people didn't even whimper when an extra (useless) indirect
function call got added at all these points.  It's easy to make this
overhead only exist when a modular security module is in use (the
try_inc_mod_count wedge solution), and the overhead for non-modules is
one branch.

> Conceptually, are there any outstanding issues with "hard"
> way of unloading modules, assuming we can use the TRY_INC way[1] for
> "easy" modules?  One I don't recall being discussed, is the inherent
> difficulty of unhooking an interface like LSM, one function at a time.

Without preempt, it was relatively easy (my initial code preceeded
preempt).  With preempt, unless you touch the scheduler (I have code
for that too, Ingo doesn't like it anyway), a module can't control its
own reference counts.

Either way, how do you return "Pretend I wasn't here" in general, if
the module is being unloaded?  Only the infrastructure knows what to
do.

If a module cannot control its own reference counts, every exported
interface which can sleep needs to do the try_inc_modcount thing, or a
module which uses it cannot be unloaded.

Now, there remains a subtle problem with the try_inc_mod_count
approach in general.  It is the "spurious failure" problem, where
eg. a notifier cannot inc the module count, and so does not call the
registered notifier, but the module is still being initialized *OR* is
in the middle of an attempt to remove the module (which fails, and the
module is restored to "life").

Will this be a problem in general?  I don't think so, since I couldn't
find an example, but it's possible.

The major advantage of this scheme is the simplicity for module
authors (for the vast majority, no change).  Given the complete dogs
breakfast most module authors made of the current module count scheme,
that's a HUGE bonus.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
