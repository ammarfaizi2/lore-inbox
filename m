Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbREOVzs>; Tue, 15 May 2001 17:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbREOVzj>; Tue, 15 May 2001 17:55:39 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:3837 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261611AbREOVzZ>; Tue, 15 May 2001 17:55:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105152152.f4FLqshi021498@webber.adilger.int>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151031320.2112-100000@penguin.transmeta.com>
 "from Linus Torvalds at May 15, 2001 10:43:18 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 15 May 2001 15:52:54 -0600 (MDT)
CC: James Simmons <jsimmons@transvirtual.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
> And my opinion is that the "hot-plugged" approach works for devices even
> if they are soldered down - the "plugging" event just always happens
> before the OS is booted, and people just don't unplug it. So we might as
> well consider devices to always be hot-pluggable, whether that is actually
> physically true or not. Because that will always work, and that way we
> don't create any artificial distinctions (and they often really _are_
> artifical: historically soldered-down devices tend to eventually move in a
> more hot-pluggable direction, as you point out).

Basically, what you describe is the system that AIX has used since day 1.

All devices are "discovered" at boot time (even if they are soldered-down),
and registered in a database (for Linux that database could be /dev and
some text files in /etc)...

Every device driver supports hot-plugging.  No "static" major or minor
numbers per-se (i.e. no HPA needed), but devices are static in the sense
of "once a device node is created in /dev, it does not change major/minor
numbers until removed", so it is the same device name across reboots.
Devices keep a device node in /dev until specifically unconfigured (so
sysadmins know a device disappeared) but are seen as "unavailable", and
can be permanently removed via "rmdev".  Real hot-plug devices on Linux
could remove their own device node when removed, I suppose.

> This is true to the point that I would not actually think that it is a bad
> idea to call /sbin/hotplug when we enumerate the motherboard devices. In
> fact, if you look at the current network drivers, this is exactly what
> will happen: when we auto-detect the motherboard devices, we _will_
> actually call /sbin/hotplug to tell that we've "inserted" a network
> device.

Yes, in AIX it is always possible to re-run device detection (cfgmgr)
to find new devices (if they do not announce that fact themselves).
This would re-traverse all of the system busses (including CPU, memory,
motherboard(s), etc) looking for new devices, and each item found
spits out either endpoints or children which need further enumeration.
It is also possible to only selectively run device detection, so you
could, say, ask it to check for new disks only on a specific adapter
(important if you have 300 disks on a system).

This way you can detect new disks, adapter cards, serial ports, etc. any
time after the system is up.  All disks are identified as "/dev/hdiskX",
(serial ports /dev/ttySX, etc) and if you really need to know more
about the location of the device that is stored as part of the device
attributes (e.g. physical path to that device, I/O addresses, some device
attributes like serial number/MAC/etc).

> [ The biggest silliness is this "let's try to make the disks appear in the
>   same order that the BIOS probes them". Now THAT is really stupid, and it
>   goes on a lot more than I'd ever like to see. ]

Of course, since AIX uses exclusively LVM, it can identify which disk
is which no matter where it has moved, so it never had that legacy "I
have a DOS partition on C: and D: and I don't want to toast them" issue.
Since AIX runs only on proprietary H/W it always can tell you which slot
a card is in if you need to identify it (which PCI can do, but ISA can't).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
