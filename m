Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbREPVkI>; Wed, 16 May 2001 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262099AbREPVj6>; Wed, 16 May 2001 17:39:58 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:36093 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261301AbREPVjn>; Wed, 16 May 2001 17:39:43 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105162136.f4GLat2L015085@webber.adilger.int>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010516120452.A16609@munchkin.spectacle-pond.org>
 "from Michael Meissner at May 16, 2001 12:04:52 pm"
To: Michael Meissner <meissner@spectacle-pond.org>
Date: Wed, 16 May 2001 15:36:55 -0600 (MDT)
CC: Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner writes:
> On Tue, May 15, 2001 at 01:18:09PM -0700, Linus Torvalds wrote:
> > This is what we have now. Network devices are called "eth0..N", and nobody
> > is complaining about the fact that the numbering is basically random. It
> > is _repeatable_ as long as you don't change your hardware setup, and the
> > numbering has effectively _nothing_ to do with "location".
> 
> Well yes and no.  The numbers are currently repeatable for a given kernel,
> but I know I and others were bitten by the 2.2. to 2.4 transition, where
> the kernel used a different algorithm for the order in which it detected
> scsi and network adapters (ie, in my machine with 3 scsi adapters, Linux 2.2
> always picked the Adaptec scsi adapter builtin into my motherboard as the
> first adapter, but 2.4 decided to pick my TekRam 390F adapter).

With a proper user-space solution for device naming, you wouldn't care what
order the kernel enumerated devices in.  You want the kernel to list all of
the devices (in any order), and then user-space is in charge of creating
(or maintaining) a semi-permanent ID to device mapping regardless of what
the major/minor number or physical device location is.

> As lots of people have been saying, you need to know which physical slot to
> plut the wire connecting eth0, eth1, etc. into.  Similarly for serial ports,
> if I have 3 or 4 (or 127 :-) USB serial devices, I really don't want to have
> to change my cabling each time I boot or change OSes (since I doubt my UPS
> will be happy if I give it the commands destined for the X10 controller or
> my remote boards).

If you keep a "static" database (in userspace) of device name -> physical
device mappings, then you are safe as long as either:
a) There is some way to identify a device which has moved (H/W serial number,
   LVM/fs UUID/label, unique make/model, etc).
b) You can get some physical location information about the device (i.e.
   I/O port address, bus/slot information, etc).

Linux currently always assumes that (b) implies the order of enumerating
devices is fixed, even when it isn't always true (hence problems with
SCSI addressing, ethernet cards, etc).  We _should_ be using (a) as much
as it is possible.  If both (a) and (b) are not true (e.g. two USB mice
(no serial number) and you change your USB layout) then there isn't much
that software can do without user intervention.

At least if there is a simple mapping table maintained in user space(*),
it is easy to switch the identities of devices to whatever they want with
little effort, rather than having to re-do all of their other config files.

Note that despite the presence of (b), we should NOT use this information
as part of the device name, since we want to be able to keep the same
device name (possibly with a _small_ bit of user intervention) even if
the device moves around.

Cheers, Andreas

(*) Something like a simple lookup table with name=value pairs (very e.g.):

ide-serial:a1e2a40a5e03=disk0
scsi-serial:xj23as88d=disk1
mdraid-uuid:3b02f06c-2c33-5905-c247-1f806535505c=disk7
isa-ioport:03f8=ttyS0
isa-ioport:02f8=ttyS1
isa-ioport:02e8=ttyS3
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
