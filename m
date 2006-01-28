Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWA1SnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWA1SnS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWA1SnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:43:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19609 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932528AbWA1SnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:43:18 -0500
Date: Sun, 29 Jan 2006 00:12:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-ID: <20060128184245.GE5633@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com> <43D92DD6.6090607@cosmosbay.com> <20060127145412.7d23e004.akpm@osdl.org> <20060127231420.GA10075@us.ibm.com> <20060127152857.32066a69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127152857.32066a69.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 03:28:57PM -0800, Andrew Morton wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >
> > > > I am using a patch that seems sligthly better : It removes the filp_count_lock 
> > > > as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
> > > > can be off with a delta of +/- 16*num_possible_cpus()
> > > 
> > > Yes, I think that is better.
> > 
> > I agree that Eric's approach likely improves performance on large systems
> > due to decreased cache thrashing.  However, the real problem is getting
> > both good throughput and good latency in RCU callback processing, given
> > Lee Revell's latency testing results.  Once we get that in hand, then
> > we should consider Eric's approach.

Lee's problem now seems to be fixed with my rcu-rt-flush-list patch.
So, atleast for now we can keep that issue aside.

> Dipankar's patch risks worsening large-SMP scalability, doesn't it? 
> Putting an atomic op into the file_free path?

It does. However I didn't see any degradation running kernbench
on a 4-way box a few months ago when I had originally written
this patch. It would be nice if someone from SGI can give
this a spin on a really big machine.

It is not as if we didn't have costly operations. Under memory
pressure, we would probably have been acquiring the file_count_lock
quite often. That lock is now gone. That said, I would like to
get a lazy percpu counter implementation done at some point
in time. So far, I have just kept the things simple.

> And afaict it fixes up the skew in the nr_files accounting but we're still
> exposed to the risk of large amounts of memory getting chewed up due to RCU
> latencies?

That is hopefully fixed by my rcu-batch-tuning patch. I tested it using
a program that does open()/close() of /dev/null in a tight
loop. [x86_64 3.6GHz]

> (And it forgot to initialise the atomic_t)

I declared it static. Isn't that sufficient ?

> (And has a couple of suspicious-looking module exports.  We don't support
> CONFIG_PROC_FS=m).

Where ? All proc functions are wrapped in #ifdef CONFIG_PROC_FS and that
is what I have done. What am I missing here ?

Thanks
Dipankar
