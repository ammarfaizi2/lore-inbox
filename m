Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319552AbSIMICj>; Fri, 13 Sep 2002 04:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319553AbSIMICi>; Fri, 13 Sep 2002 04:02:38 -0400
Received: from dp.samba.org ([66.70.73.150]:4331 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319552AbSIMICT>;
	Fri, 13 Sep 2002 04:02:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Fri, 13 Sep 2002 04:19:18 +0200."
             <E17pg3H-0007pb-00@starship> 
Date: Fri, 13 Sep 2002 16:51:58 +1000
Message-Id: <20020913080709.9026B2C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17pg3H-0007pb-00@starship> you write:
> On Friday 13 September 2002 03:30, Rusty Russell wrote:
> > In message <Pine.LNX.4.44.0209121520300.28515-100000@serv> you write:
> > > The usecount is optional, the only important question a module must be
> > > able to answer is: Are there any objects/references belonging to the
> > > module? It's a simple yes/no question. If a module can't answer that, it
> > > likely has more problem than just module unloading.
> > 
> > Ah, we're assuming you insert synchronize_kernel() between the call
> > to stop and the call to exit?
> > 
> > In which case *why* do you check the use count *inside* exit_affs_fs?
> > Why not get exit_module() to do "if (mod->usecount() != 0) return
> > -EBUSY; else mod->exit();"?
> 
> Because mod->usecount may be a totally inadequate way of determining
> if a module is busy.  How does it work for LSM, for example?

As established previously: unless the hooks do it for you, you keep
track of it yourself before you sleep.

> > There's the other issue of symmetry.  If you allocate memory, in
> > start, do you clean it up in stop or exit?
> 
> Actually, I'm going to press you on why you think you even need a
> two stage stop.  I know you have your reasons, but I doubt any of
> the effects you aim at cannot be achieved with a single stage
> stop/exit.  Could you please summarize the argument in favor of the
> two stage stop?

Of course you can simulate a two-stage within a single-stage, of course,
by doing int single_stage(void) { stage_one(); stage_two(); }, so
"need" is a bit strong.

Basically, you can't do stage two until you know noone is using the
module, but you can do stage one at any time.  Basically stage 1
ensures that the refcount never *increases* by removing all external
references to the module (ie. deregister, etc).  Stage 2 then knows
that if the refcnt is zero, there's no race and it can destroy they
module data structures.

The synchronize_kernel() covers those "I was about to bump the module
count!" races, as long as noone explicitly sleeps before mod_inc, or
after mod_dec.

> > Similarly for other
> > resources: you call mod->exit() every time start fails, so that is
> > supposed to check that mod->start() succeeded?
> 
> He does?  That's not right.  ->start should clean up after itself if
> it fails, like any other good Linux citizen.

>From my reading, yes.

> > Of course, separating start into "init" and "start" allows you to
> > solve the half-initialized problem as well as clarify the rules.
> 
> I doubt it gives any new capability at all.

Since I explained what it does for you at the kernel summit, you
obviously aren't listening.  If you split registration interfaces into
reserve (can fail) and use (can't fail), then you do:

	int my_module_init(void)
	{
		int ret;
		ret = reserve_foo();
		if (ret != 0)
			return ret;
		ret = reserve_bar();
		if (ret != 0)
			unreserve_foo();
		return ret;
	}

	void my_module_start(void)
	{
		use_foo();
		use_bar();
	}

Note the symmetry here with the exit case: noone can actually use the
module until my_module_start is called, so even if the reserve_bar()
fails, we're safe.

> The same with the entrenched separation at the user level between
> create and init module: what does it give you that an error exit
> from a single create/init would not?

That's done for entirely different reasons, as the userspace linker
needs to know the address of the module.

> Sure, I know it's not going to change, but I'd like to know what the
> thinking was, and especially, if there's a non-bogus reason, I'd
> like to know it.

You should probably start playing with my code if you're really
interested.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
