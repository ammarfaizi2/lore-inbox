Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVBFTTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVBFTTH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBFTTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:19:06 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:495 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261289AbVBFTI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:08:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZsnTrSRSzjXocDkqlXBA28oZjNGlTgCKweb9OzoALTFlzS3b44z4DFgVEhcXUc4KytZCWrMl6zti5brLV+RdYtT7pVaUe9C9IbBHeusCZ3PYHRUtyJfA9xfYa45L0j1kann+Mjc7YrM7bpXMAeShHOLN9mQ1u9v5WBjbYssH2oc=
Message-ID: <58cb370e05020611081a604a45@mail.gmail.com>
Date: Sun, 6 Feb 2005 20:08:53 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 04/09] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050205102843.93952132701@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42049F20.7020706@home-tj.org>
	 <20050205102843.93952132701@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot about this one...

> @@ -55,22 +55,19 @@
>  #include <asm/io.h>
>  #include <asm/bitops.h>
> 
> -static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
> +void ide_init_flush_task(ide_drive_t *drive, ide_task_t *args)
>  {
> -       char *buf = rq->cmd;
> -
> -       /*
> -        * reuse cdb space for ata command
> -        */
> -       memset(buf, 0, sizeof(rq->cmd));
> -
> -       rq->flags = REQ_DRIVE_TASK | REQ_STARTED;
> -       rq->buffer = buf;
> -       rq->buffer[0] = WIN_FLUSH_CACHE;
> +       memset(args, 0, sizeof(*args));
> 
>         if (ide_id_has_flush_cache_ext(drive->id) &&
>             (drive->capacity64 >= (1UL << 28)))
> -               rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
> +               args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
> +       else
> +               args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
> +
> +       args->command_type = IDE_DRIVE_TASK_NO_DATA;
> +       args->data_phase = TASKFILE_NO_DATA;
> +       args->handler = task_no_data_intr;
>  }

Isn't EXPORT_SYMBOL_{GPL} needed for ide_init_flush_task()?
