Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbSIPNuO>; Mon, 16 Sep 2002 09:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSIPNuO>; Mon, 16 Sep 2002 09:50:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32942 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262172AbSIPNuN>;
	Mon, 16 Sep 2002 09:50:13 -0400
Date: Mon, 16 Sep 2002 15:54:44 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: end_request error procedure in 2.5?
Message-ID: <20020916135444.GK12364@suse.de>
References: <200209161349.g8GDngd06901@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209161349.g8GDngd06901@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16 2002, Peter T. Breuer wrote:
> Can someone tell me why this block end_request routine works fine with a
> request that isn't errored, but locks the machine a milisecond or two
> later if the request is marked for erroring?
> 
> call as 
> 
>  end_request( req, (req->errors == 0) ? 1 : 0 );
>  ..
> 
>  static void end_request(struct request *req, int uptodate) {
>  struct bio *bio;
>  while ((bio = req->bio) != NULL) {
>              blk_finished_io(bio_sectors(bio));
>              req->bio = bio->bi_next;
>              bio->bi_next = NULL;
>              bio_endio(bio, uptodate);
>      }
>      blk_put_request(req);
>  }
> 
> 
> It works fine except on error.  Kernel 2.5.31.  I understand that
> put_request adds the request back to a free list (if gotten from there
> via get_request).  The request is ordinary, except out of range ...
> it's produced by an e2fsck of the device when the device itself is
> unformatted, and the out of range request gets passed to the driver and
> is errored there, and "kapow" ..

The error is most likely in the driver calling end_that_request_first(),
not the function itself. Maybe you can try to do at least some
debugging, I hope you are not expecting anyone to be able to help you
from the above report.

-- 
Jens Axboe

