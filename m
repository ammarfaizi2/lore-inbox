Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSKJTcq>; Sun, 10 Nov 2002 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265144AbSKJTcp>; Sun, 10 Nov 2002 14:32:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:44227 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265143AbSKJTcl>;
	Sun, 10 Nov 2002 14:32:41 -0500
Message-ID: <3DCEB5E7.5147A449@digeo.com>
Date: Sun, 10 Nov 2002 11:39:19 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de> <20021110150626.GI23425@holomorphy.com> <20021110155851.GL31134@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2002 19:39:20.0141 (UTC) FILETIME=[DD04E7D0:01C288F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> Complete diff against 2.5.46-BK current attached.
> 
> [rbtree IO scheduler.. ]
>

Well it's nice to see 250 megabytes under writeback to a single
queue, but this could become a bit of a problem:

	blkdev_requests:     5760KB     5767KB   99.86

(gdb) p sizeof(struct request)
$1 = 136

On a Pentium 4, that will be rounded up to 256 bytes, so it'd be
up around 10 megabytes.  Now imagine 200 disks....

Putting struct request on a diet would help - get it under 128
bytes.  Also, I'd suggest that SLAB_HWCACHE_ALIGN not be used in
the blkdev_requests slab.

(SLAB_HWCACHE_ALIGN is waaaay overused, btw)

But we'll still have a problem with hundreds of disks.

Of course, I'm assuming that there's a significant benefit
in having 1024 requests.  Perhaps there isn't, so we don't have
a problem.  But if it _is_ good (and for some things it will be),
we need to do something sterner.

It is hard to justify 1024 read requests, so the read pool and the
write pool could be split up.  128 read requests, 1024 write requests.

Still not enough.

Now, 1024 requests is enough to put up to 512 megabytes of memory
under I/O.  Which is cool, but it is unlikely that anyone would want
to put 512 megs under IO against 200 disks at the same time.

Which means that we need a common pool.  Maybe a fixed pool of 128
requests per queue, then any additional requests should be dynamically
allocated on a best-effort basis.  A mempool-per-queue would do that
quite neatly.  (Using GFP_ATOMIC & ~_GFP_HIGH). The throttling code
would need some rework.

All of which is a bit of a hassle.  I'll do an mm3 later today which
actually has the damn code in it and let's get in and find out whether
the huge queue is worth pursuing.
