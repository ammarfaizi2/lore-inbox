Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWAYQ0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWAYQ0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWAYQ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:26:11 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:39268 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750852AbWAYQ0J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:26:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tq1KCd8pbmWdUoV5pb1x1cpRREcOZgO9qRQ6PZhi0QVe9zwQciQW+nuKUO1ItofLeN6duujJUJOh4i7FdRv/QkV1CmJGJQBhHePP2GugBHUUHhahHtIFkb8DpSE8ue5Fld/iqQQkIMJsk5JoMiW4gHiegZyfvuwdkyTEYiV/Irw=
Message-ID: <58cb370e0601250826m330984g576839345ed908de@mail.gmail.com>
Date: Wed, 25 Jan 2006 17:26:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Cc: Thomas Backlund <tmb@mandriva.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <43CD8E62.7060301@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051204011953.GA16381@havoc.gtf.org>
	 <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com>
	 <43987A28.8070509@mandriva.org> <439899B6.2000302@pobox.com>
	 <43B16B06.3000401@mandriva.org> <43CD8E62.7060301@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Thomas Backlund wrote:
> > Jeff Garzik wrote:
> >
> >> Thomas Backlund wrote:
> >>
> >>> Richard Bollinger wrote:
> >>>
> >>>>> ata1: BUG: SG size underflow
> >>>>> ata1: status=0x50 { DriveReady SeekComplete }
> >>>
> >>>
> >>>
> >>> and onde by one the raid devices got deactivated until the full
> >>> freeze...
> >>
> >>
> >>
> >> I think I know what's going on with the 'SG size underflow' thingy,
> >> give me a few days to come up with a fix.
> >>
> >>     Jeff
> >>
> >>
> >>
> > Any news on this?
> > or is it already fixed ?
>
> Back-burner for the moment :(

I think I have finally found the bug
after auditing the patch for x times...

+       /* Stop DMA, if doing DMA */
+       switch (qc->tf.protocol) {
+       case ATA_PROT_DMA:
+       case ATA_PROT_ATAPI_DMA:
+               ata_bmdma_stop(qc);

It should be sil_bmdma_stop()...

By accident ata_bmdma_stop() is OK for sil3112 so that would
explain why only people with sil3114 reported problems.

My theory is that using ata_bmdma_stop() for sil3114 results
in IRQs for port 2 and 3 not being delivered (because
SIL_INTR_STEERING bit is cleared) and we end up with
dma_stat_mask == 0.

Rest of the patch looks perfectly fine for me.  Could somebody
reporting problems with this patch retest with the above change?

+               break;
+       default:
+               /* do nothing */
+               break;
+       }

Bartlomiej
