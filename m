Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSGXOsj>; Wed, 24 Jul 2002 10:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSGXOsj>; Wed, 24 Jul 2002 10:48:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3087 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317359AbSGXOsh>;
	Wed, 24 Jul 2002 10:48:37 -0400
Message-ID: <3D3EBDC6.3060601@evision.ag>
Date: Wed, 24 Jul 2002 16:46:30 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
References: <Pine.SOL.4.30.0207241632350.15605-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 24 Jul 2002, Jens Axboe wrote:
> 
> 
>>On Wed, Jul 24 2002, Marcin Dalecki wrote:
>>
>>>>Jens, the same is in cciss.c.
>>>>Please remove locking from blk_stop_queue() (as you suggested) or intrduce
>>>>unlocking in request_functions.
>>>>
>>>
>>>Bartek I think the removal is just for reassertion that the
>>>locking is the problem. You can't remove it easly from
>>>blk_stop_queue() unless you make it mandatory that blk_stop_queue
>>>has to be run with the lock already held. Or in other words
>>>basically -> Don't use blk_stop_queue() outside of ->request_fn.
>>
>>Of couse Bart is advocating just making sure that every caller of
>>blk_stop_queue() _has_ the queue_lock before calling it, not removing
>>the locking there.
>>
>>--
>>Jens Axboe
> 
> 
> And I'm also advocating for __blk_start_queue() ideal for usage in
> ata_end_request(). And moving spin_lock scope to cover test_and_set_bit()
> in blk_start_queue() (for coherency and avoiding spurious calls to
> q->request_fn() )

You mean this:

void blk_start_queue(request_queue_t *q)
{
	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
		unsigned long flags;

		spin_lock_irqsave(q->queue_lock, flags);
		if (!test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
			spin_unlock_irqrestore(q->queue_lock, flags);
			return;
		}
		clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);
		if (!elv_queue_empty(q))
			q->request_fn(q);
		spin_unlock_irqrestore(q->queue_lock, flags);
	}
}

Becouse this is avoiding checking for spinlock in the case
the queue is not stopped.

The spinlock free variant isn't needed right.

> However IDE_BUSY -> QUEUE_STOPPED_FLAG is braindamaged idea.

You should never see it. Think of it as a mind bridge between
IDE_BUSY and queue plug and unplug please. Becouse the purpose
of IDE_BUSY *is* to effectively stall queue processing for
the time of internally issued request. OK?

