Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280622AbRKYBUv>; Sat, 24 Nov 2001 20:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280623AbRKYBUl>; Sat, 24 Nov 2001 20:20:41 -0500
Received: from science.horizon.com ([192.35.100.1]:24885 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S280622AbRKYBU2>; Sat, 24 Nov 2001 20:20:28 -0500
Date: 25 Nov 2001 01:20:22 -0000
Message-ID: <20011125012022.6326.qmail@science.horizon.com>
From: "dnu478nt5w@mailexpire.com"@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:

> Most power supplies are not designed to hold up for more than 30-60 ms at 
> full load upon removal of mains power.  Power-fail detect typically 
> requires 12 ms (three-quarters cycle average at 60 Hz) or 15 ms 
> (three-quarters cycle average at 50 Hz) to detect that mains power has 
> failed, leaving your system a very short time to abort that long queue of 
> disk write commands.  It's very possible that by the time the system wakes 
> up to the fact that its electron feeding tube is empty it has already 
> started a write operation that cannot be completed before power goes out of 
> specification.  It's a race condition.
>
> If power goes out of specification before the drive completes a commanded
> write, what do you expect the poor drive to do?

I expect it to have enough capacitor power and rotational inertia that
it can decide before it *starts* a given sector write whether it will
be able, barring a disaster rather less likely than instantaneous loss
of DC power, to complete it.

It doesn't need that long.  Take, as an example, a Really Old drive...
an original 20 MB MFM drive.  3600 RPM, 17 sectors/track.

That's 60*17 = 1020 sectors per second passing under the head.  So the
actual duration of a sector write is 1 ms.

In a more modern hard drive (IBM 40GV) will spin faster and have
from 370 (inner tracks) to 792 (outer tracks) sectors per track.
(http://www.storagereview.com/guide2000/ref/hdd/geom/tracksZBR.html)

Even at 5400 rpm, on the innermost track, that's 90*370 = 33300
sectors/second passing under the head, or 30 *microseconds* per sector.


I think it's reasonable to expect a drive to keep functioning for 30
microseconds between when it notices the power is dropping and when it
really can't continue.  Heck, even 1 ms isn't unreasonable.

We exepct a drive to look at the power supply shortly before the write,
and decide if it's "go for launch" or not.

Given that modern drives already save enough power to unload the heads
before the platter slows to the point that they'd touch down, this doesn't
seem like a big problem.  (Of course, unloading the heads doesn't require
that drive RPM, head position, or anything else be within spec.)


What we'd *like* is for the drive to have enough power to be able to
seek to a reserved location and dump out the entire write-behind cache
before dying, but that possibly requires a full-bore seek (longer than
the typical 9 ms "average" seek) plus head settle time (it's okay to
start *reading* before you're sure the head is in place; the CRC will
tell you if you didn't make it), plus writing 4000 sectors (5+ rotations,
with head switching and extra settle time between, for a 2 MB buffer),
but that's adding up to a good fraction of 100 ms, which *is* a bit long
for power-loss operation.
