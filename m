Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWJ3Oli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWJ3Oli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWJ3Oli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:41:38 -0500
Received: from brick.kernel.dk ([62.242.22.158]:58483 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751957AbWJ3Olh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:41:37 -0500
Date: Mon, 30 Oct 2006 15:43:16 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030144315.GG4563@kernel.dk>
References: <45460D52.3000404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45460D52.3000404@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Mark Lord wrote:
> =================================
> [ INFO: inconsistent lock state ]
> 2.6.19-rc3-git7-ml #3
> ---------------------------------
> inconsistent {in-softirq-W} -> {softirq-on-W} usage.
> startproc/4046 [HC0[0]:SC0[0]:HE1:SE1] takes:
> (&q->__queue_lock){-+..}, at: [<c0219091>] cfq_set_request+0x351/0x3b0
> {in-softirq-W} state was registered at:
>  [<c01376b1>] mark_lock+0x81/0x5f0
>  [<c0138a90>] __lock_acquire+0x660/0xc10
>  [<c013939d>] lock_acquire+0x5d/0x80
>  [<c0361c59>] _spin_lock+0x29/0x40
>  [<c029fa24>] scsi_device_unbusy+0x64/0x90
>  [<c029a5bc>] scsi_finish_command+0x1c/0xa0
>  [<c02115c2>] blk_done_softirq+0x62/0x70
>  [<c0122a27>] __do_softirq+0x87/0x100
>  [<c0122af5>] do_softirq+0x55/0x60
>  [<c0122f3c>] ksoftirqd+0x7c/0xd0
>  [<c0130f76>] kthread+0xf6/0x100
>  [<c0103c6f>] kernel_thread_helper+0x7/0x18
>  [<ffffffff>] 0xffffffff
> irq event stamp: 3331
> hardirqs last  enabled at (3331): [<c016326d>] kmem_cache_alloc+0x6d/0xa0
> hardirqs last disabled at (3330): [<c016321f>] kmem_cache_alloc+0x1f/0xa0
> softirqs last  enabled at (3012): [<c0122af5>] do_softirq+0x55/0x60
> softirqs last disabled at (2971): [<c0122af5>] do_softirq+0x55/0x60

Not sure what exactly is complained about here. The queue_lock must
always be grabbed with an irq disabling option, such as _irq or _irqsave
if potentially in interrupt context. I'm guessing it's the
scsi_device_unbusy() locking sequence that confuses it:

        spin_lock_irqsave(shost->host_lock, flags);
        ...
        spin_unlock(shost->host_lock);
        spin_lock(sdev->request_queue->queue_lock);
        ...
        spin_unlock_irqrestore(sdev->request_queue->queue_lock, flags);

which has always been considered safe, while not very pretty.

Ingo?

-- 
Jens Axboe

