Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVD3OIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVD3OIN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVD3OIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:08:13 -0400
Received: from tim.rpsys.net ([194.106.48.114]:43156 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261226AbVD3OHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:07:51 -0400
Message-ID: <031d01c54d8d$fb82d4b0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20050429231653.32d2f091.akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm1
Date: Sat, 30 Apr 2005 15:07:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc3-mm1 fails to compile for an arm pxa sharp zaurus kernel:

  LD      .tmp_vmlinux1
fs/built-in.o(.text+0x39110): In function `smaps_pte_range':
task_mmc.c: undefined reference to `clean_pmd_entry'
make: *** [.tmp_vmlinux1] Error 1

Adding #include <asm/tlbflush.h> to fs/proc/task_mmu.c "fixes" this although
I doubt that's the correct thing to do.

The config I'm using is at http://www.rpsys.net/openzaurus/defconfig-c7x0
if needed.

I'm also seeing problems with CompactFlash cards (I also saw this with
2.6.12-rc2-mm3, other versions are untested). I'm using pcmcia-cs (not
pcmciautils) but that shouldn't be a problem as I understand things. The
card mounts fine as the machine boots and I can access it fine. Trying to
eject the card causes problems:

Normally I can execute "cardctl eject" and then remove the card. I trigger
the oops below however I try to eject the card under this kernel though.
(Note: I never physically remove it here although that will also trigger an
oops). I suspect this is a further problem with ide-cs (which nobody has
both the knowledge and time to fix) although I'm open to advice as to where
the fault lies:

root@c7x0:~# cardcmgr
cardmgr[1932]: watching 1 socket
root@c7x0:~# hda: Flash Card, CFA DISK drive
ide0 at 0xc2860000-0xc2860007,0xc286000e on irq 40
hda: max request size: 128KiB
hda: 254464 sectors (130 MB) w/0KiB Cache, CHS=994/8/32
hda: cache flushes not supported
 hda: hda1
ide-cs: hda: Vcc = 3.3, Vpp = 0.0
 hda: hda1

[drive gets automounted]

root@c7x0:~# umount /dev/hda1
root@c7x0:~# cardctl eject
Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c17ec000
[00000010] *pgd=a17a8031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0
PC is at ide_drive_remove+0x1c/0x28
LR is at ide_drive_remove+0x20/0x28
pc : [<c0153b18>]    lr : [<c0153b1c>]    Not tainted
sp : c1685cb8  ip : c1685cc8  fp : c1685cc4
r10: c03ee404  r9 : c029b6e8  r8 : 00000000
r7 : c029b8c0  r6 : c029b908  r5 : c0254ad0  r4 : c029b860
r3 : 00000000  r2 : c029b778  r1 : 00000003  r0 : c029b778
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A17EC000  DAC: 00000015
Process cardctl (pid: 2108, stack limit = 0xc1684194)
Stack: (0xc1685cb8 to 0xc1686000)
5ca0:                                                       c1685ce4
c1685cc8
5cc0: c012e4a4 c0153b08 c029b860 c029bc90 c029b8c0 c0254650 c1685d04
c1685ce8
5ce0: c012dd38 c012e3f4 c029b860 c029bc90 c029b8c0 00000000 c1685d20
c1685d08
[stack snipped]
Backtrace:
[<c0153afc>] (ide_drive_remove+0x0/0x28) from [<c012e4a4>]
(device_release_driver+0xbc/0xc4)
[<c012e3e8>] (device_release_driver+0x0/0xc4) from [<c012dd38>]
(bus_remove_device+0x5c/0xa8)
 r7 = C0254650  r6 = C029B8C0  r5 = C029BC90  r4 = C029B860
[<c012dcdc>] (bus_remove_device+0x0/0xa8) from [<c012ce30>]
(device_del+0x40/0x80)
 r7 = 00000000  r6 = C029B8C0  r5 = C029BC90  r4 = C029B860
[<c012cdf0>] (device_del+0x0/0x80) from [<c012ce84>]
(device_unregister+0x14/0x20)
 r6 = 00000000  r5 = C03DD3A0  r4 = C029B860
[<c012ce70>] (device_unregister+0x0/0x20) from [<c0151f04>]
(ide_unregister+0x6d0/0x8b0)
 r4 = C029B778
[<c0151834>] (ide_unregister+0x0/0x8b0) from [<c015f270>]
(ide_release+0x64/0x68)
[<c015f20c>] (ide_release+0x0/0x68) from [<c015f4f4>] (ide_event+0xd4/0x674)
 r5 = C1685E0C  r4 = C1C10200
