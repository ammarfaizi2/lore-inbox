Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSGUPZG>; Sun, 21 Jul 2002 11:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSGUPZG>; Sun, 21 Jul 2002 11:25:06 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:2804 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S317638AbSGUPZF>;
	Sun, 21 Jul 2002 11:25:05 -0400
Date: Sun, 21 Jul 2002 11:28:04 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: cpqarray broken since 2.5.19
Message-ID: <20020721152804.GA6273@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpqarray driver seems to have been broken around 2.5.19 with the
blk_start_queue/blk_stop_queue changes. As-is, cpqarray deadlocks the entire
system when it tries to do partition detection. The bits from the 2.5.19 patch
which seem to relate are:

> @@ -916,6 +915,7 @@
>       goto queue_next;
>
>  startio:
> +     blk_stop_queue(q);
>       start_io(h);
>  }
>
> @@ -1066,8 +1066,8 @@
>       /*
>        * See if we can queue up some more IO
>        */
> -     do_ida_request(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
>       spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags);
> +     blk_start_queue(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
>  }
>
>  /*

Simply reverting these changes allows the driver to successfully do partition
detect, but it quickly hangs if any significant amount of I/O is attempted. The
hang in this case seems to just affect processes trying to do I/O on the array;
it is not a whole-system-deadlock.

Test machine is SMP ppro.

--Adam

