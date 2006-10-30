Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161317AbWJ3Rus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWJ3Rus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWJ3Rur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:50:47 -0500
Received: from brick.kernel.dk ([62.242.22.158]:7199 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161317AbWJ3Ruq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:50:46 -0500
Date: Mon, 30 Oct 2006 18:52:25 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030175224.GB14055@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162225915.2948.49.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Arjan van de Ven wrote:
> 
> > > 
> > > 
> > >  [<c0219091>] cfq_set_request+0x351/0x3b0
> > >  [<c020c7fc>] elv_set_request+0x1c/0x40
> > >  [<c020fcff>] get_request+0x23f/0x270
> > >  [<c0210537>] get_request_wait+0x27/0x120
> > >  [<c02107ca>] __make_request+0x5a/0x350
> > >  [<c020f40f>] generic_make_request+0x16f/0x220
> > >  [<c02117e4>] submit_bio+0x64/0x110
> > > 
> > > now cfq_set_request() uses several inlines which muddies the situation,
> > > but lockdep claims one of them is not done correctly. (eg either it
> > > takes the lock incorrectly or something does spin_unlock_irq while the
> > > lock is held)
> > 
> > It's not really inlined trickery, the trace is exactly as printed.
> 
> what I meant is that cfq_set_request() calls a few inlines that also
> take locks so it might be one of those instead

I looked over them, and cfq_cic_link() should use _irqsave() instead of
_irq() if called without __GFP_WAIT set. That doesn't happen in the
normal io path though, so I'm not sure that is it.

So if the bug is using spin_lock_irq() with interrupts already disabled,
iirc that would trigger a different warning...

> >  A few
> > things may be allocated from that path, so we pass gfp_mask around. I'll
> > double check it tonight, but I don't currently see what could be wrong.
> > Would lockdep complain about:
> > 
> >         spin_lock_irqsave(lock, flags);
> >         ...
> >         spin_unlock_irq(lock);
> >         ...
> >         spin_lock_irq(lock);
> >         ...
> >         spin_unlock_irqrestore(lock, flags);
> 
> this is fine for lockdep IF and only IF there is no "out lock" held
> around this that requires irqs to be off. So if you do
> 
> spin_lock_irqsave(lock1, flags);
> ...
> spin_lock_irqsave(lock2, flags);
> spin_unlock_irq(lock2)
> ...
> 
> then lockdep WILL complain, and rightfully so, about a violation since
> lock1 gets violated here ;)

Naturally, that is a bug fair and simple, nothing to do with lockdep.


diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 4bae64e..da9bddf 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1355,6 +1355,7 @@ cfq_cic_link(struct cfq_data *cfqd, stru
 	struct rb_node **p;
 	struct rb_node *parent;
 	struct cfq_io_context *__cic;
+	unsigned long flags;
 	void *k;
 
 	cic->ioc = ioc;
@@ -1384,9 +1385,9 @@ restart:
 	rb_link_node(&cic->rb_node, parent, p);
 	rb_insert_color(&cic->rb_node, &ioc->cic_root);
 
-	spin_lock_irq(cfqd->queue->queue_lock);
+	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
 	list_add(&cic->queue_list, &cfqd->cic_list);
-	spin_unlock_irq(cfqd->queue->queue_lock);
+	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
 }
 
 /*

-- 
Jens Axboe

