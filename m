Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWILAOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWILAOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWILAOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:14:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:47764 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965199AbWILAOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:14:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QGwZ49U6SREClU/PbiEujY5kyKXGBO5sa2txVQ/eMBAbfpL2unpTo8OOMeOMNDgp4bjLrBig5j3p/Mgx81qKDtEUbLaDOpXWDvBO4UMt16MbrZX9lCtwc5GHwDMrgy7wpp5nxJA2Nqp5wNW4qwKgU36x1qMXlzM03as5icf0xvw=
Message-ID: <e9c3a7c20609111714h1b88f8cbid99c567d7f3e997c@mail.gmail.com>
Date: Mon, 11 Sep 2006 17:14:44 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH 08/19] dmaengine: enable multiple clients and operations
Cc: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
In-Reply-To: <4505F4D0.7010901@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	 <4505F4D0.7010901@garzik.org>
X-Google-Sender-Auth: 026a85abe371c215
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/06, Jeff Garzik <jeff@garzik.org> wrote:
> Dan Williams wrote:
> > @@ -759,8 +755,10 @@ #endif
> >       device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
> >       device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
> >       device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
> > -     device->common.device_memcpy_complete = ioat_dma_is_complete;
> > -     device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
> > +     device->common.device_operation_complete = ioat_dma_is_complete;
> > +     device->common.device_xor_pgs_to_pg = dma_async_xor_pgs_to_pg_err;
> > +     device->common.device_issue_pending = ioat_dma_memcpy_issue_pending;
> > +     device->common.capabilities = DMA_MEMCPY;
>
>
> Are we really going to add a set of hooks for each DMA engine whizbang
> feature?

What's the alternative?  But, also see patch 9 "dmaengine: reduce
backend address permutations" it relieves some of this pain.

>
> That will get ugly when DMA engines support memcpy, xor, crc32, sha1,
> aes, and a dozen other transforms.
>
>
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index c94d8f1..3599472 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -20,7 +20,7 @@
> >   */
> >  #ifndef DMAENGINE_H
> >  #define DMAENGINE_H
> > -
> > +#include <linux/config.h>
> >  #ifdef CONFIG_DMA_ENGINE
> >
> >  #include <linux/device.h>
> > @@ -65,6 +65,27 @@ enum dma_status {
> >  };
> >
> >  /**
> > + * enum dma_capabilities - DMA operational capabilities
> > + * @DMA_MEMCPY: src to dest copy
> > + * @DMA_XOR: src*n to dest xor
> > + * @DMA_DUAL_XOR: src*n to dest_diag and dest_horiz xor
> > + * @DMA_PQ_XOR: src*n to dest_q and dest_p gf/xor
> > + * @DMA_MEMCPY_CRC32C: src to dest copy and crc-32c sum
> > + * @DMA_SHARE: multiple clients can use this channel
> > + */
> > +enum dma_capabilities {
> > +     DMA_MEMCPY              = 0x1,
> > +     DMA_XOR                 = 0x2,
> > +     DMA_PQ_XOR              = 0x4,
> > +     DMA_DUAL_XOR            = 0x8,
> > +     DMA_PQ_UPDATE           = 0x10,
> > +     DMA_ZERO_SUM            = 0x20,
> > +     DMA_PQ_ZERO_SUM         = 0x40,
> > +     DMA_MEMSET              = 0x80,
> > +     DMA_MEMCPY_CRC32C       = 0x100,
>
> Please use the more readable style that explicitly lists bits:
>
>         DMA_MEMCPY              = (1 << 0),
>         DMA_XOR                 = (1 << 1),
>         ...
I prefer this as well, although at one point I was told (not by you)
the absolute number was preferred when I was making changes to
drivers/scsi/sata_vsc.c.  In any event I'll change it...

>
> > +/**
> >   * struct dma_chan_percpu - the per-CPU part of struct dma_chan
> >   * @refcount: local_t used for open-coded "bigref" counting
> >   * @memcpy_count: transaction counter
> > @@ -75,27 +96,32 @@ struct dma_chan_percpu {
> >       local_t refcount;
> >       /* stats */
> >       unsigned long memcpy_count;
> > +     unsigned long xor_count;
> >       unsigned long bytes_transferred;
> > +     unsigned long bytes_xor;
>
> Clearly, each operation needs to be more compartmentalized.
>
> This just isn't scalable, when you consider all the possible transforms.
Ok, one set of counters per op is probably overkill what about lumping
operations into groups and just tracking at the group level? i.e.

memcpy, memset -> string_count, string_bytes_transferred
crc, sha1, aes -> hash_count, hash_transferred
xor, pq_xor -> sum_count, sum_transferred

>
>         Jeff

Dan
