Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSHIBtR>; Thu, 8 Aug 2002 21:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSHIBtR>; Thu, 8 Aug 2002 21:49:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60044 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S318116AbSHIBtQ>;
	Thu, 8 Aug 2002 21:49:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs API Updates 
In-reply-to: Your message of "Thu, 08 Aug 2002 11:21:35 MST."
             <Pine.LNX.4.44.0208080914060.1241-100000@cherise.pdx.osdl.net> 
Date: Fri, 09 Aug 2002 11:20:07 +1000
Message-Id: <20020809015454.D0A274521@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208080914060.1241-100000@cherise.pdx.osdl.net> you w
rite:
> That said, this is what I want to do:
> 
> Define helpers for parsing and formatting types; e.g. show_int() and
> store_int(). Objects' show and store methods can use those for the exposed
> attribute.
> 
> Support single static attributes by having something like this:
> 
> struct int_attribute {
> 	struct attribute	attr;
> 	show_int_t		show;
> 	store_int_t		store;
> 	int			* data;
> };
> 
> INT_ATTR(frobbable,0644);

Ok, that makes sense, except I prefer to build the interface in
layers, something like:

	ATTRIBUTE(frobbable,int,0644)
	=> ATTRIBUTE_CALL(frobbable,0644,show_int,store_int)

This still allows you to define your own types...

> What do you think? It definitely looks a lot like your PARAM stuff, and I 
> need to look again at what you wrote to see if I can tie in any more of 
> it. 

I think you've got all the good bits now 8)

> Of course, they don't have to be exposed to userspace in order to access
> them. This is a little further down the road, but by placing them (or
> pointers to them) in a special section, we could access attributes at boot
> time or module load time, like module parameters. 

This was my idea with "000" perm attributes: they are explicitly only
settable at module/kernel init (eg. they and their set/show functions
can be declared __init).

> I'm thinking that we could macro-ize locking for single static variables 
> as well. We could have something like:
> 
> rwlock_t mylock;
> 
> INT_ATTR_LOCKED(frobbable,0644,mylock);
> 
> which could then generate 
> 
> int get_frobbable(void);
> 
> void set_frobbable(int val);

Hmmm, how about:

	ATTRIBUTE_LOCKED(frobbable,int,0644,mylock)
	=> ATTRIBUTE_CALL(frobbable,0644,mylock,show_int_lock,store_int_lock)

With PARAM()/sysfs, I hit the wall when I tried to handle spinlocks,
rwlocks, semaphores, rwsemaphores, and backed off until I knew which
ones were actually useful 8)

This is the nice thing about having people actually using the code is
you can tell when you've hit the 90% mark (the weird cases can always
use their own callbacks).  I think trial-and-error is the best way to
introduce these kind of convenience functions.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
