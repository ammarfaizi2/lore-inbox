Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272146AbRHVWYL>; Wed, 22 Aug 2001 18:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272148AbRHVWYD>; Wed, 22 Aug 2001 18:24:03 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:36082 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S272146AbRHVWXv>; Wed, 22 Aug 2001 18:23:51 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F29@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: The cause of the "VM" performance problem with 2.4.X
Date: Wed, 22 Aug 2001 17:23:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew!  I'll try out your patch shortly, and I'll let you
know how it goes.

> Note how fsync_dev() passes the target device to sync_buffers().  But
> the dirty buffer list is global.  So to write out the dirty buffers
> for a particular device, write_locked_buffers() has to do a linear
> walk of the dirty buffers for *other* devices to find the target
> device.

I had just figured that out.  I hadn't changed the code yet, though.

The other thing that exacerbates the start-from-0 approach is only
flushing 32 blocks at a time.  Especially if we take a long time to
find the first one because of the linear search, not doing much
work once we get there is also a problem.

> And write_unlocked_buffers() uses a quite common construct - it
> scans a list but when it drops the lock, it restarts the scan
> from the start of the list.  (We do this all over the kernel, and
> it keeps on biting us).

It sounds like we want a per-device list, not a global (linear) one.
But I'm sure there are other places in the kernel where the per-
device list would introduce problems (but would make things like
sync() better, since we could flush all devices more in parallel).
But there are probably also problems there when scaling to 100's or
1000's of disks.

> So if the dirty buffer list has 10,000 buffers for device A and
> then 10,000 buffers for device B, and you call fsync_dev(B),
> we end up traversing the 10,000 buffers of device A 10,000/32 times,
> which is a lot.
> 
> In fact, write_unlocked_buffers(A) shoots itself in the foot by
> moving buffers for device A onto BUF_LOCKED, and then restarting the
> scan.  So of *course* we end up with zillions on non-A buffers at the
> head of the list.

Is it safe to restart from the middle of the list after dropping
the lock?  It looks like you try to solve that problem by only using
the hint if the block is still on the dirty list.

I was going to cache that per-device info globally as a quick hack;
I was thinking about hanging it off the kdev_t, since I didn't want
a fixed-size array in write_some_buffers(), but your approach of just
having the caller track it works too.


I'm off to try the patch...


But before I go, here is another profile run, but without your patch,
to validate your hypothesis (seem to have lost several interrupts)

[ia64_spinlock_contention is time spinning on a spinlock (you know
which one); myskupbuffer1 is called each time it "skips" a buffer
in the LRU list (no dev match).
Note that in this case, 26000 elements are skipped on the "average"
call to write_some_buffers.]

Each sample counts as 0.000976562 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 50.36     40.43    40.43
ia64_spinlock_contention
 23.98     59.68    19.25     2658     7.24     8.17  write_some_buffers
 17.10     73.40    13.72                             cg_record_arc
  4.48     77.00     3.59                             mcount
  1.36     78.09     1.10    85039     0.01     0.01  _make_request
  0.82     78.75     0.66 69385716     0.00     0.00  myskipbuffer1
  0.77     79.37     0.62    85039     0.01     0.01  blk_get_queue

index % time    self  children    called     name
                                                 <spontaneous>
[1]     52.7   40.43    0.00                 ia64_spinlock_contention [1]
-----------------------------------------------
                2.68    0.34     370/2658        sync_old_buffers [11]
               16.57    2.12    2288/2658        write_unlocked_buffers [6]
[2]     28.3   19.25    2.47    2658         write_some_buffers [2]
                0.00    1.77    2658/2658        write_locked_buffers [12]
                0.66    0.00 69385716/69385716     myskipbuffer1 [16]
                0.01    0.01   85056/123329      _refile_buffer [54]
                0.01    0.00   85056/130255      _insert_into_lru_list [70]
                0.01    0.00   85056/85056       myatomic_set_buffer_clean
[93]
                0.00    0.00   85056/85056       my__refile_buffer [104]
                0.00    0.00   85056/85056       mytest_and_set_bit [113]
                0.00    0.00    2658/418442      spin_unlock_ [97]
-----------------------------------------------


Kevin Van Maren
