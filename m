Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268698AbTCCSmu>; Mon, 3 Mar 2003 13:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268708AbTCCSmu>; Mon, 3 Mar 2003 13:42:50 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:1731 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S268698AbTCCSms>;
	Mon, 3 Mar 2003 13:42:48 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pavel Machek <pavel@ucw.cz>
Date: Mon, 3 Mar 2003 19:52:47 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] make nbd working in 2.5.x
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <11BAC7716B51@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Mar 03 at 19:39, Pavel Machek wrote:
> >    we use nbd for our diskless systems, and it looks to me like that
> > it has some serious problems in 2.5.x... Can you apply this patch
> > and forward it to Linus? 
> > 
> > There were:
> > * Missing disk's queue initialization
> > * Driver should use list_del_init: put_request now verifies
> >   that req->queuelist is empty, and list_del was incompatible
> >   with this.
> > * I converted nbd_end_request back to end_that_request_{first,last}
> >   as I saw no reason why driver should do it itself... and 
> >   blk_put_request has no place under queue_lock, so apparently when
> >   semantic changed nobody went through drivers...
> 
> I do not think this is good idea. I am not sure who converted it to
> bio, but he surely had good reason to do that.

I think that at the beginning of 2.5.x series there was some thinking
about removing end_that_request* completely from the API. As it never
happened, and __end_that_request_first()/end_that_request_last() has 
definitely better quality (like that it does not ignore req->waiting...)
than opencoded nbd loop, I prefer using end_that_request* over opencoding
bio traversal.

If you want, then just replace blk_put_request() with __blk_put_request(),
instead of first change. But I personally will not trust such code, as 
next time something in bio changes nbd will miss this change again.
                                                    Petr Vandrovec
                                                    
> > diff -urdN linux/drivers/block/nbd.c linux/drivers/block/nbd.c
> > --- linux/drivers/block/nbd.c 2003-02-28 20:56:05.000000000 +0100
> > +++ linux/drivers/block/nbd.c 2003-03-01 22:53:36.000000000 +0100
> > @@ -76,22 +76,15 @@
> >  {
> >   int uptodate = (req->errors == 0) ? 1 : 0;
> >   request_queue_t *q = req->q;
> > - struct bio *bio;
> > - unsigned nsect;
> >   unsigned long flags;
> >  
> >  #ifdef PARANOIA
> >   requests_out++;
> >  #endif
> >   spin_lock_irqsave(q->queue_lock, flags);
> > - while((bio = req->bio) != NULL) {
> > -     nsect = bio_sectors(bio);
> > -     blk_finished_io(nsect);
> > -     req->bio = bio->bi_next;
> > -     bio->bi_next = NULL;
> > -     bio_endio(bio, nsect << 9, uptodate ? 0 : -EIO);
> > + if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
> > +     end_that_request_last(req);
> >   }
> > - blk_put_request(req);
> >   spin_unlock_irqrestore(q->queue_lock, flags);
> >  }
> >  

