Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVCDJAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVCDJAC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCDJAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:00:01 -0500
Received: from siaag2aa.compuserve.com ([149.174.40.131]:51920 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262698AbVCDIzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:55:52 -0500
Date: Fri, 4 Mar 2005 03:52:56 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: cfq: depth 4 reached, tagging now on
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Message-ID: <200503040355_MC3-1-979D-F1DE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-02-21 at 8:20:44, Jens Axboe wrote:

> On Sat, Feb 19 2005, Lee Revell wrote:
> > Starting around 2.6.11-rc4 I get this printk during the boot process
> > after kjournald starts, and again if I stress the filesystem.
> > 
> > cfq: depth 4 reached, tagging now on
> > 
> > Is this printk intentional?  I am sure users will wonder about it,
> > especially because (presumably) cfq turns tagging off at some point in
> > between, and doesn't say anything about it.

> It's a one-time message. CFQ starts out assuming the drive doesn't do
> TCQ, if the driver depth goes beyond a defined limit (4), it will assume
> that the hardware can do tagged queueing and change its internal
> accounting accordingly.

 Is that a safe assumption?  ide-scsi allows 5 active commands. Trying to use
cfq with ide-scsi and a DVD-RAM on 2.6.10-ac12, I get:

        $ dd if=/dev/zero of=/dev/scd1 bs=64k count=128
        cfq: depth 4 reached, tagging now on
        hdc: DMA timeout retry
        hdc: timeout waiting for DMA
        hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
        hdc: status error: error=0x00 { }
        hdc: drive not ready for command

Then it deadlocks trying to get the host_lock:

        SysRq : Show Regs
        
        Pid: 23, comm:            scsi_eh_1
        EIP: 0060:[<c034d9d7>] CPU: 0
        EIP is at _spin_lock_irqsave+0x17/0x20
         EFLAGS: 00000286    Not tainted  (2.6.10-ac12)
        EAX: 00000246 EBX: 00000000 ECX: d7eedb40 EDX: d7eea020
        ESI: d7eea000 EDI: d7ef8b00 EBP: d7f597a0 DS: 007b ES: 007b
        CR0: 8005003b CR2: 0030b99c CR3: 15ca1000 CR4: 000002d0
         [<c02962c5>] idescsi_end_request+0x105/0x3c0
         [<c0296580>] idescsi_expiry+0x0/0x20
         [<c0296637>] idescsi_pc_intr+0x97/0x2e0
         [<c0296580>] idescsi_expiry+0x0/0x20
         [<c02965a0>] idescsi_pc_intr+0x0/0x2e0
         [<c0263a64>] ide_intr+0xe4/0x16a
         [<c01319c0>] handle_IRQ_event+0x3b/0x7b
         [<c0131aea>] __do_IRQ+0xea/0x140
         [<c0104939>] do_IRQ+0x19/0x24
         [<c0102ee2>] common_interrupt+0x1a/0x20
         [<c026007b>] ide_register_hw+0x1b/0x21
         [<c02975ee>] idescsi_eh_abort+0xaa/0x1c4
         [<c02750ca>] scsi_try_to_abort_cmd+0x5e/0x7a
         [<c027520a>] scsi_eh_abort_cmds+0x4a/0x80
         [<c034c6f4>] __down_interruptible+0xf4/0x120
         [<c0275e00>] scsi_unjam_host+0x9f/0xbf
         [<c0115385>] complete+0x45/0x60
         [<c0275ed0>] scsi_error_handler+0xb0/0xe0
         [<c0275e20>] scsi_error_handler+0x0/0xe0
         [<c01007d5>] kernel_thread_helper+0x5/0x10

ide-cd works fine with the same hardware, except for stunningly slow UDF write
speed (~30K/sec; ext2 is about 350K/sec.)  At least there is no UDF file corruption
like others have reported.

        Linux version 2.6.10-ac12 (*****) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 SMP Sat Feb 19 19:49:33 EST 2005
        OEM ID: DELL     Product ID: OPTIPLEXGX2  APIC at: 0xFEE00000
        Processor #0 6:3 APIC version 17
        Processor #1 6:3 APIC version 17
        I/O APIC #2 Version 17 at 0xFEC00000.
        PIIX3: IDE controller at PCI slot 0000:00:0d.1
        hdc: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
        ide1 at 0x170-0x177,0x376 on irq 15
        scsi1 : SCSI host adapter emulation for IDE ATAPI devices
          Vendor: HL-DT-ST  Model: DVDRAM GSA-4163B  Rev: A100
          Type:   CD-ROM                             ANSI SCSI revision: 02
        sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
        Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5


--
Chuck
