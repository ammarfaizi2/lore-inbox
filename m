Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWJ3QYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWJ3QYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWJ3QYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:24:43 -0500
Received: from brick.kernel.dk ([62.242.22.158]:22333 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964855AbWJ3QYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:24:43 -0500
Date: Mon, 30 Oct 2006 17:26:21 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030162621.GK4563@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162225002.2948.45.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Arjan van de Ven wrote:
> 
> > 
> > > so to me it looks like lockdep at least has the appearance of moaning
> > > about a reasonably fishy situation...
> > 
> > To me it looks more about lockdep complaining because it doesn't grok
> > the full picture. The question is how to shut it up.
> 
> ok that is quite possible. But I do think you read the original output
> incorrectly so let me at least phrase it in english:
> 
> 
> __queue_lock is used in softirq context like this:
>   [<c0361c59>] _spin_lock+0x29/0x40
>   [<c029fa24>] scsi_device_unbusy+0x64/0x90
>   [<c029a5bc>] scsi_finish_command+0x1c/0xa0
>   [<c02115c2>] blk_done_softirq+0x62/0x70
>   [<c0122a27>] __do_softirq+0x87/0x100
>   [<c0122af5>] do_softirq+0x55/0x60
>   [<c0122f3c>] ksoftirqd+0x7c/0xd0
>   [<c0130f76>] kthread+0xf6/0x100
> 
> which means that it always has to be taken _irq / _irqsave and one never
> can enable interrupts while holding this lock. This backtrace is from
> the first time the lock was taken in irq context.
> 
> Now a new situation has arisen that violates this constraint, and it
> looks like this:
> 
> 
>  [<c0219091>] cfq_set_request+0x351/0x3b0
>  [<c020c7fc>] elv_set_request+0x1c/0x40
>  [<c020fcff>] get_request+0x23f/0x270
>  [<c0210537>] get_request_wait+0x27/0x120
>  [<c02107ca>] __make_request+0x5a/0x350
>  [<c020f40f>] generic_make_request+0x16f/0x220
>  [<c02117e4>] submit_bio+0x64/0x110
> 
> now cfq_set_request() uses several inlines which muddies the situation,
> but lockdep claims one of them is not done correctly. (eg either it
> takes the lock incorrectly or something does spin_unlock_irq while the
> lock is held)

It's not really inlined trickery, the trace is exactly as printed. A few
things may be allocated from that path, so we pass gfp_mask around. I'll
double check it tonight, but I don't currently see what could be wrong.
Would lockdep complain about:

        spin_lock_irqsave(lock, flags);
        ...
        spin_unlock_irq(lock);
        ...
        spin_lock_irq(lock);
        ...
        spin_unlock_irqrestore(lock, flags);

? cfq will do that, but only if it knew that interrupts were currently
enabled when we originally made the _irqsave call (when __GFP_WAIT is
set).

> I get the impression you assumed lockdep was complaining about
> scsi_device_unbusy; but it's not; that function is only referenced since
> it's the first place since boot where the lock was taken in softirq
> context... not because the violation is occuring there.

Yeah, I read it in the reverse order. To be honest, the lockdep output
is not immediately parseable to me, I guess I need to read the
documentation.

-- 
Jens Axboe

