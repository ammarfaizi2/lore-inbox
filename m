Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUCWKls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCWKls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:41:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:138 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262435AbUCWKlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:41:45 -0500
Date: Tue, 23 Mar 2004 16:11:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tiwai@suse.de, andrea@suse.de, rml@ximian.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323104103.GD3676@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <20040323022540.2c0c7154.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323022540.2c0c7154.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 02:25:40AM -0800, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> > Here is the RCU patch for low scheduling latency Andrew was talking
> > about in the other thread. I had done some measurements with
> > amlat on a 2.4 GHz P4 xeon box with 256MB memory running dbench
> > and it reduced worst case scheduling latencies from 800 microseconds
> > to about 400 microseconds.
> > 
> > It uses per-cpu kernel threads to execute excess callbacks and
> > pretty much relies on preemption.
> 
> Is simple enough.  Do you expect this will help with the route cache
> reaping problem?  I do think it's a bit hard to justify purely on the basis
> of the scheduling latency goodness.

We have two somewhat overlapping problems to solve in our hands.
Latencies impeded by long running rcu softirqs and RCU itself
impeded by long running softirqs.

In the route cache DoS case, I have been experimenting with
various throttling mechanism and I consistently see 350ms odd
grace period irrespective of whether I have long running RCU
batches in softirq or not. I checked that by batching RCUs and
putting an interval of a few ticks between batches.
This leads me to believe that the only way to avoid the route
cache DoS is to reduce softirq load given a period in time and have more 
balance in the system. I am working on some experimental code to throttle
softirqs and have some more fair use of CPU between softirqs
and process context code. To answer your question, I don't think
handing over to krcud will help, but it is definitely in my list
of things to experiment under DoS.

Anyway, I will mail out the results/experiments so far to lkml
and netdev.

Thanks
Dipankar