[<c015f420>] (ide_event+0x0/0x674) from [<c016fd18>]
(send_event_callback+0x64/0x6c)
[<c016fcb4>] (send_event_callback+0x0/0x6c) from [<c012db38>]
(bus_for_each_dev+0x60/0x8c)
 r4 = 00000000
[<c012dad8>] (bus_for_each_dev+0x0/0x8c) from [<c016fd50>]
(send_event+0x30/0x40)
 r7 = 00000001  r6 = 00000001  r5 = 00000001  r4 = 00000008
[<c016fd20>] (send_event+0x0/0x40) from [<c0170128>] (ds_event+0xc0/0x210)
[<c0170068>] (ds_event+0x0/0x210) from [<c016aa64>] (send_event+0xd0/0x154)
[<c016a994>] (send_event+0x0/0x154) from [<c016ac8c>]
(socket_shutdown+0x18/0xfc)
 r7 = 00000000  r6 = 00000000  r5 = C03EE404  r4 = C03EE404
[<c016ac74>] (socket_shutdown+0x0/0xfc) from [<c016b424>]
(socket_remove+0x14/0xa0)
 r6 = 00000000  r5 = C03EE404  r4 = C03EE404
[<c016b410>] (socket_remove+0x0/0xa0) from [<c016bac4>]
(pcmcia_eject_card+0x94/0x98)
 r5 = C03EE404  r4 = C03EE530
[<c016ba30>] (pcmcia_eject_card+0x0/0x98) from [<c0172db0>]
(ds_ioctl+0xa30/0xc14)
 r6 = C03EE404  r5 = 0000640E  r4 = 00000000
[<c0172380>] (ds_ioctl+0x0/0xc14) from [<c0095fa0>] (do_ioctl+0x6c/0xa0)
[<c0095f34>] (do_ioctl+0x0/0xa0) from [<c0096068>] (vfs_ioctl+0x94/0x328)
 r7 = 00000000  r6 = 00000000  r5 = 00000003  r4 = C1BFFC80
[<c0095fd4>] (vfs_ioctl+0x0/0x328) from [<c009633c>] (sys_ioctl+0x40/0x64)
 r8 = C001CFA4  r7 = 00000036  r6 = 0000640E  r5 = FFFFFFF7
 r4 = C1BFFC80
[<c00962fc>] (sys_ioctl+0x0/0x64) from [<c001ce20>]
(ret_fast_syscall+0x0/0x2c)
 r6 = BECC8D90  r5 = 00000000  r4 = 00000000
Code: e24020e8 e1a00002 e592301c e1a0e00f (e593f010)

------------------------------------------------------

root@c7x0:~# cardmgr
cardmgr[1956]: watching 1 socket
root@c7x0:~# hda: Flash Card, CFA DISK drive
ide0 at 0xc2860000-0xc2860007,0xc286000e on irq 40
hda: max request size: 128KiB
hda: 254464 sectors (130 MB) w/0KiB Cache, CHS=994/8/32
hda: cache flushes not supported
 hda: hda1
ide-cs: hda: Vcc = 3.3, Vpp = 0.0
 hda: hda1

root@c7x0:~# cardctl eject

hda: status timeout: status=0x88 { Busy }

ide: failed opcode was: 0xec
hda: drive not ready for command
hda: status timeout: status=0x88 { Busy }

ide: failed opcode was: 0xec
hda: drive not ready for command
hda: status timeout: status=0x88 { Busy }

ide: failed opcode was: 0xec
hda: drive not ready for command

root@c7x0:~# cardctl insert
root@c7x0:~# Unable to handle kernel NULL pointer dereference at virtual
address 00000010
pgd = c1280000
[00000010] *pgd=a1250031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0
PC is at ide_drive_remove+0x1c/0x28
LR is at ide_drive_remove+0x20/0x28
pc : [<c0153b18>]    lr : [<c0153b1c>]    Not tainted
sp : c113fbb4  ip : c113fbc4  fp : c113fbc0
r10: 00000000  r9 : c029b6e8  r8 : c029b6e8
r7 : c029b8c0  r6 : c029b908  r5 : c0254ad0  r4 : c029b860
r3 : 00000000  r2 : c029b778  r1 : 00000003  r0 : c029b778
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A1280000  DAC: 00000015
Process cardmgr (pid: 1957, stack limit = 0xc113e194)
Stack: (0xc113fbb4 to 0xc1140000)
fba0:                                              c113fbe0 c113fbc4
c012e4a4
fbc0: c0153b08 c029b860 c029bc90 c029b8c0 c0254650 c113fc00 c113fbe4
c012dd38
fbe0: c012e3f4 c029b860 c029bc90 c029b8c0 00000000 c113fc1c c113fc04
c012ce30
[stack snipped]
Backtrace:
[<c0153afc>] (ide_drive_remove+0x0/0x28) from [<c012e4a4>]
(device_release_driver+0xbc/0xc4)
[<c012e3e8>] (device_release_driver+0x0/0xc4) from [<c012dd38>]
(bus_remove_device+0x5c/0xa8)
 r7 = C0254650  r6 = C029B8C0  r5 = C029BC90  r4 = C029B860
