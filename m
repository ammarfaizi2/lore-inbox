Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVAFIxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVAFIxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVAFIxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:53:43 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:63406 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262779AbVAFIxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:53:41 -0500
Message-ID: <41DCFC91.5060703@yahoo.com.au>
Date: Thu, 06 Jan 2005 19:53:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: memory barrier in ll_rw_blk.c (was Re: [PATCH][5/?] count writeback
 pages in nr_scanned)
References: <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <41DCC4C6.8000205@yahoo.com.au> <20050106080649.GE17821@suse.de> <41DCF3EC.3090506@yahoo.com.au> <20050106083251.GH17821@suse.de>
In-Reply-To: <20050106083251.GH17821@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 06 2005, Nick Piggin wrote:
> 

>>No that's right... but between the prepare_to_wait and the io_schedule,
>>get_request takes the lock and checks nr_requests. I think we are safe?
> 
> 
> It looks like it, yes you are right. But it looks to be needed a few
> lines further down instead, though :-)
> 
> ===== drivers/block/ll_rw_blk.c 1.281 vs edited =====
> --- 1.281/drivers/block/ll_rw_blk.c     2004-12-01 09:13:57 +01:00
> +++ edited/drivers/block/ll_rw_blk.c    2005-01-06 09:32:19 +01:00
> @@ -1630,11 +1630,11 @@
>         if (rl->count[rw] < queue_congestion_off_threshold(q))
>                 clear_queue_congested(q, rw);
>         if (rl->count[rw]+1 <= q->nr_requests) {
> -               smp_mb();
>                 if (waitqueue_active(&rl->wait[rw]))
>                         wake_up(&rl->wait[rw]);
>                 blk_clear_queue_full(q, rw);
>         }
> +       smp_mb();
>         if (unlikely(waitqueue_active(&rl->drain)) &&
>             !rl->count[READ] && !rl->count[WRITE])
>                 wake_up(&rl->drain);
> 

Yes, looks like you're right there.

Any point in doing it like this

	if (!rl->count[READ] && !rl->count[WRITE]) {
		smb_mb();
		if (unlikely(waitqueue_active(...)))
			wake_up()
	}

I wonder? I don't have any feeling of how memory barriers impact performance
on a very parallel system with CPUs that do lots of memory reordering like
POWER5.
