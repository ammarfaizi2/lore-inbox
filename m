Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTJVUmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTJVUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 16:42:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:220 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263570AbTJVUmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 16:42:35 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 22 Oct 2003 22:42:12 +0200 (MEST)
Message-Id: <UTC200310222042.h9MKgCi18202.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl, Stuart_Hayes@Dell.com
Subject: Re: IDE "logical" geometry & partition tables (problem with 2.4 kerne l, also seems to apply to 2.6)
Cc: Andries.Brouwer@cwi.nl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Wednesday 22 of October 2003 00:00, Stuart_Hayes@Dell.com wrote:

    > I have discovered a problem with how Linux determines IDE disk "logical"
    > (BIOS) geometry.

The concept of logical geometry is slowly vanishing.

Supporting it is impossible, but there were some attempts,
and in the 2.0, 2.2, 2.4, 2.6 series each kernel drops
some of the contortions present in previous versions.

I wrote long stories in http://www.win.tue.nl/~aeb/linux/Large-Disk.html
and even more in various replies to questions like this one,
but the easiest point of view is "geometry does not exist".

    > If an IDE hard drive has no partition table when Linux is booted,
    > *and* if the hard drive is on a PCI IDE controller (a controller
    > that isn't at I/O address 1f0h), *and* if the drive doesn't support
    > 48-bit addressing, Linux will just use the geometry that is reported
    > by the drive in with the "identify device" command, rather than
    > getting the geometry used by the IDE BIOS by doing an int13 function 8
    > call.

"Linux will just use" - but roughly speaking Linux never uses the geometry,
there is no need for a concept like that. Fortunately, because there is
no such thing, so we would have problems if it were actually needed.

"Roughly speaking": user space can ask for a geometry using HDIO_GETGEO
and then gets some random #cyls / #heads / #secs/track. Also - in some
cases the "last cylinder" plays a role, and of course nobody knows where
that is unless disk size and geometry are given.

Asking the BIOS is one of the attempts at support. It fails in many ways.
One reason is that the correspondence between BIOS devices and kernel
devices is unknown - so if we do an INT 13 call for device 0x80, for which
device do we get data? hda? hdb? sda?
Also, the BIOS may allow us only to inquire about the first two disks.

Since the kernel does not use this info, and only transmits it to fdisk
and LILO, and fdisk and LILO need slightly different information anyway,
there is no good reason to keep this code in the kernel.

Finally, things can be forced on all levels. The kernel has boot parameters
telling it what to reply to HDIO_GETGEO. And LILO and fdisk have command
parameters that allow the specification of a geometry.
And no geometry is needed at all with LILO "linear" or "lba32" and
with fdisk on a disk larger than 8 GB.

    > If a partition table is then created on the drive using this geometry,
    > the CHS values in the partition table will not be correct.

"correct" has no meaning here.

"geometry" is not a property of the disk, but of CMOS, BIOS, OS.

    > I would think that the best solution

But is there a problem?

Andries
