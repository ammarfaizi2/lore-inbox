Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313166AbSDIN0b>; Tue, 9 Apr 2002 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSDIN03>; Tue, 9 Apr 2002 09:26:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28944 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313166AbSDIN0Q>; Tue, 9 Apr 2002 09:26:16 -0400
Message-ID: <3CB2DD74.30700@evision-ventures.com>
Date: Tue, 09 Apr 2002 14:24:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE TCQ #2
In-Reply-To: <20020409124417.GK25984@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since I have been experimenting with your initial release
yerstoday, please allow me some more detailed notes about the code:


>   echo "using_tcq:0" > /proc/ide/hdX/setting
> 
>   will disable TCQ and revert to DMA,
> 
>   echo "using_tcq:32" > /proc/ide/hdX/setting
> 
>   will set queue depth to 32, any value in between the two are of course
>   also allowed. The driver will print enable/disable info to the kernel
>   log.

Well this belongs to an ioctl or sysctl... However most
of the /proc/ide stuff if not all will go to the sysctl quite soon.

> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
> --- /opt/kernel/linux-2.5.8-pre2/drivers/block/ll_rw_blk.c	Mon Mar 18 21:37:05 2002
> +++ linux/drivers/block/ll_rw_blk.c	Tue Apr  9 10:35:20 2002
> @@ -857,10 +857,10 @@
>  	spin_lock_prefetch(q->queue_lock);
>  
>  	generic_unplug_device(q);
> -	add_wait_queue(&rl->wait, &wait);
> +	add_wait_queue_exclusive(&rl->wait, &wait);
>  	do {
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> -		if (rl->count < batch_requests)
> +		if (!rl->count)
>  			schedule();
>  		spin_lock_irq(q->queue_lock);
>  		rq = get_request(q, rw);
> @@ -1683,9 +1683,11 @@
>  	 * Free request slots per queue.
>  	 * (Half for reads, half for writes)
>  	 */
> -	queue_nr_requests = 64;
> -	if (total_ram > MB(32))
> -		queue_nr_requests = 256;
> +	queue_nr_requests = (total_ram >> 8) & ~15;	/* One per quarter-megabyte */
> +	if (queue_nr_requests < 32)
> +		queue_nr_requests = 32;
> +	if (queue_nr_requests > 256)
> +		queue_nr_requests = 256;

This adaptive behaviour seems to be better fitting possible
ram sized those days indeed.


> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
> --- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-disk.c	Tue Apr  9 11:41:13 2002
> +++ linux/drivers/ide/ide-disk.c	Tue Apr  9 10:29:46 2002
> @@ -26,9 +26,10 @@
>   * Version 1.11		Highmem I/O support, Jens Axboe <axboe@suse.de>
>   * Version 1.12		added 48-bit lba
>   * Version 1.13		adding taskfile io access method
> + * Version 1.14		Added tcq support, Jens Axboe <axboe@suse.de>
>   */
>  
> -#define IDEDISK_VERSION	"1.13"
> +#define IDEDISK_VERSION	"1.14"
>  
>  #include <linux/config.h>
>  #include <linux/module.h>
> @@ -109,53 +110,64 @@
>  static u8 get_command(ide_drive_t *drive, int cmd)
>  {
>  	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
> +	int command = WIN_NOP;

The "incremental" usage of the command variable I think is an overoptimization.
u8 is the proper type for it anyway. I have unwound the code below once
to make it more obvious and you would be surprised what GCC does with it :-).
> +
> +	return command;
>  }

See you are returning an int entity as u8!


> +	ide_task_t			*args = &ar->ar_task;
> +	struct request			*rq = ar->ar_rq;

Hints that ide_task_t and ata_request_t and struct request usage
belong together. This could alleviate the ugly usage of the
rq->special field if rq is struct request - which would be a GoodThin(TM).


> +	args->ar = ar;
> +	rq->special = ar;

Same hint as above.

>n ata_taskfile(drive,
> -			&args.taskfile,
> -			&args.hobfile,
> -			args.handler,
> -			args.prehandler,
> +			&args->taskfile,
> +			&args->hobfile,
> +			args->handler,
> +			args->prehandler,
>  			rq);

Due to the other cleanups which happened already it was now possible
for me to collapse the arguments of the ata_taskfile function to
use only one parameter - names ide_task_t. This will immediately allow
to consolidate all data specific to a command into one queued structure,
which will be named struct ata_request then. I will post the
corresponding patch just immediately, since the integration of the
tcq stuff will be quite involved with it.

