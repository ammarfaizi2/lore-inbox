Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbSIPVcJ>; Mon, 16 Sep 2002 17:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbSIPVcJ>; Mon, 16 Sep 2002 17:32:09 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:31500 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263084AbSIPVcH>; Mon, 16 Sep 2002 17:32:07 -0400
Date: Mon, 16 Sep 2002 23:36:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface 
In-Reply-To: <20020916120021.D87982C06B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209161756540.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Sep 2002, Rusty Russell wrote:

> > Your init problem is easily solvable for try_inc_mod_count() users, just
> > add a check for MOD_INITIALIZING, so it will fail during module init. On
> > the other hand forcing everyone to use try_inc_mod_count is a serious
> > problem.
>
> Well, yes.  I think Daniel, yourself and I all share a dislike for
> try_inc_mod_count() everywhere, but it *is* one solution.

And it's an overly complex one, with my patch I demonstrated, how it could
be removed and made simpler.

> > The exit function should always be called after the init function (even if
> > it failed, I don't do it in the patch, that's a bug). The fs init/exit
> > would like this then:
>
> I disagree with this, but really, it's a detail.

I wouldn't call it a detail, it's an important part of the complete module
load/unload mechanism.

> > > I disagree with pushing the count into the filesystem structure: it
> > > changes nothing except hide the fact that you're only keeping
> > > reference counts for the sake of the module.  Filesystems are low
> > > performance impact, but other subsystems really don't want that atomic
> > > inc and dec for every access.
> >
> > As I already said before, it doesn't has to be an atomic reference count.
>
> Please explain?  It has to be atomic for all the interesting cases
> (sure, fs mounting might be protected by a lock, but other things aren't).

Let me explain it in a larger context. You and Daniel are making it really
more complex than necessary. Only the module itself can really answer the
question whether it's safe to unload or not. So all the module code
needs to do is some general module management and ask the module somehow,
whether it's safe to unload, when the user requests it. The easiest way
for modules to check for this is to use counters, it's very simple and
covers the majority of modules.
The few modules that don't want/can't use counters can use whatever they
want and they usually know better how to synchronize with the part of the
kernel where they installed their hooks into, without disturbing too much
other parts of the kernel.
I really don't like the synchronize calls as general mechanism, either
they have to to do too much and possibly disturb other parts without good
reason or modules have to take care of it (e.g. don't call somehow
schedule() without extra protection). This makes the whole synchronize
mechanism very fragile, which I'd prefer to keep it in the modules which
really need it, where it can be better controlled.

> > The ip_conntrack problem is a variation of the LSM problem and both are a
> > problem of the driver not of the module code.
> > Basically you have to wait long enough until no new package can call to
> > the module. This means after removing the hooks, you have to check how
> > much packages are busy and wait for them to be processed.
>
> Yes, which means an atomic reference count somewhere.  At the moment I
> spin inside the cleanup() routine (not nice at all).

Packets don't come out of nowhere. I'm not familiar with the locking
there, but it should be possible to use a cheap nonatomic count, which is
read only accessible outside the normal locking.

bye, Roman

