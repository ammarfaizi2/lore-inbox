Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSDINlh>; Tue, 9 Apr 2002 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313187AbSDINlg>; Tue, 9 Apr 2002 09:41:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58129 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313162AbSDINlf>;
	Tue, 9 Apr 2002 09:41:35 -0400
Date: Tue, 9 Apr 2002 15:41:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE TCQ #2
Message-ID: <20020409134137.GB32133@suse.de>
In-Reply-To: <20020409124417.GK25984@suse.de> <3CB2DD74.30700@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09 2002, Martin Dalecki wrote:
> >  echo "using_tcq:0" > /proc/ide/hdX/setting
> >
> >  will disable TCQ and revert to DMA,
> >
> >  echo "using_tcq:32" > /proc/ide/hdX/setting
> >
> >  will set queue depth to 32, any value in between the two are of course
> >  also allowed. The driver will print enable/disable info to the kernel
> >  log.
> 
> Well this belongs to an ioctl or sysctl... However most
> of the /proc/ide stuff if not all will go to the sysctl quite soon.

Put it wherever you want it, I'm just making it easier for myself not
having to pass patches to hdparm around as well for people to enable
taggged queueing.

> > #include <linux/config.h>
> > #include <linux/module.h>
> >@@ -109,53 +110,64 @@
> > static u8 get_command(ide_drive_t *drive, int cmd)
> > {
> > 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
> >+	int command = WIN_NOP;
> 
> The "incremental" usage of the command variable I think is an 
> overoptimization.

Quite possibly, I couldn't resist since the commands are defined the
way there are.

> u8 is the proper type for it anyway. I have unwound the code below once
> to make it more obvious and you would be surprised what GCC does with it 
> :-).
> >+
> >+	return command;
> > }
> 
> See you are returning an int entity as u8!

Oh yeah, woops. Value is ok.

> >+	ide_task_t			*args = &ar->ar_task;
> >+	struct request			*rq = ar->ar_rq;
> 
> Hints that ide_task_t and ata_request_t and struct request usage
> belong together. This could alleviate the ugly usage of the
> rq->special field if rq is struct request - which would be a GoodThin(TM).

Of course, that's my whole point with this ata_request stuff. It's just
messy now because I only cared for tcq usage, not cleaning the rest of
the cruft.

> >n ata_taskfile(drive,
> >-			&args.taskfile,
> >-			&args.hobfile,
> >-			args.handler,
> >-			args.prehandler,
> >+			&args->taskfile,
> >+			&args->hobfile,
> >+			args->handler,
> >+			args->prehandler,
> > 			rq);
> 
> Due to the other cleanups which happened already it was now possible
> for me to collapse the arguments of the ata_taskfile function to
> use only one parameter - names ide_task_t. This will immediately allow
> to consolidate all data specific to a command into one queued structure,
> which will be named struct ata_request then. I will post the
> corresponding patch just immediately, since the integration of the
> tcq stuff will be quite involved with it.

Good, ata_taskfile/ide_wait_taskfile is a horrible interface right now.
But you now that :-)

> >+/*
> >+ * FIXME: taskfiles should be a map of pages, not a long virt address... 
> >/jens
> >+ */
> 
> I fully agree with you - possible it will be helpfull to just pee at
> the SCSI code to see how it should be done...

Just build a big bio, for instance. And hey, look then taskfile and
request paths are identical all of a sudden.

> >+	if (rq->flags & REQ_DRIVE_TASKFILE)
> >+		ar->ar_sg_nents = ide_raw_build_sglist(hwif, rq);
> >+	else 
> >+		ar->ar_sg_nents = ide_build_sglist(hwif, rq);
> 
> Most certainly the switch should be pushed down to one sinde
> build_sglist function - we are passing the rq anyway to it.

See above, they can be unified instead.

> >@@ -372,10 +378,9 @@
> > void ide_destroy_dmatable (ide_drive_t *drive)
> > {
> > 	struct pci_dev *dev = drive->channel->pci_dev;
> >-	struct scatterlist *sg = drive->channel->sg_table;
> >-	int nents = drive->channel->sg_nents;
> >+	ata_request_t *ar = IDE_CUR_AR(drive);
> 
> This looks a bit ugly and should be analogous to ata_ar_get()
> possible ata_ar_current() will fit.

Ok with me, no strong style oppinions here.

> >+int ide_start_dma(struct ata_channel *hwif, ide_drive_t *drive, 
> >ide_dma_action_t func)
> >+{
> >+	unsigned int reading = 0, count;
> >+	unsigned long dma_base = hwif->dma_base;
> >+	ata_request_t *ar = IDE_CUR_AR(drive);
> >+
> >+	if (rq_data_dir(ar->ar_rq) == READ)
> >+		reading = 1 << 3;
> >+
> >+	if (hwif->rwproc)
> >+		hwif->rwproc(drive, func);
> >+
> >+	if (!(count = ide_build_dmatable(drive, ar->ar_rq, func)))
> >+		return 1;	/* try PIO instead of DMA */
> >+
> >+	ar->ar_flags |= ATA_AR_SETUP;
> >+	outl(ar->ar_dmatable, dma_base + 4);	/* PRD table */
> >+	outb(reading, dma_base);		/* specify r/w */
> >+	outb(inb(dma_base + 2) | 6, dma_base+2);/* clear INTR & ERROR flags 
> >*/
> 
> Hmmm there is one architecture which will have possbile problems with this
> namely cris. But right now I'm quite convinced that they should fix 
> something
> there and the OUT_ IDE code specific compatibility macros should be removed
> altogether.

How is cris working now, then?

> >diff -urN -X /home/axboe/cdrom/exclude 
> >/opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-features.c 
> >linux/drivers/ide/ide-features.c
> >--- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-features.c	Tue Apr  9 
> >11:41:13 2002
> >+++ linux/drivers/ide/ide-features.c	Thu Apr  4 08:14:18 2002
> >@@ -75,10 +75,7 @@
> > char *ide_dmafunc_verbose (ide_dma_action_t dmafunc)
> > {
> > 	switch (dmafunc) {
> >-		case ide_dma_read:		return("ide_dma_read");
> >-		case ide_dma_write:		return("ide_dma_write");
> > 		case ide_dma_begin:		return("ide_dma_begin");
> >-		case ide_dma_end:		return("ide_dma_end:");
> > 		case ide_dma_check:		return("ide_dma_check");
> > 		case ide_dma_on:		return("ide_dma_on");
> > 		case ide_dma_off:		return("ide_dma_off");
> This abortion will be killed by using __FUNCTION__ where apriopriate in 
> debugging code.

Good!

> OK I will just "eat" your code this evening...

Looking forward to the merge work ahead :-)

-- 
Jens Axboe

