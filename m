Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTDQTgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTDQTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:36:13 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:38743 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261380AbTDQTgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:36:12 -0400
Message-ID: <3E9F0294.8040802@myrealbox.com>
Date: Thu, 17 Apr 2003 12:37:56 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <fa.cde0mrb.127uv05@ifi.uio.no> <fa.i9on98t.1gg0toj@ifi.uio.no>
In-Reply-To: <fa.i9on98t.1gg0toj@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

> ...There was a missing call to scsi_queue_next_request for door locking (the
> ioctl in the scsi log output, ALLOW_MEDIUM_REMOVAL value 30, or 0x1e),
> Mike A posted this patch to linux-scsi in response to some debugging leg
> work of Alan Stern, does this fix your problem?
> 
> Not sure if it patches clean against 2.5.67, but it's pretty simple.
> 
> DESC
> The patch adds a call to scsi_queue_next_request from scsi_release_request. It
> also removes a call in scsi_eh_lock_done to scsi_put_command.
> scsi_release_request will do a call to scsi_put_command if needed.
> EDESC
> 
> 
>  drivers/scsi/scsi.c       |    2 ++
>  drivers/scsi/scsi_error.c |    4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff -puN drivers/scsi/scsi.c~scsi-release-req drivers/scsi/scsi.c
> --- sysfs-bleed-2.5/drivers/scsi/scsi.c~scsi-release-req	Mon Apr 14 15:34:14 2003
> +++ sysfs-bleed-2.5-andmike/drivers/scsi/scsi.c	Mon Apr 14 15:34:14 2003
> @@ -224,8 +224,10 @@ void scsi_release_request(Scsi_Request *
>  {
>  	if( req->sr_command != NULL )
>  	{
> +    		request_queue_t *q = req->sr_device->request_queue;
>  		scsi_put_command(req->sr_command);
>  		req->sr_command = NULL;
> +		scsi_queue_next_request(q, NULL);
>  	}
>  
>  	kfree(req);
> diff -puN drivers/scsi/scsi_error.c~scsi-release-req drivers/scsi/scsi_error.c
> --- sysfs-bleed-2.5/drivers/scsi/scsi_error.c~scsi-release-req	Mon Apr 14 15:34:14 2003
> +++ sysfs-bleed-2.5-andmike/drivers/scsi/scsi_error.c	Mon Apr 14 15:34:14 2003
> @@ -1334,10 +1334,6 @@ static void scsi_eh_lock_done(struct scs
>  {
>  	struct scsi_request *sreq = scmd->sc_request;
>  
> -	scmd->sc_request = NULL;
> -	sreq->sr_command = NULL;
> -
> -	scsi_put_command(scmd);
>  	scsi_release_request(sreq);
>  }

Yes!  I can now eject and re-insert a Zip disk in the drive and re-mount 
it as many times as I wish.

I did need to remove the 'static' (as posted by Gert) before I could 
compile the kernel, but otherwise it seems perfect.

You guys are great, thanks!

