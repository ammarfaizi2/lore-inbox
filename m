Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSGQUaO>; Wed, 17 Jul 2002 16:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSGQUaO>; Wed, 17 Jul 2002 16:30:14 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:54974 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316672AbSGQUaN>;
	Wed, 17 Jul 2002 16:30:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] new module format
Date: Wed, 17 Jul 2002 22:34:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207172146590.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207172146590.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UvVM-0004Pp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 22:12, Roman Zippel wrote:
> Hi,
> 
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
> 
> > > 1. Properly fixing module races: I'm playing with a init/start/stop/exit
> > > model, this has the advantage that we can stop anyone from reusing a
> > > module and we only have to wait for remaining users to go away until we
> > > can safely unload the module.
> >
> > I'm satisfied that, for filesystems at least, all the module races can be
> > solved without adding start/stop, and I will present code in due course.
> 
> The start/stop methods are not needed to fix the races, they allow better
> control of the unload process.

I'm afraid it must show that I didn't read the previous threads closely 
enough, but what is the specific benefit supposed to be, if not to address
the races?

> > However, Rusty tells me there are harder cases than filesystems.  At this
> > point I'm waiting for a specific example.
> 
> For filesystems it's only simpler because they only have a single entry
> point, but the basic problem is always the same.

What do you mean by single entry point?  Mount?  Register_filesystem?
Lowlevel activity on a filesystem is certainly not restricted to a single 
entry point.

> We have to protect
> against module load/unload and unregister. Without an interface change we
> will have to add module owner pointers everywhere and we will see
> contention on the unload_lock due to try_inc_mod_count.

It makes perfect sense for mount to be able to know which module implements 
its filesystem.  I do not see why updating every mount-like thing in the 
system is bad, if it's the best interface.

It's really hard to see why contention on a slow-path lock is anything to 
worry about.  Anyway, it's not hard to fix the locking model so the lock
only covers the transitions of state bits, instead of all of free_module.

So, I'm still hoping to hear a substantive reason why the filesystem model
can't be applied in general to all forms of modular code.  To remind you
of the issue: the proposition is that the subsystem in the module is
always capable of knowing when the module is quiescent, because it does
whatever is necessary to keep track of the users and what they're doing.

-- 
Daniel
