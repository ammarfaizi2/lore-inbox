Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSGKU1X>; Thu, 11 Jul 2002 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSGKU1X>; Thu, 11 Jul 2002 16:27:23 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:58796 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315805AbSGKU1V>;
	Thu, 11 Jul 2002 16:27:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Rusty's module talk at the Kernel Summit
Date: Thu, 11 Jul 2002 22:29:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207112059580.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207112059580.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SkZM-0002Vp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 21:48, Roman Zippel wrote:
> Hi,
> 
> On Thu, 11 Jul 2002, Daniel Phillips wrote:
> 
> > > Please check try_inc_mod_count(). It's already done.
> >
> > It's a good start, but it's not quite right.  Deregister_filesystem has to be
> > the authority on whether the module can be deleted or not, and there's no
> > interface for that at the moment.
> 
> That's right, but the filesystem code shows that this is not strictly
> necessary. In get_fs_type() you can't get access to a filesystem that will
> be removed, either it's first marked deleted or the use count is
> incremented, both are protected by the unload_lock. file_systems_lock now
> takes care that get_fs_type() doesn't see an invalid filesystem/owner
> pointer.

But that's crude and awkward.  Rmmod just needs deregister_filesystem in its
call chain and we're in great shape, without that fragile chain of
assumptions.

> > In short, it's close to the truth, but it's not quite there in its current
> > form.  Al said as much himself.
> 
> He was talking about a generic interface. I stared now long enough at
> that code, could anyone point me to where exactly is there a race in
> the filesystem code???

I believe the remaining race is rmmod-ret.  But it's not just a matter of
papering that over, the goal here is to get the thing into simplest form,
with an easily documentable interface that can be applied to the rest, or
almost all the rest of the module flavors.

I now have little doubt that even the complex module cases like (when it
happens) modular networking can be fit into the new module.  It comes
down to a pretty simple concept: you have a slow path *in the module*
that locks/unlocks the module in memory and knows the gory details of
active users, including spawned threads.  The fast paths don't have to
do any bookkeeping themselves.

Erm, by the way, there's the nasty detail of IO completion code in a
module.  This brings back the rmmod-ret race in a new incarnation;
even if the module's code keeps track of all submissions and
completions, there's no easy way to ensure the IO completion code
called from interrupt or soft irq context has returned to its caller.
I think the answer here is "just don't do it" - use the existing IO
completion handlers, and if they aren't good enough for some reason,
then we need a new, generic IO completion flavor that knows how to do
the required bookkeeping when it invokes the one in our module.
Bleh.

> IMO it's more complex than necessary (because it
> has to work around the problem that unregister can't fail), but it should
> work.

Let unregister be able to fail, why work around the borkness?  We
just need to be able to say -EBUSY to rmmod->remove so rmmod can duly
report that to the user.

> BTW this example shows also the limitation of the current module
> interface. It's impossible for a module to control itself, whether it can
> be unloaded or not. All code for this must be outside of this module,
> after __MOD_DEC_USE_COUNT() the module must not be touched anymore (so
> this call can't be inside of a module).

The module interface is under the knife, that's the whole point of
this.  Fortunately, what needs to be done is pretty minor.

-- 
Daniel
