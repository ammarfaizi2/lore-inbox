Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287205AbSACNw3>; Thu, 3 Jan 2002 08:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286334AbSACNwU>; Thu, 3 Jan 2002 08:52:20 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:60820 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287200AbSACNwO>; Thu, 3 Jan 2002 08:52:14 -0500
Message-ID: <XFMail.20020103143902.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 03 Jan 2002 14:39:02 +0100 (MET)
From: R.Oehler@GDImbH.com
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ksymoops was not possible, because after rebooting the 
memory/module-layout had changed. (Or is there a trick
I don't know?) To get a useable stack chain I patched 
the kernel with SGI's kadb and reproduced the crash.

I'm using the aic7xxx controller. (With both, the old and 
the new one I can reproduce the crash).

Alan Cox reports that the -ac kernels behave. This
makes me believe that the BUG sneaked into the linus
kernel at 2.4.10, where heavy block layer changes
happened, which were not applied to alan's kernel.
linus-2.4.0 behaves, too.



Here is
1) register dump
2) stack chain
3) last few lines dumped from syslog buffer


Is there anything more I can do?

Regards,
        Ralf





Welcome to SuSE Linux 7.3 (i386) - Kernel 2.4.17-Dbg (ttyS0).

tick login: 
Entering kdb (current=0xc0290000, pid 0) Oops: invalid operand
due to oops @ 0xd0853729
eax = 0x00000046 ebx = 0xce550070 ecx = 0xc027de00 edx = 0x0000276d 
esi = 0xc009e018 edi = 0x00000018 esp = 0xc0291d94 eip = 0xd0853729 
ebp = 0xc0291dd8 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010002 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc0291d60


kdb> bt
    EBP       EIP         Function(args)
0xc0291dd8 0xd0853729 [aic7xxx]ahc_linux_run_device_queue+0x39d (0xcfb6be00, 0xce62ed1c)
                               aic7xxx .text 0xd0852060 0xd085338c 0xd0853c90
0xc0291dfc 0xd0853356 [aic7xxx]ahc_linux_queue+0x172 (0xce5f6a00, 0xd0834de0)
                               aic7xxx .text 0xd0852060 0xd08531e4 0xd085338c
0xc0291e20 0xd0834674 [scsi_mod]scsi_dispatch_cmd+0x1a4 (0xce5f6a00, 0xce5f6a00)
                               scsi_mod .text 0xd0834060 0xd08344d0 0xd083481c
0xc0291e50 0xd083bc7d [scsi_mod]scsi_request_fn+0x2bd (0xcf9f77b4)
                               scsi_mod .text 0xd0834060 0xd083b9c0 0xd083bcb4
0xc0291e6c 0xd083b2d6 [scsi_mod]scsi_queue_next_request+0x46 (0xcf9f77b4, 0xce5f6a00)
                               scsi_mod .text 0xd0834060 0xd083b290 0xd083b39c
0xc0291e88 0xd083b489 [scsi_mod]__scsi_end_request+0xed (0xce5f6a00, 0x0, 0x0, 0x1, 0x1)
                               scsi_mod .text 0xd0834060 0xd083b39c 0xd083b4d4
0xc0291ea4 0xd083b4ec [scsi_mod]scsi_end_request+0x18 (0xce5f6a00, 0x0, 0x2)
                               scsi_mod .text 0xd0834060 0xd083b4d4 0xd083b4f0
0xc0291ee0 0xd083b96b [scsi_mod]scsi_io_completion+0x3ab (0xce5f6a00, 0x0, 0x1)
                               scsi_mod .text 0xd0834060 0xd083b5c0 0xd083b978
0xc0291f10 0xd084ecec [sd_mod]rw_intr+0x1e8 (0xce5f6a00)
                               sd_mod .text 0xd084e060 0xd084eb04 0xd084ecf8
0xc0291f28 0xd0835214 [scsi_mod]scsi_finish_command+0xdc (0xce5f6a00)
                               scsi_mod .text 0xd0834060 0xd0835138 0xd0835220
0xc0291f3c 0xd083508a [scsi_mod]scsi_bottom_half_handler+0x1f2
more> 
                               scsi_mod .text 0xd0834060 0xd0834e98 0xd08350ac
0xc0291f44 0xc0117dd0 bh_action+0x1c (0x8)
                               kernel .text 0xc0100000 0xc0117db4 0xc0117df8
0xc0291f5c 0xc0117ce9 tasklet_hi_action+0x59 (0xc02a85c0)
                               kernel .text 0xc0100000 0xc0117c90 0xc0117d10
0xc0291f78 0xc0117aac do_softirq+0x4c
                               kernel .text 0xc0100000 0xc0117a60 0xc0117b00
0xc0291f90 0xc01083ed do_IRQ+0xa1 (0xc0290000, 0xc14e4000, 0xc14e4270, 0xc0105170, 0xffffe000)
                               kernel .text 0xc0100000 0xc010834c 0xc0108400
0xc0291fcc 0xc01f33b8 call_do_IRQ+0x5
                               kernel .rodata 0xc01f1b00 0xc01f33b3 0xc01f33c0
           0xc0105207 cpu_idle+0x3f
                               kernel .text 0xc0100000 0xc01051c8 0xc010521c
0xc0291fe8 0xc010502a stext+0x2a
                               kernel .text 0xc0100000 0xc0105000 0xc0105030
0xc0291ff8 0xc0292931 start_kernel+0x101
                               kernel .text.init 0xc0292000 0xc0292830 0xc0292938


>From log_buf[]:
<4>SCSI device sda: 1273011 1024-byte hdwr sectors (1304 MB).
<4>sda: Write Protect is off.
<6> /dev/scsi/host0/bus0/target1/lun0:SCSI disk error : 
    host 0 channel 0 id 1 lun 0 return code = 8000002.
<4>Info fld=0x0, Current sd08:00: sense key Blank Check.
<4> I/O error: dev 08:00, sector 0.
<4>Incorrect number of segments after building list.
<4>kernel BUG at /usr/src/linux-SuSE73-2.4.17-Dbg/include/asm/pci.h:147!


Regards,
        Ralf Oehler

 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

