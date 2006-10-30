Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161337AbWJ3R4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbWJ3R4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWJ3R4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:56:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161337AbWJ3R4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:56:37 -0500
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20061030175224.GB14055@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk>
	 <1162220239.2948.27.camel@laptopd505.fenrus.org>
	 <20061030154444.GH4563@kernel.dk>
	 <1162225002.2948.45.camel@laptopd505.fenrus.org>
	 <20061030162621.GK4563@kernel.dk>
	 <1162225915.2948.49.camel@laptopd505.fenrus.org>
	 <20061030175224.GB14055@kernel.dk>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 18:56:33 +0100
Message-Id: <1162230993.2948.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > what I meant is that cfq_set_request() calls a few inlines that also
> > take locks so it might be one of those instead
> 
> I looked over them, and cfq_cic_link() should use _irqsave() instead of
> _irq() if called without __GFP_WAIT set. That doesn't happen in the
> normal io path though, so I'm not sure that is it.
> 
> So if the bug is using spin_lock_irq() with interrupts already disabled,
> iirc that would trigger a different warning...

it's not spin_lock_irq() that'll warn, but the unlock... :)

> Naturally, that is a bug fair and simple, nothing to do with lockdep.
> 
> 
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 4bae64e..da9bddf 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -1355,6 +1355,7 @@ cfq_cic_link(struct cfq_data *cfqd, stru
>  	structirely reason rb_node **p;
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

this looks entirely reasonable and correct

Acked-By: Arjan van de Ven <arjan@linux.intel.com>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

