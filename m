Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbSIYLbw>; Wed, 25 Sep 2002 07:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261959AbSIYLbw>; Wed, 25 Sep 2002 07:31:52 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:44043 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261958AbSIYLbt>; Wed, 25 Sep 2002 07:31:49 -0400
Date: Wed, 25 Sep 2002 13:36:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020925055151.E491F2C134@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209251147250.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Sep 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0209241739460.338-100000@serv> you write:
> > Will the usage of an initramdisk be a requirement for 2.6? Otherwise I
> > don't see a reason for such hurry. I don't know of Linus plans, but
>
> That was the plan as far as I knew, hence recent klibc development.

Why this hurry? What is so badly broken, that it must be fixed before 2.6?

> > > 1) Registration interfaces (where callbacks can sleep) must keep track
> > >    of reference counts of current users.
> >
> > Rusty, read my lips: They only have to know whether they are busy. It's a
> > _Bool not an atomic_t, e.g. this would work too:
> >
> > 	if (!list_empty(users))
> > 		return -EBUSY;
>
> Yes, same thing.  Either way, register_xxx has a new requirement it
> didn't have before, to keep track of the number of users.

It's not a new requirement, before it had to use try_inc_mod_count() for
this.

> > > 2) They must also implement two-stage delete (ie. proc_net_unlink()).
> >
> > That's a "can" requirement.
>
> You didn't show me how to get rid of my ip_conntrack problem without
> it in the previous mail.
>
> That's a *real* example we have today.  My code fixes it without
> requiring a split of such interfaces.

Where is the problem? You can use your bigref like you already
demonstrated and proc_net_destroy() also does a call to proc_net_unlink().

> > > See why I like the "extend try_inc_mod_count()" solution?  It's not
> > > perfect, but it's already there and it's simple.
> >
> > I explained already earlier why try_inc_mod_count() is a bad interface and
> > renaming it doesn't change much. The consequences of its usage are not
> > simple and its existence is not a good argument (at least not a technical
> > one).
>
> It's well understood, and already more widespread than any other real
> solution.  All other approaches being equal, it wins.

I don't get this, sorry.

> > My approach offers a gradual switch to a much more flexible interface,
>
> No, *every* unregister function needs to change.  What's gradual about
> that?

It can be done gradually? The interfaces can be changed step by step.
Interfaces which already use try_inc_mod_count() can be converted
trivially as demonstrated by my patch.

> Moving this into the kernel has proven to be smaller, more flexible,
> makes small initramdisks possible *and* makes the whole thing vastly
> simpler.  What part of this don't you understand?

So your argument is to move everything into the kernel to make the
initramdisk simpler?

> > My patch doesn't require new tools, but allows for an userspace
> > insmod of similiar complexity as your kernel loader.
>
> I challenge you to write a 64-bit kernel linker in a 32-bit userspace
> in the codesize of my in-kernel linker.  I've tried it, and it's *not*
> easy, and when you pile on all the extra kernel interfaces to support
> it don't quite work, you end up *nowhere near*.

Rusty, have you understood, what my new module layout is all about? So far
I haven't heard a single argument for or against it. I haven't explained
it yet in detail, but I didn't got any questions about it either.
If you understood it, it will be certainly no problem for you to show me,
where my claim is flawed.

> > Making module removal a config option is a really bad idea, either
> > it works or it doesn't.
>
> Maybe, but it gives an indication of how much it costs us to have this
> feature, which is why I've kept it through development.

If we continue to build on bad interfaces, it will certainly cost us a
lot.

> > Can we please judge the approaches on a technical level and forget for a
> > moment the impending code freeze?
>
> I started implementing module race solutions back in early 2001.  This
> is not a rushed decision, sorry.

What does this prove?
You're trying to get a monster patch into the kernel, which is mostly only
tested by you and breaks most architectures without good (urgent) reason.
Sorry, that I can't really feel comfortable with this.

bye, Roman

