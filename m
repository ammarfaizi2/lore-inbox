Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVB0Hgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVB0Hgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 02:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVB0Hgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 02:36:39 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:39212 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261356AbVB0HgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 02:36:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=kHafV5l1IhFBgX+a4LsozemdEGFo1IWyhE28ickbwQ08K/5AxIZTPC4W4WSONyY2g3LjHf3g/nfb9q+78VE+nvIWcn0c2wYI92QjBpyqwSrTKSswWxTTVKQZOD2jDIoBZ/g8oEBBjjMf+G6j7drF12sHWIfQTbfzJl/jWHnbHUE=
Date: Sun, 27 Feb 2005 16:36:09 +0900
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Message-ID: <20050227073608.GA30796@htj.dyndns.org>
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.6+20040907i
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

 This patch should be modified to use flagged taskfile if the
task_end_request_fix patch isn't applied.  As non-flagged taskfile
won't return valid result registers, TASK ioctl users won't get the
correct register output.

 IMHO, this flag-to-get-result-registers thing is way too subtle.  How
about keeping old behavior by just not copying out register outputs in
ide_taskfile_ioctl() in applicable cases instead of not reading
registers when ending commands?  That is, unless there's some
noticeable performance impacts I'm not aware of.

 Thanks.

On Thu, Feb 24, 2005 at 03:48:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> ide_task_ioctl() rewritten to use taskfile transport.
> This is the last user of REQ_DRIVE_TASK.
> 
> bart: ported to recent IDE changes by me
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> --- a/drivers/ide/ide-taskfile.c	2005-02-24 15:30:02 +01:00
> +++ b/drivers/ide/ide-taskfile.c	2005-02-24 15:30:02 +01:00
> @@ -777,30 +777,42 @@
>  	return err;
>  }
> 
> -static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
> -{
> -	struct request rq;
> -
> -	ide_init_drive_cmd(&rq);
> -	rq.flags = REQ_DRIVE_TASK;
> -	rq.buffer = buf;
> -	return ide_do_drive_cmd(drive, &rq, ide_wait);
> -}
> -
> -/*
> - * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
> - */
> -int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
> +int ide_task_ioctl(ide_drive_t *drive, unsigned int cmd, unsigned long arg)
>  {
>  	void __user *p = (void __user *)arg;
> -	int err = 0;
> -	u8 args[7], *argbuf = args;
> -	int argsize = 7;
> +	int err;
> +	u8 args[7];
> +	ide_task_t task;
> +	struct ata_taskfile *tf = &task.tf;
> 
>  	if (copy_from_user(args, p, 7))
>  		return -EFAULT;
> -	err = ide_wait_cmd_task(drive, argbuf);
> -	if (copy_to_user(p, argbuf, argsize))
> +
> +	memset(&task, 0, sizeof(task));
> +
> +	tf->command	= args[0];
> +	tf->feature	= args[1];
> +	tf->nsect	= args[2];
> +	tf->lbal	= args[3];
> +	tf->lbam	= args[4];
> +	tf->lbah	= args[5];
> +	tf->device	= args[6];
> +
> +	task.command_type = IDE_DRIVE_TASK_NO_DATA;
> +	task.data_phase = TASKFILE_NO_DATA;
> +	task.handler = &task_no_data_intr;
> +
> +	err = ide_diag_taskfile(drive, &task, 0, NULL);
> +
> +	args[0] = tf->command;
> +	args[1] = tf->feature;
> +	args[2] = tf->nsect;
> +	args[3] = tf->lbal;
> +	args[4] = tf->lbam;
> +	args[5] = tf->lbah;
> +	args[6] = tf->device;
> +
> +	if (copy_to_user(p, args, 7))
>  		err = -EFAULT;
>  	return err;
>  }

-- 
tejun

