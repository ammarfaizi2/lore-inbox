Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSHBBx7>; Thu, 1 Aug 2002 21:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317611AbSHBBx7>; Thu, 1 Aug 2002 21:53:59 -0400
Received: from damocles.com ([216.12.219.203]:49858 "EHLO uph.com")
	by vger.kernel.org with ESMTP id <S317605AbSHBBx5>;
	Thu, 1 Aug 2002 21:53:57 -0400
Date: Thu, 1 Aug 2002 20:57:20 -0500
From: Jeff Randall <randall@uph.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020801205720.A18177@uph.com>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, Jul 29, 2002 at 11:19:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 11:19:27PM +0100, Matthew Wilcox wrote:
> I'm not.  All the issues you mention below go away if we make the rule
> that _all_ serial ports are /dev/ttyS*.  Userspace can have symlinks to
> ease the transition if necessary.

Might I suggest that each driver then have a character code after the
ttyS before the numbering starts?  Then each driver could sanely number
its own devices and not worry about confict with another driver.

Also, drivers that have the potential for large port counts might best
provide their own node creation methods instead of relying upon MAKEDEV
to know about all the nodes it might need at any given time.

The last driver I worked upon (the Digi dgdm driver) exported the nodes
it wanted made in /proc and the rc script that came with the driver built
them at each boot in accordance with the product that the driver detected.



> > c. People with many serial ports.  We _could_ change the device number
> >    allocations such that ttyS gobbles up the ttySA, ttyCL, ttyAM, etc
> >    device numbers so we end up with the same number of port slots
> >    available for those with many many serial ports in their machines.
> 
> Yep, there really are people with >256 serial ports.  It'd be nice to
> support them.  Does anything care about the mapping from device name
> to char minor?  I suspect the MAKEDEV maintainer will come and squash
> me if i suggest moving the mapping for the first 192 serial devices,
> but we should be able to reclaim:
> 
> Chase serial card (major 17/18), the Cyclades (major 19/20), Digiboard
> (major 22/23), Stallion (major 24/25), Specialix (32/33), isdn4linux
> (43/44), Comtrol (46/47), SDL RISCom (48/49), Hayes (57/58), Computone
> (71/72), Specialix (75/76), PAM (78/79), Comtrol VS (105/106), ISI
> (112/113), Technology Concepts (148/149), Specialix RIO (154/155/156/157),
> Chase Research (164/165), ACM (166/167), Moxa (172/173), SmartIO
> (174/175), USB (188/189), Low-density misc serial ports (204/205),
> userspace (208/209) BlueTooth (216/217), A2232 (224/225) ... holy crap,
> that's a lot of char dev space ;-)  52 majors.. think what those must
> be worth on the open market ;-)

Last I heard when I was working at Digi on the Digiboard driver, they wanted
to pull that driver out of the kernel entirely and support it on their own
(and none of the other drivers Digi distributes currently default to 22/23,
they tend to start at 70 and use as many as 10 minors, depending on the 
port count).



> My only real objection (and it's a problem we have at the moment!) is
> that serial ports then become like ethernet interfaces.  Add or remove a
> card and everything changes number.  Somehow we already survive with this.
> I was very careful when adding a new SIIG 4-port serial card to my console
> server the other day to notice which card was first in PCI bus scan
> order and make sure all my existing machines were hooked up to that one.
> 
> The solution to this has to be to name devices by PCI bus ID, but this is
> an argument for an entirely different thread ;-)

Agreed... but you have to consider other busses as well and incorporate
them into the naming scheme -- SCSI, USB, and Ethernet spring immediately
to mind.

It's my opinion that most people can get along well enough if the devices
are at least named consistently from boot to boot, but it would be nice
to have something a bit more stable than that so that adding and removing
units didn't change the device names.

It's not that important when you only have a couple boards, but some of
the drivers I worked on supported as many as 1024 units over ethernet..
and another 8 SCSI busses worth locally.. having one unit inserted into
the middle changing the order of half or more of the units would really
be a bad thing with such an installation.

Digi tried to make most of their nodes in a sub directory (/dev/digi/dgdm
or /dev/digi/els for example) and then link just the ttyS* nodes back up
into /dev

For large device counts (the dgdm driver made 5 nodes per physical port),
that's a sane way to go about IMHO.



Jeff Randall
(note: I'm no longer at Digi, I speak for myself, etc)
-- 
randall@uph.com    "It's a big world and you can hit it with any airplane."
                                           -- Flying, August 2000, Page 90.
