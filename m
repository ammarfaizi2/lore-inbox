Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278635AbRJXQRF>; Wed, 24 Oct 2001 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278625AbRJXQQz>; Wed, 24 Oct 2001 12:16:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35083 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278603AbRJXQQm>; Wed, 24 Oct 2001 12:16:42 -0400
Date: Wed, 24 Oct 2001 09:15:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Benjamin Herrenschmidt wrote:
> >
> >So the scsi devices hang off sd, sr etc which in turn hang off scsi and
> >the controllers hang off scsi (and or the bus layers)
> >
> >This one at least I think I do understand
>
> The problem with subsystems is that they don't fit well in the
> power tree. They aren't "devices" in that sense that they are
> not exposing a struct device, and they spawn over several controllers
> which means the dependency can quickly become unmanageable, especially
> when SCSI starts beeing layered on top of USB or FireWire.

Why would you _ever_ get "sg.c" and other crap involved in the suspend
process?

The device tree is for _device_ suspend, not for "subsystem suspend". The
SCSI subsystem is a piece of cr*p, but even if it was perfect it should
never get involved with the act of suspension.

We should not have pending IO, but that's for a totally different reason:
the first thing the much much MUCH higher levels of suspend should be
doing is to make sure that user apps are "quiescent". And that isn't done
by getting involved with sg.c or anything similar, but by basically
stopping all user apps (think of the equivalent of a "kill -STOP -1", but
done internally in the kernel without actually using a signal).

> Also, the dependency issue is made worst if you let RAID enter into
> the dance as I beleive ultimately, nothing would prevent a volume to
> spawn over several devices from different controllers or even different
> controller types.

Why would you get RAID involved? There is no _IO_ involved in suspending:
we just stop doing what we're doing, and leave it at that. We don't try to
flush state, we just freeze the machine.

The act of "suspend" should basically be: shut off the SCSI controller,
screw all devices, reset the bus on resume.

The act of suspend on USB should be to turn off the host controller and
remove power from devices. End of story. Nothing fancy.

If somebody removes a disk or equivalent while we're suspended, that's
_his_ problem, and is exactly the same as removing a disk while the disk
is running. Either the subsystem (like USB) already handles it, or it
doesn't. Suspend is _not_ an excuse to do anything that isn't done at
run-time.

So suspend is _not_ supposed to be equivalent of a full clean shutdown
with just users not seeing it.  That's way too expensive to be practical.
Remember: the main point of suspend is to have a laptop go to sleep, and
come back up on the order of a few _seconds_.

And if there are desktops which would like to suspend but cannot because
they aren't strictly designed for it, then tough - we should not try to
design a heavy suspend for hardware that doesn't live with it well.

Also, realize that the act of suspension is STARTED BY THE USER. Which
means that before the kernel suspends, you _can_ have user programs that
basically take disk arrays off-line etc if that is what you want. But
that's not ae kernel suspend issue.

			Linus

