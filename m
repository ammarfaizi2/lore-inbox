Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319690AbSIMPvE>; Fri, 13 Sep 2002 11:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319693AbSIMPvD>; Fri, 13 Sep 2002 11:51:03 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:30474 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319690AbSIMPu6>; Fri, 13 Sep 2002 11:50:58 -0400
Date: Fri, 13 Sep 2002 17:55:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17psOu-0008AW-00@starship>
Message-ID: <Pine.LNX.4.44.0209131740530.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:

> > The exit itself can fail as well, so it has to be done by the module code
> > anyway (until it suceeds).
>
> That's debatable.  Arguably, a failed ->module_cleanup() should be
> retried on every rmmod -a, but expecting module.c to just keep
> retrying mindlessly on its own sounds too much like a busy wait.

That's not what I meant, if module_init fails the module goes directly to
the cleanup state and the module code calls module_exit. Depending on this
return value it continues to the exit state. Further exit attempts (if
necessary) are done on user request.

> > What DoS opportunities are there?
>
> Suppose the module exit relies on synchronize_kernel.  The attacker
> can force repeated synchronize_kernels, knowing that module.c will
> mindlessly do a synchronize_kernel every time a module init fails,
> whether needed or not.  Each synchronize_kernel takes an unbounded
> amount of time to complete, across which module.c holds a lock.

This can't happen:

	if (hook) {
		hook = NULL;
		synchronize();
	}

> > Module init failure is the exception
> > case and usally needs further attention, so we could actually disable
> > further attempts to load this module, unless the user tells us
> > specifically so.
>
> Sure, you can fix it by lathering on more complexity.  What you have
> to do is explain why we should do that, when there is a simpler and
> faster approach that doesn't introduce the problem in the first
> place.

It doesn't add any complexity (at least not to the kernel). A simple
approach might be that a failed kernel module cannot be loaded with
modprobe anymore, this sort of policy can be done in userspace.

> I take it that the points you didn't reply to are points that you
> agree with?  (The main point being, that we both advocate a simple,
> two-method interface for module load/unload.)

Basically yes, it's just that your initial RFC was more confusing than
helpful.

bye, Roman

