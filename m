Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSGCASN>; Tue, 2 Jul 2002 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSGCASM>; Tue, 2 Jul 2002 20:18:12 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:54878 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S314277AbSGCASL>;
	Tue, 2 Jul 2002 20:18:11 -0400
Date: Wed, 3 Jul 2002 02:20:39 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hd_geometry question.
Message-ID: <20020703002039.GA22020@win.tue.nl>
References: <OF25B15FAC.FE67359D-ONC1256BEA.0032B6AA@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF25B15FAC.FE67359D-ONC1256BEA.0032B6AA@de.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:16:06AM +0200, Martin Schwidefsky wrote:

> >About a partition one wants to know start and length.
> >About a full disk one wants to know size, and perhaps a (fake) geometry.
> >
> >The vital partition data cannot depend on obscure hardware info.
> >So, the units used must be well-known. Earlier, everything was in
> >512-byte sectors, but there are a few places where that is inconvenient
> >or unnatural, and now that one has more than 2^32 sectors and 64 bits
> >are needed anyway, things are measured in bytes.
> >
> >That the start field comes with the HDIO_GETGEO ioctl and the size with
> >the BLKGETSIZE ioctl is due to history. Both are given in 512-byte sectors.
> >BLKGETSIZE64 gives bytes.

> Just to make sure I got that right, HDIO_GETGEO delivers a FAKE geometry
> based on the assumption that the sector size is 512 bytes ?

I am tempted to just answer "yes".
You capitalize FAKE, as if that is an interesting and important part.
But non-fake geometries do not exist. Let me give a somewhat more
explicit answer.

HDIO_GETGEO delivers several things, namely a starting address and a geometry.

The starting address is in 512-byte sector units, and is entirely
independent of any hardware properties.
Also the size returned by BLKGETSIZE is in 512-byte sector units.

The geometry has, for the common IDE and SCSI cases, been fake for the last
ten years or so, since IDE and SCSI disks do not have a geometry. 
The geometry consists of cylinders / heads / sectors-per-track.
In reality of course the number of physical sectors per track is not constant:
there are more sectors per track on the outer rim. Thus, such a geometry does
not have any physical significance.
The purpose of these ridiculous numbers is only to fill certain fields
in a DOS-type partition table. This geometry is of interest only on a
disk that is shared with DOS or some similar operating system, where
it is important that Linux and DOS do interpret the partition table
in the same way.

The cylinder field in the struct returned by HDIO_GETGEO is obsolete
and must not be used. (Because the value is trancated and nobody needs
it - user space can compute it when desired, like *fdisk does, but
the number obtained is purely phantasy, eye-candy only, and does not
play any role in the interpretation of partition tables.)

The heads and sectors-per-track values are those specified by the user
on the command line, or guessed from the partition table, or returned
by the IDENTIFY command to the IDE drive, or returned by the biosparam
routine of the SCSI drive. (Or ...)
The sectors of this sectors-per-track value are sectors of unknown size,
namely the size that DOS would use in its partition table.
Usually one sets heads to 16 and sectors per track to 63.

The ATA standard defines a sector as 256 words (512 bytes), so
what the IDENTIFY command returns is in terms of 512-byte sectors.
Everybody else follows.

It is rumoured that certain MO disks with a hardware sector size
of 2048 bytes have partition tables in units of 2048-byte sectors.

All these things are of no concern to the kernel. It is up to
*fdisk, and perhaps some boot loader, to worry about such things.

Andries

