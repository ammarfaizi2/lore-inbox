Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317763AbSGZPLO>; Fri, 26 Jul 2002 11:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317765AbSGZPLO>; Fri, 26 Jul 2002 11:11:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2827 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317763AbSGZPLN>;
	Fri, 26 Jul 2002 11:11:13 -0400
Message-ID: <3D416625.4050205@evision.ag>
Date: Fri, 26 Jul 2002 17:09:25 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com> <3D40E62B.9070202@evision.ag> <20020726143840.GC8761@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jul 26 2002, Marcin Dalecki wrote:
> 
>>The attached patch does the following:
> 
> 
> Looks fine to me. One thing sticks out though:

Hey it was *literal* cut and paste from SCSI code after all ;-)

>>+	rq->flags &= REQ_QUEUED;
> 
> 
> this can't be right. Either it's a bug for REQ_QUEUED to be set here, or
> it needs to end the tag properly.
> 
> 
>>+	rq->flags |= REQ_SPECIAL | REQ_BARRIER;
>>+
>>+	rq->special = data;
>>+
>>+	spin_lock_irqsave(q->queue_lock, flags);
>>+	/* If command is tagged, release the tag */
>>+	if(blk_rq_tagged(rq))
>>+		blk_queue_end_tag(q, rq);
> 
> 
> woops, you just possible leaked a tag. I really don't think you should
> mix inserting a special and ending a tag into the same function, makes
> no sense. If a driver wants that it should do:
> 
> 	if (blk_rq_tagged(rq))
> 		blk_queue_end_tag(q, rq);

Yes.

> 	blk_insert_request(q, rq, bla bla);
> 
> Also, please use the right spacing, if(bla :-)

Cut and paste damage from SCSI code.... no argument here.

> So kill any reference to tagging (and REQ_QUEUED)i in
> blk_insert_request, and I'm ok with it.

Ah, yes I'm pretty sure now. I looked up how blk_queue_end_tag()
works and it's indeed the case -> setting the flag
and undoing it immediately doesn't make sense anyway.
(Even the collateral damage to tag allocation aside...)
This was perhaps "defensive coding" by the SCSI people?

You are right the

rq->flags &= REQ_QUEUED;

and the

  	if (blk_rq_tagged(rq))
  		blk_queue_end_tag(q, rq);

should be just removed and things are fine.
They only survive becouse they don't provide a tag for the request in
first place.

Thanks for pointing it out.

