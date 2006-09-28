Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWI1RvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWI1RvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWI1RvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:51:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030331AbWI1RvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:51:24 -0400
Date: Thu, 28 Sep 2006 10:51:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: Sujoy Gupta <sujoy@google.com>, LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       video4linux-list@redhat.com
Subject: Re: [PATCH] fix compiler warning in drivers/media/video/video-buf.c
Message-Id: <20060928105108.88b37304.akpm@osdl.org>
In-Reply-To: <451C070E.8080800@google.com>
References: <451C070E.8080800@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 10:31:58 -0700
Martin Bligh <mbligh@google.com> wrote:

> Using a double cast to avoid compiler warnings when
> building for PAE. Compiler doesn't like direct casting
> of a 32 bit ptr to 64 bit integer.
> 
> ...
>
> diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18/drivers/media/video/video-buf.c 2.6.18-videobuf/drivers/media/video/video-buf.c
> --- linux-2.6.18/drivers/media/video/video-buf.c	2006-06-17 18:49:35.000000000 -0700
> +++ 2.6.18-videobuf/drivers/media/video/video-buf.c	2006-09-28 10:28:54.000000000 -0700
> @@ -365,7 +365,12 @@ videobuf_iolock(struct videobuf_queue* q
>  		if (NULL == fbuf)
>  			return -EINVAL;
>  		/* FIXME: need sanity checks for vb->boff */
> -		bus   = (dma_addr_t)fbuf->base + vb->boff;
> +		/*
> +		 * Using a double cast to avoid compiler warnings when
> +		 * building for PAE. Compiler doesn't like direct casting 
> +		 * of a 32 bit ptr to 64 bit integer.
> +		 */
> +		bus   = (dma_addr_t)(size_t)fbuf->base + vb->boff;
>  		pages = PAGE_ALIGN(vb->size) >> PAGE_SHIFT;
>  		err = videobuf_dma_init_overlay(&vb->dma,PCI_DMA_FROMDEVICE,
>  						bus, pages);
> 

We normally cast pointers to unsigned long prior to assigning them to
64-bit values.  I'll make that change.

That being said, this driver is wrong to be storing dma addresses in a
void*.  And indeed there is a FIXME regarding this at
include/linux/videodev2.h:476, so I guess hiding this warning won't obscure
any fault which wasn't already known about..
