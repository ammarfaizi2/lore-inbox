Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSGXLhL>; Wed, 24 Jul 2002 07:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSGXLhL>; Wed, 24 Jul 2002 07:37:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61708 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316860AbSGXLhK>; Wed, 24 Jul 2002 07:37:10 -0400
Message-ID: <3D3E90E4.3080108@evision.ag>
Date: Wed, 24 Jul 2002 13:35:00 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207241248380.17154-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>There are some nasty checks for it != NULL in the generic BIO code.
> 
> 
> No, there are no checks there.

Hello?:

[root@localhost block]# grep \>special *.c
elevator.c:         !rq->waiting && !rq->special)
^^^^^^ This one is supposed to have the required barrier effect.
ll_rw_blk.c:    if (req->special || next->special)
ll_rw_blk.c:            rq->special = NULL;
ll_rw_blk.c:    rq->special = data;
^^^^^^^ This one is me :-).
ll_rw_blk.c:        || next->waiting || next->special)
[root@localhost block]#


>>>So look at ide.c for example.
>>
>>So look at drivers which call blk_start_queue() from within
>>q->request_fn context, which is, well, causing deliberate *recursion*.
>>
> 
> 
> Are you sure? If so they should first check whether queue is
> started/stopped, if they don't it is a bug.

void blk_start_queue(request_queue_t *q)
{
         if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
                 unsigned long flags;

================== possigle race here for qeue_flags BTW.

                 spin_lock_irqsave(q->queue_lock, flags);
                 clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags);

                 if (!elv_queue_empty(q))
                         q->request_fn(q);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If we call it from within request_fn then if this isn't recursion on the
kernel stack then I don't know...

                 spin_unlock_irqrestore(q->queue_lock, flags);
         }
}

