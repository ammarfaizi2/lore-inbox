Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261917AbSIYFqh>; Wed, 25 Sep 2002 01:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261918AbSIYFqh>; Wed, 25 Sep 2002 01:46:37 -0400
Received: from dp.samba.org ([66.70.73.150]:26807 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261917AbSIYFqg>;
	Wed, 25 Sep 2002 01:46:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Wed, 25 Sep 2002 02:46:29 +0200."
             <Pine.LNX.4.44.0209241739460.338-100000@serv> 
Date: Wed, 25 Sep 2002 15:50:55 +1000
Message-Id: <20020925055151.E491F2C134@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209241739460.338-100000@serv> you write:
> Will the usage of an initramdisk be a requirement for 2.6? Otherwise I
> don't see a reason for such hurry. I don't know of Linus plans, but

That was the plan as far as I knew, hence recent klibc development.

> > 1) Registration interfaces (where callbacks can sleep) must keep track
> >    of reference counts of current users.
> 
> Rusty, read my lips: They only have to know whether they are busy. It's a
> _Bool not an atomic_t, e.g. this would work too:
> 
> 	if (!list_empty(users))
> 		return -EBUSY;

Yes, same thing.  Either way, register_xxx has a new requirement it
didn't have before, to keep track of the number of users.

> > 2) They must also implement two-stage delete (ie. proc_net_unlink()).
> 
> That's a "can" requirement.

You didn't show me how to get rid of my ip_conntrack problem without
it in the previous mail.

That's a *real* example we have today.  My code fixes it without
requiring a split of such interfaces.

> > See why I like the "extend try_inc_mod_count()" solution?  It's not
> > perfect, but it's already there and it's simple.
> 
> I explained already earlier why try_inc_mod_count() is a bad interface and
> renaming it doesn't change much. The consequences of its usage are not
> simple and its existence is not a good argument (at least not a technical
> one).

It's well understood, and already more widespread than any other real
solution.  All other approaches being equal, it wins.

> My approach offers a gradual switch to a much more flexible interface,

No, *every* unregister function needs to change.  What's gradual about
that?

> which doesn't force drivers to use only module approved synchronization
> methods. I keep most of the complexity (the module loading/relocation) in
> user space, that means my patch has far less impact on the kernel.

Look, you're wrong.  Keeping it in userspace is complex; I have lines
of code and bytecounts for you to read.  You can argue as much as you
like but I've been there, and you're simply not listening.

Moving this into the kernel has proven to be smaller, more flexible,
makes small initramdisks possible *and* makes the whole thing vastly
simpler.  What part of this don't you understand?

> My patch doesn't require new tools, but allows for an userspace
> insmod of similiar complexity as your kernel loader.

I challenge you to write a 64-bit kernel linker in a 32-bit userspace
in the codesize of my in-kernel linker.  I've tried it, and it's *not*
easy, and when you pile on all the extra kernel interfaces to support
it don't quite work, you end up *nowhere near*.

> Making module removal a config option is a really bad idea, either
> it works or it doesn't.

Maybe, but it gives an indication of how much it costs us to have this
feature, which is why I've kept it through development.  I blame
CONFIG_PREEMPT for getting me into bad habits. 8)

> Can we please judge the approaches on a technical level and forget for a
> moment the impending code freeze?

I started implementing module race solutions back in early 2001.  This
is not a rushed decision, sorry.

This is more heat than light now 8(
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