[<c012dcdc>] (bus_remove_device+0x0/0xa8) from [<c012ce30>]
(device_del+0x40/0x80)
 r7 = 00000000  r6 = C029B8C0  r5 = C029BC90  r4 = C029B860
[<c012cdf0>] (device_del+0x0/0x80) from [<c012ce84>]
(device_unregister+0x14/0x20)
 r6 = 00000000  r5 = C03DB0A0  r4 = C029B860
[<c012ce70>] (device_unregister+0x0/0x20) from [<c0151f04>]
(ide_unregister+0x6d0/0x8b0)
 r4 = C029B778
[<c0151834>] (ide_unregister+0x0/0x8b0) from [<c0152310>]
(ide_register_hw_with_fixup+0x1b8/0x1ec)
[<c0152158>] (ide_register_hw_with_fixup+0x0/0x1ec) from [<c015f200>]
(idecs_register+0xa4/0xb0)
[<c015f15c>] (idecs_register+0x0/0xb0) from [<c015f8c4>]
(ide_event+0x4a4/0x674)
 r7 = C286000E  r6 = C1C00460  r5 = C1F72A14  r4 = 00000000
[<c015f420>] (ide_event+0x0/0x674) from [<c016ffc0>]
(pcmcia_register_client+0x260/0x308)
[<c016fd60>] (pcmcia_register_client+0x0/0x308) from [<c015f3dc>]
(ide_attach+0xb8/0xfc)
[<c015f324>] (ide_attach+0x0/0xfc) from [<c016edb0>]
(pcmcia_device_probe+0xc0/0x18c)
 r6 = C1F72A60  r5 = C0254BF0  r4 = C1F72A00
[<c016ecf0>] (pcmcia_device_probe+0x0/0x18c) from [<c012e230>]
(driver_probe_device+0x4c/0xb0)
 r8 = 00000050  r7 = C012E294  r6 = 00000000  r5 = C0254C00
 r4 = C1F72A60
[<c012e1e4>] (driver_probe_device+0x0/0xb0) from [<c012dbc4>]
(bus_for_each_drv+0x60/0x8c)
 r6 = C1F72A60  r5 = C113FE60  r4 = 00000000
[<c012db64>] (bus_for_each_drv+0x0/0x8c) from [<c012e334>]
(device_attach+0x8c/0x98)
 r7 = C012DF2C  r6 = C113FEE4  r5 = C1F72B08  r4 = C1F72A60
[<c012e2a8>] (device_attach+0x0/0x98) from [<c012df54>]
(bus_rescan_devices_helper+0x28/0x40)
 r5 = C113FEB8  r4 = C113FEE4
[<c012df2c>] (bus_rescan_devices_helper+0x0/0x40) from [<c012db38>]
(bus_for_each_dev+0x60/0x8c)
 r4 = 00000000
[<c012dad8>] (bus_for_each_dev+0x0/0x8c) from [<c012df90>]
(bus_rescan_devices+0x24/0x30)
 r7 = 0001C070  r6 = C1F72A00  r5 = C050643C  r4 = C03EC530
[<c012df6c>] (bus_rescan_devices+0x0/0x30) from [<c0172c84>]
(ds_ioctl+0x904/0xc14)
[<c0172380>] (ds_ioctl+0x0/0xc14) from [<c0095fa0>] (do_ioctl+0x6c/0xa0)
[<c0095f34>] (do_ioctl+0x0/0xa0) from [<c0096068>] (vfs_ioctl+0x94/0x328)
 r7 = 00000000  r6 = 0001C070  r5 = 00000004  r4 = C1312800
[<c0095fd4>] (vfs_ioctl+0x0/0x328) from [<c009633c>] (sys_ioctl+0x40/0x64)
 r8 = C001CFA4  r7 = 00000036  r6 = C050643C  r5 = FFFFFFF7
 r4 = C1312800
[<c00962fc>] (sys_ioctl+0x0/0x64) from [<c001ce20>]
(ret_fast_syscall+0x0/0x2c)
 r6 = 00034738  r5 = 00000001  r4 = 00000001
Code: e24020e8 e1a00002 e592301c e1a0e00f (e593f010)

Regards,

Richard

