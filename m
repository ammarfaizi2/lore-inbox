Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTAQAR7>; Thu, 16 Jan 2003 19:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbTAQAR7>; Thu, 16 Jan 2003 19:17:59 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:21512 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267338AbTAQAR6>; Thu, 16 Jan 2003 19:17:58 -0500
Message-ID: <3E2745E8.D8908505@linux-m68k.org>
Date: Fri, 17 Jan 2003 00:53:12 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
References: <20030115063349.A1521@almesberger.net> <20030116013125.ACE0F2C0A3@lists.samba.org> <20030115234258.E1521@almesberger.net> <3E26F6DC.D9150735@linux-m68k.org> <20030116155815.A29595@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Werner Almesberger wrote:

> > You can simplify this. All you need are the following simple functions:
> >
> > - void register();
> > - void unregister();
> > - int is_registered();
> > - void inc_usecount();
> > - void dec_usecount();
> > - int get_usecount();
> 
> I'm not sure if you, you're not changing the semantics.

See above functions as primitives, which one can use to build any other
resource management you want.
The module code does the get_usecount() test for every driver and if it
was zero it disables inc_usecount() and only then the driver is allowed
to unregister(). The module code has to add another is_active state for
this and is so actually adding more complexity to it.

> What I was
> describing was a non-blocking interface, e.g.
> 
>         if (!prepare_deregister(foo))
>                 return -E...;
>         if (!prepare_deregister(bar)) {
>                 undo_deregister(foo);
>                 return -E...;
>         }
>         commit_deregister(foo);
>         commit_deregister(bar);
>         return 0;

You are making it too complex, as you probably need an is_active state
as well, it would be just per interface instead of global.
If you really want to reduce complexity, all you can do, is to get rid
of the is_active state. For the majority of drivers such state isn't
needed at all, but it's currently forced on all drivers.
So to keep things simple, we should just finish shutting down the
driver, as soon as we started with it and don't restart or undo
anything. To avoid the sleeping we can also simply return -EBUSY and
continue later, so the cleanup could look like this:

	if (!ptr)
		return 0;
	if (is_registered())
		unregister();
	if (get_usecount())
		return -EBUSY;
	release();
	return 0;

This way the caller just needs to do the following, which can be called
as often as necessary:

	if (shutdown(ptr))
		return -EBUSY;
	ptr = NULL;

There is really no need to introduce extra states to make things more
complex.

bye, Roman


