Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSGXMg5>; Wed, 24 Jul 2002 08:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSGXMg5>; Wed, 24 Jul 2002 08:36:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41674 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317054AbSGXMgz>; Wed, 24 Jul 2002 08:36:55 -0400
Date: Wed, 24 Jul 2002 14:39:45 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <martin@dalecki.de>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: please DON'T run 2.5.27 with IDE!
In-Reply-To: <3D3E90E4.3080108@evision.ag>
Message-ID: <Pine.SOL.4.30.0207241423190.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Marcin Dalecki wrote:

> Bartlomiej Zolnierkiewicz wrote:
>
> >>There are some nasty checks for it != NULL in the generic BIO code.
                                               ^^^^^^^^^^^^^^^^^^^^^^^
> >
> >
> > No, there are no checks there.
>
> Hello?:

Yes, hello Martin, read you own sentence ;-)

Generic BIO code is bio.c and bio.h.

> [root@localhost block]# grep \>special *.c
> elevator.c:         !rq->waiting && !rq->special)
> ^^^^^^ This one is supposed to have the required barrier effect.
> ll_rw_blk.c:    if (req->special || next->special)
> ll_rw_blk.c:            rq->special = NULL;
> ll_rw_blk.c:    rq->special = data;
> ^^^^^^^ This one is me :-).
> ll_rw_blk.c:        || next->waiting || next->special)
> [root@localhost block]#

You seem to confuse block layer with BIO layer.

> >>>So look at ide.c for example.
> >>
> >>So look at drivers which call blk_start_queue() from within
> >>q->request_fn context, which is, well, causing deliberate *recursion*.
> >>
> >
> > Are you sure? If so they should first check whether queue is
> > started/stopped, if they don't it is a bug.
>
> void blk_start_queue(request_queue_t *q)
> {
>          if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
>                  unsigned long flags;
>
> ================== possigle race here for qeue_flags BTW.
>
>                  spin_lock_irqsave(q->queue_lock, flags);
>                  clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
>
>                  if (!elv_queue_empty(q))
>                          q->request_fn(q);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> If we call it from within request_fn then if this isn't recursion on the
> kernel stack then I don't know...

You really don't know.

And funny thing is I have diffirent blk_start_queue() function in my tree
(2.5.27) ? Without described above race and without possibilty of
recursion...

2.5.27:drivers/block/ll_rw_blk.c
void blk_start_queue(request_queue_t *q)
{
        if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
                unsigned long flags;

                spin_lock_irqsave(q->queue_lock, flags);
                if (!elv_queue_empty(q))
                        q->request_fn(q);
                spin_unlock_irqrestore(q->queue_lock, flags);
        }
}

Regards
--
Bartlomiej

>                  spin_unlock_irqrestore(q->queue_lock, flags);
>          }
> }




