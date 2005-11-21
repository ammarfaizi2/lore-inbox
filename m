Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVKUUbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVKUUbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVKUUbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:31:17 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:42662 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750986AbVKUUbQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:31:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RqAhISMNT+rhLj0JP27KlGzE4YOgFhoar3IA0oZo+UudRTyq9SU53vvyCHnU53ELkWi3IiFSQ7ctxj12mXyhnLPDM1aNMOriEsXhmC5Kwc1Ym2C5lWtY7CDybCVvKSn0HkFClLXBoL6RgA0TsUgBFqG/1KfScm2d713WkvpbsyE=
Message-ID: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
Date: Mon, 21 Nov 2005 21:31:14 +0100
From: Lars Roland <lroland@gmail.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Poor Software RAID-0 performance with 2.6.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have created a stripe across two 500Gb disks located on separate IDE
channels using:

mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd

the performance is awful on both kernel 2.6.12.5 and 2.6.14.2 (even
with hdparm and blockdev tuning), both bonnie++ and hdparm (included
below) shows a single disk operating faster than the stripe:

----
dkstorage01:~# hdparm -t /dev/md0
/dev/md0:
 Timing buffered disk reads:  182 MB in  3.01 seconds =  60.47 MB/sec

dkstorage02:~# hdparm -t /dev/hdc1
/dev/hdc1:
Timing buffered disk reads:  184 MB in  3.02 seconds =  60.93 MB/sec
----

I am aware of cpu overhead with software raid but such a degradation
should not be the case with raid 0, especially not when the OS is
located on a separate SCSI disk - the IDE disks should just be ready
to work.

There have been some earlier reporting on this problem but they all
seam to end more and less inconclusive (here is one
http://kerneltrap.org/node/4745). Some people favors switching to
dmraid with device mapper, is this the de facto standard today ?

Examining the setup with mdadm gives:
-------
dkstorage01:~# mdadm -E /dev/hdb
/dev/hdb:
          Magic : a92b4efc
        Version : 00.90.02
           UUID : 7edc2c10:6cb402e8:06d9bd91:57b11f01
  Creation Time : Mon Nov 21 19:38:30 2005
     Raid Level : raid0
    Device Size : 488386496 (465.76 GiB 500.11 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 0

    Update Time : Mon Nov 21 19:38:30 2005
          State : active
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0
       Checksum : 9766c3ec - correct
         Events : 0.1

     Chunk Size : 4K

      Number   Major   Minor   RaidDevice State
this     1       3       64        1      active sync   /dev/hdb

   0     0      22       64        0      active sync   /dev/hdd
   1     1       3       64        1      active sync   /dev/hdb
-------

mdadm is v1.12.0.



--
Lars Roland
