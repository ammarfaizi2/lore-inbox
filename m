Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTBJPM4>; Mon, 10 Feb 2003 10:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTBJPM4>; Mon, 10 Feb 2003 10:12:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8067 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261701AbTBJPMz>;
	Mon, 10 Feb 2003 10:12:55 -0500
Date: Mon, 10 Feb 2003 16:22:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SFQ disk scheduler
Message-ID: <20030210152226.GV12828@suse.de>
References: <20030210145001.GT12828@suse.de> <20030210151144.GT31401@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210151144.GT31401@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10 2003, Andrea Arcangeli wrote:
> On Mon, Feb 10, 2003 at 03:50:01PM +0100, Jens Axboe wrote:
> > Hi,
> > 
> > Here's a simple stochastic fairness queueing disk scheduler, for current
> > 2.5.59-BK. It has known limitations right now, mainly because I didn't
> > bother making it complete. But it should suffice for some rudimentary
> > testing, at least.
> 
> Cool, that was fast! ;)

It's pretty easy to do in 2.5 :-). A 2.4 backport is of course feasible,
but requires a bit more work (and possibly abstracting some of the
elevator stuff there).

> > I'm not going to go into great detail about how it works, see Andrea's
> > initial post of the paper referenced. This version may not be completely
> > true to the SFQ concept, but should be close enough I think. It divides
> > traffic into a fixed number of buckets (64 per default), and perturbs
> > the hash every 5 seconds (hash shamelessly borrowed from networking atm,
> > see comment).
> 
> I tend to think 5 seconds is too small, 30 sec would be better IMHO (it
> should be tested at bit).

It probably is too small, testing will show. I don't see too many
collisions from a dbench 32 or 64, so...

> > To avoid too many disk seeks, when it's time to dispatch requests to the
> > driver, we round robin all non-empty buckets and grab a single request
> > from each. These requests are sorted into the dispatch queue.
> > 
> > For performance reasons, io scheduler request merging is still a
> > per-queue function (and not per-bucket).
> 
> Unsure if it worth, but it probably it won't make that much difference,
> likely different workloads are working on different part of the disk
> anyways.

The rate of unrelated merging is typically quite low, so no it probably
doesn't provide much of a performance benefit. However, it also keeps
the code simpler to simply have a single merge hash per queue.

> > In closing, let me stress that this version has not really been tested
> > all that much. It passes simple SCSI and IDE testing, should work on any
> > hardware basically.
> 
> How does it feel?

I don't know yet, haven't booted it on my work station yet. Will do so
soon :)

-- 
Jens Axboe

