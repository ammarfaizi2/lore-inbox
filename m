Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263040AbTDBPyu>; Wed, 2 Apr 2003 10:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263037AbTDBPyu>; Wed, 2 Apr 2003 10:54:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17079 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263036AbTDBPyq>; Wed, 2 Apr 2003 10:54:46 -0500
Date: Wed, 2 Apr 2003 08:02:26 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: isp1020 memory trample in 2.5.66
Message-ID: <20030402080226.A25288@beaverton.ibm.com>
References: <Pine.LNX.4.50.0304020101460.8773-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.50.0304020101460.8773-100000@montezuma.mastecende.com>; from zwane@linuxpower.ca on Wed, Apr 02, 2003 at 01:08:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 01:08:54AM -0500, Zwane Mwaikambo wrote:
> 2.5.65 was ok, 2.5.66 can't boot, there is nothing obvious in the patch 
> which could have led to this. I'd try a binary search but i'm afraid i 
> won't have that much free time for a while.

> Box is 32way PIII-450, devices attached to the only real active isp1020 
> HBA are;

I've been booting OK with 2.5.66 with isp1020 and qlogicisp driver with
multiple disks, though the boot sometimes hangs.

I've also booted OK with the feral driver.

> qlogicisp : new isp1020 revision ID (5)
> qlogicisp : interrupt 233 already in use
> scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 70 irq 41 MEM base 
> 0xf8c1a000
>   Vendor: IBM       Model: DRHS36V           Rev: 0270
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>   Vendor: IBM       Model: DRHS36V           Rev: 0270
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>   Vendor: PLEXTOR   Model: CD-ROM PX-32CS    Rev: 1.02
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> scsi1 : QLogic ISP1020 SCSI on PCI bus 04 device 70 irq 89 MEM base 0xf8c1c000
> SCSI device sda: 72170879 512-byte hdwr sectors (36951 MB)
> SCSI device sda: drive cache: write through
>  sda: sda1 sda2 sda3
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sdb: 72170879 512-byte hdwr sectors (36951 MB)
> SCSI device sdb: drive cache: write through
>  sdb: unknown partition table
> 
> Unable to handle kernel paging request at virtual address 6b6b6b6b
>  printing eip:
> 6b6b6b6b
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<6b6b6b6b>]    Not tainted
> EFLAGS: 00010086
> EIP is at 0x6b6b6b6b
> eax: f8c1c000   ebx: e4f9c000   ecx: 00000001   edx: c3f56400
> esi: e4f9c000   edi: 00000002   ebp: e4fa09cc   esp: c0375f10
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c0374000 task=c03064a0)
> Stack: c0228d4b e4fa09cc 00000001 00000001 c3f564b0 c3f56400 0000000b c3f56400 
>        00000002 c0375f98 c0228a39 0000000b c3f56400 c0375f98 e59f1914 24000001 
>        0000000b c010cd4a 0000000b c3f56400 c0375f98 c0356960 c0356970 0000000b 
> Call Trace:
>  [<c0228d4b>] isp1020_intr_handler+0x2db/0x300
>  [<c0228a39>] do_isp1020_intr_handler+0x49/0x80
>  [<c010cd4a>] handle_IRQ_event+0x3a/0x60
>  [<c010d052>] do_IRQ+0x112/0x1f0
>  [<c01089b0>] default_idle+0x0/0x40
>  [<c01089b0>] default_idle+0x0/0x40
>  [<c010b700>] common_interrupt+0x18/0x20
>  [<c01089b0>] default_idle+0x0/0x40
>  [<c01089b0>] default_idle+0x0/0x40
>  [<c01089dd>] default_idle+0x2d/0x40
>  [<c0108a82>] cpu_idle+0x52/0x70
>  [<c0105000>] _stext+0x0/0x70
> 
> Code:  Bad EIP value.
>  <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 0xc0228d4b is in isp1020_intr_handler (drivers/scsi/qlogicisp.c:1072).
> 1071                    (*Cmnd->scsi_done)(Cmnd); <===
> 1072            }

This looks a lot like the oops when trying to send IO to more than one
disk at a time with the isp1020 + qlogicisp.

Is there something different causing IO to muliple disks at that point?

I hit this once when I enabled parallel fsck (it didn't oops until after I
got a late oops, and rebooted).

Martin hit it when the queue depth was not properly checked.

wli has hit it with parallel mkfs (or something).

The following thread was pretty useful, Doug L mentions that the qlogicisp
does bad things, starting with Martin's analysis:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104457083601573&w=2

-- Patrick Mansfield
