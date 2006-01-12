Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWALIUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWALIUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWALIUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:20:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9790 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751155AbWALIUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:20:54 -0500
Date: Thu, 12 Jan 2006 09:22:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       neilb@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112082227.GG17718@suse.de>
References: <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112080051.GA22783@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Tejun Heo wrote:
> Hello, Reuben, Jens and all.
> 
> On Thu, Jan 12, 2006 at 04:49:30PM +1300, Reuben Farrelly wrote:
> > 
> > 
> > On 12/01/2006 8:53 a.m., Jens Axboe wrote:
> > >On Wed, Jan 11 2006, Jens Axboe wrote:
> > >>At least it shows that the problem is indeed barrier related. I don't
> > >>have the start of this thread, so can you please send me the output from
> > >>dmesg from this kernel boot? I'm curious whether the fallback triggers,
> > >>or if it's the barrier that fails instead.
> > >
> > >Or even better, please boot with this patch applied on top of the kernel
> > >you just booted (the new one, with the md patch applied).
> > >
> > >diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > >index 4c5127e..07aee66 100644
> > >--- a/drivers/scsi/sd.c
> > >+++ b/drivers/scsi/sd.c
> > >@@ -1492,6 +1492,7 @@ static int sd_revalidate_disk(struct gen
> > > 		ordered = QUEUE_ORDERED_DRAIN;
> > > 
> > > 	blk_queue_ordered(sdkp->disk->queue, ordered, sd_prepare_flush);
> > >+	printk("%s: ordered set to %d\n", disk->disk_name, ordered);
> > > 
> > > 	set_capacity(disk, sdkp->capacity);
> > > 	kfree(buffer);
> > 
> > Here it is...
> > 
> > Linux version 2.6.15-mm3 (root@tornado.reub.net) (gcc version 4.1.0 
> > 20060106 (Red Hat 4.1.0-0.14)) #4 SMP Thu Jan 12 16:26:28 NZDT 2006
> [--snip--]
> > ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA 
> > mode
> > ahci 0000:00:1f.2: flags: 64bit ncq led slum part
> > ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 193
> > ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 193
> > ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 193
> > ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 193
> > ata1: SATA link up 1.5 Gbps (SStatus 113)
> > ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
> > 88:007f
> > ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
> > ata1: dev 0 configured for UDMA/133
> > scsi0 : ahci
> > ata2: SATA link up 1.5 Gbps (SStatus 113)
> > ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
> > 88:007f
> > ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
> > ata2: dev 0 configured for UDMA/133
> > scsi1 : ahci
> > ata3: SATA link up 1.5 Gbps (SStatus 113)
> > ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
> > 88:007f
> > ata3: dev 0 ATA-6, max UDMA/133, 156299375 sectors: LBA48
> > ata3: dev 0 configured for UDMA/133
> > scsi2 : ahci
> > ata4: SATA link down (SStatus 0)
> > scsi3 : ahci
> >   Vendor: ATA       Model: ST380817AS        Rev: 3.42
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> >   Vendor: ATA       Model: ST380817AS        Rev: 3.42
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> >   Vendor: ATA       Model: ST380013AS        Rev: 3.18
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> > sda: Write Protect is off
> > sda: Mode Sense: 00 3a 00 00
> > SCSI device sda: drive cache: write back
> > sda: ordered set to 49
> 
> 49d == 31h == QUEUE_ORDERED_DRAIN_FLUSH which is the right ordered
> mode on most SATA drives.  Barrier is performed by
> 
>  drain -> pre-flush -> barrier -> post-flush
> 
> sequence.  If something went wrong and above sequence got stuck, the
> first suspect part would be 'draining'.  I'm attaching a patch which
> adds a bunch of debug messages regarding ordered sequencing.  Can you
> please apply the patch and post the log message?  The patch is against
> v2.6.15-mm2.
> 
> I've also tested almost the same setup here - 2 maxtor SATA drives
> hanging off AHCI and grouped into /dev/md0 and it works fine here.  It
> prints something like the following while mounting /dev/md0 on boot
> with the debug patch applied.

It works fine for me as well, both with SATA using the drain-flush
approach and with SCSI + FUA _and_ drain-flush (modified SD to set that
instead).

Thanks for looking at this Tejun, we badly need it fixed asap!

-- 
Jens Axboe

