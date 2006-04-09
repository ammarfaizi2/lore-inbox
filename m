Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWDIUdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWDIUdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWDIUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:33:10 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:19549 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750936AbWDIUdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:33:09 -0400
Date: Sun, 09 Apr 2006 15:12:56 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: 2.6.17-rc1-mm2: badness in 3w_xxxx driver
In-reply-to: <20060409113240.630b9a24.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Mail-followup-to: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <20060409191256.GA4609@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060409182306.GA4680@nickolas.homeunix.com>
 <20060409113240.630b9a24.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 11:32:40AM -0700, Andrew Morton wrote:
> Nick Orlov <bugfixer@list.ru> wrote:
> >
> > The following patch: x86-kmap_atomic-debugging.patch exposed a badness
> > in 3w_xxx driver.
> 
> Sweet, thanks.
> 
[[ skipped ]]
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> We must disable local IRQs while holding KM_IRQ0 or KM_IRQ1.  Otherwise, an
> IRQ handler could use those kmap slots while this code is using them,
> resulting in memory corruption.
> 
> Thanks to Nick Orlov <bugfixer@list.ru> for reporting.
> 
> Cc: <linuxraid@amcc.com>
> Cc: James Bottomley <James.Bottomley@SteelEye.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/scsi/3w-xxxx.c |    3 +++
>  1 files changed, 3 insertions(+)
> 
> diff -puN drivers/scsi/3w-xxxx.c~3ware-kmap_atomic-fix drivers/scsi/3w-xxxx.c
> --- devel/drivers/scsi/3w-xxxx.c~3ware-kmap_atomic-fix	2006-04-09 11:28:08.000000000 -0700
> +++ devel-akpm/drivers/scsi/3w-xxxx.c	2006-04-09 11:29:21.000000000 -0700
> @@ -1508,10 +1508,12 @@ static void tw_transfer_internal(TW_Devi
>  	struct scsi_cmnd *cmd = tw_dev->srb[request_id];
>  	void *buf;
>  	unsigned int transfer_len;
> +	unsigned long flags = 0;
>  
>  	if (cmd->use_sg) {
>  		struct scatterlist *sg =
>  			(struct scatterlist *)cmd->request_buffer;
> +		local_irq_save(flags);
>  		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
>  		transfer_len = min(sg->length, len);
>  	} else {
> @@ -1526,6 +1528,7 @@ static void tw_transfer_internal(TW_Devi
>  
>  		sg = (struct scatterlist *)cmd->request_buffer;
>  		kunmap_atomic(buf - sg->offset, KM_IRQ0);
> +		local_irq_restore(flags);
>  	}
>  }
>  
> _

Confirmed, this patch solves the "badness" problem for me.
I still experiencing a weird hangs though (the box just hangs, no
messages on console/syslog, nothing). I'll try to nail it down.

2.6.16-mm2 works like a charm with the same config.
Do you know which patches should I try to revert first?

-- 
With best wishes,
	Nick Orlov.

