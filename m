Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbTCOGyp>; Sat, 15 Mar 2003 01:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbTCOGyp>; Sat, 15 Mar 2003 01:54:45 -0500
Received: from holomorphy.com ([66.224.33.161]:41936 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261407AbTCOGyo>;
	Sat, 15 Mar 2003 01:54:44 -0500
Date: Fri, 14 Mar 2003 23:05:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315070511.GQ20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315054910.GN20188@holomorphy.com> <20030315062025.GP20188@holomorphy.com> <20030314224413.6a1fc39c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314224413.6a1fc39c.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Looks like dbench doesn't scale. It needs to learn how to spread itself
>> across disks if it's not to saturate a device queue while at the same
>> time generating enough cpu load to saturate cpus.

On Fri, Mar 14, 2003 at 10:44:13PM -0800, Andrew Morton wrote:
> Nope.  What we're trying to measure here is pure in-memory lock contention,
> locked bus traffic, context switches, etc, etc.  To do that we need to get
> the IO system out of the picture.
> One way to do that is to increase /proc/sys/vm/dirty_ratio and
> dirty_background_ratio to 70% or so.  You can still hit IO wait if someone
> tries to truncate a file which pdflush is writing out, so increase
> dirty_expire_centisecs and dirty_writeback_centisecs to 1000000000 or so...
> Then, on the second run, when all the required metadata blocks are in
> pagecache you should be able to get an IO-free run.

Oh, sorry, I did increase dirty_ratio and dirty_background_ratio to 99,
I forgot about dirty_writeback_centisecs though, I'll re-run with that.

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Is there a better (publicable/open/whatever) benchmark?

On Fri, Mar 14, 2003 at 10:44:13PM -0800, Andrew Morton wrote:
> I have lots of little testlets which can be mixed and matched.  RAM-only
> dbench will do for the while.  It is showing things.
> 

William Lee Irwin III <wli@holomorphy.com> wrote:
>> dbench 128:
>> Throughput 161.237 MB/sec 128 procs
>> dbench 128 2>& 1  143.85s user 3311.10s system 1219% cpu 4:43.27 total
>> vma      samples  %-age       symbol name
>> c0106ff4 9134179  33.7261     default_idle
>> c01dc3b0 5570229  20.5669     __copy_to_user_ll
>> c01dc418 1773600  6.54865     __copy_from_user_ll
>> c0119058 731524   2.701       try_to_wake_up
>> c0108140 686952   2.53643     .text.lock.semaphore
>> c011a1bc 489415   1.80706     schedule
>> c0119dac 485196   1.79149     scheduler_tick
>> c011fadc 448048   1.65433     profile_hook
>> c0119860 356065   1.3147      load_balance
>> c0107d0c 267333   0.987072    __down
>> c011c4ff 249627   0.921696    .text.lock.sched

On Fri, Mar 14, 2003 at 10:44:13PM -0800, Andrew Morton wrote:
> The wakeup and .text.lock.semaphore load indicates that there is a lot
> of contention for a semaphore somewhere.  Still.
> I'm not sure which one.  It shouldn't be a directory semaphore.  Might be
> lock_super() in the inode allocator, but that seems unlikely.

I'm going to have to break out tools to decipher which one this is.
hlinder forward-ported lockmeter so I'll throw that in the mix.


-- wli
