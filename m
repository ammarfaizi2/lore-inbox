Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269751AbRHDB3i>; Fri, 3 Aug 2001 21:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269750AbRHDB32>; Fri, 3 Aug 2001 21:29:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21259 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269751AbRHDB3Q>;
	Fri, 3 Aug 2001 21:29:16 -0400
Date: Fri, 3 Aug 2001 22:29:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Ben LaHaise <bcrl@redhat.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108031812120.23074-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33L.0108032144310.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Ben LaHaise wrote:

> --- vm-2.4.7/drivers/block/ll_rw_blk.c.2	Fri Aug  3 19:06:46 2001
> +++ vm-2.4.7/drivers/block/ll_rw_blk.c	Fri Aug  3 19:32:46 2001
> @@ -1037,9 +1037,16 @@
>  		 * water mark. instead start I/O on the queued stuff.
>  		 */
>  		if (atomic_read(&queued_sectors) >= high_queued_sectors) {
> -			run_task_queue(&tq_disk);
> -			wait_event(blk_buffers_wait,
> -			 atomic_read(&queued_sectors) < low_queued_sectors);

... OUCH ...

> bah.  Doesn't fix it.  Still waiting indefinately in ll_rw_blk().

And it's obvious why.

The code above, as well as your replacement, are have a
VERY serious "fairness issue".

	task 1			task 2

 queued_sectors > high
   ==> waits for
   queued_sectors < low

                             write stuff, submits IO
                             queued_sectors < high  (but > low)
                             ....
                             queued sectors still < high, > low
                             happily submits more IO
                             ...
                             etc..

It is quite obvious that the second task can easily starve
the first task as long as it keeps submitting IO at a rate
where queued_sectors will stay above low_queued_sectors,
but under high_queued sectors.

There are two possible solutions to the starvation scenario:

1) have one threshold
2) if one task is sleeping, let ALL tasks sleep
   until we reach the lower threshold

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

