Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUFVNrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUFVNrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUFVNrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:47:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:62630 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263656AbUFVNqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:46:17 -0400
Subject: Re: [PATCH] idle ide disk on resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20040622121742.GA1937@suse.de>
References: <20040622121742.GA1937@suse.de>
Content-Type: text/plain
Message-Id: <1087911565.22683.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 08:39:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 07:17, Jens Axboe wrote:
> Hi,
> 
> I need this patch to survive suspend on my powerbook, if the drive is
> sleeping when suspend is entered. Otherwise it freezes on resume when it
> tries to read from the drive.

Interesting, I didn't experience that, I suppose I never suspended the
machine with the disk sleeping ;)

Looks good though, Bart, can you submit to Linus / Andrew please ?

Ben.

> ===== drivers/ide/ide-disk.c 1.86 vs edited =====
> --- 1.86/drivers/ide/ide-disk.c	2004-06-05 22:15:29 +02:00
> +++ edited/drivers/ide/ide-disk.c	2004-06-22 14:15:08 +02:00
> @@ -1334,7 +1334,8 @@
>  	idedisk_pm_flush_cache	= ide_pm_state_start_suspend,
>  	idedisk_pm_standby,
>  
> -	idedisk_pm_restore_dma	= ide_pm_state_start_resume,
> +	idedisk_pm_idle		= ide_pm_state_start_resume,
> +	idedisk_pm_restore_dma,
>  };
>  
>  static void idedisk_complete_power_step (ide_drive_t *drive, struct request *rq, u8 stat, u8 error)
> @@ -1349,6 +1350,9 @@
>  	case idedisk_pm_standby:	/* Suspend step 2 (standby) complete */
>  		rq->pm->pm_step = ide_pm_state_completed;
>  		break;
> +	case idedisk_pm_idle:		/* resume step 1, idle drive */
> +		rq->pm->pm_step = idedisk_pm_restore_dma;
> +		break;
>  	}
>  }
>  
> @@ -1376,6 +1380,12 @@
>  		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args->handler	   = &task_no_data_intr;
> +		return do_rw_taskfile(drive, args);
> +
> +	case idedisk_pm_idle:
> +		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
> +		args->command_type = IDE_DRIVE_TASK_NO_DATA;
> +		args->handler = task_no_data_intr;
>  		return do_rw_taskfile(drive, args);
>  
>  	case idedisk_pm_restore_dma:	/* Resume step 1 (restore DMA) */
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

