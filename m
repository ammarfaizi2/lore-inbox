Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSGEGbl>; Fri, 5 Jul 2002 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSGEGbk>; Fri, 5 Jul 2002 02:31:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39570 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315455AbSGEGbk>;
	Fri, 5 Jul 2002 02:31:40 -0400
Date: Fri, 5 Jul 2002 08:34:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot!
Message-ID: <20020705063401.GI1007@suse.de>
References: <200207042259.g64MxdH03605@localhost.localdomain> <Pine.LNX.4.10.10207041900080.19028-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10207041900080.19028-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04 2002, Andre Hedrick wrote:
> 	1) 8K writes and 64K (or larger) reads.

I've heard this before, but noone seems to have tested it yet. You know,
this is a couple of lines of change in ll_rw_blk.c and blkdev.h to
support this. Any reason you haven't done that, benched, and submitted
something to that effect? I'll even walk you through the 2.5 changes
needed to do this:

blkdev.h:
	unsigned short max_sectors;

change to

	unsigned short max_sectors[2];

ll_rw_blk.c:
	ll_back_merge_fn()
	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors) {

change to

	if (req->nr_sectors + bio_sectors(bio) > q->max_sectors[rq_data_dir[req]) {

Ditto for ll_front_merge_fn() and ll_merge_requests_fn(). The line in
attempt_merge() can be killed.

	generic_make_request()
	BUG_ON(bio_sectors(bio) > q->max_sectors);

change to

	BUG_ON(bio_sectors(bio) > q->max_sectors[bio_data_dir(bio)];

And do the trivial thing to blk_queue_max_sectors() as well. Now all you
need to do is change ide-probe.c to set the values you want.

> 	2) ONE maybe TWO passes on elevator operations.

Explain.

> Since this is falling on deaf ears in general, oh well.

How so?

-- 
Jens Axboe

