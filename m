Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSFEKNf>; Wed, 5 Jun 2002 06:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSFEKNe>; Wed, 5 Jun 2002 06:13:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64452 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314433AbSFEKNc>;
	Wed, 5 Jun 2002 06:13:32 -0400
Date: Wed, 5 Jun 2002 12:13:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020605101315.GY1105@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <15613.26250.675556.878683@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Neil Brown wrote:
> On Tuesday June 4, axboe@suse.de wrote:
> > On Tue, Jun 04 2002, Jens Axboe wrote:
> > > On Tue, Jun 04 2002, Jens Axboe wrote:
> > > > plug? Wrt umem, it seems you could keep 'card' in the queuedata. Same
> > > > for raid5 and conf.
> > > 
> > > Ok by actually looking at it, both card and conf are the queues
> > > themselves. So I'd say your approach is indeed a bit overkill. I'll send
> > > a patch in half an hour for you to review.
> > 
> > Alright here's the block part of it, you'll need to merge your umem and
> > raid5 changes in with that. I'm just interested in knowing if this is
> > all you want/need. It's actually just a two line changes from the last
> > version posted -- set q->unplug_fn in blk_init_queue to our default
> > (you'll override that for umem and raid5, or rather you'll set it
> > yourself after blk_queue_make_request()), and then call that instead of
> > __generic_unplug_device directly from blk_run_queues().
> > 
> I can work with that...
> 
> Below is a patch that fixes a couple of problems with umem and add
> support for md/raid5.  I haven't tested it yet, but it looks right. It
> is on top of your patch.
> 
> It irks me, though, that I need to embed a whole request_queue_t when
> I don't use the vast majority of it.

Yeah this annoys me too...

> What I would like is to have a 
> 
> struct blk_dev {
>        	make_request_fn		*make_request_fn;
> 	unplug_fn		*unplug_fn;
> 	struct list_head	plug_list;
> 	unsigned long		queue_flags;
> 	spinlock_t		*queue_lock;
> }
> 
> which I can embed in mddev_s and umem card, and you can embed in
> struct request_queue.

To some extent, I agree with you. However, I'm not sure it's worth it
abstracting this bit out. The size of the request queue right now in
2.5.20 (with plug change) is 196 bytes on i386 SMP. If you really feel
it's worth saving these bytes, then I'd much rather go in a different
direction: only keep the "main" elements of request_queue_t, and have
blk_init_queue() alloc the "remainder"

> In ll_rw_blk.c we change blk_plug_device to avoid the check for
> the queue being empty as this may not be well define for
> umem/raid5.  Instead, blk_plug_device is not called when
> the queue is not empty (which is mostly wasn' anyway).

I left it that way on purpose, and yes I did see you changed that in the
previous patch as well. I think it's a bit of a mess to have both
blk_plug_device and blk_plug_queue. Without looking at it, I have no
idea which does what?! blk_queue_empty() will always be true for
make_request_fn type drivers, so no change is necessary there.

-- 
Jens Axboe

