Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUCSH5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUCSH5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:57:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3237 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261753AbUCSH5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:57:09 -0500
Date: Fri, 19 Mar 2004 08:57:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: markw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040319075704.GD22234@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403181737.i2IHbCE09261@mail.osdl.org> <20040318100615.7f2943ea.akpm@osdl.org> <20040318192707.GV22234@suse.de> <20040318191530.34e04cb2.akpm@osdl.org> <20040319073919.GY22234@suse.de> <20040318235200.25c376a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318235200.25c376a9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > --- 25/drivers/md/dm-table.c~a	2004-03-18 19:03:15.130004696 -0800
> >  > +++ 25-akpm/drivers/md/dm-table.c	2004-03-18 19:03:41.656971984 -0800
> >  > @@ -893,7 +893,7 @@ void dm_table_unplug_all(struct dm_table
> >  >  		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
> >  >  		request_queue_t *q = bdev_get_queue(dd->bdev);
> >  >  
> >  > -		if (q->unplug_fn)
> >  > +		if (q->unplug_fn && queue_needs_unplug(q)))
> >  >  			q->unplug_fn(q);
> >  >  	}
> >  >  }
> >  > 
> >  > 
> >  > to reduce the computational expense of dm_table_unplug_all() a bit.
> >  > 
> >  > But we're barking up the wrong tree here.  Mark, if it's OK I'll run up
> >  > some kernels for you to test.
> > 
> >  I thought about this last night, and I have a better idea that gets the
> >  same accomplished. The problem right now is indeed that we aren't
> >  tracking who needs to be unplugged, like we used to. The solution is to
> >  do the exact same style plugging (with block helpers) that we used to,
> >  except the plug_list is maintained in the driver. So when you do
> >  dm_unplug(), it doesn't _have_ to iterate the full device list, only
> >  those that do need kicking.
> > 
> >  I'll produce a patch to fix this this morning. First coffee.
> 
> Yes, it would be nice but I fear that it gets complicated.
> 
> Is it not the case that two dm maps can refer to the same queue?  Say, one
> map uses /dev/hda1 and another map uses /dev/hda2?
> 
> If so, then when the /dev/hda queue is plugged we need to tell both the
> higher-level maps that this queue needs an unplug.  So blk_plug_device()
> and the various unplug functions need to perform upcalls to an arbitrary
> number of higher-level drivers, and those drivers need to keep track of the
> currently-plugged queues without adding data structures to the
> request_queue structure.
> 
> It can be done of course, but could get messy.

That would get nasty, it's much more natural to track it from the other
end. I view it as a dm (or whatever problem) that they need to track who
has pending io on their behalf, which is pretty easy to to from eg
__map_bio().

The only addition is putting the old q->plug_list back, but using it on
stacking drivers like dm. dm then maintains a per-dm plugged list that
it can use when dm_unplug() runs.

-- 
Jens Axboe

