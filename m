Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbTDDT4y (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTDDT4y (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:56:54 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:27278 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S261341AbTDDT4v (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:56:51 -0500
Date: Fri, 4 Apr 2003 22:07:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeffrey Baker <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance degradation from 2.4.17 to 2.4.21-pre5aa2
Message-ID: <20030404200749.GV16293@dualathlon.random>
References: <20030404181648.GA23281@heat> <20030404184059.GR16293@dualathlon.random> <20030404190550.GB25891@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404190550.GB25891@heat>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 11:05:50AM -0800, Jeffrey Baker wrote:
> On Fri, Apr 04, 2003 at 08:40:59PM +0200, Andrea Arcangeli wrote:
> > On Fri, Apr 04, 2003 at 10:16:48AM -0800, Jeffrey Baker wrote:
> > > 
> > > I guess the punch line is that the kernel can look good on
> > > paper but be a stinker in reality.  I've since moved the
> > 
> > well, those numbers are paper yes, but they're generated in real life
> > with some of the best and most reliable open benchmarks that I'm aware
> > of (peraphs with the exception of dbench, that at least when read alone
> > doesn't tell you the whole picture, but it's still good to benchmark the
> > writeback cache changes across otherwise unchanged kernels).
> 
> Of course.  My only point is the old nugget that the only
> useful benchmark is your own actual workload.

that's certainly the most interesting ;). Actually in this case it seems
a quite common workload too which makes it even more interesting. I'm
quite surprised you see a big regression.

> 
> > can you check if:
> > 
> > 	echo 1000 >/proc/sys/vm/vm_mapped_ratio
> 
> Will try this.
> 
> > helps? That can be enabled very safely, there's no downside except it'll
> > swap less.
> > 
> > Also make sure the 3400M of cache aren't all shared memory (not sure if
> > mysql provides a very large memory model), in such case you may be
> > bitten by the lowmem reservation, in such case you can boot with this
> > parameter passed to the kernel via grub or lilo:
> 
> Not sure how to determine this.  Postgresql is using 512MB
> shared memory total.  This is configured in postgresql.conf.
> I'm not certain how mysql uses shared memory.  I do know
> that it doesn't bother mmaping its data files.
> 
> > 	lower_zone_reserve=256,256

for the pure shm you can see /dev/shm and `ipcs`. For the regular
MAP_SHARED you'd need to have a look at /proc/pid/maps of mysql.

> > 
> > Then it will reserve less lowmem and it'll give you more ram to allocate
> > in shm (see your "free is now around 100M, it can go down to 20M or so
> > with such parameter, giving you 80M back that can make a difference
> > since you're only 200M into swap).
> 
> /proc/meminfo:
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  4124626944 4013682688 110944256        0 13500416 3556990976
> Swap: 970571776 196100096 774471680
> MemTotal:      4027956 kB
> MemFree:        108344 kB
> MemShared:           0 kB
> Buffers:         13184 kB
> Cached:        3381220 kB
> SwapCached:      92404 kB
> Active:         690052 kB
> Inactive:      3021568 kB
> HighTotal:     2113472 kB
> HighFree:         4264 kB
> LowTotal:      1914484 kB
> LowFree:        104080 kB
> SwapTotal:      947824 kB
> SwapFree:       756320 kB
> BigFree:             0 kB

this looks good. You're around 200M in swap, and you probably want to
avoid that. The suggestions of vm_mapped_ratio and lower_zone_reserve=
still looks the most appropriate here ;)

> 
> 
> > but it's not very recommended, since it can lead to normal zones
> > shortages in some conditions (like pagetables filling zone normal, or
> > anon memory and shm filling zone normal w/o swap). But you can give it a
> > spin (it won't be less safe than 2.4.17 anyways)
> > 
> > Also I would be extremely interested to see the:
> > 
> > 	readprofile -m /boot/System.map-2.4.21-pre5aa2 | sort -nr +2
> > 	readprofile -m /boot/System.map-2.4.21-pre5aa2 | sort -nr
> 
> I can give you this in a few days.  I'm not at liberty to reboot the
> machine.

you need to reboot to pass profile=2 to generate /proc/profile yes

> 
> > output, to see where you're spending all such system time, if it's
> > swapping time walking pagetables or something else. the offender should
> > definitely showup in the readprofile.
> 
> I actually think swap activity is minimal, despite the large amount
> of swap used.  The disk with the swap (and root) filesystem has only
> 360242 commands since boot time, compared with 15 million commands
> on the data disks.

It's minimal but there definitely was some swapin, and swapin are
often synchronous, so I don't exclude completely the slowdown is due
more swapping.

Would be interesting to see a /proc/meminfo with 2.4.17 and vmstat too
to see if it's swapping much less, or similar.

> 
> > Would also be interesting if you could try a vanilla 2.4.21-pre5 (or
> > pre6) and see if you get the same problem, many things have changed
> > since 2.4.17, I don't touch drivers usually.
> 
> I don't know if this will be possible.

Ok.

One more thing, if the db is doing lots of sync writes that makes the
async cache not very worthwhile, you could also try:

	echo 30 500 0 0 500 3000 40 20 0 >/proc/sys/vm/bdflush

to decrease the amount of dirty memory that can coexist at any given
time. I recall 2.4.17 was more restrictive on that.

But the most interesting will be the readprofile.

Andrea
