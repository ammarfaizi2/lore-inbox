Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSKJO0H>; Sun, 10 Nov 2002 09:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSKJO0H>; Sun, 10 Nov 2002 09:26:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54743 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264885AbSKJO0D>;
	Sun, 10 Nov 2002 09:26:03 -0500
Date: Sun, 10 Nov 2002 15:32:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021110143208.GJ31134@suse.de>
References: <3DCDD9AC.C3FB30D9@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <3DCDD9AC.C3FB30D9@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 09 2002, Andrew Morton wrote:
> And Jens's rbtree-based insertion code for the request queue.  Which
> means that the queues can be grown a *lot* if people want to play with
> that.  The VM should be able to cope with it fine.

I've attached a small document describing the deadline io scheduler
tunables. stream_unit is not in Andrew's version, yet, it uses a hard
defined 128KiB. Also, Andrew didn't apply the rbtree patch only the
tunable patch. So it uses the same insertion algorithm as the default
kernel, two linked lists.

-- 
Jens Axboe


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="deadline-iosched.txt"

Deadline IO scheduler tunables
==============================

This little file attempts to document how the deadline io scheduler works.
In particular, it will clarify the meaning of the exposed tunables that may be
of interest to power users.

Each io queue has a set of io scheduler tunables associated with it. These
tunables control how the io scheduler works. You can find these entries
in:

/sys/block/<device>/iosched

assuming that you have sysfs mounted on /sys. If you don't have sysfs mounted,
you can do so by typing:

# mount none /sys -t sysfs


********************************************************************************


read_expire	(in ms)
-----------


The goal of the deadline io scheduler is to attempt to guarentee a start
service time for a request. As we focus mainly on read latencies, this is
tunable. When a read request first enters the io scheduler, it is assigned
a deadline that is the current time + the read_expire value in units of
miliseconds.


fifo_batch
----------

When a read request expires its deadline, we must move some requests from
the sorted io scheduler list to the block device dispatch queue. fifo_batch
controls how many requests we move, based on the cost of each request. A
request is either qualified as a seek or a stream. The io scheduler knows
the last request that was serviced by the drive (or will be serviced right
before this one). See seek_cost and stream_unit.


seek_cost
---------

The cost of a seek compared to a stream_unit (see below).


stream_unit	(in KiB)
-----------

How many KiB we qualify as a single stream unit. A stream unit has a cost of
1, so if a request is X KiB big, it has a cost of

	cost = (X + stream_unit - 1) / stream_unit

stream_unit, seek_cost, and fifo_batch control how many requests we
potentially move to the dispatch queue when a request expires.


write_starved	(number of dispatches)
-------------

When we have to move requests from the io scheduler queue to the block
device dispatch queue, we always give a preference to reads. However, we
don't want to starve writes indefinitely either. So writes_starved controls
how many times we give preference to reads over writes. When that has been
done writes_starved number of times, we dispatch some writes based on the
same criteria as reads.


front_merges	(bool)
------------

Sometimes it happens that a request enters the io scheduler that is contigious
with a request that is already on the queue. Either it fits in the back of that
request, or it fits at the front. That is called either a back merge candidate
or a front merge candidate. Due to the way files are typically laid out,
back merges are much more common than front merges. For some work loads, you
may even know that it is a waste of time to spend any time attempting to
front merge requests. Setting front_merges to 0 disables this functionality.
Front merges may still occur due to the cached last_merge hint, but since
that comes at basically 0 cost we leave that on. We simply disable the
rbtree front sector lookup when the io scheduler merge function is called.


Nov 11 2002, Jens Axboe <axboe@suse.de>


--wac7ysb48OaltWcw--
