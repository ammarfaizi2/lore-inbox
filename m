Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbUKDAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbUKDAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUKDAu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:50:27 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:62575 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262024AbUKDArf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:47:35 -0500
Message-ID: <41897C21.2030403@yahoo.com.au>
Date: Thu, 04 Nov 2004 11:47:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: blk_queue_congestion_threshold()
References: <200411031913_MC3-1-8DE3-3DC@compuserve.com>
In-Reply-To: <200411031913_MC3-1-8DE3-3DC@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>   Looking at this function in ll_rw_blk.c:
> 
> 
> static void blk_queue_congestion_threshold(struct request_queue *q)
> {
>         int nr;
> 
>         nr = q->nr_requests - (q->nr_requests / 8) + 1;
>         if (nr > q->nr_requests)
>                 nr = q->nr_requests;
>         q->nr_congestion_on = nr;
> 
>         nr = q->nr_requests - (q->nr_requests / 8) - 1;
>         if (nr < 1)
>                 nr = 1;
>         q->nr_congestion_off = nr;
> }
> 
> 
>   Why are the "on" and "off" thresholds the same, i.e. shouldn't there be some

They aren't the same, there is some hysteresis.

> hysteresis?  Con Kolivas posted a patch that changed the "off" threshold to
> "nr_requests - nr_requests/8 - nr_requests/16" and it was said to be better,
> but it never made it into mainline (it also changed get_request_wait() and that
> was never merged either):
> 

Patch was from Arjan. IIRC everyone agreed it looked good, and from
all the feedback I have seen it has worked well. Jens just may not
have had time to get it merged, or forgotten about it.

It can probably at least go to -mm for now.

> 
> --- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c       2004-10-12 12:25:09.798003278 +0200
> +++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c       2004-10-12 12:25:42.959479479 +0200
> @@ -100,7 +100,7 @@
>                 nr = q->nr_requests;
>         q->nr_congestion_on = nr;
>  
> -       nr = q->nr_requests - (q->nr_requests / 8) - 1;
> +       nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 1;
>         if (nr < 1)
>                 nr = 1;
>         q->nr_congestion_off = nr;

The stuff below this hunk is a different thing altogether, and should
not be merged.

> @@ -1758,8 +1758,10 @@
>  {
>         DEFINE_WAIT(wait);
>         struct request *rq;
> +       struct io_context *ioc;
>  
>         generic_unplug_device(q);
> +       ioc = get_io_context(GFP_NOIO);
>         do {
>                 struct request_list *rl = &q->rq;
>  
> @@ -1769,7 +1771,6 @@
>                 rq = get_request(q, rw, GFP_NOIO);
>  
>                 if (!rq) {
> -                       struct io_context *ioc;
>  
>                         io_schedule();
>  
> @@ -1779,12 +1780,11 @@
>                          * up to a big batch of them for a small period time.
>                          * See ioc_batching, ioc_set_batching
>                          */
> -                       ioc = get_io_context(GFP_NOIO);
>                         ioc_set_batching(q, ioc);
> -                       put_io_context(ioc);
>                 }
>                 finish_wait(&rl->wait[rw], &wait);
>         } while (!rq);
> +       put_io_context(ioc);
>  
>         return rq;
>  }
> 
> 
