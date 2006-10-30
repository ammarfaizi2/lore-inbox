Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWJ3SPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWJ3SPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWJ3SPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:15:08 -0500
Received: from brick.kernel.dk ([62.242.22.158]:56937 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751539AbWJ3SPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:15:06 -0500
Date: Mon, 30 Oct 2006 19:16:46 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <liml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030181645.GF14055@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45464064.2090108@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Mark Lord wrote:
> Mark Lord wrote:
> >Jens Axboe wrote:
> ..
> >>diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> >>index 4bae64e..da9bddf 100644
> >>--- a/block/cfq-iosched.c
> >>+++ b/block/cfq-iosched.c
> ..
> 

I thought so. But at least we got an obscure bug fixed in the process
:-)

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
> 
> other info that might help us debug this:
> no locks held by startproc/4046.
> 
> stack backtrace:
> [<c0104042>] dump_trace+0x192/0x1c0
> [<c0104088>] show_trace_log_lvl+0x18/0x30
> [<c010483f>] show_trace+0xf/0x20
> [<c01049a5>] dump_stack+0x15/0x20
> [<c0137291>] print_usage_bug+0x251/0x270
> [<c0137ae7>] mark_lock+0x4b7/0x5f0
> [<c0138aae>] __lock_acquire+0x67e/0xc10
> [<c013939d>] lock_acquire+0x5d/0x80
> [<c0361c59>] _spin_lock+0x29/0x40
> [<c0219091>] cfq_set_request+0x351/0x3b0

Can you do:

$ gdb vmlinux
  l *cfq_set_request+0x351

assuming you built with DEBUG_INFO enabled.

-- 
Jens Axboe

