Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135550AbRDSFJh>; Thu, 19 Apr 2001 01:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135551AbRDSFJ0>; Thu, 19 Apr 2001 01:09:26 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18442 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135550AbRDSFJV>; Thu, 19 Apr 2001 01:09:21 -0400
Date: Wed, 18 Apr 2001 22:08:39 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: John Fremlin <chief@bandits.org>
cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Next gen PM interface
In-Reply-To: <m2d7a97ddb.fsf_-_@bandits.org>
Message-ID: <Pine.LNX.4.10.10104182122250.7690-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > IMHO the pm interface should be split up as following:
> 
> Nobody has disagreed: therefore this separation must be perfect ;-)

I once heard that patience is a virtue. :)

> >         (1) Battery status, power status, UPS status polling. It
> >         should be possible for lots of processes to do this
> >         simultaneously. [That does not prohibit a single process
> >         querying the kernel and all the others querying it.]
> 
> Solution. Have a bunch of procfs or dev nodes each giving info on a
> particular power source, like now, but vaguely standardise the output.

I concur. This is easy, and clean.

> >         (2) Funky events happening to the physical machine, like a
> >         button being pressed, the case being closed, etc. [Should this
> >         include battery low warnings, power status changes? I don't
> >         know.]

I can see at least two types of events - (forgive the lack of colorful
terminology) passive and active. Passive events are simply providing
status updates, much like the events described above. These are simply so
some UI can notify the user of things like a low battery or detection of
an AC adapter. These can be handled in much the same way as described
above.

Active events require some sort of action by user space, like a shutdown
request initiated by a button press or a dead battery. See the next
comment.

> Solution. Have a special procfs or dev node that any number of people
> can select(2) or read(2). Protocol text. Syntax:
> 
>         <event> <WS> <subsystem> <WS> <description> <LF>
> 
> Where <event> is one of the strings
> OFF,SLEEP,WAKE,EMERGENCY,POWERCHANGE, <WS> is a space character,
> <subsystem> is a word signifying the kernel pm interface responsible
> for generating th event, <description> is an arbitrary string. <LF> is
> a newline character \n.
> 
> This is flexible and simple. It means a reasonable default behaviour
> can be suggested by the kernel (OFF,SLEEP,etc.) for events that
> userspace doesn't know about and yet userspace can choose fine grained
> policy and provide helpful error messages based on the exact event by
> checking the description.

First, Is there any reason why the kernel should do more text processing?
It is better left for user space. Besides, enumerated values translated by
userspace seems more efficient than copying and parsing strings.

Having a daemon that sits in user space and waits for system events
(denoted by enumerated values in some /proc or /dev file) seems simple
enough. When it gets the request to power down, it handles calling init
and whatever else it wants to do. When it gets notification that the
laptop was plugged into the base station, it can look for new devices and
load the modules for them.

This can also handle the user-dictated policy, which I haven't seen
discussed yet. For instance, when you close the lid or press the power
button, the system can enter suspend or it can power off. If the kernel
simply exported the event, the userspace daemon could simply check its
config file for the proper thing to do and initiate the transition.

> >         (3) Sending the machine to sleep, turning it off. It should be
> >         possible to do this from userspace ;-)
> 
> I would suggest that all pm capable objects should be able to be
> controlled individually. E.g. you should be able to send your monitor
> to sleep alone, leaving other stuff running. Fbdrivers are already
> capable of this on some archs.
> 
> IOW I suggest a nice FS with a dir per PM capable device. In this
> dir would be
> 
>         name - descriptive text name of device class
> 
>         wake - writing to this node wakes device
> 
>         sleep - writing a number n (text encoded) sends the device to
>         sleep in such a way that it can be back in action in no less
>         than n seconds after a wakeup call on a vague guess
>         basis. Reading from it gets errno.
> 
>         off - writing to this node puts device in deepest possible
>         sleep, possibly losing state. Reading gets errno.

Sure, but does it really make sense for anything but system sleep states? 
ACPI defines a mechnanism for runtime power management, where devices will
go into sleep states if they're not being used. Given proper heuristics
for controlling this, user-initiated suspension of individual devices
doesn't seem necessary. And, given a proper abstraction in the PM layer,
this should be extendable, to some extent, to other low-level PM schemes.


	-pat


