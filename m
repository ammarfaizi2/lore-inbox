Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSGKGeV>; Thu, 11 Jul 2002 02:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317707AbSGKGeV>; Thu, 11 Jul 2002 02:34:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52122 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317667AbSGKGeT>;
	Thu, 11 Jul 2002 02:34:19 -0400
Date: Thu, 11 Jul 2002 02:37:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, adam@yggdrasil.com,
       R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-Reply-To: <20020711051232.5F93844F8@lists.samba.org>
Message-ID: <Pine.GSO.4.21.0207110155330.6250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jul 2002, Rusty Russell wrote:

> Sure, if you want to reduce the problem space to "modules which are a
> single fs/net/etc device driver" then we can *definitely* work
> something out.  This works because they have such a narrow and
> non-time-critical interface (who cares if we do a gratuitous
> atomic_inc on every fs mount?).

Note: "single" can be easily removed here.
 
> To really get this to work well, you should make sure such modules
> don't even need init and remove functions, by providing something
> like:
> 
> 	I_AM_A_FILESYSTEM_DRIVER("ramfs", ramfs_fs_type);

Not needed.  Really not needed (just wait for a couple of days until
I get the infrastructure for race-free register/unregister on generic
stuff into submittable shape).

> > I'd rather get the simple (== large) classes into decent shape and then
> > deal with what's left.  FVO "deal" possibly including "no rmmod for these
> > guys".
> 
> This was *entirely* my question at the Kernel Summit:
> 
> 	Are modules first class citizens?
> 	  Should everything be modular?
> 	  What complexity are we prepared to pay?

That depends.  As it is, currently we can pick _any_ part of the code
and declare it modular - matter of adding more gratitious exports and
maybe several "upcalls" (a-la recently killed devpts ones).

In _that_ sense of "module" questions are ridiculous - and answer are
"not in that generality"/"don't be silly"/"nowhere near the amount needed
to make __down_failed() modular".

However, absolute majority of modules are nowhere near that monstrous.
And actually we don't need to special-case "I'm a filesystem"/"I'm a
block device"/"I'm a framebuffer" - with a bit of massage all of these
and then some can be handled by the same code.  Again, wait for a couple
of days and I'll post the patches for testing.

Call them well-behaving modules if you wish.  For these the answers are
"yes"/"a lot of things can be"/"it's easy to handle".  What's left?
The pieces of code with really complex interfaces.  And guess what,
race-prevention is complex for these guys - and it's not just about
rmmod races.  E.g. parts of procfs, sysctls and devfs are still quite racy
even if you compile everything into the tree and remove all module-related
syscalls completely.

Again, complex API -> complex race-prevention.  No way around it and frankly,
I wouldn't want to have one - a lot of otherwise sane people are prone
to creating ugly and overcompicated interfaces and if there is something that
makes people think hard before doing that I'm only glad.

Nobody sane argues for allowing to make any piece of code modular
(hands up those who really want modular semaphores; good, now turn
face to the wall, the firing squad will be taking care of you in
a moment).

Every time you are creating an interface between the main kernel and
modules you _are_ responsible for protection against races, be they
rmmod-related or not.

When you are using existing interface - you are using existing protection.
And preferably - with minimal PITA on your side.

Nobody promises that some random piece of code you want to cut out will be
safe or easy to make safe.  As long as for absolute majority of drivers
we _can_ make things safe painlessly for driver - that's it.  You want
something tricky - you get to hold the pieces.

