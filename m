Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264557AbSIVWBi>; Sun, 22 Sep 2002 18:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264561AbSIVWBh>; Sun, 22 Sep 2002 18:01:37 -0400
Received: from nameservices.net ([208.234.25.16]:15602 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264557AbSIVWBg>;
	Sun, 22 Sep 2002 18:01:36 -0400
Message-ID: <3D8E3FA9.7389A61F@opersys.com>
Date: Sun, 22 Sep 2002 18:09:45 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209222124580.28832-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> On Sun, 22 Sep 2002, Karim Yaghmour wrote:
> 
> > Source bloat is certainly not desirable, as I said to my reply to Ingo.
> 
> (then how should i interpret 90% of the patches you sent to lkml today?)

Please refer to my other email where I explain why tracing is essential
to the day-to-day usage of any kernel. I don't think this is bloat and
the distributions which already include LTT certainly think it's quite
useful to their clients. In fact, most embedded distro actually make
the inclusion of LTT one of the main features with which they sell
Linux to their clients.

> > What is desirable, however, is to have a uniform tracing mechanism
> > replace the ad-hoc tracing mechanisms already implemented in many
> > drivers and subsystems.
> 
> exactly what is the problem with keeping intrusive debugging patches
> separate, just like all the other ones are kept separate?

Again, this is not a kernel debugging patch. As you yourself have stated
elsewhere, instrumenting a kernel for it to yield useful information to
a kernel developer makes the code "butt-ugly" (your words). The trace
statements currently inserted by LTT are clearly useless for any kernel
debugging whatsoever. The trace statements inserted are only useful for
the day-to-day tracing needs of any Linux user.

> It's not like
> this came out of the blue, per-CPU trace buffers (and other tracers) were
> done years ago for Linux.

I don't remember claiming to having implemented the first tracer. However,
I have been working very hard in putting together a rock solid tracer
which includes the best ideas of all existing tracers and offers a wide
range of tools for _any_ user to use. The decision of the attendees of
the RAS BoF at the OLS to standardize on LTT clearly goes in this direction.

Again, please understand that LTT is not a kernel debugger. Any look at
the set of trace statements inserted by LTT will reveal their low value
for kernel developers. These trace statements are meant for providing
users with in-depth and complete understanding of the system's dynamics.

> > The lockless scheme is pretty simple, instead of using a spinlock to
> > ensure atomic allocation of buffer space, the code does an
> > allocate-and-test routine where it tries to allocate space in the buffer
> > and tests if it succeeded in doing so. If so, then it goes on to write
> > the data in the event buffer, otherwise it tries again. In most cases,
> > it does this loop only once and in most worst cases twice.
> 
> (this is in essence a moving spinlock at the tail of the trace buffer -
> same problem.)

Hmm. No offense, but I think you ought to take a better look at the code.

Because events can occur at the interrupt level and on normal non-interrupt
path, any tracer that has to record a broad range of event types needs
to use spin_lock_irqsave(), which is what LTT's tracer used. Now, last
I checked, spin_lock_irqsave() calls on local_irq_save() which, on an
i386 for example, is defined as follows:
#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")

There's a cli() in there. No cli's in the lockless code. Among other
things, this makes the lockless code quite different from any usual
Linux spinlock.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
