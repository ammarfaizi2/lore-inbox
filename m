Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSFVToB>; Sat, 22 Jun 2002 15:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSFVToA>; Sat, 22 Jun 2002 15:44:00 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:53266 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S316885AbSFVTn6>;
	Sat, 22 Jun 2002 15:43:58 -0400
Message-ID: <3D14D301.F2C8DBBE@torque.net>
Date: Sat, 22 Jun 2002 15:41:53 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Bellinger <nickb@attheoffice.org>
CC: Oliver Xymoron <oxymoron@waste.org>, Patrick Mochel <mochel@osdl.org>,
       sullivan <sullivan@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
References: <Pine.LNX.4.44.0206211616510.16808-100000@waste.org> <1024720721.6874.104.camel@subjeKt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Bellinger wrote:
> 
> On Fri, 2002-06-21 at 15:33, Oliver Xymoron wrote:
> > On Thu, 20 Jun 2002, Patrick Mochel wrote:
> >
> > > > But it was entierly behind me how to fit this
> > > > in to the sheme other sd@4,0:h,raw
> > > > OS-es are using. And finally how would one fit this in to the
> > > > partitioning shemes? For the system aprtitions are simply
> > > > block devices hanging off the corresponding block device.
> > >
> > > Partitions are purely logical entities on a physical disk. They have no
> > > presence in the physical device tree.
> >
> > As I raised elsewhere in this thread, the distinction between physical and
> > logical is troubling. Consider iSCSI, (aka SCSI-over-IP). It's analogous
> > to SCSI-over-Fibre Channel, except that rather than using an embedded FC
> > stack, it's using the kernel's IP stack. But it's every bit as much a SCSI
> > disk/tape/whatever as a local device. Ergo, it ought to show up in the
> > device tree so that it can be discovered in the same way. But where?
> >
> > This is only one step (the SCSI midlayer) removed from the logical devices
> > created by partitioning, LVM, NBD, MD, loopback, ramdisk and the like,
> > that again, ought to be discoverable in the same way as all other block
> > devices. Perhaps we need root/{virtual,logical}?
> >
> 
> The interaction between iSCSI & driverfs does pose an interesting
> problem:
> 
> On one hand I tend to lead toward the view of a physical device.
> The reason being that there will never be a distinction as far as the
> kernel is concerned (other than driverfs of course) that a SCSI upper
> level driver (hopefully soon to be a personality driver) using a iSCSI
> Initiator low-level driver is not really a physical host.
> 
> On the other hand there is the obvious fact that an iSCSI initiator
> driver is not attached to a bus, and assuming /root/iSCSI.target/disk1
> etc, is out of the question.  There is a real need for a solution to
> handle virtual devices (as stated your previous message) that are not
> assoicated with any physical connectors.
> 
> Not being too fimilar with driverfs,  what are the options with regard
> to virtual devices as things currently stand without tainting the
> elegant tree that is provides?

iSCSI introduces some other issues. The SCSI subsystem has
a 4 byte target (port) identifier at the moment. However Annex A
of the SAM-2 draft ( http://www.t10.org ) indicates that it should
be 258 bytes for iSCSI (and 11 bytes for ieee1394). For iSCSI the
target port identifier is a WWUI plus a 2 byte target portal group 
tag. A WWUI looks like:
  com.disk-vendor.diskarrays.sn.45678

Also the SCSI subsystem has tended to hide the the initiator's
own identifier (this is usually id 7 on the SCSI parallel bus).
For iSCSI it may be worthwhile to make the initiator port 
identifier visible in driverfs.

There is also the case where you want a box to appear to
the network as an iSCSI target. In this case once a iSCSI
login is complete you might want to represent the initiator
in the driverfs tree. For iSCSI, the initiator port identifier 
is a WWUI plus a 6 byte "inititator session id" for a total
of 262 bytes.

So the "target id" we put in driverfs could have one of
these suggested formats:
   <number>              - 0 to 1 for ATA
   <number>              - 0 to 15 for SCSI parallel interface
   <number>              - 24 bit number for fibre channel
   <EUI 64+discovery_id> - ieee1394
   <???>                 - usb (mass storage + scanner)
   <WWUI> ":" <num>      - iSCSI   [something better than ":"?]


We should also be moving towards 8 byte luns which in one
descriptor format are a 4 level hierarchy (2 bytes at each
level).

Doug Gilbert
