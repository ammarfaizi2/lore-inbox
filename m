Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSDJPeF>; Wed, 10 Apr 2002 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313239AbSDJPeE>; Wed, 10 Apr 2002 11:34:04 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7554 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313238AbSDJPeC>; Wed, 10 Apr 2002 11:34:02 -0400
Date: Wed, 10 Apr 2002 09:33:58 -0600
Message-Id: <200204101533.g3AFXwS09100@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: RAID superblock confusion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've found the following (vexing) problem with the way the
raid code handles superblocks/migrating devices. This was with
2.4.19-pre6. This machine has 7 SCSI controllers: 4 isp2x00 (qlogicfc)
and 3 sym53c8xxx. On 3 of the isp2x00 controllers, there are 2 drives
each. The second partition on each of these 6 drives forms part of the
RAID0 set. The sym53c8xx driver is built into the kernel, always (it
has the boot drive).

If the isp2x00 driver is built-in to the kernel, then host numbers
[0-3] are assigned to the isp2x00 controllers, and [4-6] to the
sym53c8xx controllers. The devices on the isp2x00 controllers are
detected first, which means they have lower minor numbers. This is
configuration used when the RAID set was configured many moons ago,
and continues to work.

If the isp2x00 driver is built as a module, and the scsihosts boot
parameter is passed to the kernel to reserve host numbers [0-3] for
the isp2x00 controllers, then the RAID code gets confused. Even though
the host numbers are the same, the device detection order is changed,
and thus the minor numbers are changed. Even though I'm using
persistent superblockss, which is supposed to allow one to move
devices from one controller to another, I can't use my RAID) set in
this configuration. Looks like a bug.

Below is some relevant information.

Kernel log for first (working) configuration:
===============================================================================
 [events: 0000004a]
 [events: 0000004a]
 [events: 0000004a]
 [events: 0000004a]
 [events: 0000004a]
 [events: 0000004a]
md: autorun ...
md: considering scsi/host2/bus0/target2/lun0/part2 ...
md:  adding scsi/host2/bus0/target2/lun0/part2 ...
md:  adding scsi/host2/bus0/target1/lun0/part2 ...
md:  adding scsi/host1/bus0/target2/lun0/part2 ...
md:  adding scsi/host1/bus0/target1/lun0/part2 ...
md:  adding scsi/host0/bus0/target2/lun0/part2 ...
md:  adding scsi/host0/bus0/target1/lun0/part2 ...
md: created md0
md: bind<scsi/host0/bus0/target1/lun0/part2,1>
md: bind<scsi/host0/bus0/target2/lun0/part2,2>
md: bind<scsi/host1/bus0/target1/lun0/part2,3>
md: bind<scsi/host1/bus0/target2/lun0/part2,4>
md: bind<scsi/host2/bus0/target1/lun0/part2,5>
md: bind<scsi/host2/bus0/target2/lun0/part2,6>
md: running: <scsi/host2/bus0/target2/lun0/part2><scsi/host2/bus0/target1/lun0/part2><scsi/host1/bus0/target2/lun0/part2><scsi/host1/bus0/target1/lun0/part2><scsi/host0/bus0/target2/lun0/part2><scsi/host0/bus0/target1/lun0/part2>
md: scsi/host2/bus0/target2/lun0/part2's event counter: 0000004a
md: scsi/host2/bus0/target1/lun0/part2's event counter: 0000004a
md: scsi/host1/bus0/target2/lun0/part2's event counter: 0000004a
md: scsi/host1/bus0/target1/lun0/part2's event counter: 0000004a
md: scsi/host0/bus0/target2/lun0/part2's event counter: 0000004a
md: scsi/host0/bus0/target1/lun0/part2's event counter: 0000004a
md0: max total readahead window set to 1536k
md0: 6 data-disks, max readahead per data-disk: 256k
raid0: looking at scsi/host0/bus0/target1/lun0/part2
raid0:   comparing scsi/host0/bus0/target1/lun0/part2(11767488) with scsi/host0/bus0/target1/lun0/part2(11767488)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at scsi/host0/bus0/target2/lun0/part2
raid0:   comparing scsi/host0/bus0/target2/lun0/part2(11767488) with scsi/host0/bus0/target1/lun0/part2(11767488)
raid0:   EQUAL
raid0: looking at scsi/host1/bus0/target1/lun0/part2
raid0:   comparing scsi/host1/bus0/target1/lun0/part2(11767488) with scsi/host0/bus0/target1/lun0/part2(11767488)
raid0:   EQUAL
raid0: looking at scsi/host1/bus0/target2/lun0/part2
raid0:   comparing scsi/host1/bus0/target2/lun0/part2(11767488) with scsi/host0/bus0/target1/lun0/part2(11767488)
raid0:   EQUAL
raid0: looking at scsi/host2/bus0/target1/lun0/part2
raid0:   comparing scsi/host2/bus0/target1/lun0/part2(11767488) with scsi/host0/bus0/target1/lun0/part2(11767488)
raid0:   EQUAL
raid0: looking at scsi/host2/bus0/target2/lun0/part2
raid0:   comparing scsi/host2/bus0/target2/lun0/part2(11767488) with scsi/host0/bus0/target1/lun0/part2(11767488)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking scsi/host0/bus0/target1/lun0/part2 ... contained as device 0
  (11767488) is smallest!.
