Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTJFTdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTJFTdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:33:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261613AbTJFTd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:33:28 -0400
Date: Mon, 6 Oct 2003 15:33:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Hans-Georg Thien <1682-600@onlinehome.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: getting timestamp of last interrupt?
In-Reply-To: <3F81BCE9.2010808@onlinehome.de>
Message-ID: <Pine.LNX.4.53.0310061507470.531@chaos>
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.fvjdidn.13ni70f@ifi.uio.no>
 <3F7E46AB.3030709@onlinehome.de> <Pine.LNX.4.53.0310060843500.8593@chaos>
 <3F81B2A3.4040001@onlinehome.de> <Pine.LNX.4.53.0310061426080.11197@chaos>
 <3F81BCE9.2010808@onlinehome.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Hans-Georg Thien wrote:

> Richard B. Johnson wrote:
>
> > On Mon, 6 Oct 2003, Hans-Georg Thien wrote:
> >
> >>
> >>[...]
> >>I'm writing a kernel mode device driver (mouse).
> >>
> >>In that device driver I need the timestamp of the last event for another
> >>kernel mode device (keyboard).
> >>
> >>I do not care if that timestamp is in jiffies or in gettimeofday()
> >>format or whatever format does exist in the world. I am absolutely sure
> >>I can convert it somehow to fit my needs.
> >>
> >>But since it is a kernel mode driver it can not -AFAIK- use the signal()
> >>syscall.
> >>
> >>-Hans
> >
> >
> > Then it gets real simple. Just use jiffies, if you can stand the [...]
> I fear that there is still some miss-understanding. Jiffies are totally
> OK for me. I can use them without any conversion.
>
> I'll try to formulate the problem with some other words:
>
> I hope that there is is something like a "jiffie-counter" for the
> keyboard driver, that stores the actual jiffies value whenever a
> keyboard interrupt occurs.
>

Well the keyboard driver and the mouse driver are entirely
different devices.

The keyboard has a built-int CPU that generates scan-codes for
every key-press/key-release. It also performs auto-repeat. The
mouse generates mouse data at each interrupting event. This data
represents direction and three key events. Wheel mouse have may
have additional data, I haven't looked at them. They are not
related in any way.


> I hope too, that there is a way to query that "jiffie-counter" from
> another kernel driver, so that I can write something like
>
>
> mymouse_module.c
>
> ...
> void mouse_event(){
>
>     // get the current time in jiffies
>     int now=jiffies;
>
>     // get the jiffie value of the last kbd event
>     int last_kbd_event= ????;  // ... but how to do that ...
>
>     if ((now - last_kbd_event) > delay) {
> 	do_some_very_smart_things();
>     }
>    }
> ...
>

Now this pseudo-code shows a "last_kbd_event", not a mouse-
event as shown in:

> >>I'm writing a kernel mode device driver (mouse).

... your words, not mine.

I presume that you are replacing the existing mouse-driver.
If so, your mouse-buffer, i.e., the place you put the
mouse-event movement-codes can be something like:

struct mouse_event {
    unsigned long time;
    int mouse_code;
    }

You allocate a buffer of this type and, during each interrupt,
you put both the jiffie-time and the mouse code into your buffer.

If you are not replacing the existing mouse driver, then you
need to share its interrupt with your new module. The new
module records the time-stamp of each of the interrupts, only.

Every bit of mouse-data was obtained as a result of an interrupt.
Using that knowledge, you should be able to correlate a time-stamp
to mouse-data (clear your time-stamp buffer when no mouse data
are available).

If you are using the keyboard, not the mouse, then the same
things apply.

If you just want to patch the existing keyboard or mouse
ISR to save a time-stamp in your module code, you need to
make the built-in keyboard or mouse ISR code call a function
by pointer. This pointer must be initialized to point to a
stub that simply returns. You need to export this symbol
so it can be found by your module.

When your module is installed, it saves the value in that
pointer. It then changes the pointer value to the address of
your routine. It needs to do this under a spin-lock.

When your module is un-installed, it needs to restore the
previous (saved) value of that pointer.

Whatever code you make that pointer point-to, must be
interrupt-safe. It can get the jiffie-count and put it
into a buffer, then return.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


