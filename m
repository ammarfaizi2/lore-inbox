Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276298AbRI1UhK>; Fri, 28 Sep 2001 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276299AbRI1UhB>; Fri, 28 Sep 2001 16:37:01 -0400
Received: from cogito.cam.org ([198.168.100.2]:7721 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S276298AbRI1Ugs>;
	Fri, 28 Sep 2001 16:36:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: Patch to fix HP Colorado in 2.4 (RH #36628)
Date: Fri, 28 Sep 2001 16:31:31 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Pete Zaitcev <zaitcev@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010928203132.7ED5D14D48@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does seem to fix things for 2.4.10 too.  If the ide device for the
tape is using DMA your backups may not work correctly (last block incomplete).
This problem is documented in redhat bug 38404 where the problem is fixed
for PIO mode.  In my case the default (ie. no hdparm) results in DMA on... 

Ed Tomlinson

(HP Colorado 10/20G on hdd of a via MVP3 based board)

Pete Zaitcev wrote:

> Alan,
> 
> would you please to take this patch in. I am not sure it's 100% ok
> for Linus tree, but I want as many people as possible to test it,
> especially OnStream owners.
> 
> Thanks,
> -- Pete
> 
> ide-tape-03x.diff --------------------------------------
> 
> Removes extra buffer flush from read_position(), which confuses
> all versions of the HP Colorado.
> 
> Also touches up on insane logging.
> 
> --- linux-2.4.9/drivers/ide/ide-tape.c	Mon Aug 13 14:56:19 2001
> +++ linux-2.4.9-tape/drivers/ide/ide-tape.c	Wed Sep 26 16:18:11 2001
> @@ -429,8 +429,6 @@
>  #include <asm/bitops.h>
>  
>  
> -#define NO_LONGER_REQUIRED	(1)
> -
>  /*
>   *	OnStream support
>   */
> @@ -2101,10 +2099,6 @@
>  if (status.b.check && pc->c[0] == IDETAPE_REQUEST_SENSE_CMD)
>  status.b.check = 0;
>  if (status.b.check || test_bit (PC_DMA_ERROR, &pc->flags)) {	/* Error detected */
> -#if IDETAPE_DEBUG_LOG
> -			if (tape->debug_level >= 1)
> -				printk (KERN_INFO "ide-tape: %s: I/O error, ",tape->name);
> -#endif /* IDETAPE_DEBUG_LOG */
>  if (pc->c[0] == IDETAPE_REQUEST_SENSE_CMD) {
>  printk (KERN_ERR "ide-tape: I/O error in request sense command\n");
>  return ide_do_reset (drive);
> @@ -2178,7 +2172,7 @@
>  pc->current_position+=bcount.all;
>  #if IDETAPE_DEBUG_LOG
>  if (tape->debug_level >= 2)
> -		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes on that interrupt\n",
> pc->c[0], bcount.all);
> +		printk(KERN_INFO "ide-tape: [cmd %x] done %d\n", pc->c[0], bcount.all);
>  #endif
>  ide_set_handler (drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* And set the
>  interrupt handler again */ return ide_started;
> @@ -2297,7 +2291,7 @@
>  }
>  #if IDETAPE_DEBUG_LOG
>  if (tape->debug_level >= 2)
> -		printk (KERN_INFO "ide-tape: Retry number - %d\n", pc->retries);
> +		printk (KERN_INFO "ide-tape: Retry number - %d, [cmd %x]\n", pc->retries, pc->c[0]);
>  #endif /* IDETAPE_DEBUG_LOG */
>  
>  pc->retries++;
> @@ -2472,7 +2466,8 @@
>  status.all = GET_STAT();
>  if (status.b.dsc) {
>  if (status.b.check) {					/* Error detected */
> -			printk (KERN_ERR "ide-tape: %s: I/O error, ",tape->name);
> +			printk (KERN_ERR "ide-tape: %s: I/O error: pc = %2x, key = %2x, asc = %2x, ascq =
> %2x\n",
> +					tape->name, pc->c[0], tape->sense_key, tape->asc, tape->ascq);
>  return idetape_retry_pc (drive);			/* Retry operation */
>  }
>  pc->error = 0;
> @@ -3096,10 +3091,10 @@
>  idetape_tape_t *tape = drive->driver_data;
>  idetape_read_position_result_t *result;
>  
> -//#if IDETAPE_DEBUG_LOG
> -//	if (tape->debug_level >= 4)
> +#if IDETAPE_DEBUG_LOG
> +	if (tape->debug_level >= 4)
>  printk (KERN_INFO "ide-tape: Reached idetape_read_position_callback\n");
> -//#endif /* IDETAPE_DEBUG_LOG */
> +#endif /* IDETAPE_DEBUG_LOG */
>  
>  if (!tape->pc->error) {
>  result = (idetape_read_position_result_t *) tape->pc->buffer;
> @@ -3273,30 +3268,15 @@
>  idetape_pc_t pc;
>  int position;
>  
> -//#if IDETAPE_DEBUG_LOG
> -//        if (tape->debug_level >= 4)
> -	printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
> -//#endif /* IDETAPE_DEBUG_LOG */
> +#if IDETAPE_DEBUG_LOG
> +	if (tape->debug_level >= 4)
> +		printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
> +#endif /* IDETAPE_DEBUG_LOG */
>  
> -#ifdef NO_LONGER_REQUIRED
> -	idetape_flush_tape_buffers(drive);
> -#endif
>  idetape_create_read_position_cmd(&pc);
>  if (idetape_queue_pc_tail (drive, &pc))
>  return -1;
>  position = tape->first_frame_position;
> -#ifdef NO_LONGER_REQUIRED
> -	if (tape->onstream) {
> -		if ((position != tape->last_frame_position - tape->blocks_in_buffer) &&
> -		    (position != tape->last_frame_position + tape->blocks_in_buffer)) {
> -			if (tape->blocks_in_buffer == 0) {
> -				printk("ide-tape: %s: correcting read position %d, %d, %d\n", tape->name, position,
> tape->last_frame_position, tape->blocks_in_buffer);
> -				position = tape->last_frame_position;
> -				tape->first_frame_position = position;
> -			}
> -		}
> -	}
> -#endif
>  return position;
>  }

