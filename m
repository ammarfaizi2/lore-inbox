Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQLBFlJ>; Sat, 2 Dec 2000 00:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQLBFk7>; Sat, 2 Dec 2000 00:40:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129563AbQLBFkp>; Sat, 2 Dec 2000 00:40:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
Date: 1 Dec 2000 21:09:25 -0800
Organization: Transmeta Corporation
Message-ID: <90a065$5ai$1@penguin.transmeta.com>
In-Reply-To: <200012020409.UAA04058@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200012020409.UAA04058@adam.yggdrasil.com>,
Adam J. Richter <adam@yggdrasil.com> wrote:
>
>	Well, alas, it appears that linux-2.4.0-test12-pre3 freezes hard
>while reading the base address registers of the first PCI device
>(the "host bridge").  Actually, I think the problem is some kind of
>system management interrupt occuring at about this time, since the
>exact point where the printk's stop gets earlier as I add more
>printk's.

This is due to a Linux bug, where we disable the northbridge while we do
the PCI window probes.

[ I actually suspected for a while that we'd messed up at Transmeta, but
  after talking with and double-checking the PCI specs, it turns out
  that Linux really was at fault. Oh, well. Whichever way I turn, I'm
  always to blame ;) ]

What happens is that the Sony notebook has Legacy USB support on in the
BIOS, which causes USB DMA events several thousand times a second. When
Linux does PCI probing, Linux will turn off the MEM and IO bits in the
PCI command register of the device it probes. It so happens that
according to the PCI spec, turning off the MEM bit of the host bridge
(aka "northbridge") disconnects the host from the PCI bus.

A few microseconds later a USB legacy DMA event comes in, but now the
host bridge no longer forwards the DMA between the PCI bus and memory,
and the machine hangs. Oops.

The simplest (working) solution is to remove the jiggering with the PCI
command register IO and MEM bits in drivers/pci/pci.c: pci_read_bases().

The proper fix (which we discussed with Martin Mares and Richard
Henderson) is actually to do the full bus enumeration first, _without_
doing any window probes (and thus without having to muck with the IO and
MEM bits in the command register), and when we find the offending USB
controller that the BIOS has left active, we kill it off first (we
already have this in the PCI quirks section, it's just that the PCI
quirks get executed too late to fix this problem as it is now). 

>	One sin that I am committing in these builds is that I am bulding
>them under gcc-2.95.2, although I do not think this is the sort of
>behavior that an optimizer bug is likely to produce.

Nope, this is completely unrelated.

>	If anyone out there is using Linux 2.4.0-test on a Sony
>PictureBook PCG-C1VN (the Transmeta version), I would be interested in
>at least trying to build from your .config file.
>
>	Memo to Transmeta management: buy Linus a PictureBook. :-)

Actually, I have one, and have had one for about two weeks, but because
of the newest (human) addition to the Torvalds family I didn't have any
time to debug this until the day before yesterday.

NOTE! Getting the 2.4.x kernel up and running is the easy part.  The
machine also has a very recent ATI Rage Mobility chip in it, and you
need the newest XFree86 CVS snapshot to make it work (along with a
one-liner patch from me, unless that has already made it into the CVS
tree by now).

Even then XFree86 does something bad with DPMS, and will lock up the
graphics chipset when it tries to shut down the flat panel display. 
Solution: don't enable DPMS is XF86Config.  That's an XFree86 problem,
but happily easily worked around. 

Oh, and there's a UHCI driver bug that will bite you (again because the
machine has legacy USB enabled by default - and unlike almost every
other laptop out there, Sony didn't allow USB legacy code to be turned
off in the BIOS setup), so unless you've applied the USB patches from
the USB mailing list you'll just hang there instead. 

Anyway, I do have this machine working now, although not everything is
to my liking.  Unlike older picture-books, for example, this one has a
WinModem.  Ugh.  And the sound chip is supported, but only by the ALSA
driver (the OSS version is too broken to be used). 

But the camera is cool, and works beautifully (once you get XFree86
happy) thanks to Andrew Tridgell.  (If I could just coax the X server
into giving my a YUV overlay I could play DVD's with this thing). 

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
