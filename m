Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312684AbSDON04>; Mon, 15 Apr 2002 09:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312687AbSDON04>; Mon, 15 Apr 2002 09:26:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60429 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312684AbSDON0y>; Mon, 15 Apr 2002 09:26:54 -0400
Message-ID: <3CBAC690.8090908@evision-ventures.com>
Date: Mon, 15 Apr 2002 14:24:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> Updated the patch to 2.5.8 (painful). Changes:

S*it - I did just offer you assistance... well you where faster.
Anyway thank you for going into this trouble.

Please allow me some notes anyway:

> 
> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
> --- /opt/kernel/linux-2.5.8/drivers/block/ll_rw_blk.c	2002-04-15 07:59:53.000000000 +0200
> +++ linux/drivers/block/ll_rw_blk.c	2002-04-15 08:42:23.000000000 +0200

I recognize the following makes sense but since
it's affecting every single type of device out there
it should go separetely to Linus I think...


> +  drive as a /\/\/\/\ queue size balance, where we could instead try and
> +  maintain a minimum queue size and get a /---------\ graph instead.

Nice drawings :-). But the help text shouldn't be
that encouraging right now IMHO... (At least
we should mark the options as experimental. (OK I will do that...)

> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
> --- /opt/kernel/linux-2.5.8/drivers/ide/ide.c	2002-04-15 10:05:03.000000000 +0200
> +++ linux/drivers/ide/ide.c	2002-04-15 14:31:08.000000000 +0200
> @@ -381,8 +381,23 @@
>  		add_blkdev_randomness(major(rq->rq_dev));
>  
>  		spin_lock_irqsave(&ide_lock, flags);
> +
> +		if ((jiffies - ar->ar_time > ATA_AR_MAX_TURNAROUND) && drive->queue_depth > 1) {
> +			printk("%s: exceeded max command turn-around time (%d seconds)\n", drive->name, ATA_AR_MAX_TURNAROUND / HZ);
> +			drive->queue_depth >>= 1;
> +		}
> +
> +		if (jiffies - ar->ar_time > drive->tcq->oldest_command)
> +			drive->tcq->oldest_command = jiffies - ar->ar_time;
> +

time_before() and timer_after() should be used here.


>  	while ((read_timer() - hwif->last_time) < DISK_RECOVERY_TIME);

Same here.


I don't like that the following get's even more complicated.
But of course I will just have too look closer and understand it actually.

> +		if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
> +			sleep = jiffies + WAIT_MIN_SLEEP;

The susual... timer_after() time_before()...

> -#ifdef CONFIG_BLK_DEV_IDEPCI
>  		if (hwif->pci_dev && !hwif->pci_dev->vendor)
> -#endif

Here I'm still not convinced whatever this should be implemented for
all architectures...


> -		memset(ar, 0, sizeof(*ar));
> +		memset(ar, 0, sizeof(ar));

Please look closer - I'm quite convinced that sizeof(ar) == sizeof(void *)
which gives not the desired effect. I have fixed this during the last
merge...

>  static int ide_check_media_change (kdev_t i_rdev)
> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
> --- /opt/kernel/linux-2.5.8/drivers/ide/ide-disk.c	2002-04-15 07:59:53.000000000 +0200
> +++ linux/drivers/ide/ide-disk.c	2002-04-15 10:20:33.000000000 +0200
> @@ -107,10 +107,7 @@
>  	 * 48-bit commands are pretty sanely laid out
>  	 */
>  	if (lba48bit) {
> -		if (cmd == READ)
> -			command = WIN_READ_EXT;
> -		else
> -			command = WIN_WRITE_EXT;
> +		command = cmd == READ ? WIN_READ_EXT : WIN_WRITE_EXT;

Checking with GCC will reveal that the former version doesn't
generate worser code...

>  	return command;
> @@ -895,24 +894,24 @@
>  
>  		__set_bit(i, &tag_mask);
>  		len += sprintf(out+len, "%d, ", i);
> -		if (ar->ar_time > max_jif)
> -			max_jif = ar->ar_time;
> +		if (cur_jif - ar->ar_time > max_jif)
> +			max_jif = cur_jif - ar->ar_time;

I disgust timer calculartions...- will have to look at a way
how to nap in a similar way eth drivers do.

> diff -urN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
> --- /opt/kernel/linux-2.5.8/drivers/ide/ide-dma.c	2002-04-15 07:59:53.000000000 +0200
> +++ linux/drivers/ide/ide-dma.c	2002-04-15 09:17:55.000000000 +0200
>
> +#endif /* CONFIG_BLK_DEV_IDE_TCQ */
>  
>  		case ide_dma_read:
>  			reading = 1 << 3;
>  		case ide_dma_write:
> -			ar = HWGROUP(drive)->rq->special;
> +			ar = IDE_CUR_AR(drive);

Ahhh!!! I'm gald to see this.


>  
>  static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
>  {
>  #ifdef IDE_TCQ_NIEN
> -	int mask = clear ? 0 : 2;
> +	int mask = clear ? 0 : 1 << 1;
????


> -			BUG_ON(drive->tcq->active_tag == -1);
> +			BUG_ON(drive->tcq->active_tag == IDE_INACTIVE_TAG);

IDE_IDLE_TAG would sound better I think... but no argument here.


> -#define IDE_CUR_AR(drive)	\
> -	((drive)->using_tcq ? IDE_CUR_TAG((drive)) : HWGROUP((drive))->rq->special)
> +#define IDE_CUR_AR(drive)	(HWGROUP((drive))->rq->special)

Ahh that's nice :-). Let's look further down how this coexists with ide-cd.c...


> -extern inline int ide_get_tag(ide_drive_t *drive)
> +static inline int ide_get_tag(ide_drive_t *drive)

OK. I have missed this one apparently.

ar_timer will make it at least esier to finish the ide-cd.c transition
to this data transport base.

Should I just quickly remerge this, so we can work further from
the same code base to ease the merging pain?

