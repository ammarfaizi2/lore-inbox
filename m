Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSG2XvY>; Mon, 29 Jul 2002 19:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSG2XvY>; Mon, 29 Jul 2002 19:51:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50843 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314149AbSG2XvV>;
	Mon, 29 Jul 2002 19:51:21 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 30 Jul 2002 01:54:41 +0200 (MEST)
Message-Id: <UTC200207292354.g6TNsfR09632.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, peter@chubb.wattle.id.au
Subject: Re: [PATCH] partition fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Peter Chubb <peter@chubb.wattle.id.au>

    With regard to disc geometry...  Almost every SCSI low level driver
    has identical code for faking the geometry.  Is there any good reason
    why?  Why not provide a generic version, and only set the bios_param
    member in the SCSI host template to something special where it's
    needed?

> disc?

OK, I see what country you are from.

> Why are fragments of source repeated N times in the kernel?

People copy.

> Why not provide a generic version?

There is a generic version.

> Only set the bios_param member in the SCSI host template
> to something special where it's needed?

Since I intend to remove everything having to do with geometry
from the kernel the question is perhaps no longer of interest.

But as long as we support this phantom, it is not easy to decide
where precisely it is needed since that requires knowledge of the
common DOS drivers.

Some theory [longish]:
(i) IDE and SCSI disks do not have a geometry.
(ii) But MFM and RLL disks did.
So, when addressing MFM and RLL disks one has to know the geometry.
Often that information is supplied by the user in the Setup-CMOS.
Linux got that info at boot time from the BIOS for disks 1 and 2.
(iii) IDE disks can be addressed in two ways: CHS and LBA.
When an IDE disk is addressed using CHS a geometry is needed.
Since an IDE disk does not have a geometry, one tells the drive
what geometry it is supposed to have today. It can be chosen freely.
(iv) For IDE disks using LBA and for SCSI disks geometry does
not play any role.

That is the I/O part of geometry. Unless you have an old MFM disk,
you are not interested.

(v) The DOS-type partition table describes start and size of a
partition in two ways: a) in longs - this is what Linux uses,
b) in a CHS notation - this is what DOS mostly uses.

Unless you have both Linux and DOS/Windows/... on the same disk,
you are not interested. But if you have, you need a geometry.
Not the geometry of the disk - the disk does not have a geometry.
You need the geometry that DOS would use.

So, some voodoo is needed to guess what DOS will use on this disk.
For IDE drives the voodoo can be fairly uniform.
But SCSI drives are connected to a SCSI controller that often
has jumpers or a setup menu to allow the user to specify what
geometry or translation its BIOS is supposed to fake for DOS.
A Linux SCSI driver must therefore know what the corresponding
DOS SCSI driver would do, given jumper settings and setup options.

A few drivers do this correctly. Most don't, usually because
the driver authors did not understand what was expected.

But all of this is hopefully a thing of the past.


Andries
