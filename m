Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262228AbTCMKSE>; Thu, 13 Mar 2003 05:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbTCMKSE>; Thu, 13 Mar 2003 05:18:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57550 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262228AbTCMKSC>;
	Thu, 13 Mar 2003 05:18:02 -0500
Date: Thu, 13 Mar 2003 11:28:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Joe Korty <joe.korty@ccur.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
Message-ID: <20030313102854.GC827@suse.de>
References: <200303122213.WAA17415@rudolph.ccur.com> <20030313092601.GB827@suse.de> <200303131126.17963.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303131126.17963.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Marc-Christian Petersen wrote:
> On Thursday 13 March 2003 10:26, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > There's a tiny bit missing from your patch:
> > > -	 * it's a highmem page
> > > -	 */
> > > -	__cli();
> > > +	local_irq_save(*flags);
> >
> > 	local_irq_disable();
> >
> > >  	addr = (unsigned long) kmap_atomic(bh->b_page, KM_BH_IRQ);
> > >
> > > -	if (addr & ~PAGE_MASK)
> > > -		BUG();
> > > +	BUG_ON (addr & ~PAGE_MASK);
> > >
> > >  	return (char *) addr + bh_offset(bh);
> > >  }
> > > @@ -58,7 +46,7 @@
> > >  	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
> > >
> > >  	kunmap_atomic((void *) ptr, KM_BH_IRQ);
> > > -	__restore_flags(*flags);
> > > +	local_irq_restore(*flags);
> 	local_irq_enable();
> 
> ^ isn't this missing too with your suggested one-liner?

no, the local_irq_restore() brings back the irq flags from before we did
the irq disable. if interrupts were disabled before bh_kmap_irq() was
called, we must not enable them. basically, maintain the same flags.

-- 
Jens Axboe

