Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130120AbQL0UfK>; Wed, 27 Dec 2000 15:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQL0UfA>; Wed, 27 Dec 2000 15:35:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27468 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130120AbQL0Uev>; Wed, 27 Dec 2000 15:34:51 -0500
Date: Wed, 27 Dec 2000 21:04:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: plug problem in linux-2.4.0-test11
Message-ID: <20001227210426.B10446@athlon.random>
In-Reply-To: <C12569A6.00425037.00@d12mta07.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C12569A6.00425037.00@d12mta07.de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Nov 29, 2000 at 12:56:44PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Nov 29, 2000 at 12:56:44PM +0100, schwidefsky@de.ibm.com wrote:
> 
> 
> Hi,
> I experienced disk hangs with linux-2.4.0-test11 on S/390 and after
> some debugging I found the cause. It the new method of unplugging
> block devices that doesn't go along with the S/390 disk driver:
> 
> /*
>  * remove the plug and let it rip..
>  */
> static inline void __generic_unplug_device(request_queue_t *q)
> {
>         if (!list_empty(&q->queue_head)) {
>                 q->plugged = 0;
>                 q->request_fn(q);
>         }
> }
> 
> The story goes like this: at start the request queue was empty but
> the disk driver was still working on an older, already dequeued
> request. Someone plugged the device (q->plugged = 1 && queue on
> tq_disk). Then a new request arrived and the unplugging was
> started. But before __generic_unplug_device was reached the
> outstanding request finished. The bottom half of the S/390 disk
> drivers always checks for queued requests after an interrupt,
> starts the first and dequeues some of the requests on the
> request queue to put them on its internal queue. You could argue
> that it shouldn't dequeue request if q->plugged == 1. On the other

Yes I argue exactly that ;). That's a bug in the driver. For example if the
driver is an headactive device (q->headactive == 1) then the bug will also
corrupt memory (probably it isn't an headactive device because you said it
moves the request into its private lists). Otherwise it only forbids the
elevator to merge requests and optimze seeks away.

I think right behaviour of the blkdev layer is to BUG() if the driver eats
requests while the device is plugged.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
