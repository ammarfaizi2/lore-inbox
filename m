Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSGHAVv>; Sun, 7 Jul 2002 20:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGHAVu>; Sun, 7 Jul 2002 20:21:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39442 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316675AbSGHAVt>; Sun, 7 Jul 2002 20:21:49 -0400
Date: Sun, 7 Jul 2002 20:18:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Werner Almesberger <wa@almesberger.net>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
In-Reply-To: <20020707220933.B11999@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.3.96.1020707201054.19682A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2002, Jamie Lokier wrote:

> Werner Almesberger wrote:
> > Okay, here's an almost correct example (except for the usual
> > return-after-removal, plus an unlikely data race described
> > below). foo_1 runs first:
> 
> This can be fixed if we assume a way to ask "is any CPU still executing
> module code?".
> 
> To do this, have the `free_module' function use `smp_call_function' to
> ask every CPU "are you executing code for module XXX?".  The question is
> answered by a routine which walks the stack, checking the instruction
> pointer at each place on the stack to see whether it's inside the module
> of interest.
> 
> Yes this is complex, but it's not that complex -- provided you can rely
> on stack walking to find the module.  (It wouldn't work if x86 used
> -fomit-frame-pointer, for example).

Complex, may not be reliable, and the question is "are you now or will you
ever run code in or for module XXX" because there may be pointers for
threads, interrupt handlers, etc. Gets ugly doing it from the back.

I think you have to do it with the use count, and there may well be
modules you can't remove safely. But to add re-init code to modules,
define new ioctls to call it, etc, etc, doesn't seem satisfactory. I think
we really need to bump the use counter more carefully, to really know when
a module is in use, and when we can clear it out.

The smp case looks doable, the preempt case may be harder. I really like
the idea of simply queueing a remove and then doing it when the use count
drops to zero. But we have have to provide a "don't use" to keep new
things out. That's hard.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

