Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317766AbSGKFJc>; Thu, 11 Jul 2002 01:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSGKFJb>; Thu, 11 Jul 2002 01:09:31 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55506 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317766AbSGKFJa>;
	Thu, 11 Jul 2002 01:09:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, adam@yggdrasil.com, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Wed, 10 Jul 2002 23:30:12 -0400."
             <Pine.GSO.4.21.0207102311290.6250-100000@weyl.math.psu.edu> 
Date: Thu, 11 Jul 2002 15:13:02 +1000
Message-Id: <20020711051232.5F93844F8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0207102311290.6250-100000@weyl.math.psu.edu> you write:
> > So this TLB argument alone is not sufficient :-)
> > I do concur on the "ipv4 as module is difficult to
> > get correct" argument however.
> 
> Sure, but consider the amount of tricky modules and amount of easy ones.
> net/ipv4/*.c _is_ tricky; so much that having system with many parts of
> such complexity would be extremely painful.
> 
> IOW, yes, we have some very tricky interfaces between the parts of kernel;
> and their trickiness alone guarantees that we don't want to have them
> breeding.  Stuff that genuinely needs complex interfaces is *not* something
> you want to be mass-produced.

Sure, if you want to reduce the problem space to "modules which are a
single fs/net/etc device driver" then we can *definitely* work
something out.  This works because they have such a narrow and
non-time-critical interface (who cares if we do a gratuitous
atomic_inc on every fs mount?).

To really get this to work well, you should make sure such modules
don't even need init and remove functions, by providing something
like:

	I_AM_A_FILESYSTEM_DRIVER("ramfs", ramfs_fs_type);

> I'd rather get the simple (== large) classes into decent shape and then
> deal with what's left.  FVO "deal" possibly including "no rmmod for these
> guys".

This was *entirely* my question at the Kernel Summit:

	Are modules first class citizens?
	  Should everything be modular?
	  What complexity are we prepared to pay?

We *can* do anything, up to and including modules which hand out
references to themselves in interrupt context, and dealing with the
race between "my module count is zero" and "oops, someone jumped in
before I had deactivated myself" without using try_inc_mod_count.

But *should* we?  The solution, for those of strong stomach, looks
something like this:

	Each module implements: init(), start(), stop(), reinit(), destroy().
	Each registerable interface takes a "struct module *" parameter.
	Every call through a function ptr does "inc_mod_count(struct->module)"
		(Of course, if you make assumptions about a struct
		containing only functions from the same module or
		in-kernel ones, and knowing that some strategy
		functions are always called before others, you can
		optimize this).

I don't think we're disagreeing, but I did want to clarify,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
