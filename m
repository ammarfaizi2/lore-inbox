Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbREOWf6>; Tue, 15 May 2001 18:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261667AbREOWfs>; Tue, 15 May 2001 18:35:48 -0400
Received: from mail.ece.umn.edu ([128.101.168.129]:31173 "EHLO
	mail.ece.umn.edu") by vger.kernel.org with ESMTP id <S261666AbREOWfg>;
	Tue, 15 May 2001 18:35:36 -0400
Date: Tue, 15 May 2001 17:35:15 -0500
From: Bob Glamm <glamm@mail.ece.umn.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515173515.C472@kittpeak.ece.umn.edu>
In-Reply-To: <p05100316b7272cdfd50c@[207.213.214.37]> <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 01:18:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >Keep it informational. And NEVER EVER make it part of the design.
> > 
> > What about:
> > 
> > 1 (network domain). I have two network interfaces that I connect to 
> > two different network segments, eth0 & eth1;
> 
> So?
> 
> Informational. You can always ask what "eth0" and "eth1" are.
[...] 
> The location of the device is _meaningless_. 
[...]

Roast me if I'm wrong or if this has been beat to death, but there
seem to be two sides of the issue here:

  1) Device numbering/naming.  It is immaterial to the kernel how the
     devices are enumerated or named.  In fact, I would argue that the
     naming could be non-deterministic across reboots.

  2) Device identification.  The end-user or user-space software needs
     to be able to configure certain devices a certain way.  They too
     don't (shouldn't) care what numbers or names are given to the
     devices, as long as they can configure the proper device correctly.

I don't disagree that a move toward making the move toward dynamic device
enumeration/naming is the right way to go; in fact, I don't disagree
that a 32-bit dev_t would be more than adequate (and sparse) for most
configurations - even the largest configured machines wouldn't have more
than several million device names/nodes.

However, I *do* see that there is a LOT of end-user software that still
depends on static numbering to partially identify devices.  Yes, it is
half-baked that major 8 gets you SCSI devices, and then after you open
all the minor devices you STILL get to do all the device-specific ioctl()
calls to identify the device capabilities of the controller or each target
on the controller.  But I don't think that arbitrarily slamming the door
on static naming/numbering to force people to change arguably broken
code or semantics is the right move to make either.

Instead, what about doing the transformation gradually?  Static and
dyanmic enumeration shouldn't have to be mutually exclusive.  E.g.
in the interim devices could be accessed via dynamically enumerated/named
nodes as well as the old staticially enumerated/named nodes.  The 
current device enumeration space seems be sparse enough to take
care of this for most cases.

During this transition, end-user software would have the chance to be
re-written to use the new dynamically enumerated/named device scheme,
perhaps with a somewhat standardized interface to make identification 
and capability detection of devices easier from software.  At some
scheduled point in future kernel development support for the old
static enumeration/naming scheme would be dropped.

Finally, there has to be an *easy* way of identifying devices from software.
You're right, I don't care if my network cards are numbered 0-1-2, 2-0-1,
or in any other permutation, *as long as I can write something like this*:

  # start up networking
  for i in eth0 eth1 eth2; do
      identify device $i
      get configuration/config procedure for device $i identity
      configure $i
  done

Ideally, the identity of device $i would remain the same across reboots.
Note that the device isn't named by its identity, rather, the identity is
acquired from the device.

This gets difficult for certain situations but I think those situations
are rare.  Most modern hardware I've seen has some intrinsic identification
built on board.

> Linux gets this right. We don't give 100Mbps cards different names from
> 10Mbps cards - and pcmcia cards show up in the same namespace as cardbus,
> which is the same namespace as ISA. And it doesn't matter what _driver_ we
> use.
> 
> The "eth0..N" naming is done RIGHT!
> 
> > 2 (disk domain). I have multiple spindles on multiple SCSI adapters. 
> 
> So? Same deal. You don't have eth0..N, you have disk0..N. 
[...]
> Linux gets this _somewhat_ right. The /dev/sdxxx naming is correct (or, if
> you look at only IDE devices, /dev/hdxxx). The problem is that we don't
> have a unified namespace, so unlike eth0..N we do _not_ have a unified
> namespace for disks.

This numbering seems to be a kernel categorization policy.  E.g.,
I have k eth devices, numbered eth0..k-1.  I have m disks, numbered
disc0..m-1, I have n video adapters, numbered fb0..n-1, etc.  This
implies that at some point someone will have to maintain a list of 
device categories.

IMHO the example isn't consistent though.  ethXX devices are a different
level of classification from diskYY.  I would argue that *all* network
devices should be named net0, net1, etc., be they Ethernet, Token Ring, Fibre
Channel, ATM.  Just as different disks be named disk0, disk1, etc., whether
they are IDE, SCSI, ESDI, or some other controller format.

-Bob
