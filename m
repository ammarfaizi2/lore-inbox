Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSENAVl>; Mon, 13 May 2002 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSENAVk>; Mon, 13 May 2002 20:21:40 -0400
Received: from [195.223.140.120] ([195.223.140.120]:60768 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312426AbSENAVi>; Mon, 13 May 2002 20:21:38 -0400
Date: Tue, 14 May 2002 02:22:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE  56)
Message-ID: <20020514022238.J22902@dualathlon.random>
In-Reply-To: <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020514095214.040f5098@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 09:58:31AM +1000, Lincoln Dale wrote:
> At 01:19 PM 13/05/2002 +0200, Andrea Arcangeli wrote:
> >> so the above is:
> >>   blocks = 64K, bs=8k means 64000 x 8192-byte read()s = 524288000 bytes
> >>   blocks = 5K, bs=1m means 5000 x 1048576-byte read()s = 5242880000 bytes
> >
> >if the program is doing only what shown in the main loop, then you're
> >reading 10 times more data with O_DIRECT, that was my point in saying
> >64k*8k == 5k * 1M / 10, but I assume you took it into account (otherwise
> >it means O_DIRECT is just 5 times faster than buffered-I/O for you)
> 
> no- count them up above.
>   without O_DIRECT i was doing: 64000 x 8192 = 524288000 bytes
>   with O_DIRECT i was doing: 5000 x 1048576 = 524288000 bytes.
> 
> ie. same amount of data.

I don't mind the 1024/1000 difference, in this context let's assume
k=K,m=M and g=G, I only mind the 1 order of magintude difference. python
tells me:

	w/o O_DIRECT 64000 * 8192   = 524288000
	w/  O_DIRECT 5000 * 1048576 = 5242880000
					       ^ note the additional zero

they're both _bytes_, it's apples against apples.

You instead wrote:

	without O_DIRECT i was doing: 64000 x 8192 = 524288000
	with O_DIRECT i was doing: 5000 x 1048576  = 524288000

in the above you're losing a 0 at the end in the O_DIRECT case.

> regardless, the "mbyte/sec" is calculated at the very end.

So I assume the 1 order of magnitude difference didn't affect the
benchmark results anyways. That's quite expectable otherwise as said in
the earlier email O_DIRECT would be just running 5 times faster than
non-O_DIRECT :).

> >Also I would suggest to measure the time taken by the whole workload, not 
> >only
> >the time for read/write syscalls.
> 
> the time taken for the whole workload _is_ calculated at the very end of 
> the workload.  that way and "readahead" doesn't have an unfair advantage.
> i also have gettimeofday() calls to measure latency on a per-read or 
> per-write basis

Ok fine, by only reading the pseudocode of the main loop it wasn't
obvious (I mistaken the latency accounting for the global throughput
accounting). thanks for the clarification.

> ...
> >One thing I would also recommend is to write a threaded version of the 
> >program,
> >that reads or writes to all the /dev/sd disks simultaneously, first w/ 
> >O_DIRECT
> >then w/o O_DIRECT. The reason is that currently you aren't using all the 
> >disks
> >at once with O_DIRECT due the lack of async-io
> 
> i've thought about doing that - shame that there isn't an async version of 
> read().  the hard part is that i want to keep the disks at roughly the same 
> "block" at the same time, so there will still need to be some 
> syncronization of threads.
> otherwise, basic SCSI id priority means that it won't be fair across all 
> disks.  (remeber that i'm also attempting to measure latency)
> 
> ...
> >Since you "stripe" by hand in all disks you do a different workload than my
> >previous benchs and you definitely want to keep all the harddisk running 
> >at the
> >same time. I would also suggest to benchmark a single disk, to see if there 
> >is
> >still such a big performance difference (again: including the cost outside 
> >the
> >syscalls too).
> 
> a single-disk means we hit the performance limits of a single disk 
> spindle.  ie. around 45mbyte/sec sustained throughput.
> if you don't think there's any real overhead in the MD driver, i'll just 
> use that instead for now. (raid-0)

I think raid0 is a good start to make all disks running at the same time
for O_DIRECT too (only make sure to use a buffer large nr_PV*512k or
nr_PV*1M to allow the generation of large dma transactions to each
disk). The overhead of raid-0 shouldn't be noticeable, it should be
minimal compared to the overhead of the 1k bhs.

Andrea
