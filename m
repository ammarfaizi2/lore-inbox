Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSGXMi1>; Wed, 24 Jul 2002 08:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSGXMi1>; Wed, 24 Jul 2002 08:38:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43138 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317063AbSGXMiZ>;
	Wed, 24 Jul 2002 08:38:25 -0400
Date: Wed, 24 Jul 2002 14:41:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
Message-ID: <20020724124124.GA15201@suse.de>
References: <3D3E90E4.3080108@evision.ag> <Pine.SOL.4.30.0207241423190.15605-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207241423190.15605-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Bartlomiej Zolnierkiewicz wrote:
> > void blk_start_queue(request_queue_t *q)
> > {
> >          if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> >                  unsigned long flags;
> >
> > ================== possigle race here for qeue_flags BTW.
> >
> >                  spin_lock_irqsave(q->queue_lock, flags);
> >                  clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
> >
> >                  if (!elv_queue_empty(q))
> >                          q->request_fn(q);
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > If we call it from within request_fn then if this isn't recursion on the
> > kernel stack then I don't know...
> 
> You really don't know.
> 
> And funny thing is I have diffirent blk_start_queue() function in my tree
> (2.5.27) ? Without described above race and without possibilty of
> recursion...
> 
> 2.5.27:drivers/block/ll_rw_blk.c
> void blk_start_queue(request_queue_t *q)
> {
>         if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
>                 unsigned long flags;
> 
>                 spin_lock_irqsave(q->queue_lock, flags);
>                 if (!elv_queue_empty(q))
>                         q->request_fn(q);
>                 spin_unlock_irqrestore(q->queue_lock, flags);
>         }
> }

Yep, the version Martin posted must be really old.

-- 
Jens Axboe

