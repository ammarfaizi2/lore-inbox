Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUBTQZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUBTQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:25:49 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:59528 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S261307AbUBTQZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:25:22 -0500
Date: Fri, 20 Feb 2004 10:25:14 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
In-Reply-To: <20040219080115.GD25184@schottelius.org>
Message-ID: <Pine.GSO.4.21.0402201022540.20183-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [...] 
> > FWIW, after reading this thread, I've slightly modified smartmontools
so
> > that when smartctl prints the error log (-l error) it ALSO prints the
LBA
> > at which a READ or WRITE command failed.
> 
> Thank you very much for patching smartctl and explaining howto calulate
> the LBA from those values.

You're welcome!

> So at least my hd crash had some sense.

Yes.  One of the 512-byte sectors became unreadable, so when the OS
asked for the data from that sector, the disk generated a hard error.
 
> > [Note that this is a 28-bit sector address.  If a disk is larger than
2^37
> > Bytes = 137 GB, then some LBAs can't be written in 28 bits, in which
case
> > there won't be a summary error log entry.  If the disk is smaller than
> > 2^37 Bytes then the failing LBA address should always be logged.]
> 
> Why are we bound to a 28 bit value?
> As there are currently more and more disks out there with >=260GB, I
> think this will be an issue very soon.

To quote from the ATA specifications:

"The summary error log supports 28-bit addressing only".

This summary error log is the error log currently printed by
smartmontools. In principle, for ATA 6 and 7, there are two additional
logs: 'Comprehensive SMART error' log and 'Extended Comprehensive
SMART error log'.  The 'Comprehensive SMART error log' is also 28-bit
addresses only.  The 'Extended' log also supports 48-bit addresses.

The '-l directory' option to smartctl will show what logs your disk
supports.

When I actually get my hands on a disk that supports the 'Extended'
log, I'll add code to smartmontools to print it.  However, at least up
to this point I have not seen a disk that supports it.  To cite one
example, a recent Maxtor 250 GB disk (manufacture date Jan 28, 2004)
 Device Model:     Maxtor 6Y250P0
 Serial Number:    Y60PYXBE
 Firmware Version: YAR41BW0
does NOT support the Extended error logs.

Once I find a disk that actually supports the logs, I need to use the
ATA READ LOG EXT command to get the logs.  In order to issue this
command under Linux, I need to use the .  HDIO_DRIVE_TASKFILE ioctl().
In my experience many distribution kernels (eg, Redhat) don't support
this ioctl(), so users may need to rebuilt their kernels in order to
be able to read the Extended error logs.

Cheers,
	Bruce

