Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317949AbSGZSa1>; Fri, 26 Jul 2002 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSGZSa1>; Fri, 26 Jul 2002 14:30:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317949AbSGZSaY>;
	Fri, 26 Jul 2002 14:30:24 -0400
Message-ID: <3D419583.DFE940DA@zip.com.au>
Date: Fri, 26 Jul 2002 11:31:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
References: <20020726120248.GI14839@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> The layout of the deadline i/o scheduler is roughly:
> 
>         [1]       [2]
>          |         |
>          |         |
>          |         |
>          ====[3]====
>               |
>               |
>               |
>               |
>              [4]
> 
> where [1] is the regular ascendingly sorted pending list of requests,
> [2] is a fifo list (well really two lists, one for reads and one for
> writes) of pending requests which each have an expire time assigned, [3]
> is the elv_next_request() worker, and [4] is the dispatch queue
> (q->queue_head again). When a request enters the i/o scheduler, it is
> sorted into the [1] list, assigned an expire time, and sorted into the
> fifo list [2] (the fifo list is really two lists, one for reads and one
> for writes).
> 
> [1] is the main list where we serve requests from. If a request deadline
> gets exceeded, we move a number of entries (known as the 'fifo_batch'
> count) from the sorted list starting from the expired entry onto the
> dispatch queue. This makes sure that we at least attempt to start an
> expired request immediately, but don't completely fall back to FCFS i/o
> scheduling (well set fifo_batch == 1, and you will get FCFS with an
> appropriately low expire time).

I don't quite understand...  When expired requests are moved from the
fifo [2] onto the dispatch queue [4], is merging performed at the
dispatch queue?

In other words, if the fifo queue has blocks (1,3,5,7,2,4,6,8) or
(1,10,20,5,15,25), and they expire, will they be sorted in some manner
before going to the hardware?  If so, where?

> ...
> 
> Finally, I've done some testing on it. No testing on whether this really
> works well in real life (that's what I want testers to do), and no
> testing on benchmark performance changes etc. What I have done is
> beat-up testing, making sure it works without corrupting your data.

I'll give it a whizz over the weekend.

-
