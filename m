Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWIBAIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWIBAIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWIBAIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 20:08:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbWIBAIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 20:08:41 -0400
Date: Fri, 1 Sep 2006 17:08:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Lee Trager <Lee@PicturesInMotion.net>, Alan Cox <alan@redhat.com>
Subject: Re: 2.6.18-rc5-mm1 (IDE resume regression)
Message-Id: <20060901170809.89e5e41f.akpm@osdl.org>
In-Reply-To: <200609020113.23965.rjw@sisk.pl>
References: <20060901015818.42767813.akpm@osdl.org>
	<200609020113.23965.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006 01:13:23 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday 01 September 2006 10:58, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> > 
> > 
> > - CONFIG_BLOCK=n is bust due to
> >   writeback_congestion_end()/blk_congestion_end() snafu.  We'll fix it later.
> 
> I need the appended patch to prevent my box from crashing during suspend to
> disk (in the resume-during-suspend phase).
> 
> Apparently, the pointer returned by to_ide_driver() in generic_ide_resume()
> is completely bogous, although it's nonzero, and a NULL pointer dereference
> occurs when drv->resume is evaluated (100% of the time on my box).
> 

OK, thanks.  That's ide-hpa-resume-fix.patch

> Index: linux-2.6.18-rc5-mm1/drivers/ide/ide.c
> ===================================================================
> --- linux-2.6.18-rc5-mm1.orig/drivers/ide/ide.c
> +++ linux-2.6.18-rc5-mm1/drivers/ide/ide.c
> @@ -1235,11 +1235,9 @@ static int generic_ide_suspend(struct de
>  static int generic_ide_resume(struct device *dev)
>  {
>  	ide_drive_t *drive = dev->driver_data;
> -	ide_driver_t *drv = to_ide_driver(dev->driver);
>  	struct request rq;
>  	struct request_pm_state rqpm;
>  	ide_task_t args;
> -	int err;
>  
>  	memset(&rq, 0, sizeof(rq));
>  	memset(&rqpm, 0, sizeof(rqpm));
> @@ -1250,12 +1248,7 @@ static int generic_ide_resume(struct dev
>  	rqpm.pm_step = ide_pm_state_start_resume;
>  	rqpm.pm_state = PM_EVENT_ON;
>  
> -	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
> -
> -	if (err == 0 && drv->resume)
> -		drv->resume(drive);
> -
> -	return err;
> +	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
>  }
>  
>  int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,


And the above reverts most of it.  It looks like we'll need to
have another go at that one.  I'll drop it.

-- 
VGER BF report: H 0
