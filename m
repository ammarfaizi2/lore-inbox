Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTE3Jz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTE3Jzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:55:55 -0400
Received: from penguin.theopalgroup.com ([206.24.109.10]:45795 "EHLO
	penguin.theopalgroup.com") by vger.kernel.org with ESMTP
	id S263528AbTE3Jzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:55:53 -0400
Date: Fri, 30 May 2003 06:09:02 -0400 (EDT)
From: Kevin Jacobs <jacobs@penguin.theopalgroup.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: Ext3 meta-data performance
In-Reply-To: <3ED60574.3080308@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0305290923330.11990-100000@penguin.theopalgroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003, Nick Piggin wrote:
> Kevin Jacobs wrote:
> >[...]
> >Since these rsync backups are done in addition to traditional daily tape
> >backups, we've taken the system out of production use and opened the door
> >for experimentation.  So, the next logical step was to try a 2.5 kernel. 
> >After some work, I've gotten 2.5.70-mm2 booting and it is _much_ better than
> >the Redhat 2.4 kernels, and the system interactivity is flawless.  However,
> >the speed of creating hard-links is still three and a half times slower than
> >with the old 2.2 kernel.  It now takes ~14 minutes to create the links, and
> >from what I can tell, the bottlenecks is not the CPU or the disk-throughput. 
> >
> Its probably seek bound.
> Provide some more information about your disk/partition setup, and external
> journals, and data= mode. Remember ext3 will generally always have to do
> more work than ext2.

  SCSI ID 1  3ware 7500-8 ATA RAID Controller

     * Array Unit 0  Mirror (RAID 1)  40.01 GB   OK
          + Port 0 WDC WD400BB-00DEA0    40.02 GB   OK
          + Port 1 WDC WD400BB-00DEA0    40.02 GB   OK
     * Array Unit 4  Striped with Parity 64K (RAID 5)  555.84 GB   OK
          + Port 4 IC35L180AVV207-1    185.28 GB   OK
          + Port 5 IC35L180AVV207-1    185.28 GB   OK
          + Port 6 IC35L180AVV207-1    185.28 GB   OK
          + Port 7 IC35L180AVV207-1    185.28 GB   OK

Disk /dev/sda: 40.0 GB, 40019615744 bytes
255 heads, 63 sectors/track, 4865 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1       261   2096451   83  Linux
/dev/sda2           262      1566  10482412+  83  Linux
/dev/sda3          1567      4570  24129630   83  Linux
/dev/sda4          4571      4865   2369587+   f  Win95 Ext'd (LBA)
/dev/sda5          4571      4589    152586   83  Linux
/dev/sda6          4590      4734   1164681   83  Linux
/dev/sda7          4735      4865   1052226   83  Linux

Disk /dev/sdb: 555.8 GB, 555847581696 bytes
255 heads, 63 sectors/track, 67577 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1   *         1     67577 542812221   83  Linux

Unit 0 is /dev/sda and the journal is /dev/sda5. Unit 1 is /dev/sdb and the
backup filesystem is /dev/sdb1. The data= mode is whatever is default,
/dev/sdb1 is mounted noatime.  I've also applied the journal_refile_buffer
patch posted by AKPM yesterday morning.

> If you want to play with the scheduler, try set
> /sys/block/blockdev*/queue/nr_requests = 8192

This killed the entire system -- livelocking it with no disk activity to the
point that I had to hit the reset button.  So does setting nr_requests on
sda and sdb from 128 to 256.  The problems hit before the rsync, during a
'rm -Rf' on a previously copied tree.

> then try
> /sys/block/blockdev*/queue/iosched/antic_expire = 0

This seemed to make no difference.

> Try the above combinations with and without a big TCQ depth. You should
> be able to set them on the fly and see what happens to throughput during
> the operation. Let me know what you see.

I'm not sure how to change TCQ depth on the fly.  Last I knew, it was a
compiled-in parameter.

I have some more time to experiment, so please let me know if there is
anything else you think I should try.

Thanks,
-Kevin

-- 
--
Kevin Jacobs
The OPAL Group - Enterprise Systems Architect
Voice: (216) 986-0710 x 19         E-mail: jacobs@theopalgroup.com
Fax:   (216) 986-0714              WWW:    http://www.theopalgroup.com

