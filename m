Return-Path: <linux-kernel-owner+w=401wt.eu-S1762903AbWLKOHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762903AbWLKOHe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762909AbWLKOHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:07:34 -0500
Received: from brick.kernel.dk ([62.242.22.158]:9486 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762903AbWLKOHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:07:33 -0500
Date: Mon, 11 Dec 2006 15:08:45 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Avantika Mathur <mathur@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq performance gap
Message-ID: <20061211140845.GL4576@kernel.dk>
References: <1165536200.25180.1.camel@dyn9047017105.beaverton.ibm.com> <20061208120522.GN23887@kernel.dk> <1165615793.9200.11.camel@dyn9047017105.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165615793.9200.11.camel@dyn9047017105.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08 2006, Avantika Mathur wrote:
> On Fri, 2006-12-08 at 13:05 +0100, Jens Axboe wrote:
> > On Thu, Dec 07 2006, Avantika Mathur wrote:
> > > Hi Jens,
> > 
> > (you probably noticed now, but the axboe@suse.de email is no longer
> > valid)
> 
> I saw that, thanks!
> > > I've noticed a performance gap between the cfq scheduler and other io
> > > schedulers when running the rawio benchmark.
> > > Results from rawio on 2.6.19, cfq and noop schedulers:
> > >
> > > CFQ:
> > >
> > > procs           device    num read   KB/sec     I/O Ops/sec
> > > -----  ---------------  ----------  -------  --------------
> > >   16         /dev/sda       16412     8338            2084
> > > -----  ---------------  ----------  -------  --------------
> > >   16                        16412     8338            2084
> > >
> > > Total run time 0.492072 seconds
> > >
> > >
> > > NOOP:
> > >
> > > procs           device    num read   KB/sec     I/O Ops/sec
> > > -----  ---------------  ----------  -------  --------------
> > >   16         /dev/sda       16399    29224            7306
> > > -----  ---------------  ----------  -------  --------------
> > >   16                        16399    29224            7306
> > >
> > > Total run time 0.140284 seconds
> > >
> > > The benchmark workload is 16 processes running 4k random reads.
> > >
> > > Is this performance gap a known issue?
> > 
> > CFQ could be a little slower at this benchmark, but your results are
> > much worse than I would expect. What is the queueing depth of sda? How
> > are you invoking rawio?
> 
> I am running rawio with the following options:
> rawread -p 16 -m 1 -d 1 -x -z -t 0 -s 4096
>  
> The queue depth on sda is 4.
> 
> > 
> > Your runtime is very low, how does it look if you allow the test to run
> > for much longer? 30MiB/sec random read bandwidth seems very high, I'm
> > wondering what exactly is being tested here.
> > 
> 
> rawio is actually performing sequential reads, but I don't believe it is
> purely sequential with the multiple processes.
> I am currently running the test with longer runtimes and will post
> results once it is complete. 
> I've also attached the rawio source.

It's certainly the slice and idling hurting here. But at the same time,
I don't really think your test case is very interesting. The test area
is very small and you have 16 threads trying to read the same thing,
optimizing for that would be silly as I don't think it has much real
world relevance.

That said, I might add some logic to detect when we can cheaply switch
queues instead of waiting for a new request from the same queue.
Averaging slice times over a period of time instead of 1:1 with that
logic, should help cases like this while still being fair.

-- 
Jens Axboe

