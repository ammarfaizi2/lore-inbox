Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWFBXEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWFBXEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWFBXEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:04:13 -0400
Received: from mga03.intel.com ([143.182.124.21]:48930 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030343AbWFBXEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:04:12 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45298104:sNHT3620118103"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 15:58:12 -0700
Message-ID: <000501c68698$06378290$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGlFfogpDu5pDaTxCovYBylQ+zaAAAViJw
In-Reply-To: <200606030831.41117.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 3:32 PM
> > > > But you keep on missing the point that this only happens in the initial
> > > > stage of tasks competing for CPU resources.
> > > >
> > > > If this is broken, then current smt nice is equally broken with the
> > > > same reasoning: once the low priority task gets scheduled, there is
> > > > nothing to kick it off the CPU until its entire time slice get used up.
> > > >  They compete equally with a high priority task running on the sibling
> > > > CPU.
> > >
> > > There has to be some way of metering it out and in the absence of cpu
> > > based hardware priority support (like ppc64 has) the only useful thing we
> > > have to work with is timeslice. Yes sometimes the high priority task is
> > > at the start and sometimes at the end of the timeslice but overall it
> > > balances the proportions out reasonably fairly.
> >
> > Good!  Then why special case the initial stage?  Just let task run and it
> > will even out statistically.  Everyone is happy, less code, less special
> > case, same end result.
> 
> Hang on I think I missed something there. What did you conclude I conceded 
> there? When I say "work with timeslice" I mean use percentage of timeslice 
> the way smt nice currently does.


You haven't answered my question either.  What is the benefit of special
casing the initial stage of cpu resource competition?  Is it quantitatively
measurable?  If so, how much and with what workload?

Also there are oddness in the way that the sleep decision is made: 75% of
resched decision is to sleep, while 25% of the time is to run, but there
are fussiness in there and all depends on when the resched and time slice
expires.  Considering a scenario when resched occurs on jiffies%100 = 10,
and low priority task time slice of 100 jiffies, the current code always
decide to run the low priority task!

 if (rt_task(smt_curr)) {
    /*
     * With real time tasks we run non-rt tasks only
     * per_cpu_gain% of the time.
     */
    if ((jiffies % DEF_TIMESLICE) >
       (sd->per_cpu_gain * DEF_TIMESLICE / 100))
             ret = 1;


The whole point is: precise fairness can not be (or difficult to) control
at milli-second range.  It all will work out statistically in a long run.
Which again brings back the question: what does the special casing in
precision control will bring to the overall scheme?  So far, I have not
seen any quantitative measure at all that indicates it is a win.

- Ken


