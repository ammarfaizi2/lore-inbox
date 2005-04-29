Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVD2VaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVD2VaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVD2V3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:29:32 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:15488 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263006AbVD2V2t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:28:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bLWwl2pggmDhLNY7JYNnWd6OBI3r0Lf6XHhyQF9c1zxLG7drR1IbLGkXT6AeMGqYDnAZL8bOQE3pLEcHo4+B6GA/2otc9vHcsXMHFVWLeQS01RUetJCF1zNd959ETZsjzN+Qa0awHR0mxwVInSNLgHyjmcL/+rdsVGNSlGqup5I=
Message-ID: <29495f1d05042914285b83beaa@mail.gmail.com>
Date: Fri, 29 Apr 2005 14:28:49 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "jdavis@accessline.com" <jdavis@accessline.com>
Subject: Re: Odd Timer behavior in 2.6 vs 2.4 (1 extra tick)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/05, jdavis@accessline.com <jdavis@accessline.com> wrote:
> 
> 
> Hello,
> 
> I've created a pretty straight forward timer using setitimer, and noticed
> some odd differences between 2.4 and 2.6, I wonder if I could get a
> clarification if this is the way it should work, or if I should continue to
> try to "fix" it.
> 
> I create a RealTime Thread( SCHED_FIFO, maxPriority-1 ) (also tried
> SCHED_RR) ...
> 
> that creates a timer ...setitimer( ITIMER_REAL, SIGALRM) with a 10 milli
> period. (I've also tried timer_create with CLOCK_REALTIME and SIGRTMIN)
> 
> and then the thread does a sem_wait() on a semaphore.
> 
> the signal handler does a sem_post() .
> 
> on 2.4.X the (idle) worst case latency is ~40 microseconds,
> on 2.6.X the (idle) latency is about the same plus 1 tick of the scheduler
> ~1000 micro seconds... Always.. Every time.
> So to work around this on 2.6 I simply subtract 1 millisecond from my timer
> as a fudge factor and everything works as expected.

There are several problems with the current soft-timer subsystem in
this area. Basically, the actual tick rate is slightly more than once
per millisecond, which requires adding one jiffy to compensate.
Additionally, one can't be sure ``where'' one is within a tick, so
another jiffy has to be added, to make sure the timer does not go off
early. sys_nanosleep() does something similar.

I will be submitting an RFC based on John Stultz's timeofday rework
which tries to resolve these issues.

Thanks,
Nish
