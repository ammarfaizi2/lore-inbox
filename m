Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTJWP0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTJWP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:26:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263603AbTJWP0B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:26:01 -0400
Date: Thu, 23 Oct 2003 11:27:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stuart_Hayes@Dell.com
cc: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: IDE "logical" geometry & partition tables (problem with 2.4 k
 erne l, also seems to apply to 2.6)
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A3C@ausx2kmpc106.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.53.0310231120150.18389@chaos>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A3C@ausx2kmpc106.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Oct 2003 Stuart_Hayes@Dell.com wrote:

>
> By "correct", I meant that the geometry matches what the BIOS expects when
> doing int13 calls.  If the partitions are not set up with this geometry,
> then an MBR/bootloader that uses CHS to access the drive will not be able to
> boot.  This problem only came to my attention because of an instance where
> such an MBR is used.
>
>
>     >> If a partition table is then created on the drive using this
> geometry,
>     >> the CHS values in the partition table will not be correct.
>
> > "correct" has no meaning here.
>
>
>
>
> -----Original Message-----
> From: Andries.Brouwer@cwi.nl [mailto:Andries.Brouwer@cwi.nl]
> Sent: Wednesday, October 22, 2003 3:42 PM
> To: B.Zolnierkiewicz@elka.pw.edu.pl; Hayes, Stuart
> Cc: Andries.Brouwer@cwi.nl; linux-ide@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: IDE "logical" geometry & partition tables (problem with 2.4
> kerne l, also seems to apply to 2.6)
>
>
>     On Wednesday 22 of October 2003 00:00, Stuart_Hayes@Dell.com wrote:
>
>     > I have discovered a problem with how Linux determines IDE disk
> "logical"
>     > (BIOS) geometry.
>
> The concept of logical geometry is slowly vanishing.
>
> Supporting it is impossible, but there were some attempts,
> and in the 2.0, 2.2, 2.4, 2.6 series each kernel drops
> some of the contortions present in previous versions.
>
> I wrote long stories in http://www.win.tue.nl/~aeb/linux/Large-Disk.html
> and even more in various replies to questions like this one,
> but the easiest point of view is "geometry does not exist".
>
>     > If an IDE hard drive has no partition table when Linux is booted,
>     > *and* if the hard drive is on a PCI IDE controller (a controller
>     > that isn't at I/O address 1f0h), *and* if the drive doesn't support
>     > 48-bit addressing, Linux will just use the geometry that is reported
>     > by the drive in with the "identify device" command, rather than
>     > getting the geometry used by the IDE BIOS by doing an int13 function 8
>     > call.
>
> "Linux will just use" - but roughly speaking Linux never uses the geometry,
> there is no need for a concept like that. Fortunately, because there is
> no such thing, so we would have problems if it were actually needed.
>
> "Roughly speaking": user space can ask for a geometry using HDIO_GETGEO
> and then gets some random #cyls / #heads / #secs/track. Also - in some
> cases the "last cylinder" plays a role, and of course nobody knows where
> that is unless disk size and geometry are given.
>
> Asking the BIOS is one of the attempts at support. It fails in many ways.
> One reason is that the correspondence between BIOS devices and kernel
> devices is unknown - so if we do an INT 13 call for device 0x80, for which
> device do we get data? hda? hdb? sda?
> Also, the BIOS may allow us only to inquire about the first two disks.
>
> Since the kernel does not use this info, and only transmits it to fdisk
> and LILO, and fdisk and LILO need slightly different information anyway,
> there is no good reason to keep this code in the kernel.
>
> Finally, things can be forced on all levels. The kernel has boot parameters
> telling it what to reply to HDIO_GETGEO. And LILO and fdisk have command
> parameters that allow the specification of a geometry.
> And no geometry is needed at all with LILO "linear" or "lba32" and
> with fdisk on a disk larger than 8 GB.
>
>     > If a partition table is then created on the drive using this geometry,
>     > the CHS values in the partition table will not be correct.
>
> "correct" has no meaning here.
>
> "geometry" is not a property of the disk, but of CMOS, BIOS, OS.
>
>     > I would think that the best solution
>
> But is there a problem?
>
> Andries

Geometry is not a property of the disk IFF the disk interface
accepts random offsets into the device. It doesn't. You end
up with different "sectors" (blocks) with different lengths
and boundaries. Many (most) disks will automatically move
to another head when one runs out of logical sectors, but
few will seek to another track! Instead, they return partial
reads or writes that need to be completed. This tends to
maintain the notion of CHS when, as you pointed out, there
doesn't really need to be any such.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


