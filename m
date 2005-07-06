Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVGFWFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVGFWFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVGFVyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:54:55 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:17169 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S262450AbVGFVyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:54:08 -0400
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: linux-kernel@vger.kernel.org
Subject: Megaraid + reiser problem
Date: Wed, 6 Jul 2005 23:54:07 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507062354.07347.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with a megaraid controller, kernel:
Linux version 2.6.5-7.155.29-smp (geeko@buildhost) (gcc version 3.3.3 (SuSE 
Linux)) #1 SMP Thu Jun 2 12:07:05 UTC 2005

It crashed one reiserFS partition completely, leaving the system in a state in 
which only a power off/on will reboot the system. The partition can be 
mounted, but can not be used. According to the RAID controller, there are no 
physical problems with the disks, so there is no reason for the partition to 
fail in this way.

The question:
Is there anyway to determine what caused this problem to be blown out of 
proportions this much?

The situation:
There is a FAILED disk in the RAID since 3 days, the moment the problems 
started (RAID5, should not be a problem):

Channel: 0 Id: 0 State: Online.
  Vendor: Maxtor    Model: 7Y250M0           Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 03
Channel: 0 Id: 1 State: Online.
  Vendor: Maxtor    Model: 7Y250M0           Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 03
Channel: 0 Id: 2 State: Failed.
  Vendor:           Model: HDS724040KLSA80   Rev: KFAO
  Type:   Direct-Access                      ANSI SCSI revision: 03
Channel: 0 Id: 3 State: Online.
  Vendor: Maxtor    Model: 7Y250M0           Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 03

The disk on channel 0, id2 is a replacement disk which was in rebuild mode 
until one hour ago. Anyway, it decided to fail too (disk 3 on the same point 
which fails, probably it did not really fail, I will not know until later).

The diskconfiguration is in RAID5, the partitioning is as follows:
Disk /dev/sda: 752.9 GB, 752986619904 bytes
255 heads, 63 sectors/track, 91545 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

fstab
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1         131     1052226   82  Linux swap
/dev/sda2   *         132        2220    16779892+  83  Linux
/dev/sda3            2221       91539   717454867+  83  Linux


/dev/sda2            /                    reiserfs   acl,user_xattr        1 1
/dev/sda3            /data                auto       auto,user_xattr       0 0
/dev/sda1            swap                 swap       pri=42                0 0

dmesg output (relevant parts only), /dev/sda3 is not mounted at boottime 
anymore!!
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<5>RAMDISK: Compressed image found at block 0
<4>VFS: Mounted root (ext2 filesystem).
<5>SCSI subsystem initialized
<6>ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 48
<5>megaraid: found 0x1000:0x1960:bus 3:slot 1:func 0
<5>scsi0:Found MegaRAID controller at 0xf90f8000, IRQ:48
<5>megaraid: [713G:G117] detected 1 logical drives.
<5>megaraid: supports extended CDBs.
<6>megaraid: channel[0] is raid.
<6>scsi0 : LSI Logic MegaRAID 713G 254 commands 16 targs 4 chans 7 luns
<5>scsi0: scanning scsi channel 0 for logical drives.
<5>  Vendor: MegaRAID  Model: LD 0 RAID5  718G  Rev: 713G
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<5>SCSI device sda: 1470676992 512-byte hdwr sectors (752987 MB)
<3>sda: asking for cache data failed
<3>sda: assuming drive cache: write through
<6> sda: sda1 sda2 sda3
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>scsi0: scanning scsi channel 1 for logical drives.
<5>scsi0: scanning scsi channel 2 for logical drives.
<5>scsi0: scanning scsi channel 4 [P0] for physical devices.
<5>ReiserFS: sda2: found reiserfs format "3.6" with standard journal
<5>ReiserFS: sda2: using ordered data mode
<4>reiserfs: using flush barriers
<5>ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
<5>ReiserFS: sda2: checking transaction log (sda2)
<5>ReiserFS: sda2: replayed 28 transactions in 21 seconds
<4>reiserfs: disabling flush barriers on sda2
<5>ReiserFS: sda2: Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<5>Trying to move old root to /initrd ... failed
<5>Unmounting old root
<5>Trying to free ramdisk memory ... okay
<6>Freeing unused kernel memory: 252k freed
<6>Adding 1052216k swap on /dev/sda1.  Priority:42 extents:1
<5>ReiserFS: sda2: Removing [209 125728 0x0 SD]..done
<5>ReiserFS: sda2: Removing [209 125726 0x0 SD]..done
<5>ReiserFS: sda2: Removing [209 121365 0x0 SD]..done
<5>ReiserFS: sda2: There were 3 uncompleted unlinks/truncates. Completed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
<6>subfs 0.9
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.
Activating swap-devices in /etc/fstab...
doneChecking root file system...
fsck 1.34 (25-Jul-2003)
Reiserfs super block in block 16 on 0x802 of format 3.6 with standard journal
Blocks (total/free): 4194960/2841624 by 4096 bytes
Filesystem is NOT clean
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
done<notice>exit status of (boot.rootfsck) is (0)
<notice>run boot scripts (boot.md boot.device-mapper)
Activating device mapper...
Creating /dev/mapper/control character device with major:10 minor:63.
done
<notice>exit status of (boot.md boot.device-mapper) is (0 0)
<notice>run boot scripts (boot.localfs)
Checking file systems...
fsck 1.34 (25-Jul-2003)
doneSetting updone
Mounting local file systems...
proc on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hda on /media/cdrecorder type subfs 
(ro,nosuid,nodev,fs=cdfss,procuid,iocharset=utf8)

dmesg output with /dev/sda3 mounted at boottime:
<6>Adding 1052216k swap on /dev/sda1.  Priority:42 extents:1
<5>ReiserFS: sda2: Removing [209 121367 0x0 SD]..done
<5>ReiserFS: sda2: Removing [209 121358 0x0 SD]..done
<5>ReiserFS: sda2: Removing [209 121158 0x0 SD]..done
<5>ReiserFS: sda2: There were 3 uncompleted unlinks/truncates. Completed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
<5>ReiserFS: sda3: found reiserfs format "3.6" with standard journal
<5>ReiserFS: sda3: using ordered data mode
<4>reiserfs: using flush barriers
<4>ReiserFS: sda3: warning: sh-461: journal_init: wrong transaction max size 
(4294967295). Changed to 1024
<5>ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 2, max trans age 30
<5>ReiserFS: sda3: checking transaction log (sda3)
<5>ReiserFS: sda3: replayed 8 transactions in 1 seconds
<4>reiserfs: disabling flush barriers on sda3
<5>ReiserFS: sda3: Using r5 hash to sort names
<6>subfs 0.9

I can not find anymore info without risking a crash of /dev/sda2 too, and 
since the backup machine is lying around to be upgraded, I can not risk too 
much fault detection. 

Best regards,

Norbert van Nobelen
www.edusupport.nl (with a bit of luck, if the server stays alive)
-- 
<a href="http://www.edusupport.nl">EduSupport: Linux Desktop for schools and 
small to medium business in The Netherlands and Belgium</a>
