Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTAOIPu>; Wed, 15 Jan 2003 03:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAOIPu>; Wed, 15 Jan 2003 03:15:50 -0500
Received: from dp.samba.org ([66.70.73.150]:41949 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265816AbTAOIPt>;
	Wed, 15 Jan 2003 03:15:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Wed, 15 Jan 2003 04:31:47 -0300."
             <20030115043147.A1840@almesberger.net> 
Date: Wed, 15 Jan 2003 19:16:24 +1100
Message-Id: <20030115082444.062EF2C0F0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030115043147.A1840@almesberger.net> you write:
> kuznet@ms2.inr.ac.ru wrote:
> > Somewhat overdone.
> 
> I think it would be nice to introduce in 2.7 a shutdowncall
> (*) function class for modules that works like exitcall, but
> with the following differences:
> 
>  - does not return before the module has really de-registered
>    itself everywhere, including synchronization with any
>    callbacks, etc.
>  - has a return code, and can fail if it would have to sleep
>    for a possibly long time
> 
> Before calling the shutdown function, all symbols exported by
> the module are hidden, and after the shutdown functions returns,
> the module can be unloaded.

This already happens.  This is why all accesses to the module are
protected by try_module_get().

I've analyzed dozens of "here's my implementation idea" mails over the
last two years.  Here's the executive summary:

1) It's simply not a good idea to force 1600 modules to change, no
   matter what timescale.  And changing it in a way that is *more*,
   not *less* complex is even worse.

2) It's bad enough to force the interfaces to change: at least the
   primitive they are to use is one many of them are already using,
   and is very simple to understand.

Rusty.
PS.  The *implementation* flaw in your scheme: someone starts using a
     module as you try to deregister it.  Either you re-register the
     module (ie. you can never unload security modules), or you leave
     it half unloaded (even worse).
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
