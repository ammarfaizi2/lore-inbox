Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRATD1o>; Fri, 19 Jan 2001 22:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRATD1d>; Fri, 19 Jan 2001 22:27:33 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:58591 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129444AbRATD1V>; Fri, 19 Jan 2001 22:27:21 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Michael Lindner" <mikel@att.net>
Cc: <linux-kernel@vger.kernel.org>, "Chris Wedgwood" <cw@f00f.org>
Subject: RE: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  available
Date: Fri, 19 Jan 2001 19:27:19 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKIEIINCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3A68F855.6F16F152@att.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks CW and DS for the prompt replies. However, although each
> addressed the (flawed) example I included, neither addressed the
> problem described in the text.
>
> I wrote:
> > > If select() is waiting for data to become available on a
> > > TCP socket FD, and
> > > data becomes available, it doesn't return until the next clock tick.
>
> David Schwartz wrote:
> > This program doesn't demonstrate anything except that
> > Linux's sleep time is
> > granular. This shouldn't be news to anyone. If you don't force
> > a reschedule,
> > everything works the way it's supposed to:

> The sample program you included doesn't show anything other
> than that select() doesn't sleep at all if there's already
> data available when select() starts. That was not my claim
> either.

	Correct. Select doesn't sleep unless it has to.

> My problem is that if data is NOT available when select()
> starts, but becomes available immediately afterwards, select()
> doesn't wake up immediately, but sleeps for 1/100 second.

	How can you tell when select wakes up the process? What you are seeing has
nothing whatsoever to do with select and simply has to do with the fact that
the kernel does not give the CPU to a process the second that process may
want it.

> In other words, select doesn't wake up immediately when
> data becomes available, but on the next clock tick.

	Right. The process becomes eligible to run -- it's no longer blocked. The
scheduler then schedules it whenever it feels like it.

> This is
> not the experience I've had with any other OS I've used,
> and is a source of great latency in my application. Since
> I am passing data from one process to another, and that
> data is generated as a result of data received via a select(),
> the next delivery occurs a clock tick later, with the machine
> mostly idle.

	If you have scheduling latency requirements, you MUST communicate them to
the scheduler. If your process had an altered scheduling class, then you
would be right -- it should get the CPU immediately. Otherwise, there's no
reason for the scheduler to give that process the CPU immediately.

> It can be argued that there's no law governing the latency of
> select() waking up, and that my application is expecting
> too much. Yet, it runs on other UNIXes and Windows, and I'd
> like to be able to get the same high performance out of Linux.

	Then tell that to the scheduler.

> P.S. Chris Wedgwood writes:
> 	"The time passed to slect is a _minimum_ "
>
> but the man page for select says:
> 	"timeout  is  an  upper bound on the amount of time elapsed
>        before select returns."
>
> who is right?

	This should read "before select returns the process to the list of runnable
processes".

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
