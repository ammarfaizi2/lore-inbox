Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSFOH4B>; Sat, 15 Jun 2002 03:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSFOH4A>; Sat, 15 Jun 2002 03:56:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17344 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314451AbSFOHz7>;
	Sat, 15 Jun 2002 03:55:59 -0400
Date: Sat, 15 Jun 2002 09:55:49 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020615075549.GA1359@suse.de>
In-Reply-To: <200206141652.JAA26744@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14 2002, Adam J. Richter wrote:
> On Fri, 14 Jun 2002 Jens Axboe wrote:
> >On Thu, Jun 13 2002, Adam J. Richter wrote:
> [...]
> >> 	newbio = bio_chain(oldbio);
> [...]
> >> 	I realize there may be locking issues in implementing this.
> 
> >but I think that statement is very naive :-)
> 
> >Essentially you are keeping a cookie to the old bio submitted, so that
> >you can merge new bio with it fairly cheaply (it's still not very cheap,
> >although you do eliminate the biggest offender, the list merge scan).
> >The first problem is that once you submit the bio, there are some things
> >that are not yours to touch anymore. You cannot change bi_next for
> >instance, you have no idea what state the bio is in wrt I/O completion.
> >Sure you can hold a reference to the bio, but all that really gets you
> >in this situation is a handle to it, nothing more. How do you decide
> >when to invalidate this cookie that you have?
> 
> 	At any time, there could be only one "hinted" bio in a
> request: the last bio in the request.  So you only have to
> clear the hint when:
> 
> 		1. you merge bio's,
> 		2. elv_next_request is called,
> 		3. newbio is submitted.
> 
> 	In all three cases q->queue_lock gets taken, so we should
> not need to add any additional spin_lock_irq's, and the two lines
> to clear the hint pointers should be trivial.

This logic is flawed. As I said, once you pass the bio to submit_bio,
you can't maintain a pointer to it for these purposes. Grabbing the
queue_lock guarentees absolutely nothing in this regard. Consider loop,
for instance. I/O could be completed by the time bio_submit returns.
Sure you can grab a reference to the bio with bio_get(), but what would
that buy you? Just that the bio at least won't be freed by the time
bio_submit returns, but that's it.

-- 
Jens Axboe

