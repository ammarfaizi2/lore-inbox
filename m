Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUBZHlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbUBZHlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:41:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9092 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262713AbUBZHlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:41:10 -0500
Date: Thu, 26 Feb 2004 08:40:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <linus@osdl.org>, anton@samba.org, paulus@samba.org,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       hch@lst.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iSeries virtual disk
Message-ID: <20040226074043.GF32080@suse.de>
References: <20040123163504.36582570.sfr@canb.auug.org.au> <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au> <403DA056.8030007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403DA056.8030007@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26 2004, Jeff Garzik wrote:
> 4) why do you call blkdev_dequeue_request() in do_viodasd_request() 
> rather than viodasd_end_request() ?  Or just use end_request() ?

It makes the queueing simpler (you could potentially leave the _last_
request on the queue, but it's probably not worth the hassle).

They should not call elv_next_request() only to bail if
num_req_outstanding is too big, since it has side effects (moving
request from io scheduler core to dispatch, which makes it ineligible
for merging, sorting, etc).

	do {
		if (too_many_queued)
			break;

		rq = elv_next_request(q);
		if (!rq)
			break;

		...
	}

> 12) don't you need to set blk_queue_max_phys_segments() too?

Yep

> P.S.  I so wish that people had named the API function 
> dma_alloc_incoherent() rather than dma_alloc_noncoherent :)

;-)

-- 
Jens Axboe

