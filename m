Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWJ3QcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWJ3QcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWJ3QcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:32:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965019AbWJ3QcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:32:00 -0500
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20061030162621.GK4563@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk>
	 <1162220239.2948.27.camel@laptopd505.fenrus.org>
	 <20061030154444.GH4563@kernel.dk>
	 <1162225002.2948.45.camel@laptopd505.fenrus.org>
	 <20061030162621.GK4563@kernel.dk>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 17:31:55 +0100
Message-Id: <1162225915.2948.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > 
> >  [<c0219091>] cfq_set_request+0x351/0x3b0
> >  [<c020c7fc>] elv_set_request+0x1c/0x40
> >  [<c020fcff>] get_request+0x23f/0x270
> >  [<c0210537>] get_request_wait+0x27/0x120
> >  [<c02107ca>] __make_request+0x5a/0x350
> >  [<c020f40f>] generic_make_request+0x16f/0x220
> >  [<c02117e4>] submit_bio+0x64/0x110
> > 
> > now cfq_set_request() uses several inlines which muddies the situation,
> > but lockdep claims one of them is not done correctly. (eg either it
> > takes the lock incorrectly or something does spin_unlock_irq while the
> > lock is held)
> 
> It's not really inlined trickery, the trace is exactly as printed.

what I meant is that cfq_set_request() calls a few inlines that also
take locks so it might be one of those instead

>  A few
> things may be allocated from that path, so we pass gfp_mask around. I'll
> double check it tonight, but I don't currently see what could be wrong.
> Would lockdep complain about:
> 
>         spin_lock_irqsave(lock, flags);
>         ...
>         spin_unlock_irq(lock);
>         ...
>         spin_lock_irq(lock);
>         ...
>         spin_unlock_irqrestore(lock, flags);

this is fine for lockdep IF and only IF there is no "out lock" held
around this that requires irqs to be off. So if you do

spin_lock_irqsave(lock1, flags);
...
spin_lock_irqsave(lock2, flags);
spin_unlock_irq(lock2)
...

then lockdep WILL complain, and rightfully so, about a violation since
lock1 gets violated here ;)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

