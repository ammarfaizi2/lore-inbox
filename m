Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTFLTOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbTFLTOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:14:35 -0400
Received: from devil.servak.biz ([209.124.81.2]:10431 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S264955AbTFLTOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:14:33 -0400
Subject: SBP2 hotplug doesn't update /proc/partitions
From: Torrey Hoffman <thoffman@arnor.net>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@digeo.com>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030606025721.GJ625@phunnypharm.org>
References: <1054770509.1198.79.camel@torrey.et.myrio.com>
	 <3EDE870C.1EFA566C@digeo.com>
	 <1054838369.1737.11.camel@torrey.et.myrio.com>
	 <20030605175412.GF625@phunnypharm.org>
	 <1054858724.3519.19.camel@torrey.et.myrio.com>
	 <20030606025721.GJ625@phunnypharm.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055446080.3480.291.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Jun 2003 12:28:00 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am now running 2.5.70-bk15, and with slab debugging turned off SBP2
mostly works.  However, I just had an interesting glitch show up.

I plugged in a 120 GB drive which had two VFAT partitions, mounted them,
copied some data to them, unmounted them, and unplugged the drive.  
That worked perfectly. (This was the first use of SBP2 after booting.)

Then I plugged in a 250 GB drive with a single reiserfs partition.  The
SBP2 driver detected the drive correctly, but the kernel's idea of what
partitions are available was not updated.  

/proc/partitions still has the old, stale data from the 120 GB drive and
looks like this: (skipping my hda partitions)

major minor  #blocks  name

   8     0  117187500 sda
   8     1   80011701 sda1
   8     2   37174410 sda2

fdisk /dev/sda believes the drive is only 120 GB but has a single 250 GB
partition:

[root@torrey mnt]# fdisk /dev/sda

The number of cylinders for this disk is set to 14589.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/sda: 120.0 GB, 120000000000 bytes
255 heads, 63 sectors/track, 14589 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1     30515 245111706   83  Linux


Attempting to mount the partition fails and produces lots of errors,
which is not surprising. A snippet of the system log:

Jun 12 12:10:12 torrey kernel: found reiserfs format "3.6" with standard journal
Jun 12 12:10:15 torrey kernel: limit=160023402
Jun 12 12:10:15 torrey kernel: attempt to access beyond end of device
Jun 12 12:10:15 torrey kernel: sda1: rw=0, want=394002440, limit=160023402
Jun 12 12:10:15 torrey kernel: attempt to access beyond end of device


Here is the system log of the 250 GB drive being plugged in and
correctly detected:

Jun 12 12:09:45 torrey /etc/hotplug/ieee1394.agent: Setup sbp2 for IEEE1394 product 0x000000/0x00609e/0x010483
Jun 12 12:09:45 torrey kernel: ieee1394: sbp2: Logged into SBP-2 device
Jun 12 12:09:45 torrey kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]Jun 12 12:09:45 torrey kernel:   Vendor: Maxtor 4  Model: A250J8            Rev:     
Jun 12 12:09:45 torrey kernel:   Type:   Direct-Access                      ANSI SCSI revision: 06
Jun 12 12:09:45 torrey kernel: error 1
Jun 12 12:09:46 torrey devlabel: devlabel service started/restarted


Thanks for your development efforts!

Torrey Hoffman



