Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbTDDSy0 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263908AbTDDSy0 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:54:26 -0500
Received: from [65.198.37.67] ([65.198.37.67]:2995 "EHLO funky.gghcwest.com")
	by vger.kernel.org with ESMTP id S263907AbTDDSyX (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:54:23 -0500
Date: Fri, 4 Apr 2003 11:05:50 -0800
From: Jeffrey Baker <jwbaker@acm.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance degradation from 2.4.17 to 2.4.21-pre5aa2
Message-ID: <20030404190550.GB25891@heat>
References: <20030404181648.GA23281@heat> <20030404184059.GR16293@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404184059.GR16293@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 08:40:59PM +0200, Andrea Arcangeli wrote:
> On Fri, Apr 04, 2003 at 10:16:48AM -0800, Jeffrey Baker wrote:
> > 
> > I guess the punch line is that the kernel can look good on
> > paper but be a stinker in reality.  I've since moved the
> 
> well, those numbers are paper yes, but they're generated in real life
> with some of the best and most reliable open benchmarks that I'm aware
> of (peraphs with the exception of dbench, that at least when read alone
> doesn't tell you the whole picture, but it's still good to benchmark the
> writeback cache changes across otherwise unchanged kernels).

Of course.  My only point is the old nugget that the only
useful benchmark is your own actual workload.

> can you check if:
> 
> 	echo 1000 >/proc/sys/vm/vm_mapped_ratio

Will try this.

> helps? That can be enabled very safely, there's no downside except it'll
> swap less.
> 
> Also make sure the 3400M of cache aren't all shared memory (not sure if
> mysql provides a very large memory model), in such case you may be
> bitten by the lowmem reservation, in such case you can boot with this
> parameter passed to the kernel via grub or lilo:

Not sure how to determine this.  Postgresql is using 512MB
shared memory total.  This is configured in postgresql.conf.
I'm not certain how mysql uses shared memory.  I do know
that it doesn't bother mmaping its data files.

> 	lower_zone_reserve=256,256
> 
> Then it will reserve less lowmem and it'll give you more ram to allocate
> in shm (see your "free is now around 100M, it can go down to 20M or so
> with such parameter, giving you 80M back that can make a difference
> since you're only 200M into swap).

/proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  4124626944 4013682688 110944256        0 13500416 3556990976
Swap: 970571776 196100096 774471680
MemTotal:      4027956 kB
MemFree:        108344 kB
MemShared:           0 kB
Buffers:         13184 kB
Cached:        3381220 kB
SwapCached:      92404 kB
Active:         690052 kB
Inactive:      3021568 kB
HighTotal:     2113472 kB
HighFree:         4264 kB
LowTotal:      1914484 kB
LowFree:        104080 kB
SwapTotal:      947824 kB
SwapFree:       756320 kB
BigFree:             0 kB


> but it's not very recommended, since it can lead to normal zones
> shortages in some conditions (like pagetables filling zone normal, or
> anon memory and shm filling zone normal w/o swap). But you can give it a
> spin (it won't be less safe than 2.4.17 anyways)
> 
> Also I would be extremely interested to see the:
> 
> 	readprofile -m /boot/System.map-2.4.21-pre5aa2 | sort -nr +2
> 	readprofile -m /boot/System.map-2.4.21-pre5aa2 | sort -nr

I can give you this in a few days.  I'm not at liberty to reboot the
machine.

> output, to see where you're spending all such system time, if it's
> swapping time walking pagetables or something else. the offender should
> definitely showup in the readprofile.

I actually think swap activity is minimal, despite the large amount
of swap used.  The disk with the swap (and root) filesystem has only
360242 commands since boot time, compared with 15 million commands
on the data disks.

> Would also be interesting if you could try a vanilla 2.4.21-pre5 (or
> pre6) and see if you get the same problem, many things have changed
> since 2.4.17, I don't touch drivers usually.

I don't know if this will be possible.

-jwb
