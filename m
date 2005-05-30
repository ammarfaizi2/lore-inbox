Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVE3RXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVE3RXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVE3RXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:23:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1668 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261653AbVE3RXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:23:23 -0400
Date: Mon, 30 May 2005 16:20:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: [rfc: patch 0/6] scalable fd management
Message-ID: <20050530105042.GA5534@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is RFC-only at the moment, but if things look well,
I would like to see this patchset get some testing in -mm.

This patchset probably doesn't set the record for longest
gestation period, but I am still glad that we can use it
to solve a problem that a lot of people care about *now*.
Maneesh and I developed this patch in 2001
where we used somewhat dodgy locking and copious memory
barriers to demonstrate making file descriptor look-up
(then fget()) lock-free using RCU. The main advantage
was with threads, but there were other problems confronting threads
users then and I decided not to push for it. Since threads
performance is now important for a lot of people, it is
time to revisit the issue. Whether we like java or not, it
is a reality, so are threaded apps. Andrew Tridgell has a
test (http://samba.org/ftp/unpacked/junkcode/thread_perf.c)
which shows that on a 4-cpu P4 box, a "readwrite"
syscall test ran twice as fast using processes as threads.

An earlier version of this patchset was published and
discussed a few months ago :
(http://marc.theaimsgroup.com/?t=109144217400003&r=1&w=2)
The consensus there was that it makes sense to make
fget()/fget_light() lock-free in order to avoid the
cache line bouncing on ->files_lock typically when the fd table
is shared. The problem with that version of the patchset
was that it piggybacked on kref and complicated a simple
kref api meant for use with strict safety rules. It required
invasive changes to wherever f_count was being used. It also
used an RCU model from 2001 with explicit memory barriers
which we don't need to use anymore.

Recently, I rewrote the patchset with the following ideas :

1. Instead of using explicit memory barriers to make the fd table
   array and fdset updates appear atomic to lock-free readers,
   I split the fd table in files_struct and put it in a separate
   structure (struct fdtable). Whenever fd array/set expansion
   happens, I allocate a new fdtable, copy the contents and
   atomically update the pointer. This allows me to use
   the recent rcu_assign_pointer() and rcu_dereference() macros.
   Howver this required significant changes in file management
   code in VFS. With this new locking model, all the known issues
   of the past have been taken care of.

2. Greg and I agreed not to loosen the kref apis. Instead I wrote
   a set of rcuref APIs that work on a regular atomic_t counters.
   This is *not* a separate refcounting API set, it is meant for
   use in regular refcounters when needed with RCU. With this,
   f_count users, however wrong they are, are spared. There is
   a separate patchset to clean some of them up, but that does not
   affect this patchset.

3. I added documentation for both the rcuref apis and for the new
   locking model I used for file descriptor table and file
   reference counting.


Testing :
-------
I have been beating up this patchset with multiplce instances of
LTP and a special test I wrote to exercise the vmalloced fdtable
path that uses keventd for freeing. It has survived 24+ hour
tests as well as a 72 hour run with chat benchmark
and fd_vmalloc tests. All this was on a 4(8)-way P4 xeon
system.

No slab leak or vmalloc leak.

I would appreciate if someone tests this on an arch without
cmpxchg (sparc32??). I intend to run some more tests
with preemption enabled and also on ppc64 myself.

Performance results :
-------------------

tiobench on a 4(8)-way (HT) P4 system on ramdisk :

					(lockfree)
Test		2.6.10-vanilla	Stdev 	2.6.10-fd	Stdev
-------------------------------------------------------------
Seqread		1400.8	  	11.52	1465.4		34.27
Randread	1594  		8.86	2397.2		29.21
Seqwrite	242.72      	3.47	238.46		6.53
Randwrite	445.74		9.15	446.4		9.75

With Tridge's thread_perf test on a 4(8)-way (HT) P4 xeon system :

2.6.12-rc5-vanilla :

Running test 'readwrite' with 8 tasks
Threads     0.34 +/- 0.01 seconds
Processes   0.16 +/- 0.00 seconds

2.6.12-rc5-fd :

Running test 'readwrite' with 8 tasks
Threads     0.17 +/- 0.02 seconds
Processes   0.17 +/- 0.02 seconds

So, the lock-free file table patchset gets rid of the overhead
of doing I/O with thread.

Thanks
Dipankar
