Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSGXLu3>; Wed, 24 Jul 2002 07:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSGXLu3>; Wed, 24 Jul 2002 07:50:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65244 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316969AbSGXLu2>;
	Wed, 24 Jul 2002 07:50:28 -0400
Date: Wed, 24 Jul 2002 13:53:22 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
Message-ID: <20020724115322.GC5159@suse.de>
References: <Pine.SOL.4.30.0207241248380.17154-100000@mion.elka.pw.edu.pl> <3D3E90E4.3080108@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3E90E4.3080108@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Marcin Dalecki wrote:
> >>So look at drivers which call blk_start_queue() from within
> >>q->request_fn context, which is, well, causing deliberate *recursion*.
> >>
> >
> >
> >Are you sure? If so they should first check whether queue is
> >started/stopped, if they don't it is a bug.
> 
> void blk_start_queue(request_queue_t *q)
> {
>         if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
>                 unsigned long flags;
> 
> ================== possigle race here for qeue_flags BTW.
> 
>                 spin_lock_irqsave(q->queue_lock, flags);
>                 clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
> 
>                 if (!elv_queue_empty(q))
>                         q->request_fn(q);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> If we call it from within request_fn then if this isn't recursion on the
> kernel stack then I don't know...
> 
>                 spin_unlock_irqrestore(q->queue_lock, flags);
>         }
> }

Care to enlighten us on exactly which block drivers call
blk_start_queue() from request_fn?

-- 
Jens Axboe

