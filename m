Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWFBCfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWFBCfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWFBCfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:35:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:61494 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751146AbWFBCfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:35:22 -0400
X-IronPort-AV: i="4.05,200,1146466800"; 
   d="scan'208"; a="44684926:sNHT14947653"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'Chris Mason'" <mason@suse.com>, <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Thu, 1 Jun 2006 19:35:21 -0700
Message-ID: <000001c685ed$31cba1d0$d234030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaF6Cxi7ksx10CbQ7eJRLGZZRZ1zAAA9w3A
In-Reply-To: <200606021159.06519.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Thursday, June 01, 2006 6:59 PM
> On Friday 02 June 2006 09:57, Chen, Kenneth W wrote:
> > Chris Mason wrote on Thursday, June 01, 2006 3:56 PM
> >
> > > Hello everyone,
> > >
> > > Recent benchmarks showed some performance regressions between 2.6.16 and
> > > 2.6.5.  We tracked down one of the regressions to lock contention in
> > > schedule heavy workloads (~70,000 context switches per second)
> > >
> > > kernel/sched.c:dependent_sleeper() was responsible for most of the lock
> > > contention, hammering on the run queue locks.  The patch below is more of
> > > a discussion point than a suggested fix (although it does reduce lock
> > > contention significantly).  The dependent_sleeper code looks very
> > > expensive to me, especially for using a spinlock to bounce control
> > > between two different siblings in the same cpu.
> >
> > Yeah, this also sort of echo a recent discovery on one of our benchmarks
> > that schedule() is red hot in the kernel.  I was just scratching my head
> > not sure what's going on.  This dependent_sleeper could be the culprit
> > considering it is called almost at every context switch.  I don't think
> > we are hitting on lock contention, but by the large amount of code it
> > executes.  It really needs to be cut down ....
> 
> Thanks for the suggestion. How about something like this which takes your
> idea and further expands on it. Compiled, boot and runtime tests ok.
> 
>  /*
> + * Try to lock all the siblings of a cpu that is already locked. As we're
> + * only doing trylock the order is not important.
> + */
> +static int trylock_smt_siblings(cpumask_t sibling_map)
> +{
> +	cpumask_t locked_siblings;
> +	int i;
> +
> +	cpus_clear(locked_siblings);
> +	for_each_cpu_mask(i, sibling_map) {
> +		if (!spin_trylock(&cpu_rq(i)->lock))
> +			break;
> +		cpu_set(i, locked_siblings);
> +
> +	}
> +
> +	/* Did we lock all the siblings? */
> +	if (cpus_equal(sibling_map, locked_siblings))
> +		return 1;
> +
> +	for_each_cpu_mask(i, locked_siblings)
> +		spin_unlock(&cpu_rq(i)->lock);
> +	return 0;
> +}


I like Chris's version of trylock_smt_siblings().  Why create all that
local variables?  sibling_map is passed by value, so the whole thing is
duplicated on the stack (I think it should be pass by pointer), then
there is another locked_siblings mask declared followed by a bitmask
compare. The big iron people who set CONFIG_NR_CPUS=1024 won't be
amused because of all that bitmask copying.

Let me hack up something too, so we can compare notes etc.

- Ken
