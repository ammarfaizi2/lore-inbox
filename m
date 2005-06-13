Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVFMXsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFMXsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFMXrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:47:02 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:47335 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261218AbVFMXg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:36:59 -0400
Message-ID: <42ADB5B4.1020704@cyte.com>
Date: Mon, 13 Jun 2005 09:35:00 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: amd64 cdrom access locks system
References: <42A64556.4060405@cyte.com>	<20050608052354.7b70052c.akpm@osdl.org>	<42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>
In-Reply-To: <20050609160045.69c579d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton said I should carbon copy the IDE developer on this
issue so I have in the hopes of re-opening this issue and making
some progress since I'm still unable to write anything with my
cd-burner.

Here's what I know to date:

    I have the alim15x3 IDE driver installed and running.
    I do NOT have any of the generic IDE drivers installed or
       even compiled as they grossly interfere with the alim15x3
       and cause a kernel panic.
    My hardware is an AMD64 FX55 in a Shuttle ST20G5 case with a
       serial ATA harddrive.
    I'm using a stock 2.6.12-rc6 kernel.
    Debian unstable distribution.

At first I can read from the drive fine.
    For instance I did two "cdparanoia -B -d /dev/hda" without
    a hitch. Nothing was reported in /var/log/kernel as a result.

The problem is that I can't write to the drive (burn cds with
cdrecord) with causing a lost interrupt and then nothing works;
even reads don't respond.

When I do:
    cdrecord -v -tao dev=ATAPI:/dev/hda something.iso

I get this output:
   Cdrecord-Clone 2.01.01a01 (x86_64-unknown-linux-gnu) Copyright (C) 
1995-2004 Joerg Schilling
   NOTE: this version of cdrecord is an inofficial (modified) release of 
cdrecord
         and thus may have bugs that are not present in the original 
version.
         Please send bug reports and support requests to 
<cdrtools@packages.debian.org>.
         The original author should not be bothered with problems of 
this version.

   cdrecord: Warning: Running on Linux-2.6.12-rc6-jw14
   cdrecord: There are unsettled issues with Linux-2.5 and newer.
   cdrecord: If you have unexpected problems, please try Linux-2.4 or 
Solaris.
   TOC Type: 1 = CD-ROM
   scsidev: 'ATAPI:/dev/hda'
   devname: 'ATAPI:/dev/hda'
   scsibus: -2 target: -2 lun: -2
   Warning: Using ATA Packet interface.
   Warning: The related Linux kernel interface code seems to be 
unmaintained.
   Warning: There is absolutely NO DMA, operations thus are slow.
   Using libscg version 'ubuntu-0.8ubuntu1'.
   cdrecord: Warning: using inofficial version of libscg 
(ubuntu-0.8ubuntu1 '@(#)scsitransp.c      1.91 04/06/17 Copyright 
1988,1995,2000-2004 J. Schilling').
   SCSI buffer size: 64512
   atapi: 1
   Device type    : Removable CD-ROM
   Version        : 0
   Response Format: 2
   Capabilities   :
   Vendor_info    : 'SONY    '
   Identifikation : 'DVD RW DRU-500A '
   Revision       : '2.0h'
   Device seems to be: Generic mmc2 DVD-R/DVD-RW.
   Current: 0x0009
   Profile: 0x001B
   Profile: 0x001A
   Profile: 0x0014
   Profile: 0x0013
   Profile: 0x0011
   Profile: 0x0010
   Profile: 0x000A
   Profile: 0x0009 (current)
   Profile: 0x0008

And nothing else happens. (The drive light isn't even lit.)
The machine isn't locked up. (I'm typing this as it happened.)

after a minute, or so, /var/log/kern.log reports this:
   Jun 13 08:57:25 localhost kernel: ide-cd: cmd 0x3 timed out
   Jun 13 08:57:25 localhost kernel: hda: lost interrupt

A bit later (exactly one minute) kern.log again reports:
   Jun 13 08:58:25 localhost kernel: ide-cd: cmd 0x3 timed out
   Jun 13 08:58:25 localhost kernel: hda: lost interrupt

Then nothing else seems to happen through I've waited several minutes
more.

When I try to Ctrl-C the cdrecord process, it seems to be ignored.
But many minutes later the process dies after kern.log logs:
   Jun 13 09:05:05 localhost kernel: hda: lost interrupt
   Jun 13 09:06:05 localhost kernel: ide-cd: cmd 0x1e timed out
   Jun 13 09:06:05 localhost kernel: hda: lost interrupt

after this point all access to the cd drive takes a *very* long
time to complete (or doesn't seem to complete at all).
The first time I did: eject -v /dev/hda it took several minutes to
complete. During which time kern.log again reports:
   Jun 13 09:18:20 localhost kernel: hda: lost interrupt
   Jun 13 09:19:20 localhost kernel: hda: lost interrupt
   Jun 13 09:20:20 localhost kernel: ide-cd: cmd 0x1e timed out
   Jun 13 09:20:20 localhost kernel: hda: lost interrupt

The second time I did eject it didn't seem to complete at all and
kern.log reported:
   Jun 13 09:18:20 localhost kernel: hda: lost interrupt
   Jun 13 09:19:20 localhost kernel: hda: lost interrupt
   Jun 13 09:20:20 localhost kernel: ide-cd: cmd 0x1e timed out
   Jun 13 09:20:20 localhost kernel: hda: lost interrupt
   Jun 13 09:21:43 localhost kernel: hda: lost interrupt
   Jun 13 09:22:43 localhost kernel: ide-cd: cmd 0x3 timed out
   Jun 13 09:22:43 localhost kernel: hda: lost interrupt
   Jun 13 09:23:42 localhost kernel: ide-cd: cmd 0x3 timed out
   Jun 13 09:23:42 localhost kernel: hda: lost interrupt
   Jun 13 09:24:44 localhost kernel: hda: lost interrupt
   Jun 13 09:25:44 localhost kernel: hda: lost interrupt
   Jun 13 09:26:44 localhost kernel: ide-cd: cmd 0x25 timed out
   Jun 13 09:26:44 localhost kernel: hda: lost interrupt
   Jun 13 09:27:44 localhost kernel: ide-cd: cmd 0x25 timed out
   Jun 13 09:27:44 localhost kernel: hda: lost interrupt
   Jun 13 09:28:44 localhost kernel: hda: lost interrupt
   Jun 13 09:29:44 localhost kernel: hda: lost interrupt
   Jun 13 09:30:44 localhost kernel: hda: lost interrupt
   Jun 13 09:31:44 localhost kernel: hda: lost interrupt
   Jun 13 09:32:44 localhost kernel: hda: lost interrupt
   Jun 13 09:33:44 localhost kernel: hda: lost interrupt

Any ideas on how I can fix this?

-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)
