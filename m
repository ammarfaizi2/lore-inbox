Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUBVOD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 09:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUBVOD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 09:03:26 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:27577 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261299AbUBVODW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 09:03:22 -0500
Date: Sun, 22 Feb 2004 15:02:32 +0100
From: Miquel van Smoorenburg <miquels@cistron.net>
To: Jens Axboe <axboe@suse.de>
Cc: Joe Thornber <thornber@redhat.com>,
       Miquel van Smoorenburg <miquels@cistron.net>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       miquels@cistron.nl, linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bdi_congestion_funp (was: Re: [PATCH] per process request limits (was Re: IO scheduler, queue depth, nr_requests))
Message-ID: <20040222140232.GE1375@drinkel.cistron.nl>
References: <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl> <40355F03.9030207@cyberone.com.au> <20040219172656.77c887cf.akpm@osdl.org> <40356599.3080001@cyberone.com.au> <20040219183218.2b3c4706.akpm@osdl.org> <20040220144042.GC20917@traveler.cistron.net> <20040220145944.GM27549@reti> <20040220150013.GY27190@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040220150013.GY27190@suse.de> (from axboe@suse.de on Fri, Feb 20, 2004 at 16:00:13 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 16:00:13, Jens Axboe wrote:
> On Fri, Feb 20 2004, Joe Thornber wrote:
> > > +	devices = dm_table_get_devices(t);
> > > +	for (d = devices->next; d != devices; d = d->next) {
> > > +		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
> > > +		request_queue_t *q = bdev_get_queue(dd->bdev);
> > > +		r |= test_bit(bdi_state, &(q->backing_dev_info.state));
> > 
> > Shouldn't this be calling your bdi_*_congested function rather than
> > assuming it is a real device under dm ? (often not true).
> > 
> > I'm also very slightly worried that or'ing together the congestion
> > results for all the seperate devices isn't always the right thing.
> > These devices include anything that the targets are using, exception
> > stores for snapshots, logs for mirror, all paths for multipath (or'ing
> > is most likely to be wrong for multipath).
> 
> Yeah the patch is pretty much crap in that area, I don't think Miquel
> was aiming for inclusion :)
> 
> I'd suggest making queue functions for congestion state as well so it
> stacks properly.

I've been looking at this. If you want to keep the struct backing_dev_info
reasonably stand-alone (no function pointer and aux data like I did) you
probably need to add a list of parent_queues to every request_list. If
the queue get congested, you mark the parent queue(s) congested as well.
Congested state would need to be changed into a counter instead of a
bitfield, I think.

The pdflush-is-running-on-this-queue bit can probably remain as-is. It's
mostly meant to prevent 2 pdflush daemons from running the same queue.
I don't see much harm in pdflush #1 running on /dev/md0 which consists
of /dev/sda1 and /dev/sdb1 and pdflush #2 running on /dev/sdb2, right ?

Would that be the way to go? If so, I'll take a stab at it.

Mike.
