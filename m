Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUDPRqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUDPRqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 13:46:46 -0400
Received: from c-24-10-136-159.client.comcast.net ([24.10.136.159]:35332 "EHLO
	chaljin") by vger.kernel.org with ESMTP id S261875AbUDPRqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 13:46:38 -0400
Message-ID: <40801BFC.3090702@spishack.com>
Date: Fri, 16 Apr 2004 11:46:36 -0600
From: cira <linux@spishack.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <200404152030.51052.vda@port.imtp.ilyichevsk.odessa.ua> <407F315E.2000809@pobox.com> <200404161748.38958.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404161748.38958.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Friday 16 April 2004 04:05, Jeff Garzik wrote:

>>It seems like the situation is already resolved, to me.
>>
>>When you mount a filesystem, it changes the default block size (512 or
>>1024) to the filesystem block size, normally 4096.  This would certainly
>>increase the throughput.
> 
> 
> Yes, this works.
> 
> But if one uses unpartitioned disk, why does (s)he need to
> do some blocksize tricks before hdparm starts to measure good performance?
> I think that in this case block layer can coalesce small read requests
> into large ones regardless of block size.

debian unstable
kernel 2.6.5 with udev
promise sata150 tx4
dual seagate ST3120026AS (120GB)
libata 1.02
sata_promise 0.91

Thank you all!

I use lvm2 with /dev/sda and /dev/sdb as members of my volume group. 
That means, no partition tables.  The logical volume contains a 
ReiserFS.  Once the logical volume is mounted the higher transfer rates 
are seen.

22 root@chaljin:/mnt # mount /dev/sdb1 sdb1
23 root@chaljin:/mnt # mount | grep sdb

/dev/scsi/host1/bus0/target0/lun0/part1 on /mnt/sdb1 type ext2 (rw)

24 root@chaljin:/mnt # hdparm -t /dev/sdb

/dev/sdb:
  Timing buffered disk reads:   32 MB in  3.04 seconds =  10.52 MB/sec

25 root@chaljin:/mnt # hdparm -t /dev/sdb

/dev/sdb:
  Timing buffered disk reads:  166 MB in  3.02 seconds =  54.98 MB/sec

26 root@chaljin:/mnt # umount /dev/sdb1

Ah, the change is not stable either.  If I umount the partition it
reverts to the slower rate.  There is no need to reboot.

 > Konstantin, does dd give you the same behaviour as hdparm?
 > --
 > vda

Yes, dd does behave the same as hdparm.

39 root@chaljin:/root # dd bs=512 count=65536 if=/dev/sdb of=/dev/null

65536+0 records in
65536+0 records out
33554432 bytes transferred in 3.203750 seconds (10473487 bytes/sec)

40 root@chaljin:/root # cd /mnt
41 root@chaljin:/mnt # mount /dev/sdb1 sdb1
42 root@chaljin:/mnt # dd bs=512 count=65536 if=/dev/sdb of=/dev/null

65536+0 records in
65536+0 records out
33554432 bytes transferred in 3.184339 seconds (10537330 bytes/sec)

43 root@chaljin:/mnt # dd bs=512 count=65536 if=/dev/sdb of=/dev/null

65536+0 records in
65536+0 records out
33554432 bytes transferred in 0.400394 seconds (83803552 bytes/sec)

44 root@chaljin:/mnt # dd bs=512 count=339968 if=/dev/sdb of=/dev/null

339968+0 records in
339968+0 records out
174063616 bytes transferred in 2.705558 seconds (64335569 bytes/sec)

45 root@chaljin:/mnt #

If anyone wants further testing just let me know.  I still have one 
blank disk and one promise sata150 tx4 controller that is not yet in use.

-cira

(I'm on the linux-ide list)

