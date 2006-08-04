Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWHDF3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWHDF3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWHDF3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:29:40 -0400
Received: from brick.kernel.dk ([62.242.22.158]:32796 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030260AbWHDF3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:29:40 -0400
Date: Fri, 4 Aug 2006 07:30:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [2/2] Add the Elevator I/O scheduler
Message-ID: <20060804053021.GB4717@suse.de>
References: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03 2006, Nate Diller wrote:
> This is the Elevator I/O scheduler.  It is a simple one-way elevator,
> with a couple tunables for reducing latency or starvation.  It also
> has a performance-oriented tracing facility to help debug strange or
> specialized workloads.
> 
> This also adds a new merge call to the iosched API.
> 
> Tested and benchmarked extensively on several platforms with several
> disk controllers and multiple brands of disk.  Subsequently ported
> forward from 2.6.14, compile and boot tested on 2.6.18-rc1-mm2.

So where are these benchmarks?

> diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/elevator-iosched.c
> linux-dput/block/elevator-iosched.c
> --- linux-2.6.18-rc1-mm2/block/elevator-iosched.c	1969-12-31
> 16:00:00.000000000 -0800
> +++ linux-dput/block/elevator-iosched.c	2006-08-02 
> 18:04:52.000000000 -0700
> @@ -0,0 +1,1182 @@
> +/*
> + *  linux/block/elevator-iosched.c
> + *
> + *  Elevator I/O scheduler.  This implementation is intended to be much

[snip]

That's a huge chunk of text, can we please put the Hans speak somewhere
else? In-file documentation is fine if it explains what the
file/algorithm does, lets not fill it with pages of stuff.

For the remainder of the file - way too many macros, too much ?: usage,
kill the "nate" printk prefixes, remove the alias front sector
condition.

Also, rename it, don't call it "elevator". We have enough naming
confusing as it is.

> diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/Kconfig.iosched
> linux-dput/block/Kconfig.iosched
> --- linux-2.6.18-rc1-mm2/block/Kconfig.iosched	2006-07-18
> 14:52:29.000000000 -0700
> +++ linux-dput/block/Kconfig.iosched	2006-08-02 17:40:01.000000000 -0700
> @@ -38,21 +38,55 @@ config IOSCHED_CFQ
> 	  among all processes in the system. It should provide a fair
> 	  working environment, suitable for desktop systems.
> 
> +config IOSCHED_ELEVATOR
> +	tristate "Elevator I/O scheduler"
> +	default y
> +	---help---
> +	  This is a simple BSD style one-way elevator.  It avoids the 
> complexity
> +	  of deadlines, and uses a limit on contiguous I/O sectors to keep 
> things
> +	  moving and reduce latency.

deadlines are a simply fifo, it's by no stretch of the imagination a
"complexity". Please fixup this entry.

> +config IOSCHED_EL_SSTF
> +	bool "Alternate Heuristic: Shortest Seek Time First" if 
> IOSCHED_ELEVATOR
> +	default n
> +	---help---
> +	  Elevator normally uses the C-SCAN one-way elevator algorithm,
> +	  which is useful in most situations to avoid queue congestion and
> +	  request starvation.  In some cases, SSTF might be higher
> +	  performance, particularly with certain localized workloads.
> +
> +	  If you don't know that you want this, you don't.

sysfs entry?

> +config IOSCHED_EL_PERF_DEBUG
> +	bool "Debug Elevator I/O performance" if IOSCHED_ELEVATOR
> +	default y
> +	---help---
> +	  This enables extra checking to ensure that Elevator I/O scheduling
> +	  is occurring without errors that could effect performance.  It
> +	  will print messages into the system log if it detects problems.
> +	  If your performance under Elevator is lower than you expect, or if
> +	  you would like to monitor for degradation, enable this option.
> +
> +	  This has negligible overhead, and does not change Elevator's 
> behavior.
> +
> choice
> 	prompt "Default I/O scheduler"
> -	default DEFAULT_CFQ
> +	default DEFAULT_AS
> 	help
> 	  Select the I/O scheduler which will be used by default for all
> 	  block devices.

Eh?

> @@ -2951,7 +2953,7 @@ get_rq:
> 		blk_plug_device(q);
> 	add_request(q, req);
> out:
> -	if (sync)
> +/*	if (sync)*/
> 		__generic_unplug_device(q);
> 
> 	spin_unlock_irq(q->queue_lock);

Huh?

-- 
Jens Axboe

