Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSIWH1y>; Mon, 23 Sep 2002 03:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265163AbSIWH1x>; Mon, 23 Sep 2002 03:27:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58003 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265023AbSIWH1v>;
	Mon, 23 Sep 2002 03:27:51 -0400
Date: Mon, 23 Sep 2002 09:41:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <3D8E5329.3DAB4A1B@opersys.com>
Message-ID: <Pine.LNX.4.44.0209230929010.2659-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Karim Yaghmour wrote:

> >  - remove the 'event registration' and callback stuff. It just introduces
> >    unnecessery runtime overhead. Use an include file as a registry of
> >    events instead. This will simplify things greatly.
> 
> OK, basically then all the trace points call the trace driver directly.

yes. And in fact i'd suggest to not make it a driver but create a new
kernel/trace.c file - if it's a central mechanism then it should live in a
central place.

> > Why do you need a
> >    table of callbacks registered to an event? Nothing in your patches
> >    actually uses it ...
> 
> True, nothing in the patches actually uses it as this point. This was
> added with the mindset of letting other tools than LTT use the trace
> points already provided by LTT.

okay. The thing is that generic callbacks and data hooks in the task
structure are an invitation for various types of abuses - security and GPL
type abuses. People do get very nervous when seeing such stuff - eg. read
back Christoph Hellwig's comment from a few weeks ago. It's a red flag for
many people. Provide a clean and concentrated set of APIs, no callbacks,
no unnecessery hooks. I can see the technical reasons why you have added
it - it's in theory an extensible interface, but generally we tend to add
such stuff when it's needed - if it's needed at all.

> > Just use one tracing function that copies the
> >    arguments into a per-CPU ringbuffer. It's really just a few lines.
> 
> Sure, the writing of data itself is trivial. The reason you find the
> driver to be rather full is because of its need to do a couple of
> extra operations:
> - Get timestamp and use delta since begining of buffer to reduce
> trace size. (i.e. because of the rate at which traces are filled, it's
> essential to be able to cut down in the data written as much as possible).

yes - but even this one can also be solved by providing 2-3 macros that
each are hardcoded for one specific event length each - this should cover
about 90% of the events. Plus perhaps a more generic entry to handle the
longer/rarer event lengths, and the variable event length stuff.

> - Filter events according to event mask.

yes - this is handled by the event_allowed() function.

> - Copy extra data in case of some events (e.g. filenames). (We're
> working on ways to simplify this).

are you sure you want to copy filenames? File descriptor and inode numbers
ought to be enough.

> - Synchronize with trace daemon to save trace data. (A single per-CPU
> circular buffer may be useful when doing kernel devleopment, but user
> tracing often requires N buffers).
>
> In addition, because this data is available from user-space, you need to
> be able to deal with many buffers. For example, you don't want some
> random user to know everything that's happening on the entire system for
> obvious security reasons. So the tracer will need to be able to have
> per-user and per-process buffers.

in fact i have the feeling that you should not expose any of this to
ordinary users. Performance measurements are to be done by administrator
types - all this stuff has heavy memory allocation impact anyway.

in exactly which cases do you want to have multiple trace buffers? A
single (large enough if needed) buffer should be enough. This i think is
one of the core issues of your design.

	Ingo

