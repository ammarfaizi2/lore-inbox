Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263367AbVBCRjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbVBCRjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbVBCRjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:39:07 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:28456 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263446AbVBCRhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:37:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KLyVeIpyx3mP2C3CHRSqZqTrIeGbloW60zNSSjlg1d7ZOTTMlZqRSJvkg+E0O0KBTtu/kzj7n4d0NW1jiMa4BJEyMZTpB5N05gjKcl8vLROYkDsKfsBG4RwKGS35yRf1cWuorqXcD2VkBwF3RKIh7yL8u41VBoiTXyfAuWJbjUs=
Message-ID: <58cb370e050203093726c7cf70@mail.gmail.com>
Date: Thu, 3 Feb 2005 18:37:04 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 23/29] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202030813.GH1187@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202030813.GH1187@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 12:08:13 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 23_ide_taskfile_task_ioctl.patch
> >
> >       ide_task_ioctl() modified to map to ide_taskfile_ioctl().
> >       This is the last user of REQ_DRIVE_TASK.

ide_task_ioctl() should map to taskfile transport not ide_taskfile_ioctl()

> Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> Index: linux-ide-export/drivers/ide/ide-taskfile.c
> ===================================================================
> --- linux-ide-export.orig/drivers/ide/ide-taskfile.c    2005-02-02 10:28:06.273027780 +0900
> +++ linux-ide-export/drivers/ide/ide-taskfile.c 2005-02-02 10:28:06.751950074 +0900
> @@ -778,30 +778,51 @@ abort:
>         return err;
>  }
> 
> -static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
> -{
> -       struct request rq;
> -
> -       ide_init_drive_cmd(&rq);
> -       rq.flags = REQ_DRIVE_TASK;
> -       rq.buffer = buf;
> -       return ide_do_drive_cmd(drive, &rq, ide_wait);
> -}
> -
> -/*
> - * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
> - */
>  int ide_task_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned long arg)
>  {
>         void __user *p = (void __user *)arg;
> -       int err = 0;
> -       u8 args[7], *argbuf = args;
> -       int argsize = 7;
> +       u8 args[7];
> +       ide_task_request_t task_req;
> +       task_ioreg_t *io_ports;
> +       mm_segment_t orig_fs;
> +       int ret;
> 
>         if (copy_from_user(args, p, 7))
>                 return -EFAULT;
> -       err = ide_wait_cmd_task(drive, argbuf);
> -       if (copy_to_user(p, argbuf, argsize))
> -               err = -EFAULT;
> -       return err;
> +
> +       memset(&task_req, 0, sizeof(task_req));
> +       task_req.out_flags.h.taskfile   = IDE_TASKFILE_STD_OUT_FLAGS;
> +       task_req.in_flags.h.taskfile    = IDE_TASKFILE_STD_IN_FLAGS;
> +
> +       io_ports = task_req.io_ports;
> +       io_ports[IDE_COMMAND_OFFSET]    = args[0];
> +       io_ports[IDE_FEATURE_OFFSET]    = args[1];
> +       io_ports[IDE_NSECTOR_OFFSET]    = args[2];
> +       io_ports[IDE_SECTOR_OFFSET]     = args[3];
> +       io_ports[IDE_LCYL_OFFSET]       = args[4];
> +       io_ports[IDE_HCYL_OFFSET]       = args[5];
> +       io_ports[IDE_SELECT_OFFSET]     = args[6];
> +
> +       task_req.req_cmd                = IDE_DRIVE_TASK_NO_DATA;
> +       task_req.data_phase             = TASKFILE_NO_DATA;
> +
> +       orig_fs = get_fs();
> +       set_fs(KERNEL_DS);
> +
> +       ret = ide_taskfile_ioctl(drive, cmd, (unsigned long)&task_req);
> +
> +       set_fs(orig_fs);

as HDIO_DRIVE_TASKFILE only supports no-data protocol
it should be easy to add missing bits here and get rid of calling
ide_taskfile_ioctl()

> +       args[0] = io_ports[IDE_COMMAND_OFFSET];
> +       args[1] = io_ports[IDE_FEATURE_OFFSET];
> +       args[2] = io_ports[IDE_NSECTOR_OFFSET];
> +       args[3] = io_ports[IDE_SECTOR_OFFSET];
> +       args[4] = io_ports[IDE_LCYL_OFFSET];
> +       args[5] = io_ports[IDE_HCYL_OFFSET];
> +       args[6] = io_ports[IDE_SELECT_OFFSET];
> +
> +       if (copy_to_user(p, args, 7))
> +               ret = -EFAULT;
> +
> +       return ret;
>  }
