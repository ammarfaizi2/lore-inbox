Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWFBC27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWFBC27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWFBC27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:28:59 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:64175 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751139AbWFBC26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:28:58 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 12:28:37 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021159.06519.kernel@kolivas.org>
In-Reply-To: <200606021159.06519.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021228.37910.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 11:59, Con Kolivas wrote:
> On Friday 02 June 2006 09:57, Chen, Kenneth W wrote:
> > Chris Mason wrote on Thursday, June 01, 2006 3:56 PM
> >
> > > Hello everyone,
> > >
> > > Recent benchmarks showed some performance regressions between 2.6.16
> > > and 2.6.5.  We tracked down one of the regressions to lock contention
> > > in schedule heavy workloads (~70,000 context switches per second)
> > >
> > > kernel/sched.c:dependent_sleeper() was responsible for most of the lock
> > > contention, hammering on the run queue locks.  The patch below is more
> > > of a discussion point than a suggested fix (although it does reduce
> > > lock contention significantly).  The dependent_sleeper code looks very
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
> ---
> It is not critical to functioning that dependent_sleeper() succeeds every
> time. We can significantly reduce the locking overhead and contention of
> dependent_sleeper by only doing trylock on the smt sibling runqueues. As
> we're only doing trylock it means we do not need to observe the normal
> locking order and we can get away without unlocking this_rq in schedule().
> This provides us with an opportunity to simplify the code further.

Actually looking even further, we only introduced the extra lookup of the next 
task when we started unlocking the runqueue in schedule(). Since we can get 
by without locking this_rq in schedule with this approach we can simplify 
dependent_sleeper even further by doing the dependent sleeper check after we 
have discovered what next is in schedule and avoid looking it up twice. I'll 
hack something up to do that soon.

-- 
-ck
