Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUGYUNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUGYUNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUGYUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:13:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33183 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264382AbUGYUM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:12:59 -0400
Subject: Re: Another dumb question about  Voluntary Kernel Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <410415E7.3090001@techsource.com>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>
	 <200407202011.20558.musical_snake@gmx.de>
	 <1090353405.28175.21.camel@mindpipe>  <40FDAF86.10104@gardena.net>
	 <1090369957.841.14.camel@mindpipe> <40FDC625.9080804@techsource.com>
	 <40FEE26D.7060904@techsource.com> <1090628706.1471.12.camel@mindpipe>
	 <410415E7.3090001@techsource.com>
Content-Type: text/plain
Message-Id: <1090786387.14951.75.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 16:13:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-25 at 16:19, Timothy Miller wrote:
> Lee Revell wrote:
> > On Wed, 2004-07-21 at 17:38, Timothy Miller wrote:
> > The vountary kernel preemption patch takes
> > sections that are non-preemptible (aka holding a spinlock) and that
> > would otherwise run for an unbounded time and adds logic to break out of
> > those loops, releasing any locks, in order to allow a higher priority
> > process to run.  It is voluntary because even though you are in a
> > non-preemptible section you voluntarily release any locks and yield to a
> > higher priority process.  It has nothing to do with the BKL as such.
> > 
>
> I'm guessing, then, that if you get preempted, then the function call to 
> voluntarily preempt returns a value which tells you whether or not you 
> got preempted, so that you know whether or not to clean up the results 
> of having your locks broken?  (ie. re-lock)
> 
> And how does the voluntary-preempt code know which locks to break?  All 
> of them?
> 

If we hit a voluntary preemption point and there is no higher priority
process ready to run, it's a NOOP, the code just continues without
breaking any locks.  If there is a runnable higher priority process,
then you have to release all spin locks to become preemptible.  This is
handled on a case-by-case basis, depending on what you have locked and
why.  When Ingo talks about points in the code being 'latency-aware'
this usually means in practice that we are iterating over some list that
could be very large, so one way to deal with it is to break out of the
loop and release the spinlock after N iterations, where N has to be
determined by benchmarking latencies.

Lee

