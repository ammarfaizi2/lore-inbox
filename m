Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319714AbSIMQDD>; Fri, 13 Sep 2002 12:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319715AbSIMQDC>; Fri, 13 Sep 2002 12:03:02 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:49551 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319714AbSIMQC7>;
	Fri, 13 Sep 2002 12:02:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 18:09:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209131740530.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0209131740530.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pt13-0008Aw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 17:55, Roman Zippel wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Daniel Phillips wrote:
> 
> > > The exit itself can fail as well, so it has to be done by the module code
> > > anyway (until it suceeds).
> >
> > That's debatable.  Arguably, a failed ->module_cleanup() should be
> > retried on every rmmod -a, but expecting module.c to just keep
> > retrying mindlessly on its own sounds too much like a busy wait.
> 
> That's not what I meant, if module_init fails the module goes directly to
> the cleanup state and the module code calls module_exit. Depending on this
> return value it continues to the exit state.

What I don't like about that is, module_exit doesn't know the exact state
module_cleanup was in when it encountered the error.  Look at how error
cleanup is done normally: a bunch of gotos that jump into a sequence that
releases resources in reverse order to the way they were allocated, so
that each initialization state has a corresponding error cleanup state.
How are you going to recover that level of precision if the error
cleanup is in a separate function?

> Further exit attempts (if necessary) are done on user request.

Yep, another point nailed down.  I'm keeping a list ;-)

> > > What DoS opportunities are there?
> >
> > Suppose the module exit relies on synchronize_kernel.  The attacker
> > can force repeated synchronize_kernels, knowing that module.c will
> > mindlessly do a synchronize_kernel every time a module init fails,
> > whether needed or not.  Each synchronize_kernel takes an unbounded
> > amount of time to complete, across which module.c holds a lock.
> 
> This can't happen:
> 
> 	if (hook) {
> 		hook = NULL;
> 		synchronize();
> 	}

Ah, this relys on synchronize_kernel only being called when necessary.
In general, that can only be known by the module itself.  This is one
more point we agree on, and which differs from Rusty's proposal.

> > > Module init failure is the exception
> > > case and usally needs further attention, so we could actually disable
> > > further attempts to load this module, unless the user tells us
> > > specifically so.
> >
> > Sure, you can fix it by lathering on more complexity.  What you have
> > to do is explain why we should do that, when there is a simpler and
> > faster approach that doesn't introduce the problem in the first
> > place.
> 
> It doesn't add any complexity (at least not to the kernel). A simple
> approach might be that a failed kernel module cannot be loaded with
> modprobe anymore, this sort of policy can be done in userspace.

User space complexity is an issue too, if there is an approach that
avoids complexity in both the kernel and user space.

> > I take it that the points you didn't reply to are points that you
> > agree with?  (The main point being, that we both advocate a simple,
> > two-method interface for module load/unload.)
> 
> Basically yes, it's just that your initial RFC was more confusing than
> helpful.

Humble apologies.  I will rewrite it now that I've had some practice
at explaining the points.  The second try should be much more concise
and backed with more actual code.  Some of which I will shamelessly
lift from you and Rusty ;-)

-- 
Daniel
