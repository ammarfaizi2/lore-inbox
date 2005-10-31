Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVJaDtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVJaDtE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVJaDsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:48:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:12172 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751319AbVJaDsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:48:32 -0500
Message-ID: <43659404.6050605@pobox.com>
Date: Sun, 30 Oct 2005 22:48:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide-scsi highmem cleanup
References: <200510310302.j9V32hO4009277@hera.kernel.org>
In-Reply-To: <200510310302.j9V32hO4009277@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> tree c6016a8741a2527acac0ceb6e6ce431a798d6708
> parent f1fc78a8c7f3a784b9fd1e07cc1438a0ea569555
> author Andrew Morton <akpm@osdl.org> Mon, 31 Oct 2005 07:00:13 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 31 Oct 2005 09:37:17 -0800
> 
> [PATCH] ide-scsi highmem cleanup
> 
> It's not necessary to test PageHighmem in here - kmap_atomic() does the right
> thing.
> 
> Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/scsi/ide-scsi.c |   38 ++++++++++++--------------------------
>  1 files changed, 12 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
> --- a/drivers/scsi/ide-scsi.c
> +++ b/drivers/scsi/ide-scsi.c
> @@ -180,19 +180,12 @@ static void idescsi_input_buffers (ide_d
>  			return;
>  		}
>  		count = min(pc->sg->length - pc->b_count, bcount);
> -		if (PageHighMem(pc->sg->page)) {
> -			unsigned long flags;
> -
> -			local_irq_save(flags);
> -			buf = kmap_atomic(pc->sg->page, KM_IRQ0) + pc->sg->offset;
> -			drive->hwif->atapi_input_bytes(drive, buf + pc->b_count, count);
> -			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
> -			local_irq_restore(flags);
> -		} else {
> -			buf = page_address(pc->sg->page) + pc->sg->offset;
> -			drive->hwif->atapi_input_bytes(drive, buf + pc->b_count, count);
> -		}
> -		bcount -= count; pc->b_count += count;
> +		buf = kmap_atomic(pc->sg->page, KM_IRQ0);
> +		drive->hwif->atapi_input_bytes(drive,
> +				buf + pc->b_count + pc->sg->offset, count);
> +		kunmap_atomic(buf, KM_IRQ0);
> +		bcount -= count;
> +		pc->b_count += count;
>  		if (pc->b_count == pc->sg->length) {
>  			pc->sg++;
>  			pc->b_count = 0;
> @@ -212,19 +205,12 @@ static void idescsi_output_buffers (ide_
>  			return;
>  		}
>  		count = min(pc->sg->length - pc->b_count, bcount);
> -		if (PageHighMem(pc->sg->page)) {
> -			unsigned long flags;
> -
> -			local_irq_save(flags);
> -			buf = kmap_atomic(pc->sg->page, KM_IRQ0) + pc->sg->offset;
> -			drive->hwif->atapi_output_bytes(drive, buf + pc->b_count, count);
> -			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
> -			local_irq_restore(flags);
> -		} else {
> -			buf = page_address(pc->sg->page) + pc->sg->offset;
> -			drive->hwif->atapi_output_bytes(drive, buf + pc->b_count, count);
> -		}
> -		bcount -= count; pc->b_count += count;
> +		buf = kmap_atomic(pc->sg->page, KM_IRQ0);
> +		drive->hwif->atapi_output_bytes(drive,
> +				buf + pc->b_count + pc->sg->offset, count);
> +		kunmap_atomic(buf, KM_IRQ0);
> +		bcount -= count;
> +		pc->b_count += count;

Unless I'm missing something, this patch looks very wrong.

kmap_atomic(..., KM_IRQx) needs to be inside local_irq_save().

As such, the PageHighMem() does have clear benefits.

	Jeff


