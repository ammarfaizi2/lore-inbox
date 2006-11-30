Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759177AbWK3Ivz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177AbWK3Ivz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759187AbWK3Ivz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:51:55 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:35467 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1759181AbWK3Ivy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:51:54 -0500
Date: Thu, 30 Nov 2006 14:22:01 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130085201.GA23354@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061129130556.d20c726e.akpm@osdl.org> <20061130042807.GA4855@in.ibm.com> <20061130063512.GA19492@in.ibm.com> <20061130082934.GB29609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130082934.GB29609@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:29:34AM +0100, Ingo Molnar wrote:
> 
> * Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > Ok, I see that we are already doing it :(. So we can end up in a
> > deadlock.
> >
> > Here's the culprit callpath:
> 
> in general lockdep is 100% correct when it comes to "individual locks".
> The overwhelming majority of lockdep false-positives is not due to
> lockdep not getting the dependencies right, but due to the "lock class"
> not being correctly identified. That's not an issue here i think.

You're right. That's not the issue.

> 
> what lockdep does is it observes actual locking dependencies as they
> happen individually in various contexts, and then 'completes' the
> dependency graph by combining all the possible scenarios how contexts
> might preempt each other. So if lockdep sees independent dependencies
> and concludes that they are circular, there's nothing that saves us from
> the deadlock.
> 

Ah! I get it now. I had taken neither preemption nor the SMP scenario
into account before concluding that the warning might be a false
positive.

All I need to do is to run my test cases on a preemptible kernel 
or in parallel on a smp box. It'll definitely deadlock there!

> The only way for those dependencies to /never/ trigger simultaneously on
> different CPUs would be via the use of a further 'outer' exclusion
> mechanism (i.e. a lock) - but all explicit kernel-API exclusion
> mechanisms are tracked by lockdep => Q.E.D. (Open-coded exclusion might
> escape the attention of lockdep, but those are extremely rare and are
> also easily found.)

Thanks for making it clear :-)

> 
> 	Ingo

regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
