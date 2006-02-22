Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWBVHsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWBVHsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBVHsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:48:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38949 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932235AbWBVHsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:48:05 -0500
Date: Wed, 22 Feb 2006 08:48:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: blktrace daemon vs LTTng lttd
Message-ID: <20060222074805.GE8852@suse.de>
References: <20060222030044.GB17987@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222030044.GB17987@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21 2006, Mathieu Desnoyers wrote:
> Hi M. Axboe,
> 
> Tom Zanussi just informed me of your work of blktrace. I think that
> some aspects of our respective projects (mine being LTTng) shows
> resemblances.
> 
> LTTng is a system wide tracer that aims at tracing programs/librairies
> and the kernel. There is a version currently available at
> http://ltt.polymtl.ca. Is has a viewer counterpart (LTTV) that
> analyses and show graphically the traces takes by LTTng.
> 
> I just looked at the blktrace code, and here are some parts we share :
> 
> - We both use RelayFS for data transfer to user space.
> - We both need to get highly precise timestamps.

That's true.

> Where LTTng might have more constraints is on the performance and
> reentrancy side : my tracer is NMI reentrant (using atomic operations)
> and must be able to dump data at a rate high enough to sustain a
> loopback ping flood (with interrupts logged). Time precision must
> permit to reorder events occuring very closely on two different CPUs.

I don't think we differ a lot there, actually. blktrace also needs to be
minimum impact - for the cases where we are not io bound (eg queueing
io), the logging rate can be quite high.

> I already developed a multithreaded daemon (lttd) that generically reads the
> RelayFS channels : it uses mmap() and 4 ioctl() to control the channel
> buffers. I just discussed it with Tom Zanussi in the following thread :
> 
> http://www.listserv.shafik.org/pipermail/ltt-dev/2006-February/001245.html
> 
> Here is the argumentation I gave to justify the use of ioctl() for RelayFS
> channels (in the same discussion) :
> 
> http://www.listserv.shafik.org/pipermail/ltt-dev/2006-February/001247.html
> 
> I suggest to integrate my ioctl addition to the RelayFS channels so
> they can be used very efficiently with both mmap() and ioctl() to
> control the reader.
> 
> It would be trivial to use send() instead of write() to adapt lttd to
> the networked case. 
> 
> Using mmap() and write() instead or read() and write() would eliminate
> the extra copy blktrace is doing when it writes to disk.

blktrace currently uses read() to mmap'ed file buffers for local
storage, not read+write. We could mmap both ends of course and just copy
the data, I'm not sure it would buy me a lot though. For local storage,
blktraces biggest worry is peturbing the vm/io side of things so we skew
the results of what we are tracing. That is usually more important than
using that extra 0.1% of cpu cycles, as most io tests are not CPU bound.
The sendfile() support should work now, so the preferred approach now
becomes using blktrace in net client mode and sendfile() the data out
without it ever being copied either in-kernel or to-user.

That said, the "complexity" of controlling produced/consumed numbers is
what has kept me away from doing mmap() of the relayfs buffers for
local storage. With an easier control mechanism in place, I might be
convinced to switch blktrace as well.

> On another point, I looked at your timekeeping in blktrace and I think
> you could gain precision by using a monotonic clock instead of
> do_gettimeofday (which is altered by NTP).

I don't use gettimeofday() for time keeping, unless sched_clock() winds
up using that for some cases. Haven't looked much into that yet, but on
some systems the granularity of sched_clock() is jiffies which doesn't
work very well for us of course.

What does LTT use in the kernel?

-- 
Jens Axboe

