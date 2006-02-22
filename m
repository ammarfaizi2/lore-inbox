Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWBVOYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWBVOYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWBVOYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:24:49 -0500
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:60909 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751293AbWBVOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:24:48 -0500
Date: Wed, 22 Feb 2006 09:24:43 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: blktrace daemon vs LTTng lttd
Message-ID: <20060222142443.GA22548@Krystal>
References: <20060222030044.GB17987@Krystal> <20060222074805.GE8852@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060222074805.GE8852@suse.de>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 09:09:14 up 15 days, 10:23,  4 users,  load average: 0.03, 0.59, 0.89
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (axboe@suse.de) wrote:
> blktrace currently uses read() to mmap'ed file buffers for local
> storage, not read+write.

I see that blktrace uses fwrite() in write_data(). Isn't it a disk write
scheme where you read() from the RelayFS channel and (f)write() to a file ? Oh,
but the mmaped file is the output.. I see. However, you have to mmap/unmap the
output file between each subbuffer, which costs you time.

> We could mmap both ends of course and just copy
> the data, I'm not sure it would buy me a lot though. For local storage,
> blktraces biggest worry is peturbing the vm/io side of things so we skew
> the results of what we are tracing. That is usually more important than
> using that extra 0.1% of cpu cycles, as most io tests are not CPU bound.
> The sendfile() support should work now, so the preferred approach now
> becomes using blktrace in net client mode and sendfile() the data out
> without it ever being copied either in-kernel or to-user.
> 

As I said earlier, using sendfile() or mmap+send() should lead to a similar
result.

> That said, the "complexity" of controlling produced/consumed numbers is
> what has kept me away from doing mmap() of the relayfs buffers for
> local storage.

Yes, it has been my reaction too.

> With an easier control mechanism in place, I might be
> convinced to switch blktrace as well.
> 

Well, if you want to try the current lttd disk dumper, it's quite simple : you
fork from blktrace, exec lttd with 2-3 parameters and it will simply open
recursively a directory structure, create the exact same trace directory
structure as output, mmap each buffer and wait for data. It quits when the last
buffer has hung up.

Once adapted to a network send(), I don't see any limitation in it's genericity.


> > On another point, I looked at your timekeeping in blktrace and I think
> > you could gain precision by using a monotonic clock instead of
> > do_gettimeofday (which is altered by NTP).
> 
> I don't use gettimeofday() for time keeping, unless sched_clock() winds
> up using that for some cases. Haven't looked much into that yet, but on
> some systems the granularity of sched_clock() is jiffies which doesn't
> work very well for us of course.
> 
> What does LTT use in the kernel?
> 

I looked closely at the time keeping in the Kernel, and found out that
cycles_2_ns was using a precomputed variable which was not precise enough for my
needs, as it is computed with integers.

So I has two mode, one with and one without TSC. The simplest one is the TSC
mode, where I get the TSC of the CPUs. I also log the cpu_khz variable at the
beginning of the trace, so I can calculate the time myself from the tsc, but I
do it later, in double precision with the analyser.

In non TSC case, I use the jiffies counter or'd with a logical clock.


Mathieu

> -- 
> Jens Axboe
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