> +	ide_task_t			*args = &ar->ar_task;
> +	struct request			*rq = ar->ar_rq;

See agin they belong together.

> +	args->ar = ar;
> +	rq->special = ar;

> +	ide_task_t			*args = &ar->ar_task;
> +	struct request			*rq = ar->ar_rq;

and again.

> +	args->ar = ar;
> +	rq->special = ar;

and again they belong together and strcut request should not be passed
as parameter in IDE code.


> -		return lba48_do_request(drive, rq, block);
> +		return lba48_do_request(drive, ar, block);
>  
>  	/* 28-bit LBA */
>  	if (drive->select.b.lba)
> -		return lba28_do_request(drive, rq, block);
> +		return lba28_do_request(drive, ar, block);
>  
>  	/* 28-bit CHS */
> -	return chs_do_request(drive, rq, block);
> +	return chs_do_request(drive, ar, block);

Didn't I tell we shouldn't be tossing request structs around? :-).

> +/*
> + * FIXME: taskfiles should be a map of pages, not a long virt address... /jens
> + */

I fully agree with you - possible it will be helpfull to just pee at
the SCSI code to see how it should be done...

> +	if (rq->flags & REQ_DRIVE_TASKFILE)
> +		ar->ar_sg_nents = ide_raw_build_sglist(hwif, rq);
> +	else 
> +		ar->ar_sg_nents = ide_build_sglist(hwif, rq);

Most certainly the switch should be pushed down to one sinde
build_sglist function - we are passing the rq anyway to it.

> @@ -372,10 +378,9 @@
>  void ide_destroy_dmatable (ide_drive_t *drive)
>  {
>  	struct pci_dev *dev = drive->channel->pci_dev;
> -	struct scatterlist *sg = drive->channel->sg_table;
> -	int nents = drive->channel->sg_nents;
> +	ata_request_t *ar = IDE_CUR_AR(drive);

This looks a bit ugly and should be analogous to ata_ar_get()
possible ata_ar_current() will fit.

> +int ide_start_dma(struct ata_channel *hwif, ide_drive_t *drive, ide_dma_action_t func)
> +{
> +	unsigned int reading = 0, count;
> +	unsigned long dma_base = hwif->dma_base;
> +	ata_request_t *ar = IDE_CUR_AR(drive);
> +
> +	if (rq_data_dir(ar->ar_rq) == READ)
> +		reading = 1 << 3;
> +
> +	if (hwif->rwproc)
> +		hwif->rwproc(drive, func);
> +
> +	if (!(count = ide_build_dmatable(drive, ar->ar_rq, func)))
> +		return 1;	/* try PIO instead of DMA */
> +
> +	ar->ar_flags |= ATA_AR_SETUP;
> +	outl(ar->ar_dmatable, dma_base + 4);	/* PRD table */
> +	outb(reading, dma_base);		/* specify r/w */
> +	outb(inb(dma_base + 2) | 6, dma_base+2);/* clear INTR & ERROR flags */

Hmmm there is one architecture which will have possbile problems with this
namely cris. But right now I'm quite convinced that they should fix something
there and the OUT_ IDE code specific compatibility macros should be removed
altogether.

> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
> --- /opt/kernel/linux-2.5.8-pre2/drivers/ide/ide-features.c	Tue Apr  9 11:41:13 2002
> +++ linux/drivers/ide/ide-features.c	Thu Apr  4 08:14:18 2002
> @@ -75,10 +75,7 @@
>  char *ide_dmafunc_verbose (ide_dma_action_t dmafunc)
>  {
>  	switch (dmafunc) {
> -		case ide_dma_read:		return("ide_dma_read");
> -		case ide_dma_write:		return("ide_dma_write");
>  		case ide_dma_begin:		return("ide_dma_begin");
> -		case ide_dma_end:		return("ide_dma_end:");
>  		case ide_dma_check:		return("ide_dma_check");
>  		case ide_dma_on:		return("ide_dma_on");
>  		case ide_dma_off:		return("ide_dma_off");
This abortion will be killed by using __FUNCTION__ where apriopriate in 
debugging code.


> +	ata_request_t *ar = rq->special;
> +	ide_task_t *args = &ar->ar_task;

Did I mention they belong to a single entity :-).

> -	ide_task_t *args	= HWGROUP(drive)->rq->special;
> +	ata_request_t *ar	= HWGROUP(drive)->rq->special;
> +	ide_task_t *args	= &ar->ar_task;

Same comment here.

> +	ata_request_t *ar = rq->special;
> +	ide_task_t *args = &ar->ar_task;

And here.

OK I will just "eat" your code this evening...

