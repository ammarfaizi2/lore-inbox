Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVCDJF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVCDJF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVCDJF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:05:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1673 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262694AbVCDJAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:00:46 -0500
Date: Fri, 4 Mar 2005 10:00:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cfq: depth 4 reached, tagging now on
Message-ID: <20050304090031.GE14764@suse.de>
References: <200503040355_MC3-1-979D-F1DE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503040355_MC3-1-979D-F1DE@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04 2005, Chuck Ebbert wrote:
> On 2005-02-21 at 8:20:44, Jens Axboe wrote:
> 
> > On Sat, Feb 19 2005, Lee Revell wrote:
> > > Starting around 2.6.11-rc4 I get this printk during the boot process
> > > after kjournald starts, and again if I stress the filesystem.
> > > 
> > > cfq: depth 4 reached, tagging now on
> > > 
> > > Is this printk intentional?  I am sure users will wonder about it,
> > > especially because (presumably) cfq turns tagging off at some point in
> > > between, and doesn't say anything about it.
> 
> > It's a one-time message. CFQ starts out assuming the drive doesn't do
> > TCQ, if the driver depth goes beyond a defined limit (4), it will assume
> > that the hardware can do tagged queueing and change its internal
> > accounting accordingly.
> 
> Is that a safe assumption?  ide-scsi allows 5 active commands.
> Trying to use cfq with ide-scsi and a DVD-RAM on 2.6.10-ac12,
> I get:
> 
>         $ dd if=/dev/zero of=/dev/scd1 bs=64k count=128
>         cfq: depth 4 reached, tagging now on

It's pretty pointless to queue requests internally, if your
hardware cannot do queueing. The drive is deliberately stealing
information away from the io scheduler and preventing merging,
etc.

What CFQ tells you is that it considers the rq timing unreliable,
because it doesn't know how much time the hardware will use to
complete that specific request.

>         hdc: DMA timeout retry
>         hdc: timeout waiting for DMA
>         hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>         hdc: status error: error=0x00 { }
>         hdc: drive not ready for command

Unrelated to the io scheduling, it's a drive/driver problem.

> Then it deadlocks trying to get the host_lock:
> 
>         SysRq : Show Regs
>         
>         Pid: 23, comm:            scsi_eh_1
>         EIP: 0060:[<c034d9d7>] CPU: 0
>         EIP is at _spin_lock_irqsave+0x17/0x20
>          EFLAGS: 00000286    Not tainted  (2.6.10-ac12)
>         EAX: 00000246 EBX: 00000000 ECX: d7eedb40 EDX: d7eea020
>         ESI: d7eea000 EDI: d7ef8b00 EBP: d7f597a0 DS: 007b ES: 007b
>         CR0: 8005003b CR2: 0030b99c CR3: 15ca1000 CR4: 000002d0
>          [<c02962c5>] idescsi_end_request+0x105/0x3c0
>          [<c0296580>] idescsi_expiry+0x0/0x20
>          [<c0296637>] idescsi_pc_intr+0x97/0x2e0
>          [<c0296580>] idescsi_expiry+0x0/0x20
>          [<c02965a0>] idescsi_pc_intr+0x0/0x2e0
>          [<c0263a64>] ide_intr+0xe4/0x16a
>          [<c01319c0>] handle_IRQ_event+0x3b/0x7b
>          [<c0131aea>] __do_IRQ+0xea/0x140
>          [<c0104939>] do_IRQ+0x19/0x24
>          [<c0102ee2>] common_interrupt+0x1a/0x20
>          [<c026007b>] ide_register_hw+0x1b/0x21
>          [<c02975ee>] idescsi_eh_abort+0xaa/0x1c4
>          [<c02750ca>] scsi_try_to_abort_cmd+0x5e/0x7a
>          [<c027520a>] scsi_eh_abort_cmds+0x4a/0x80
>          [<c034c6f4>] __down_interruptible+0xf4/0x120
>          [<c0275e00>] scsi_unjam_host+0x9f/0xbf
>          [<c0115385>] complete+0x45/0x60
>          [<c0275ed0>] scsi_error_handler+0xb0/0xe0
>          [<c0275e20>] scsi_error_handler+0x0/0xe0
>          [<c01007d5>] kernel_thread_helper+0x5/0x10

ide-scsi error handling is broken.

-- 
Jens Axboe

