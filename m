Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSGXNhC>; Wed, 24 Jul 2002 09:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSGXNhB>; Wed, 24 Jul 2002 09:37:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54664 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317114AbSGXNhA>;
	Wed, 24 Jul 2002 09:37:00 -0400
Date: Wed, 24 Jul 2002 15:39:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
Message-ID: <20020724133959.GD5159@suse.de>
References: <20020721152804.GA6273@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020721152804.GA6273@www.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21 2002, Adam Kropelin wrote:
> The cpqarray driver seems to have been broken around 2.5.19 with the
> blk_start_queue/blk_stop_queue changes. As-is, cpqarray deadlocks the entire
> system when it tries to do partition detection. The bits from the 2.5.19 patch
> which seem to relate are:
> 
> > @@ -916,6 +915,7 @@
> >       goto queue_next;
> >
> >  startio:
> > +     blk_stop_queue(q);
> >       start_io(h);
> >  }
> >
> > @@ -1066,8 +1066,8 @@
> >       /*
> >        * See if we can queue up some more IO
> >        */
> > -     do_ida_request(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
> >       spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags);
> > +     blk_start_queue(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
> >  }
> >
> >  /*
> 
> Simply reverting these changes allows the driver to successfully do
> partition detect, but it quickly hangs if any significant amount of
> I/O is attempted. The hang in this case seems to just affect processes
> trying to do I/O on the array; it is not a whole-system-deadlock.
> 
> Test machine is SMP ppro.

Thanks for the report. Could you just kill the spin_lock/unlock in
blk_stop_queue() in drivers/block/ll_rw_blk.c and see if it works?

-- 
Jens Axboe

