Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUBRQ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267342AbUBRQ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:57:25 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:24456 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S267362AbUBRQzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:55:22 -0500
Date: Wed, 18 Feb 2004 10:55:05 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
In-Reply-To: <200402160109.05151.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.21.0402181042090.8134-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 16 of February 2004 00:34, Nico Schottelius wrote:
> > Bartlomiej Zolnierkiewicz [Fri, Feb 13, 2004 at 05:17:34PM +0100]:
> > > [ ... ]
> > > Check your disk with SMART tools: http://smartmontools.sf.net.
> >
> > Before I continue to report what I've found out:
> >
> > Thank you all for your good help!
> >
> > I'm really down as this is the second disk
> > dyeing within two month (and the second 2.5" hd even, I begin to think
> > notebooks don't like me :/).
> 
> :-(  sh*t happens
> 
> > I currently collect all data I get / find out to
> >
> > http://schotteli.us/~nico/hd-problem.02/
> > (renamed it, as this does not look like a kernel problem and I don't
> > want somebody believe this).
> >
> > Currently I don't really understand the output of smartctl and cannot
> > say what causes the error. Perhaps someone can give me a hint on this?
> 
> The most important things are: READ DMA errors were logged,
> SMART self tests (short and extended) completed with read failure.

FWIW, after reading this thread, I've slightly modified smartmontools so
that when smartctl prints the error log (-l error) it ALSO prints the LBA
at which a READ or WRITE command failed.

[Note that this is a 28-bit sector address.  If a disk is larger than 2^37
Bytes = 137 GB, then some LBAs can't be written in 28 bits, in which case
there won't be a summary error log entry.  If the disk is smaller than
2^37 Bytes then the failing LBA address should always be logged.]

This feature is in smartmontools releases AFTER 5.27, or from the
smartmontools CVS server.

In the case of Nico's disk the failed READ LBA address can be computed
from the error log registers at
http://schotteli.us/~nico/hd-problem.02/smartctl-a:

  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 01 32 bb 7e e0  Error: UNC

yielding:

  LBA = 0x007ebb32 (bits 0-3 of DH, CH, CL and SN)

which can be compared with the LBA of the first error in the self-test
log:

# 1  Extended offline    Completed: read failure       90%      1633
0x007ebb32

and with the LBA logged in SYSLOG:
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8305458,
sector=8305454

Since 8305458 = 0x7EBB32 it's a pretty open and shut case.

****************************************************************

Executive summary: smartmontools versions > 5.27 will print this:

  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 01 32 bb 7e e0  Error: UNC at LBA = 0x007ebb32 = 8305458

rather than this:

  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 01 32 bb 7e e0  Error: UNC

Cheers,
	Bruce




