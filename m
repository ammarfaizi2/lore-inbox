Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318284AbSIMPXt>; Fri, 13 Sep 2002 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319668AbSIMPXt>; Fri, 13 Sep 2002 11:23:49 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:23951 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318284AbSIMPXs>;
	Fri, 13 Sep 2002 11:23:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 17:30:32 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209131705040.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0209131705040.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17psOu-0008AW-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 17:13, Roman Zippel wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Daniel Phillips wrote:
> 
> > > The exit function should always be called after the init function (even if
> > > it failed, I don't do it in the patch, that's a bug). The fs init/exit
> > > would like this then:
> >
> > Perhaps, but if so, the module itself should call the exit function in
> > its failure path itself.  Doing the full exit whether it needs to be
> > done or not is wasteful and opens up new DoS opportunities.
> 
> The exit itself can fail as well, so it has to be done by the module code
> anyway (until it suceeds).

That's debatable.  Arguably, a failed ->module_cleanup() should be
retried on every rmmod -a, but expecting module.c to just keep
retrying mindlessly on its own sounds too much like a busy wait.

> What DoS opportunities are there?

Suppose the module exit relies on synchronize_kernel.  The attacker
can force repeated synchronize_kernels, knowing that module.c will
mindlessly do a synchronize_kernel every time a module init fails,
whether needed or not.  Each synchronize_kernel takes an unbounded
amount of time to complete, across which module.c holds a lock.

> Module init failure is the exception
> case and usally needs further attention, so we could actually disable
> further attempts to load this module, unless the user tells us
> specifically so.

Sure, you can fix it by lathering on more complexity.  What you have
to do is explain why we should do that, when there is a simpler and
faster approach that doesn't introduce the problem in the first
place.

> > In the example you give below you must rely on register_filesystem
> > tolerating unregistering a nonexistent filesystem.  That's sloppy at
> > best, and you will have to ensure *every* helper used by ->exit is
> > similarly sloppy.
> 
> Why is that sloppy? E.g. kfree() happily accepts NULL pointers as well.

That is sloppy.  Different discussion.

I take it that the points you didn't reply to are points that you
agree with?  (The main point being, that we both advocate a simple,
two-method interface for module load/unload.)

-- 
Daniel
