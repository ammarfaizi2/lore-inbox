Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUKPVPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUKPVPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUKPVPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:15:34 -0500
Received: from alog0072.analogic.com ([208.224.220.87]:18048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261815AbUKPVOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:14:51 -0500
Date: Tue, 16 Nov 2004 16:14:39 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Work around a lockup?
In-Reply-To: <Pine.LNX.4.53.0411162145240.20538@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411161556420.1963@chaos.analogic.com>
References: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411161456030.983@chaos.analogic.com>
 <Pine.LNX.4.53.0411162111440.32739@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411161524450.1562@chaos.analogic.com>
 <Pine.LNX.4.53.0411162145240.20538@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1992984896-1100639679=:1963"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-1992984896-1100639679=:1963
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Nov 2004, Jan Engelhardt wrote:

>> If there is a continuous loop inside the kernel, something outside
>> the kernel (you) are never going to get control except from an
>> interrupt. The keyboard interrupt is going to let you see what
>> is happening, but you won't get any real control because the
>> kernel is not a task. If the kernel were a task (like VMS),
>
> (Surprise.) Yes, I can still ping it and initiate a connection (i.e. the =
queue
> accepts it, because someone did listen() on the socket), but that's all. =
I bet
> that's due to the network card generating an interrupt.
>
>> you could (maybe) context-switch out of the kernel. But,
>> the kernel is some common code that executes on behalf of
>> all the tasks in the context of "current". If the current
>> task is stuck inside the kernel code, it has nowhere to go.
>
> Wait, an interrupt can ... well interrupt a task, /even/ if it is in kern=
el
> mode, otherwise jiffies would not get incremented. So, would not it be
> possible
> to call some sort of schedule() when do_timer() (or similar) is run?
> Like:
>  foreach p in runqueue {
>    if(p->location=3D=3DKERNELSPACE && exceeded-kernelspace-timeslic) {
>      switch_to(rq->next); // "never returns"
>    }
>  }
>

You can't schedule from an interrupt because, if (when) the
scheduled task calls the kernel to do something, the return
address, context info, etc., of the previously-interrupted
task will be overwritten and lost forever.

Now, VMS (solved) this non-problem, at great performance penalty,
by having a context-switch for everything. A hardware interrupt
generated a context-switch so the hardware interrupt could
certainly directly context-switch to a user-mode task. The
kernel was, itself, a task (called SWAPPER). When you called
the kernel (trapped to), a context-switch occurred and the
kernel did whatever in whatever order it wanted because it
didn't have to return to the caller right away (if ever).
In fact, it didn't even have to return to whatever got
interrupted. That task was just put into the queue of
runnable tasks.

The performance was nice for a single task that used, for
instance, a DR11 parallel-port board. An interrupt occurred
and the task got control right away after the data was
DMAed. Add more tasks and the system bogged down.
If you had 20 people compiling FORTRAN of a 11/780, it
took MINUTES to log in.

However, with such a system a high-priority task could
take the CPU away from anything. That meant that SYSTEM
could usually get control, assuming it was already logged
in. A dead driver was just marked unusable and everything
continued. Even dead RAM was able to marked unusable.

Unix was invented to bypass all this stuff. The kernel
is not a task. It is just some privileged shared code.
Therefore, it can execute quickly. The trade-off is
that you need to fix bad drivers.


>> When some user task executes outside the kernel, it doesn't
>> have the priviliges to loop forever. A context switch will
>> occur and the CPU will be shared with others. However, when
>> that user task calls some kernel function, perhaps from
>> a driver interface, that function has the priviliges to
>> keep the CPU forever. If the driver is improperly written,
>> it will.
>
> So to summarize what I need: disprivilege a process to keep the CPU forev=
er
> when it is in kernel mode.
>

You can't. Once the kernel code starts executing, it must behave.

>
> Jan Engelhardt
> --=20
> Gesellschaft f=FF=FFr Wissenschaftliche Datenverarbeitung
> Am Fassberg, 37077 G=FF=FFttingen, www.gwdg.de
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
--1678434306-1992984896-1100639679=:1963--
