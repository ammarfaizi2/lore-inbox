Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSGXNLo>; Wed, 24 Jul 2002 09:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSGXNLm>; Wed, 24 Jul 2002 09:11:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54029 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317066AbSGXNLI>; Wed, 24 Jul 2002 09:11:08 -0400
Message-ID: <3D3EA6E9.7000601@evision.ag>
Date: Wed, 24 Jul 2002 15:08:57 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <20020724124124.GA15201@suse.de> <Pine.SOL.4.30.0207241446130.15605-100000@mion.elka.pw.edu.pl> <20020724125037.GB15201@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>>>2.5.27:drivers/block/ll_rw_blk.c
>>>>void blk_start_queue(request_queue_t *q)
>>>>{
>>>>        if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
>>>>                unsigned long flags;
>>>>
>>>>                spin_lock_irqsave(q->queue_lock, flags);
>>>>                if (!elv_queue_empty(q))
>>>>                        q->request_fn(q);
>>>>                spin_unlock_irqrestore(q->queue_lock, flags);
>>>>        }
>>>>}

> There were buggy versions at one point, however they may not have made it
> into a full release. In that case it was just bk version of 2.5.19-pre
> effectively. I forget the details :-)

Naj - it's far more trivial I just looked at wrong tree at hand...
But anyway. What happens if somone does set QUEUE_FLAG_STOPPED
between the test_and_claer_bit and taking the spin_lock? Setting
the QUEUE_FLAG_STOPPED isn't maintaining the spin_lock protection!

My goal is to make sure that the QUEUE_FLAG_STOPPED has a valid value
*inside* the q->request_fn call.

This here is where it's supposed to be set:

void blk_stop_queue(request_queue_t *q)
{
         unsigned long flags;

         spin_lock_irqsave(q->queue_lock, flags);
         blk_remove_plug(q);
         spin_unlock_irqrestore(q->queue_lock, flags);

         set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
}

And I don't see anything preventing the above problem.

It sould perhaps be?

void blk_stop_queue(request_queue_t *q)
{
         unsigned long flags;

         spin_lock_irqsave(q->queue_lock, flags);
         blk_remove_plug(q);
         set_bit(QUEUE_FLAG_STOPPED, &q->queue_flags); /* Notice 
spinlock still held! */
         spin_unlock_irqrestore(q->queue_lock, flags);
}

void blk_start_queue(request_queue_t *q)
{
         if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
                 unsigned long flags;

                 spin_lock_irqsave(q->queue_lock, flags);
		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
			spin_unlock_irqsave(q->queue_lock, flags);
			return;
		}
                 clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
                 if (!elv_queue_empty(q))
                         q->request_fn(q);
                 spin_unlock_irqrestore(q->queue_lock, flags);
         }
}

At least I couldn't see any harm in doing it like above.
And again. I think it would assert that the flag is well defined inside
q->request_fn().

