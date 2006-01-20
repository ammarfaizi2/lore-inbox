Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWATMvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWATMvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWATMvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:51:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750787AbWATMvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:51:49 -0500
Date: Fri, 20 Jan 2006 04:51:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: davej@redhat.com, AChittenden@bluearc.com, linux-kernel@vger.kernel.org,
       lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-Id: <20060120045121.6b284b1e.akpm@osdl.org>
In-Reply-To: <20060120122859.GH13429@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com>
	<20060119194836.GM21663@redhat.com>
	<20060119141515.5f779b8d.akpm@osdl.org>
	<20060120081231.GE4213@suse.de>
	<20060120002307.76bcbc27.akpm@osdl.org>
	<20060120120844.GG13429@suse.de>
	<20060120041727.5329f299.akpm@osdl.org>
	<20060120122859.GH13429@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > > better candidate to fix that :-)
> > 
> > It's not ZONE_DMA32.  It's the 12MB ZONE_DMA which is being exhausted on
> > this 4GB 64-bit machine.
> > 
> > Andy put a dump_stack() into the oom code and it pointed at 
> > 
> > 
> >  Call Trace:<ffffffff8014d7bc>{out_of_memory+48}
> >  <ffffffff8014f4b0>{__alloc_pages+536}
> >         <ffffffff80169788>{bio_alloc_bioset+232}
> >  <ffffffff80169d03>{bio_copy_user+218}
> >         <ffffffff801bd657>{blk_rq_map_user+136}
> >  <ffffffff801c0008>{sg_io+328}
> >         <ffffffff801c047c>{scsi_cmd_ioctl+491}
> >  <ffffffff88005e22>{:ide_core:generic_ide_ioctl+631}
> >         <ffffffff88202d0c>{:sd_mod:sd_ioctl+371}
> >  <ffffffff802a6db6>{schedule_timeout+158}
> >         <ffffffff801bf165>{blkdev_ioctl+1365}
> >  <ffffffff80243cb2>{sys_sendto+251}
> >         <ffffffff801751e5>{__pollwait+0}
> >  <ffffffff8016b16a>{block_ioctl+25}
> >         <ffffffff801749f4>{do_ioctl+24} <ffffffff80174c46>{vfs_ioctl+541}
> >         <ffffffff80174cb4>{sys_ioctl+89}
> 
> Hmm strange, what kind of device is this? I'm guessing it's not ISA.

 sata_via 0000:00:0f.0: routed to hard irq line 1
 ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xC802 bmdma 0xB800 irq 17
 ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB808 irq 17
 sata_promise 0000:00:08.0: version 1.03
 ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 19
 ata3: SATA max UDMA/133 cmd 0xFFFFC20000006200 ctl 0xFFFFC20000006238
 bmdma 0x0 irq 19
 ata4: SATA max UDMA/133 cmd 0xFFFFC20000006280 ctl 0xFFFFC200000062B8
 bmdma 0x0 irq 19
 ...
 ata4: no device found (phy stat 00000000)
 scsi3 : sata_promise
 ata1: dev 0 cfg 49:2f00 82:3069 83:7c01 84:4003 85:3069 86:3c01 87:4003
 88:203f
 ata1: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
 ata1: dev 0 configured for UDMA/100
 scsi0 : sata_via
 ata2: no device found (phy stat 00000000)
 scsi1 : sata_via
   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
   Type:   Direct-Access                      ANSI SCSI revision: 05

> Andy, can you try and boot with this applied?

yes, that'll be interesting.

> Did the blk_max_low_pfn stuff get a different meaning with the addition
> of the DMA32 zone?

The Fedora reporter
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173) hit what
appears to be the same thing (gfp_mask=0xd1 - that's ZONE_DMA unless I've
lost it completely?) in 2.6.14, which doesn't have ZONE_DMA32.