raid0: checking scsi/host0/bus0/target2/lun0/part2 ... contained as device 1
raid0: checking scsi/host1/bus0/target1/lun0/part2 ... contained as device 2
raid0: checking scsi/host1/bus0/target2/lun0/part2 ... contained as device 3
raid0: checking scsi/host2/bus0/target1/lun0/part2 ... contained as device 4
raid0: checking scsi/host2/bus0/target2/lun0/part2 ... contained as device 5
raid0: zone->nb_dev: 6, size: 70604928
raid0: current zone offset: 11767488
raid0: done.
raid0 : md_size is 70604928 blocks.
raid0 : conf->smallest->size is 70604928 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: scsi/host2/bus0/target2/lun0/part2 [events: 0000004b]<6>(write) scsi/host2/bus0/target2/lun0/part2's sb offset: 11767488
md: scsi/host2/bus0/target1/lun0/part2 [events: 0000004b]<6>(write) scsi/host2/bus0/target1/lun0/part2's sb offset: 11767488
md: scsi/host1/bus0/target2/lun0/part2 [events: 0000004b]<6>(write) scsi/host1/bus0/target2/lun0/part2's sb offset: 11767488
md: scsi/host1/bus0/target1/lun0/part2 [events: 0000004b]<6>(write) scsi/host1/bus0/target1/lun0/part2's sb offset: 11767488
md: scsi/host0/bus0/target2/lun0/part2 [events: 0000004b]<6>(write) scsi/host0/bus0/target2/lun0/part2's sb offset: 11767488
md: scsi/host0/bus0/target1/lun0/part2 [events: 0000004b]<6>(write) scsi/host0/bus0/target1/lun0/part2's sb offset: 11767488
md: ... autorun DONE.
===============================================================================

Kernel log for second (failing) configuration:
===============================================================================
 [events: 0000004a]
md: can not import scsi/host6/bus0/target0/lun0/part2, has active inodes!
md: could not import scsi/host6/bus0/target0/lun0/part2, trying to run array nevertheless.
 [events: 0000004a]
 [events: 0000004a]
 [events: 0000004a]
 [events: 0000004a]
