Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSIPLzj>; Mon, 16 Sep 2002 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbSIPLzi>; Mon, 16 Sep 2002 07:55:38 -0400
Received: from dp.samba.org ([66.70.73.150]:16073 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261819AbSIPLzY>;
	Mon, 16 Sep 2002 07:55:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Fri, 13 Sep 2002 12:35:47 +0200."
             <Pine.LNX.4.44.0209131131210.28515-100000@serv> 
Date: Mon, 16 Sep 2002 11:49:22 +1000
Message-Id: <20020916120021.D87982C06B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209131131210.28515-100000@serv> you write:
> > I don't think of either of them as core, they are two problems.
> 
> Your init problem is easily solvable for try_inc_mod_count() users, just
> add a check for MOD_INITIALIZING, so it will fail during module init. On
> the other hand forcing everyone to use try_inc_mod_count is a serious
> problem.

Well, yes.  I think Daniel, yourself and I all share a dislike for
try_inc_mod_count() everywhere, but it *is* one solution.

> The exit function should always be called after the init function (even if
> it failed, I don't do it in the patch, that's a bug). The fs init/exit
> would like this then:

I disagree with this, but really, it's a detail.

> > I disagree with pushing the count into the filesystem structure: it
> > changes nothing except hide the fact that you're only keeping
> > reference counts for the sake of the module.  Filesystems are low
> > performance impact, but other subsystems really don't want that atomic
> > inc and dec for every access.
> 
> As I already said before, it doesn't has to be an atomic reference count.

Please explain?  It has to be atomic for all the interesting cases
(sure, fs mounting might be protected by a lock, but other things aren't).

> > 	if (down_interruptible(&module_mutex))
> > 		return -EINTR;
> 
> I really don't like that the global module lock is held during calls to
> the driver, e.g. it makes it impossible to request further modules during
> module load.

Yes, this is a problem.  It's a little icky to fix though, since you
must disallow the *same* module being loaded.  I can certainly do it:
well spotted.

> > This works better for my in ip_conntrack, since ideally the usage
> > count is a count of the number of packets we're tracking, which is
> > under control of the outside world, so I wanted an "rmmod -f".
> 
> The ip_conntrack problem is a variation of the LSM problem and both are a
> problem of the driver not of the module code.
> Basically you have to wait long enough until no new package can call to
> the module. This means after removing the hooks, you have to check how
> much packages are busy and wait for them to be processed.

Yes, which means an atomic reference count somewhere.  At the moment I
spin inside the cleanup() routine (not nice at all).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
