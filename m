Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUCZFX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUCZFX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:23:28 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:8586 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263942AbUCZFXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:23:25 -0500
Message-ID: <4063BE4C.40504@nsr500.net>
Date: Thu, 25 Mar 2004 21:23:24 -0800
From: Tim Moore <linux-kernel@nsr500.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Linux Kernel Mailing List etc." <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1,
References: <20040213014804.13771.75238.Mailman@lists.us.dell.com>
In-Reply-To: <20040213014804.13771.75238.Mailman@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Timothy Miller wrote:
> I'm attempting to get some idea of how much overhead ext3 causes me on 
> my workstation at home.  Furthermore, I'm trying to determine what sort 
> of advantage I'm really getting from my 3ware RAID controller (model 
> 7000-2, configured for RAID1) over single disks.

3w 6400 (ATA/66), IBM DTLA-307020 (2MB, 7200RPM), Athlon K7 Model2 @880MHz, 
2.4.26-pre5, ext3:

abit:~ > hdparm -tT /dev/sdb1

/dev/sdb1:
  Timing buffer-cache reads:   644 MB in  2.00 seconds = 322.00 MB/sec
  Timing buffered disk reads:  100 MB in  2.89 seconds =  34.60 MB/sec

abit:~ > /usr/bin/time dd if=/dev/sdb1 of=/dev/null bs=1k
104391+0 records in
104391+0 records out
: dd if=/dev/sdb1 of=/dev/null bs=1k
: 3.01 0:03.01 s 0.70 u 0.04 c 24% mapf 112 mipf 12
abit:~ > /usr/bin/time dd if=/dev/zero of=/dev/sdb1 bs=1k count=104391
104391+0 records in
104391+0 records out
: dd if=/dev/zero of=/dev/sdb1 bs=1k count=104391
: 4.49 0:04.49 s 1.04 u 0.05 c 24% mapf 112 mipf 12

Raw writes ~ 67% raw reads.  Same disk, software raid0 mounted 
ext3,data=writeback:

abit:~ > hdparm -tT /dev/md0

/dev/md0:
  Timing buffer-cache reads:   628 MB in  1.99 seconds = 315.58 MB/sec
  Timing buffered disk reads:  204 MB in  3.01 seconds =  67.77 MB/sec

Note after many years and configurations I no longer use native 3w RAID.
0 because the disk cannot be sub-partitioned,
1 because the mirror half is not portable to another controller,
5 because there's no real cache on the 6400 and so no performance.
As a straight controller however, unbeatable.

abit:~ > fdisk -l

Disk /dev/sda: 255 heads, 63 sectors, 2501 cylinders
Units = cylinders of 16065 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1        13    104391   83  Linux
/dev/sda2            14        45    257040   82  Linux swap
/dev/sda3            46      2500  19719787+   5  Extended
/dev/sda5            46       306   2096451   fd  Linux raid autodetect
/dev/sda6           307       457   1212876   fd  Linux raid autodetect
/dev/sda7           458      1248   6353676   fd  Linux raid autodetect
/dev/sda8          1249      2500  10056658+  fd  Linux raid autodetect

Disk /dev/sdb: 255 heads, 63 sectors, 2501 cylinders
Units = cylinders of 16065 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/sdb1   *         1        13    104391   83  Linux
/dev/sdb2            14        45    257040   82  Linux swap
/dev/sdb3            46      2500  19719787+   5  Extended
/dev/sdb5            46       306   2096451   fd  Linux raid autodetect
/dev/sdb6           307       457   1212876   fd  Linux raid autodetect
/dev/sdb7           458      1248   6353676   fd  Linux raid autodetect
/dev/sdb8          1249      2500  10056658+  fd  Linux raid autodetect

