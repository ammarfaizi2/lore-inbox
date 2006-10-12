Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWJLMir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWJLMir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWJLMir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:38:47 -0400
Received: from mail.gmx.de ([213.165.64.20]:1475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750958AbWJLMiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:38:46 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
In-Reply-To: <20061012122146.GS6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov>
	 <20061012065346.GY6515@kernel.dk>
	 <1160648885.5897.6.camel@Homer.simpson.net>
	 <1160662435.6177.3.camel@Homer.simpson.net>
	 <20061012120927.GQ6515@kernel.dk>  <20061012122146.GS6515@kernel.dk>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 14:44:50 +0000
Message-Id: <1160664290.6207.2.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 14:21 +0200, Jens Axboe wrote:

> Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
> think it should fix it.

Yup, all better here.  Thanks.

	-Mike

> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 69bbb62..e7513e5 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -597,7 +597,7 @@ static void cdrom_prepare_request(ide_dr
>  	struct cdrom_info *cd = drive->driver_data;
>  
>  	ide_init_drive_cmd(rq);
> -	rq->cmd_type = REQ_TYPE_BLOCK_PC;
> +	rq->cmd_type = REQ_TYPE_ATA_PC;
>  	rq->rq_disk = cd->disk;
>  }
>  
> @@ -2023,7 +2023,8 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
>  		}
>  		info->last_block = block;
>  		return action;
> -	} else if (rq->cmd_type == REQ_TYPE_SENSE) {
> +	} else if (rq->cmd_type == REQ_TYPE_SENSE ||
> +		   rq->cmd_type == REQ_TYPE_ATA_PC) {
>  		return cdrom_do_packet_command(drive);
>  	} else if (blk_pc_request(rq)) {
>  		return cdrom_do_block_pc(drive, rq);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 26f7856..d370d2c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -157,6 +157,7 @@ enum rq_cmd_type_bits {
>  	REQ_TYPE_ATA_CMD,
>  	REQ_TYPE_ATA_TASK,
>  	REQ_TYPE_ATA_TASKFILE,
> +	REQ_TYPE_ATA_PC,
>  };
>  
>  /*
> 

