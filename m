Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319829AbSIMXgl>; Fri, 13 Sep 2002 19:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319830AbSIMXgl>; Fri, 13 Sep 2002 19:36:41 -0400
Received: from daytona.gci.com ([205.140.80.57]:15114 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S319829AbSIMXgk>;
	Fri, 13 Sep 2002 19:36:40 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA31509E4C934@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Raid 1 Issues
Date: Fri, 13 Sep 2002 15:41:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.18, and trying to use Raid-1.

I created /etc/raidtab according to the instructions.
    raiddev /dev/md0
        raid-level      1
        nr-raid-disks   2
        nr-spare-disks  0
        device  /dev/hdc2
        raid-disk       0
        device /dev/hdb2
        raid-disk       1

Next, I performed a raidsetup on my new disk (/dev/hdc2), and restarted.  I
was
able to mount my new md0 with a single disk.

I then migrated all my data onto that new md0 and removed the old disk
(/dev/hdbX)
from /etc/fstab. I changed fstab to mount /dev/md0 as /usr and shutdown.

I removed the old /dev/hdb, and installed the new drive, a duplicate model
of /dev/hdc,
and restarted.  I have no problems accessing /usr at this point, mounted
from /dev/md0.

I partitioned /dev/hdb to be exactly like /dev/hdc, and formatted it as
ext3.
I then used raidhotadd /dev/md0 /dev/hdb2 to try and add the new partition
to
my mirror.

"cat /proc/mdstat"  shows the the devices connected, but not attached:

	Personalities : [raid1] 
	read_ahead 1024 sectors
	md0 : active raid1 ide/host0/bus0/target1/lun0/part2[1]
ide/host0/bus1/target0/lun0/part2[0]
	      77914752 blocks [1/1] [U]
      unused devices: <none>


I waited for a while, installed some software, and then looked at
/proc/interrupts:
root@hedwig:~> cat /proc/interrupts 
           CPU0       
  0:   14635352          XT-PIC  timer
 14:     581245          XT-PIC  ide0
 15:    1341378          XT-PIC  ide1

I have 2 disks on ide0,( / and /dev/hdb2), 2 disks on ide1 (/dev/hdc2 and
/dev/cdrom)

The difference in interrupts is really significant when moving data around.
ide0 doesn't
increment at the rate that ide1 does (nowhere close!) when accessing
/dev/md0 (mounted on /usr)

if I raidhotremove /dev/md0 /dev/hdb2, and then mount /dev/hdb2, there is
nothing on the
disk.

I've consulted the how-to without any success.

Thanks for any help or suggestions.
