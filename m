Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132892AbRDSTJS>; Thu, 19 Apr 2001 15:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbRDSTI5>; Thu, 19 Apr 2001 15:08:57 -0400
Received: from m226-mp1-cvx1c.col.ntl.com ([213.104.76.226]:11392 "EHLO
	[213.104.76.226]") by vger.kernel.org with ESMTP id <S132859AbRDSTIk>;
	Thu, 19 Apr 2001 15:08:40 -0400
To: Patrick Mochel <mochel@transmeta.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Next gen PM interface
In-Reply-To: <Pine.LNX.4.10.10104182122250.7690-100000@nobelium.transmeta.com>
From: John Fremlin <chief@bandits.org>
Date: 19 Apr 2001 20:07:43 +0100
In-Reply-To: <Pine.LNX.4.10.10104182122250.7690-100000@nobelium.transmeta.com>
Message-ID: <m2zodcoghs.fsf@bandits.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Patrick Mochel <mochel@transmeta.com> writes:

[...]

> > Solution. Have a special procfs or dev node that any number of people
> > can select(2) or read(2). Protocol text. Syntax:
> > 
> >         <event> <WS> <subsystem> <WS> <description> <LF>
> > 
> > Where <event> is one of the strings
> > OFF,SLEEP,WAKE,EMERGENCY,POWERCHANGE, <WS> is a space character,
> > <subsystem> is a word signifying the kernel pm interface responsible
> > for generating th event, <description> is an arbitrary string. <LF> is
> > a newline character \n.
> > 
> > This is flexible and simple. It means a reasonable default behaviour
> > can be suggested by the kernel (OFF,SLEEP,etc.) for events that
> > userspace doesn't know about and yet userspace can choose fine grained
> > policy and provide helpful error messages based on the exact event by
> > checking the description.
> 
> First, Is there any reason why the kernel should do more text processing?

Kernel does no text processing. Kernel merely gives text instead of
magic numbers to the stream of bytes.

> It is better left for user space. Besides, enumerated values
> translated by userspace seems more efficient than copying and
> parsing strings.

Oh? Do you honestly believe there will be in any way a detectable
difference?

> Having a daemon that sits in user space and waits for system events
> (denoted by enumerated values in some /proc or /dev file) seems simple
> enough. 

Yes, but text strings are simpler. You don't have to export magic
numbers in some kernel header (causing no end of woe). You can just
cat /proc/pm/events to the console and understand it, and just about
anybody with the rudiments of knowledge about programming in any
language can write an event handler - even without having to know
hardly anything about or look at the kernel source because the
interface is so transparent and simple.

> When it gets the request to power down, it handles calling init and
> whatever else it wants to do. When it gets notification that the
> laptop was plugged into the base station, it can look for new
> devices and load the modules for them.

Exactly. Right. Bang on target - but with text strings you can do it
in a line or two of perl, and the kernel side is not made any more
complex.

> This can also handle the user-dictated policy, which I haven't seen
> discussed yet. For instance, when you close the lid or press the power
> button, the system can enter suspend or it can power off. If the kernel
> simply exported the event, the userspace daemon could simply check its
> config file for the proper thing to do and initiate the transition.

Exactly what I was suggesting. In this case, you'd get the event

        SLEEP ACPI Laptop case closed

and your perl script could do something vaguely like

        /ACPI Laptop case closed$/ && system "shutdown -p now";

to turn the machine off instead of sleeping.


[...]

> >         sleep - writing a number n (text encoded) sends the device to
> >         sleep in such a way that it can be back in action in no less
> >         than n seconds after a wakeup call on a vague guess
> >         basis. Reading from it gets errno.

Probably microseconds would be a more useful unit.

> >         off - writing to this node puts device in deepest possible
> >         sleep, possibly losing state. Reading gets errno.
> 
> Sure, but does it really make sense for anything but system sleep
> states? ACPI defines a mechnanism for runtime power management,
> where devices will go into sleep states if they're not being
> used. Given proper heuristics for controlling this, user-initiated
> suspension of individual devices doesn't seem necessary. And, given
> a proper abstraction in the PM layer, this should be extendable, to
> some extent, to other low-level PM schemes.


OK, so add another node, something like

        boredafter - writing a number of milliseconds tells device to
        go to some sort of sleep after that time has elapsed without
        activity.

-- 

	http://www.penguinpowered.com/~vii
