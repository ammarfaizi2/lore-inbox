Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965360AbWJ3SCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbWJ3SCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWJ3SCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:02:19 -0500
Received: from brick.kernel.dk ([62.242.22.158]:58418 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932466AbWJ3SCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:02:18 -0500
Date: Mon, 30 Oct 2006 19:03:57 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030180357.GD14055@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <20061030175400.GA31581@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030175400.GA31581@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Ingo Molnar wrote:
> 
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > > > things may be allocated from that path, so we pass gfp_mask around. I'll
> > > > double check it tonight, but I don't currently see what could be wrong.
> > > > Would lockdep complain about:
> > > > 
> > > >         spin_lock_irqsave(lock, flags);
> > > >         ...
> > > >         spin_unlock_irq(lock);
> > > >         ...
> > > >         spin_lock_irq(lock);
> > > >         ...
> > > >         spin_unlock_irqrestore(lock, flags);
> > > 
> > > this is fine for lockdep IF and only IF there is no "out lock" held
> > > around this that requires irqs to be off. So if you do
> > > 
> > > spin_lock_irqsave(lock1, flags);
> > > ...
> > > spin_lock_irqsave(lock2, flags);
> > > spin_unlock_irq(lock2)
> > > ...
> > > 
> > > then lockdep WILL complain, and rightfully so, about a violation since
> > > lock1 gets violated here ;)
> > 
> > Naturally, that is a bug fair and simple, nothing to do with lockdep.
> 
> well, finding such locking bugs is the main purpose of lockdep, so there 
> is at least some connection i'd say ;-)

Right, I'm totally with you on that one, I wasn't trying to state
otherwise :-)

But we've also had a class of lockdep complaints that simply need some
sort of annotation so that lockdep understands there's nothing wrong
with it.

-- 
Jens Axboe

