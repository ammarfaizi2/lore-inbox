Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWHRIN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWHRIN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWHRIN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:13:29 -0400
Received: from brick.kernel.dk ([62.242.22.158]:28713 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751034AbWHRIN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:13:28 -0400
Date: Fri, 18 Aug 2006 10:15:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Steffen Maier <smaier@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Chad Talbott <ctalbott@google.com>,
       Jochen Suckfuell <jo-lkml@suckfuell.net>,
       Zlatko Calusic <zlatko.calusic@iskon.hr>
Subject: Re: ios_in_flight of CONFIG_BLK_STATS (still) negative in 2.4
Message-ID: <20060818081524.GG798@suse.de>
References: <Pine.LNX.4.64.0608171924570.16659@nettc.informatik.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608171924570.16659@nettc.informatik.uni-stuttgart.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(top posting, since I'm not replying to specific parts of this)

I'd suggest an easy fix of just adding a 'char io_account' variable to
struct request to fix this finally. The request type checking has been
proven fragile.

You can even use this for just debugging what goes wrong. Set
rq->io_account = 1 when you account the io as started, check that it is
indeed set when you do the end io account. And likewise, if ->io_account
isn't set and end io accounting is called, dump the stack trace and
request info to learn about why.


On Thu, Aug 17 2006, Steffen Maier wrote:
> Hello,
> 
> in this posting I would like to analyze and discuss a bug(?), that
> causes the number of I/O requests in flight (ios_in_flight) of the
> extended block device statistics (CONFIG_BLK_STATS) to become and stay
> negative on various kernels of version 2.4. In turn, this leads to
> erroneous display of 100% utilization for certain classes of harddisk
> devices with 'iostat -x' and probably other statistic tools relying on
> the 13th (last but two) field (ios_in_flight) of extended block device
> statistics listed in /proc/partitions.
> 
> First I encountered the behavior with 2.4.24 but could reproduce it
> with 2.4.33-rc3 (which is now the latest 2.4 kernel version 2.4.33).
> There have been various postings concerning this problem in recent
> years but to the best of my knowledge no ultimate fix has been merged
> into the mainstream kernel so far.
> 
> Some past posts [1,4] and debug instrumentation of the kernel (details
> later) indicate that apparently some types of block device I/O
> requests get enqueued without starting accounting. Unfortunately, on
> finishing the same requests accounting is ended. Thus, the accounting
> functions are unbalanced and the base line of ios_in_flight (and
> probably other counters?) becomes negative without ever recovering
> back to zero for idle devices.
> 
> At least in my case using an IDE disk ios_in_flight is -5 after
> booting without even executing hdparm, which in turn permanently
> decrements the value even further. That means, it does not just happen
> if you use hdparm but also during kernel initialization on usual
> bootup as will be shown later on. Also the problem only appears for
> the harddisk block device (hda) but not for its partitions (hdaX).
> 
> The obvious hacks to cure the symptom [7,8] won't fix the problem and
> might even cause corrupted statistics if a mix of "good" and "bad"
> requests gets queued together. I could also confirm that the issue
> happens on a single processor system and is not necessarily an SMP
> issue [5]. A former fix for SCSI [6] is already part of the kernel and
> obviously does not fix the problem here. Hence, there is need for a
> real fix.
> 
> The general questions is, if those "bad" requests should be accounted?
> If so, we need to find all missing accounting starts to pair the
> increment and decrement functions accordingly [2]. If not, we could
> eliminate the accounting end for "bad" requests as in [1] or in [3].
> 
> Chad Talbot's fix [3] works for me both during the booting part and
> for hdparm execution. Probably it needs some refactoring. However, it
> only fixes issues in ide_end_drive_cmd but there might be more
> functions enqueueing "bad" requests (see details below).
> 
> Rick Lindsley's fix [1] also works for me both during the booting part
> and for hdparm execution. I wonder, if those two conditional
> executions should be moved to req_new_io and req_finished_io instead
> of add_request and end_that_request_last. That way they should catch
> really all "bad" requests no matter where they came from.
> 
> Please keep me in CC since I'm currently not subscribed.
> 
> 
> Now the details:
> 
> Usual requests from the file system and buffer cache roughly take the
> following code path and correctly start accounting through req_new_io:
> 
> ll_rw_block
>  submit_bh
>   generic_make_request
>    __make_request (request_queue_t->make_request_fn())
>     req_new_io
>      account_io_start
>       up_ios
>     add_request
>      drive_stat_acct [update dk_drive_rio,dk_drive_rblk only for READ or WRITE]
>      list_add(&req->queue, insert_here) >>>ENQUEUE<<<
> 
> On finishing requests the following dequeues them and ends accounting:
> 
> end_that_request_last, __scsi_end_request
>  req_finished_io
>   account_io_end
>    down_ios
> 
> Unfortunately, various places (fgrep -c) call end_that_request_last of
> which some may be the culprit:
> 
> drivers/block/cciss.c:3
> drivers/block/cpqarray.c:2
> drivers/block/ll_rw_blk.c:3
> drivers/block/sx8.c:1
> drivers/ide/ide-cd.c:1
> drivers/ide/ide-disk.c:1
> drivers/ide/ide-floppy.c:1
> drivers/ide/ide-io.c:2
> drivers/ide/ide-taskfile.c:1
> drivers/ide/ide-tape.c:1
> drivers/message/i2o/i2o_block.c:1
> drivers/s390/block/dasd.c:1
> drivers/s390/char/tapeblock.c:1
> drivers/scsi/ide-scsi.c:1
> 
> In order to track down, which places call end_that_request_last
> without having ever called req_new_io, I instrumented the kernel as
> shown in the patch attached to the end of this mail [9]. It enables
> matching of the start and end of requests by means of an
> ID. Additionally, it prints call traces to be converted into symbols
> using ksymoops. The instrumentation of ide_start_request in ide-io.c
> is of course an educated guess based on the fact that I noticed
> ios_in_flight becoming negative on task_no_data_intr calling
> end_that_request_last.  Since the serial console log with kernel
> messages and interleaved symbols decoded with ksymoops are quite
> large, I only report on selected findings here. If anybody is
> interested in my full debug log or kernel configuration, I'm happy to
> provide them.
> 
> The issues start during initialization of the IDE subsystem:
> 
> Linux version 2.4.33-rc3 (maiersn@nettc) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-47.fc4)) #18 Fri Aug 11 18:50:00 CEST 2006
> ...
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH4: IDE controller at PCI slot 00:1f.1
> PCI: Found IRQ 12 for device 00:1f.1
> PCI: Sharing IRQ 12 with 00:1d.2
> ICH4: chipset revision 1
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> hda: HDS722540VLAT20, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-disk driver.
> hda: host protected area => 1
> req=c158fe7c:00000000 cmd=97 sec=0,0 dev=3,0 spcl=c158ff0c buf=00000000 !drive->special.all=0 ide_start_request:-
> Pid: 1, comm:              swapper
> c158fdb4 c01b7214 c0227f1c 00000001 c158e23e 00000061 00000000 00000000 
>        00000003 00000000 c158ff0c 00000000 00000000 c0238956 c022e1d1 00000000 
>        00000000 c0250918 00000000 00000006 c158fe7c c02d74d0 c02d7420 c02d74d0 
> Call Trace:    [<c01b7214>] [<c01b7449>] [<c01b7bd0>] [<c01b0aef>] [<c011b69f>]
>   [<c01b0b47>] [<c01bf660>] [<c01b0070>] [<c01bfa1c>] [<c01c0b48>] [<c01b5b35>]
>   [<c0105000>] [<c01c0eee>] [<c010507b>] [<c0105000>] [<c010736e>] [<c0105070>]
> Trace; c01b7214 <ide_start_request+294/2e0>
> Trace; c01b7449 <ide_do_request+1b9/310>
> Trace; c01b7bd0 <ide_do_drive_cmd+b0/100>
> Trace; c01b0aef <ide_diag_taskfile+7f/b0>
> Trace; c011b69f <__call_console_drivers+5f/70>
> Trace; c01b0b47 <ide_raw_taskfile+27/30>
> Trace; c01bf660 <idedisk_read_native_max_address+50/a0>
> Trace; c01b0070 <task_no_data_intr+0/a0>
> Trace; c01bfa1c <init_idedisk_capacity+29c/2b0>
> Trace; c01c0b48 <idedisk_setup+158/380>
> Trace; c01b5b35 <ide_register_subdriver+125/150>
> Trace; c0105000 <_stext+0/0>
> Trace; c01c0eee <idedisk_init+7e/120>
> Trace; c010507b <init+b/100>
> Trace; c0105000 <_stext+0/0>
> Trace; c010736e <arch_kernel_thread+2e/40>
> Trace; c0105070 <init+0/100>
> req=c158fe7c:00000000 cmd=97 sec=0,0 dev=3,0 spcl=c158ff0c buf=00000000 !drive->special.all=0 ide_start_request:I
> Pid: 0, comm:              swapper
> c0261eb4 c01b7214 c0227f1c 00000000 c026023e 00000061 00000000 00000000 
>        00000003 00000000 c158ff0c 00000000 00000000 c0238956 c0237fe7 00000000 
>        c158ff58 00000046 00000000 00000282 c158fe7c c02d74d0 c02d7420 c02d74d0 
> Call Trace:    [<c01b7214>] [<c01b7449>] [<c01b7a42>] [<c01aff60>] [<c010a655>]
>   [<c010a804>] [<c0106fb0>] [<c010cd28>] [<c0106fb0>] [<c0106fd3>] [<c0107062>]
>   [<c0105000>]
> Trace; c01b7214 <ide_start_request+294/2e0>
> Trace; c01b7449 <ide_do_request+1b9/310>
> Trace; c01b7a42 <ide_intr+f2/130>
> Trace; c01aff60 <set_geometry_intr+0/c0>
> Trace; c010a655 <handle_IRQ_event+45/70>
> Trace; c010a804 <do_IRQ+64/a0>
> Trace; c0106fb0 <default_idle+0/40>
> Trace; c010cd28 <call_do_IRQ+5/d>
> Trace; c0106fb0 <default_idle+0/40>
> Trace; c0106fd3 <default_idle+23/40>
> Trace; c0107062 <cpu_idle+52/70>
> Trace; c0105000 <_stext+0/0>
> req=c158fe7c:00000000 cmd=97 sec=0,0 dev=3,0 spcl=c158ff0c buf=00000000 !drive->special.all=1 ide_start_request:I
> Pid: 0, comm:              swapper
> c0261eb4 c01b7214 c0227f1c 00000000 c026023e 00000061 00000000 00000000 
>        00000003 00000000 c158ff0c 00000000 00000001 c0238956 c0237fe7 00000000 
>        c158ff58 00000046 00000000 00000282 c158fe7c c02d74d0 c02d7420 c02d74d0 
> Call Trace:    [<c01b7214>] [<c01b7449>] [<c01b7a42>] [<c01b0020>] [<c010a655>]
>   [<c010a804>] [<c0106fb0>] [<c010cd28>] [<c0106fb0>] [<c0106fd3>] [<c0107062>]
>   [<c0105000>]
> Trace; c01b7214 <ide_start_request+294/2e0>
> Trace; c01b7449 <ide_do_request+1b9/310>
> Trace; c01b7a42 <ide_intr+f2/130>
> Trace; c01b0020 <recal_intr+0/50>
> Trace; c010a655 <handle_IRQ_event+45/70>
> Trace; c010a804 <do_IRQ+64/a0>
> Trace; c0106fb0 <default_idle+0/40>
> Trace; c010cd28 <call_do_IRQ+5/d>
> Trace; c0106fb0 <default_idle+0/40>
> Trace; c0106fd3 <default_idle+23/40>
> Trace; c0107062 <cpu_idle+52/70>
> Trace; c0105000 <_stext+0/0>
> req=c158fe7c:00000000 cmd=97 sec=0,0 dev=3,0 spcl=c158ff0c buf=00000000 ios=4294967295 account_io_end:I
> Pid: 0, comm:              swapper
> c0261ec4 c01a208c c15d4000 c158fe7c c0261edc c15d4000 00000000 c158fe7c 
>        c01a2f6a c158fe7c c0237fe7 00000286 c158fe7c c01b6603 c158fe7c 000003f6 
>        00000000 00000050 c02d7450 c02d7420 c02d74d0 c158ff0c c01b010c c02d74d0 
> Call Trace:    [<c01a208c>] [<c01a2f6a>] [<c01b6603>] [<c01b010c>] [<c01b7a0a>]
>   [<c01b0070>] [<c010a655>] [<c010a804>] [<c0106fb0>] [<c010cd28>] [<c0106fb0>]
>   [<c0106fd3>] [<c0107062>] [<c0105000>]
> Trace; c01a208c <req_finished_io+5c/60>
> Trace; c01a2f6a <end_that_request_last+2a/70>
> Trace; c01b6603 <ide_end_drive_cmd+83/2e0>
> Trace; c01b010c <task_no_data_intr+9c/a0>
> Trace; c01b7a0a <ide_intr+ba/130>
> Trace; c01b0070 <task_no_data_intr+0/a0>
> Trace; c010a655 <handle_IRQ_event+45/70>
> Trace; c010a804 <do_IRQ+64/a0>
> Trace; c0106fb0 <default_idle+0/40>
> Trace; c010cd28 <call_do_IRQ+5/d>
> Trace; c0106fb0 <default_idle+0/40>
> Trace; c0106fd3 <default_idle+23/40>
> Trace; c0107062 <cpu_idle+52/70>
> Trace; c0105000 <_stext+0/0>
> 
> That's the debug output for one single request. The final
> account_io_end clearly decrements ios_in_flight to -1 == (signed
> int)4294967295. To me it looks like if ide_do_drive_cmd enqueues the
> request with list_add(&rq->queue, queue_head). That could be one place
> where account starting by req_new_io is missing (or req_finished_io
> should be eliminated depending on the point of view). Unfortunately I
> don't know the block or IDE subsystem, in order to decide if that's
> correct. Any thoughts?
> 
> The following two requests similarly lead to erroneous decrements. (I
> still don't understand, why I get -5 for ios_in_flight although only 3
> requests seem to be "bad".)
> 
> req=c158fe70:00000000 cmd=97 sec=0,0 dev=3,0 spcl=c158ff08 buf=00000000 !drive->special.all=1 ide_start_request:-
> Pid: 1, comm:              swapper
> c158fda8 c01b7214 c0227f1c 00000001 c158e23e 00000061 00000000 00000000 
>        00000003 00000000 c158ff08 00000000 00000001 c0238956 c022e1d1 00000000 
>        c024d560 c158e000 00000000 00000006 c158fe70 c02d74d0 c02d7420 c02d74d0 
> Call Trace:    [<c01b7214>] [<c01b7449>] [<c01b7bd0>] [<c01b0aef>] [<c01b0b47>]
>   [<c01bf709>] [<c01b0070>] [<c01bf98c>] [<c01c0b48>] [<c01b5b35>] [<c0105000>]
>   [<c01c0eee>] [<c010507b>] [<c0105000>] [<c010736e>] [<c0105070>]
> Trace; c01b7214 <ide_start_request+294/2e0>
> Trace; c01b7449 <ide_do_request+1b9/310>
> Trace; c01b7bd0 <ide_do_drive_cmd+b0/100>
> Trace; c01b0aef <ide_diag_taskfile+7f/b0>
> Trace; c01b0b47 <ide_raw_taskfile+27/30>
> Trace; c01bf709 <idedisk_read_native_max_address_ext+59/d0>
> Trace; c01b0070 <task_no_data_intr+0/a0>
> Trace; c01bf98c <init_idedisk_capacity+20c/2b0>
> Trace; c01c0b48 <idedisk_setup+158/380>
> Trace; c01b5b35 <ide_register_subdriver+125/150>
> Trace; c0105000 <_stext+0/0>
> Trace; c01c0eee <idedisk_init+7e/120>
> Trace; c010507b <init+b/100>
> Trace; c0105000 <_stext+0/0>
> 
> hda: 80418240 sectors (41174 MB) w/1794KiB Cache, CHS=5005/255/63, UDMA(100)
> 
> req=c158fea4:00000000 cmd=97 sec=0,0 dev=3,0 spcl=c158ff34 buf=00000000 !drive->special.all=0 ide_start_request:-
> Pid: 1, comm:              swapper
> c158fddc c01b7214 c0227f1c 00000001 c158e23e 00000061 00000000 00000000 
>        00000003 00000000 c158ff34 00000000 00000000 c0238956 c022e1d1 00000000 
>        c158e000 00000000 00000000 00000006 c158fea4 c02d74d0 c02d7420 c02d74d0 
> Call Trace:    [<c01b7214>] [<c01b7449>] [<c01b7bd0>] [<c01b0aef>] [<c01b0b47>]
>   [<c01c00f3>] [<c01b0070>] [<c01bd435>] [<c01c0ce8>] [<c0105000>] [<c01c0eee>]
>   [<c010507b>] [<c0105000>] [<c010736e>] [<c0105070>]
> Trace; c01b7214 <ide_start_request+294/2e0>
> Trace; c01b7449 <ide_do_request+1b9/310>
> Trace; c01b7bd0 <ide_do_drive_cmd+b0/100>
> Trace; c01b0aef <ide_diag_taskfile+7f/b0>
> Trace; c01b0b47 <ide_raw_taskfile+27/30>
> Trace; c01c00f3 <write_cache+73/a0>
> Trace; c01b0070 <task_no_data_intr+0/a0>
> Trace; c01bd435 <__ide_dma_verbose+c5/1f0>
> Trace; c01c0ce8 <idedisk_setup+2f8/380>
> Trace; c0105000 <_stext+0/0>
> Trace; c01c0eee <idedisk_init+7e/120>
> Trace; c010507b <init+b/100>
> Trace; c0105000 <_stext+0/0>
> Trace; c010736e <arch_kernel_thread+2e/40>
> Trace; c0105070 <init+0/100>
> 
> Partition check:
>  hda:
> 
> [[at this point, some "good" requests are processed and accounted correctly]]
> 
>  hda1 hda2 hda3 hda4 <
> 
> [[at this point, some "good" requests are processed and accounted correctly]]
> 
>  hda5 hda6 hda7 hda8 hda9 >
> 
> That's all for now.
> 
> Thanks,
> Steffen.
> 
> -- 
> 
> REFERENCES:
> 
> [1]
> hint to unbalanced requests
> fix to never account non-blk_fs_request's and thus eliminating wrong 
> req_finished_io
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0401.1/1353.html
> Rick Lindsley
> diff -rup linux-2.4.33-rc3/drivers/block/ll_rw_blk.c linux-2.4.33-rc3.rl/drivers/block/ll_rw_blk.c
> --- linux-2.4.33-rc3/drivers/block/ll_rw_blk.c	2006-08-08 18:45:09.000000000 +0200
> +++ linux-2.4.33-rc3.rl/drivers/block/ll_rw_blk.c	2006-08-17 16:38:27.000000000 +0200
> @@ -854,7 +854,8 @@ EXPORT_SYMBOL(req_finished_io);
>  static inline void add_request(request_queue_t * q, struct request * req,
>  			       struct list_head *insert_here)
>  {
> -	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
> +        if (blk_fs_request(req))
> +                drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
>  
>  	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
>  		spin_unlock_irq(&io_request_lock);
> @@ -1495,7 +1496,8 @@ void end_that_request_last(struct reques
>  	if (laptop_mode && req->cmd == READ)
>  		mod_timer(&writeback_timer, jiffies + 5 * HZ);
>  
> -	req_finished_io(req);
> +        if (blk_fs_request(req))
> +                req_finished_io(req);
>  	blkdev_release_request(req);
>  	if (waiting)
>  		complete(waiting);
> 
> [2]
> need to pair accounting
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0309.3/0036.html
> Stephen C. Tweedie
> 
> [3]
> fix replaces end_that_request_last in ide_end_drive_cmd by the content
> of end_that_request_last minus req_finished_io
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0309.2/1454.html
> Chad Talbott
> diff -rup linux-2.4.33-rc3/drivers/ide/ide-io.c linux-2.4.33-rc3.ct/drivers/ide/ide-io.c
> --- linux-2.4.33-rc3/drivers/ide/ide-io.c	2006-08-08 18:45:09.000000000 +0200
> +++ linux-2.4.33-rc3.ct/drivers/ide/ide-io.c	2006-08-17 18:03:18.000000000 +0200
> @@ -116,6 +116,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
>  	ide_hwif_t *hwif = HWIF(drive);
>  	unsigned long flags;
>  	struct request *rq;
> +        struct completion *waiting;
>  
>  	spin_lock_irqsave(&io_request_lock, flags);
>  	rq = HWGROUP(drive)->rq;
> @@ -189,7 +190,12 @@ void ide_end_drive_cmd (ide_drive_t *dri
>  	spin_lock_irqsave(&io_request_lock, flags);
>  	blkdev_dequeue_request(rq);
>  	HWGROUP(drive)->rq = NULL;
> -	end_that_request_last(rq);
> +        waiting = rq->waiting;
> +        /* FIXME: laptop_mode behavior of end_that_request_last is
> +         * missing because writeback_timer is static in ll_rw_blk.c */
> +        blkdev_release_request(rq);
> +        if (waiting)
> +                complete(waiting);
>  	spin_unlock_irqrestore(&io_request_lock, flags);
>  }
>  
> [4]
> hints where accounting starts could be missing
> (but it's not an exclusive hdparm issue, it rather
> happens during kernel init, even before init is spawned)
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0309.1/2327.html
> Chad Talbott
> 
> [5]
> fix to count atomically on SMP (but does not help here)
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.3/0721.html
> Jochen Suckfuell
> 
> [6]
> fix for scsi_lib is in the mainstream
> (but does not fix the issue here)
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.1/0323.html
> Jochen Suckfuell
> acknowledged as bug
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.1/0843.html
> Jens Axboe
> 
> [7]
> hack to reset ios_in_flight to zero if negative on reading procfs
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0902.html
> Jochen Suckfuell
> 
> [8]
> hack to prevent decrement past zero
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0703.html
> Zlatko Calusic
> 
> [9]
> diff -ur linux-2.4.33-rc3/drivers/block/ll_rw_blk.c linux-2.4.33-rc3.blkstatfix/drivers/block/ll_rw_blk.c
> --- linux-2.4.33-rc3/drivers/block/ll_rw_blk.c	2006-08-08 18:45:09.000000000 +0200
> +++ linux-2.4.33-rc3.blkstatfix/drivers/block/ll_rw_blk.c	2006-08-17 10:45:30.000000000 +0200
> @@ -32,6 +32,8 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> +#include <linux/interrupt.h>
> +
>  /*
>   * MAC Floppy IWM hooks
>   */
> @@ -761,6 +763,8 @@
>  	hd->last_idle_time = now;	
>  }
>  
> +static unsigned int blkstatfix_count = 42;
> +
>  static inline void down_ios(struct hd_struct *hd)
>  {
>  	disk_round_stats(hd);	
> @@ -790,6 +794,22 @@
>  	}
>  	if (!merge)
>  		up_ios(hd);
> +#if 1
> +        if (blkstatfix_count > 0) {
> +                /* blkstatfix_count--; */
> +                printk(KERN_ERR "\nreq=%p:%08lx cmd=%i sec=%lu,%lu dev=%u,%u spcl=%p buf=%p ios=%010u mrg=%i secs=%i %s:%s\n\n",
> +                       req, req->start_time, req->cmd,
> +                       req->sector, req->nr_sectors,
> +                       MAJOR(req->rq_dev), MINOR(req->rq_dev),
> +                       req->special, req->buffer,
> +                       hd->ios_in_flight,
> +                       merge, sectors,
> +                       __PRETTY_FUNCTION__, (in_interrupt()?"I":"-")
> +                       );
> +                printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
> +                dump_stack(); /* from kernel.h, arch/.../kernel/traps.c */
> +        }
> +#endif
>  }
>  
>  static void account_io_end(struct hd_struct *hd, struct request *req)
> @@ -806,6 +826,21 @@
>  		break;
>  	}
>  	down_ios(hd);
> +#if 1
> +        if (blkstatfix_count > 0) {
> +                blkstatfix_count--;
> +                printk(KERN_ERR "\nreq=%p:%08lx cmd=%i sec=%lu,%lu dev=%u,%u spcl=%p buf=%p ios=%010u %s:%s\n\n",
> +                       req, req->start_time, req->cmd,
> +                       req->sector, req->nr_sectors,
> +                       MAJOR(req->rq_dev), MINOR(req->rq_dev),
> +                       req->special, req->buffer,
> +                       hd->ios_in_flight,
> +                       __PRETTY_FUNCTION__, (in_interrupt()?"I":"-")
> +                       );
> +                printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
> +                dump_stack(); /* from kernel.h, arch/.../kernel/traps.c */
> +        }
> +#endif
>  }
>  
>  void req_new_io(struct request *req, int merge, int sectors)
> @@ -828,6 +863,22 @@
>  		down_ios(hd1);
>  	if (hd2)	
>  		down_ios(hd2);
> +#if 1
> +        if (blkstatfix_count > 0) {
> +                blkstatfix_count--;
> +                printk(KERN_ERR "\nreq=%p:%08lx cmd=%i sec=%lu,%lu dev=%u,%u spcl=%p buf=%p ios1=%010u ios2=%010u %s:%s\n\n",
> +                       req, req->start_time, req->cmd,
> +                       req->sector, req->nr_sectors,
> +                       MAJOR(req->rq_dev), MINOR(req->rq_dev),
> +                       req->special, req->buffer,
> +                       (hd1)?hd1->ios_in_flight:666,
> +                       (hd2)?hd2->ios_in_flight:666,
> +                       __PRETTY_FUNCTION__, (in_interrupt()?"I":"-")
> +                       );
> +                printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
> +                dump_stack(); /* from kernel.h, arch/.../kernel/traps.c */
> +        }
> +#endif
>  }
>  
>  void req_finished_io(struct request *req)
> diff -ur linux-2.4.33-rc3/drivers/ide/ide-io.c linux-2.4.33-rc3.blkstatfix/drivers/ide/ide-io.c
> --- linux-2.4.33-rc3/drivers/ide/ide-io.c	2006-08-08 18:45:09.000000000 +0200
> +++ linux-2.4.33-rc3.blkstatfix/drivers/ide/ide-io.c	2006-08-17 10:45:01.000000000 +0200
> @@ -541,6 +541,8 @@
>  
>  EXPORT_SYMBOL(execute_drive_cmd);
>  
> +static unsigned int blkstatfix_count = 42;
> +
>  /**
>   *	ide_start_request	-	start of I/O and command issuing for IDE
>   *
> @@ -610,6 +612,22 @@
>  		printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
>  		return startstop;
>  	}
> +#if 1
> +        if ((blkstatfix_count > 0)
> +            && (1 || !blk_fs_request(rq))) {
> +                blkstatfix_count--;
> +                printk(KERN_ERR "\nreq=%p:%08lx cmd=%i sec=%lu,%lu dev=%u,%u spcl=%p buf=%p !drive->special.all=%i %s:%s\n\n",
> +                       rq, rq->start_time, rq->cmd,
> +                       rq->sector, rq->nr_sectors,
> +                       MAJOR(rq->rq_dev), MINOR(rq->rq_dev),
> +                       rq->special, rq->buffer,
> +                       !drive->special.all,
> +                       __PRETTY_FUNCTION__, (in_interrupt()?"I":"-")
> +                       );
> +                printk("Pid: %d, comm: %20s\n", current->pid, current->comm);
> +                dump_stack(); /* from kernel.h, arch/.../kernel/traps.c */
> +        }
> +#endif
>  	if (!drive->special.all) {
>  		switch(rq->cmd) {
>  			case IDE_DRIVE_CMD:

-- 
Jens Axboe

