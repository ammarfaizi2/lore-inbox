Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWFBDEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWFBDEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWFBDEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:04:37 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:42395 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751167AbWFBDEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:04:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 13:04:14 +1000
User-Agent: KMail/1.9.1
Cc: "'Chris Mason'" <mason@suse.com>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>
References: <000001c685ed$31cba1d0$d234030a@amr.corp.intel.com>
In-Reply-To: <000001c685ed$31cba1d0$d234030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021304.14819.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 12:35, Chen, Kenneth W wrote:
> Con Kolivas wrote on Thursday, June 01, 2006 6:59 PM
>
> > On Friday 02 June 2006 09:57, Chen, Kenneth W wrote:
> > > Chris Mason wrote on Thursday, June 01, 2006 3:56 PM
> > >
> > > > Hello everyone,
> > > >
> > > > Recent benchmarks showed some performance regressions between 2.6.16
> > > > and 2.6.5.  We tracked down one of the regressions to lock contention
> > > > in schedule heavy workloads (~70,000 context switches per second)
> > > >
> > > > kernel/sched.c:dependent_sleeper() was responsible for most of the
> > > > lock contention, hammering on the run queue locks.  The patch below
> > > > is more of a discussion point than a suggested fix (although it does
> > > > reduce lock contention significantly).  The dependent_sleeper code
> > > > looks very expensive to me, especially for using a spinlock to bounce
> > > > control between two different siblings in the same cpu.
> > >
> > > Yeah, this also sort of echo a recent discovery on one of our
> > > benchmarks that schedule() is red hot in the kernel.  I was just
> > > scratching my head not sure what's going on.  This dependent_sleeper
> > > could be the culprit considering it is called almost at every context
> > > switch.  I don't think we are hitting on lock contention, but by the
> > > large amount of code it executes.  It really needs to be cut down ....
> >
> > Thanks for the suggestion. How about something like this which takes your
> > idea and further expands on it. Compiled, boot and runtime tests ok.
> >
> >  /*
> > + * Try to lock all the siblings of a cpu that is already locked. As
> > we're + * only doing trylock the order is not important.
> > + */
> > +static int trylock_smt_siblings(cpumask_t sibling_map)
> > +{
> > +	cpumask_t locked_siblings;
> > +	int i;
> > +
> > +	cpus_clear(locked_siblings);
> > +	for_each_cpu_mask(i, sibling_map) {
> > +		if (!spin_trylock(&cpu_rq(i)->lock))
> > +			break;
> > +		cpu_set(i, locked_siblings);
> > +
> > +	}
> > +
> > +	/* Did we lock all the siblings? */
> > +	if (cpus_equal(sibling_map, locked_siblings))
> > +		return 1;
> > +
> > +	for_each_cpu_mask(i, locked_siblings)
> > +		spin_unlock(&cpu_rq(i)->lock);
> > +	return 0;
> > +}
>
> I like Chris's version of trylock_smt_siblings().  Why create all that
> local variables?

Because cpumasks are so pretty.

> sibling_map is passed by value, so the whole thing is 
> duplicated on the stack (I think it should be pass by pointer), then
> there is another locked_siblings mask declared followed by a bitmask
> compare. The big iron people who set CONFIG_NR_CPUS=1024 won't be
> amused because of all that bitmask copying.

Good point.
>
> Let me hack up something too, so we can compare notes etc.

Sure, you have the hack lock. Actually we can just trylock and if it fails 
remove it from the sibling_map and go to out_unlock without a separate 
trylock_smt_cpus function entirely...

-- 
-ck
