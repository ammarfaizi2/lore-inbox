Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSG1UKn>; Sun, 28 Jul 2002 16:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSG1UKn>; Sun, 28 Jul 2002 16:10:43 -0400
Received: from host194.steeleye.com ([216.33.1.194]:35082 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317264AbSG1UKn>; Sun, 28 Jul 2002 16:10:43 -0400
Message-Id: <200207282013.g6SKDjg02769@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>, Marcin Dalecki <dalecki@evision.ag>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Jul 2002 15:13:45 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are right the
> > rq->flags &= REQ_QUEUED;
> > and the
> > if (blk_rq_tagged(rq))
> blk_queue_end_tag(q, rq);
> > should be just removed and things are fine.
> They only survive becouse they don't provide a tag for the request in
> first place.
> > Thanks for pointing it out.


Please don't remove this.

insert_special isn't just used to start new requests, it's also used to queue 
incoming requests that cannot be processed by the device (host adapter, 
queue_full etc.).

In this latter case, the tag is already begun, so it needs to go back with 
end_tag (we start a new tag when the device begins processing again).

I own up to introducing the &= REQ_QUEUED rubbish---I was just keeping the 
original  placement of the flag clearing code, but now we need to preserve 
whether the request was queued or not for the blk_rq_tagged check.  On 
reflection it would have been better just to set the flags to REQ_SPECIAL | 
REQ_BARRIER after the end tag code.

axboe@suse.de said:
> But the crap still got merged, sigh... Yet again an excellent point of
> why stuff like this should go through the maintainer. Apparently Linus
> blindly applies this stuff.

Hmm, well I sent it to you and you are the Maintainer.

James

P.S. I just got back into the US from a long flight, I'll give this more 
mature reflection tomorrow.


