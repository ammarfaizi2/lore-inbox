Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUFKQsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUFKQsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUFKQql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:46:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33512 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264247AbUFKQpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:45:10 -0400
Date: Fri, 11 Jun 2004 18:45:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [7/12]
Message-ID: <20040611164501.GA4309@suse.de>
References: <200406111759.54209.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406111759.54209.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> [PATCH] ide: fix ide-cd to not retry REQ_DRIVE_TASKFILE requests
> 
> 'cat /proc/ide/hdx/identify' generates REQ_DRIVE_TASKFILE request
> (for WIN_PIDENTIFY command) even for devices controlled by ide-cd.
> 
> All other drivers don't retry such requests.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
> 
>  linux-2.6.7-rc3-bzolnier/drivers/ide/ide-cd.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/ide/ide-cd.c~ide_cdrom_taskfile drivers/ide/ide-cd.c
> --- linux-2.6.7-rc3/drivers/ide/ide-cd.c~ide_cdrom_taskfile	2004-06-10 23:01:31.725338592 +0200
> +++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-cd.c	2004-06-10 23:01:31.731337680 +0200
> @@ -574,7 +574,7 @@ ide_startstop_t ide_cdrom_error (ide_dri
>  	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
>  		return ide_stopped;
>  	/* retry only "normal" I/O: */
> -	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
> +	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
>  		rq->errors = 1;
>  		ide_end_drive_cmd(drive, stat, err);
>  		return ide_stopped;

Was wondering whether it was clearer to use !blk_fs_request() instead,
but that would need looking at REQ_PC and REQ_BLOCK_PC. So for now the
above is fine with me, if you include ide_cdrom_abort() as well.

-- 
Jens Axboe

