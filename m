Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVAFMBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVAFMBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVAFMBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:01:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57019 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262636AbVAFMBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:01:04 -0500
Date: Thu, 6 Jan 2005 13:00:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: memory barrier in ll_rw_blk.c (was Re: [PATCH][5/?] count writeback pages in nr_scanned)
Message-ID: <20050106120034.GK17821@suse.de>
References: <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <41DCC4C6.8000205@yahoo.com.au> <20050106080649.GE17821@suse.de> <41DCF3EC.3090506@yahoo.com.au> <20050106083251.GH17821@suse.de> <41DCFC91.5060703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCFC91.5060703@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Thu, Jan 06 2005, Nick Piggin wrote:
> >
> 
> >>No that's right... but between the prepare_to_wait and the io_schedule,
> >>get_request takes the lock and checks nr_requests. I think we are safe?
> >
> >
> >It looks like it, yes you are right. But it looks to be needed a few
> >lines further down instead, though :-)
> >
> >===== drivers/block/ll_rw_blk.c 1.281 vs edited =====
> >--- 1.281/drivers/block/ll_rw_blk.c     2004-12-01 09:13:57 +01:00
> >+++ edited/drivers/block/ll_rw_blk.c    2005-01-06 09:32:19 +01:00
> >@@ -1630,11 +1630,11 @@
> >        if (rl->count[rw] < queue_congestion_off_threshold(q))
> >                clear_queue_congested(q, rw);
> >        if (rl->count[rw]+1 <= q->nr_requests) {
> >-               smp_mb();
> >                if (waitqueue_active(&rl->wait[rw]))
> >                        wake_up(&rl->wait[rw]);
> >                blk_clear_queue_full(q, rw);
> >        }
> >+       smp_mb();
> >        if (unlikely(waitqueue_active(&rl->drain)) &&
> >            !rl->count[READ] && !rl->count[WRITE])
> >                wake_up(&rl->drain);
> >
> 
> Yes, looks like you're right there.
> 
> Any point in doing it like this
> 
> 	if (!rl->count[READ] && !rl->count[WRITE]) {
> 		smb_mb();
> 		if (unlikely(waitqueue_active(...)))
> 			wake_up()
> 	}
> 
> I wonder? I don't have any feeling of how memory barriers impact performance
> on a very parallel system with CPUs that do lots of memory reordering like
> POWER5.

I had the same idea - I think it's a good idea, it's definitely an
optimization worth doing.

-- 
Jens Axboe

