Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUCOVt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUCOVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:49:25 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:49582 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262814AbUCOVru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:47:50 -0500
Date: Mon, 15 Mar 2004 22:47:42 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.4 ext3fs half order of magnitude slower than xfs - bulk write
Message-ID: <20040315214741.GA5042@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an application that writes bulky data files in a short time. The
file sizes are 7, 13, 75 and 95 MBytes (total 190); each file is fsynced
after write, the test partitions are otherwise idle.  Think gunzip if
you wish, but it isn't gunzip.

The destination partition is on a Maxtor 4K060H3 ATA drive (5400/min, 12
ms seek, UDMA/100 is enabled), with disabled write cache for one test
set and enabled write cache for another. The ext3 partition is on the
outside (hda5) of the xfs partition (hda7).

Either test uses default scheduler settings (anticipatory I/O
scheduler), ATA controller is a VIA 8237, 256 MB RAM of which around 130
MB are used for X11, and idle squid and some idle Perl processes.

For comparison purposes, I have also checked a reiserfs partition on a
7200/min SCSI drive with write cache and tagged command queueing on.

ext3fs runs in the default data=ordered mode for one test and
data=writeback for another. xfs runs in default mode without special
realtime tricks or such. XFS is at least by a factor three faster than
even ext3 -o data=writeback.

                          real usr system time in seconds
                             |   |   |  throughput MB/s approx.
ATA ext3 ordered WC on      52 6.3 1.2  3.6
ATA ext3 writeback WC on    46 6.4 1.3  4.1
ATA xfs WC on               15 6.3  .9 12.7

ATA ext3 ordered WC off    172 6.3 1.2  1.1
ATA ext3 writeback WC off  128 6.2 1.3  1.5
ATA xfs WC off              32 6.3  .9  5.9
-----------------------------------------------------------------------------
SCSI reiserfs TCQ on WC on  38 6.8 1.2  5.0

READ performance with hdparm -tT (above is write performance):
 Timing buffer-cache reads:  1180 MB in  2.01 seconds = 588.03 MB/sec
 Timing buffered disk reads:   98 MB in  3.03 seconds =  32.38 MB/sec

I'd think we can't reach such a value for writes to a real file system.

Watching "vmstat 1" reveals that ext3fs hangs with >= 98% I/O wait for a
long time, something the other FS don't do; the block-out rate is
considerably lower for ext3fs as well. XFS does not hesitate to stuff
down 26,000 blocks in a single second, ext3fs hardly exceeds 700.

What makes ext3fs so much slower than xfs? (Note that even XFS with
write cache on doesn't get close to even half of what one would expect of
such a system.)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
