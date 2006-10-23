Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWJWUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWJWUBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWJWUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:01:15 -0400
Received: from brick.kernel.dk ([62.242.22.158]:45072 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965100AbWJWUBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:01:14 -0400
Date: Mon, 23 Oct 2006 22:02:21 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061023200220.GB4281@kernel.dk>
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453D05C3.7040104@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2006, Martin Peschke wrote:
> Jens Axboe wrote:
> >On Sat, Oct 21 2006, Martin Peschke wrote:
> >>This patch set makes the block layer maintain statistics for request
> >>queues. Resulting data closely resembles the actual I/O traffic to a
> >>device, as the block layer takes hints from block device drivers when a
> >>request is being issued as well as when it is about to complete.
> >>
> >>It is crucial (for us) to be able to look at such kernel level data in
> >>case of customer situations. It allows us to determine what kind of
> >>requests might be involved in performance situations. This information
> >>helps to understand whether one faces a device issue or a Linux issue.
> >>Not being able to tap into performance data is regarded as a big minus
> >>by some enterprise customers, who are reluctant to use Linux SCSI
> >>support or Linux.
> >>
> >>Statistics data includes:
> >>- request sizes (read + write),
> >>- residual bytes of partially completed requests (read + write),
> >>- request latencies (read + write),
> >>- request retries (read + write),
> >>- request concurrency,
> >
> >Question - what part of this does blktrace currently not do?
> 
> The Dispatch / Complete events of blktrace aren't as accurate as
> the additional "markers" introduced by my patch. A request might have
> been dispatched (to the block device driver) from the block layer's
> point of view, although this request still lingers in the low level
> device driver.
> 
> For example, the s390 DASD driver accepts a small batch of requests
> from the block layer and translates them into DASD requests. Such DASD
> requests stay in an internal queue until an interrupt triggers the DASD
> driver to issue the next ready-made DASD request without further delay.
> Saving on latency.
> 
> For SCSI, the accuracy of the Dispatch / Complete events of blktrace
> is not such an issue, since SCSI doesn't queue stuff on its own, but
> reverts to queues implemented in SCSI devices. Anyway, command pre-
> and postprocessing in the SCSI stack adds to the latency that can be
> observed through the Dispatch / Complete events of blktrace.
> 
> Of course, the addition of two events to blktrace could fix that.

Right, that's pretty close to what I am thinking :-)

> > In case it's missing something, why not add it there instead of
> > putting new trace code in?
> 
> The question is:
> Is blktrace a performance tool? Or a development tool, or what?

I hope it's flexible enough to do both. I certainly have used it for
both. Others use it as a performance tool.

> Our tests indicate that the blktrace approach is fine for performance
> analysis as long as the system to be analysed isn't too busy.
> But once the system faces a consirable amount of non-sequential I/O
> workload, the plenty of blktrace-generated data starts to get painful.

Why haven't you done an analysis and posted it here? I surely cannot fix
what nobody tells me is broken or suboptimal. I have to say it's news to
me that it's performance intensive, tests I did with Alan Brunelle a
year or so ago showed it to be quite low impact. We don't even do any
sort of locking in the log path and everything is per-CPU.

> The majority of the scenarios that are likely to become subject of a
> performance analysis due to some customer complaint fit into the
> category of workloads that will be affected by the activation of
> blktrace.

Any sort of change will impact the running system, that's a given.

> If the system runs I/O-bound, how to write out traces without
> stealing bandwith and causing side effects?

You'd be silly to locally store traces, send them out over the network.

> And if CPU utilisation is high, how to make sure that blktrace
> tools get the required share without seriously impacting
> applications which are responsible for the workload to be analysed?

The only tool running locally is blktrace, and if you run in remote mode
it doesn't even touch the data. So far I see a lot of hand waving,
please show me some real evidence of problems you are seeing. First of
all, you probably need to investigate doing remote logging.

> How much memory is reqired for per-cpu and per-device relay buffers
> and for the processing done by blktrace tools at run time?

That's a tough problem, I agree. There's really no way to answer that
without doing tests. The defaults should be good enough for basically
anything you throw at it, if you lose events they are not.

> What if other subsystems get rigged with relay-based traces,
> following the blktrace example? I think that's okay - much better
> than cluttering the printk buffer with data that doesn't necessarily
> require user attention. I am advocating the renovation of
> arch/s390/kernel/debug.c - a tracing facility widely used throughout
> the s390 code - so that it is switched over to blktrace-like techniques,
> (and ideally shares code and is slimmed down).
> 
> With blktrace-like (utt-based?) tracing facilities the data
> stream will swell. But if those were required to get an overview
> about the performance of subsystems or drivers...
> 
> In my opinion, neither trace events relayed to user space nor
> performance counters maintained in the kernel are the sole answer
> to all information needs. The trick is to deliberate about 'when to
> use which approach what for'. Performance counters should give
> directions for further investigation. Traces are fine for debugging
> a specific subsystem.

Your problem seems dasd specific so far, so probably the best solution
(if you can't/won't use blktrace) is to keep it there.

-- 
Jens Axboe

