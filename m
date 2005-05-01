Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVEASEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVEASEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 14:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVEASET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 14:04:19 -0400
Received: from tim.rpsys.net ([194.106.48.114]:45739 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262634AbVEASCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 14:02:50 -0400
Message-ID: <03be01c54e77$83d86980$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <bzolnier@gmail.com>
Cc: "Dominik Brodowski" <linux@brodo.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ide@vger.kernel.org>
Subject: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Date: Sun, 1 May 2005 18:59:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've switched back to 2.6.12-rc3-mm1 and added some debuging to all the ide 
functions to trace the order functions are getting called. I've shown the 
result below for two different oops. There is more than one problem. The 
first problem was introduced in 2.6.12-rc1-bk1 in the ide-disk changes. The 
second has been around for a while but is showing up again.

The problem is idedisk_cleanup() gets called twice from ide_unregister(). 
Once here:

 for (unit = 0; unit < MAX_DRIVES; ++unit) {
  drive = &hwif->drives[unit];
  if (!drive->present)
   continue;
  DRIVER(drive)->cleanup(drive);
 }

and secondly in ide_unregister indirectly via:

  blk_cleanup_queue(drive->queue);
  printk(KERN_ERR "ide_unregister4()\n");
  device_unregister(&drive->gendev);
  down(&drive->gendev_rel_sem);
  spin_lock_irq(&ide_lock);
  drive->queue = NULL;
  printk(KERN_ERR "ide_unregister5()\n");

device_unregister()  triggers ide_drive_remove() which calls 
DRIVER(drive)->cleanup(drive);

In the first call to idedisk_cleanup(), ide_disk_put(idkp) is called which 
decreases the reference counter to zero. This triggers ide_disk_release() 
which calls kfree(idkp). Hence the second call to idedisk_cleanup() calls 
what is now a null pointer (or worse).

The solution is that ide_drive_remove() should no longer be calling 
DRIVER(drive)->cleanup(drive) as the refcounting now takes care of 
everything (although I'm presuming refcounting has been added to all drive 
types). I removed the above call and it cures both this oops and the one 
below.

The second oops is for similar reasons but "cardctl eject" doesn't succeed 
highlighting a second issue. ide_unregister() is called but aborts leaving 
ide-cs thinking the call succeeded when it didn't. This leads to the io 
timeouts.

Solution: ide_unregister() should return failure and pass responsibility for 
handling it to ide-cs or it should always succeed. I'd favour the latter as 
the ide layer should really handle its own cleanup. Maybe a parameter should 
be added to ide_unregister() to select the behaviour if the drive is busy/in 
use? If the hardware is gone, we want it to happen regardless for example...

------------------- Opps #1 -------------------

root@c7x0:~# cardmgr
cardmgr[1900]: cannot access /lib/modules/2.6.12-rc3-mm1: No such file or 
directory
cardmgr[1900]: watching 1 socket
root@c7x0:~# ide_uregister_hw_with_fixup()
init_hwif_data()
init_hwif_default()
ide_hwif_request_regions()
hwif_request_region()
hwif_request_region()
hda: KODAK LM, CFA DISK drive
ide0 at 0xc2860000-0xc2860007,0xc286000e on irq 40
ide_add_generic_settings()
ide_add_generic_settings()
ata_attach()
idedisk_attach()
ide_register_subdriver()
idedisk_setup()
hda: max request size: 128KiB
init_idedisk_capacity()
lba_capacity_is_ok()
hda: 128512 sectors (65 MB) w/1KiB Cache, CHS=1004/4/32
hda: cache flushes not supported
ide_disk_open()
ide_disk_get()
idedisk_media_changed()
idedisk_revalidate_disk()
 hda:<3>ide_do_rw_disk()
 hda1
idedisk_release()
ide_cacheflush_p()
ide_disk_put()
ide-cs: hda: Vcc = 3.3, Vpp = 0.0
ide_disk_open()
ide_disk_get()
idedisk_media_changed()
idedisk_revalidate_disk()
idedisk_revalidate_disk()
 hda:<3>ide_do_rw_disk()
 hda1
root@c7x0:~# umount /dev/hda1
idedisk_release()
ide_cacheflush_p()
ide_disk_put()
root@c7x0:~# cardctl eject
ide_unregister()
ide_unregister1()
idedisk_cleanup()
ide_cacheflush_p()
ide_unregister_subdriver()
auto_remove_settings()
ide_disk_put()
ide_disk_release()
ide_unregister2()
ide_unregister3()
ide_hwif_release_regions()
ide_unregister4()
ide_drive_remove()
Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c10bc000
[00000010] *pgd=a119c031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0
PC is at ide_drive_remove+0x28/0x38
LR is at ide_drive_remove+0x2c/0x38
pc : [<c0152190>]    lr : [<c0152194>]    Not tainted
sp : c15efcb4  ip : c15efbfc  fp : c15efcc4
r10: c03cb804  r9 : c0283088  r8 : 00000000
r7 : c0283260  r6 : c02832a8  r5 : c023ea10  r4 : c0283118
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c0283118
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A10BC000  DAC: 00000015
Process cardctl (pid: 2052, stack limit = 0xc15ee194)
Stack: (0xc15efcb4 to 0xc15f0000)
fca0:                                              c0283200 c15efce4 
c15efcc8
fcc0: c012de44 c0152174 c0283200 c0283630 c0283260 c023e590 c15efd04 
c15efce8
fce0: c012d6d8 c012dd94 c0283200 c0283630 c0283260 00000000 c15efd20 
c15efd08
 [stack snipped]
Backtrace:
[<c0152168>] (ide_drive_remove+0x0/0x38) from [<c012de44>] 
(device_release_driver+0xbc/0xc4)
 r4 = C0283200
[<c012dd88>] (device_release_driver+0x0/0xc4) from [<c012d6d8>] 
(bus_remove_device+0x5c/0xa8)
 r7 = C023E590  r6 = C0283260  r5 = C0283630  r4 = C0283200
[<c012d67c>] (bus_remove_device+0x0/0xa8) from [<c012c7d0>] 
(device_del+0x40/0x80)
 r7 = 00000000  r6 = C0283260  r5 = C0283630  r4 = C0283200
[<c012c790>] (device_del+0x0/0x80) from [<c012c824>] 
(device_unregister+0x14/0x20)
 r6 = 00000000  r5 = C03CA0A0  r4 = C0283200
[<c012c810>] (device_unregister+0x0/0x20) from [<c01503d4>] 
(ide_unregister+0x714/0x960)
 r4 = C0283118
[<c014fcc0>] (ide_unregister+0x0/0x960) from [<c015da24>] 
(ide_release+0x64/0x68)
[<c015d9c0>] (ide_release+0x0/0x68) from [<c015dca8>] (ide_event+0xd4/0x674)
 r5 = C15EFE0C  r4 = C03E8200
[<c015dbd4>] (ide_event+0x0/0x674) from [<c016e4cc>] 
(send_event_callback+0x64/0x6c)
[<c016e468>] (send_event_callback+0x0/0x6c) from [<c012d4d8>] 
(bus_for_each_dev+0x60/0x8c)
 r4 = 00000000
[<c012d478>] (bus_for_each_dev+0x0/0x8c) from [<c016e504>] 
(send_event+0x30/0x40)
 r7 = 00000001  r6 = 00000001  r5 = 00000001  r4 = 00000008
[<c016e4d4>] (send_event+0x0/0x40) from [<c016e8dc>] (ds_event+0xc0/0x210)
[<c016e81c>] (ds_event+0x0/0x210) from [<c0169218>] (send_event+0xd0/0x154)
[<c0169148>] (send_event+0x0/0x154) from [<c0169440>] 
(socket_shutdown+0x18/0xfc)
 r7 = 00000000  r6 = 00000000  r5 = C03CB804  r4 = C03CB804
[<c0169428>] (socket_shutdown+0x0/0xfc) from [<c0169bd8>] 
(socket_remove+0x14/0xa0)
 r6 = 00000000  r5 = C03CB804  r4 = C03CB804
[<c0169bc4>] (socket_remove+0x0/0xa0) from [<c016a278>] 
(pcmcia_eject_card+0x94/0x98)
 r5 = C03CB804  r4 = C03CB930
[<c016a1e4>] (pcmcia_eject_card+0x0/0x98) from [<c0171564>] 
(ds_ioctl+0xa30/0xc14)
 r6 = C03CB804  r5 = 0000640E  r4 = 00000000
[<c0170b34>] (ds_ioctl+0x0/0xc14) from [<c0095e30>] (do_ioctl+0x6c/0xa0)
[<c0095dc4>] (do_ioctl+0x0/0xa0) from [<c0095ef8>] (vfs_ioctl+0x94/0x328)
 r7 = 00000000  r6 = 00000000  r5 = 00000003  r4 = C18FC180
[<c0095e64>] (vfs_ioctl+0x0/0x328) from [<c00961cc>] (sys_ioctl+0x40/0x64)
 r8 = C001CFA4  r7 = 00000036  r6 = 0000640E  r5 = FFFFFFF7
 r4 = C18FC180
[<c009618c>] (sys_ioctl+0x0/0x64) from [<c001ce20>] 
(ret_fast_syscall+0x0/0x2c)
 r6 = BEEE5D90  r5 = 00000000  r4 = 00000000
Code: ebfb9b8b e1a00004 e594301c e1a0e00f (e593f010)
 Segmentation fault

------------------- Opps #2 -------------------

root@c7x0:~# cardmgr
cardmgr[1804]: watching 1 socket
root@c7x0:~# ide_uregister_hw_with_fixup()
init_hwif_data()
init_hwif_default()
ide_hwif_request_regions()
hwif_request_region()
hwif_request_region()
hda: KODAK LM, CFA DISK drive
ide0 at 0xc2860000-0xc2860007,0xc286000e on irq 40
ide_add_generic_settings()
ata_attach()
idedisk_attach()
ide_register_subdriver()
idedisk_setup()
hda: max request size: 128KiB
init_idedisk_capacity()
lba_capacity_is_ok()
hda: 128512 sectors (65 MB) w/1KiB Cache, CHS=1004/4/32
hda: cache flushes not supported
ide_disk_open()
ide_disk_get()
idedisk_media_changed()
idedisk_revalidate_disk()
 hda: hda1
idedisk_release()
ide_cacheflush_p()
ide_disk_put()
ide-cs: hda: Vcc = 3.3, Vpp = 0.0
ide_disk_open()
ide_disk_get()
idedisk_media_changed()
idedisk_revalidate_disk()
idedisk_revalidate_disk()
 hda: hda1

root@c7x0:~#
root@c7x0:~# cardctl eject
ide_unregister()
ide_unregister() abort
root@c7x0:~# hda: status timeout: status=0x88 { Busy }

ide: failed opcode was: 0xec
hda: drive not ready for command
hda: status timeout: status=0x88 { Busy }

ide: failed opcode was: 0xec
hda: drive not ready for command

root@c7x0:~# carhda: status timeout: status=0x88 { Busy }

ide: failed opcode was: 0xec
hda: drive not ready for command
didedisk_release()
ide_cacheflush_p()
ide_disk_put()
ctl eject
root@c7x0:~# root@c7x0:~# cardctl insert
root@c7x0:~# ide_uregister_hw_with_fixup()
ide_unregister()
ide_unregister1()
idedisk_cleanup()
ide_cacheflush_p()
ide_unregister_subdriver()
auto_remove_settings()
ide_disk_put()
ide_disk_release()
ide_unregister2()
ide_unregister3()
ide_hwif_release_regions()
ide_unregister4()
ide_drive_remove()
Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c17c8000
[00000010] *pgd=a1614031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0
PC is at ide_drive_remove+0x28/0x38
LR is at ide_drive_remove+0x2c/0x38
pc : [<c0152190>]    lr : [<c0152194>]    Not tainted
sp : c125bbb0  ip : c125baf8  fp : c125bbc0
r10: 00000000  r9 : c0283088  r8 : c0283088
r7 : c0283260  r6 : c02832a8  r5 : c023ea10  r4 : c0283118
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c0283118
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A17C8000  DAC: 00000015
Process cardmgr (pid: 1805, stack limit = 0xc125a194)
Stack: (0xc125bbb0 to 0xc125c000)
bba0:                                     c0283200 c125bbe0 c125bbc4 
c012de44
bbc0: c0152174 c0283200 c0283630 c0283260 c023e590 c125bc00 c125bbe4 
c012d6d8
bbe0: c012dd94 c0283200 c0283630 c0283260 00000000 c125bc1c c125bc04 
c012c7d0
 [stack snipped]
Backtrace:
[<c0152168>] (ide_drive_remove+0x0/0x38) from [<c012de44>] 
(device_release_driver+0xbc/0xc4)
 r4 = C0283200
[<c012dd88>] (device_release_driver+0x0/0xc4) from [<c012d6d8>] 
(bus_remove_device+0x5c/0xa8)
 r7 = C023E590  r6 = C0283260  r5 = C0283630  r4 = C0283200
[<c012d67c>] (bus_remove_device+0x0/0xa8) from [<c012c7d0>] 
(device_del+0x40/0x80)
 r7 = 00000000  r6 = C0283260  r5 = C0283630  r4 = C0283200
[<c012c790>] (device_del+0x0/0x80) from [<c012c824>] 
(device_unregister+0x14/0x20)
 r6 = 00000000  r5 = C03CC0A0  r4 = C0283200
[<c012c810>] (device_unregister+0x0/0x20) from [<c01503d4>] 
(ide_unregister+0x714/0x960)
 r4 = C0283118
[<c014fcc0>] (ide_unregister+0x0/0x960) from [<c015086c>] 
(ide_register_hw_with_fixup+0x1c0/0x1f8)
[<c01506ac>] (ide_register_hw_with_fixup+0x0/0x1f8) from [<c015d9b4>] 
(idecs_register+0xa4/0xb0)
[<c015d910>] (idecs_register+0x0/0xb0) from [<c015e078>] 
(ide_event+0x4a4/0x674)
 r7 = C286000E  r6 = C03E6460  r5 = C03E8214  r4 = 00000000
[<c015dbd4>] (ide_event+0x0/0x674) from [<c016e774>] 
(pcmcia_register_client+0x260/0x308)
[<c016e514>] (pcmcia_register_client+0x0/0x308) from [<c015db90>] 
(ide_attach+0xb8/0xfc)
[<c015dad8>] (ide_attach+0x0/0xfc) from [<c016d564>] 
(pcmcia_device_probe+0xc0/0x18c)
 r6 = C03E8260  r5 = C023EB30  r4 = C03E8200
[<c016d4a4>] (pcmcia_device_probe+0x0/0x18c) from [<c012dbd0>] 
(driver_probe_device+0x4c/0xb0)
 r8 = 00000050  r7 = C012DC34  r6 = 00000000  r5 = C023EB40
 r4 = C03E8260
[<c012db84>] (driver_probe_device+0x0/0xb0) from [<c012d564>] 
(bus_for_each_drv+0x60/0x8c)
 r6 = C03E8260  r5 = C125BE60  r4 = 00000000
[<c012d504>] (bus_for_each_drv+0x0/0x8c) from [<c012dcd4>] 
(device_attach+0x8c/0x98)
 r7 = C012D8CC  r6 = C125BEE4  r5 = C03E8308  r4 = C03E8260
[<c012dc48>] (device_attach+0x0/0x98) from [<c012d8f4>] 
(bus_rescan_devices_helper+0x28/0x40)
 r5 = C125BEB8  r4 = C125BEE4
[<c012d8cc>] (bus_rescan_devices_helper+0x0/0x40) from [<c012d4d8>] 
(bus_for_each_dev+0x60/0x8c)
 r4 = 00000000
[<c012d478>] (bus_for_each_dev+0x0/0x8c) from [<c012d930>] 
(bus_rescan_devices+0x24/0x30)
 r7 = 00039300  r6 = C03E8200  r5 = C050643C  r4 = C03CD930
[<c012d90c>] (bus_rescan_devices+0x0/0x30) from [<c0171438>] 
(ds_ioctl+0x904/0xc14)
[<c0170b34>] (ds_ioctl+0x0/0xc14) from [<c0095e30>] (do_ioctl+0x6c/0xa0)
[<c0095dc4>] (do_ioctl+0x0/0xa0) from [<c0095ef8>] (vfs_ioctl+0x94/0x328)
 r7 = 00000000  r6 = 00039300  r5 = 00000004  r4 = C1441AC0
[<c0095e64>] (vfs_ioctl+0x0/0x328) from [<c00961cc>] (sys_ioctl+0x40/0x64)
 r8 = C001CFA4  r7 = 00000036  r6 = C050643C  r5 = FFFFFFF7
 r4 = C1441AC0
[<c009618c>] (sys_ioctl+0x0/0x64) from [<c001ce20>] 
(ret_fast_syscall+0x0/0x2c)
 r6 = 00034738  r5 = 00000001  r4 = 00000001
Code: ebfb9b8b e1a00004 e594301c e1a0e00f (e593f010)

