Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbTCOGeH>; Sat, 15 Mar 2003 01:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbTCOGeH>; Sat, 15 Mar 2003 01:34:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:1926 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261406AbTCOGeF>;
	Sat, 15 Mar 2003 01:34:05 -0500
Date: Fri, 14 Mar 2003 22:44:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030314224413.6a1fc39c.akpm@digeo.com>
In-Reply-To: <20030315062025.GP20188@holomorphy.com>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
	<m38yvixvlz.fsf@lexa.home.net>
	<20030315043744.GM1399@holomorphy.com>
	<20030314205455.49f834c2.akpm@digeo.com>
	<20030315054910.GN20188@holomorphy.com>
	<20030315062025.GP20188@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 06:44:05.0862 (UTC) FILETIME=[45FBF060:01C2EABE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Fri, Mar 14, 2003 at 08:54:55PM -0800, Andrew Morton wrote:
> > > `dbench 512' will presumably do lots of IO and spend significant
> > > time in I/O wait.  You should see the effects of this change more
> > > if you use fewer clients (say, 32) so it doesn't hit disk.
> > 
> On Fri, Mar 14, 2003 at 09:49:10PM -0800, William Lee Irwin III wrote:
> > Throughput 226.57 MB/sec 32 procs
> > dbench 32 2>& 1  25.04s user 515.02s system 1069% cpu 50.516 total
> 
> It's too light a load... here's dbench 128.

OK.

> Looks like dbench doesn't scale. It needs to learn how to spread itself
> across disks if it's not to saturate a device queue while at the same
> time generating enough cpu load to saturate cpus.

Nope.  What we're trying to measure here is pure in-memory lock contention,
locked bus traffic, context switches, etc, etc.  To do that we need to get
the IO system out of the picture.

One way to do that is to increase /proc/sys/vm/dirty_ratio and
dirty_background_ratio to 70% or so.  You can still hit IO wait if someone
tries to truncate a file which pdflush is writing out, so increase
dirty_expire_centisecs and dirty_writeback_centisecs to 1000000000 or so...

Then, on the second run, when all the required metadata blocks are in
pagecache you should be able to get an IO-free run.

> Is there a better (publicable/open/whatever) benchmark?

I have lots of little testlets which can be mixed and matched.  RAM-only
dbench will do for the while.  It is showing things.

> 
> dbench 128:
> Throughput 161.237 MB/sec 128 procs
> dbench 128 2>& 1  143.85s user 3311.10s system 1219% cpu 4:43.27 total
> 
> vma      samples  %-age       symbol name
> c0106ff4 9134179  33.7261     default_idle
> c01dc3b0 5570229  20.5669     __copy_to_user_ll
> c01dc418 1773600  6.54865     __copy_from_user_ll
> c0119058 731524   2.701       try_to_wake_up
> c0108140 686952   2.53643     .text.lock.semaphore
> c011a1bc 489415   1.80706     schedule
> c0119dac 485196   1.79149     scheduler_tick
> c011fadc 448048   1.65433     profile_hook
> c0119860 356065   1.3147      load_balance
> c0107d0c 267333   0.987072    __down
> c011c4ff 249627   0.921696    .text.lock.sched

The wakeup and .text.lock.semaphore load indicates that there is a lot
of contention for a semaphore somewhere.  Still.

I'm not sure which one.  It shouldn't be a directory semaphore.  Might be
lock_super() in the inode allocator, but that seems unlikely.


