Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVCPUCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVCPUCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVCPUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:02:30 -0500
Received: from postoffice.prismnet.com ([209.198.128.18]:28679 "EHLO
	postoffice.prismnet.com") by vger.kernel.org with ESMTP
	id S262774AbVCPUCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:02:14 -0500
From: "J. Ryan Earl" <ryan@dynaconnections.com>
To: <nbd-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       "Linux RAID" <linux-raid-owner@vger.kernel.org>
Subject: Interesting problem with running MD devices across NBD
Date: Wed, 16 Mar 2005 14:03:24 -0600
Message-ID: <OMEKLMBKKEOEENCKLEIDKEEJCFAA.ryan@dynaconnections.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, let me describe the situation and what I'm trying to achieve.

I have two servers, each with 5 146GB SCSI disks.  These disks are connected
to a LSI MegaRAID controller running the new driver, which seems to work
great.  I have partitioned such that there is a ~520GB partition dedicated
to storing media, this is /dev/sda4.  The 2 servers are partitioned
identically.

Now on one server, call it the master, I setup /dev/md0 as a RAID1 volume
with 2 devices: /dev/sda4 and /dev/nbd0.  Now /dev/nbd0 is the slave's
/dev/sda4 partition exported via NBD.  Both partitions are of type 'fd' =
Linux Raid Autodetect, but I have raid1.c compiled as a module so that md0
doesn't get autodetected and half-started at boot on both of the media
servers.

Now the goal in all this is simply to have a more highly-available media
serving solution.  If the master goes down, all I have to do is stop the
nbd-server on the slave, mount /dev/sda4 on the slave replaying all
uncompleted filesystem transactions, export the volume, and point clients
the export.  I'm using ReiserFS for this, and all seems great, except...

When I kill a process doing I/O across the syncronized /dev/md0 mount and
kill the process (think ctrl+c) it not only kills the process doing I/O, it
kills the nbd-client process as well!  This in turn causes /dev/md0 to mark
/dev/nbd0 as failed and the mirror loses sync:

# Syncing completes
Mar 15 15:06:09 mannoroth md: md0: sync done.
Mar 15 15:06:09 mannoroth RAID1 conf printout:
Mar 15 15:06:09 mannoroth --- wd:2 rd:2
Mar 15 15:06:09 mannoroth disk 0, wo:0, o:1, dev:nbd0
Mar 15 15:06:09 mannoroth disk 1, wo:0, o:1, dev:sda4

# I run a du /dev/md0's filesystem and kill it before it completes
Mar 15 15:22:40 mannoroth nbd (pid 15715: du) got signal 9
Mar 15 15:22:40 mannoroth nbd0: Send control failed (result -4)
Mar 15 15:22:40 mannoroth nbd0: Request send failed
Mar 15 15:22:40 mannoroth end_request: I/O error, dev nbd0, sector 727355960
Mar 15 15:22:40 mannoroth raid1: Disk failure on nbd0, disabling device.
Mar 15 15:22:40 mannoroth       Operation continuing on 1 devices
Mar 15 15:22:40 mannoroth raid1: nbd0: rescheduling sector 727355960
Mar 15 15:22:40 mannoroth nbd0: Unexpected reply (de0c3e28)
Mar 15 15:22:40 mannoroth nbd0: shutting down socket
Mar 15 15:22:40 mannoroth nbd0: queue cleared
Mar 15 15:22:40 mannoroth RAID1 conf printout:
Mar 15 15:22:40 mannoroth --- wd:1 rd:2
Mar 15 15:22:40 mannoroth disk 0, wo:1, o:0, dev:nbd0
Mar 15 15:22:40 mannoroth disk 1, wo:0, o:1, dev:sda4
Mar 15 15:22:40 mannoroth RAID1 conf printout:
Mar 15 15:22:40 mannoroth --- wd:1 rd:2
Mar 15 15:22:40 mannoroth disk 1, wo:0, o:1, dev:sda4
Mar 15 15:22:40 mannoroth raid1: sda4: redirecting sector 727355960 to
another mirror

Killing du is killing nbd-client for some reason.  This has to be an error
of some sort, but I'm not sure where to look first.  Any ideas on how to fix
this?  I repartitioned to use 10GB volume instead of 520GB volumes to reduce
the sync time so I could test this further.  I've tried killing an `ls -R *`
and a `find .` and they both terminate fine without bringing down
nbd-client, I can even kill them with a -9 and it's ok.  Killing an fsck on
a sync'd but unmounted /dev/md0 also doesn't not bring down the nbd-client;
on 'du' appears to cause this.

I'm kinda baffled.  Why would killing a du running on an md device
consisting of an nbd mirror bring down that nbd mirror?  It's like the
signal doesn't get caught and goes up the chain.

Please reply to me directly in addition to the list as I'm not on all the
lists.

Thanks in advance,
-ryan

PS Some version information:

mannoroth media # du --version
du (coreutils) 5.2.1
Written by Torbjorn Granlund, David MacKenzie, Paul Eggert, and Jim
Meyering.

Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

mannoroth media # cat /proc/version
Linux version 2.6.11-gentoo-r3 (root@mannoroth) (gcc version 3.3.5 (Gentoo
Linux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #2 SMP Sat Mar 12 15:28:27 CST
2005
# 2.6.11.2 derived kernel

mannoroth media # nbd-client --version
nbd-client version 2.7.2
Usage: nbd-client [bs=blocksize] host port nbd_device [-swap]
Or   : nbd-client -d nbd_device
Default value for blocksize is 1024 (recommended for ethernet)
Allowed values for blocksize are 512,1024,2048,4096
Note, that kernel 2.4.2 and older ones do not work correctly with
blocksizes other than 1024 without patches