md: autorun ...
md: considering scsi/host2/bus0/target1/lun0/part2 ...
md:  adding scsi/host2/bus0/target1/lun0/part2 ...
md:  adding scsi/host1/bus0/target2/lun0/part2 ...
md:  adding scsi/host1/bus0/target1/lun0/part2 ...
md:  adding scsi/host0/bus0/target2/lun0/part2 ...
md:  adding scsi/host0/bus0/target1/lun0/part2 ...
md: created md0
md: bind<scsi/host0/bus0/target1/lun0/part2,1>
md: bind<scsi/host0/bus0/target2/lun0/part2,2>
md: bind<scsi/host1/bus0/target1/lun0/part2,3>
md: bind<scsi/host1/bus0/target2/lun0/part2,4>
md: bind<scsi/host2/bus0/target1/lun0/part2,5>
md: running: <scsi/host2/bus0/target1/lun0/part2><scsi/host1/bus0/target2/lun0/part2><scsi/host1/bus0/target1/lun0/part2><scsi/host0/bus0/target2/lun0/part2><scsi/host0/bus0/target1/lun0/part2>
md: scsi/host2/bus0/target1/lun0/part2's event counter: 0000004a
md: scsi/host1/bus0/target2/lun0/part2's event counter: 0000004a
md: scsi/host1/bus0/target1/lun0/part2's event counter: 0000004a
md: scsi/host0/bus0/target2/lun0/part2's event counter: 0000004a
md: scsi/host0/bus0/target1/lun0/part2's event counter: 0000004a
md: device name has changed from scsi/host1/bus0/target2/lun0/part2 to scsi/host2/bus0/target1/lun0/part2 since last import!
md: device name has changed from scsi/host1/bus0/target1/lun0/part2 to scsi/host1/bus0/target2/lun0/part2 since last import!
md: device name has changed from scsi/host0/bus0/target2/lun0/part2 to scsi/host1/bus0/target1/lun0/part2 since last import!
md: device name has changed from scsi/host0/bus0/target1/lun0/part2 to scsi/host0/bus0/target2/lun0/part2 since last import!
md: device name has changed from scsi/host6/bus0/target0/lun0/part2 to scsi/host0/bus0/target1/lun0/part2 since last import!
md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable, removing from array!
md0: max total readahead window set to 1536k
md0: 6 data-disks, max readahead per data-disk: 256k
md: md0, array needs 6 disks, has 5, aborting.
raid0: disks are not ordered, aborting!
md: pers->run() failed ...
md :do_md_run() returned -22
md: md0 stopped.
md: unbind<scsi/host2/bus0/target1/lun0/part2,4>
md: export_rdev(scsi/host2/bus0/target1/lun0/part2)
md: unbind<scsi/host1/bus0/target2/lun0/part2,3>
md: export_rdev(scsi/host1/bus0/target2/lun0/part2)
md: unbind<scsi/host1/bus0/target1/lun0/part2,2>
md: export_rdev(scsi/host1/bus0/target1/lun0/part2)
md: unbind<scsi/host0/bus0/target2/lun0/part2,1>
md: export_rdev(scsi/host0/bus0/target2/lun0/part2)
md: unbind<scsi/host0/bus0/target1/lun0/part2,0>
md: export_rdev(scsi/host0/bus0/target1/lun0/part2)
md: ... autorun DONE.
===============================================================================
Note the following line from the kernel logs above:
md: can not import scsi/host6/bus0/target0/lun0/part2, has active inodes!

Well, that's no surprise, as this partition has /usr! And this
partition isn't even mentioned in the /etc/raidtab file. But I note
that it has the same device number in this (the broken) configuration
as /dev/sd/c0b0t1u0p2 has in the working configuration.

The /etc/raidtab file:
===============================================================================
raiddev /dev/md/0
        raid-level             0
        nr-raid-disks          6
        persistent-superblock  1
        chunk-size             4
        device                 /dev/sd/c0b0t1u0p2
        raid-disk              0
        device                 /dev/sd/c0b0t2u0p2
        raid-disk              1
        device                 /dev/sd/c1b0t1u0p2
        raid-disk              2
        device                 /dev/sd/c1b0t2u0p2
        raid-disk              3
        device                 /dev/sd/c2b0t1u0p2
        raid-disk              4
        device                 /dev/sd/c2b0t2u0p2
        raid-disk              5
===============================================================================

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
