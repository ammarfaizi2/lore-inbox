Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133105AbRANV3k>; Sun, 14 Jan 2001 16:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135439AbRANV3a>; Sun, 14 Jan 2001 16:29:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17675 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S133105AbRANV3W>;
	Sun, 14 Jan 2001 16:29:22 -0500
Message-ID: <3A621A27.685B985E@mandrakesoft.com>
Date: Sun, 14 Jan 2001 16:29:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: Roman.Hodek@informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make drivers/scsi/atari_scsi.c check request_irq (240p3)
In-Reply-To: <20010114195323.B602@jaquet.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> 
> Hi.
> 
> The following patch makes drivers/scsi/atari_scsi.c check request_irq's
> return code. It applies cleanly against 240p3 and ac9.
> 
> Comments?
> 
> --- linux-ac9/drivers/scsi/atari_scsi.c~        Tue Nov 28 02:57:34 2000
> +++ linux-ac9/drivers/scsi/atari_scsi.c Sun Jan 14 19:28:00 2001
> @@ -690,19 +690,27 @@
>                 /* This int is actually "pseudo-slow", i.e. it acts like a slow
>                  * interrupt after having cleared the pending flag for the DMA
>                  * interrupt. */
> -               request_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr, IRQ_TYPE_SLOW,
> -                           "SCSI NCR5380", scsi_tt_intr);
> +               if (!request_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr, IRQ_TYPE_SLOW,
> +                                "SCSI NCR5380", scsi_tt_intr)) {
> +                       printk(KERN_ERR "atari_scsi_detect: cannot allocate irq %d, aborting",IRQ_TT_MFP_SCSI);
> +                       atari_stram_free(atari_dma_buffer);
> +                       atari_dma_buffer = 0;
> +                       return 0;
> +               }

request_irq returns zero on success, not on failure.  Further, you need
to return the request_irq error value back to the caller, if possible.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
