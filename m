Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUCSITj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 03:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUCSITj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 03:19:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261913AbUCSITT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 03:19:19 -0500
Date: Fri, 19 Mar 2004 00:19:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: markw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040319001921.269380a3.akpm@osdl.org>
In-Reply-To: <20040319075704.GD22234@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<200403181737.i2IHbCE09261@mail.osdl.org>
	<20040318100615.7f2943ea.akpm@osdl.org>
	<20040318192707.GV22234@suse.de>
	<20040318191530.34e04cb2.akpm@osdl.org>
	<20040319073919.GY22234@suse.de>
	<20040318235200.25c376a9.akpm@osdl.org>
	<20040319075704.GD22234@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > Is it not the case that two dm maps can refer to the same queue?  Say, one
> > map uses /dev/hda1 and another map uses /dev/hda2?
> > 
> > If so, then when the /dev/hda queue is plugged we need to tell both the
> > higher-level maps that this queue needs an unplug.  So blk_plug_device()
> > and the various unplug functions need to perform upcalls to an arbitrary
> > number of higher-level drivers, and those drivers need to keep track of the
> > currently-plugged queues without adding data structures to the
> > request_queue structure.
> > 
> > It can be done of course, but could get messy.
> 
> That would get nasty, it's much more natural to track it from the other
> end. I view it as a dm (or whatever problem) that they need to track who
> has pending io on their behalf, which is pretty easy to to from eg
> __map_bio().

But dm doesn't know enough.  Suppose it is managing a map which includes
/dev/hda1 and I do some I/O against /dev/hda2 which plugs the queue.  dm
needs to know about that plug.

Actually the data structure isn't toooo complex.

- In the request_queue add a list_head of "interested drivers"

- In a dm map, add:

	struct interested_driver {
		list_head list;
		void (*plug_upcall)(struct request_queue *q, void *private);
		void (*unplug_upcall)(struct request_queue *q, void *private);
		void *private;
	}

  and when setting up a map, dm does:

  blk_register_interested_driver(struct request_queue *q,
			struct interested_driver *d)
  {
	list_add(&d->list, q->interested_driver_list);
  }

- In blk_device_plug():

     list_for_each_entry(d, q->interested_driver_list, list) {
	(*d->plug_upcall)(q, d->private);
     }

- Similar in the unplug functions.


And in dm, maintain a dynamically allocated array of request_queue*'s:

  dm_plug_upcall(struct request_queue *q, void *private)
  {
	map = private;

	map->plugged_queues[map->nr_plugged_queues++] = q;
  }

  dm_unplug_upcall(struct request_queue *q, void *private)
  {
	map = private;

 	for (i = 0; i < map->nr_plugged_queues; i++) {
		if (map->plugged_queues[i] == q) {
			memcpy(&map->plugged_queues[i],
				&map->plugged_queues[i+1],
				<whatever>
		}
	}
  }

unplug_upcall is a bit sucky, but they're much less frequent than the
current unplug downcalls.  

Frankly, I wouldn't bother.  0.5% CPU when hammering the crap out of a
56-disk LVM isn't too bad.  I'd suggest you first try to simply reduce the
number of cache misses in the inner loop, see what that leaves us with.


