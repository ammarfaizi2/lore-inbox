Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264609AbSIVX1R>; Sun, 22 Sep 2002 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264613AbSIVX1R>; Sun, 22 Sep 2002 19:27:17 -0400
Received: from nameservices.net ([208.234.25.16]:38902 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264609AbSIVX1P>;
	Sun, 22 Sep 2002 19:27:15 -0400
Message-ID: <3D8E5329.3DAB4A1B@opersys.com>
Date: Sun, 22 Sep 2002 19:32:57 -0400
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
References: <Pine.LNX.4.44.0209230032350.28641-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the recommendations, we will certainly direct the development
to address these issues.

Ingo Molnar wrote:
>  - remove the 'event registration' and callback stuff. It just introduces
>    unnecessery runtime overhead. Use an include file as a registry of
>    events instead. This will simplify things greatly.

OK, basically then all the trace points call the trace driver directly.

> Why do you need a
>    table of callbacks registered to an event? Nothing in your patches
>    actually uses it ...

True, nothing in the patches actually uses it as this point. This was
added with the mindset of letting other tools than LTT use the trace
points already provided by LTT.

> Just use one tracing function that copies the
>    arguments into a per-CPU ringbuffer. It's really just a few lines.

Sure, the writing of data itself is trivial. The reason you find the
driver to be rather full is because of its need to do a couple of
extra operations:
- Get timestamp and use delta since begining of buffer to reduce
trace size. (i.e. because of the rate at which traces are filled, it's
essential to be able to cut down in the data written as much as possible).
- Filter events according to event mask.
- Copy extra data in case of some events (e.g. filenames). (We're working on
ways to simplify this).
- Synchronize with trace daemon to save trace data. (A single per-CPU
circular buffer may be useful when doing kernel devleopment, but user
tracing often requires N buffers).

In addition, because this data is available from user-space, you need
to be able to deal with many buffers. For example, you don't want some
random user to know everything that's happening on the entire system
for obvious security reasons. So the tracer will need to be able to
have per-user and per-process buffers.

The writing of the data itself is not a problem, the real problem is
having a flexible lightweight tracer that can be used in a variety
of different situations.

>  - do not disable interrupts when writing events. I used this method in
>    a tracer and it works well. Just get an irq-safe index to the trace
>    ring-buffer and fill it in. [eg. on x86 incl can be used for this
>    purpose.]

Done.

>  - get rid of p->trace_info and the pending_write_count - it's completely
>    unnecessery.

But then how do we keep track of whether processes have pointers to the
trace buffer or not? We need to be able to allocate/free trace buffers
in runtime. That's what the pending_write_count is for. A buffer can't
be freed is someone still has pending writes. Alternatives are welcomed.

Also, though this hasn't been implemented yet, users may desire to trace a
certain set of processes and trace_info could include a flag to this end.

>  - drivers/trace/tracer.c is a complex mess of strange coding style and
>    #ifdefs, it's not proper Linux kernel code.

We'll fix that.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
