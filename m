Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbREPNOC>; Wed, 16 May 2001 09:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbREPNNw>; Wed, 16 May 2001 09:13:52 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:39970 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261930AbREPNNk>; Wed, 16 May 2001 09:13:40 -0400
Date: Wed, 16 May 2001 08:13:24 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105161313.IAA47695@tomcat.admin.navo.hpc.mil>
To: glamm@mail.ece.umn.edu, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Glamm <glamm@mail.ece.umn.edu>:

> Finally, there has to be an *easy* way of identifying devices from software.
> You're right, I don't care if my network cards are numbered 0-1-2, 2-0-1,
> or in any other permutation, *as long as I can write something like this*:
> 
>   # start up networking
>   for i in eth0 eth1 eth2; do
>       identify device $i
>       get configuration/config procedure for device $i identity
>       configure $i
>   done
> 
> Ideally, the identity of device $i would remain the same across reboots.
> Note that the device isn't named by its identity, rather, the identity is
> acquired from the device.
> 
> This gets difficult for certain situations but I think those situations
> are rare.  Most modern hardware I've seen has some intrinsic identification
> built on board.

Not that rare here - HIPPI, parallel, serial lines, fibre channel, FDDI
interfaces... Anywhere there are two or more interfaces that do not or
cannot carry self identification. Consider the problem of two rocket port
multiplexor adapters where one uses high speed devices, another lower speed.
If the interfaces are swapped, which is the high speed? Or multiple parallel
interfaces. Which one has the color printer?

Even in cases with ethernet.. If there are two interfaces, which one is
eth0. Only the MAC address knows for sure, and some of the interfaces allow
changing the MAC address. It depends entirely on the wiring, not the MAC
as to which IP to assign. This is doable using DHCP, but not static IP.
Serial/parallel interfaces don't have that option. Neither do FDDI devices
broadcast on a FDDI isn't really defined.

> > Linux gets this right. We don't give 100Mbps cards different names from
> > 10Mbps cards - and pcmcia cards show up in the same namespace as cardbus,
> > which is the same namespace as ISA. And it doesn't matter what _driver_ we
> > use.
> > 
> > The "eth0..N" naming is done RIGHT!
> > 
> > > 2 (disk domain). I have multiple spindles on multiple SCSI adapters. 
> > 
> > So? Same deal. You don't have eth0..N, you have disk0..N. 
> [...]
> > Linux gets this _somewhat_ right. The /dev/sdxxx naming is correct (or, if
> > you look at only IDE devices, /dev/hdxxx). The problem is that we don't
> > have a unified namespace, so unlike eth0..N we do _not_ have a unified
> > namespace for disks.
> 
> This numbering seems to be a kernel categorization policy.  E.g.,
> I have k eth devices, numbered eth0..k-1.  I have m disks, numbered
> disc0..m-1, I have n video adapters, numbered fb0..n-1, etc.  This
> implies that at some point someone will have to maintain a list of 
> device categories.
> 
> IMHO the example isn't consistent though.  ethXX devices are a different
> level of classification from diskYY.  I would argue that *all* network
> devices should be named net0, net1, etc., be they Ethernet, Token Ring, Fibre
> Channel, ATM.  Just as different disks be named disk0, disk1, etc., whether
> they are IDE, SCSI, ESDI, or some other controller format.

Ummm... not sure. Fibre channel attached to disks are/should be treated
differently from fibre channel attached to compute clusters. Different
characteristics of use. Ethernet/fibre/FDDI/ATM all have drastically different
characteristics and have to be initialized differently. Even HIPPI can be
used as a network device... But it is also a storage attachment device.
Different characteristics, different MTU.

There must still be a way to specify/identify this uniqueness.

Looking at SCSI:

	1. hardware controller driver
	2. SCSI mid layer
	3. device specific driver

The mid level is used to make multiple harware controllers look the same
to the device specific drivers. This heirarchy must also be identified, and
in some cases (non SCSI issues) should be initialized differently.

When there are two (or more) hardware controllers, there may need to be
different ways to force the hardware controller to scan for newly attached
devices. The mid layer may have to scan for new/replaced hardware controllers
(hot swap PCI), the device specific drivers may need to scan for new units
(possibly initiated from lower levels, possibly from external request).

Each unit at each level needs to be able to be addressed.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
