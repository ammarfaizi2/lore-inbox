Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264486AbSIVTKr>; Sun, 22 Sep 2002 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264488AbSIVTKr>; Sun, 22 Sep 2002 15:10:47 -0400
Received: from nameservices.net ([208.234.25.16]:33512 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264486AbSIVTKq>;
	Sun, 22 Sep 2002 15:10:46 -0400
Message-ID: <3D8E179B.FCD06E7@opersys.com>
Date: Sun, 22 Sep 2002 15:18:51 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> On Sun, 22 Sep 2002, Roman Zippel wrote:
> > What about other developers, which only want to develop a simple driver,
> > without having to understand the whole kernel? Traces still work where
> > printk() or kgdb don't work. I think it's reasonable to ask an user to
> > enable tracing and reproduce the problem, which you can't reproduce
> > yourself.
> 
> That makes adding source bloat ok? I've debugged some drivers with
> dprintk() style tracing, and it often makes the code harder to follow,
> even if it eds up being compiled away.

Source bloat is certainly not desirable, as I said to my reply to Ingo.
What is desirable, however, is to have a uniform tracing mechanism
replace the ad-hoc tracing mechanisms already implemented in many drivers
and subsystems.

> >From what I've seen from the LTT thing, it's too heavy-weight to be good
> for many things (taking SMP-global locks for trace events is _not_ a good
> idea if the trace is for doing things like doing performance tracing,
> where a tracer that adds synchronization fundamentally _changes_ what is
> going on in ways that have nothing to do with timing).

Sure, but there are no locks anymore in the tracer with the addition of
the lockless code which is part of the set of patches I just sent. So yes,
this was a problem with LTT, but it isn't anymore.

The lockless scheme is pretty simple, instead of using a spinlock to
ensure atomic allocation of buffer space, the code does an allocate-and-test
routine where it tries to allocate space in the buffer and tests if it
succeeded in doing so. If so, then it goes on to write the data in the
event buffer, otherwise it tries again. In most cases, it does this loop
only once and in most worst cases twice.

> I suspect we'll want to have some form of event tracing eventually, but
> I'm personally pretty convinced that it needs to be a per-CPU thing, and
> the core mechanism would need to be very lightweight. It's easier to build
> up complexity on top of a lightweight interface than it is to make a
> lightweight interface out of a heavy one.

I fully agree with the requirements you list. LTT is already lightweight
in terms of its performance impact on the system and it doesn't use any
form of locking anymore. The only remaining issue is the use of per-CPU
buffers and this is currently being worked on by the team at IBM that
had already developed the lockless scheme and will be ready shortly.
However, there clearly is no more lock contention.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
