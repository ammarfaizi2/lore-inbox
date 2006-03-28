Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWC1LHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWC1LHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWC1LHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:07:05 -0500
Received: from fmr17.intel.com ([134.134.136.16]:35207 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932185AbWC1LHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:07:04 -0500
Date: Tue, 28 Mar 2006 03:06:39 -0800
From: Valerie Henson <val.henson@intel.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: Load average calculation?
Message-ID: <20060328110637.GB16173@goober>
References: <20060328105612.GA17094@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328105612.GA17094@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 11:56:12AM +0100, Russell King wrote:
> 
> So, the question becomes - should a lot of network activity contribute
> to the system load average, thereby denying other services from
> performing their usual business.

Another case where simply counting up all processes in D state results
in an unreasonable load average is the "NFS server stops responding"
case.  Even though all threads doing I/O to the NFS server are totally
inactive until the server comes back, they are all stuck in D state -
and counting towards the load average.

What these cases have in common is interesting: in both cases, the
thread is throttled by an external machine.  We're not waiting on I/O
that is taking up resources locally and therefore should be counted as
part of load average; we're waiting for some other machine to free up
enough resources that we can push some data down the pipe.

The comment for io_schedule() suggests that this case has received
some thought:

/*
 * This task is about to go to sleep on IO.  Increment rq->nr_iowait so
 * that process accounting knows that this is a task in IO wait state.
 *
 * But don't do that if it is a deliberate, throttling IO wait (this task
 * has set its backing_dev_info: the queue against which it should throttle)
 */
void __sched io_schedule(void)
{
	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());

	atomic_inc(&rq->nr_iowait);
	schedule();
	atomic_dec(&rq->nr_iowait);
}

The code and comment are out of sync and in any case don't help us
here.

Possible solution: Maybe sync_page should take into account whether
this is an NFS file or TCP sendfile page and call schedule() instead of
io_schedule() in these cases?

-VAL
