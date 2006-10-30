Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161289AbWJ3Ryk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWJ3Ryk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161331AbWJ3Ryj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:54:39 -0500
Received: from rtr.ca ([64.26.128.89]:22534 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161243AbWJ3Ryi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:54:38 -0500
Message-ID: <45463C5B.7070900@rtr.ca>
Date: Mon, 30 Oct 2006 12:54:35 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk>
In-Reply-To: <20061030175224.GB14055@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> I looked over them, and cfq_cic_link() should use _irqsave() instead of
> _irq() if called without __GFP_WAIT set. That doesn't happen in the
> normal io path though, so I'm not sure that is it.
> 
> So if the bug is using spin_lock_irq() with interrupts already disabled,
> iirc that would trigger a different warning...
..

This seems 100% reproduceable here, so if there's any specific instrumentation
that might be useful, just let me know.  Meanwhile I'll try Jen's patch (below).

-ml

> 
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 4bae64e..da9bddf 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1355,6 +1355,7 @@ cfq_cic_link(struct cfq_data *cfqd, stru
>  	struct rb_node **p;
>  	struct rb_node *parent;
>  	struct cfq_io_context *__cic;
> +	unsigned long flags;
>  	void *k;
>  
>  	cic->ioc = ioc;
> @@ -1384,9 +1385,9 @@ restart:
>  	rb_link_node(&cic->rb_node, parent, p);
>  	rb_insert_color(&cic->rb_node, &ioc->cic_root);
>  
> -	spin_lock_irq(cfqd->queue->queue_lock);
> +	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
>  	list_add(&cic->queue_list, &cfqd->cic_list);
> -	spin_unlock_irq(cfqd->queue->queue_lock);
> +	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
>  }
