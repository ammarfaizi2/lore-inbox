Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752265AbWAGOdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbWAGOdD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbWAGOdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:33:01 -0500
Received: from [202.67.154.148] ([202.67.154.148]:7554 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1752265AbWAGOdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:33:00 -0500
Message-ID: <43BFD11F.3080300@ns666.com>
Date: Sat, 07 Jan 2006 15:33:03 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as_insert_request at drivers/block/as-iosched.c:1519
References: <43BFC3FF.5080908@ns666.com> <43BFC705.50509@ns666.com>
In-Reply-To: <43BFC705.50509@ns666.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark v Wolher wrote:
> Mark v Wolher wrote:
> 
>>Hiya all,
>>
>>I was just playing a cd as usual and i noticed suddenly the errors
>>below, they repeated like 8 times.
>>
>>kernel: 2.6.14.5
>>
>>
>>Jan 7 14:32:40 localhost kernel: Badness in as_insert_request at
>>drivers/block/as-iosched.c:1519
>>Jan 7 14:32:40 localhost kernel: [as_insert_request+100/384]
>>Jan 7 14:32:40 localhost kernel: [__elv_add_request+120/192]
>>Jan 7 14:32:40 localhost kernel: [elv_add_request+76/112]
>>Jan 7 14:32:40 localhost kernel: [blk_execute_rq_nowait+72/96]
>>Jan 7 14:32:40 localhost kernel: [blk_execute_rq+148/192]
>>Jan 7 14:32:40 localhost kernel: [blk_end_sync_rq+0/64]
>>Jan 7 14:32:40 localhost kernel: [blk_rq_bio_prep+115/160]
>>Jan 7 14:32:40 localhost kernel: [cdrom_read_cdda_bpc+391/496]
>>Jan 7 14:32:40 localhost kernel: [cdrom_read_cdda+68/176]
>>Jan 7 14:32:40 localhost kernel: [mmc_ioctl+1373/2752]
>>Jan 7 14:32:40 localhost kernel: [cdrom_read_cdda+68/176]
>>Jan 7 14:32:40 localhost kernel: [mmc_ioctl+1373/2752]
>>Jan 7 14:32:40 localhost kernel: [scsi_cmd_ioctl+125/1232]
>>Jan 7 14:32:40 localhost last message repeated 3 times
>>Jan 7 14:32:40 localhost kernel: [cdrom_ioctl+3228/3392]
>>Jan 7 14:32:40 localhost kernel: [activate_task+141/160]
>>Jan 7 14:32:40 localhost kernel: [try_to_wake_up+730/832]
>>Jan 7 14:32:40 localhost kernel: [idecd_ioctl+133/144]
>>Jan 7 14:32:40 localhost kernel: [blkdev_driver_ioctl+82/144]
>>Jan 7 14:32:40 localhost kernel: [blkdev_ioctl+168/432]
>>Jan 7 14:32:40 localhost kernel: [block_ioctl+43/48]
>>Jan 7 14:32:40 localhost kernel: [do_ioctl+142/160]
>>Jan 7 14:32:40 localhost kernel: [vfs_ioctl+101/496]
>>Jan 7 14:32:40 localhost kernel: [sys_ioctl+103/144]
>>Jan 7 14:32:40 localhost kernel: [syscall_call+7/11]
>>Jan 7 14:32:40 localhost kernel: arq->state: 4
>>
>>Appreciate it if any one can take a look.
>>
>>Thanks,
>>
>>Mark
>>-
> 
> 
> 
> I have 2 drives, when i put the same cd or other cd's in the other drive
> then nothing happens. It happens only with the other drive.
> 
> Which is this one:
> Model=DVDRW DRW-1S45, FwRev=GBG2, SerialNo=
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2
>  AdvancedPM=no
>  Drive conforms to: device does not report version:
> 
>  * signifies the current active mode
> 
> 
> 
> 
> 

I went to /usr/src/linux/drivers/block/as-iosched.c line 1519, it's
located in this function, anyone know what arq is ?


static void
as_insert_request(request_queue_t *q, struct request *rq, int where)
{
        struct as_data *ad = q->elevator->elevator_data;
        struct as_rq *arq = RQ_DATA(rq);

        if (arq) {
                if (arq->state != AS_RQ_PRESCHED) {
                        printk("arq->state: %d\n", arq->state);
                        WARN_ON(1);             <<======= line 1519
                }
                arq->state = AS_RQ_NEW;
        }

        /* barriers must flush the reorder queue */
        if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
                        && where == ELEVATOR_INSERT_SORT)) {
                WARN_ON(1);
                where = ELEVATOR_INSERT_BACK;
        }

        switch (where) {
                case ELEVATOR_INSERT_BACK:
                        while (ad->next_arq[REQ_SYNC])
                                as_move_to_dispatch(ad,
ad->next_arq[REQ_SYNC]);

                        while (ad->next_arq[REQ_ASYNC])
                                as_move_to_dispatch(ad,
ad->next_arq[REQ_ASYNC]);

                        list_add_tail(&rq->queuelist, ad->dispatch);
                        as_account_queued_request(ad, rq);
                        as_antic_stop(ad);
                        break;
                case ELEVATOR_INSERT_FRONT:
                        list_add(&rq->queuelist, ad->dispatch);
                        as_account_queued_request(ad, rq);
                        as_antic_stop(ad);
                        break;
                case ELEVATOR_INSERT_SORT:
                        BUG_ON(!blk_fs_request(rq));
                        as_add_request(ad, arq);
                        break;
                default:
                        BUG();
                        return;
        }
}
