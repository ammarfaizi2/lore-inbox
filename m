Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317882AbSGVXBI>; Mon, 22 Jul 2002 19:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGVXBI>; Mon, 22 Jul 2002 19:01:08 -0400
Received: from mta3.snet.net ([204.60.203.69]:24195 "EHLO mta3.snet.net")
	by vger.kernel.org with ESMTP id <S317882AbSGVXBH>;
	Mon, 22 Jul 2002 19:01:07 -0400
Date: Mon, 22 Jul 2002 19:04:01 -0400 (EDT)
From: "T.Raykoff" <traykoff@snet.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 IDE channels block each other under load?
In-Reply-To: <Pine.LNX.4.33.0207221750210.22553-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.44.0207221859070.18179-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Mark Hahn wrote:

> > I guess what does happen is that the IDE driver in the kernel doesnt
> > distribute commands in a "fair" manner between drive 0 & drive 1. If it
> 
> but this is between hda and hdc, which are on different IDE channels.
> 
> I'm guessing this is straighforward memory thrashing - the dd is 
> abusing the system, and getting anything else done is hard.
> for instance, what happens if bs is reasonable instead?
> what happens if the load is read, rather than write?

Not sure about the bs dependency, but I seem to remember that it had 
little effect.

This lockup only happens under write load.  Heavy reads don't cause the 
prob.  Hmmmm.

Not sure that it really is memory thrashing.  The box is unloaded and 
really has about 1GB free, to use for buffer as it sees fit.  No I/O to 
the swap file going on, cause there is no mounted swap.

Check this out:

dd if=/dev/zero of=/dev/hda bs=1024

then:

fdisk /dev/hdc

"q"

fdisk blocks in the close() call.... for well over 15 minutes!

As soon as dd ends cause /dev/hda is at EOF, fisk::close() returns in a 
moment.

Doesn't sounds like simple system abuse to me.

Taavo.



> 
> 
> > Taavo Raykoff wrote:
> > > 
> > > Can someone tell me what is going on here?
> > > 
> > > dd if=/dev/zero of=/dev/hda bs=1024 count=1000000
> > > 
> > > then in another vt:
> > > fdisk /dev/hdc, then immediately press "q".
> > > 
> > > fdisk "hangs" for a long, long time.
> > > ps -aux says state of dd and fdisk are both "D"
> > > strace says fdisk is hanging on the close()
> > > /proc/interrupts tell me that ide1 (/dev/hdc) is getting no
> > >  int activity for a long, long time. ide0 is very busy.
> > > 
> > > It is not just dd/fdisk.  Any intensive writes on one IDE
> > > channel (direct to the hd? device) seem to block any IO on
> > > the other device.
> > > 
> > > Intel SAI2 MB, ServerWorks IDE chipset, 2.4.18, two IDE
> > > hard drives /dev/hda and /dev/hdc, 1024MB RAM, RH73 kernel
> > > build.
> > > 
> > > Also seen on Promise PDCx IDE controllers hanging off the PCI.
> > > 
> > > hdparm settings appear to have no influence on this behavior.
> > > 
> > > Thanks,
> > > TR.
> 

