Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSJQBup>; Wed, 16 Oct 2002 21:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbSJQBup>; Wed, 16 Oct 2002 21:50:45 -0400
Received: from dsl-213-023-039-240.arcor-ip.net ([213.23.39.240]:26789 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261610AbSJQBuo>;
	Wed, 16 Oct 2002 21:50:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Thu, 17 Oct 2002 03:57:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20021016230712.713B12C076@lists.samba.org>
In-Reply-To: <20021016230712.713B12C076@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E181zuY-0004Fl-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 00:48, Rusty Russell wrote:
> > On Wednesday 16 October 2002 08:11, Rusty Russell wrote:
> > > It needs to be turned off when dealing with any interface which might
> > > be used by one of the hard modules.  Which is pretty bad.
> > 
> > As far as I can see, preemption only has to be disabled during the 
> > synchronize_kernel phase of unloading that one module, and this requirement 
> > is inherited neither by dependant or depending modules.
> 
> No, someone could already have been preempted before you start
> synchronize_kernel().

I don't get that.  The sequence is:

  - turn off preemption
  - unhook call points
  - synchronize_kernel
  - ...

which doesn't leave any preemption hole that I can see, so I can't comment
on a couple of the other points until you clear that one up.

> > > Now, there remains a subtle problem with the try_inc_mod_count
> > > approach in general.  It is the "spurious failure" problem, where
> > > eg. a notifier cannot inc the module count, and so does not call the
> > > registered notifier, but the module is still being initialized *OR* is
> > > in the middle of an attempt to remove the module (which fails, and the
> > > module is restored to "life").
> > 
> > For pure counting-style modules, it's easy to avoid this problem: the module
> > is placed in the can't-increment state if and only if the current count is 
> > zero, and from that point on we know the unload will either succeed or fail 
> > with an error.
> 
> Still a race between the zero check and the can't-increment state
> setting.

But that one is easy: the zero check just takes the same spinlock as 
TRY_INC_MOD_COUNT, then sets can't-increment only in the case the count
is zero, considerably simpler than:

> This is what my current code does: rmmod itself checks (if
> /proc/modules available), then the kernel sets the module to
> can't-increment, then checks again.  If the non-blocking flag is set,
> it then re-animates the module and fails, otherwise it waits.

and leaves no window for spurious failure.  The still-initializing case is
also easy, e.g., a filesystem module simply doesn't call register_filesystem
until it's completely ready to service calls, so nobody is able to do
TRY_INC_MOD_COUNT.

> BTW, current patchset (2.5.43):

Thanks, I'll read them all on the 21st ;-)  The other thing I need to read
closely is Roman's strategy for changing the module format, and the weird
linker connections.

> ...The second is the "die-mother-fucker-die"
> version, which taints the kernel and just removes the damn thing.  For
> most people, this is better than a reboot, and will usually "work".

Is there a case where removing a module would actually help?  What is
the user going to do next, try to reinsert the same module?

> http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/force-unload.patch.gz
> [ Doesn't apply currently, needs updating ]

ERROR 404: Not Found.

-- 
Daniel
