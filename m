Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131421AbRBMQOx>; Tue, 13 Feb 2001 11:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130665AbRBMQOo>; Tue, 13 Feb 2001 11:14:44 -0500
Received: from a1as02-p233.fra.tli.de ([195.252.197.233]:55567 "EHLO
	sharon.GDImbH.com") by vger.kernel.org with ESMTP
	id <S129918AbRBMQOb>; Tue, 13 Feb 2001 11:14:31 -0500
Message-Id: <200102131612.RAA26210@marvin.GDImbH.Com>
Date: Tue, 13 Feb 2001 17:12:46 +0100 (MET)
From: Ralf Oehler <ro@GDImbH.com>
Reply-To: Ralf Oehler <ro@GDImbH.com>
Subject: Kernel panic: Ththththaats all folks
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: sFnbjllhrjGdi17ktpGigQ==
X-Mailer: dtmail 1.2.1 CDE Version 1.2.1 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mailing-list,

Currently I'm working on a device-virtualizing robotic driver for HP jukeboxes
(magneto-optical media) an a WORM filesystem for linux.

Both work really nice now, but it seems there are some weak spots in the SCSI
subsystem which I cannot work around.
The worst situation I encounter sometimes (reproducible within about 48 hours)
always ends up in a kernel panic with the following call chain.

My system:
Pentium-II, 350 MHz, 64MB
Adaptec AHA-2940A (-> aic7xxx.o)
kernel: 2.4.0
patch:  SGI-debugger (kdb-v1.7-2.4.0)

Some more details:
My jukebox consists of a picker device (sg.o) and some MO-drives (sd_mod.o)
The sg.o attaches to all these devices, while sd attaches to the drives only.
My jukebox driver registers as scsi-disk-device, moves a medium to a free drive
(via sg), opens sd for the drive and further maps 
( see ll_rw_blk.c: generic_make_request() ) the requests to sd.
For testing I run more copy-processes to mounted virtual jukebox-disks
than there are physical drives. So the picker-thread alternatingly moves the 
involved media between their storage-slots the drives while the copy-processes 
do stop-and-go.
It works well, just until SCSI timeouts occur...

The kernel-panic occurs, independently of the presence of tagged queuing, some time
(seconds or minutes) after the occurence of disconnected timeouts for the 
SCSI-READ/WRITE commands to the MO-drives (by sd_mod.o).
I see some messages about bus-resets in the syslog, then the kernel stops.

Can anybody help ...?



----------------------------------------------------------
Master Resource Control: runlevel 3 has been                           reached
....and some hours later....
Kernel panic: Ththththaats all folks.  Too dangerous to continue.
In interrupt handler - not syncing
SysRq: Emergency Sync

Entering kdb (current=0xc3884000, pid 177) Panic: invalid operand
due to panic @ 0xc0110064
eax = 0x0000001b ebx = 0xc3885bbc ecx = 0xc0292c48 edx = 0x00000001 
esi = 0xc11fb264 edi = 0xc3884000 esp = 0xc3885b78 eip = 0xc0110064 
ebp = 0xc3885ba8 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010202 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc3885b44
kdb> bt
    EBP       EIP         Function(args)
0xc3885ba8 0xc0110064 schedule+0x388
                               kernel .text 0xc0100000 0xc010fcdc 0xc0110070
           0xc012e33a __wait_on_buffer+0x6a (0xc11fb264)
                               kernel .text 0xc0100000 0xc012e2d0 0xc012e360
0xc3885bf0 0xc012e3e3 sync_buffers+0x83 (0x302, 0x1)
                               kernel .text 0xc0100000 0xc012e360 0xc012e500
0xc3885c04 0xc012e552 fsync_dev+0x2a (0x302)
                               kernel .text 0xc0100000 0xc012e528 0xc012e55c
0xc3885c1c 0xc0195f7a go_sync+0x112 (0xc11f8a00, 0x0)
                               kernel .text 0xc0100000 0xc0195e68 0xc0195f90
0xc3885c34 0xc0195fd8 do_emergency_sync+0x48
                               kernel .text 0xc0100000 0xc0195f90 0xc0196040
0xc3885c40 0xc0111ffe panic+0xde (0xc491b4a0)
                               kernel .text 0xc0100000 0xc0111f20 0xc0112000
0xc3885c58 0xc490f939 [scsi_mod]dump_stats+0x79 (0xc2d59aac, 0x1, 0x0, 0x20, 0xc491b600)
                               scsi_mod .text 0xc4908060 0xc490f8c0 0xc490f93c
0xc3885c8c 0xc4910e9e [scsi_mod]scsi_init_io_vc+0x12a (0xc2d59a00)
                               scsi_mod .text 0xc4908060 0xc4910d74 0xc4910ec8
0xc3885cb8 0xc490f78c [scsi_mod]scsi_request_fn+0x238 (0xc3a0e49c)
                               scsi_mod .text 0xc4908060 0xc490f554 0xc490f864
0xc3885cd4 0xc490eebb [scsi_mod]scsi_queue_next_request+0x3f (0xc3a0e49c, 0xc2d59a00)
more> 
                               scsi_mod .text 0xc4908060 0xc490ee7c 0xc490ef84
0xc3885cf0 0xc490f063 [scsi_mod]__scsi_end_request+0xdf (0xc2d59a00, 0x0, 0x0, 0x1, 0x1)
                               scsi_mod .text 0xc4908060 0xc490ef84 0xc490f0ac
0xc3885d0c 0xc490f0c4 [scsi_mod]scsi_end_request_Rac26c809+0x18 (0xc2d59a00, 0x0, 0x2)
                               scsi_mod .text 0xc4908060 0xc490f0ac 0xc490f0c8
0xc3885d3c 0xc490f504 [scsi_mod]scsi_io_completion_R2f9973d3+0x38c (0xc2d59a00, 0x0, 0x1)
                               scsi_mod .text 0xc4908060 0xc490f178 0xc490f510
0xc3885d6c 0xc4964d0a [sd_mod]rw_intr+0x1ee (0xc2d59a00)
                               sd_mod .text 0xc4964060 0xc4964b1c 0xc4964d14
0xc3885d98 0xc490e636 [scsi_mod]scsi_old_done+0x596 (0xc2d59a00)
                               scsi_mod .text 0xc4908060 0xc490e0a0 0xc490e644
0xc3885da8 0xc49423d0 [aic7xxx]aic7xxx_done_cmds_complete+0x2c (0xc3a48078)
                               aic7xxx .text 0xc4940060 0xc49423a4 0xc49423e0
0xc3885dc0 0xc494ca56 [aic7xxx]do_aic7xxx_isr+0x72 (0xb, 0xc3a48078, 0xc3885e0c)
                               aic7xxx .text 0xc4940060 0xc494c9e4 0xc494ca70
0xc3885de0 0xc010a2e6 handle_IRQ_event+0x2e (0xb, 0xc3885e0c, 0xc390db04)
                               kernel .text 0xc0100000 0xc010a2b8 0xc010a314
0xc3885e04 0xc010a456 do_IRQ+0x6a (0x32, 0xc383c978, 0xc383c000, 0xc383c000, 0x32)
                               kernel .text 0xc0100000 0xc010a3ec 0xc010a498
           0xc0108e64 ret_from_intr
                               kernel .text 0xc0100000 0xc0108e64 0xc0108e84
Interrupt registers:
eax = 0x00001000 ebx = 0x00000032 ecx = 0xc383c978 edx = 0xc383c000 
more> 
esi = 0xc383c000 edi = 0x00000032 esp = 0xc3885e40 eip = 0xc018ea12 
ebp = 0xc3885e40 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000246 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffff0b &regs = 0xc3885e0c
           0xc018ea12 con_write_room+0x1a (0xc383c000)
                               kernel .text 0xc0100000 0xc018e9f8 0xc018ea18
0xc3885ea8 0xc01819f1 opost_block+0x15 (0xc383c000, 0x8052638, 0x32, 0x32, 0xc383c000)
                               kernel .text 0xc0100000 0xc01819dc 0xc0181b54
0xc3885ef8 0xc018391c write_chan+0x158 (0xc383c000, 0xc38ce404, 0x8052638, 0x32)
                               kernel .text 0xc0100000 0xc01837c4 0xc01839ac
           0xc017f7ea tty_write+0x14a (0xc38ce404, 0x8052638, 0x32, 0xc38ce424)
                               kernel .text 0xc0100000 0xc017f6a0 0xc017f858
0xc3885f9c 0xc012d915 do_readv_writev+0x1a1 (0x0, 0xc38ce404, 0xbfffef64, 0x1)
                               kernel .text 0xc0100000 0xc012d774 0xc012d984
0xc3885fbc 0xc012da1d sys_writev+0x41 (0x1, 0xbfffef64, 0x6, 0x6, 0x1)
                               kernel .text 0xc0100000 0xc012d9dc 0xc012da34
           0xc0108dbb system_call+0x33
                               kernel .text 0xc0100000 0xc0108d88 0xc0108dc0
kdb> 



Regards,

   Ralf Oehler


*********************************************************************
*                                                                   *
*    Ralf Oehler                      GDI                           *
*                                                                   *
*    E-Mail: R.Oehler@GDImbH.com      Gesellschaft fuer Digitale    *
*    Tel.:   +49 6182-9271-23            Informationstechnik mbH    *
*    Fax.:   +49 6182-25035           Bensbruchstrasse 11           *
*                                     63533 Mainhausen              *
*                                                                   *
*********************************************************************

