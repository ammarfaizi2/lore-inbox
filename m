Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSGVVLN>; Mon, 22 Jul 2002 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317805AbSGVVLN>; Mon, 22 Jul 2002 17:11:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45063
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317799AbSGVVLL>; Mon, 22 Jul 2002 17:11:11 -0400
Date: Mon, 22 Jul 2002 14:09:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Aniket Malatpure <aniket@sgi.com>
cc: Taavo Raykoff <traykoff@snet.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 IDE channels block each other under load?
In-Reply-To: <3D3C6628.37AA6167@sgi.com>
Message-ID: <Pine.LNX.4.10.10207221400110.23502-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One if the issues causing problems is the driver does not pull its queue
off the channel.  This is the ideal model as one is permitted to thread
the channel wisely.  This was scheduled for 2.5 but now I have to run a
shorter development cycle to get it correct for the remainder of 2.4.

Taskfile is designed to deal with a threaded model, but that is only the
base core.  Also with the advent of SATA, the desire to make a PATA core
threaded is not so pressing.

Cheers,

On Mon, 22 Jul 2002, Aniket Malatpure wrote:

> Hi
> 
> In the IDE Protocol, only 1 DMA transfer can take place on the bus at
> one time.
> So if the IDE  bus is busy doing the DMA transfer for 1 drive, the other
> drive cannot receive any commands.
> 
> I guess what does happen is that the IDE driver in the kernel doesnt
> distribute commands in a "fair" manner between drive 0 & drive 1. If it
> receives commands for drive 0, it keeps sending those commands to the
> drive 0, one after the other, without checking if there is a command for
> drive 1.
> 
> A driver distributing commands in a "fair" manner would send 1 command
> to drive 0, check if there is a command for drive 1, if there is, it
> would send a command to drive 1, then send the next command to drive 0
> and so on...
> 
> The above is a guess...would anyone care to verify?
> 
> Thanks
> Aniket
> 
> 
> 
> 
> 
> 
> 
> Taavo Raykoff wrote:
> > 
> > Can someone tell me what is going on here?
> > 
> > dd if=/dev/zero of=/dev/hda bs=1024 count=1000000
> > 
> > then in another vt:
> > fdisk /dev/hdc, then immediately press "q".
> > 
> > fdisk "hangs" for a long, long time.
> > ps -aux says state of dd and fdisk are both "D"
> > strace says fdisk is hanging on the close()
> > /proc/interrupts tell me that ide1 (/dev/hdc) is getting no
> >  int activity for a long, long time. ide0 is very busy.
> > 
> > It is not just dd/fdisk.  Any intensive writes on one IDE
> > channel (direct to the hd? device) seem to block any IO on
> > the other device.
> > 
> > Intel SAI2 MB, ServerWorks IDE chipset, 2.4.18, two IDE
> > hard drives /dev/hda and /dev/hdc, 1024MB RAM, RH73 kernel
> > build.
> > 
> > Also seen on Promise PDCx IDE controllers hanging off the PCI.
> > 
> > hdparm settings appear to have no influence on this behavior.
> > 
> > Thanks,
> > TR.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

