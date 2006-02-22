Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWBVOv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWBVOv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWBVOv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:51:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751299AbWBVOvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:51:25 -0500
Date: Wed, 22 Feb 2006 15:51:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: blktrace daemon vs LTTng lttd
Message-ID: <20060222145128.GG8852@suse.de>
References: <20060222030044.GB17987@Krystal> <20060222074805.GE8852@suse.de> <20060222142443.GA22548@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222142443.GA22548@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22 2006, Mathieu Desnoyers wrote:
> * Jens Axboe (axboe@suse.de) wrote:
> > blktrace currently uses read() to mmap'ed file buffers for local
> > storage, not read+write.
> 
> I see that blktrace uses fwrite() in write_data(). Isn't it a disk
> write scheme where you read() from the RelayFS channel and (f)write()
> to a file ? Oh, but the mmaped file is the output.. I see. However,
> you have to mmap/unmap the output file between each subbuffer, which
> costs you time.

That's just a coding thing, if it really was an issue I could mremap
extend it instead.

> > We could mmap both ends of course and just copy
> > the data, I'm not sure it would buy me a lot though. For local storage,
> > blktraces biggest worry is peturbing the vm/io side of things so we skew
> > the results of what we are tracing. That is usually more important than
> > using that extra 0.1% of cpu cycles, as most io tests are not CPU bound.
> > The sendfile() support should work now, so the preferred approach now
> > becomes using blktrace in net client mode and sendfile() the data out
> > without it ever being copied either in-kernel or to-user.
> > 
> 
> As I said earlier, using sendfile() or mmap+send() should lead to a similar
> result.

Not following, similar what result?

> > That said, the "complexity" of controlling produced/consumed numbers is
> > what has kept me away from doing mmap() of the relayfs buffers for
> > local storage.
> 
> Yes, it has been my reaction too.

Currently I just do sendfile() per subbuffer, if I just limit one
subbuffer in flight at the time, I can reliably use poll() to check
whether a new subbufer is available for transfer. I still do have to use
a relay control file to get the subbuffer padding at the end of the
subbuffer, if the trace info doesn't fully fill a subbuffer.

> > With an easier control mechanism in place, I might be
> > convinced to switch blktrace as well.
> > 
> 
> Well, if you want to try the current lttd disk dumper, it's quite
> simple : you fork from blktrace, exec lttd with 2-3 parameters and it
> will simply open recursively a directory structure, create the exact
> same trace directory structure as output, mmap each buffer and wait
> for data. It quits when the last buffer has hung up.
> 
> Once adapted to a network send(), I don't see any limitation in it's
> genericity.

It might be a slight improvement in the local trace case, however as I
said it's not really an issue for me. Even for the local trace case, the
read-to-mmap isn't close to being the top bottleneck for traces. As it
stands right now, there's little incentive for me to do anything :)

As mentioned, blktrace prefers sendfile() for the network side which is
still a win over send() as you'd still have to copy the data over. A
quick there here shows 0.5-0.6% more idle time with the sendfile()
approach over send(), with ~0.3% of that being copy_user_generic()
overhead.

> > > On another point, I looked at your timekeeping in blktrace and I think
> > > you could gain precision by using a monotonic clock instead of
> > > do_gettimeofday (which is altered by NTP).
> > 
> > I don't use gettimeofday() for time keeping, unless sched_clock() winds
> > up using that for some cases. Haven't looked much into that yet, but on
> > some systems the granularity of sched_clock() is jiffies which doesn't
> > work very well for us of course.
> > 
> > What does LTT use in the kernel?
> > 
> 
> I looked closely at the time keeping in the Kernel, and found out that
> cycles_2_ns was using a precomputed variable which was not precise
> enough for my needs, as it is computed with integers.
> 
> So I has two mode, one with and one without TSC. The simplest one is
> the TSC mode, where I get the TSC of the CPUs. I also log the cpu_khz
> variable at the beginning of the trace, so I can calculate the time
> myself from the tsc, but I do it later, in double precision with the
> analyser.
> 
> In non TSC case, I use the jiffies counter or'd with a logical clock.

Sounds like we can share some code there, I basically just used
sched_clock() as it was available and had good granularity on the
systems I tested then. An internal get_good_clock() that does the right
thing would be appreciated :)

-- 
Jens Axboe

